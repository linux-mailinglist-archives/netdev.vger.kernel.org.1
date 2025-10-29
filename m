Return-Path: <netdev+bounces-233774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9E2C181C8
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 04:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC70D4E43BF
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC9B2D9EF0;
	Wed, 29 Oct 2025 03:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AfxONwmC"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A62C026B
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 03:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761706911; cv=none; b=pmZlJXnN7pX8pLbJv2DOO7E4Z82TyRtuiiY4Dy6d2zvWlC6VyEQkLMAj+xMUmE0wvBi/4PiwR1q3i5UXgw3ZokfR488gaHlP38psyhvmympovuj1nY/S7VqH1NH5VNHadXsLytrqWIPRBeio9SYJ6UnzyvAz6AOHKLrLxDqnah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761706911; c=relaxed/simple;
	bh=mx2F6/vwuED9DzbKrbiALNqgKgaARjR4o44AWuQ3vBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dmmSbj/FvF8KqzBONpe+UiY7d2znjbZVu+VjracJcyRvYwIxpITbefWyEest4oOfmpMpr5wxbEXCVjgpqgeNinTGd4CDL7BTxizaldy3klOmr7GW3SuhOVTvh7o0EmzVG3Pq/+oXa4DEuo3/OpPW+TuisEmTQZ6GRf0EibOXtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AfxONwmC; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761706907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukNV8wqYjjps4L53O/aYTQR//EoDC+b5Q+4KHLrPSVk=;
	b=AfxONwmC+N2k9JRZSfdV2SjE2/ym8xH5k+5yAdtXx6yPcY32NvHmBHa72HKseTigQKg+nK
	ZAJkkdK8yk76L05eMYiiNlydOODqkOgw4WhciTgNhJWPn7rGrF2ainoOJv7I41nkwkMjJc
	LV9O8RmDPoifV/mcqWCIq1ODEHAZ7s8=
From: Yi Cong <cong.yi@linux.dev>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH net-next 1/2] net: phy: motorcomm: correct the default rx delay config for the rgmii
Date: Wed, 29 Oct 2025 11:00:42 +0800
Message-Id: <20251029030043.39444-2-cong.yi@linux.dev>
In-Reply-To: <20251029030043.39444-1-cong.yi@linux.dev>
References: <20251029030043.39444-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

According to the dataSheet, rx delay default value is set to 0.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/phy/motorcomm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index a3593e663059..620c879d89e4 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -890,7 +890,7 @@ static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
 	rx_reg = ytphy_get_delay_reg_value(phydev, "rx-internal-delay-ps",
 					   ytphy_rgmii_delays, tb_size,
 					   &rxc_dly_en,
-					   YT8521_RC1R_RGMII_1_950_NS);
+					   YT8521_RC1R_RGMII_0_000_NS);
 	tx_reg = ytphy_get_delay_reg_value(phydev, "tx-internal-delay-ps",
 					   ytphy_rgmii_delays, tb_size, NULL,
 					   YT8521_RC1R_RGMII_1_950_NS);
-- 
2.25.1


