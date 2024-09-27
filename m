Return-Path: <netdev+bounces-130104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED2D988386
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 13:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DC31F24113
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F5B18A6DB;
	Fri, 27 Sep 2024 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="r+38QcPg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DAC183CA0
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438106; cv=none; b=C35uj1ZQ6f/x8e+7xqFwrxrQ7NnfDWbXz/7YLxWZLgjWk4InJEScZahhRjn/Bg9hsntnkMno4G9y/EKn59UgG0HRGOLa6dQfRQyj0WHPi/bMBspGBtfMzr5ELr4idtekxmGQF3Ei+dVEOrKyQR1F8Qlx8TV7wDPWQPE39F/Adi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438106; c=relaxed/simple;
	bh=ctRyTqItGXKsHGOwl1H4NA8pK/Phb7gWknhYkKib/Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p8tY9w6AL40yvTvr1fhLiNiECuJcTKgPbuDQHpNLq6AO8DNqCT9A8AdbXovbb/uA8dRctQZrmtP1iYr4323kNJYLTtF1iO9lRKfHibTWVq76VkV+PID8RrI8vC36sWxbW35raK0NkrW66etsZDLGh4BInbJRftZl7CMC3Q0Rh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=r+38QcPg; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [120.85.106.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 84A5640277;
	Fri, 27 Sep 2024 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727437647;
	bh=1V5jaOlJyAWu6qoK5On0+XA3Jat5U+8h8bUOeyMc8eM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=r+38QcPgmZAhSBUkwWGUtmrKjeU3r7UYj0+NtEjm4z8CfozTRUPT/zbe4fG1LQO+y
	 YtxdHN5/ruIzEajn2GLbgF+Flav0Cn1K1vWqQzTuaeGMX9ujP4DkmKOkW3GPa2C3R4
	 g4vn9dTWgKO1UYBHcLBBbYZjTOp6HkEvoY4BdvaYLoaSOArG7V4gxgLa4LVB2N5mKk
	 iV0ISm2e9sQ9TkV6xGJCQSS4zrh1B79wlsqZV7ZCB3/kr4PUY8GzMuP+XPn3nBCX5N
	 vIHWZabDImmzejFnxsKY+/zxyxeoReAMZ+YDEkEjRQuIW17aFn+F/VFis3n2LC9uKl
	 8N5Axo7p6WHWw==
From: Hui Wang <hui.wang@canonical.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	marex@denx.de,
	netdev@vger.kernel.org
Cc: hui.wang@canonical.com
Subject: [PATCH] net: phy: realtek: Check the index value in led_hw_control_get
Date: Fri, 27 Sep 2024 19:46:10 +0800
Message-Id: <20240927114610.1278935-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like rtl8211f_led_hw_is_supported() and
rtl8211f_led_hw_control_set(), the rtl8211f_led_hw_control_get() also
needs to check the index value, otherwise the caller is likely to get
an incorrect rules.

Fixes: 17784801d888 ("net: phy: realtek: Add support for PHY LEDs on RTL8211F")
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/net/phy/realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 25e5bfbb6f89..c15d2f66ef0d 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -527,6 +527,9 @@ static int rtl8211f_led_hw_control_get(struct phy_device *phydev, u8 index,
 {
 	int val;
 
+	if (index >= RTL8211F_LED_COUNT)
+		return -EINVAL;
+
 	val = phy_read_paged(phydev, 0xd04, RTL8211F_LEDCR);
 	if (val < 0)
 		return val;
-- 
2.34.1


