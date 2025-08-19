Return-Path: <netdev+bounces-214826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6284B2B658
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922A31B62808
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 01:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1F81E7C12;
	Tue, 19 Aug 2025 01:35:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2F15747D;
	Tue, 19 Aug 2025 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567306; cv=none; b=Dhsww8ba5xZQDfULQ6HtW6pY0n1FjKcbS4y+wv+xk70vxPeHA3yOqBUV7mdBVqkZCp0XefbEERpOakG/mPNVM47H3aLRfAesU6DOZjzmOyVD1ATj1DScVHANPLOUqlL0SYsEbMqhOcQDogkjPhL3jm0Sik18HrjLkVBWRNq3pRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567306; c=relaxed/simple;
	bh=MAlPwEUABUm7hiZGRY2uATv4Exkmx934oFD/ePxmpZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxlSM47VDN3Y+eDVggKJzUquODuUNcj4lw5FgGyX1sRMgfaprhx1q8s27NRMsH2Zr9GYQyBElr0xFfjmuWNxuVo2Yej7omgYD60//Q6WmM0Uk7IlK6D0YPbGwXFvHhpdd7YVo5IijV9nHDcoXT8UML4p+YLEERZy4kAuUYsu5Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uoBFc-000000000DC-0bEU;
	Tue, 19 Aug 2025 01:35:00 +0000
Date: Tue, 19 Aug 2025 02:34:56 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v2 8/8] net: dsa: lantiq_gswip: add support for
 SWAPI version 2.3
Message-ID: <fec27a7cc9d2db00829597b2cb12e5c475700117.1755564606.git.daniel@makrotopia.org>
References: <cover.1755564606.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755564606.git.daniel@makrotopia.org>

Add definition for switch API version 2.3 and a macro to make comparing
the switch hardware version with the (byte-swapped) version macros more
conveniant.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 5a0ac7a538d9..54cbfad21ada 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -7,6 +7,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/swab.h>
 #include <net/dsa.h>
 
 /* GSWIP MDIO Registers */
@@ -93,6 +94,8 @@
 #define   GSWIP_VERSION_2_1		0x021
 #define   GSWIP_VERSION_2_2		0x122
 #define   GSWIP_VERSION_2_2_ETC		0x022
+#define   GSWIP_VERSION_2_3		0x023
+#define GSWIP_VERSION_GE(priv, ver)	((priv)->version >= swab16(ver))
 
 #define GSWIP_BM_RAM_VAL(x)		(0x043 - (x))
 #define GSWIP_BM_RAM_ADDR		0x044
-- 
2.50.1

