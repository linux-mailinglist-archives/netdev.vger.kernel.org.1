Return-Path: <netdev+bounces-157455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE0A0A5E3
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97F3168781
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2841B6CEF;
	Sat, 11 Jan 2025 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMP5sevT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32D1799F
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627234; cv=none; b=inTQZP53YZN1nnDYrTLeglOLpp/xenB4fKstUiHY3YyHGJCPI6IFKPlL/dNE8nZg+wh74qnR2Wbs7GeCxdy8rA98FLiK1EfNbqLezVyxjRCbJ3Z2J5yz9XlNqE9Ds2vaJYxkw5K52fGxzLAAuyOB1dNHR9moYiWQ2OdMo+lOf38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627234; c=relaxed/simple;
	bh=YCB34JLlQkpPUu3q4HB+ePRyc7u3+yMm46le00milnw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ExAJvFqeZeOmuxqyQ4eUZ3BG3LyPkLkTQZ7uxgC3r9jce+QFGEm7eHhGgkPtCVS7QgFzsQf81KSKOl+Mjs2HRvATVR2knnXZ3dCiC7LQyXFaadGLmzTHhZbCvT21k5MmZng7BfHJr3An7dwtOkIoYhM1+PAUA6uEOYoAKBjpVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMP5sevT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso5426453a12.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 12:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736627232; x=1737232032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B/FpL7CmJTe1W7DtWMGgO7HVASN54rPsnRzFSSP0ZVU=;
        b=lMP5sevT2yHGmUkhuI/peAMALvt/YXYsOK89PWhtWq4Ur8y15fpXvSkPNwiSQyPgiU
         o53sODdGyA8N0xHgaZvU+5YFcWC6tLRp94WONvp2GyscwSq15/Kyi4F6cgbwel22jKBj
         5TkKoP7Bc38xysK1NUr/diDpKJuoJEPt9CUz5fm2Rv8X8ly9WxlOxt2s6taK6zngrRus
         uzm6eqa24jmK/hMIH6vSrgyYq31GMd4IXvkYgKqb8fdxizXgqhxxDZYL2nXd7TYsF34p
         li7rdX54MNqrZnOVBUrEoosAZG14GrRM959uI4m21hVFutmff0WXnNZBIhmp8m9N7gRM
         C2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736627232; x=1737232032;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/FpL7CmJTe1W7DtWMGgO7HVASN54rPsnRzFSSP0ZVU=;
        b=YXYmY70GTof4wDCdWxmeDr0vwnz10gRO+nyeZUpBwqCOnsRai78CFHo3ckwGfYEHVr
         HPnzN+/gcgVkwrlBysG0xTIy6oyX4ybvzxdJSRQHWBIswHxnuuUO5Y7bzPYFGnFOaXFt
         mHc9t+5rE+rJQXPS6SYiezEOE80qiHXaZSso3vVXNHLCwxZjS5hcv/3sj5Xo3b0WexRZ
         x+0Sr7Ybejfr4M7R9e7WjKDUkWPKq58VheiDqnDvEaVb3fq6XZ3uwnxyDV78cg37lgfT
         4++BBw5oXf89rU5VGisM0sDqYUto8nCeoop5G5NP8/cgsXcDAlYvzea2OuPRVolfWn4v
         coUg==
X-Gm-Message-State: AOJu0YxDLSIiV9MyUQClVHwdGzCv1IJXT64UZ/f0o4VmgZg0EJGt6jgw
	d5lKg8FUHH2Ms1/RkmGDXfzbB5hZQoa4Zar1LVAp83vDfEJRMW1p
X-Gm-Gg: ASbGncuU+Yx64h7s1JMonUXzpHTbvGRURraDAgONZGZt2PP+TnxkJmbbNMUFzzU1K9k
	m5KsmtnYzmLdSli6yBH6WbOXyXAtNMU/8sPjvodAMGvH90oY+FDCAUW3eXHC094qd7t3cp/Olhz
	hI8RB1L+5U0oNWJliCMyAkIr35x58KrKOthDVLQsupgg+69+N4DMh+xnMW3WQwQVDJAx11rGCrv
	Fa1tdRlNm32roEGMTgKohR5WP4lmzqXYFEQcqlcjEShN6chfeWd3Cqumi1u42+dkJpVPdQzhedQ
	7lSNeN0Z5/vEuKc//zBUUannoYHpapJHp26OlR+YpGphBQICZkI/ue8jvthsvGFNsVcfj9MAvMZ
	i/quvqBVUb1AF1o6k0p2M9kFgj4B2qAdAhqaXFICEtINHxy1x
X-Google-Smtp-Source: AGHT+IFMCppDnxvYMIoryUEJwH7yI6ZAEc+ZW0a0PiXEyYkQiVGBmXhvT9juxhnCSqmC9epiwFXbvg==
X-Received: by 2002:a05:6402:2105:b0:5d0:bf27:ef8a with SMTP id 4fb4d7f45d1cf-5d972e4eeb6mr13536823a12.26.1736627230003;
        Sat, 11 Jan 2025 12:27:10 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903bb465sm3025828a12.36.2025.01.11.12.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 12:27:08 -0800 (PST)
Message-ID: <8143533e-8eaa-409f-b5cd-f653fb32ac43@gmail.com>
Date: Sat, 11 Jan 2025 21:27:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 03/10] ethtool: allow ethtool op set_eee to set an
 NL extack message
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Disabled EEE modes (e.g. because not supported by the MAC) are silently
filtered out by phylib's set_eee implementation. For being able to
present a hint to the user, expose extack as part of struct ethtool_keee.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/ethtool.h | 1 +
 net/ethtool/eee.c       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f711bfd75..8ee047747 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -270,6 +270,7 @@ struct ethtool_keee {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertised);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertised);
+	struct netlink_ext_ack *extack;
 	u32	tx_lpi_timer;
 	bool	tx_lpi_enabled;
 	bool	eee_active;
diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index bf398973e..6546d7290 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -129,7 +129,7 @@ ethnl_set_eee(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct net_device *dev = req_info->dev;
 	struct nlattr **tb = info->attrs;
-	struct ethtool_keee eee = {};
+	struct ethtool_keee eee = { .extack = info->extack };
 	bool mod = false;
 	int ret;
 
-- 
2.47.1



