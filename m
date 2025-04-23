Return-Path: <netdev+bounces-185002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EECA980EA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5391683C2
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C160326E162;
	Wed, 23 Apr 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="fVwAVkf6"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3226B941;
	Wed, 23 Apr 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393395; cv=none; b=BlC5QMV8nQi0vr/Y3edbyoNXyA4dniunEC3Px8QEP98Vky6La8Bm082mTs370TBTPG5pcFRDeW1n7R+t7ktw3ZnFXWnPWUZs0fOp25SSep6+2N4T/sWv3yE8bnKvgeNNKX10R3TUiHjigNAKXI9NAKaXMRpkU2vOeXIF6TalZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393395; c=relaxed/simple;
	bh=/ur92+u0SOQHd6YsYjHL6mWSKNe+AOPzBnqsX6DxDts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CUN+MHcemOeq3MH7FkEXZmi84G9iXuLok/CGg9G+sPrqcyO/X3GLX91X/iygXjgRTZnjdkQGHAdX9Ej542hz+qvNOiLrMHBBQq5XU+CzqJjFR6qumgnq/3P+YLmzF6DUBtkmtBVjulsJkwl7QKxT27RfCsRbBFDRsFj3KLPZ0Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=fVwAVkf6; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7705102A4BE8;
	Wed, 23 Apr 2025 09:29:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745393392; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=eCojgqJD5RNVsuSKlWQXeXlsHX7xNPh0TCkFmdSQ7Cg=;
	b=fVwAVkf6KZ9UfQzmYbTUImgLTygtLG0TWeWjCKbdonsR/ELbFCMD9kz5wZUxGZzcTneumf
	hxbv9i/HyEsh1NcJPuDjOe9XrrNUgnIsADQlmj9bzNCDApCNW3yEjd6MesxYXUT9eBdhDN
	Yy1kUWZLuAJlY7SEj1cRWSwROAdMmOTgzwknDeZj6mAr//VkIJQO2bMJcbo3Lz0LqgV2ff
	s0aBsJFqHQlm9Gr/TLTT6Oa4bxblVb+TqO/1OI4N/jq4Ud3qIzgBd6ZMFCmppTnQFiNOAS
	gv1tq5hkYWjy+xNdE8k6vhu0NseiKyE8+kPeLf1MTUHknT0mebrdIoUCC1Oq2A==
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
Subject: [net-next v7 7/7] ARM: mxs_defconfig: Enable CONFIG_FEC_MTIP_L2SW to support MTIP L2 switch
Date: Wed, 23 Apr 2025 09:29:11 +0200
Message-Id: <20250423072911.3513073-8-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423072911.3513073-1-lukma@denx.de>
References: <20250423072911.3513073-1-lukma@denx.de>
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
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---
Changes for v4:
- New patch

Changes for v5:
- Apply this patch on top of patch, which updates mxs_defconfig to
  v6.15-rc1
- Add more verbose commit message with explanation why SWITCHDEV and
  BRIDGE must be enabled as well

Changes for v6:
- None

Changes for v7:
- None
---
 arch/arm/configs/mxs_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index b1a31cb914c8..ef4556222274 100644
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


