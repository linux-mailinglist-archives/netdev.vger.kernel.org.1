Return-Path: <netdev+bounces-148319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212009E11AA
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 839F7B21EA5
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0D41487CD;
	Tue,  3 Dec 2024 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvfvBt90"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A904364AE;
	Tue,  3 Dec 2024 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196119; cv=none; b=l+YXpukp8CZ2NtOtTGo72uRhZDFV9b5C5Pq1KXIcYPrYr0zjLVZdttJs/jRQ7QjFCweeK4VZSuJfhP/DZk4D2Kn54Tt3uW0pUPBMgJLc/gStBoNoJZgfegpqu6KtdoEwPmvFZezFOo7rA47DfspxfloZA6gf26L4Gx1/WPRSZqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196119; c=relaxed/simple;
	bh=ZRcKUNedk1GDyYSccCn0F+Pv+MiUmfBEW5IAFUVkzHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjgWaor+95d07/eS51hLBM3XSCD0Gb28QaJYq2BoInRVPgjOFN+UW0pK8/vheA/VhswQWv5eJduJwDZ4xy4I4noLLsAaodK0+Fy8VlgAFtNvOqEjQYCpCDRCObURwygAkucw4xgB2rM86F/AFYQ28DEl472yhXDvBNmq8VQRG1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvfvBt90; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4add8596cccso135560137.0;
        Mon, 02 Dec 2024 19:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733196117; x=1733800917; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YXgZno5E0Mtpt3tZxp1yeQ8UkXHQMFfEwMCjpQKv8U4=;
        b=FvfvBt90gXSQwYg4uBMivJ7V1hOu62UV+xT05RnMGEEG4gMnQJwdcaPsxH+8RSKCb3
         +Sm7aVb8SM3OhjQ83fVDkNinBQWeiUcQYXzK7QjclH8zeICEBfgdE5Yoe7rtDlmsOE8r
         i9NwmgxnqPG6ubbUuhLkSysnsLWZg5NErDap2u2HDSE+pTzx2CCWyi4GgNdcG0Pypg0B
         JISR/OA/Bb0v3rss6TFthLsST6Hyz96VrRlsiYXRmmtxvm5no73NpLv86THzGt6NCRPw
         PFUSVJjfoBj50rEqKeFRy0ugTsK8xtynrTjNgJ70Vi1dp8ZPIsGyErmeVQmbADMGGgYs
         YKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196117; x=1733800917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXgZno5E0Mtpt3tZxp1yeQ8UkXHQMFfEwMCjpQKv8U4=;
        b=KdvuFoyFkNg7646jyoCasnWsV1bGF9UY8wCbDVXEe5jDfxo3LanaPPpap2byl/JsHO
         XHZ7cNYE15ilPD6+/YPDB1HI6w8JSFxctg20FL3ayj7Bsj2yeUSYt6k1TGIKmJT+bOkg
         xR1eJ/qukA25ewuVnCnhWrX1CoTkl3adsgGa15GdGrMeS89nHNe4Qdge61eB4VtGK13o
         MNDXjXjL9GN4VCjj1pabdsBW1Mrkdc73pQgKI+hZVTxoPE746kRLPzNWeFAFxqtFt8Kd
         seOPtaYfmrN9u8LvM90NQatsEuqydTt7lOUlNe/WtDztJYOk2LCglvACg3PlONjJUFxC
         9Stw==
X-Forwarded-Encrypted: i=1; AJvYcCU+wDb1X7OA3Q3BEn/4i87nnxc/IFxhuFV77shm7UF+udRE7Wvp95R6P66bWxqpEvSed4rilHm3@vger.kernel.org, AJvYcCXf7Z6w4IxgDUDo/vG1WC6dARy8Jmjo10or+ZgWdKGBIlOC6ghOU3elAYHleiIweEaZk7LfcLqiTj7GWKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOdj1GrkMOVJcFkyO8PXJLbDcLPxBYdXPcza3qt4E4jCRqjdk
	v90Wz2U8ltwGYfgD2J5DzoVOlnMkLUkUxiNU5N8gCN7EVtb0kMklMjjLcjT6HPbl4OSWTKm0fLu
	1wEOp/AcVC1BRD9t0XT43z6fwv691F5ggdD++Aw==
X-Gm-Gg: ASbGncu2k/Fr+8LVkbTJuFH+QYN5QfyeGMKkWr0ZrZbg/Y1m5HXgtVRf6/L4ePQ4/CY
	oZtXVRTk5CbfWWXK/DkZzWWti7dQnsbc=
X-Google-Smtp-Source: AGHT+IF7a9G8GmstZl1OCWwnWy4CuZjj181/rGk/t0my5kfWwR/shpsKoSGiiJSxTL9PypMxiXc6QxXKxf8vzzaFKLQ=
X-Received: by 2002:a05:6102:2924:b0:4af:4bc9:7872 with SMTP id
 ada2fe7eead31-4af9719ad21mr655154137.4.1733196117397; Mon, 02 Dec 2024
 19:21:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHwZ4N0gbTvXFYCawbOUFWk7yitTeAWwUmfmb7RU68n-md8x4Q@mail.gmail.com>
 <ae46016c-c391-42c1-854e-075e7ee03a62@lunn.ch>
In-Reply-To: <ae46016c-c391-42c1-854e-075e7ee03a62@lunn.ch>
From: =?UTF-8?B?5LiH6Ie06L+c?= <kmlinuxm@gmail.com>
Date: Tue, 3 Dec 2024 11:21:47 +0800
Message-ID: <CAHwZ4N3rPCtXMUW1R_1zs14G-2wyOQnTOH+hqryE+7rq7013fg@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: phy: realtek: add dt property to disable
 broadcast PHY address
To: Andrew Lunn <andrew@lunn.ch>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willy.liu@realtek.com, Yuki Lee <febrieac@outlook.com>
Content-Type: text/plain; charset="UTF-8"

At 2024/12/3 10:54, Andrew Lunn wrote:
>>> I think you can do this without needing a new property. The DT binding
>>> has:
>>>
>>>             reg = <4>;
>>>
>>> This is the address the PHY should respond on. If reg is not 0, then
>>> broadcast is not wanted.
>>>
>> First, broadcast has no relationship with PHY address, it allows MAC
>> broadcast command to all supported PHY on the MDIO bus.
>>
>> I can't assume that there's no user use this feature to configure multiple
>> PHY devices (e.g. there's like 3 or more PHYs on board, their address
>> represented as 1, 2, 3. When this feature is enabled (default behavior),
>> users can send commands to address 0 to configure common parameters shared
>> by these PHYs) at the same time.
>
> phylib does not do that. Each PHY is considered a single entity. User
> space could in theory do it via phy_do_ioctl(), but that is a very
> risky thing to do, there is no locking, and you are likely to confuse
> phylib and/or the PHY driver.
>
> So we don't actually need the broadcast feature.
>
>> Again, the broadcast address is shared by all PHYs on MDIO which
>> support this feature, it's handy for MAC to change multiple PHYs
>> setting at the same time.
>
> Please point me at a MAC driver doing this.
>

I know some cursed user-mode program do that but seems no kernel driver
doing this.

>> I would recommend to add this feature, because it doesn't change the
>> behavior of this driver, and allows this PHY works together with
>> other PHY or switch chip which don't support this feature, like mt7530 or
>> Marvell ones.
>
> I agree we should be disabling this when it is safe to disable, but i
> don't agree we need a new property, reg is sufficient.
>
Okay, so I will left PHYAD == 0 stay untouched, and PHYAD != 0 disables
broadcast feature.
>       Andrew
Sincerely,

Zhiyuan Wan

