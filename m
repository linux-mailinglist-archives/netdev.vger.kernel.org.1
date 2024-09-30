Return-Path: <netdev+bounces-130570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A669B98ADB3
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA321F239EA
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594E1A0BFB;
	Mon, 30 Sep 2024 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6ZVEI2n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FC71A0BDA;
	Mon, 30 Sep 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726620; cv=none; b=CeWalPZ4lQktRD5xgSmeub+dEEA/hR4kZvjO2ArHS/DRb510kQBfOfteYjXnbN6fW7psDweVAM7hlpEVRchnsEbz/UBEAsHpAmL/upRU+I39FqQI3BvlLDC6chwzxHcujhN/Q/E8ecrUrm5Vcqx9Kej2gTd5pp0RTfpCsVs52YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726620; c=relaxed/simple;
	bh=SdWNxiW1a33gv3dEjg3cIUhOf0p4uT9vq1QQloiGxG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mQLNu/qLUh5Pw+mwNvRvIfRsjzqw3+XcgXdRxh5HgZqs3HDPyr2Ut3Uai46DteJWbfIt+5xImt4bWxags+qv7geMpvpevVAJ+VRq6/0rCrT0Wda82vXbR8xwma2tbkgh52KUI1TLgq11sJXOPU3kc2Pt2/ZC2Rx3EtM48hRxpv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6ZVEI2n; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so44068855e9.1;
        Mon, 30 Sep 2024 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727726617; x=1728331417; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sqtZ/31Yy7RoVK60NTWtW6OUtzrXK53h8wt43cKuCI=;
        b=V6ZVEI2nw8xB0EnEbBEmUP6irDwJdW70k5sjzzlqhwFDcZnbcK7vn46zBI1GCfL16H
         28m+Cxa+/UVX3K/x8UgH+Bz51+3PRmTUN/zW7cBICPqwYv4LGKepS/s8RGc7wRIBgy29
         E9Sdbd1Vw/SChhw6Hl3R8F33Cn0gLC34xksyiqkTO2Yfw04teUjoXTJhvS9SCwANI225
         CBjHjLoOWZO1WBKw90DBuVj3MIleXHbLcqax1ZzIcTY/5KAXdNT+36HFMKkhmpkWskax
         E92Ckxx0T+FUFwQ28PzsAcnTjiEy0aP5t9dubsVQIiXG+FcXLgIymCttio1sgwy5KX0O
         q45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726617; x=1728331417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sqtZ/31Yy7RoVK60NTWtW6OUtzrXK53h8wt43cKuCI=;
        b=Ikdyxv2BE16znmp/Y1LAlpBmvTqDkIKDEP3zbnJixnESdaimGEBB3a0grVQbN46QMV
         ZPkHbwy4eZFz7hOTMF8YPNtSlwFKHurAG2E3TsHhvxoQnfV8Z3xou2MxsijERDXjT/ij
         MGvKUDDFK0EizC4ikWUTaxX9hA0efQCHq3c3Av3Odm1AqEwjsppnhEdGvJUwT9Ve8wCm
         rv35WN7lDRjACWwO85oIDTZzqqfoPbzrtAe0X+eBxD/unA71Nie0NG+UF/kgpZ46ea2N
         T6JeKRFZ+0uqxC8X8wn1/4BqKfF2MXlhb+3GClS2rjFfdYXzxXSAmBqy1lZP5+d/5Vt0
         yvJA==
X-Forwarded-Encrypted: i=1; AJvYcCVXxUHNjSOPLvxGroU3Ex7ndCPFT1HtYFUJL2LR7lLEzyCao4hlrT9oHCriVXnzuI0Oj3HFXsmOy3U9tes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHHp6/Cqjnq31pr7pOdb/hpio9H6bEjH7PNgs+dt/43KWeCCuz
	OjArV1Zi0tL9UOR+ZnEuqYaj+Zkye589MBYYpWxxLvaC8ELSqZNv
X-Google-Smtp-Source: AGHT+IHyDpJZAsP9L4afD9qdQC5EpU03DAwOfUju88L+kABFeUBfItj9Qxuyx1WNxS38Wg1b1ZZdGg==
X-Received: by 2002:a05:600c:1da6:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-42f584a2dd7mr102005795e9.30.1727726616787;
        Mon, 30 Sep 2024 13:03:36 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36760sm162591215e9.30.2024.09.30.13.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:03:35 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 30 Sep 2024 22:03:29 +0200
Subject: [PATCH 1/2] net: mdio: switch to scoped
 device_for_each_child_node()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-net-device_for_each_child_node_scoped-v1-1-bbdd7f9fd649@gmail.com>
References: <20240930-net-device_for_each_child_node_scoped-v1-0-bbdd7f9fd649@gmail.com>
In-Reply-To: <20240930-net-device_for_each_child_node_scoped-v1-0-bbdd7f9fd649@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727726610; l=1729;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=SdWNxiW1a33gv3dEjg3cIUhOf0p4uT9vq1QQloiGxG8=;
 b=W31MMQTY6MhpSYx2RAf8Jy6ryidrYwcEeuouGExz1hyC5q7/EXiDbtqar3cBPj5VusubJkyiD
 7bvWP8CRkZsDdbP7CLklvOL67/k1J8QRg9BPSzyic9DWxZhZ6g8uQsH
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

There has already been an issue with the handling of early exits from
device_for_each_child() in this driver, and it was solved with commit
b1de5c78ebe9 ("net: mdio: thunder: Add missing fwnode_handle_put()") by
adding a call to fwnode_handle_put() right after the loop.

That solution is valid indeed, but if a new error path with a 'return'
is added to the loop, this solution will fail. A more secure approach
is using the scoped variant of the macro, which automatically
decrements the refcount of the child node when it goes out of scope,
removing the need for explicit calls to fwnode_handle_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/mdio/mdio-thunder.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-thunder.c b/drivers/net/mdio/mdio-thunder.c
index 6067d96b2b7b..1e1aa72b1eff 100644
--- a/drivers/net/mdio/mdio-thunder.c
+++ b/drivers/net/mdio/mdio-thunder.c
@@ -23,7 +23,6 @@ static int thunder_mdiobus_pci_probe(struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
 	struct device_node *node;
-	struct fwnode_handle *fwn;
 	struct thunder_mdiobus_nexus *nexus;
 	int err;
 	int i;
@@ -54,7 +53,7 @@ static int thunder_mdiobus_pci_probe(struct pci_dev *pdev,
 	}
 
 	i = 0;
-	device_for_each_child_node(&pdev->dev, fwn) {
+	device_for_each_child_node_scoped(&pdev->dev, fwn) {
 		struct resource r;
 		struct mii_bus *mii_bus;
 		struct cavium_mdiobus *bus;
@@ -106,7 +105,6 @@ static int thunder_mdiobus_pci_probe(struct pci_dev *pdev,
 		if (i >= ARRAY_SIZE(nexus->buses))
 			break;
 	}
-	fwnode_handle_put(fwn);
 	return 0;
 
 err_release_regions:

-- 
2.43.0


