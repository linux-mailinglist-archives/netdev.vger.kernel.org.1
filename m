Return-Path: <netdev+bounces-142520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F4F9BF7E9
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 21:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93A72814B1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA7520C010;
	Wed,  6 Nov 2024 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjQQwwO2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56C20A5C3
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924404; cv=none; b=cO8tscZbMcbOBNe6KdOH6+KXnPTlB7E17i+bxbOSkteZvFvRPdIYEjSD/kngKIVNcaiMPrAT6K3IYpgaNSDAnU5HwVluc9u5Xxjb+N0qr5uxTabwkPtkIx/hcQ3vhfC/Ax8BTP1RNrBYwl6vtPFScgiD/V4vjcdltM2tfegKQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924404; c=relaxed/simple;
	bh=27JqhAAwV4iljMj+rY/9DpZxNmPjEwt6mLLL4XmHHBg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lKZmlvY3UF94sWxaCDqdQmTVhGy20QzTQ8LxnHDFFUlq9vMjOFb5mBqKzLVR2bbYGvJKBdoSQrwIK5oeP1HULR2lO6QEYvUDhS8FJ10wMlInlB2913ZvbgIGwf/qZm2UjtlhoT15kSd1ngo44b9f7A8ZnFk6D4KWzLFP7AWnPik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjQQwwO2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ceb75f9631so196937a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 12:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730924401; x=1731529201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C1xGRhqXFf/SW1nncR01uTY0FKiJmCwNXnH8VHamxZg=;
        b=EjQQwwO2NIdKFtG153xxeDlL61N8jF+2tYO42v4xza88gK0KREi9jBEqlJLPkVcMrF
         6cERTVuOsvv6WsM9KXJpr8jkkM3U/m5wWKCsAjwiUzX9KHGPzqPpkMxoGBqHmOVfeZh8
         UidyQ8FrlRFN40gKPkr3T2ghSUhtKgGaTi7WfZd20AYVjwgyuCGZ+ABC7bT2F/pYTLkQ
         z+/d1euN1tcdPu9VE2A76DWyjGqK9e5QADDN5bou6SnwYtX50WVQ7BqLp3RI2IwlbNXj
         xBWQ4fdpLmVYcc8Lr/Ctx5D3vWSdX07pM7mSMPWv/LG0kXQsulhLFLRnMGmD9RUE6E4A
         m7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730924401; x=1731529201;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1xGRhqXFf/SW1nncR01uTY0FKiJmCwNXnH8VHamxZg=;
        b=KFZamjFbMQYpbTZw9hM8Q4lPL+lxbN2rK4hzU81ZEM1UPcE24BnI1UFSMrwj8WWuIF
         QOvjBxUzfYv6Wiysy14x3qbyUKmvrhNHKHwZ4IvA3aHKmY9Yw/4YQlPxEdzqfmCzDeas
         TtkDgT7k2u6sxK6JdhIITPMdE9xqI2ZsjSxU47qXK2PZOZlJHtxTnmjhJfi4owtIPipU
         Qy80MBs/3EgAKTJzKrlHjxv/TKHA4SzY0eFHXM3W/MwOYTpCNH2ueNMpA6BjyvBcc75q
         cZOxcr7no1wAz0tDWpPgA/yWqCTJ/4Eya7tUFFXGUo59AftXH915rQ8+SkaaQnRwh2l5
         fskA==
X-Gm-Message-State: AOJu0Ywd8K6v+HNSS/vNF+SHGadS1bIfATC7Sz4J1OmEVofpU2x/k14u
	52CHxYHXptrrF1HMQrveC6xBwRfhWx3xbv69C3qN2snrxJNORvu4
X-Google-Smtp-Source: AGHT+IGq8K+gtJ3CVcPU9+yvYEL37ye1lGBvFPxILsBGDv4+qr/U+8cnw/Ek7l4Vm8jLMuLO9PEJjQ==
X-Received: by 2002:a05:6402:3491:b0:5ce:c925:1756 with SMTP id 4fb4d7f45d1cf-5cec9251eeamr10401690a12.6.1730924400759;
        Wed, 06 Nov 2024 12:20:00 -0800 (PST)
Received: from ?IPV6:2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6? (dynamic-2a02-3100-a488-4700-cc12-ac39-a3b8-6ff6.310.pool.telefonica.de. [2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6ab12d2sm3276147a12.32.2024.11.06.12.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 12:20:00 -0800 (PST)
Message-ID: <d23bd784-44e6-4a15-af3a-b37379156521@gmail.com>
Date: Wed, 6 Nov 2024 21:19:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/4] net: phy: make genphy_c45_write_eee_adv() static
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 David Miller <davem@davemloft.net>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <69d22b31-57d1-4b01-bfde-0c6a1df1e310@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <69d22b31-57d1-4b01-bfde-0c6a1df1e310@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

genphy_c45_write_eee_adv() isn't used outside phy-c45.c,
so make it static.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 3 ++-
 include/linux/phy.h       | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 5695935fd..6e7198794 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -680,7 +680,8 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_mdix);
  * @phydev: target phy_device struct
  * @adv: the linkmode advertisement settings
  */
-int genphy_c45_write_eee_adv(struct phy_device *phydev, unsigned long *adv)
+static int genphy_c45_write_eee_adv(struct phy_device *phydev,
+				    unsigned long *adv)
 {
 	int val, changed = 0;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 0a0985150..517f6e0d3 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1954,7 +1954,6 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 			       struct ethtool_keee *data);
 int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 			       struct ethtool_keee *data);
-int genphy_c45_write_eee_adv(struct phy_device *phydev, unsigned long *adv);
 int genphy_c45_an_config_eee_aneg(struct phy_device *phydev);
 int genphy_c45_read_eee_adv(struct phy_device *phydev, unsigned long *adv);
 
-- 
2.47.0



