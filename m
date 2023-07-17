Return-Path: <netdev+bounces-18326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4B37566D2
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130832813F6
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58617253CA;
	Mon, 17 Jul 2023 14:51:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92B253BB
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:51:03 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D965B2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=Jy3ZiZtqQdwy+l4bnE
	M5Hd8reUGe43hZFmNw0iE2Hrw=; b=lhr81nlrUXvdks49TqOfJZ1v8muWV2cyaA
	4ZZjM62ndvGYyOYjsFpL1V1kWaX4S9ogsP2M4q8YjlisTvMPV1+kdy+z9NgauQ/A
	VzohuAmMjUcLMI3XXNAlB2tIMqEJyqX7Xoc7x/DPplG0LqHuDXym0l3zUlJjGnRy
	VTVFRYCjA=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wBHIrBKVbVkPFg1Ag--.37240S4;
	Mon, 17 Jul 2023 22:50:53 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] net:tipc: check return value of pskb_trim()
Date: Mon, 17 Jul 2023 22:50:49 +0800
Message-Id: <20230717145049.27642-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wBHIrBKVbVkPFg1Ag--.37240S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxurWxCw4ftr1xuFW5trb_yoWDtFX_uF
	yFgr18Ww4UGwn5ur4UZanFqr95Ww4kuFWkC3ySyFWUWa4DJa1kZFZ5urnxC348uFsrW3Zx
	Gws8GF1jgwnrujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMZ2aPUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBSRKv5VaEH4VL4gAAsw
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

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 net/tipc/crypto.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 577fa5af33ec..1b86cea261a5 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1894,6 +1894,7 @@ static void tipc_crypto_rcv_complete(struct net *net, struct tipc_aead *aead,
 	struct tipc_aead *tmp = NULL;
 	struct tipc_ehdr *ehdr;
 	struct tipc_node *n;
+	int ret;
 
 	/* Is this completed by TX? */
 	if (unlikely(is_tx(aead->crypto))) {
@@ -1960,7 +1961,9 @@ static void tipc_crypto_rcv_complete(struct net *net, struct tipc_aead *aead,
 
 	skb_reset_network_header(*skb);
 	skb_pull(*skb, tipc_ehdr_size(ehdr));
-	pskb_trim(*skb, (*skb)->len - aead->authsize);
+	ret = pskb_trim(*skb, (*skb)->len - aead->authsize);
+	if (ret)
+		goto free_skb;
 
 	/* Validate TIPCv2 message */
 	if (unlikely(!tipc_msg_validate(skb))) {
-- 
2.17.1


