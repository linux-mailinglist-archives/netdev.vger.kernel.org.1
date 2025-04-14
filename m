Return-Path: <netdev+bounces-182243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF52FA884E8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CBD1635C1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4DB2C1095;
	Mon, 14 Apr 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="OJJaZGgO"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28AD27FD77;
	Mon, 14 Apr 2025 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639332; cv=none; b=ryO4J92wvnPl0sUT9OngTXszdrDemp1e1Bd5E27vOyx5zMWMU1qVlnGbe6ocoOfrwgxdRax44I4os2drYxMxAscimGbFpfR1NMcs43l0mqezURTWqzfUOeaTvPsqiIuuj91MdT00BCZscXHIF5sNc7Ay0buq5wDmwfs5lq1EN54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639332; c=relaxed/simple;
	bh=XVj9JR7DNRUFpN+AsxSxl6AseC4mFLvQ6gkTVey6KEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQLnmispJgY3L3yH86eEjAf+rUmPGmiBJxnjQPynk7vkUkyS2X2f7l3ekx+A/ikWVcHTw3KnF9BE3znPK5sr0wwE45MDZBLgoui21fMKv9Gx5RsY9V1DcV+ZOf5tRfHYmainc+UhizvqSVi23L/+3JMfajdAk/H3bTS3U+n6qzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=OJJaZGgO; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A26861026C88F;
	Mon, 14 Apr 2025 16:02:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744639328; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RbGnIm4hb935cyx0JLBc0r6wcr8bm4+ihAtRQ47eXPI=;
	b=OJJaZGgOUsi76mes6eYPL7Zp1qTQvUA/bQKvbhIOHR8Fu6Iz3avQpCSqUPtI5zLwP4AtOV
	LmKdvytWy3RJJAZubLeXuKvp8eEVF/ouGrZsfBNx8FWUC6WS0qxu7Kwu9JYZyDNkU1tbbq
	MvEIZyyIBSwU+K5Qg3qx6aRGv00nDnKO+Gj4aH6rLo6ymNpFs0mrASyZEnkgfq+mcagn0L
	FcJCewBj8NRyVcT4trFsm/KxEnl+YK8KNkoVM1X2HpAHqzwDj86nAbKKpFHIFD2RJEFb+w
	oZ0B/Yf6LxnI3407/ZJ8/yFAQSimop1gTJGF23PXFOSSf2GteIVH8da0Tzmd4Q==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next v5 6/6] ARM: mxs_defconfig: Enable CONFIG_FEC_MTIP_L2SW to support MTIP L2 switch
Date: Mon, 14 Apr 2025 16:01:28 +0200
Message-Id: <20250414140128.390400-7-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414140128.390400-1-lukma@denx.de>
References: <20250414140128.390400-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch enables support for More Than IP L2 switch available on some
imx28[7] devices.

Moreover, it also enables CONFIG_SWITCHDEV and CONFIG_BRIDGE required
by this driver for correct operation.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v4:
- New patch

Changes for v5:
- Apply this patch on top of patch, which updates mxs_defconfig to
  v6.15-rc1
- Add more verbose commit message with explanation why SWITCHDEV and
  BRIDGE must be enabled as well
---
 arch/arm/configs/mxs_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 91723fdd3c04..4f8f715dcc41 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -34,6 +34,8 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
+CONFIG_BRIDGE=y
+CONFIG_NET_SWITCHDEV=y
 CONFIG_CAN=m
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
@@ -52,6 +54,7 @@ CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
+CONFIG_FEC_MTIP_L2SW=y
 CONFIG_ENC28J60=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_MICREL_PHY=y
-- 
2.39.5


