Return-Path: <netdev+bounces-27826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BB377D613
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 00:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51E11C20E0A
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 22:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A31AA75;
	Tue, 15 Aug 2023 22:30:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB011F19F
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 22:30:42 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510DA1BFF;
	Tue, 15 Aug 2023 15:30:41 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qW2Yg-0004be-Vk; Wed, 16 Aug 2023 00:30:39 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Xin Long <lucien.xin@gmail.com>,
	Paolo Valerio <pvalerio@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 5/9] netfilter: set default timeout to 3 secs for sctp shutdown send and recv state
Date: Wed, 16 Aug 2023 00:29:55 +0200
Message-ID: <20230815223011.7019-6-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815223011.7019-1-fw@strlen.de>
References: <20230815223011.7019-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xin Long <lucien.xin@gmail.com>

In SCTP protocol, it is using the same timer (T2 timer) for SHUTDOWN and
SHUTDOWN_ACK retransmission. However in sctp conntrack the default timeout
value for SCTP_CONNTRACK_SHUTDOWN_ACK_SENT state is 3 secs while it's 300
msecs for SCTP_CONNTRACK_SHUTDOWN_SEND/RECV state.

As Paolo Valerio noticed, this might cause unwanted expiration of the ct
entry. In my test, with 1s tc netem delay set on the NAT path, after the
SHUTDOWN is sent, the sctp ct entry enters SCTP_CONNTRACK_SHUTDOWN_SEND
state. However, due to 300ms (too short) delay, when the SHUTDOWN_ACK is
sent back from the peer, the sctp ct entry has expired and been deleted,
and then the SHUTDOWN_ACK has to be dropped.

Also, it is confusing these two sysctl options always show 0 due to all
timeout values using sec as unit:

  net.netfilter.nf_conntrack_sctp_timeout_shutdown_recd = 0
  net.netfilter.nf_conntrack_sctp_timeout_shutdown_sent = 0

This patch fixes it by also using 3 secs for sctp shutdown send and recv
state in sctp conntrack, which is also RTO.initial value in SCTP protocol.

Note that the very short time value for SCTP_CONNTRACK_SHUTDOWN_SEND/RECV
was probably used for a rare scenario where SHUTDOWN is sent on 1st path
but SHUTDOWN_ACK is replied on 2nd path, then a new connection started
immediately on 1st path. So this patch also moves from SHUTDOWN_SEND/RECV
to CLOSE when receiving INIT in the ORIGINAL direction.

Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
Reported-by: Paolo Valerio <pvalerio@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Documentation/networking/nf_conntrack-sysctl.rst | 4 ++--
 net/netfilter/nf_conntrack_proto_sctp.c          | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/nf_conntrack-sysctl.rst b/Documentation/networking/nf_conntrack-sysctl.rst
index 8b1045c3b59e..c383a394c665 100644
--- a/Documentation/networking/nf_conntrack-sysctl.rst
+++ b/Documentation/networking/nf_conntrack-sysctl.rst
@@ -178,10 +178,10 @@ nf_conntrack_sctp_timeout_established - INTEGER (seconds)
 	Default is set to (hb_interval * path_max_retrans + rto_max)
 
 nf_conntrack_sctp_timeout_shutdown_sent - INTEGER (seconds)
-	default 0.3
+	default 3
 
 nf_conntrack_sctp_timeout_shutdown_recd - INTEGER (seconds)
-	default 0.3
+	default 3
 
 nf_conntrack_sctp_timeout_shutdown_ack_sent - INTEGER (seconds)
 	default 3
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 91eacc9b0b98..b6bcc8f2f46b 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -49,8 +49,8 @@ static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
 	[SCTP_CONNTRACK_COOKIE_WAIT]		= 3 SECS,
 	[SCTP_CONNTRACK_COOKIE_ECHOED]		= 3 SECS,
 	[SCTP_CONNTRACK_ESTABLISHED]		= 210 SECS,
-	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= 300 SECS / 1000,
-	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= 300 SECS / 1000,
+	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= 3 SECS,
+	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= 3 SECS,
 	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	= 3 SECS,
 	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= 30 SECS,
 };
@@ -105,7 +105,7 @@ static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK_MAX] = {
 	{
 /*	ORIGINAL	*/
 /*                  sNO, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS */
-/* init         */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCW},
+/* init         */ {sCL, sCL, sCW, sCE, sES, sCL, sCL, sSA, sCW},
 /* init_ack     */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL},
 /* abort        */ {sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL},
 /* shutdown     */ {sCL, sCL, sCW, sCE, sSS, sSS, sSR, sSA, sCL},
-- 
2.41.0


