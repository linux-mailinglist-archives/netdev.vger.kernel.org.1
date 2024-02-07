Return-Path: <netdev+bounces-69899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7C884CF2B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71AD1F24467
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884E7F7D9;
	Wed,  7 Feb 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSvbHwl8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D20811F2
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324083; cv=none; b=j9i7O4dDvaQYasRnjZNwnoNKytXOe/0dxnWMlHa1puVNZ9fnoCnNZ8vuaJP55KsrOp9yYeUaxkKjyVSL2941rqS/TajKz0/gk8CVxQgB7LbIZOk4KKVyu+w+be58/rkCrWpoEUzB4SbzyBeEZqq0TIermBpG1MUR2zSLEGu+25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324083; c=relaxed/simple;
	bh=7qSXH5SD3AElk7JxyR6Ym+fGV05zZKenNEUvkSGiMjM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=g5XZYPKan4VrXl5t2kRTpRKGr/w3aFEgOMq5Qbs4E71bHxYvMGB98KG/c5NmmDHHCxodjKUKlXKaa3nRyiuRSItTq8CTG3IAUvkU+nLDV6hwfyDXADasnffTtDUdxnXjeqPzyT5lqG9V3JdQdzxrj27+WCQSvvE5Nvl1zghglME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSvbHwl8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a389ea940f1so32199166b.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 08:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324080; x=1707928880; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:autocrypt:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P2xS2pwUc1q1fScV0ww597RvO/hy3eZucGDZ0AMYj8=;
        b=WSvbHwl8AtuZuAavkq1ztoH3jxY30s8fyOuRcIMiTAZM6eh4c0LoevAUzAzVHJH6Qn
         8BL9klUBuyGER3Ens5ZaVoZr2NmYj5r2JYiKu6fDp62ZGN1xf/Zv158n8fL9iV/Ls2q/
         aNE8ywbDpTWMiLZTmDOjRHKXIeacwMbBVVfB2WgDx6sZVSLlFO3mjFIb/PAO4yxGE58N
         074naPa3KJSpxLJQErZ8AwtWZhKhsGvcyw0dkQ26O49t08nV0baVN3B0Wf7DVjgkKyVg
         qcQQOoowRIPYjK8CZz5Vnagx99fFn+S599nPq6RpEaGc961AyoMLmYMbS3MNiXpwRWmM
         NDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324080; x=1707928880;
        h=content-transfer-encoding:subject:cc:to:autocrypt:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1P2xS2pwUc1q1fScV0ww597RvO/hy3eZucGDZ0AMYj8=;
        b=Pb+KwwDfczVA/ymqCnr7cC/OzE3Y2og5V8+zWo8+CmHnYfA0CU3+wLWZagKKibUYwY
         FeHjgGOfHrufIDc4xLZvgK5vPrIATMpGWhbhliiNr6ssUGhyrrhdFjWIzXR90J0i5J7Y
         0i42Ct27jhmAvp/kZaTWd2HlpgMR68KuEOrSPOECZcJ5awpMY9l85AwZnLA6iMlV+yUd
         PbGfgOFZ7fqu2VC98jAasYPoxeu78V085Hz9tSracDW9aEEhITvx65hdMrteDnzaVa35
         81pSqP8SNzsP9qMkfuGLShb4uVRKk497moBCt6X8HVPRzKsM1x4uwckgAi6UvFK8zJp8
         2AjQ==
X-Gm-Message-State: AOJu0YwAEiaHp/vLPg+lkvIucqYCzglDBbJmV1ESRxjwNpRQPx1jYKYq
	0L3A6Vks/heMAs0cb4OkCBsLWltgX2VBpxcdjEvlYVNyX65tqJc8
