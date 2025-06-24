Return-Path: <netdev+bounces-200539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FC5AE5F9D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6241920CCB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F6259CA0;
	Tue, 24 Jun 2025 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8p6f8aX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEE72586CA
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754380; cv=none; b=gB8QXmfVUZHjaD9N+uuLGXI5htxY54eT7ixebYbu+GB8wJUHC1csDd0vcbtlVYTSX1hZaQBOKmNjsBAAJgrnwKq3v6zhOv4Im9vmDXgmRIKEaZ+pCZf/J0V1m4JaQp7lToQrBxCpSKzOnXOEL6F/O+rX/YqXh1BgxUsGEngTPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754380; c=relaxed/simple;
	bh=DVsCUdKVYcsFTKatDm5synRnxfD9Fb+XLA6NRENVAIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5y5/ncZk586jEO6Ek9NYW5mb6nV/tdQLORdasqLqa0d1a89hRvHtPiNND5vHXsnlThMjAzEuiWo5wHiFfy8fVUR18s8TMc8XSqA/jQxsefpMe+oNApz7bcKz2yqyOHZJ7CbzCDJsxHM8+O2xQ8juo3rFxO44HZk4oSQXd2psiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8p6f8aX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750754376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onzA+wcTvsJpzeYf5prB/BcDYizuukYIYq67f2ch1FM=;
	b=b8p6f8aXzWbAgdBgadtXEYfBiXmBXrIZpbm5pfejeZXOpJFYHaRQNDRqx04xflO2A0LrlP
	cX41RFi/RigBcllOf5u6aOnU4IsVL0i3RxS6u0ZWhfJAjMd9vhT0qmMp5q+LKDrMxAS84U
	CWX3M6gwVj3cEwmCkk/sYzISLPQWm6Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-ZGkPe6OkP0GGOuxJbUf2Xg-1; Tue, 24 Jun 2025 04:39:35 -0400
X-MC-Unique: ZGkPe6OkP0GGOuxJbUf2Xg-1
X-Mimecast-MFC-AGG-ID: ZGkPe6OkP0GGOuxJbUf2Xg_1750754374
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so2506918f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 01:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750754374; x=1751359174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onzA+wcTvsJpzeYf5prB/BcDYizuukYIYq67f2ch1FM=;
        b=jCSuLt+bBhq2fBCpDEyX9GSGLZ3p36f05wl63YjczusPoXi2MTglBW+L/Mgibd5iBp
         9kPA4UHeG1TzUkX0rNgryl2i++6QVNIqrs4tLqoOMzh2O9V1zahYODL92R1Cq+MXfazq
         QixAVWRRtx1imGjSnrF3MohAuGe6gzy/dBnCqW8h45LZGBrAqL1m0Bh23r+f6VPaqZii
         tb+/m+6zwEi5T1cUqGsK18NwmPGGUV7+8ZAyRMUgWE208jZDaV6MJlx0l3zMNebh4tWy
         Z0LVDJQ3VxDB7Jb7S7QyXTbLn9+/u0MjxSnOp288TmoDoNluXwmhGP5vZVZCjQ/c+3Ka
         UvEg==
X-Forwarded-Encrypted: i=1; AJvYcCVpcgsvlM/4pd4HJz8Wh8O/C2osz19ZtEomdQOu8jQBFc7Q5bd3qrP1tlk+w3SRSU8wSZVUoao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkgPMeUnl8RevNrqziSoeaNzg3mMYDbn6BzbSbfCqtIAHZs3Iz
	HqRkgu30XamH5WYGGOLX9sCY81iZn9nR7UoB70/jI5w0X9HABOHpqQoEOzx7hL3pWA3CAHFU/KA
	BvffeGVAt0bUcSByFkmBxvhtOJSKcENmEZC8a5J1pyx468zJcYFzMgI9+EA==
