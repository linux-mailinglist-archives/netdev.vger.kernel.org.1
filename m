Return-Path: <netdev+bounces-131710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B308C98F4FD
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1101C221D3
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9AC1A7ADD;
	Thu,  3 Oct 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="00NORwoG";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cOVqByRd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jYTvpSeP"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BF61A7240;
	Thu,  3 Oct 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976073; cv=none; b=iR/VEtyYNCd2yaltTApz2VkoSlNYgFKA8KAgLCMRv6mohbcMA/AGbtD8YfkHsY6Jlc3uGBjl8AoQURnuvnMpre5V+3/fFodQP2iV63u5/5e7Cq4QDp79HhC6MBYSRM2fYEqhNiKvw4lBl25RSb1UT8QOITc/R3eBt1KWTIrVRPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976073; c=relaxed/simple;
	bh=zzvhN7MdgZFsCDeGnEYUrpETzhGoAu1pBnN9N/vbcUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkATss9rgCPZ4axKNW7E3lqsJ6Zkbolob5K6e8bfngg8/AIHfeCRR/6zqfBrLtuf4trOJkTxBPdY5Bhu/RxwYdQEr/7YaKk8wfqNVjAl+zc1i6ckFvQjMvi5ERSXS/E4Qwt/VzGsPDjxK2v+amgMsCO2LdD/epoav7Jf7c3Uh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=00NORwoG; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cOVqByRd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jYTvpSeP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F7E711401EA;
	Thu,  3 Oct 2024 13:21:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 03 Oct 2024 13:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=2016-12.pbsmtp; t=1727976070;
	 x=1728062470; bh=Grcsh8hKx60b73xxxrMUlXKi0fKzSJUcDrZOp+euGcI=; b=
	00NORwoG91iMQBP2nMclEiGNnhLG+JXXMOLghGRiFLvFSf4ahr43PLs8Y7eW0Tuv
	4QA7Sh4czVoB5kGrvahpoysXQBtc5OO4Q1dbdEfqsT3wotArIv87LY6FDuoUD3jr
	6R7R/lONBj1jp4TlxrsGD3EUo8ZyJiSAR397WeD0c7I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1727976070; x=
	1728062470; bh=Grcsh8hKx60b73xxxrMUlXKi0fKzSJUcDrZOp+euGcI=; b=c
	OVqByRdmbNix2k68BXiGHv4FKzkX6LMMttsGbwiH4akh5/wzweWE//iIhdtuSfW/
	jNNYmB+CbYP/1IWyneSmODD8pKGruhYvdu/oh3V+b83TI7wB8NphlfmDBbJlHwm/
	nHOsOKflyeRAiYGW7XK9zNEsXGbFOZ2quNnnVXBbVHBd2Jx9weeidDnBsUMuVG7j
	KdbdC1LlJmeGBYbTjMUrhWl50yLs8hNC9O9xHC0Lym0k3QyEpynKx4Lx2YwbnoiW
	OKbiFsbjK9Jj5YGDFF4XI/2FQNQjzLdsFIEpveAI4OJpXEbUF84K0J46HOpRMdzP
	TXsScSt0m2jmELB8xigGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727976070; x=
	1728062470; bh=Grcsh8hKx60b73xxxrMUlXKi0fKzSJUcDrZOp+euGcI=; b=j
	YTvpSeP3uGuGL9HuWPDWscTZ+vbXUDmnMhpvqAUBMhux/vWuY3dIPcJHWD8z7ZQ0
	ai/l8zBgsqs7vcgzaFylV+jD0Wqtrr8h4YAgnhu05ewc7Ug+/85B3v7/O0yOzrPo
	dyKPG5WWK3tR8Wn+X0IjrmstiEZbDYzEICU9UhdYCERbZG5FA4rmTeKYmZTLCTKN
	wsov+8/5svxZtDLp9rgK6z5P49RXlON5sNoDTolT2xecgRj/w4r2tuz5atw0RAcq
	8nVZ4p0qTOqfnDRQqph6CoEZGN4YW3d3rV71fcE7YFAlZvzESrb+F7+7xi24ecav
	DWbeqjncOUFYOZRc2ISBw==
X-ME-Sender: <xms:hdL-Zp5X9Lx6DgmhIG9_WDSyOtr_76lEc5oRyGJ6NVAJQ669gHmw7g>
    <xme:hdL-Zm5eXwxJK_F1G7995c9owdi_JduOJUnO3r2JRMxGx90C3RLtH4F20r2Ge5dEi
    kTRS5z_J6t_qQrp3p8>
X-ME-Received: <xmr:hdL-ZgdhOlwlHz8Mtf70b3kis3JGjb1hV9ms1gSW7H1z1XbuJdrpcTAs485F5IeraXXTPiOBkQxx0MVspuPYWCH1wfiiv9hikqbvmVZnd1IeoJWXeg>
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
X-ME-Proxy: <xmx:hdL-ZiIGX4FJ1JWNkqthrFintDua3poxsr392oyZfNGqjOcS12o8IA>
    <xmx:hdL-ZtLsk9SC9uW1o_q6shOo2N8JQCXm329b5fMUC5EpoidWVnyzCQ>
    <xmx:hdL-ZrwdP1h1Gn48EYGwIIVXR7UeuzNKuRAgz0ZTsoMYLH57de549w>
    <xmx:hdL-ZpIihCsp-Ze4HMWlnC_K_LVqFX9-pwmnZAdxa7GVkkamjnOfTg>
    <xmx:htL-Zl_gvoEiYRaYjv_17Q5Ieg3WlCT2LPvKy32VnZE6JX7EugDvUnU->
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 13:21:09 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 5529AE3B224;
	Thu,  3 Oct 2024 13:21:08 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] net: ethernet: ti: am65-cpsw: prevent WARN_ON upon module removal
Date: Thu,  3 Oct 2024 13:07:12 -0400
Message-ID: <20241003172105.2712027-2-nico@fluxnic.net>
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

In am65_cpsw_nuss_remove(), move the call to am65_cpsw_unregister_devlink()
after am65_cpsw_nuss_cleanup_ndev() to avoid triggering the
WARN_ON(devlink_port->type != DEVLINK_PORT_TYPE_NOTSET) in
devl_port_unregister(). Makes it coherent with usage in
m65_cpsw_nuss_register_ndevs()'s cleanup path.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Fixes: 58356eb31d60 ("net: ti: am65-cpsw-nuss: Add devlink support")
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index cbe99017cb..f6bc8a4dc6 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3652,13 +3652,13 @@ static void am65_cpsw_nuss_remove(struct platform_device *pdev)
 		return;
 	}
 
-	am65_cpsw_unregister_devlink(common);
 	am65_cpsw_unregister_notifiers(common);
 
 	/* must unregister ndevs here because DD release_driver routine calls
 	 * dma_deconfigure(dev) before devres_release_all(dev)
 	 */
 	am65_cpsw_nuss_cleanup_ndev(common);
+	am65_cpsw_unregister_devlink(common);
 	am65_cpsw_nuss_phylink_cleanup(common);
 	am65_cpts_release(common->cpts);
 	am65_cpsw_disable_serdes_phy(common);
-- 
2.46.1


