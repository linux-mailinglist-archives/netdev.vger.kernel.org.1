Return-Path: <netdev+bounces-131709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F2098F4FC
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A0A1C21F0F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1087F1A76D0;
	Thu,  3 Oct 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="DE693XBz";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I36BJjWf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cW4DMLQ0"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699721A7046;
	Thu,  3 Oct 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976073; cv=none; b=l7vssW/7NUsXUt9zXNjROu9dW4M4UfMdx6ll7hIRNCdfc2AhgHLNPGKs8KDcTgpJuAPdehllW8QxzAZkr3AmlOqr7XYSJwrPs1jMAqpmksW5UhJIXM6oqEIXKnLEnWqJkb2Sj+dgE+JZ7niiGZV9Ql4SAzKRRmWgGakasfzQjSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976073; c=relaxed/simple;
	bh=HbEzXLH/jnP5HGWqMdjFnIPLwuD+a1iwUyOjMCqMxvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cm2ct9VPqQNNQf6syb0vxMkV+JY1U7RS3mChaBpAee9vozOHnuNx7OjXuORhvjQq9Lg8+t2EJbIKyvIFRZbZFNYVWhnCt3rH9vJPUsloJCd0QwvqvamJq1uZu0zIjkh9Z5x1UDAmc3whjyBkOlOZIhAcnZNUdMbpZOAmBC/2maU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=DE693XBz; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I36BJjWf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cW4DMLQ0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96B69114021C;
	Thu,  3 Oct 2024 13:21:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 03 Oct 2024 13:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=2016-12.pbsmtp; t=1727976069;
	 x=1728062469; bh=T0Gh2u4m3SKRElcRPNC2jke2wIz4dVAsTOIve8RcFg0=; b=
	DE693XBz/1b5g00of7cv9jCWAq197Jd9yYnds2uw+E6gX11SxNUHHbNKbe9ce1q2
	NO8h/yPOuYPTqd7JF4g8i9iBtOjxCw4w79TjCAFba5JZ52jndE7xY9VFrwQKJ+Zq
	BfFbla3Op+E73+XB7Qg1eXdPm3VowCPT6v2HXp6gGyg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1727976069; x=
	1728062469; bh=T0Gh2u4m3SKRElcRPNC2jke2wIz4dVAsTOIve8RcFg0=; b=I
	36BJjWfqCEjH0XZVFxLEqE3Bn1HUPgNpFxKX8ouOisjgvZbwYV7vPPXIr4nStGtt
	p+bklPEW0X7Ta1rAcLew+drYFeqxz1o2hVLvSDiuFL+9/ELiS3iVj7MxtKYbvTmY
	y3wlbSjYJbbjlb2vUUW10bIKm8Fm+lcBQ1DbHQqop6g+BQC/9UiAok85GyiyumBE
	3iHKlfuyjDZ45iNbPCouu/J1DMrAC3KHkOfe3g8y7SBneeJa1I1ES/kdj+ApZkqn
	v+CPyo7EM0RxVfs0nK+FQ3QQQMnEXblooLECvS/0i0cEaBTy2It6z5L7FyaHKes4
	WRff2GU6kEFp1hHrVN1oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727976069; x=
	1728062469; bh=T0Gh2u4m3SKRElcRPNC2jke2wIz4dVAsTOIve8RcFg0=; b=c
	W4DMLQ0SaljKT7J76tZaRYDWYyFu33Oav6pdR2JsBviGHwY+gKZdfUSzf4A1/WEW
	Tt0cb8/2lMPjYLS1fUI5dj9Cq32EhtHcphlO8Rfz/ZTHmBnII910OXIO+oTMWAS/
	B/vnGDv2z0j+uxM0nTMrYI7KK2x8pqmgTrUrMb/vVmnxz6fACVdwMorPtRi4RYHW
	YuKtF2DcVEXAUZaCwyrzwyUxSr3Lhl9Y6rcVzOHO7pSh2Muqadst1LXjNuvPqu/q
	WWj+f1S8UvX6x+xoSHv6sHZGUI45YDHPkeortteoE4CTf5LLj3VDqSWggL9wA/JH
	vEipzMvFMj31ZsCWdOPxg==
X-ME-Sender: <xms:hdL-ZkPrHa7-Q_Pe-z_MDnx6WW2LkJudymZ6WOVG-Fkm_OFwS3TMmg>
    <xme:hdL-Zq951Ud5psbeomhE6CsLtsHDUlyQPcewMB00EiFfjGg_dMALHbnosrwCvG9z0
    FwGcVN2Vm77HDfzgZo>
X-ME-Received: <xmr:hdL-ZrRh7EefPq_ZzFeq3MNJkxQExrR7YFZgOLjZ6xDJtbOfNPjonKuAYDIlgGR9Fiitrx_QGodWloFSunx20vJ7jYA70J8e0HWD4qG6QMaSd3UxIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrd
    hnvghtqeenucggtffrrghtthgvrhhnpedtjeeuieeiheeiueffuddvffelheekleegkedu
    keeffffhudffudegvdetiefhteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhpihhtrhgvsegsrgihlh
    hisghrvgdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
    pdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hdL-Zsu9QG67c-uyyGyhRYzMOjdl0OMuHZNRIPZbGZM8-tlOacDoRw>
    <xmx:hdL-Zsf1fFkkc6oaggReqZsCincUgM1epK7TIEIvJcD2dSuJaiqUpA>
    <xmx:hdL-Zg0MYAWiCqi_sH5hioqtL52kLxYWOI_23M25OLQCikIpyMGXxg>
    <xmx:hdL-Zg9hUmmrtx0B11L-w9HIFQaroy6bymey9ulA1D8EMuxf9UAUDg>
    <xmx:hdL-ZkSnONdKVSrtY2s_CfOVxz5C15stixz25Nr6diC_U6AMK2W7Bp9u>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 13:21:09 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 6FBF0E3B225;
	Thu,  3 Oct 2024 13:21:08 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] net: ethernet: ti: am65-cpsw: avoid devm_alloc_etherdev, fix module removal
Date: Thu,  3 Oct 2024 13:07:13 -0400
Message-ID: <20241003172105.2712027-3-nico@fluxnic.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241003172105.2712027-1-nico@fluxnic.net>
References: <20241003172105.2712027-1-nico@fluxnic.net>
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
Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index f6bc8a4dc6..e95457c988 100644
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
 
@@ -3613,16 +3616,17 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 
 	ret = am65_cpsw_nuss_init_ndevs(common);
 	if (ret)
-		goto err_free_phylink;
+		goto err_ndevs_clear;
 
 	ret = am65_cpsw_nuss_register_ndevs(common);
 	if (ret)
-		goto err_free_phylink;
+		goto err_ndevs_clear;
 
 	pm_runtime_put(dev);
 	return 0;
 
-err_free_phylink:
+err_ndevs_clear:
+	am65_cpsw_nuss_cleanup_ndev(common);
 	am65_cpsw_nuss_phylink_cleanup(common);
 	am65_cpts_release(common->cpts);
 err_of_clear:
-- 
2.46.1


