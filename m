Return-Path: <netdev+bounces-222259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB5BB53C2C
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C67AA3C3D
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA2C257437;
	Thu, 11 Sep 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crEP0qiD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00743258CC1
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618348; cv=none; b=NV57iMQ9ShuYWwDZZ1hp+JpHTyorZ52HUI8SmyeLbnN07ookPr5WvAQcLwmXn6afx83S8C/d6QsgV7T3LPz+UmIA4QWWEW8yjXaa7DqnEQkOL2tXqjENMe7VxYj6TVNcDaf1dmAZojKcjrD3Qdkhwvn1LnPCPJqRK2woCpYQJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618348; c=relaxed/simple;
	bh=lmmwM8GFBv1sniqc9+LlbJEcqeWdSV5GhYCCC+cvzEs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tr9+MrYw87WoqSjQ2ffR70XUCwaR6N8dVOdSpnZrOAfrhKM1rlydHksSH/HOGamIj4I/RU7dqsrBtDgE4Q+atDWcB5rqYBR5XxMgBlhH77Lz/2DfeZjnIu5MW90+CYZVkt/RGgY4zx9zzjOhWzay3teAE/YQq+iokx+glUHSBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crEP0qiD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45df09c7128so8837785e9.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757618345; x=1758223145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VYY7MfTJdFRiZUNO/om+69F5l3jLiP3RVrbDhEdQ66w=;
        b=crEP0qiDWY4Bqx3zXgt7VF6BxZh3ll6G9I/KCpR6sN/c9X2ZG3PrUtSSaEbzGi29ek
         139Cn7onwlWhVdGeOGfEsdxWe8mLmJbEqJyNqNfYExAnntsMWUndbqqVt5EO66dqeIFz
         xYUKI1NO4yxR+zCUckxhlhg8UAFnEpn4eM6rezRt+g5xUpxaJ61IocZrXJvUGpCe/xd/
         BBP/arA9iJRCn/ekLewYYyJPMJv6K6pbk3VnCkLD57tWv0T0Q5LyCgiZBWFBLaENnMQP
         5DdsoaInnouDrWVfrpLRxFtZnlORssGzluIjofF1BRMijSOinxju3YUmz1rJFylqnCIt
         vY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757618345; x=1758223145;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYY7MfTJdFRiZUNO/om+69F5l3jLiP3RVrbDhEdQ66w=;
        b=WIoQIRIWqZy0AX9tKEk1BxxgJqwN9jdCFr2Yl4xTEjZqu0yW4AFEPwSVmLWvKz4/JQ
         ZYlWixHjqa3N/a7Fvxf15NY9CgOZUoyVJnrk17cBfD5e3qGH3OC0xrS0EmA04JngWGH1
         NbLzRZlgdIb9HMYGNdlXtTMzESNHpkCMxd+oxRCRZtmE2aPmuEXfjwKSJJ6UoClkvnwI
         fbMJ+uIohjiBnvimmVboHmZPx5El9cNbOg8CC1E9DYApmLJaP+6i5y/MCZGQpXT3sSE/
         6WqXHqBpHWdsMtMkY0D61A5uMGiv10W3y+Ng4xQJr3jja+3d2Yu17bGM8NJx6QtuD6Kf
         ZDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM4xlh9yHseBLGYJJyVi/y64IjhB0BF6xzlngWXZWxpnzpCvjn/7zGaHbSDrBuOmMirV/3FWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9X4z6TPkVjjqdCAF9WP/CcAyd8y/sU2vI/35u/HRbvHU9QFEh
	J9k3XB/rsl+THOAsqGDTvJOntN2irK+bAmchkUxdF0P99yp1vEc53vv3
X-Gm-Gg: ASbGncsejmmiU322OHh7zrWotki9enY/ZmQ2CDe6DVoiYGdPf8YSzF4OKbGfaRu4Tv6
	bD/vdOSUBDL+8/D6EsWkPC5+7FD2ezK6ZmVyQMCEwoqW3Fy7MkEklXtCR+v37MHG5sCpxTHninF
	d14QZ7Ow6YdyAUImSBdyQoD/Gu+rQwDDRgy0UF/CUJU8riddlijUT+VajAVIP8R1dOSwqsQC5PK
	N8/mOON8tPf25hZk3nbqk8DE+k1iG+GHHckCPPwJlXGOZ3M+gUc/i2GW+iU0nzvrDoz+3Cd1O/Z
	uVRLfsEaP6upO6jba+XXHLEGuNorV9qWo+GN3eJS9NhOWAJKPQuDuTa1+BQWL+T/6xkJ9kQs6FC
	7w2kcUBfsLsyOEUjKMtBhLsXfZJ6jFX1TLUabR/SILSTkfeuFpopwqL9URd4J05giR7bvonKq8j
	6lfDJz+OrTg+tnlEIhX4h46nLi+V4pmp/YmyJMASGrANIe8UzD1rAcZrU1W8pLARKpc7zve7mbQ
	EtLh5xvoHM=
X-Google-Smtp-Source: AGHT+IHwIFQNqmdxGhkrEDoBaBpyNJaaCMWXYXhPsEQb1H3viUglpiBnHNSqIbifjV38R3gpfn3ZQQ==
X-Received: by 2002:a05:600c:3e1a:b0:45d:e4d6:a7db with SMTP id 5b1f17b1804b1-45dfe9c6a1fmr38214205e9.5.1757618345084;
        Thu, 11 Sep 2025 12:19:05 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4f:5300:1cfa:4708:5a23:4727? (p200300ea8f4f53001cfa47085a234727.dip0.t-ipconnect.de. [2003:ea:8f4f:5300:1cfa:4708:5a23:4727])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e017b2a32sm37099275e9.18.2025.09.11.12.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:19:04 -0700 (PDT)
Message-ID: <5b3bc68c-fb1f-47ab-a6b0-8980c69fe068@gmail.com>
Date: Thu, 11 Sep 2025 21:19:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 1/2] of: mdio: warn if deprecated fixed-link
 binding is used
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <f45308fd-635a-458b-97f6-41e0dc276bfb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <f45308fd-635a-458b-97f6-41e0dc276bfb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The array-style fixed-link binding has been marked deprecated for more
than 10 yrs, but still there's a number of users. Print a warning when
usage of the deprecated binding is detected.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- use %pOF printk specifier
---
 drivers/net/mdio/of_mdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index d8ca63ed8..24e03f7a6 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -447,6 +447,8 @@ int of_phy_register_fixed_link(struct device_node *np)
 	/* Old binding */
 	if (of_property_read_u32_array(np, "fixed-link", fixed_link_prop,
 				       ARRAY_SIZE(fixed_link_prop)) == 0) {
+		pr_warn_once("%pOF uses deprecated array-style fixed-link binding!",
+			     np);
 		status.link = 1;
 		status.duplex = fixed_link_prop[1];
 		status.speed  = fixed_link_prop[2];
-- 
2.51.0



