Return-Path: <netdev+bounces-68803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D50B484854D
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 12:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326B11F236E1
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 11:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7201011CBE;
	Sat,  3 Feb 2024 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLkl6+cO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B487EDF4A
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706959146; cv=none; b=LCf+/x8jEogfTsi0oW6zvtQdgETzkoyYNaPO6yXFubL0slcjDNHqUq1RDHHJHHHxkMxZDHWGQL6yCuKIh+cAaVp0END6W9Rs9Aq8CfJT7tLQcrYbOUm0QN3SZNWH5lnVCBeSpglfH9uwfShW5Fe4VD0/mvvwitkTcLiMNznVDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706959146; c=relaxed/simple;
	bh=l/oWP7F//0r19+UOsvQYepjWZrYgyyqm9+r6SGxhjCs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IjdXQxs9qya4wK9HT+4uab9fC0wVH3RzzWG7INThMn+Zq9XYBkasN0dldTNS3qxadqqkDlloWF5DF26Dgt/LTI808mkhZjyKsDmkmdXMQpMJwaXXfeBUGSs5hCd+B5nlx6kcEWDia/2jFa6Ap6e6aInKt8S2kv7u7obI/7jYNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLkl6+cO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55cca88b6a5so3602271a12.1
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 03:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706959143; x=1707563943; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkmaV9wFck84yxozHakRRa/24KQ8o4NJc8pCIs+Z6SE=;
        b=SLkl6+cOvJmOnjI9CnGoeJTm28dVAp715w9BeppCBg4DY+eHKNcwu4wAMd0cv58gPU
         0aYqdDTHyACrWa4x2MCZ5InKDNBkvxjrqWJwpflZYclzgHuclMjSqa84URvWI9uqGMyy
         sSdDkfHaKfmwn5ckZYHt2WekLYGwiWEkAlecZr0CB8RTpIbzLJyomAl7+bDl/fhF8d5l
         JmqjG7CtLG+1qhvphMWZAZl4A/8lGBmhmVYYlDXvMPliu+wvktL2vzlUcJGwFmoWrnFZ
         eWi/cEruzMxOsNehMxkXNrzmaYRGnp0AMt0DXDzpmBqudtPW8LJp8DVDq/GNzhaavmJD
         oMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706959143; x=1707563943;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkmaV9wFck84yxozHakRRa/24KQ8o4NJc8pCIs+Z6SE=;
        b=NPyyQzwV2jw4lI1oEnttmwFVHGCSi+41EZzbDV4ukyCpgkwU5M4XleeS46utFpKwTC
         ROrKGv1WkmzdpRegIzBYCZXByl2pWiJnVlH+TanGDwKw3bPreaZt3qrT4+gBGhvhtEAa
         f0OPV4CWT1/g+Ez1SVIOpbXgmDMiZ3vV1EOAJK21h3DsYHQ3tsruMo9E+S/h5A0fhQ9/
         1wY+TCbsazExNkJtv4guIXH542kfz4QzisOFjdavaV1+6DmBc+PEYAZm823iJdM0RemZ
         ApWnCu1eP/hFwUdoJcO/ioOybMfKQvNQXVEioWA7gLwYqef3ajPtbIY9IIfACxOzM7IV
         kpAw==
X-Gm-Message-State: AOJu0Yy1ycw3H8i5NXYViAvKrLZE8iZHmmZXgkPIHCOBE9MAt7kdog1T
	kCJ28QUHmBHbWu5D8b62NXzkiprxgtp/epKzzN0I6a7VtEKkwH9H
X-Google-Smtp-Source: AGHT+IG16QupZvMiTKPQBhnuZwcdFNLf7curmAgXvjrVdAf5HLCIbcKsqtD53G9EOn8c2dhlz2klGg==
X-Received: by 2002:a05:6402:1847:b0:55f:9bb6:b205 with SMTP id v7-20020a056402184700b0055f9bb6b205mr1405634edy.34.1706959142637;
        Sat, 03 Feb 2024 03:19:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVqvuNFHO65eWbfWtWyzKbgQn+xLLRuu6xzDezU6pQVXC4jevns4q5Q+AkKFxwaQLHoXT8d4oAiGArBoNlx0rkNGtMr91MgzvF7eiR7XCOtZdXf0VPsdQfszejZmWCEAzA/GizqnNX/hAccJTrUuzo2Sy8hX3pI4xvOm58V7EihzzPPfPCysCZa1gFDs6DrjJ6+sp57f4elTakJS9JyGNVs1hkyC91x
Received: from ?IPV6:2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac? (dynamic-2a01-0c23-bde4-a000-48dd-a4bf-88d3-e6ac.c23.pool.telefonica.de. [2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac])
        by smtp.googlemail.com with ESMTPSA id g18-20020a056402091200b0055ff4a88936sm1380915edz.41.2024.02.03.03.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 03:19:01 -0800 (PST)
Message-ID: <14ee6c37-3b4f-454e-9760-ca41848fffc2@gmail.com>
Date: Sat, 3 Feb 2024 12:19:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] net: phy: add and use helper
 phy_advertise_eee_all
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Per default phylib preserves the EEE advertising at the time of
phy probing. The EEE advertising can be changed from user space,
in addition this helper allows to set the EEE advertising to all
supported modes from drivers in kernel space.

Heiner Kallweit (2):
  net: phy: add helper phy_advertise_eee_all
  r8169: use new helper phy_advertise_eee_all

 drivers/net/ethernet/realtek/r8169_main.c |  3 +--
 drivers/net/phy/phy_device.c              | 12 ++++++++++++
 include/linux/phy.h                       |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.43.0


