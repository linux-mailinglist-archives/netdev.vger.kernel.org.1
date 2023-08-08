Return-Path: <netdev+bounces-25398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE2773DB9
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03D61C20835
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FA314292;
	Tue,  8 Aug 2023 16:21:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF611427B
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:21:49 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA1AB0A16;
	Tue,  8 Aug 2023 09:21:34 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qTM2b-0000M0-Dy; Tue, 08 Aug 2023 14:42:25 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH next-next 5/5] netfilter: nfnetlink_log: always add a timestamp
Date: Tue,  8 Aug 2023 14:41:48 +0200
Message-ID: <20230808124159.19046-6-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808124159.19046-1-fw@strlen.de>
References: <20230808124159.19046-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Maciej Żenczykowski <maze@google.com>

Compared to all the other work we're already doing to deliver
an skb to userspace this is very cheap - at worse an extra
call to ktime_get_real() - and very useful.

(and indeed it may even be cheaper if we're running from other hooks)

(background: Android occasionally logs packets which
caused wake from sleep/suspend and we'd like to have
timestamps reliably associated with these events)

Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nfnetlink_log.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index e57eb168ee13..53c9e76473ba 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -470,7 +470,6 @@ __build_packet_message(struct nfnl_log_net *log,
 	sk_buff_data_t old_tail = inst->skb->tail;
 	struct sock *sk;
 	const unsigned char *hwhdrp;
-	ktime_t tstamp;
 
 	nlh = nfnl_msg_put(inst->skb, 0, 0,
 			   nfnl_msg_type(NFNL_SUBSYS_ULOG, NFULNL_MSG_PACKET),
@@ -599,10 +598,9 @@ __build_packet_message(struct nfnl_log_net *log,
 			goto nla_put_failure;
 	}
 
-	tstamp = skb_tstamp_cond(skb, false);
-	if (hooknum <= NF_INET_FORWARD && tstamp) {
+	if (hooknum <= NF_INET_FORWARD) {
+		struct timespec64 kts = ktime_to_timespec64(skb_tstamp_cond(skb, true));
 		struct nfulnl_msg_packet_timestamp ts;
-		struct timespec64 kts = ktime_to_timespec64(tstamp);
 		ts.sec = cpu_to_be64(kts.tv_sec);
 		ts.usec = cpu_to_be64(kts.tv_nsec / NSEC_PER_USEC);
 
-- 
2.41.0


