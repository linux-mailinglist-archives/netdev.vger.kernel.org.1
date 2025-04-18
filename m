Return-Path: <netdev+bounces-184097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B29A9352D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D51D4652A0
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF4526F44B;
	Fri, 18 Apr 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0cYYPeb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200E26B94E
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968114; cv=none; b=UwhLS+Cxcp/+fKpSQ19hbU9Yg8oX5gASa9D2wWyi4oTsVjeoB0V8ArRwMOGIZ7kXHAbtYCwD4UY4sZluQvjLtsOD6bRV0q3l+xr1osd1kAro1bsl2Lw3ww5UnAsuV8dY/WwGvPS5U3QIuKwHTTjYzrwOdloPxXLuZw664YfSvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968114; c=relaxed/simple;
	bh=WFI5cICBEnzSPfIxvQmARc31asPoI/Gwqwrydco3eMU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=t6E9zB//zfOtXUUPGJAJC20ly3mVmDhPOhVpKIGfIP22mbSvbr8IReInu9SrrpbRjhR8ftszIDxflc8TdVMHFWghAON0U28/bRDXbimL58oScTsw0RodanXZSJogK6VBCQOXP2nufnBpvXy92NKUlKSMK17Yoh4OZaQLA2s6n48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0cYYPeb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394a823036so8218155e9.0
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744968111; x=1745572911; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=utnv/lyBhMT0ysYQke098jKOA4Eb1JaoiGsEeM0PSBs=;
        b=I0cYYPeb9Q3hlzeZutORZAanLFE8mwll88KfIoByy1hRVh3RiH0/2jSxIcITpa9yCi
         NOBOVfC/Q425rljDr73pCky0KUH7Pxo+67dNzofEugA7fSEXZxYKUPABQ2Qc86sIit5I
         MjItgxBoUknC+NGmJfzrs65EYBxhYyihwOGNy9MDZHrX4G1D33x4/dyGMBPC0ANJclVO
         11h4HN8kpxOloqM7Y1qnd9jFh8NbMWlZTTtyom9l7N5DhN9etp9ki0vmavhOjhLygD33
         JYwHFBW+Dde4jynu61wyyec+LTC0/Wd8G4sfmEpyeeif70y6AmetvjzVinr9O4/nZNZ+
         m2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744968111; x=1745572911;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=utnv/lyBhMT0ysYQke098jKOA4Eb1JaoiGsEeM0PSBs=;
        b=eygR2rB9O1wkcDttCC76yzKDjT9kzhgHYmn/hDDtBcLU5L1oqbOuuEKoZkGHgtzfJH
         63VM2tzbwDAG0ZvVgzTcAB5KA9dUF/XgxDNQ4sHqjWaixHaQ7fyB3sK8AhsG5MW/MmTT
         DwgCcpytBQnSE3875dgTQr/X3Eb14YDevznhybnDCaD/Qvpn6HNBLmAooYIOh6tpPoIR
         ZAn64JdkUtoiu6nIvMwNvrTfodiPeZtT5YnXTYRFW+9iBbNVd4IQN3JOZ3dk1ZWsiKUd
         oVqv9Lspk1hJ0tYigmT2saRzfsIuIf5CYCv1l3nAKbfMI/bLwtqvH5H/ngJIccbNC+BT
         OHjQ==
X-Gm-Message-State: AOJu0YztqpFzcOQRXj8HQErk14QwkQdgbpMmrWH7sdqPrIC/u7YCeFJh
	UnWhg5WNe7Xm4hJ+bUWMiReHkkSurG4UNSfSiqdokKDHGbZA3MM1
X-Gm-Gg: ASbGncvuegY+tkWXpvT/QOxgsgSndOxybYMtqfv6U60nwNIqwjGwXfeyF1LsWVH4YoJ
	usixxR24e4qr7lVtnaW9+6F58sQv1Uiw2/7WnYip0YKhxC1uERK/Id/cS+0l7XrxTOjRUjWJHj/
	dvsPbT1jPvADDPT49IL3pzKj8bXJasw8dCC7OtwLRGppeDA87B7p9Ly+vf9RJishm6N2eS/bokT
	vVFewEcxrk4O6ENeVZZmFQdjGGqgayGRY5o8cN5Zs0MTg3HyebJbWTgMDJR2NTW02GNuXUaCZr4
	pLE6cYqQpa8/givEQ4aWocQ9aK3qRv5GmBQUmGhtnkE0+9UEZ/g9IL09kd0zrnt3Z/B/eDkFani
	knpIU3/u9SWNl1w5IWD35rR95aWSflJW26WsZZdY3dmHxiQRobEd7I4JHS54nXGiDeA6YqncCE0
	f7pbYY4T0t+V3dZXp6F0LpcH8+LPoEU/9oO1c6Ny7EQd8=
X-Google-Smtp-Source: AGHT+IHaM78nxPpThgXJ4vsKf3M3epuxDyuvO+nzm0pP+2vCn+pzg1DX9925WeWcVSizCsms56f++w==
X-Received: by 2002:a05:600c:524f:b0:43c:fb8e:aec0 with SMTP id 5b1f17b1804b1-4406ab7ff18mr14927525e9.1.1744968111009;
        Fri, 18 Apr 2025 02:21:51 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a14c:6800:64c1:f857:3ca4:c5c8? (dynamic-2a02-3100-a14c-6800-64c1-f857-3ca4-c5c8.310.pool.telefonica.de. [2a02:3100:a14c:6800:64c1:f857:3ca4:c5c8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4406d5d7ad1sm14987245e9.40.2025.04.18.02.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 02:21:50 -0700 (PDT)
Message-ID: <5e1e14ea-d60f-4608-88eb-3104b6bbace8@gmail.com>
Date: Fri, 18 Apr 2025 11:22:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/3] r8169: merge chip versions
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After 2b065c098c37 ("r8169: refactor chip version detection") we can
merge handling of few chip versions.

Heiner Kallweit (3):
  r8169: merge chip versions 70 and 71 (RTL8126A)
  r8169: merge chip versions 64 and 65 (RTL8125D)
  r8169: merge chip versions 52 and 53 (RTL8117)

 drivers/net/ethernet/realtek/r8169.h          |  3 --
 drivers/net/ethernet/realtek/r8169_main.c     | 36 +++++++------------
 .../net/ethernet/realtek/r8169_phy_config.c   |  3 --
 3 files changed, 12 insertions(+), 30 deletions(-)

-- 
2.49.0




