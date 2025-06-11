Return-Path: <netdev+bounces-196697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF63CAD5FE1
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B14178627
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B39289811;
	Wed, 11 Jun 2025 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQAWLXrJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF0221F1C
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672575; cv=none; b=TJum+kdG+ObeD7mJWBA+ur/2jHmdEK/n9JZM+f6yjKY16REVXvlo6PkLAqBhcmU/erU7USK6DgnwfXlIDm8j3AzhPKSaq4081pDO/2JG98Mx2Gcfu3UFct/18kbNX3lfTe05+/AkFEMwiWkM2mVBXJhrqZIU6O2vjksGRfH0yvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672575; c=relaxed/simple;
	bh=6scT2CnsUigx+naFbUHge12JbJH99zUPkxNiCgT59Tc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=djixFd9oV5zr5ESYA1ThUHj27Epfo0JnhQ22BD6XAi4moyoXIp8nt8ecpv0zQF9zpDZkpJJOoTbSHHVQ8GufZV5LP+NcBdBU+YHniTBeROAEbTQhRcLHUqBUZlyRdgeOEZhW83/1vvInfW9DZK6VHrrh4yPwV0yv+upmo2V0Wss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQAWLXrJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4f379662cso235288f8f.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672572; x=1750277372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/z/bnGxlkYj0dtQj6zFA1O8axatQ1CAC425yJEmm58=;
        b=FQAWLXrJT1wXF/GF11fMnmTI2sBUiGtFJvS87MOeUEjOFj/pX/gKzx1lyJxUSZ6y7H
         nCMW28w8IdNBTru8KJ316m9jD5DTzB3RHKS+sevnQyj6/smmyb+PtagPAIKrZvDo3j69
         IWNOHcZ0UBpiE7mymHM6+c5KpRRUOAhju9L5Ivsimn8zx7jsxck9Cp7p4STTqXl6bdQF
         9RjS8qHVDLTAZAzZ9djuD/LF7hqEEOL9x4RFDRQJiTzdFAI9LL/CnGcoHRwELGlnsy9U
         SeyToCCeOmqfle9gJI/1KDgqkOWwMyj5ilvt4xVvO5fJLN7nzlt9iTZVuE+Jmy5zMj+h
         pBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672572; x=1750277372;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/z/bnGxlkYj0dtQj6zFA1O8axatQ1CAC425yJEmm58=;
        b=hZbeQOvZTX8OuTW6cixVvNzOZi1OY5cEFnf4uI+ysQ2uAV/Qg8b3jXf7P4h749FND4
         YY7TZAdMFDWk1RWC6RRRYIXM1lKmE8+dsz61GjgGHTdPuqrBldFlAOg0kksIk9ZIf0n2
         OuxgmW45BTWfMLMmbLgUJO8CSKR+HFAmFYnbOy8gALYJeVfVRZI/SnEf9Jys8edMgbWa
         M0E+ci1s7TV1CLuw2SiqLGUcxkPHrUzA3RwBDJ6Sa/1DnNbWyhjnmc93N9kcUibl1ScL
         NvaApWbluWMNJxXjYExfTDYyB5yp3jtniSmdJrkf3bYH7X48LEpEkxChE626jTrsCSWC
         4yqg==
X-Gm-Message-State: AOJu0YwMuLqBrK+nXKRES+Dhj75Nsn2qLlk9AKEgefYqOAAOylmBUvU2
	vrLaFYbl50akYWryFdMnhtwRdMi0knlghY/l0NIftNb+wK+mWGShB79N
X-Gm-Gg: ASbGncvCiW9Fqo/BF1xk7tZdj9IgSAyjKDtIQstHE2Il/ptPl9NlIypb0KsWNCFNd+v
	yC1Yp+Fkqgh9P2M4x6rlR5RP76GAMc/8PedVK3hOHbJh5cM4HHPpBSo+piJZNKVDyWRW+lCeh5N
	ulTikoVWWJFjueeM2/FDuiDaWYw6Ww3TEHH+5k9/9Qenvl9iKfa4oc5mMQ2tu1TSnTdJSZzCH9a
	Z60ayTdSueXzfJhNg7Dzdoczv5OLoNuqDBmTqqhYvFm9eOMS7q6GYGdDfxoeX4qkiJA9p3MUwsF
	vaYOuiXWv+SNF+NTQ8vAiRkp1CSoLObVtJbZRd+FgeyZVvk2Gkj15uyWgDhOLO/Ro9DiKRJkHON
	lpAJWlt98bhT96RddqgTYBPYren79hRrCkHGGVSmUTuw+SXbsE7nJrQHhJ1hs5OxJT2IdpMHuX5
	og1j7QSmoEXRJLkgJD1kBYsimoXg==
X-Google-Smtp-Source: AGHT+IE1QcPeMQwdf+zKZYayk/SJ0NGviWYycqTP+7MVh2mzAHJmu4DVmx/q4H2ca9HB3VWCsaugxg==
X-Received: by 2002:a05:6000:1785:b0:3a4:e502:81e1 with SMTP id ffacd0b85a97d-3a5614dbb40mr217384f8f.52.1749672572478;
        Wed, 11 Jun 2025 13:09:32 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1d:5400:69f2:2062:82e9:fc02? (p200300ea8f1d540069f2206282e9fc02.dip0.t-ipconnect.de. [2003:ea:8f1d:5400:69f2:2062:82e9:fc02])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a5324621a4sm15943804f8f.88.2025.06.11.13.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 13:09:32 -0700 (PDT)
Message-ID: <f6bbe242-b43d-4c2b-8c51-2cb2cefbaf59@gmail.com>
Date: Wed, 11 Jun 2025 22:09:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/4] net: phy: simplify
 mdiobus_setup_mdiodev_from_board_info
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

- Move declaration of variable bi into list_for_each_entry_safe()
- The return value of cb() effectively isn't used, this allows to simplify
  the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio-boardinfo.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/mdio-boardinfo.c b/drivers/net/phy/mdio-boardinfo.c
index 2de679a68..0360c0d08 100644
--- a/drivers/net/phy/mdio-boardinfo.c
+++ b/drivers/net/phy/mdio-boardinfo.c
@@ -26,24 +26,18 @@ void mdiobus_setup_mdiodev_from_board_info(struct mii_bus *bus,
 					   (struct mii_bus *bus,
 					    struct mdio_board_info *bi))
 {
-	struct mdio_board_entry *be;
-	struct mdio_board_entry *tmp;
-	struct mdio_board_info *bi;
-	int ret;
+	struct mdio_board_entry *be, *tmp;
 
 	mutex_lock(&mdio_board_lock);
 	list_for_each_entry_safe(be, tmp, &mdio_board_list, list) {
-		bi = &be->board_info;
+		struct mdio_board_info *bi = &be->board_info;
 
 		if (strcmp(bus->id, bi->bus_id))
 			continue;
 
 		mutex_unlock(&mdio_board_lock);
-		ret = cb(bus, bi);
+		cb(bus, bi);
 		mutex_lock(&mdio_board_lock);
-		if (ret)
-			continue;
-
 	}
 	mutex_unlock(&mdio_board_lock);
 }
-- 
2.49.0



