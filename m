Return-Path: <netdev+bounces-131888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87AF98FE05
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD9F281D4B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 07:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03713AD2A;
	Fri,  4 Oct 2024 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XUQoXhFH"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B47F7CA;
	Fri,  4 Oct 2024 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028059; cv=none; b=ZfJLmkPE06qmaHAn7TomoppMHme/9l2/dP8qF9Inf60QbKX6i7gfb6OW1tzs9p8LHHMBGSwJTWOZdvmGr3bXx8NIiqfl9zsyNAYG1bf5mD2N+twAsFcNpfWIzJ+UuLGhoq82IZcoHMNoSOh0/aH0kRThTnKli6LwGMG2bUxxbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028059; c=relaxed/simple;
	bh=dIAxm1szg0eXxoUrHaRJyEkFiqNB1EbdiqdWK0Q3L7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTrd4bXa8xyGQjI4wyDKGDlRXdIYyD8r56rJJ9QX3p2U81eLGWHr9BZn2Id//O6bElEZojhVM7/pqHN1hrpgaGCCOy2DYjLamI/c42I7oKfRo/SLZDZGE9EmozBn7AvZJg16ggnVYKlSD1C+sOlclU7S1ibl9DNC+zaGif+08pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XUQoXhFH; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4947lKHV094502;
	Fri, 4 Oct 2024 02:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728028040;
	bh=7pYI8kQhzLjk8qhIVY25r6ky5/FBxidxa1N2CUq2AxI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XUQoXhFHQ8yijQdyE3dYiGKa1FU0SCVaQ4uKL36oTvmKbb+/xkPLDkOUL6GG0raee
	 oPJ/LpEi5USRkZBFnHlsoCWCQY+4veo4c+4q7JnBNHtsc69yjxW77d0B9evyad+VFr
	 Y/HPwSn3wJxAGjQs33gTIzTdavuDEnWrWYQiLEKo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4947lKrr035325
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Oct 2024 02:47:20 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 02:47:19 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 02:47:19 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4947lJh5031571;
	Fri, 4 Oct 2024 02:47:19 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4947lIDQ025138;
	Fri, 4 Oct 2024 02:47:19 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <jiri@resnulli.us>, <aleksander.lobakin@intel.com>, <lukma@denx.de>,
        <horms@kernel.org>, <robh@kernel.org>, <jan.kiszka@siemens.com>,
        <dan.carpenter@linaro.org>, <diogo.ivo@siemens.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next 1/3] net: hsr: Add VLAN support
Date: Fri, 4 Oct 2024 13:17:13 +0530
Message-ID: <20241004074715.791191-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004074715.791191-1-danishanwar@ti.com>
References: <20241004074715.791191-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: WingMan Kwok <w-kwok2@ti.com>

Add support for creating VLAN interfaces over HSR/PRP interface.

Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 net/hsr/hsr_device.c  |  5 -----
 net/hsr/hsr_forward.c | 19 ++++++++++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index ebdfd5b64e17..0ca47ebb01d3 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -572,11 +572,6 @@ void hsr_dev_setup(struct net_device *dev)
 			   NETIF_F_HW_VLAN_CTAG_TX;
 
 	dev->features = dev->hw_features;
-
-	/* VLAN on top of HSR needs testing and probably some work on
-	 * hsr_header_create() etc.
-	 */
-	dev->features |= NETIF_F_VLAN_CHALLENGED;
 }
 
 /* Return true if dev is a HSR master; return false otherwise.
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index b38060246e62..aa6acebc7c1e 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -280,6 +280,7 @@ static struct sk_buff *hsr_fill_tag(struct sk_buff *skb,
 				    struct hsr_port *port, u8 proto_version)
 {
 	struct hsr_ethhdr *hsr_ethhdr;
+	unsigned char *pc;
 	int lsdu_size;
 
 	/* pad to minimum packet size which is 60 + 6 (HSR tag) */
@@ -290,7 +291,18 @@ static struct sk_buff *hsr_fill_tag(struct sk_buff *skb,
 	if (frame->is_vlan)
 		lsdu_size -= 4;
 
-	hsr_ethhdr = (struct hsr_ethhdr *)skb_mac_header(skb);
+	pc = skb_mac_header(skb);
+	if (frame->is_vlan)
+		/* This 4-byte shift (size of a vlan tag) does not
+		 * mean that the ethhdr starts there. But rather it
+		 * provides the proper environment for accessing
+		 * the fields, such as hsr_tag etc., just like
+		 * when the vlan tag is not there. This is because
+		 * the hsr tag is after the vlan tag.
+		 */
+		hsr_ethhdr = (struct hsr_ethhdr *)(pc + VLAN_HLEN);
+	else
+		hsr_ethhdr = (struct hsr_ethhdr *)pc;
 
 	hsr_set_path_id(hsr_ethhdr, port);
 	set_hsr_tag_LSDU_size(&hsr_ethhdr->hsr_tag, lsdu_size);
@@ -368,7 +380,7 @@ struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
 		return skb_clone(frame->skb_std, GFP_ATOMIC);
 	}
 
-	skb = skb_copy_expand(frame->skb_std, 0,
+	skb = skb_copy_expand(frame->skb_std, skb_headroom(frame->skb_std),
 			      skb_tailroom(frame->skb_std) + HSR_HLEN,
 			      GFP_ATOMIC);
 	return prp_fill_rct(skb, frame, port);
@@ -690,9 +702,6 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 	if (frame->is_vlan) {
 		vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
 		proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
-		/* FIXME: */
-		netdev_warn_once(skb->dev, "VLAN not yet supported");
-		return -EINVAL;
 	}
 
 	frame->is_from_san = false;
-- 
2.34.1


