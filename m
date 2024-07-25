Return-Path: <netdev+bounces-113084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4A93C9D0
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742A91C21EA1
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 20:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A1413CA93;
	Thu, 25 Jul 2024 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mentovai.com header.i=@mentovai.com header.b="UlcBtrw5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7301A208A5
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940483; cv=none; b=GgM0CactDbaYI/FvUD4aDbTyPIC3ujyeLxvcZZG0Q0dOEpPYN7aUmEmY+4h13D6d6YY9fRri2U4R3KMmpXgsibeGYPWnxhxCgUsK13R62911awmCTqalyDcd41rQ7sUr0+RmbuTU5BxMcDW3J5S/odqlQ8P45U/x7QVqSxY6wHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940483; c=relaxed/simple;
	bh=tCc7yzfwMwX+3wHm11uN8y+ogivJbHvtbMIOTwN5S10=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fuq98m1Es3+xB9uXjjGdg4NtWX+90lWUo+OsHTnnFb2Mh4tlQhAO3sc1VjejixdYx/T5xDEGqouE7scIHvuoNhij3I2sLG/oj0Ofd9wTs0P10mOpvTp4K9k29ngT9nYSa3EpYoXQEaNQfnKFos7sMGFPECtwl5PmMfnjUaxCcNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mentovai.com; spf=pass smtp.mailfrom=mentovai.com; dkim=pass (1024-bit key) header.d=mentovai.com header.i=@mentovai.com header.b=UlcBtrw5; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mentovai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentovai.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so8147626d6.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mentovai.com; s=google; t=1721940479; x=1722545279; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDVR3WOcutJRJbF1ISjhWZ6SEFHi8sF6jbKuLCY1/p4=;
        b=UlcBtrw57z5DFff+al+sZ6OH4r7jSvQ1alrf8cRDyoul4s2UJoxT2MOKRpnd4LiVJ/
         6pAZRjGUmdvQVKRQVqZUiQsiSeMTC/eIwYL1TgMMBKlQVO6a68u64X2FFu7LHMkpLW3y
         FqH9Gz41cotWh7/pccCr4XvPiJ2m/JNBVXuQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721940479; x=1722545279;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDVR3WOcutJRJbF1ISjhWZ6SEFHi8sF6jbKuLCY1/p4=;
        b=qUEerLDkS8B4l+bV+yk0b1zsQ5uSy6cAziyMfoKfVmlYWyOidd68J5Td4/KKdAkw3c
         pRT13Jp6xhiY2FtAobBOrDc253v3Ot3va2be1H6+asenEz+waNXTTq9b3aY3jk15rfSq
         bWka9k26vABjeNNDblnu1FNOVQhCH4cZjAg0QUjCso+g1d07mmiJY3T5Lqos+XprYoFt
         F+bmGCida8kClna9cCBmPVdcRRFQJk/L39sfl86YkBSbzdkz5KbrHJz/q0t9uhihjMeQ
         famkVlwVMDEKo7S9CH9Kqs9niGMvjYA8kk6PirzrzAckhMql5a9Dc/FZiUCDxc1HMECE
         ZclA==
X-Gm-Message-State: AOJu0Yyqh39AmY/hTnokSFQoY35Lln4sYNxVgITReP6FuXSl8wkpDhHp
	60s15YwcyhXC9jAIfDjo1YN3/6Y5yM+B8hQydPPgvZA5DX+Z9GGj1Yzrn1KQe14=
X-Google-Smtp-Source: AGHT+IFiCqO0eALgHXDnMjwjSkiPUpvhtE5QV3jaP735DrNnryAZp59sy10aVVD1GnajR0Hgb6fSEg==
X-Received: by 2002:a05:6214:1c07:b0:6b9:5b57:f690 with SMTP id 6a1803df08f44-6bb3ca2fe58mr49398106d6.25.1721940479206;
        Thu, 25 Jul 2024 13:47:59 -0700 (PDT)
Received: from [2600:4040:9ce0:6400:a8a9:9eca:3c60:83f7] ([2600:4040:9ce0:6400:a8a9:9eca:3c60:83f7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3facb1e9sm10380386d6.119.2024.07.25.13.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 13:47:58 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:47:57 -0400 (EDT)
From: Mark Mentovai <mark@mentovai.com>
To: Simon Horman <horms@kernel.org>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Oleksij Rempel <o.rempel@pengutronix.de>, 
    Jonas Gorski <jonas.gorski@gmail.com>, 
    Russell Senior <russell@personaltelco.net>, 
    =?ISO-8859-15?Q?L=F3r=E1nd_Horv=E1th?= <lorand.horvath82@gmail.com>, 
    Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
    Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH] net: phy: realtek: add support for RTL8366S Gigabit
 PHY
In-Reply-To: <20240725200143.GM97837@kernel.org>
Message-ID: <cb4710ff-c55c-e7e7-487d-a0e1c6f10972@mentovai.com>
References: <20240725170519.43401-1-mark@mentovai.com> <20240725200143.GM97837@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Simon Horman wrote:
> On Thu, Jul 25, 2024 at 01:05:19PM -0400, Mark Mentovai wrote:
>> The PHY built in to the Realtek RTL8366S switch controller was
>> previously supported by genphy_driver. This PHY does not implement MMD
>> operations. Since 9b01c885be36 (2023-02-13, in 6.3), MMD register reads
>> have been made during phy_probe to determine EEE support. For
>> genphy_driver, these reads are transformed into 802.3 annex 22D clause
>> 45-over-clause 22 mmd_phy_indirect operations that perform MII register
>> writes to MII_MMD_CTRL and MII_MMD_DATA. This overwrites those two MII
>> registers, which on this PHY are reserved and have another function,
>> rendering the PHY unusable while so configured.
>>
>> Proper support for this PHY is restored by providing a phy_driver that
>> declares MMD operations as unsupported by using the helper functions
>> provided for that purpose, while remaining otherwise identical to
>> genphy_driver.
>>
>> Fixes: 9b01c885be36 ("net: phy: c22: migrate to genphy_c45_write_eee_adv()")
>> Fixes: https://github.com/openwrt/openwrt/issues/15981
>
> nit: AFAIK, the line immediately above is not a correct use of the Fixes
>     tag. I think Link or Closes would be appropriate instead.
>
>> Link: https://github.com/openwrt/openwrt/issues/15739
>> Reported-by: Russell Senior <russell@personaltelco.net>
>> Signed-off-by: Mark Mentovai <mark@mentovai.com>
>
> Also, as a fix, this should be targeted at the net tree.
>
> 	Subject: [PATCH net] ...
>
> Please see https://docs.kernel.org/process/maintainer-netdev.html

Thanks for your feedback, Simon. I've sent an updated (v2) patch, now at 
https://lore.kernel.org/netdev/20240725204147.69730-1-mark@mentovai.com/.

