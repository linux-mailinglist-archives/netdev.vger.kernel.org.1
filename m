Return-Path: <netdev+bounces-130046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6512987D2F
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 04:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26ED2B22760
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 02:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282916EBE8;
	Fri, 27 Sep 2024 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="wuzdyuV1";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h9MssA4x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nY2fPuzV"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F000166F26;
	Fri, 27 Sep 2024 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727405585; cv=none; b=QwmU1bNoCo8gaksLiXWziNziicPZJUKLNwyh4VtsDPog1+1sjpxmvr2xoYB/gllkPtCLayKoVSwhwNYHsnHTIrU+XYAzZn/1f/w9qO3OdAb/Rz6D9fbeBMHYZpWSLARikfbfFAS6moyAugsVgHQnhbnPmMb680vE85EBxPP5+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727405585; c=relaxed/simple;
	bh=WkPezx0o4HY/+AcdmTGqzF7F/xul+CpBZE2MPamOqDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bsUdpCeDnHLLzjqrSeTXsvawws8YQrTRl45w7Kci3wD96Z9bXTupeflezMuYOXlHI0+3kRk4zeLsmEmc8w4bOdR3aNiXKjy1MZg2FNcX3RWIu+M63Y/p9yEbfor+ubxcLgl3XRFnHNKwtWysp1Xt5M+OI6lvXP1iOg1HzcEq+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=wuzdyuV1; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h9MssA4x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nY2fPuzV; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 79ADC13801A6;
	Thu, 26 Sep 2024 22:53:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 26 Sep 2024 22:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=2016-12.pbsmtp; t=1727405582; x=1727491982; bh=chcNNPjcSE
	3Sb8CDCL8RLtmY5d8nWZqtNTXTlkj4+po=; b=wuzdyuV1wcE7PF8z+O7e9bZVCf
	O4FACUIK0PUFamBhpYZUz6EwLK7UA3U3GrqFBPLOdpT6WDMxnnMD8cbVPMUVd59s
	zzYcI93nnPoAeualOjc0HgItljXYLvk4DiR2ZcnPcKvP5VAeWp2N320Lca7a7hT0
	zJNCJeEWTqRpFHyV0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1727405582; x=1727491982; bh=chcNNPjcSE3Sb8CDCL8RL
	tmY5d8nWZqtNTXTlkj4+po=; b=h9MssA4xwXeMvWGwgTe+jVFO2Bp+fXsqEzypa
	RYT3AJPLnd6ii3JSqdN4jl12HCHXrY0q7uQ4OLpqMR/0u1NpsseHBzuNALypE253
	yf9Q7AraNWIZ/4ndu2IgVlvsr5NCfuJexXao0+VLL670+XtgjgTrdN8x/EjiLvLq
	uwA65IQfdBYhfkcREdRsotXhrQRh3XJxn0VVzPr1EEX3obIhJL+pncaEd1S/bqkG
	1MVRWaaAGDwfwIKN27pPFB+rQKm9tnCwdWpWUsZCMQiRUmY5j1rf9WMdBZgE5Iqz
	1smSTfQ/IVGV59ur1qNSzi1i+OOTrhZQBm77a32TE2UTek9Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727405582; x=1727491982; bh=chcNNPjcSE3Sb8CDCL8RLtmY5d8n
	WZqtNTXTlkj4+po=; b=nY2fPuzVHTAV/NpWsLgViQA1v7rWumQSds/AIbRvr9Iw
	CyTz+Qfw5QZGY8mQ8lkeqIPz3VCG9/7oOttbfY6tkl4r7hvP8yb0YseW1yDkG5Gu
	dPPhNrL0FLRuPXtnKAA1fJPpbY/6IX1mmGCLr1M41r53K45zpcMvdjZwtechLD0T
	i1aP9WbXJnnesenGM+923x+HiYdrvRSUD/6+X9siMO2fj49idoGDOaS2OITYXxDF
	ghyyQR5vJfddkT1kYgRk7HOmWqvzA1TZMF1OQPFSJpAhjWk5lV+2mdC1XAmgsCyN
	THX+Bt8YyGrJmynfx1RZXt5xijWkmIi1QyxGtjoUAA==
X-ME-Sender: <xms:Dh72Zs4hZz0eUGT1TI5VSzbzozE8W1Aj_vZ8rwzr9lblOD7LNJNNEA>
    <xme:Dh72Zt6UJuP5LHqHTjbBQv7IEF04l_s2LbV-IQfxtIQQzCMR7XjqKIdMAeOLHJUI9
    PuC7T3plc987yeIFOI>
X-ME-Received: <xmr:Dh72ZrcuNRnWMplJxiO9e3ccAIa2gZNLBE0BD0gnD343pQ15qBRNuzWO7WAesc1x2nDspglaSSQa-l4UG0YVTB93TB_0jRwL0WwnU15rtGc_vPoQ2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnhgvth
    eqnecuggftrfgrthhtvghrnhephefhfeetueeiteeigfffieelveethfduleegheelteeh
    udetuedvjeffffdvhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhihlihgsrh
    gvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgt
    phhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Dh72ZhK6NIvToZ2i-HFBmzW_m-vuIcj_b7ETuZUUWPpf_g7b-QmIUg>
    <xmx:Dh72ZgIqewXLz6xkrGyNSbs8NhWk8Lxm5v8Tj2rh2oCFsK-wYX_f_A>
    <xmx:Dh72ZixL7fP3IDqj1aESmkUsgUYci1ffVpbOwcI-VnPf8Ncvlx5JGQ>
    <xmx:Dh72ZkIbwPR0OUypw-OLPP3rogca_BE5QXWQ5BpFTadTsNsy7Gc5HQ>
    <xmx:Dh72Zo-WOKJo3Tro0BrDk9HX-5RMGAqhTjGnb8bjeo2bq02Mp6IG3SI7>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 22:53:01 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 34420E25F6A;
	Thu, 26 Sep 2024 22:53:01 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: ethernet: ti: am65-cpsw: prevent WARN_ON upon module removal
Date: Thu, 26 Sep 2024 22:52:59 -0400
Message-ID: <20240927025301.1312590-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.46.1
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


