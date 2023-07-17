Return-Path: <netdev+bounces-18328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD90C756707
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E57281300
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A501253C7;
	Mon, 17 Jul 2023 15:01:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D29253C4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 15:01:15 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06B7E10D8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=kG6cFHki0NPqe2b3Az
	Tgrm7u/qMp/3blu3q4rUF0FCI=; b=ksybK/lgWcaFjwmnUbSs3RBZsC+6EIAIP1
	2aBVG9chIo76g1h690GgkHEk6l67SDfpUHZuiinNnH+TYmgeKrBbF881w6lYdKTS
	axlpVEf9YqnaEULAw6eSflNOfvCRyO5LKG0o3AaLdlCttmvEs35E3bkpCx8G5zuX
	D96JewGlQ=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g4-3 (Coremail) with SMTP id _____wA3L+cOVLVkZORDAg--.8812S4;
	Mon, 17 Jul 2023 22:45:39 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] drivers:net: fix return value check in be_lancer_xmit_workarounds
Date: Mon, 17 Jul 2023 22:45:32 +0800
Message-Id: <20230717144532.22037-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wA3L+cOVLVkZORDAg--.8812S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrW3KF1fJFy5uF4rAw17trb_yoWDAFgEk3
	4Iqr4xKa98tr9Fkw4jyrW5Zr9I9FWkXa93uayIgrW5J3ZrZ3WFkw1vyrnrXr4UGw17JF9r
	GFnIvFWIk3yUKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNdgAUUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBiBav5VaEFzdO7AAAsE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

in be_lancer_xmit_workarounds, it should go to label 'err' if
an unexpected value is returned by pskb_trim.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 18c2fc880d09..eba29a2e0e8b 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1138,7 +1138,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	    (lancer_chip(adapter) || BE3_chip(adapter) ||
 	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
 		ip = (struct iphdr *)ip_hdr(skb);
-		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
+		if (unlikely(pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len))))
+			goto err;
 	}
 
 	/* If vlan tag is already inlined in the packet, skip HW VLAN
-- 
2.17.1