X-Gm-Gg: ASbGncs3QxaESP0Z6iEZhwBKeSdZt60N3dv3PTU6BKmPnsNQEDkgPLHsX5ACppkJIKx
	x0DMyEiOxxs2/jAx/nsk9tO69oj49OPAJbOHGdR6hPUSxEHx6Olqitsu4cCpMrNqHHAILS15n6o
	ebgFVWyUAzlOeTpUTP1OVxFFRRjo1nt6E8w2g/8wTPDSryjzDaCZNtZjtRn5T3AKu8rpanaTqnX
	3uSAPLdnEIUJOqOxKg0kKvKOEK/En30VStu9J9BWwHSAVywF78wTQ38Y6ReUjXs642/93soXRRq
	aGxCGbzqDuPeb8gm8TjTrNH27lNNtg==
X-Received: by 2002:a05:6000:220e:b0:3a4:fb7e:5fa6 with SMTP id ffacd0b85a97d-3a6d128a495mr12354814f8f.1.1750754373873;
        Tue, 24 Jun 2025 01:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXACAuieXnf1ff0n3aChzXI+RXODXJppEWVes06kAMCgYriTZilclAie3vgKCk9utLq6WSPw==
X-Received: by 2002:a05:6000:220e:b0:3a4:fb7e:5fa6 with SMTP id ffacd0b85a97d-3a6d128a495mr12354781f8f.1.1750754373434;
        Tue, 24 Jun 2025 01:39:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e810977esm1319156f8f.83.2025.06.24.01.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 01:39:33 -0700 (PDT)
Message-ID: <8d5c6585-bc49-498d-9bb9-91d02e8e793f@redhat.com>
Date: Tue, 24 Jun 2025 10:39:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] phy: micrel: add Signal Quality Indicator
 (SQI) support for KSZ9477 switch PHYs
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
References: <20250619133437.1373087-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250619133437.1373087-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/19/25 3:34 PM, Oleksij Rempel wrote:
> The KSZ9477 family of switch chips integrates PHYs that support a
> Signal Quality Indicator (SQI) feature. This feature provides a
> relative measure of receive signal quality, which approximates the
> signal-to-noise ratio and can help detect degraded cabling or
> noisy environments.
> 
> This commit implements the .get_sqi callback for these embedded PHYs
> in the Micrel PHY driver. It uses the MMD PMA/PMD device registers
> (0x01, 0xAC–0xAF) to read raw SQI values from each channel.
> 
> According to the KSZ9477S datasheet (DS00002392C), section 4.1.11:
>   - SQI registers update every 2 µs.
>   - Readings can vary significantly even in stable conditions.
>   - Averaging 30–50 samples is recommended for reliable results.
> 
> The implementation:
>   - Averages 40 samples per channel, with 3 µs delay between reads.
>   - Polls only channel A for 100BASE-TX links.
>   - Polls all four channels (A–D) for 1000BASE-T links.
>   - Returns the *worst* quality (highest raw SQI), inverted to match
>     the Linux convention where higher SQI indicates better signal quality.
> 
> Since there is no direct MDIO access to the PHYs, communication occurs
> via SPI, I2C, or MDIO interfaces with the switch core, which then provides
> an emulated MDIO bus to the integrated PHYs. Due to this level of
> indirection, and the number of reads required for stable SQI sampling,
> read latency becomes noticeable.
> 
> For example, on an i.MX8MP platform with a KSZ9893R switch connected
> via SPI, invoking `ethtool` to read the link status takes approximately
> 200 ms when SQI support is enabled.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> 
> This commit currently focuses on single-channel SQI support due to
> budget constraints that prevent immediate extension of the SQI API for
> full multichannel functionality. Despite this limitation, the feature
> still significantly improves diagnostic capabilities for users, and I
> intend to upstream it in its current form.

AFAICS the commit message reflects the 'wannabe'/future implementation
and not the actual one included into this patch.

I think you should reword the commit message, describing the current
implementation.

Also it looks like the SQI value is not inverted, I'm unsure if you
should update the commit message accordingly or actually do the invert
in the code.

Thanks,

Paolo


