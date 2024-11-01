Return-Path: <netdev+bounces-140926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5C59B8A49
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 05:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561682824AA
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 04:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D4147C9B;
	Fri,  1 Nov 2024 04:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="OWhYry3a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nXAd6zox"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1D322B;
	Fri,  1 Nov 2024 04:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730437154; cv=none; b=QRbuRWqfTr/FkfwLCned7wrEXQBkVrc2P07dAfiPPTok2F+azsK+krISu5pvdxvv5U0O0vdNiMsN0fKWUrXoAtBKUSo1sbl9ikHxTYlzhB5z5UFhO6493i4WSw1QbgllvLC+ol5msFxehMvIfSNq/fOZ4dG0ErLOXdikJ+sjPaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730437154; c=relaxed/simple;
	bh=t2sfTpM5WPgCUaI+PxFBg3ngx12mwdycHLvzxpb70eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OsDgundIxwppX3aR5irrC4NgXGoO8EJcgKy1hNAIOXzBlxVPuTH6RJTPTvWs5EgVsVLDWvzafAKs/MoBbqg0DGssdBDVqtqvxAPeSLxfbEufVa+HXSlwNPIAZJGtW3D5HzmDOa1PcjbL++wU3i4zYTn9pQSkKdkSDgi7obys4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=OWhYry3a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nXAd6zox; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FFE8138012C;
	Fri,  1 Nov 2024 00:59:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 01 Nov 2024 00:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1730437150; x=1730523550; bh=JJ9+M/HGlO5YKjsRaH9qT
	g7jRa5jm5uIC1oaNkJ8ijs=; b=OWhYry3a4nXL7seqHkZEdAmV/IINkKaq4r/i2
	8ivssk1ws7lb/rsqgaClf2SrWno99EqwgcyB9z7QHhlKI7qktrBWSHssnIEAqDje
	cXQS+h/Srs8FceTRXNBaPevjq1WItkf+XyJt78knGPRRguFDUMqtgVrY3IMxvhNE
	cEx6T8dJ82AnCFpKRsD63CS3j0pt6GeEt1L//uYC3EVB/414L+7X0Ei6SWyNhWBg
	+Mw1pRALiOq2o/Yd49ZXvke2CxpxYc9RWuKs5+W+0tWtLHAAaSg3uTEJ93DW971w
	EoJu90c5HWDhBKbfqz6cLpix7V5kdGgugMVTzI1EtuRzOik7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730437150; x=1730523550; bh=JJ9+M/HGlO5YKjsRaH9qTg7jRa5jm5uIC1o
	aNkJ8ijs=; b=nXAd6zox5lWNcWWYLI118/rMtVyPijWT6/6Ke0Cs+6cgSUcx+up
	Zq5TFrQrOl0xBYiJHOFj8N5GKlCxGiztN9okRvJcz9kcxKJRAEgH0DU8qgKRt86S
	wpxQPYWdRy6VG6GTUqwxfQTo4fgUELYrxnNdpZhXcxWNtjcgJATm76oOVNObQEJv
	uJJwBEw+T6XVRLDAG3ny8Wdg1AqqJhtKGIhmpbM0RTrgK3AAXcTGszfUEKlK1zw9
	t2g8zKR+u/PtZY7RQZdo2T8voIWJkJ492FVvXGwGH75F4C8vc/Urk8Z3D30uSVVc
	Dd6GG/2p5ZIIKR8JERHtYhBD2ltG8mWYh2Q==
X-ME-Sender: <xms:HGAkZ4DPCXiFVV9fgTZTgeCpGWkO4ettS8HIGYAd4EryX9nUjTjVzw>
    <xme:HGAkZ6h1kH50xh1lq6UR0-QUYYmMs_5-D2dNA2-EKPnMlKztrHsmqZRGqdrcGLcqG
    f1Gl2Asts2LffCKvw>
