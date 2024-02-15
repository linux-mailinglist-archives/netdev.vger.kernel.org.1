Return-Path: <netdev+bounces-72192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13D7856E90
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 21:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD2228D853
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 20:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DF113AA50;
	Thu, 15 Feb 2024 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F44w5eoI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522BB136995
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028857; cv=none; b=oDDgvRZ/bbzRBBelhPlWNdriZSBlrs57T0ri5yKEk5fYPkH6+TFRBamI5vDD+BYNNEqpiEURFVPx+UcaHVMW8MrVAZ1tfL+EAO1IpPytOJsXnndpkoYq+thYYo7OgR/8B38FaSTUFZtBwrztLD45WqhaBY2ZwSS9ZlsmQ5d8ZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028857; c=relaxed/simple;
	bh=j0Kn19OE0ShvL90dVY2gUP12sqEGjTaw6rvncGmulDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSRr4R3c5n82btul8zUV6EfJqxUc/rn5/Lt82kaeqMOtYswOobvcMYI6SncnNsi7dblKICcNh46aE1hv45uKy9mGdSMtbRihNT1Gv5cWWIVMIzJnccXfBdmSw8UuageFDcYlFcdyX03vt9wWIk8W8aOKpJw5BwNhuMS1dnyAvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F44w5eoI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so921231fa.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708028853; x=1708633653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn9wXfspaGxVUQMj/WjiA4hlQBijZtw6uxWPUNcztlo=;
        b=F44w5eoI7wE1sbrMQ0kT21sjUsMLXXJXkLxwAXT8t/Mutjopmkm+G6BCIsCbvPNgiB
         pP3kTxXkXSP9qq9F00QwsKnMYw/F1NQmXpHcMZz+szfxkmqA/2ZVSlYN52/MBZKH85Rh
         HXn4JDGWcIdSbdZJlN6DWerqJd5uF0RxHKpQ1yIDdJiWoy125bRbDLB8WBTJ9ZksS4rd
         lK1VCxOXYX+zdydZrs91NXsYjQNnB/LNjvoKiG2L7n5LHi+2YP15sJgJ9gsedXzohoiX
         QrbDqQb+EVZD0ETEptLp+CjGIDTgB5jzIpEl6x8uT4BRgBpmaXEgdMQyb3bcUoD1qzMd
         SzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708028853; x=1708633653;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn9wXfspaGxVUQMj/WjiA4hlQBijZtw6uxWPUNcztlo=;
        b=lo36+lIzMnpZYnwJP4Ghlx8Z7tjhgwf1qAL/2Xr06Qu/fqx1Qbl/cDoDIlM4OAutB8
         aKqBS8sb/yCc7qdNKfbVSBL2dNgEtDwqhOr3PAoa6UgMrniJuGBDg+JY0HQYvNTnJchf
         htis4HY1SgRzPCE7kXZ+Lk0EHBT7xe08m1tynfSTTWGBH7RDYltMu5fZgeUgX+vNDCNc
         OhtnQV8S1vrYJ7rMYlg4o3vR9T3ZLBXxeFYunauT4w7Qj3+YRyjAAbAxRD7d/Bx9J/PK
         qNvoccGoc9MMSS1iM9wdiamkG9De9hitqhG01MKEI40+eN/0c4k4cQPWnQd0NkCP11Q5
         Ygrg==
X-Forwarded-Encrypted: i=1; AJvYcCX7Ha8ZIYQ5itgaa5kNLjEaqTBFaGoRZCMfL0xvdB26fJMuweLurCNgejTY4EMzj5f2G/ZPs169u8lzufh+ZF5G/dyHd8y1
X-Gm-Message-State: AOJu0YywLlWExmQV0DMloZ4LpwHfMODfaOIJ+uDd/K41AKTpwrf/kfSs
	1qPXz8nHqZj9vse00AyemuM6yrYYA64uUOtahbp8mO+prkqYavvz
X-Google-Smtp-Source: AGHT+IHUi4ve/rCfmXaPqL/3JBR3DFoPX40zPgN4uoXszbqfWogFiq4UfoAQtvbss0HtPFsn1Xl+FA==
X-Received: by 2002:a2e:9852:0:b0:2d0:f13a:cad2 with SMTP id e18-20020a2e9852000000b002d0f13acad2mr2133170ljj.1.1708028852788;
        Thu, 15 Feb 2024 12:27:32 -0800 (PST)
Received: from ?IPV6:2a01:c23:c544:200:b8db:381c:cff6:c7bf? (dynamic-2a01-0c23-c544-0200-b8db-381c-cff6-c7bf.c23.pool.telefonica.de. [2a01:c23:c544:200:b8db:381c:cff6:c7bf])
        by smtp.googlemail.com with ESMTPSA id q8-20020aa7da88000000b005638a4f935dsm854107eds.4.2024.02.15.12.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 12:27:32 -0800 (PST)
Message-ID: <6ecc5c66-53b9-40c9-9fe4-b091afbe2f7f@gmail.com>
Date: Thu, 15 Feb 2024 21:27:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: check for unsupported modes in EEE
 advertisement
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c02d4d86-6e65-4270-bc46-70acb6eb2d4a@gmail.com>
 <Zc4zhPSceYVlYnWc@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <Zc4zhPSceYVlYnWc@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.02.2024 16:53, Russell King (Oracle) wrote:
> On Thu, Feb 15, 2024 at 02:05:54PM +0100, Heiner Kallweit wrote:
>> Let the core check whether userspace returned unsupported modes in the
>> EEE advertisement bitmap. This allows to remove these checks from
>> drivers.
> 
> Why is this a good thing to implement?
> 
Because it allows to remove all the duplicated checks from drivers.

> Concerns:
> 1) This is a change of behaviour for those drivers that do not
> implement this behaviour.
> 
Not of regular behavior. And at least for all drivers using phylib
it's no change.

> 2) This behaviour is different from ksettings_set() which silently
> trims the advertisement down to the modes that are supported
> 
It's the same check that we have in genphy_c45_ethtool_set_eee().
So it's in line with what we do in phylib.
But I would also be fine with silently trimming the advertisement.

> 3) This check is broken. Userspace is at liberty to pass in ~0 for
> the supported mask and the advertising mask which subverts this
> check.
> 
ethtool retrieves the supported mask with get_eee() from kernel.
And this (unmodified) value is passed with set_eee().
So at least with ethtool this scenario can't occur.

> So... I think overall, it's a NAK to this from me - I don't think
> it's something that anyone should implement. Restricting the
> advertisement to the modes that are supported (where the supported
> mask is pulled from the network driver and not userspace) would
> be acceptable, but is that actually necessary?
> 


