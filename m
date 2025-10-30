Return-Path: <netdev+bounces-234517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B3FC22748
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 22:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3514F4233D3
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 21:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10564314D24;
	Thu, 30 Oct 2025 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELFpy20B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F792C2364
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860790; cv=none; b=btJZYkKYBCVurge2P0PoSq2EAEoB1LXFmlvr5e3ab10OZsGXUtQkfZu4YTUY3xVAn+qgTJuRHBezS23CYY34I1ZR+dZBCo0+6lhtozVeFoqNJ8DvaUIKTRXWDLji57M9zsBmC7lUZBI7/sRNOawr4BfhdxKvh+psXiqVMzNq/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860790; c=relaxed/simple;
	bh=ogoAOc8noYnRP40EX7FiNgpoMABPPHmz1IvTtOqk89A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qOlY40DYA4z5KyYOsZqYa/g4eQM/3h3BYFfwlp8DxJqG5n0jiiLj3OvGpuR0EhN6Vricxzb869aYo4ov1581iTTxGJpi299+DVmEZKED3ZRNPoBWn4utOf1bjybiTIOv7GdR/WmwHztoAKFzd9yAuEqyiWofJf/cIJhlin0qfWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELFpy20B; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso435921866b.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761860787; x=1762465587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e2bmKsWX27KxcoODJGcbcMlZnZNIE40/bwILX8cp33g=;
        b=ELFpy20B4Debi7/9dj33sL2VbcfQCHr/v+fWcXiyQOHShZ7GB6Kv+9JCGtkx4kIZjP
         RRrUkZdl26HsF6V7QW2FxRgrVGQ5UVdimz5P1kfrSiwLGzy4ZDh4apPFErU/cXo+Nkq2
         /vvFiUTrm6JCab+EQiVB3iVGOivHvm4/JLZUlHPfUPeQ1KzP1bYlzVHNRtiJcaGZqbMZ
         yBHKa2SNScXK2+TF/aQC4pLSsqhtGRCMKu1pMET60AXo0bWez4odkiZbDD1Z6XLICIdp
         Go1hQ2SxC4mIq1ERKwwduNZ3TvNF89BWvVD9vsgxzknOwhjiyKM5W339camuhUJCA9T9
         vKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860787; x=1762465587;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2bmKsWX27KxcoODJGcbcMlZnZNIE40/bwILX8cp33g=;
        b=LmAaVq+Sf/5PudELBhLOqsvLndDpZ2FVcI2xFHRfuveaF6f59V1CxchBCzJkpo9nUp
         vzr9Y5H5glQE7/33esACCDZ2WTgVscXcaJ3Aw8LeSZCNmJ5IAVU12lri+Vxox1mfFwI3
         Vko/xc9PXjPWPud7HlV8Gjn7pjW3avK2T06TNZ4ybtjy0uZbpIgkuU87Q/R5ePi2OOGi
         f3O+0Xl5Ov3XZxLm5FmTneFlH1JQMiLE2o2lOklP9vOhvYi28D+9OhkYxgzeYfRDR7gc
         GL/PyQZzsmeCzu4aReLCY394LNd3JHLMVD71q2EsWxAisDfPBIKDJgys6w6FGO8Uc/tW
         KgcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMvuw/rpjlfoffq9x8Mn5/Cee8kXH05RyYKSPQVLpW9zObyOY7Z2wTCBH3tnjuIGc37xD2o1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6nje2kDcB7vr1riIdpeB1O+mN/CSAZAePtsfdOFSRm7cKWzC
	pOny/GZBlSKcEbjr8al4/Lx1ShUj57bgnH1yhPRE3lfLY9o+vPRzbjsh
