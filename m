Return-Path: <netdev+bounces-107578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7C491B9CC
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0131F21C8F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 08:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25E7147C89;
	Fri, 28 Jun 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EW9y3gju"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCA1465A1;
	Fri, 28 Jun 2024 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563160; cv=none; b=Q52HYXqkMWq3/QWGBRlYeCVJATFeXQixLABJdU7dAEcP7S1WT9KkcoJeuEG6W7bFV6UT0D83eXEeaUFl7Tsp+YpUaD1DmhKQMOG4DM1W9PHSlXn8UYYWD9Pj4IvLreVcBtLKQ+1T0HJd/viKs8IpPccXyNeB9+w7PVfZw+YFBaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563160; c=relaxed/simple;
	bh=sIThu4RsJgh+VwNWwKGYg2+M0IPZoD4CXmMJN4bFwDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTg3vHAZooHSrNCPR3bBtfrTwbQEUS8uISobS2lny35j9x34655IEYD62GoHiXv5vW5BccW8faugD/Uy+TbylhxqhbajXR96PLf2W31ryUYYG1GOePQfumxhL9RtEyQ4FA+XJqQJczlVVe4Rb2ohjM0ktuVmbaog9nw90TYmVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EW9y3gju; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b593387daaso11611736d6.1;
        Fri, 28 Jun 2024 01:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719563158; x=1720167958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LUMCOCYwhIHrEihfrDAlx0gwzr1mMEoKcIscYrLjAqA=;
        b=EW9y3gjugSK9fq7iPH7+/P8eTpQt730lmIgFMwii3cBX4ov+bpMCJMJEI6KlBfraX4
         KUCmKo5CadSuT+UZFWtTUXFqhHWaXkayxsjlyEIcdPeD2D3WoAA2uMym6ZayjKLnM2vE
         txWtlQuZEkUU2CmLkV0ia1GckFUv13KI1KHKillXQ3DZ2UlUwtqGIweO8rGJFEkFasnp
         N8ehkBfRBoNTvxqB8biBgDtAHt1UBksI/r+9r8dH/b9IRyBscOkVeMEGVwpUaVJnqsmh
         Cyavm8B4gcAGDxHKx3hP442OsXO77SNYCQ6C6pG4ndyEgIANM5ffcjs0SoYceLREd71D
         m3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719563158; x=1720167958;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUMCOCYwhIHrEihfrDAlx0gwzr1mMEoKcIscYrLjAqA=;
        b=OToniFdbbQ+7wqWA3fjTtdQYE1je/iViixCS0jJJbNHbQXuXsp1vAoFvMbCwUdHGk4
         Jpep5nL27eZq2IyBcjfCOkzeCQ6TgAXIVwSxNGOth8dYdl0QMT2k0X5u7Q4kgqSxJ1cY
         j7UJlfeJech0AaxX3ws6EHaqQY0k0qmuM+f537TLP/neVtMYNlFW/su/CHisBvYBXo27
         T2JVzvurKP1pGndQ+m9eLbusDVf6tmMKmDqQBByvkdzBeWqM7+adFKsOYj9r6aPqKBhj
         bov7p01l1Z8GMNVavwf2xudK5MZy2h4uCGaV3FJPeiPwds31rqiU0lXvsGr2DYpzwObv
         KUGA==
X-Forwarded-Encrypted: i=1; AJvYcCWhuqQxjDJhtnTYyDkcIcC0UMYTsGBSaidGEmcrCaTX9+rYDn/IFn7Rjfa8Y9dvrz5i+KdfjuFqYNEWEv1zvnWaAqcAiV1w7k4n5URng8WoPwQNnLzDB1U+JpE/Fwt5dlg48kOc
X-Gm-Message-State: AOJu0YyAhRzX0v3DJgEoOZmkIPQurs3PoIZ4b/zRaEw1w9c+SDgAeKKc
	g5nHQySzJ9pEttve+SXD9RtQ/ZmrljuFoBhIkaBm1HMSw39ZpS1A
