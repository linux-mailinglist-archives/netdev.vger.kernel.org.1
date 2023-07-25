Return-Path: <netdev+bounces-20697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BB760B18
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8249828173C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D828F61;
	Tue, 25 Jul 2023 07:03:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721301C37
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:03:54 +0000 (UTC)
X-Greylist: delayed 906 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jul 2023 00:03:52 PDT
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DED8B6
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=/9ek3CbTv6+eptiMON
	LXb1+/gsh99hp+MsSzOHCuOMg=; b=BXGScCCBhuww3DkuTelMbJwtzPrrakcD9f
	/PPc7GiC5iTRwvCKISq6SkKDSqLfkNMbO7GK22keeg+ez5YLQv7Cnf8UJmx7k9ZB
	2v4PHTPv4nPcRptB9hbbsLw6m653kswSETB2pykCqruYoCHrRxisi0U9dr/fXMKP
	nCl0m7ZqM=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wB30ogscL9k_u8jBQ--.1163S4;
	Tue, 25 Jul 2023 14:48:22 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: kuniyu@amazon.com
Cc: jmaloy@redhat.com,
	netdev@vger.kernel.org,
	ruc_gongyuanjun@163.com,
	ying.xue@windriver.com
Subject: [PATCH v2 1/1] tipc: check return value of pskb_trim()
Date: Tue, 25 Jul 2023 14:48:10 +0800
Message-Id: <20230725064810.5820-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717185710.93256-1-kuniyu@amazon.com>
References: <20230717185710.93256-1-kuniyu@amazon.com>
X-CM-TRANSID:_____wB30ogscL9k_u8jBQ--.1163S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxuryftw47tF13Xw4fZrb_yoWfXrX_ur
	W0gw1kWw47Gwn5ur48Aw4qqryFga18CFyku3yIyFWDua4DJF4DZF4v9rnxAa45uF47W3Zr
	Wws0yFy2gw4fujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN6pBDUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiJxe35V5vE54zAQAAss
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

goto free_skb if an unexpected result is returned by pskb_tirm()
in tipc_crypto_rcv_complete().

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 net/tipc/crypto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 577fa5af33ec..302fd749c424 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1960,7 +1960,8 @@ static void tipc_crypto_rcv_complete(struct net *net, struct tipc_aead *aead,
 
 	skb_reset_network_header(*skb);
 	skb_pull(*skb, tipc_ehdr_size(ehdr));
-	pskb_trim(*skb, (*skb)->len - aead->authsize);
+	if (pskb_trim(*skb, (*skb)->len - aead->authsize))
+		goto free_skb;
 
 	/* Validate TIPCv2 message */
 	if (unlikely(!tipc_msg_validate(skb))) {
-- 
2.17.1


