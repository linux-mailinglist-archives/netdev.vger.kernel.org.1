Return-Path: <netdev+bounces-165417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4659A31EF9
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABFA1886B2D
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 06:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88071FF608;
	Wed, 12 Feb 2025 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfQ32H2v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53A1FBEA3
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341946; cv=none; b=TSw2U+R0BqXZwPgkBbr8nmR/+XASYnmDH1mXpfSqaPLOxXFK1Rgb5DxfY7p+SV5BhRJ3iTK0LXxIC/BprkhbspOUoayikGB5hNYTa8GO9Ben7+mVmK79R0rBxVgorQmek3SVBmxVzJfs9h72pbBvuc7OXMJ6oR7u8Gaodeo0Qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341946; c=relaxed/simple;
	bh=20QpVWvUkpwzsIzjnZfqaoDaX/8En8lsgOt/fRAU1VU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=OhmMmxstNnuRD8E0G/SHCVHcv6STI3S/TsOik+/J9iJE4o+Nr8OQeB7fVRAdqIpzisOOSDDG+H1WFrtcwySHRHqT4mdRkuV02vPrJXXdKyLRlQH5luwP6NaS0Y17PPp5j0dKisI/GYwFroCgDDDStNv4D4XTOgDfRNK7fbXS8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfQ32H2v; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab744d5e567so89823366b.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 22:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739341943; x=1739946743; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c54Mzn2O0wyzs6HJus5W4wtILQV+Yc6pzW9uAzIPgvU=;
        b=AfQ32H2vRIWRJtltmcX3ucw9fCMrTSW8S5F6AsU+EP02vOmIbtwgSHhplcJ7Awi0ZA
         n8cqW0oYvfQEJ7LAHLaRVkveeGDkVJ7T4FxDtXXxctxKqub7lwKTAV/ll6QBfFBrKZt5
         QMnXWhjrYzzqxbhnbOFPvKuSsxFvpGugyNyIX7zMJ1RPk+e08IlnEyJpbWE2VemSZIia
         4b8g0qRhapqNEdmehXGxXlgMObPw9+vS1pQ8hKUqIJk8hEvw0DU4JZlruZPbrFyhZdKj
         N7ojLAyrfSzgotj2paf5oDyYzu5Fo3nAaFjr2U1r6sHHu5c5LoqnLdstGZ3dEap6zIR0
         FR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341943; x=1739946743;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c54Mzn2O0wyzs6HJus5W4wtILQV+Yc6pzW9uAzIPgvU=;
        b=HT+sEjCeNCCQE3cp8SZXx53l5jWp0wPtPaXkvUGSbAh/9StM+RA/f9NHgrs9EgAvfI
         Wns+tlp2Qsra8CdRKVNQtpLDvBHFbUoQgWtNTII39zoSI/T6K2s/bl0g/IrxsruLt53f
         FE4YsSjb0y8iWbyddT9S5Otm146aWuCH5HChrxBxBaAJkmze5/kZu7pQMB9rcVymu6DO
         dasu25SwIEO/IWKYDNITM5hvnsmk9hlR1trVXUu97DdbKh5uLGPy695ol2ugVGTGKfly
         R9LLbj8M3v9DoWrR4+bzcCqdTUeEmy0WkxbFg+JOgIFJn3oa1ZsSCYzO+ODGps2wXoi7
         0QtA==
X-Gm-Message-State: AOJu0YwiI/HBVO+dOhGgxZN1MVdS5u/rDtaUp1UHKizVznRaBQVSie+j
	y7EOmCV9fktR19OqGNABdDE04KxK66FVnJL0WS6LQz6iIY2zMN4y/Hu0Fg==
X-Gm-Gg: ASbGncsAL6Y9hClmGhE0e46Yd9GEUBP2CKjpW68+nOqKLxYrb3BAeCcfKZtATZRp5WD
	VCxo1WE8zYFGHEwoYDwd8alNbVDpv3FvsSREjdqHhPa0XOI6jOqKhpMhUITrOZNOuPL5h3Vf18f
	NuvfhzBEPJV9yII5OQD5F+oMGnUfktfFX6UiPSOtmgVeTxRLYsbP2K0I3ijdiIkWs1a5sXPOQR8
	o7/RKsI9aJ1PMRNxaYH3kN1TE42dVFoiDlPk9dRK4D4DFl0SKi1XveByERNANx0y0E17bcMfp0D
	918rhvhElqgnd/sO1Cbiv11gDiSCWOshXgIpKpjBnMiOvYUqrhCR7QuqTIHYQXE0+Q9MWHUttVt
	Fy9wWMh3B49wvkL64iICrMePKJktj0vl7PQ1ECMsZI7GVPo0r8HcEg7gjXEvYf47f/CUq+t6TSu
	hgKWxfdSo=
X-Google-Smtp-Source: AGHT+IGQo9hMkNNyD4+bf6FdGp4OlnIjQssKZUE0expmqbrHPpaJOeMiB2p/TvVtzxQ1VjzOWcB7lQ==
X-Received: by 2002:a17:907:c50f:b0:ab6:fe30:f49e with SMTP id a640c23a62f3a-ab7f30f60b1mr140147266b.28.1739341942858;
        Tue, 11 Feb 2025 22:32:22 -0800 (PST)
Received: from ?IPV6:2a02:3100:a541:5e00:c559:b395:f808:a611? (dynamic-2a02-3100-a541-5e00-c559-b395-f808-a611.310.pool.telefonica.de. [2a02:3100:a541:5e00:c559:b395:f808:a611])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab7b4724caesm677441466b.145.2025.02.11.22.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:32:21 -0800 (PST)
Message-ID: <be356a21-5a1a-45b3-9407-3a97f3af4600@gmail.com>
Date: Wed, 12 Feb 2025 07:32:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] ixgene-v2: prepare for phylib stop exporting
 phy_10_100_features_array
To: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 Keyur Chudgar <keyur@os.amperecomputing.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As part of phylib cleanup we plan to stop exporting the feature arrays.
So explicitly remove the modes not supported by the MAC. The media type
bits don't have any impact on kernel behavior, so don't touch them.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- use phy_remove_link_mode()
---
 drivers/net/ethernet/apm/xgene-v2/mdio.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene-v2/mdio.c b/drivers/net/ethernet/apm/xgene-v2/mdio.c
index eba06831a..6a17045a5 100644
--- a/drivers/net/ethernet/apm/xgene-v2/mdio.c
+++ b/drivers/net/ethernet/apm/xgene-v2/mdio.c
@@ -97,7 +97,6 @@ void xge_mdio_remove(struct net_device *ndev)
 
 int xge_mdio_config(struct net_device *ndev)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
 	struct xge_pdata *pdata = netdev_priv(ndev);
 	struct device *dev = &pdata->pdev->dev;
 	struct mii_bus *mdio_bus;
@@ -137,17 +136,12 @@ int xge_mdio_config(struct net_device *ndev)
 		goto err;
 	}
 
-	linkmode_set_bit_array(phy_10_100_features_array,
-			       ARRAY_SIZE(phy_10_100_features_array),
-			       mask);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, mask);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_AUI_BIT, mask);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_MII_BIT, mask);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, mask);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_BNC_BIT, mask);
-
-	linkmode_andnot(phydev->supported, phydev->supported, mask);
-	linkmode_copy(phydev->advertising, phydev->supported);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Full_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
+
 	pdata->phy_speed = SPEED_UNKNOWN;
 
 	return 0;
-- 
2.48.1