X-Google-Smtp-Source: AGHT+IGixB5tdagxrKAyAqo+iLjpOBxoH8NowLyTRi/7B8DkulAVvza6YtLcilGVCJkfaYCNTpHkvA==
X-Received: by 2002:a05:6214:21a1:b0:6b4:f7bb:6d69 with SMTP id 6a1803df08f44-6b5a546117fmr13228226d6.32.1719563158013;
        Fri, 28 Jun 2024 01:25:58 -0700 (PDT)
Received: from [192.168.3.22] (89-145-235-100.xdsl.murphx.net. [89.145.235.100])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e615b8csm5937896d6.123.2024.06.28.01.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 01:25:56 -0700 (PDT)
Message-ID: <249879ad-aa97-452c-a173-65255818d2d4@gmail.com>
Date: Fri, 28 Jun 2024 09:25:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: phy_device: fix PHY WOL enabled, PM failed to
 suspend
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Youwan Wang <youwan@nfschina.com>, andrew@lunn.ch
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240628060318.458925-1-youwan@nfschina.com>
 <Zn5xmMpTLK/fRoYh@shell.armlinux.org.uk>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <Zn5xmMpTLK/fRoYh@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/28/2024 9:17 AM, Russell King (Oracle) wrote:
> On Fri, Jun 28, 2024 at 02:03:18PM +0800, Youwan Wang wrote:
>> If the PHY of the mido bus is enabled with Wake-on-LAN (WOL),
>> we cannot suspend the PHY. Although the WOL status has been
>> checked in phy_suspend(), returning -EBUSY(-16) would cause
>> the Power Management (PM) to fail to suspend. Since
>> phy_suspend() is an exported symbol (EXPORT_SYMBOL),
>> timely error reporting is needed. Therefore, an additional
>> check is performed here. If the PHY of the mido bus is enabled
>> with WOL, we skip calling phy_suspend() to avoid PM failure.
>>
>> log:
>> [  322.631362] OOM killer disabled.
>> [  322.631364] Freezing remaining freezable tasks
>> [  322.632536] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>> [  322.632540] printk: Suspending console(s) (use no_console_suspend to debug)
>> [  322.633052] YT8521 Gigabit Ethernet stmmac-0:01:
>> PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x110 [libphy] returns -16
>> [  322.633071] YT8521 Gigabit Ethernet stmmac-0:01:
>> PM: failed to suspend: error -16
>> [  322.669699] PM: Some devices failed to suspend, or early wake event detected
>> [  322.669949] OOM killer enabled.
>> [  322.669951] Restarting tasks ... done.
>> [  322.671008] random: crng reseeded on system resumption
>> [  322.671014] PM: suspend exit
>>
>> If the YT8521 driver adds phydrv->flags, ask the YT8521 driver to process
>> WOL at suspend and resume time, the phydev->suspended_by_mdio_bus=1
>> flag would cause the resume failure.

Did you mean to write that if the YT8521 PHY driver entry set the 
PHY_ALWAYS_CALL_SUSPEND flag, then it would cause an error during 
resume? If so, why is that?

> 
> I think the reason this is happening is because the PHY has WoL enabled
> on it without the kernel/netdev driver being aware that WoL is enabled.
> Thus, mdio_bus_phy_may_suspend() returns true, allowing the suspend to
> happen, but then we find unexpectedly that WoL is enabled on the PHY.
> 
> However, whenever a user configures WoL, netdev->wol_enabled will be
> set when _any_ WoL mode is enabled and cleared only if all WoL modes
> are disabled.
> 
> Thus, what we have is a de-sync between the kernel state and hardware
> state, leading to the suspend failing.
> 
> I don't see anything in the motorcomm driver that requires suspend
> if WoL is enabled - yt8521_suspend() first checks to see whether WoL
> is enabled, and exits if it is.
> 
> Andrew - how do you feel about reading the WoL state from the PHY and
> setting netdev->wol_enabled if any WoL is enabled on the PHY? That
> would mean that the netdev's WoL state is consistent with the PHY
> whether or not the user has configured WoL.

Would not the situation described here be solved by having the Motorcomm 
PHY driver set PHY_ALWAYS_CALL_SUSPEND since it deals with checking 
whether WoL is enabled or not and will just return then.
-- 
Florian

