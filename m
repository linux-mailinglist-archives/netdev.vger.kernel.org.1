Return-Path: <netdev+bounces-182999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674D6A8A894
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39861888D3C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11BA24C091;
	Tue, 15 Apr 2025 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqakFdZX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2E23BF9E;
	Tue, 15 Apr 2025 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744746954; cv=none; b=V9oYsixp4lQGJm2aod0QlGbR1AtKtVuQ8W2cssC4PZSQZXJfH1/hcpZqdnHDASmbhZhYv2YLPgVpGbQGwsXZmEbzi/wgt/4YTHL0TOxWC/lUZQ28AWNUSt098fpuqjm3dDCMGu0fclMz81ah4XAapZPEMYgXewXSMw6kLov6hG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744746954; c=relaxed/simple;
	bh=drwZq6+XjcFfdQgjfSsWJFpeRvSGLkx15VE6RsfiAoM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ja9nQqFu9AN29bCgMQmyUbIdRmjrhHQroOxiDkVGABP80tOgs9hn+SokoSZrbD1CfWQLqIaTVNUTSykAsVxQc8+21qSfJ2RXMRacv5dsjIYztfwSvrH6oxsmkT5pUf+6UMGk2+iDspDjI+OioUkLJ+v5DgCjTgNIE5fSiAZsxzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqakFdZX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so10301185a12.2;
        Tue, 15 Apr 2025 12:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744746951; x=1745351751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=24eGq745trMi7DLH7wnbuipeprm9E1i5dvl+9M3/O3E=;
        b=UqakFdZXQSld9ZIgvR+/rjm00xiQQMTseN8MFddAkUJjoox0O6XanYK19Tj56LFBzz
         r+dO+4+aZKZlpVc6ljSEhEHfZym/3EosR8SO84vOXhslgxNAF3TzDeti5cRyrb787Wcl
         6La2Sxz0vfbzpuRgl5L06RkvcfKN25RO/YhPTZ+Nhwdw1W9VSK1sAcSX6G8/1nM0PtG/
         g7pheIdiJ4uvibPAxDJ2j4yS2EPDyzbtE3HURy3iO5FLWKCt2IVj9eJFE2uphuzXlfvc
         WSg05mGPZuQ1k3wiWw+AWWJdB+amGZtJW18XUdYFni2eN6qSq5V9OwDuegew105S9AMo
         fICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744746951; x=1745351751;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24eGq745trMi7DLH7wnbuipeprm9E1i5dvl+9M3/O3E=;
        b=bhWF2NgVvVxHrlmi2T7C2RKHPyOrbPZUGv41MX5ZgIMtt+2CbvildWeLUdOkHSriz/
         tsKtDx5FzmkgnkKZ3VV4rt/7sgbfbYXbR6DKwoCJlC/NBNLQHAe0K4aP9CjOk3KIo/2O
         gH1zbRdrO/fm972YMfbVSuchcWIkpLQ99wQNTvdFbLeLtqo4ZJhGL43HH79vgUqS8QTt
         OG57xNFRnQ4o/Ya9QtPU6HUeb4v3uIgYH0+W/aZQU9xmIM/orI499jxOWydkGpXwu1Cp
         VhKpf4qtpByuwTItKFM6+yOcQoB7DoDfUs1zml3HbD2C2lBb9qegBQpjCR0GLY1ig7yc
         I0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGwIXMYTT5QOAg1BRl2oG42lSBUdQ5y4Xu6B6hGdJC9EEDaG/o2zHxcFUvijuo/l4O4E02lWQ8EcBS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe3cVXROP0uRon++nMVgZs74WtIdsEmozIYS+bubawTIvCuviB
	728+m/jyfFAcjbmD1vQlAlKmrhUzZIgK7IY5gSTyfP1vE/bfSVEu
X-Gm-Gg: ASbGnctzkW9J1Sp63SrycDR2D16ilz16gu2cm2Z/GkJfyUqm/MZVqB6YdmDMWJ/G9E9
	wjij/n9/CTEcuxCW6PMM4eXULOHRNDHR8nGhbH12AC3JmK6FWP72WAwNEcc0ig292x8aXiC0rLh
	OEDxBEqukSZ+0kBxHvHTgyxiAVg+1427hTkcQxh7l+VRWq3NFze0MveRoedR1ip6Sg0FyJZgMcm
	NwAZc5g2MnJMVWbnW1B1m+CvUC0JmGr1qkI512QQfsWratMzWAYJLTVkR18PhCdJ+UzF38mnKs/
	y7Y9DAJOYTfhOQ8E1v3la3E+W25w6ncFHrRWmpLzn/cfARc/G+nlkp/7rMkRLjZ3rNW726fAIej
	NrTXhCWW4GKXOFfpudH0p5Y5tSmomb+Uw6V+3035KzBihM/4h6mu4trdwpBL+OcbVnf3Y5DUqwQ
	60IjbR9B59W8xuae5u9tc8cgedG7y2hG9nhMXcsbCXDyI=
X-Google-Smtp-Source: AGHT+IFG9Dh1DfDG2PR4Zv7wz59IhPGMdkuYi45w1adPff0K/k9SHHmS0GNpXIV81vkjsaQ7lZChig==
X-Received: by 2002:a17:907:6e9e:b0:aca:c699:8d3a with SMTP id a640c23a62f3a-acb38262c8cmr26538066b.22.1744746950846;
        Tue, 15 Apr 2025 12:55:50 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9dee:8100:1d74:fdeb:d1fd:499e? (dynamic-2a02-3100-9dee-8100-1d74-fdeb-d1fd-499e.310.pool.telefonica.de. [2a02:3100:9dee:8100:1d74:fdeb:d1fd:499e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-acaa1bb3553sm1155658666b.29.2025.04.15.12.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 12:55:50 -0700 (PDT)
Message-ID: <b3c96dcd-20ef-4ff4-89d0-f2aedd4b7a18@gmail.com>
Date: Tue, 15 Apr 2025 21:56:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/2] net: phy: remove checks for unused eee-broken
 flags
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <ee9a647e-562d-4a66-9f9b-434fed05090d@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ee9a647e-562d-4a66-9f9b-434fed05090d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These flags have never had a user, so remove support for them.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index e177037f9..2a443d029 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -209,14 +209,6 @@ void of_set_phy_eee_broken(struct phy_device *phydev)
 		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, modes);
 	if (of_property_read_bool(node, "eee-broken-1000t"))
 		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, modes);
-	if (of_property_read_bool(node, "eee-broken-10gt"))
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, modes);
-	if (of_property_read_bool(node, "eee-broken-1000kx"))
-		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT, modes);
-	if (of_property_read_bool(node, "eee-broken-10gkx4"))
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, modes);
-	if (of_property_read_bool(node, "eee-broken-10gkr"))
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, modes);
 }
 
 /**
-- 
2.49.0



