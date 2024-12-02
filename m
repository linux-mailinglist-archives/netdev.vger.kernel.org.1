Return-Path: <netdev+bounces-148141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 073479E0879
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A6517968E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D62278C60;
	Mon,  2 Dec 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="PCIWgvSh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9901BA53
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154715; cv=none; b=LpyS030760D4xqfvb1VqHXuryUO/zPuERmSLjHIpE9itOkEe+87h2vRHDp85lyusSLoKG98nVWWVdQDIfZqTv7luQGbMkSgLAsqFO91Y3Vb0NP7s2YaUI0ZEPFRB7+/WIQfeqJGvyKHYmfEfC/OX9z9GNrwfjxRGqYunEDldBZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154715; c=relaxed/simple;
	bh=bL3/xzhTDbzbGTJgjVxoz7qT0Bj5FKuFqnagataC9Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPl1+0Zt3Re9fOIfqsE4uEtN4odb9vKELMEbr9UXaVVpeJKrCx4b5jB+yNqXT1BvDuAjb0qw/+jEr9OJcxZs1wz2n3M61+5bhKpFTtgGQq5bCFr+Dgpl4XnkPbcjJVyF1hMynTLb/hy9EN6wgoJcJ80QvtnYZ7TJzA0nMMvhrXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=PCIWgvSh; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53dde4f0f23so4392900e87.3
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 07:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733154712; x=1733759512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPftgg43bq9aqu/m+EeNtGmhyyKJMhRNkMNK3b+tQes=;
        b=PCIWgvShtXlV7oMfezCNXJfVLunDJ7WaTfheu4p3Bz7RE5lCgh/DW3Pqibw3fRCZsJ
         +nZmCf6vDXL+LHUJfMOoYvhNqKicsmFu18dd7W+Ac+9TSELrfoPsG0bNJca5lVr/UtLm
         WXLizMpwWAecikmfVjFWOH9nTTgkxsUwovzDRy0QZZoCCIq+dmW3I+BYoAFB7nnF9Jom
         P7J0fu0za5EtB+2+nE6byPDSqLCFDFveIAG+G9CidfSVaVDtbt9Rsf9RTJ0iM4fsBv5d
         t6SzFexAElLvtl8cFyyUeiW5eTM4jNEMYHoppwV384MEE3S/bq/CIcsZ+yLi5VvB7kKA
         SnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154712; x=1733759512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPftgg43bq9aqu/m+EeNtGmhyyKJMhRNkMNK3b+tQes=;
        b=CCKwg5OVTa32ylaEbZHanL77cWDma/2pWTJNPTW6nb92cmirw6u1CuDYnn4U8iaWth
         q0IpU8xLbj4vIaIt9apfno3V16tAyLsoDPjfrzao+6QaIDH5ThQmIvOvfhlT+ni2ffZd
         B/h9/+ZkpQHN7DQHICewUyKze7ifcwpqwCJsSviefCLqWEjgn7JnfgWqGPmxwgNE1yip
         Zx99BYvDWswkLzGNZFkr2MFhndpXMC/DOlV1dUBpriRzQfvnPq6YBeGn5N+GCEDcYIlS
         YUpbV2r832cfTGFiiYwjQXQDzUcQbRX4nUwok2pHFc4nGFnYsaIS/aRdaUex0CB8crhP
         vIog==
X-Forwarded-Encrypted: i=1; AJvYcCWdoMOO0p5+eC8CnsC8SwNXNxymIHit+ffZy1PKab+vlzE0l4rAQTSfNDL+Fnv4b/EnCkSD1mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0P5GTVVLucEFCLL96rLWgKpjeIoN7ddUQqOAkHpq5LjYbZ9JD
	oJLvDYLaor4fAHrPUoTjf+gW0neaIUjSyp/3qQAzgWulp58+gK7Klw8+AOjmBFU=
X-Gm-Gg: ASbGncsJCB7vy6yupuD8dEIrSSf0SbOPwxlV9ZFPCZwUrg/X+oiXJLP4gLgszyz747E
	TgHo57Osh3I8DqDpW9V+X4km2y9ZcPuOC4bkZvfZ8cHTWy5oeAso83IsK/0M9SwDVxNd7Gjjt7y
	sXbPAsUYsKLmUOzDA3xq0g7iGzmu3Agi4r3g67ICNgz6pLK3x0EMKKjNR/hiQCEytxICsGuRGjk
	PThCepzuBPxnKHS6tno7x/ihLhR5af6UpeTCwISXmOPqOC6v/wFDow2EN5G4xyKeUbPtA==
X-Google-Smtp-Source: AGHT+IFwu/0m7FiwxwnmhV7gn9N4KqSQds8K2MDB//YnOhqAjuo10Y4Tx57ncNF0LbVlOwX5NtHLsw==
X-Received: by 2002:a05:6512:3d1d:b0:53d:a99e:b768 with SMTP id 2adb3069b0e04-53df00d9666mr11899727e87.25.1733154711811;
        Mon, 02 Dec 2024 07:51:51 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64311c0sm1502693e87.21.2024.12.02.07.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 07:51:51 -0800 (PST)
Message-ID: <5cef26d0-b24f-48c6-a5e0-f7c9bd0cefec@cogentembedded.com>
Date: Mon, 2 Dec 2024 20:51:44 +0500
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
 <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
 <Z02KoULvRqMQbxR3@shell.armlinux.org.uk>
 <c1296735-81be-4f7d-a601-bc1a3718a6a2@cogentembedded.com>
 <Z02oTJgl1Ldw8J6X@shell.armlinux.org.uk>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <Z02oTJgl1Ldw8J6X@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> root@vc4-033:~# ethtool tsn0
>> Settings for tsn0:
>>          Supported ports: [ MII ]
>>          Supported link modes:   2500baseT/Full
>>          Supported pause frame use: Symmetric Receive-only
>>          Supports auto-negotiation: No
> 
> Okay, the PHY can apparently only operate in fixed mode, although I
> would suggest checking that is actually the case. I suspect that may
> be a driver bug, especially as...

My contacts from Renesas say that this PHY chip is an engineering sample.

I'm not sure about the origin of "driver" for this. I did not look inside before, but now I did, and it 
is almost completely a stub. Even no init sequence. The only hw operations that this stub does are
(1) reading bit 0 of register 1.0901 and returning it as link status (phydev->link),
(2) reading bit 0 of register 1.0000 and returning it as master/slave setting (phydev->master_slave_get 
/ phydev->master_slave_state)
(3) applying phydev->master_slave_set via writing to bit 0 of register 1.0000 and then writing 0x200 to 
register 7.0200

Per standard, writing 0x200 to 7.0200 is autoneg restart, however bit 0 of 1.0000 has nothing to do with 
master/slave. So what device actually does is unclear. Just a black box that provides 2.5G Base-T1 
signalling, and software-wise can only report link and accept master-slave configuration.

Not sure if supporting this sort of black box worths kernel changes.


> it changes phydev->duplex, which is _not_ supposed to happen if
> negotiation has been disabled.

There are no writes to phydev->duplex inside the "driver".
Something in the phy core is changing it.

