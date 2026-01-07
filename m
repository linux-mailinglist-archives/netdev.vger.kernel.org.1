Return-Path: <netdev+bounces-247603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1B6CFC451
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4015301E16E
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 06:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143C4225402;
	Wed,  7 Jan 2026 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnuN3wE8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3221A92F
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769095; cv=none; b=QyVbTDz57M4tN77h/d/aRos8+ZcdxVho/XFTyMajtXBNx8rRdsBVopZ6/qszVIf6Ce9ZDWuKoISSWSnZR766R8NG5Ol1ON8VuIgpHzgYZNInnms1NpcpqxMXQgGvtyE6J4UdMj1fyMZvmbiEMDHaurf4D8ONzjOrG4NVvkS2OyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769095; c=relaxed/simple;
	bh=mlN9zkh9M3tZt5lOx2N1rJAxHiAi5K7DEEmHZYCmjS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqNlOgq2dbwfrG8UUinrk0ih7oEi7ep0hqmnYEMx6KitXfQLimsjpkHvIIQnysKVsLQgDfFWmReSOkP4X5HipNYuk7KzzYbLH7sLoXatab955wz9DyvleChKZmUu4Pn2XmmtahoKXOEL3zeQmd1j92stBzpsPj6smJVg29WtGsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnuN3wE8; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-121b14efeb8so2091368c88.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 22:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767769093; x=1768373893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxFsfTf/n8/5lnAFGn+tLoUnsynlfYu93KTb4EE0l88=;
        b=FnuN3wE869VzzPBLYs1itRQtWSy7RykP3gmEFf2vbDTHSP32QEaw1o09bXX5ofdzxF
         eoCJ2AEkiphTFWHCAbMehr/z/SvH9/cic4z2oIHeBIMLU6GRJW4oLWG8Sef57MTDtsam
         OO/CdJtITJsLuEcXjrv+9mLLLhdzvW254ygoKijcJC+HSXqyI1ZShQoY3rCIPLKMfqjy
         TkBpEkLzGvtxcpIz7bFJhvJZ1KzLm3QLkMBLFiTELLr4/LxxqI3yzm8F9DHSQm+MNb2w
         pzkdQJnvg8iBY0t4tNcEhhkUFA292jO/1TeJLFWO1ni45AISLCjbEmC8tLNGlG40KQ0b
         Y2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767769093; x=1768373893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JxFsfTf/n8/5lnAFGn+tLoUnsynlfYu93KTb4EE0l88=;
        b=jMfy4clmpodwt22x4daPEMiOQat04lVYI3GOUu8U65JmplY4ZkIcc1YuFnRu/WijL5
         qnBsFhX1WVHMy6il1GVJbr6d4KFhNZq6utMivqgzS5NpjblU2QDT9gO/Q3hS3lvRSDSj
         /8K5GwCwTsG4Usc6ZPGFYM60qTV9s8dWx7N76oHgEMubF1wKsDWaqXvbhUwn64rNxlYJ
         XWrXYDwVq2sXEETNZeWZudrNzgV1FAvgvK34m8p0kfUph7i/g1jEAgnrUwfqNh70gx2+
         vB7/JkxIVr6HbMK05b9pPpgvLIgUowGOzsJ7LqPaHWHznkKH+VJIl8HUX0ZUWWWWOIeJ
         Oa7w==
X-Gm-Message-State: AOJu0YxRwWeZ/bbWWJjOC78EyWK3lg40W1F4BXeQPvY9lEXhMvoFf1Ms
	7PBbmGVT/4zclHCbRjf2bLSOATq6ABXn/J25gFTjCf5jdurDWNWZGLfdlhPqyPRN
X-Gm-Gg: AY/fxX7e+Fa6VzhlO38bQfwo3gmgphnuCN7038QGvX7zlniaFPQah758KQk+m8f59PV
	butO0o8P7nkGlBsXXu/1MOdzdd1JXN0mnY2UD5cAc3iSKTkm1O3uYUtXI/MZY/dp4mwKb3XSMfg
	76njsWOqGqhLh6wzO7u7TfbFRUxYx7iDdUSiithstxEJmzFMa4bKy+4CP4zjIOa8Zr7xNtBsEbk
	P+qSis+PukAo7Ms6NH1tYJjWV2xz6evpWC8beYB2gR6YZvo3o5nUafkuE1dLW/yWaMdsqAneztn
	gka+4cbDPl+xntQD/24qsyjhQ583/kb0XijZEQIVtaPD/NROM68uXj6OFCCB2qJ2YM4mCabIzLX
	X1WWuKnC3CUFxI88AGz80Fg3xDCnXdJ45tDa3fgFrbEreTfvUN1Gt0zEfbhkt8yFM2YokP82qKf
	zJKg0h4UrW5O/y0e0aHKObpnhkm4Kb/Of18O1j1xTUSeDPdMlFRL9/qtJJM0mIEpT1fOdUYiz3G
	qSdKaRSa5kxVYjPCJP5QNNBz89gJmkGI7/WcavS4+UMZk8T0JDQUG0Vn1SuSEac4+exVsiCC9/2
	6CjD
X-Google-Smtp-Source: AGHT+IG+ilWamkzHvJ5ey+yqNu8KjuQBJwMBYc9xY+8PsP8BHYX1pfI+Q03wqWCpLFd5cutwt/Qt7w==
X-Received: by 2002:a05:7022:e07:b0:11f:3483:bbb0 with SMTP id a92af1059eb24-121f8ae75e8mr1053511c88.19.1767769092457;
        Tue, 06 Jan 2026 22:58:12 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243421esm9145379c88.2.2026.01.06.22.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:58:12 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH net-next] net: usb: smsc95xx: use phy_do_ioctl_running function
Date: Tue,  6 Jan 2026 22:57:49 -0800
Message-ID: <20260107065749.21800-2-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107065749.21800-1-enelsonmoore@gmail.com>
References: <20260107065749.21800-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The smsc95xx_ioctl function behaves identically to the
phy_do_ioctl_running function. Remove it and use the
phy_do_ioctl_running function directly instead.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/smsc95xx.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index de733e0488bf..c65402d850c9 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -854,14 +854,6 @@ static const struct ethtool_ops smsc95xx_ethtool_ops = {
 	.set_pauseparam	= smsc95xx_set_pauseparam,
 };
 
-static int smsc95xx_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
-{
-	if (!netif_running(netdev))
-		return -EINVAL;
-
-	return phy_mii_ioctl(netdev->phydev, rq, cmd);
-}
-
 static void smsc95xx_init_mac_address(struct usbnet *dev)
 {
 	u8 addr[ETH_ALEN];
@@ -1139,7 +1131,7 @@ static const struct net_device_ops smsc95xx_netdev_ops = {
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_set_mac_address 	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= smsc95xx_ioctl,
+	.ndo_eth_ioctl		= phy_do_ioctl_running,
 	.ndo_set_rx_mode	= smsc95xx_set_multicast,
 	.ndo_set_features	= smsc95xx_set_features,
 };
-- 
2.43.0


