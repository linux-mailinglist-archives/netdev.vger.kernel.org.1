Return-Path: <netdev+bounces-20661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5024E7606A1
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 05:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C47C28172F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 03:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672746A8;
	Tue, 25 Jul 2023 03:28:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FE524C
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:28:17 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBDD91720
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 20:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=+2gU6ooukOhhYGiJKR
	TlkEEgYjWqLV/qmeDnMXcx59Y=; b=CHMwP08yGb1VrkObGXlYpzIvTztcD+K5+z
	Y5tR/vjI0i+7OMnlt5yLIB0GIA9MCsIiGX2n5Za0kQlUHmSrthJC9jDADhEJYrLT
	WvW3E+omQKZvY6dwrmeTRL9PngWvGT2s3ZVNSPyTy5sxoXYcRwLk16ThpTGYo4Td
	upMZwTMv4=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3GLgjQb9kXV4RBQ--.44576S4;
	Tue, 25 Jul 2023 11:27:41 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: kuniyu@amazon.com
Cc: ajit.khaparde@broadcom.com,
	netdev@vger.kernel.org,
	ruc_gongyuanjun@163.com,
	somnath.kotur@broadcom.com,
	sriharsha.basavapatna@broadcom.com
Subject: [PATCH net v2 1/1] benet: fix return value check in be_lancer_xmit_workarounds()
Date: Tue, 25 Jul 2023 11:27:26 +0800
Message-Id: <20230725032726.15002-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717193259.98375-1-kuniyu@amazon.com>
References: <20230717193259.98375-1-kuniyu@amazon.com>
X-CM-TRANSID:_____wD3GLgjQb9kXV4RBQ--.44576S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1UAr4rGF1xtFyxtF1xuFg_yoWkArbEk3
	40vr4xKa98Jr9Fkw4jyrW5Zr9I9FWDXas7uayIgrW5Jw13ZF1akw1vkrnrZr4UW3W7JF9r
	G3ZIvFW0k3yUKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNF4iUUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiUQ235WDESaN-vgABsA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

in be_lancer_xmit_workarounds(), it should go to label 'tx_drop'
if an unexpected value is returned by pskb_trim().

Fixes: 93040ae5cc8d ("be2net: Fix to trim skb for padded vlan packets to workaround an ASIC Bug")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 18c2fc880d09..0616b5fe241c 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1138,7 +1138,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	    (lancer_chip(adapter) || BE3_chip(adapter) ||
 	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
 		ip = (struct iphdr *)ip_hdr(skb);
-		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
+		if (unlikely(pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len))))
+			goto tx_drop;
 	}
 
 	/* If vlan tag is already inlined in the packet, skip HW VLAN
-- 
2.17.1


