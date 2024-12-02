Return-Path: <netdev+bounces-148037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322EA9DFF0E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 11:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E2DB2C8E8
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D771FBC84;
	Mon,  2 Dec 2024 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="ddMLzbze"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F81FAC52
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134634; cv=none; b=rQereYGHfU+W+0PIJ9AIAAJVb7ogBs/eJg9c67o1nzRbMR3+3UTlFk5RCnofMQnQjFJkywqiEDydnEXpY1GYAvKFdqBIAB5Txgu2OMnj83fUOgnSlbhCNKO1sIfm8i6bq7v6rsckNlU+wRJvtMRsEqMSgCF7iSxR7laKGxFozrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134634; c=relaxed/simple;
	bh=2r7XimGRWW6H7zYQnhfYnY1sR4668203OHqHzEHk44s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frvsZ6tqhMONkJ+gcjE9m1/Hd8x/9K+wFdosZ1icDRyKK4QcID/2Y3rUWWpRJwWzVanri00sWDKL9a8VnH8C7bGudvLDLOL/mC5xfMAT490U6S3xKJ2fd8pA3kVzceWdwTjvcVuo91QnqIr1ZXRIAirMxyKyIEhHvbOKbr0y8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=ddMLzbze; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53df63230d0so4792673e87.3
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 02:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733134630; x=1733739430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFf1RmxuugZ0c4+M7u1ESLX9E9Rswmi2L3SkTIYyIxc=;
        b=ddMLzbzeBgs21gEJOBojGjWAkF24I8WZYLoApFDjaMRm3htgax5gR73P3G1UREgdpr
         95+pCHCkqQLt7sxNCDQXAV0gAo+Sk6+Gt9prHDOcmAI7LaD1I2/glFqG3SCMCdlqL8XF
         oFcEX/fHS5AiD1uieGLw9Hppn++uEGxKYU20XrVXl+U/zG5rFqoRDwHegAheSqbLe8GR
         iCyR/wP/vDKkL9H4nOLZVUx/ZWpmG/HSB9LB59L79OwexTT98Vwgh4Q3u2B0QFcibw8k
         WVavUsuB3GqmTs0zv4eKvyEycS6GMKmdGck/jpzuLqsf0YGISHBGoaqNiJzd1qafNm9Z
         EJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134630; x=1733739430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFf1RmxuugZ0c4+M7u1ESLX9E9Rswmi2L3SkTIYyIxc=;
        b=VgQGsZDdXL+SfrsdwRptyZY4AKWzov7VVLVpMNgPoTopLX6dKj1mR8nmidh0yo43xM
         bYWb6gLD4jAKTiSVSxgAel3Z+GT2kv666OCIcCz/1oMbDu7/sm7q2uEZDLOirIX1KL/8
         tSc52W7Gxc2UUoHFBoTjpvH4hSx6/5hu4cxpZH5X2XArikuti+vMFRIqr0E9f7A6mc00
         PkHD8aZmmDRlXTOEkIhFQYu7qg6WzDnCBcuvFRwn9Q2s6ixuFwhE/AaieNo2MM7LKbvF
         o9knxcybY3DWEZQNF4hn+DN+NGvMF3vDO/UixN3Z1ELSlJVvKK0DcewkgXxUGRk5/PjD
         0SNA==
X-Forwarded-Encrypted: i=1; AJvYcCW9gbsW/j/2MOSjQcpvaOGk0+RoloclsDEaqYKe3127oLFsvqyWtLMmlx25/fwvROL0qXQ41tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8QqZEWoDF2v3QYSzXJisJquYRXkrP/tU6emXBkog2jinwakw
	pgTusVJl2UqWVRoBDz+1/Gu2XHZkDCs2EzvlAAaUuD4zd/XlC5o0d6AnlRjXTr0=
X-Gm-Gg: ASbGncue0T6bhvweKglsU3izGhs2CSubYX1H0pIFfY5HwmhNwM+h7twBzrqV34aHqig
	1+WtcXHyDyKQl60RNeN3D+9TMFHtG+BVVs9kTYbZClf4YV039A+IhsK/SdCWJWAEF2af10mLY9S
	BOuhjXRtb/MEnlu9MXwzhbfD+j1OKsKP81vMlVIdGA1gKHDz5RUmbQRF1/2o1VTM5Qr7u0Ufexu
	GcvyT0dweTygkNdEu6lrr5TcAA9Y1c1Rp0BkgH8nExaBYf6JbvKZ+06FUgb0F39U+tFKQ==
X-Google-Smtp-Source: AGHT+IHRZLPNljfKWkzmQ+x7kFH17iWwmYu0Jkgog3BCYQYYWLKCPRTK8cNKNVMxZlCpSaIAKvpw0A==
X-Received: by 2002:a05:6512:124e:b0:53d:a2a6:ef67 with SMTP id 2adb3069b0e04-53df01121f4mr11899621e87.49.1733134630585;
        Mon, 02 Dec 2024 02:17:10 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df644344esm1420887e87.76.2024.12.02.02.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 02:17:10 -0800 (PST)
Message-ID: <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
Date: Mon, 2 Dec 2024 15:17:08 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
 <20241202100334.454599a7@fedora.home>
 <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
 <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> To get two such PHYs talk to each other, one of the two has to be manually configured as slave.
>> (e.g. ethtool -s tsn0 master-slave forced-slave).
> 
> I don't see what that has to do with whether AN is enabled or not.
> Forcing master/slave mode is normally independent of whether AN is
> enabled.
> 
> There's four modes for it. MASTER_PREFERRED - this causes the PHY to
> generate a seed that gives a higher chance that it will be chosen as
> the master. SLAVE_PREFERRED - ditto but biased towards being a slace.
> MASTER_FORCE and SLAVE_FORCE does what it says on the tin.
> 
> We may not be implementing this for clause 45 PHYs.

Right now, 'ethtool -s tsn0 master-slave forced-slave' causes a call to driver's ethtool 
set_link_ksettings method. Which does error out for me because at the call time, speed field is 2500.

Do you mean that the actual issue is elsewhere, e.g. the 2.5G PHY driver must not ever allow 
configuration without autoneg?  Also for Base-T1?

Nikita

