Return-Path: <netdev+bounces-131875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C947498FCB0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 06:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BD1284154
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 04:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B4153E23;
	Fri,  4 Oct 2024 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="M5mCmZvx";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mK2dEOAy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qXQIYR+Y"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3577107;
	Fri,  4 Oct 2024 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728015149; cv=none; b=rszl1I7S2RpElbh/NmqIv1WgDPh6sVxXA1XnQ3I6nlnPTHfsCnJ1MSiByHa0kh3JiejRt+jjUcaSI4ZoKh4/GMr6Lvmq9v5GK/mBZzRNgzLxZdTDe0l12r855iXa/5BxAv6g2yS4UESG+Q0lFbRYgWpfSSCNO4l95dzNweIUspw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728015149; c=relaxed/simple;
	bh=ShIQQg1VHwsJok8ffAk6GFo1fdSFrP8iYTRSiNnc4TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHdMuCMZ0wG6VHJsF46hEcdjlJrX9y4jY+0ieaEfIGfmt5G3rP4EyJ3WRIEj6zLhfeL+GEaulJQnR0Y/cYQe5wlTQNqKDnD7T3xTy6BNWiRUIMANFIUyp7MZJPxMVBKD8yYxp5MVrv2jDl07TxwefzbIGSL/1CpMbjx9ryvj7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=M5mCmZvx; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mK2dEOAy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qXQIYR+Y; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7299E1140249;
	Fri,  4 Oct 2024 00:12:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 04 Oct 2024 00:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=2016-12.pbsmtp; t=1728015145;
	 x=1728101545; bh=eHTbyG0oDxNayxdZzQC2GQk/sSeoZeAzVlGODWuCYCs=; b=
	M5mCmZvxmOaxor32TdsyASTZrEzbNkOeGLQiZvHTEu+7b3AQy9o+Cg7Cc9rFI/r1
	HLzQ8Oj5vPCNjx6UrNxfA89KARqyD3UXiNLwcMkZJv/8TV1b5strpTZIdsY6lEgL
	qyRzjP5I2Ik6GlwtrdTWKyeCokOnDfdLvGeMX1hQfB4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728015145; x=
	1728101545; bh=eHTbyG0oDxNayxdZzQC2GQk/sSeoZeAzVlGODWuCYCs=; b=m
	K2dEOAyTrD3PlKBJbn8G1QTW6UAFv3SlARcK4u9ajcl3KrN8KTmqvMsIL5nIpJ07
	2y816aYJ0ZDf+w77XW3lym9maIGAjKMImkBjSZhj+PlCQ5UMbpsAOvbNVJbhXgKp
	UwpobebX0E8P+3Ohz5eTIX5b4Usiyiw3ie0yulY2bhKAsRkVzO0z5aQuP+jvhe2V
	daT5AEdui+4P1mqk0Uibq/+VuoXfzKRW9T2FwEoCLnKz1XKe56ntG6KDv7k3qzrU
	Xgr+eQZk1TYaEMBXF2ZkjU+j+6OALSJc/5pkbj3WL/Gn2Sw0nIikb8twWX/YIAfq
	Gz7sQA/WI/0EHzGfIW0MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728015145; x=
	1728101545; bh=eHTbyG0oDxNayxdZzQC2GQk/sSeoZeAzVlGODWuCYCs=; b=q
	XQIYR+YbfambeDm1BBQ4PbibKMo2CF6VKLqxYXvUj0Pj03r4VJfNNJLfokSwxwzn
	i/+Rsd0EXyZX6Z8vvCA8eJmf0My4/5VxbaCZFCSr4nD0/FF7wCxR1mafvNgXWIRA
	JcXSgMt41qP83FoKloeD+pqRNjMAhCTKONnW822g0L8yQTisQCS0EzWZU+G1sVCN
	zHNChAZEnECxGKnmpLU6fKOiWF3stjOHn5sqWLEvvvxwVVTJWncrSaJNYseiSub3
	5sQfSe8L7rBJoYcfFcC2OuhLDaanLE6hHqomygfGv/1GVQHkrz3doIURk2PfZVrN
	NeKILUQsNgI9qgp2JQt8g==
X-ME-Sender: <xms:KGv_ZqMGYDIboClYF_aHAmG9ZwzS5RAiKUjfHlVwIJ7u0Y4RC6o0BA>
    <xme:KGv_Zo9hE3nMfYCEG0x1sKMR0FyZx7dtMGcT26_SCHqmkEM_iyLfikB49kK2hG0st
    F5BufgfbsCkqPdXQO4>
X-ME-Received: <xmr:KGv_ZhRcG-AyPLpInxC3CaaEopGKxTZvgjc-ANVjf0s404zZXsU3EXuV4LBmhrBwFAfLOXwA7sDm-Q5eflARg8PtCoDDbsR4xx3rcJ7PS23mnKKoLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnh
    gvtheqnecuggftrfgrthhtvghrnheptdejueeiieehieeuffduvdffleehkeelgeekudek
    feffhfduffdugedvteeihfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthho
    pedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhpihhtrhgvsegsrgihlh
    hisghrvgdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
    pdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhoghgvrhhqsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepghhrhihgohhrihhirdhsthhrrghshhhkohesthhirdgtohhmpdhrtghpthhtohep
    vhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KWv_ZquYs3_NkeU6fs4TiEIzdPVz2M0zNwYj9NKQW5546DFp3X0v9g>
    <xmx:KWv_Zidnif5WIpn_gI4mwuNwMpYaHTU7FC8cNHfRtW9ezAuXO2Ne0Q>
    <xmx:KWv_Zu2RCD5bkA2HgT6lL4sh2Ckh4YevTWOrY9HQxqrd9RSPGvjhqQ>
    <xmx:KWv_Zm-h2puIn882H3ZaRHra9WvFcRitHf8PZbeSgEJf7iND-iUePw>
    <xmx:KWv_Zu35Sg-a0FT80dAr0GXirZxNx6CFKjW-r2N2MIbYtSJ0TvOulO5J>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 00:12:24 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 4AA92E3D83E;
	Fri,  4 Oct 2024 00:12:24 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 2/2] net: ethernet: ti: am65-cpsw: avoid devm_alloc_etherdev, fix module removal
Date: Fri,  4 Oct 2024 00:10:34 -0400
Message-ID: <20241004041218.2809774-3-nico@fluxnic.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004041218.2809774-1-nico@fluxnic.net>
References: <20241004041218.2809774-1-nico@fluxnic.net>
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

Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
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