X-Gm-Gg: ASbGnctCNWIg8SYx7xDEPWn+2BhaweAhtcZpWuQR4RVoKZClW2bjRuz0iqwXIxM+usx
	10l0nLNmkyrXBpuPdVuBhB4LoYrwKDQHzF2yAt3ihe9uShaAlTtGJLJjptSO/Zl0S58YR2bBEDx
	nsqE4lK+LyxBt8p7fDeOlzZ/+/vEjBv8VBlvqMQaPqxVg3GLZ86gSAocpG5ROBkchrUe4TBshcd
	fBs5OP30+Qxx3HBMewc1NJybRVrPWWdXXyi8K4vm0P16Ql1P9DGn7FUKr6RbrDlB5UzWaVhbVCN
	e8QqpW1mrQf9o/UlzY6eIugLxRyTOAd1LzvmGLu6S9k9mNqAp7ea113N1PsFKBUCI3iFYTuLdXE
	RXeEvAPAtM35p2ubvdcn7BCEIsFqxVAs9hClxHlrCbx++v6S1rlhu41FsejWW833IqiGZFZ9D62
	RoYXDN8uqlgAg30CP4g2nYsu9NQMCgsJ8MQA6EX86v72k6slnLlJyTSq/0C7Tqx1uO21banzSux
	Aw3FB7asIsqnmsWmAzOP7zO07iW2ttXqLGNIU7vCSnLSxP7Gs/QGQ==
X-Google-Smtp-Source: AGHT+IHttdY4o9D7grpTruZsKEHKhDpt1ULxInoDSp8EgrLjir/7gRBnIDXS9Eo/IhcDhnQCnC8tcQ==
X-Received: by 2002:a17:907:2d25:b0:b4b:dd7e:65eb with SMTP id a640c23a62f3a-b706e5833c5mr157151366b.25.1761860786678;
        Thu, 30 Oct 2025 14:46:26 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f48:be00:f474:dcfc:be2f:4938? (p200300ea8f48be00f474dcfcbe2f4938.dip0.t-ipconnect.de. [2003:ea:8f48:be00:f474:dcfc:be2f:4938])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85359687sm1864847366b.23.2025.10.30.14.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 14:46:26 -0700 (PDT)
Message-ID: <bee046a1-1e77-4057-8b04-fdb2a1bbbd08@gmail.com>
Date: Thu, 30 Oct 2025 22:46:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 6/6] net: phy: fixed_phy: remove fixed_phy_add
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Greg Ungerer <gerg@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Hauke Mehrtens
 <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Chan <michael.chan@broadcom.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <0285fcb0-0fb5-4f6f-823c-7b6e85e28ba3@gmail.com>
Content-Language: en-US
In-Reply-To: <0285fcb0-0fb5-4f6f-823c-7b6e85e28ba3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

fixed_phy_add() has a number of problems/disadvantages:
- It uses phy address 0 w/o checking whether a fixed phy with this
  address exists already.
- A subsequent call to fixed_phy_register() would also use phy address 0,
  because fixed_phy_add() doesn't mark it as used.
- fixed_phy_add() is used from platform code, therefore requires that
  fixed_phy code is built-in.

Now that for the only two users (coldfire/5272 and bcm47xx) fixed_phy
creation has been moved to the respective ethernet driver (fec, b44),
we can remove fixed_phy_add().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 6 ------
 include/linux/phy_fixed.h   | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index bdc3a4bff..d498d8a9b 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -131,12 +131,6 @@ static int __fixed_phy_add(int phy_addr,
 	return 0;
 }
 
-void fixed_phy_add(const struct fixed_phy_status *status)
-{
-	__fixed_phy_add(0, status);
-}
-EXPORT_SYMBOL_GPL(fixed_phy_add);
-
 static DEFINE_IDA(phy_fixed_ida);
 
 static void fixed_phy_del(int phy_addr)
diff --git a/include/linux/phy_fixed.h b/include/linux/phy_fixed.h
index 08275ef64..8bade9998 100644
--- a/include/linux/phy_fixed.h
+++ b/include/linux/phy_fixed.h
@@ -17,7 +17,6 @@ struct net_device;
 
 #if IS_ENABLED(CONFIG_FIXED_PHY)
 extern int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier);
-void fixed_phy_add(const struct fixed_phy_status *status);
 struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 				      struct device_node *np);
 struct phy_device *fixed_phy_register_100fd(void);
@@ -27,7 +26,6 @@ extern int fixed_phy_set_link_update(struct phy_device *phydev,
 			int (*link_update)(struct net_device *,
 					   struct fixed_phy_status *));
 #else
-static inline void fixed_phy_add(const struct fixed_phy_status *status) {}
 static inline struct phy_device *
 fixed_phy_register(const struct fixed_phy_status *status,
 		   struct device_node *np)
-- 
2.51.1