X-Google-Smtp-Source: AGHT+IFhV7hRViQF3RfawRCfizWMwtahuHAga/sE0h7uNbuP4JToG2cBLQMJqi+u6wc5jvVnxVNkYw==
X-Received: by 2002:a17:906:4815:b0:a37:3abb:99c2 with SMTP id w21-20020a170906481500b00a373abb99c2mr4728124ejq.74.1707324080046;
        Wed, 07 Feb 2024 08:41:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX02NmFOknFg0lwz86bqA1yYkvGcsmxk2l955p+R/lRfidiY9jBNS4gM8s2C1KtTHp49GZrakk0CP46NJIIHBV7bCU61HBtcgsLlVdYy95K5C6weH9ZmJ+EtSl3zxtpxbOJ6yt1TGNP6jbPyyNzjMFPVmxDkDlFQ7mIx/ny/bDaCr35ruZ6PPlLTKG027Sh8CLExhG47KkSivTHQcoEwB7Eggw63A3+aQ==
Received: from ?IPV6:2a01:c22:76b1:9500:5d1b:fc9d:6dc2:24a? (dynamic-2a01-0c22-76b1-9500-5d1b-fc9d-6dc2-024a.c22.pool.telefonica.de. [2a01:c22:76b1:9500:5d1b:fc9d:6dc2:24a])
        by smtp.googlemail.com with ESMTPSA id ll9-20020a170907190900b00a38a561a4e5sm100021ejc.142.2024.02.07.08.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 08:41:19 -0800 (PST)
Message-ID: <c5a61d57-d2b0-427f-93b3-fcf7721165f3@gmail.com>
Date: Wed, 7 Feb 2024 17:41:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Igor Russkikh <irusskikh@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next] net: atlantic: convert EEE handling to use
 linkmode bitmaps
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert EEE handling to use linkmode bitmaps. This prepares for
removing the legacy bitmaps from struct ethtool_keee.
No functional change intended.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- remove not needed linkmode_zero in eee_mask_to_ethtool_mask()
---
 .../ethernet/aquantia/atlantic/aq_ethtool.c   | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index 0bd1a0a1a..a2606ee3b 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -15,6 +15,7 @@
 #include "aq_macsec.h"
 #include "aq_main.h"
 
+#include <linux/linkmode.h>
 #include <linux/ptp_clock_kernel.h>
 
 static void aq_ethtool_get_regs(struct net_device *ndev,
@@ -681,20 +682,16 @@ static int aq_ethtool_get_ts_info(struct net_device *ndev,
 	return 0;
 }
 
-static u32 eee_mask_to_ethtool_mask(u32 speed)
+static void eee_mask_to_ethtool_mask(unsigned long *mode, u32 speed)
 {
-	u32 rate = 0;
-
 	if (speed & AQ_NIC_RATE_EEE_10G)
-		rate |= SUPPORTED_10000baseT_Full;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, mode);
 
 	if (speed & AQ_NIC_RATE_EEE_1G)
-		rate |= SUPPORTED_1000baseT_Full;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, mode);
 
 	if (speed & AQ_NIC_RATE_EEE_100M)
-		rate |= SUPPORTED_100baseT_Full;
-
-	return rate;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, mode);
 }
 
 static int aq_ethtool_get_eee(struct net_device *ndev, struct ethtool_keee *eee)
@@ -713,14 +710,14 @@ static int aq_ethtool_get_eee(struct net_device *ndev, struct ethtool_keee *eee)
 	if (err < 0)
 		return err;
 
-	eee->supported_u32 = eee_mask_to_ethtool_mask(supported_rates);
+	eee_mask_to_ethtool_mask(eee->supported, supported_rates);
 
 	if (aq_nic->aq_nic_cfg.eee_speeds)
-		eee->advertised_u32 = eee->supported_u32;
+		linkmode_copy(eee->advertised, eee->supported);
 
-	eee->lp_advertised_u32 = eee_mask_to_ethtool_mask(rate);
+	eee_mask_to_ethtool_mask(eee->lp_advertised, rate);
 
-	eee->eee_enabled = !!eee->advertised_u32;
+	eee->eee_enabled = !linkmode_empty(eee->advertised);
 
 	eee->tx_lpi_enabled = eee->eee_enabled;
 	if ((supported_rates & rate) & AQ_NIC_RATE_EEE_MSK)
-- 
2.43.0


