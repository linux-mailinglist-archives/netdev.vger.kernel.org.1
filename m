Return-Path: <netdev+bounces-165681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FCEA3304E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD343AAED5
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E9F200B98;
	Wed, 12 Feb 2025 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsLRD1T1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDAE200118
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390478; cv=none; b=D+uuHcUzsmtXnGnJKqKzAlcA/5bD0lAPy99hQLtSZGPjgKIOFzR7gJ4RHJNZNNgASFjveXbTibA0GlBxXdD0lCFWZSnw9cULI3LPGDElu8vey2U22YYwdo+44t/bkavcNdAXgtJPao5b4V/i4VmqdXXtkVX+wsCp6jobK9m03+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390478; c=relaxed/simple;
	bh=BxyP9Yu9zGkJCsCEz/N0hZMtusP0NDeqsVirdnO2qVU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tdeyppQ0spbqvO//Fb3e3pQhhEa+wvhtMgo6DrsRUC+WLLTxOQXGrZl9wHpI3MrCq+fFkLAMQ2kunXLxdCF6PwDhv9ar+VtcwsGRxXNttF7k/9AYVqY5KfVIizgnkSwVTsSGKYLlmD5Wd+lGqYWvlDyCfSIK4NB3e9vTuqYu+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsLRD1T1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec61d0f65so38929966b.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 12:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739390472; x=1739995272; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOjuQcl2Bz7E7OUWyZuOSd3RAQlQYlq+r9V852JY4tA=;
        b=nsLRD1T18pq+4wdFJQChYebwTD2eirlVsWj0W4XP3Y0GJgjGEcVclaPaSHHr4csVtX
         ALtDQxXn8Ndp2VWo1t0m6EyNQmjA2UzhqIbpf9cQ77vmENVxCxm5FMxBJvsToNfbgrI8
         q80ULUyIgR+I2Tk8dGTMLx6+6zKuyE+VOX1gkv7WoO79VgK+Ivl+ETdy0XRzwgw5UaRl
         yVUc3R9bIqNeKheHMMT27g/ATFsrOvRoBCpXKkPLEMpIa7QWvF7sCfBCibt5x9eQyIhC
         JT618PhJhs14m9sh16IDkRMmgbB6DbhrJ8HYdcsQupQr4PM9LhKBdog0Qb9a/c151eA/
         NHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739390472; x=1739995272;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOjuQcl2Bz7E7OUWyZuOSd3RAQlQYlq+r9V852JY4tA=;
        b=dN7KVU3CWtuYoOOgSEWaGKYlx/djN019TO/0ugQ7CPqLMlejsL//P41K3B4mk2cmw3
         Bm3U9qVoC1bCinrZ86e5vl5FABmb0ciRZNjKylUjSPPll39ysm02dy5KnTVnlOJPF1v5
         LcYfouYxT5KqSwYMWcZNX/JpW23TzKTBCWqELWyT7hLGTBZv7RLPxzul0gLpioCYy9gE
         30+9y5utGt3MeNfw+Mzd+pqo2LwV0J42/AeWAGwt7326Lf3n/bZ7+KCw1NiMT1GpfAOl
         /utKqu35bptmrxXzJdT2BuAYq18q/vXoZIP5J9duyCsDmETn5bPHDnCGQQOaNrGJog7I
         YWgg==
X-Gm-Message-State: AOJu0YxGqA6FXQlV59UeUWNxmQVFASFRjEF5a6ijgw1gQlWQ0BzY+c8W
	/PwPR+MJ/eSnn2jbCOgAF1n9GFxhUqWD1QQmWJya+C+up+9hUwD2
X-Gm-Gg: ASbGnctD80K1OjapcAZgK6H3i9/IE5Y+VYff5EUbuXb+7OcfXue/0TKVMPomd8PxNsb
	9Fyohv1gBmHpOua65ViK9Wjhu3V56444ZApiSDb2VvThy1eP/lxi6HoqqK45Y0JTc3sAxAaZz/U
	UxrSW1nzVAUzlTDv+L0BodUgQtpCm9alw7SUsF4aUuTwgiZGtG5CegOp+o1TNbuVd2dF9r3R2TK
	F6oNeAUVzP1qunafviklUdvFJwAFS3xF8YAcfF5isgPOMotetZIVUZIqum3AU5xSO5p7LzK8bLw
	3KDhbhQTJQUiAqlJS984BTt717UOVZ/CzELSI7ppx2eKZ4DS5zdLyZ1lW8YsYOaHz78VfHHjyXU
	PwEZ/iGdwwi8FswxNqFZ0Si47vncO3VzCZELR+bgVx/Kc3vaqF43bU68vk5u83q/ZnV4oUnOFGI
	shUx0aKX8=
X-Google-Smtp-Source: AGHT+IHjgBlAAW621j5dIORvjMuq4oxxmRHEBDEpBeErI7SXmDFcTr7nRIz/my2AE65hcX9wPwW7ow==
X-Received: by 2002:a17:906:6a23:b0:ab6:dace:e763 with SMTP id a640c23a62f3a-aba5017e5d9mr40229466b.38.1739390471443;
        Wed, 12 Feb 2025 12:01:11 -0800 (PST)
Received: from ?IPV6:2a02:3100:a541:5e00:31d9:eadd:df61:9cc7? (dynamic-2a02-3100-a541-5e00-31d9-eadd-df61-9cc7.310.pool.telefonica.de. [2a02:3100:a541:5e00:31d9:eadd:df61:9cc7])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab7bf1d8aa5sm695384466b.62.2025.02.12.12.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 12:01:10 -0800 (PST)
Message-ID: <5187c86d-9a5a-482c-974f-cc103ce9738c@gmail.com>
Date: Wed, 12 Feb 2025 21:01:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: c45: improve handling of disabled EEE
 modes in generic ethtool functions
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently disabled EEE modes are shown as supported in ethtool.
Change this by filtering them out when populating data->supported
in genphy_c45_ethtool_get_eee.
Disabled EEE modes are silently filtered out by genphy_c45_write_eee_adv.
This is planned to be removed, therefore ensure in
genphy_c45_ethtool_set_eee that disabled EEE modes are removed from the
user space provided EEE advertisement. For now keep the current behavior
to do this silently.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 468d24611..2335f4ad1 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1525,8 +1525,8 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 		return ret;
 
 	data->eee_active = phydev->eee_active;
-	linkmode_copy(data->supported, phydev->supported_eee);
-
+	linkmode_andnot(data->supported, phydev->supported_eee,
+			phydev->eee_disabled_modes);
 	return 0;
 }
 EXPORT_SYMBOL(genphy_c45_ethtool_get_eee);
@@ -1559,7 +1559,9 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 				phydev_warn(phydev, "At least some EEE link modes are not supported.\n");
 				return -EINVAL;
 			}
-			linkmode_copy(phydev->advertising_eee, adv);
+
+			linkmode_andnot(phydev->advertising_eee, adv,
+					phydev->eee_disabled_modes);
 		} else if (linkmode_empty(phydev->advertising_eee)) {
 			phy_advertise_eee_all(phydev);
 		}
-- 
2.48.1


