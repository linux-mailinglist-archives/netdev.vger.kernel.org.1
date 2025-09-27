Return-Path: <netdev+bounces-226922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C73BA6304
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D74189EF03
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 19:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2251FA859;
	Sat, 27 Sep 2025 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aui6m7nK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F99828371
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759003017; cv=none; b=f/3ypA0s3yh4Qc7EyIpdaUECDVn8WHyEEeorcK4qqp083+Nm92JjPg0NS+qeDDu7rgHiQJN2/6by1F/PbpPyoGzTnqxDdUHcqankYseByRzIUnexTCp7VYgGsjs543g5iTZV8F+Kr+Col35fvF6IL2Z0gDwwUqKAxrLJdO56EMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759003017; c=relaxed/simple;
	bh=dQNf3/eIsttFZj1N2b2LEz9vl/93iO+iekdSIZJp5Lw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JgVqv+33yu6NFNIcSNPGmkU3F4A99s86mpuiP4kHvHN5C23CfOwSgXoonT/uaGi+ZUGo5v6TjU5glqMN2QtzK83EDFjgKYHY5rKGefZasPoTKzlQyp1xYpwpWJnbt83I4JctImTSaCILvH96HbqO8sBwc0eM51wg3HDBHXcKmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aui6m7nK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso5064535e9.3
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759003014; x=1759607814; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iou3ANeKh05XR7izAa6/5Hh3RTOd3ZwvqUHF0GKJEQo=;
        b=Aui6m7nKlDUSapxczDSTBgsJtoHSJWyXB+bvBnB4SJGx6uqQieoOhjFdeyJYCpbZgv
         o+/XNjQekOu4KhrodZeRsxNODhckwHQrrg15EBnw3Q+7d8ax8EVE4FPrnJMFElkcGFxs
         62LPhK7CnwLEvYieHdE5e3gN8cIR1FIFyMSUCe38GOQAO7wTKa4MxawsveAhIBraQ7C4
         4RK2IOY1p9+3LnLm0Sis6HXcpTOzBgp6fqlk1HUiSEP6QkzaGRG/JQAGb7wRPiYC3WsZ
         dj4JVBrHnefvZz9HuCpD6JfvI0Gmtpf825orcPvJV7p18hAMz2qGUgI8LDYaIvzHkpnC
         r6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759003014; x=1759607814;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iou3ANeKh05XR7izAa6/5Hh3RTOd3ZwvqUHF0GKJEQo=;
        b=NQl7TzsRwsmgEEc1u9BvbTgyg8dq4PKunwBHtfaBV+tYL59VMZGLZ7kjX7Zjp1AYzJ
         Rr3AT1k5qRFL4sSUVfewUB32KaZ1iClfPbpCSGEyGbFWVwJEwqkXEligZ/cOoMpMMkrb
         QU4md1b6vTxhkB/8yBUXEcPxP9q2KzWxLIxFtOQII4t8pAjS9X6q9ulmkwtcR246XBWR
         lj5AiuUztB8Qo9JYEh+PC8TenkoliwF6VW9xtJ0jthHvpXndhhy6QywQRD9S3Gewkyfr
         6EPd5mnmM3K6rdapaEZjM2X/dztj8IXeo5Qw0rKgMmTbwFEl/mqIkW0BJwgHHeyAN4Sn
         JEHg==
X-Gm-Message-State: AOJu0YziXITDYxiwfzb3VvConCbvgt01j1cc+XKoS7fwjw0Z6bDqNZtR
	wjUIfOR64jCyugsrhptaW9TS70kNVCr8CLKqedb6sR+fulan2pMzo56s
X-Gm-Gg: ASbGncvYqooZOyccvrFCa8SNRwKHUFWrRz93YVpihKDirlSerkUX3VvBFgR0gjbWNXJ
	TMLJ44Urng2hD4Vj1X+v0f5rIqCTeqdJXcfQ/TQDqetHXnv0Txcz3yT+e5Lh+AsDmW+CA1nK0NL
	fMRyd7E6pzaNy941Ei5oXbMOfxoI4QtLodqqEsaYKVvbqw0EyXN7H8WFPzfTfy00Y+ZSpMQjylB
	WzjzNkw2l/yEIyLckBiEkunof7RALIxWrdyCMUQfjI2CMHrpK1bA4Rx8OEqZmyHGW39s6304OZg
	nqLFCcu0BD1QW5zFEpzpjH+5b4Gd0NMUdvmQLf2SdaY02rcC+h7lRsh/rPhOE/PE6qnfTISP5h4
	z/E+ZR4KXhXKbtcDDaRGnkrrftvVkJoZI+GDFbHBj6R4AI18as2XjCutRONIy3GhFqqvGm1QSzq
	k0mEeiJdNd5PmCKrmUvYQAMsu2PztK+l7BzFncVQ4QHyM1vHc3QFth47SLvw/ql7/9uEEi9Fb2