X-ME-Received: <xmr:HGAkZ7lgd8vv6aLs_kaKkdI5BrIBXZQj6hbSLm2ObtB8R7IF6As9lpqSLZDXO1rbC3ezXJs-xnF1vtJiuFf4380iX8zBgUUMWq8wbWTNJcXxuUq1Q6Ur>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvd
    eggfetgfelhefhueefkeduvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhhitg
    hhrggvlhdrtghhrghnsegsrhhorggutghomhdrtghomhdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvh
    eslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvhhikhgrshdrghhuphhtrgessghrohgruggtohhmrdgtohhmpdhrtghpthhtoh
    eprghnughrvgifrdhgohhsphhouggrrhgvkhessghrohgruggtohhmrdgtohhmpdhrtghp
    thhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehprghvrghnrd
    gthhgvsggsihessghrohgruggtohhmrdgtohhm
X-ME-Proxy: <xmx:HGAkZ-zQKcBrQZrXkZFm6vdCHRuOgZAorWniWUl7UopJGDbpIedslQ>
    <xmx:HGAkZ9TAVeEJ9bHzIYlw7Z9MbO8k3epXscOvEezTqMJ2brfvVbv_NA>
    <xmx:HGAkZ5YuGBnoE_VkDrp6dL9CRUHMn-ezQ1Hp7CgPWY4775F4xKzavw>
    <xmx:HGAkZ2QrDOJg_2ol0LsdztEj4UbFuGnk3sPPiOHuuDs6Nz5t-5QDKA>
    <xmx:HmAkZzD2O20rt48UzA2d1b3tDYqp25J5iNGhWZl0LYus7G7s8TWwq999>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 00:59:07 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: davem@davemloft.net,
	michael.chan@broadcom.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	vikas.gupta@broadcom.com,
	andrew.gospodarek@broadcom.com,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	martin.lau@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH net] bnxt_en: ethtool: Fix ip[6] ntuple rule verification
Date: Thu, 31 Oct 2024 22:58:30 -0600
Message-ID: <219859e674ef7a9d8af9ab4f64a9095580f04bcc.1730436983.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, trying to insert an ip or ip6 only rule would get rejected
with -EOPNOTSUPP. For example, the following would fail:

    ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1

The reason was that all the l4proto validation was being run despite the
l4proto mask being set to 0x0.  Fix by only running l4proto validation
when mask is set.

Fixes: 9ba0e56199e3 ("bnxt_en: Enhance ethtool ntuple support for ip flows besides TCP/UDP")
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index f71cc8188b4e..1c97ee406bd7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1289,10 +1289,13 @@ static int bnxt_add_l2_cls_rule(struct bnxt *bp,
 static bool bnxt_verify_ntuple_ip4_flow(struct ethtool_usrip4_spec *ip_spec,
 					struct ethtool_usrip4_spec *ip_mask)
 {
+	u8 mproto = ip_mask->proto;
+	u8 sproto = ip_spec->proto;
+
 	if (ip_mask->l4_4_bytes || ip_mask->tos ||
 	    ip_spec->ip_ver != ETH_RX_NFC_IP4 ||
-	    ip_mask->proto != BNXT_IP_PROTO_FULL_MASK ||
-	    (ip_spec->proto != IPPROTO_RAW && ip_spec->proto != IPPROTO_ICMP))
+	    (mproto && mproto != BNXT_IP_PROTO_FULL_MASK) ||
+	    (mproto && sproto != IPPROTO_RAW && sproto != IPPROTO_ICMP))
 		return false;
 	return true;
 }
@@ -1300,10 +1303,12 @@ static bool bnxt_verify_ntuple_ip4_flow(struct ethtool_usrip4_spec *ip_spec,
 static bool bnxt_verify_ntuple_ip6_flow(struct ethtool_usrip6_spec *ip_spec,
 					struct ethtool_usrip6_spec *ip_mask)
 {
+	u8 mproto = ip_mask->l4_proto;
+	u8 sproto = ip_spec->l4_proto;
+
 	if (ip_mask->l4_4_bytes || ip_mask->tclass ||
-	    ip_mask->l4_proto != BNXT_IP_PROTO_FULL_MASK ||
-	    (ip_spec->l4_proto != IPPROTO_RAW &&
-	     ip_spec->l4_proto != IPPROTO_ICMPV6))
+	    (mproto && mproto != BNXT_IP_PROTO_FULL_MASK) ||
+	    (mproto && sproto != IPPROTO_RAW && sproto != IPPROTO_ICMPV6))
 		return false;
 	return true;
 }
-- 
2.46.0


