Return-Path: <netdev+bounces-45815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A38D7DFBDF
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 22:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E571C20F86
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 21:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71DF21342;
	Thu,  2 Nov 2023 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BdElndTn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6771DFE1
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 21:06:15 +0000 (UTC)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B440618B
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 14:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698959174; x=1730495174;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zvwvlV+sA5osxlHlrmp3E9fvyALtI8rtCvoCU76Wt2w=;
  b=BdElndTnsoZIS0/JOTw0Ln2Cb47ZJJiJiQXF4PEXWPrD841UfzpCiIMm
   qVhPDfAIdb4pufYaEMfqeL5Dq3dJx5A9e4KVqdnHG2eoHX0E4oC9Mhhff
   hAyEtL1KeHMecenvr9vpaoaqdjfJ0QCkWw4ATD6X/4f1qDjUi7DO+5FTy
   Q=;
X-IronPort-AV: E=Sophos;i="6.03,272,1694736000"; 
   d="scan'208";a="368083683"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 21:06:11 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com (Postfix) with ESMTPS id 9763940D8B;
	Thu,  2 Nov 2023 21:06:08 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:47861]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.184:2525] with esmtp (Farcaster)
 id fd71204f-7661-4ba2-b418-134e5e585282; Thu, 2 Nov 2023 21:06:08 +0000 (UTC)
X-Farcaster-Flow-ID: fd71204f-7661-4ba2-b418-134e5e585282
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 2 Nov 2023 21:06:07 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 2 Nov 2023 21:06:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Salam Noureddine <noureddine@arista.com>, Dmitry Safonov
	<0x7f454c46@gmail.com>, Francesco Ruggeri <fruggeri@arista.com>, "Kuniyuki
 Iwashima" <kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net] tcp: Fix SYN option room calculation for TCP-AO.
Date: Thu, 2 Nov 2023 14:05:48 -0700
Message-ID: <20231102210548.94361-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.38]
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

When building SYN packet in tcp_syn_options(), MSS, TS, WS, and
SACKPERM are used without checking the remaining bytes in the
options area.

To keep that logic as is, we limit the TCP-AO MAC length in
tcp_ao_parse_crypto().  Currently, the limit is calculated as below.

  MAX_TCP_OPTION_SPACE - TCPOLEN_TSTAMP_ALIGNED
                       - TCPOLEN_WSCALE_ALIGNED
                       - TCPOLEN_SACKPERM_ALIGNED

This looks confusing as (1) we pack SACKPERM into the leading
2-bytes of the aligned 12-bytes of TS and (2) TCPOLEN_MSS_ALIGNED
is not used.  Fortunately, the calculated limit is not wrong as
TCPOLEN_SACKPERM_ALIGNED and TCPOLEN_MSS_ALIGNED are the same value.

However, we should use the proper constant in the formula.

  MAX_TCP_OPTION_SPACE - TCPOLEN_MSS_ALIGNED
                       - TCPOLEN_TSTAMP_ALIGNED
                       - TCPOLEN_WSCALE_ALIGNED

Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ao.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index ef5472ed6158..7696417d0640 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1315,7 +1315,8 @@ static int tcp_ao_parse_crypto(struct tcp_ao_add *cmd, struct tcp_ao_key *key)
 	key->maclen = cmd->maclen ?: 12; /* 12 is the default in RFC5925 */
 
 	/* Check: maclen + tcp-ao header <= (MAX_TCP_OPTION_SPACE - mss
-	 *					- tstamp - wscale - sackperm),
+	 *					- tstamp (including sackperm)
+	 *					- wscale),
 	 * see tcp_syn_options(), tcp_synack_options(), commit 33ad798c924b.
 	 *
 	 * In order to allow D-SACK with TCP-AO, the header size should be:
@@ -1342,9 +1343,9 @@ static int tcp_ao_parse_crypto(struct tcp_ao_add *cmd, struct tcp_ao_key *key)
 	 * large to leave sufficient option space.
 	 */
 	syn_tcp_option_space = MAX_TCP_OPTION_SPACE;
+	syn_tcp_option_space -= TCPOLEN_MSS_ALIGNED;
 	syn_tcp_option_space -= TCPOLEN_TSTAMP_ALIGNED;
 	syn_tcp_option_space -= TCPOLEN_WSCALE_ALIGNED;
-	syn_tcp_option_space -= TCPOLEN_SACKPERM_ALIGNED;
 	if (tcp_ao_len(key) > syn_tcp_option_space) {
 		err = -EMSGSIZE;
 		goto err_kfree;
-- 
2.30.2


