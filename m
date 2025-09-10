Return-Path: <netdev+bounces-221866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE63AB5229B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 22:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9BFA012BD
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 20:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD4E2F39CD;
	Wed, 10 Sep 2025 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwCxs8U9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B01D8DFB
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536951; cv=none; b=C51Cldkujs45w5LFl2RF9/lo4OHTvTY2CqGRdAnyCS1hQdrOUljaK2KDkWaCDACPv1HoxcMXgdiW2cYVzmAIX2XycwKUzjNwBvcqjzdMHsi/dXR1ThCqCQIZwprvHMaH77nQC4BBtyaGU693WaSN678igjjXKLqCQmZJ/emFWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536951; c=relaxed/simple;
	bh=oyJu2nN/xlXaarw9dTZYDbo/e4tV1ZLgvVrPJMG6WwU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tNUWQUDm4Ocd3yLj4mq+kLU4VSyk1+OwUf5O0Nc90L2nPPvHQ41a9rMd5pmdy+hzExVUraguBxP6rj1/IH2fJAzb9E7UxmN/tE7eLyzAbPvRWSDx9Dp3WzB3X7QRy+B+s/FsBo6JTlDX5fTLHsfA0l4RuPrPuxC/xklFl3NmuHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwCxs8U9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so282305e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757536948; x=1758141748; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HkySa4Q/fxAkgOvb8psNvQCS3dKjRiHe5bDfTbwB5Q=;
        b=YwCxs8U9eBV6yUqfyXEz0EsRwVW9GEJPX8+xsyKUnyMKtKON89/RUlX80Mo+lgfG4w
         2Dr0sfVYwW8U/6erD//Z8k60j7VK657jGa4gxh1lZBdiqJ4SSwIEhou1KVL3QqmXZj/X
         WkRnf4fb5y80ZLs/DNmtyE2XtDPDVzxDcT/k6Wlowk1PAVRM8zRTwbK5mIRNiSpfx+4i
         Lf30677OevNTKcLqSm3DBz0IFXSzLupOjHKDXn7QXRO0f7Tb0+ZoEGH7ttaX00LYKAMm
         JXlQrjd7eQZa+MG8utiUC+unQwXl3ESTzlG9zhgLtqPRsd4freoTAhtOhZiW/98I3IWJ
         HQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757536948; x=1758141748;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HkySa4Q/fxAkgOvb8psNvQCS3dKjRiHe5bDfTbwB5Q=;
        b=KMr/HAIw2WYAnjQgVjvrwZvHG2T1OKMFSKoWNLG3z7c1uJJ5erf2NFhiQsz+TdGmqo
         OOx1Oua3kK0MMlsNUVkQmuJ9cOIAL0HMny9VCsziT75BRvszGscFZ3O8su7aJT74qFSx
         bwQyAMzS/4ey87tNZ2N/rxjFWNKPoAMk/oSUzFKDT54GeFz2R3ALgfzQi/1U3aMwNAS0
         CWrmnYvIu0JdJKd2YNtFA+bccKT4lAHiCBbpYJ167Y/fXsUHVWONROgFojXn5wl4OITa
         jSeYm78pXImGSvw8fv6x8WQwVs/xB1DKh9NwZENOwNu3PwFWhoM1TsCY+SidI+/DyU+L
         fioQ==
X-Gm-Message-State: AOJu0YzRbD3ew/YFpIGgH67bp6U6n8MCPLqnYW23qO1zr3hjISBbDhC+
	7N62io9B0rfrLSzuTCr9YRmUERrZL+8gjQOPH+v5ofc+zDNeu5B5BSRf
X-Gm-Gg: ASbGncurvtFHPecIXPOgUdOqWVXO67825WQyasBD5sakXtc3k0sjwA324hWNSHACg16
	ST36G9T7Y6hzJLNdsisAAbIDHSPj2gmf1090+dn63+2ac9hj9K007SFAkhXs/ePDewAPm/AEKWO
	rtlQtyHHFRNBHG+HBBVj+7bLWlSuNGEQbVo3VU+QP6CwrObqopjWs14r3gO+EhL2GK+VnvXNmKB
	kfvclGPfGyMstVMPxWsAdZ06QdqyEr3lF/W1bZ23fxRlT3qkVrwtnCdCZVePM316Zz0+GbslaCw
	TLviEdDRu2AjpxV5VC2zTyLhLtu656VwoldAL2O9+DcSeX2BK2ZJddAVsusnXvi0ffhHrUrcQHO
	5vm1L3ht0c/n3Ej4pQ8x6kxsYztv/ta6qNYhwuZqlGY470rt1HgF6LYK6Xx6YUcIt0sXL1d935O
	OHH5SfFt7++5/05rl2WPR5mZUznm5ExaAqF88YNWT2VUTaweE6TJK7aBsp/tL4KQ==
X-Google-Smtp-Source: AGHT+IHHQGyB2CkeZT4Z960ybCvwlnGOb7qmRPV8uViXjFIhcaBzYL3WkV2sxarZ3WUwUVEoimeAiQ==
X-Received: by 2002:a05:600c:630e:b0:458:bd31:2c27 with SMTP id 5b1f17b1804b1-45dddee9c7fmr139723455e9.23.1757536947478;
        Wed, 10 Sep 2025 13:42:27 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f22:bd00:fcb7:a9b6:f3d0:8b88? (p200300ea8f22bd00fcb7a9b6f3d08b88.dip0.t-ipconnect.de. [2003:ea:8f22:bd00:fcb7:a9b6:f3d0:8b88])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7521bfd08sm8062056f8f.4.2025.09.10.13.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 13:42:27 -0700 (PDT)
Message-ID: <8729170d-cf39-48d9-aabc-c9aa4acda070@gmail.com>
Date: Wed, 10 Sep 2025 22:42:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: fixed_phy: remove two function stubs
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove stubs for fixed_phy_set_link_update() and
fixed_phy_change_carrier() because all callers
(actually just one per function) select config
symbol FIXED_PHY.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/phy_fixed.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/phy_fixed.h b/include/linux/phy_fixed.h
index 6227a1bde..d17ff750c 100644
--- a/include/linux/phy_fixed.h
+++ b/include/linux/phy_fixed.h
@@ -37,16 +37,6 @@ fixed_phy_register(const struct fixed_phy_status *status,
 static inline void fixed_phy_unregister(struct phy_device *phydev)
 {
 }
-static inline int fixed_phy_set_link_update(struct phy_device *phydev,
-			int (*link_update)(struct net_device *,
-					   struct fixed_phy_status *))
-{
-	return -ENODEV;
-}
-static inline int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier)
-{
-	return -EINVAL;
-}
 #endif /* CONFIG_FIXED_PHY */
 
 #endif /* __PHY_FIXED_H */
-- 
2.51.0