X-Google-Smtp-Source: AGHT+IHtKuopPofZorqx6d3saJPW5M5ReM+iG8spMKUB1zjVl2WQtM29YlGNCo4fdxqYFdomQkxNVg==
X-Received: by 2002:a05:600c:820d:b0:46e:4744:add7 with SMTP id 5b1f17b1804b1-46e4744b19emr23109495e9.7.1759003014343;
        Sat, 27 Sep 2025 12:56:54 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f38:7d00:d0c6:28bf:dc2c:1c4f? (p200300ea8f387d00d0c628bfdc2c1c4f.dip0.t-ipconnect.de. [2003:ea:8f38:7d00:d0c6:28bf:dc2c:1c4f])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e32c49541sm60494515e9.5.2025.09.27.12.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 12:56:53 -0700 (PDT)
Message-ID: <5fb9c41b-bf44-4915-a3c3-f20952fce6de@gmail.com>
Date: Sat, 27 Sep 2025 21:57:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: annotate linkmode initializers as not used
 after init phase
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Code and data used from phy_init() only, can be annotated accordingly.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-caps.h   |  2 +-
 drivers/net/phy/phy_caps.c   |  2 +-
 drivers/net/phy/phy_device.c | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 157759966..b7f0c6a30 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -41,7 +41,7 @@ struct link_capabilities {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(linkmodes);
 };
 
-int phy_caps_init(void);
+int __init phy_caps_init(void);
 
 size_t phy_caps_speeds(unsigned int *speeds, size_t size,
 		       unsigned long *linkmodes);
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 2cc9ee97e..23c808b59 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -70,7 +70,7 @@ static int speed_duplex_to_capa(int speed, unsigned int duplex)
  *	    unexpected linkmode setting that requires LINK_CAPS update.
  *
  */
-int phy_caps_init(void)
+int __init phy_caps_init(void)
 {
 	const struct link_mode_info *linkmode;
 	int i, capa;
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 1c0264041..7a67c900e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -91,7 +91,7 @@ const int phy_basic_ports_array[3] = {
 };
 EXPORT_SYMBOL_GPL(phy_basic_ports_array);
 
-static const int phy_all_ports_features_array[7] = {
+static const int phy_all_ports_features_array[7] __initconst = {
 	ETHTOOL_LINK_MODE_Autoneg_BIT,
 	ETHTOOL_LINK_MODE_TP_BIT,
 	ETHTOOL_LINK_MODE_MII_BIT,
@@ -101,30 +101,30 @@ static const int phy_all_ports_features_array[7] = {
 	ETHTOOL_LINK_MODE_Backplane_BIT,
 };
 
-static const int phy_10_100_features_array[4] = {
+static const int phy_10_100_features_array[4] __initconst = {
 	ETHTOOL_LINK_MODE_10baseT_Half_BIT,
 	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
 	ETHTOOL_LINK_MODE_100baseT_Half_BIT,
 	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
 };
 
-static const int phy_basic_t1_features_array[3] = {
+static const int phy_basic_t1_features_array[3] __initconst = {
 	ETHTOOL_LINK_MODE_TP_BIT,
 	ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
 	ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
 };
 
-static const int phy_basic_t1s_p2mp_features_array[2] = {
+static const int phy_basic_t1s_p2mp_features_array[2] __initconst = {
 	ETHTOOL_LINK_MODE_TP_BIT,
 	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT,
 };
 
-static const int phy_gbit_features_array[2] = {
+static const int phy_gbit_features_array[2] __initconst = {
 	ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
 	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
 };
 
-static const int phy_eee_cap1_features_array[] = {
+static const int phy_eee_cap1_features_array[] __initconst = {
 	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
 	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
 	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
@@ -136,7 +136,7 @@ static const int phy_eee_cap1_features_array[] = {
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_eee_cap1_features);
 
-static const int phy_eee_cap2_features_array[] = {
+static const int phy_eee_cap2_features_array[] __initconst = {
 	ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
 	ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
 };
@@ -144,7 +144,7 @@ static const int phy_eee_cap2_features_array[] = {
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap2_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_eee_cap2_features);
 
-static void features_init(void)
+static void __init features_init(void)
 {
 	/* 10/100 half/full*/
 	linkmode_set_bit_array(phy_basic_ports_array,
-- 
2.51.0


