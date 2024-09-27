Return-Path: <netdev+bounces-130047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15B987D33
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 04:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9C41F24BDA
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 02:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52117107F;
	Fri, 27 Sep 2024 02:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="DSCTmzA2";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t5C3bCFG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mQlIgoT/"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF7B1514E2;
	Fri, 27 Sep 2024 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727405586; cv=none; b=RTo+JRr3Gm3ngaSm3XYwtaaz4Jh/d3oxBbj/OxkjH/1JJyuJra1Gc7r0W5RXvUhhapSw0Acdudd2CzZizDPEe1+2T1zy5AhYkOugHTVw7EwausKNMJpkXLgJkxjW0e9EjZac4Mcqsk8ZjirN2BBa/9wcO6cK9qjcsR99W64mGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727405586; c=relaxed/simple;
	bh=wpejYNIbHZjIWOcC+S5OkdvgrZkJfL7GbW9p64hKdlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cj3Tc/sGXHcHDKiItV/26At9VU8JEm1VME/6EjuvUf6/ZrexMM8v0+TkRC79pZ/q6OlsrMetY4OB5QSRxVPm/oTweGXgnPrzo9fdQHLZVg5nIq9mWFIm5R8v+2+JfhshUqqvJtsfRAzVXkrcQ4cqfDs5B2x9EqE+JcKSr8WSEaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=DSCTmzA2; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t5C3bCFG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mQlIgoT/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 83934138064D;
	Thu, 26 Sep 2024 22:53:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 26 Sep 2024 22:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=2016-12.pbsmtp; t=1727405582;
	 x=1727491982; bh=Ebzv83ZXk5BrbLk5HPuexO+XfIwQJeimAHqazYZBaBA=; b=
	DSCTmzA2nCX2ApE4ojhck7rtIlQU5bDrDbLxVIX/kRz71X4ihN8Ez/Q9urBdIXlZ
	3Hu+mUaQ7BD6W4cJgzo1Zva/rFmDIAm9y2BH0KUh0mBJLX8DUOouzJGQ2f7p5zRC
	W+UwNc+9ExjyIYwg+vii5W6x7Q3Xueko2Kb9dyZQAr8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1727405582; x=
	1727491982; bh=Ebzv83ZXk5BrbLk5HPuexO+XfIwQJeimAHqazYZBaBA=; b=t
	5C3bCFGg2Vsw6Q/0wbbLEXNRnUMrBcjA+YMrp2OLNdcIPb0q0RIRtENmzstvKC64
	TeYf5sxqDEMZYweVDc4edRz5K3GpuQeZz1Ai+gjf7ba7uG6yPNw+VtU5RMlRDZGN
	i8keSMoBjjevBM8b3nN+90KZ3UlM2LQTEUPKMn4EydL8mUvoT96NrI9febb8s3YT
	jFdaGSqAAw6ahtYavFzD1/EwW8mlDIkI4Pw+pjEMb9glCKYZwjri+5+gzj5mlejE
	Au3ThOikZRLfWvk5vtUnOwK+IBkheEm5GzS4dlbA5smA7rTzhI55koCxuHgekbcT
	PJBJjBhxquEhidhX85Wxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727405582; x=
	1727491982; bh=Ebzv83ZXk5BrbLk5HPuexO+XfIwQJeimAHqazYZBaBA=; b=m
	QlIgoT/LplGRCguDX1ENdoJ4qw3ue4Z1iDjijDJ24iKIIhTU6IsbaGQtyTEKCRx7
	RBtjYosr/QM+ceck9EYeMNRYBuRtdml5+MRQeCOdSJLmc4UHuE6/sBSkJ1cvzoXn
	SR5Z8W8eBQrO4Ii8J/eZR/HvuK31sLkJRcgiki6PVpyVEwh1ePTs1EfgbqBSbB5W
	Qhw9s2NSz3jOlxnxp6bcyBvSbGj+qtzASktxDkQHKlI47xq9LbwEtpWtkoGVP+gT
	bOwzEnK6FakwaH2oY5kwDROOKpk7mciGa4k9lbm6JbM8QCaa57KQHQX7Jo7xUkuT
	bHgEHoHNGMOLUz7rOqRLg==
