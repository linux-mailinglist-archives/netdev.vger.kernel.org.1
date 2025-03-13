Return-Path: <netdev+bounces-174738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8459A60175
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C10F3A37E5
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C3E1F30B2;
	Thu, 13 Mar 2025 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbWsK4TG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5765464E;
	Thu, 13 Mar 2025 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895020; cv=none; b=cX+L5GRtCD64tjjUeugjlQ5IVAceLpUkkYm7XkppGeLkCgMr9KfKK9YiRzg5JbwkzIYSmpTwdRXPWW9S58i/2Erjgar9J4VhB090bnDvSx2l16T+WHo2AZV7GWkN3hRN6wz7PVGMd9J0QcwYSmBRUboZPSMkIrM2br03zKmXBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895020; c=relaxed/simple;
	bh=KpJZlbqk21KsBHgbb9AhRFChGJEWaqX8qwu6sClDfC8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OSfvW4zi3Q+rdOeXmpUJ7fhRQfk5uq5T3qViHI1JPUviR5ayuX7DFpQyvR9FN0FYa2Q6bFtyQMAavsIZPF0CevqPpTTxys7kDv1a+5yqbmn6xTu4a/xs1HjIdDEl1NUJFT4vmewJLlWLxGuhub+7KC7lE+T3LjPOnCGYtw0dJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbWsK4TG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3965c995151so585444f8f.1;
        Thu, 13 Mar 2025 12:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741895017; x=1742499817; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRmxwrNYTcEFU1auOWABscUO+An5jgO+nPNK5tfXZzc=;
        b=ZbWsK4TGRFQTaG7XKQtpsc/TULHNhPSIv1McRAQ+6rwkd2SIZIbawh39T6rFHZaOVF
         uvWHaCaB+W+CNUXI9LNGCqDZ6dVGVxD9p/tVdUV4oMc3yVwxH4+jZRcASihRjFSg3pWE
         08GDxGBfi0UkSNWt0IRF9SH8DYRiu7TgPTGqwYa//vCkECddb+E8kXLGyAI9sh+4cneg
         HzZWCN7lED4IYZW8tKx6qtbgmVcKf+Us4AyY4kWPwX006ntQ+YS/67GtNaGZotNOcumH
         ErfgV4Xp06/NoEv96aH0OxRk/f5+THnWJmGV/Vx80+m8JR967UEr8HY0AblSxsTwj0be
         VgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741895017; x=1742499817;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRmxwrNYTcEFU1auOWABscUO+An5jgO+nPNK5tfXZzc=;
        b=CArwJu6OSnoBhndhmZdZq27raBKhL7Qn0RPgML9DV2gRr9Mh+L8h4fBF8RNVngbdbq
         1ov6qU/o7IYIcB9iuXQocwobtRstD2W02Q07anmKO/4d4b0JKMbwBh2k8O+i9d5ncDTu
         dn6NAMY6l05grl33JY30TypOda0fgUR06LeBxkSzXTPAaGT73NeGLsMFJfr4HPhK3Uxn
         UGaxuja7jstUOXQA9ssBji5iQB+Rj28AOijplsep+Zg6RE22/HM5xrpdf6jFJcY7GBqT
         0mHRgVnknNWFtrqQ04j21Py6myG0gxLnlsdw/ecAxDUeSX64TFam1jQTD6E5igdi0FLT
         pk/g==
X-Forwarded-Encrypted: i=1; AJvYcCXO2xsruDyy2nRIUxUCJPj0elAPCF5ZAWqZ9LNv2aedD8T70kXYhCN4ZH4GhjIIlv0lFNB5a71VHsmBtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr4Pb+koxgjb0AoINFIH5GOqkI/mD3HpzsDQJV74a0E6OL3Tso
	xWn/Co38yQZTNNJUZifWoNOlbM1tLoKDhcRi8s2DOTc7sI14vIzr
X-Gm-Gg: ASbGncsuzWYBdkmnDy/eV4Hp99C03fUw03XTfyCgcSeVK+riX7dm3yXRz0S69bbkhNi
	nNGj/7kU6a2+AX0eoF+Un22zp4HQUwoweztg1F9UNnDZHzcMcVjRlA+/B8CI29Bmb4LN7YaSz1L
	qmWs+7lvfJoLZxt/xtwmrD3IW9BYHToKJC4w1IGE6mWvX0psDGkmTa5tTVnslSREE53dSjvR4wp
	3gCopsJrM5wNmWfUIVJQa6JErlgNFqR6D3cfRx87ir8LcGe+Bue1ohDVojXibM3p9sIoE2CvJ4Z
	CYzqdCgQ8jwweIaPkA4gRZekYIwJ+arfCzlVosFzMzGTWVOd2zWRHpShyLB8biVH0Wpu7MZ3unf
	AyAwjW4S6RFbv8HL/W0GToCEd9C9CNA3SrlcSQe29jjrzyqBPOPj5bleb0b4PdA1l5OpFvBIdBj
	AoZlVtsGqvFT9MqDF6TZ3FAL6d17LNxUiDxt/c
X-Google-Smtp-Source: AGHT+IF1wxvNUfw4s/Z5/GWJdDB8ClXWpt5h59fasSNo0tcl3YgLLKYXyzcVC/DgTA7JDwNCsMBmIw==
X-Received: by 2002:a05:6000:2109:b0:391:2a9a:478c with SMTP id ffacd0b85a97d-39264693887mr9298956f8f.23.1741895017124;
        Thu, 13 Mar 2025 12:43:37 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9d92:6200:9d62:fd9a:43ed:7e78? (dynamic-2a02-3100-9d92-6200-9d62-fd9a-43ed-7e78.310.pool.telefonica.de. [2a02:3100:9d92:6200:9d62:fd9a:43ed:7e78])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395c888167bsm3156498f8f.45.2025.03.13.12.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 12:43:36 -0700 (PDT)
Message-ID: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
Date: Thu, 13 Mar 2025 20:43:44 +0100
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
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Xu Liang <lxu@maxlinear.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/4] net: phy: remove calls to
 devm_hwmon_sanitize_name
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since c909e68f8127 ("hwmon: (core) Use device name as a fallback in
devm_hwmon_device_register_with_info") we can simply provide NULL
as name argument.

Heiner Kallweit (4):
  net: phy: realtek: remove call to devm_hwmon_sanitize_name
  net: phy: tja11xx: remove call to devm_hwmon_sanitize_name
  net: phy: mxl-gpy: remove call to devm_hwmon_sanitize_name
  net: phy: marvell-88q2xxx: remove call to devm_hwmon_sanitize_name

 drivers/net/phy/marvell-88q2xxx.c       |  8 +-------
 drivers/net/phy/mxl-gpy.c               |  8 +-------
 drivers/net/phy/nxp-tja11xx.c           | 19 +++++--------------
 drivers/net/phy/realtek/realtek_hwmon.c |  7 +------
 4 files changed, 8 insertions(+), 34 deletions(-)

-- 
2.48.1