X-ME-Sender: <xms:Dh72ZrIaIzA9Mt6PDLMC02p3blk8Rh5OqaHyuzU1Mvd9W7s4qPxWBQ>
    <xme:Dh72ZvJl_Ej9iLiws7KnGx8rii3vQulr1JkDiBHiM3PcClgt8S7CVRXpNyaPEcozJ
    kT3xs2cseuTF31JvUs>
X-ME-Received: <xmr:Dh72Zjssh6Xn5LQ4evG-wn5o46fe2rKOYXiuHR9Z4aiQnrKHiwyK9hNacwYRgJ_sHXCCpOTZCh_-iGhqVufdub5b2XNSc6E_TCgt-2HVB1b3pppqbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnh
    gvtheqnecuggftrfgrthhtvghrnheptdejueeiieehieeuffduvdffleehkeelgeekudek
    feffhfduffdugedvteeihfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthho
    peehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhihlih
    gsrhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdp
    rhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Dh72ZkZDkiF9OA2TbMbCUWQx7kGR-DK-2ltu7NHYXfeOnihee-tQIQ>
    <xmx:Dh72ZiZNg6hvFcETf_g8-wV67BuLbyA6OtU4MNDxoqTRKTyrg6X8OQ>
    <xmx:Dh72ZoCZJkvFdxVeprN8jYndoBFBklwQ6t98ds1-j3bNb_hDDQg4XA>
    <xmx:Dh72Zgbt9aHNNz0WaCJyhlEDpQX6VIFrj0rYuf21CnTXxCypvgPA2w>
    <xmx:Dh72ZnOQNAOcnGZBPLXL7Gsbn4sbcRu1HRlCcTvhresDAwy2s_tNIvPR>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 22:53:01 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 4FF29E25F6B;
	Thu, 26 Sep 2024 22:53:01 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: ethernet: ti: am65-cpsw: avoid devm_alloc_etherdev, fix module removal
Date: Thu, 26 Sep 2024 22:53:00 -0400
Message-ID: <20240927025301.1312590-2-nico@fluxnic.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240927025301.1312590-1-nico@fluxnic.net>
References: <20240927025301.1312590-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

Usage of devm_alloc_etherdev_mqs() conflicts with
am65_cpsw_nuss_cleanup_ndev() as the same struct net_device instances
get unregistered twice. Switch to alloc_etherdev_mqs() and make sure
am65_cpsw_nuss_cleanup_ndev() unregisters and frees those net_device
instances properly.

With this, it is finally possible to rmmod the driver without oopsing
the kernel.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index f6bc8a4dc6..4cb1c187c6 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2744,10 +2744,9 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 		return 0;
 
 	/* alloc netdev */
-	port->ndev = devm_alloc_etherdev_mqs(common->dev,
-					     sizeof(struct am65_cpsw_ndev_priv),
-					     AM65_CPSW_MAX_QUEUES,
-					     AM65_CPSW_MAX_QUEUES);
+	port->ndev = alloc_etherdev_mqs(sizeof(struct am65_cpsw_ndev_priv),
+					AM65_CPSW_MAX_QUEUES,
+					AM65_CPSW_MAX_QUEUES);
 	if (!port->ndev) {
 		dev_err(dev, "error allocating slave net_device %u\n",
 			port->port_id);
@@ -2858,7 +2857,7 @@ static int am65_cpsw_nuss_init_ndevs(struct am65_cpsw_common *common)
 			return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static void am65_cpsw_nuss_cleanup_ndev(struct am65_cpsw_common *common)
@@ -2868,8 +2867,12 @@ static void am65_cpsw_nuss_cleanup_ndev(struct am65_cpsw_common *common)
 
 	for (i = 0; i < common->port_num; i++) {
 		port = &common->ports[i];
-		if (port->ndev && port->ndev->reg_state == NETREG_REGISTERED)
+		if (!port->ndev)
+			continue;
+		if (port->ndev->reg_state == NETREG_REGISTERED)
 			unregister_netdev(port->ndev);
+		free_netdev(port->ndev);
+		port->ndev = NULL;
 	}
 }
 
@@ -3624,6 +3627,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 
 err_free_phylink:
 	am65_cpsw_nuss_phylink_cleanup(common);
+	am65_cpsw_nuss_cleanup_ndev(common);
 	am65_cpts_release(common->cpts);
 err_of_clear:
 	if (common->mdio_dev)
-- 
2.46.1


