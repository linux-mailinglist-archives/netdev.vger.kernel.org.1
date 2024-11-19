Return-Path: <netdev+bounces-146113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A819D1F72
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BEBB21118
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7292214A0B5;
	Tue, 19 Nov 2024 04:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgmtY7na"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6A29CA;
	Tue, 19 Nov 2024 04:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731992120; cv=none; b=kDRW4FmkK/WzY2Wluzr2ytSHJPrsKAC5H/HzZoapn/etaBOW7UGb70zQS2Obyf+GXPCXHz0xm4UiEDfrlk1eP3FtDQYCRNaZZvxMzw9J8NBXGtMy8TVahZDDH7ZPzfiozQSPLm794Tuf74NTjPsIYPLEBxzc7VtcUYykIkdi9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731992120; c=relaxed/simple;
	bh=z/81dZ1tk15Q42b63Uiw78Bw0opOjg0YrmHT0HY9ny0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptQCJJGPdJxpesSm69ihJ/aIbu7aMnkms1dGo+OAsqRjh0w6JCWZa5PA691K4o9P02dr0KgPLJ/xcT9/U0QAAgRcC++UuHKu62/zoMGDZcgJbEGsJC14rkN6nsZGYzOGFW39cYy/kcZcmrZVwd1Pum8Lgm8xaXefqa7zkE3FVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgmtY7na; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cf3f68ff2so3132795ad.2;
        Mon, 18 Nov 2024 20:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731992118; x=1732596918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhvO12J46IBOnMPjBeMGgT1CgETrMfY9BeH8e1iABdk=;
        b=dgmtY7na1Lz8QO2fCaDkGELWIECD45yNmr/g6pz7fKuQAZ4ZxnRgv7O8Y/Vtvo+fOz
         thfUPifyiEeWqjJ+MsDfdjHO0oLvysoef/L3mMuJ/EefZUySv4KTnWxwIORX7YQGNgPr
         xlbNLbDE9LVaUbw6lEgZOz64guZWvBDtEFBNty9KmKRsFnIZ/ypQemjhkfYbmG/H1iAs
         wFjIblWnqEE/Z4LskWvlRj53j0ZYksronDEoc6mVuYfLez3gJNU/s/MQqBlkxD4XHAER
         fu6HMDIbdEPT1/la1QXQgxbCQtqeAm23Uf7s9TMDJvHF7svqWuQto0OSBAg9XVxxPgkQ
         7i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731992118; x=1732596918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhvO12J46IBOnMPjBeMGgT1CgETrMfY9BeH8e1iABdk=;
        b=g8paOqGhMJRO6AlZyeelWRVU6xBYWLi1JQT5osPZFyBxjpUyVd4l6LYm56EjAVG5m8
         cmQ7M1yk3RrWECFoec6p6I7P0lyqye+B6CZlNGkDrglB7kpBLAYGBa56jFX4S36mc6a0
         cIcFwtc5hA1wsHN7UM1Hhc4NWdaTY/NtOaTbFNKlJxwV6L2rh8POPyQpt17csZhDtNF6
         fHaHG/m1UNZyv4n4NvowsxE8j4KDfjVKDDKdd7sRimTasQ+TKXOKsoxVX07Iw13SaEgc
         eOCfMpYzx4aRRRvxhwW9uZr/SnzIyQ0uvOb1NvdmZ0baN5aq0YAH8/92S0Eb0y0P1934
         q3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUnqHS/GicR4XNC/meDcfyrVDnqRyAnQ571AdC++ttU35APtyz32wV5GW6gThn+vuRlnImNdZMz@vger.kernel.org, AJvYcCVMKDtxym6w4NgqXzgRsUGzqv7kubxKTeJKsVLRa+rss3SLYC3zUDwTl4Pp0A78Gw88iW/rCzvBjNGWUH4=@vger.kernel.org, AJvYcCWCgxkSnRI5AYpz/IenWY70c4tNI0X8D7OAiLTWniNnCoCAYz1+RyBh7/v7V59Hz1wA7OVaYq+IZnPu@vger.kernel.org
X-Gm-Message-State: AOJu0YwTlF1qhhYYVOnlrrEO3OB6sbT248LtkXjsEqQH1sPkqVsHQxc7
	2C36Z7eCIFlFc8rfX6FJZhp2aC2i7FBqsbaOETUKm9t3jCJjvAwt
X-Google-Smtp-Source: AGHT+IF3mhBrDjfmp0C3Iophs8XzghD6ZnW3lCAX9J/ycI3fY1Re/4HNouU3JBCzcdHIUNZ/pjn5Qg==
X-Received: by 2002:a17:903:2b08:b0:20c:b527:d460 with SMTP id d9443c01a7336-211d0d77e16mr82030975ad.6.1731992118089;
        Mon, 18 Nov 2024 20:55:18 -0800 (PST)
Received: from [192.168.1.7] ([119.42.110.94])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21253619d4bsm3963345ad.173.2024.11.18.20.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 20:55:17 -0800 (PST)
Message-ID: <26889f86-82bd-4bf2-808e-7476ad6671f7@gmail.com>
Date: Tue, 19 Nov 2024 11:55:10 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] net: usb: qmi_wwan: add IDs for EM7565 (9X50) in
 "MBIM USBIF" config
To: Ivan Shapovalov <intelfx@intelfx.name>, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20241117083204.57738-1-intelfx@intelfx.name>
Content-Language: en-US
From: Lars Melin <larsm17@gmail.com>
In-Reply-To: <20241117083204.57738-1-intelfx@intelfx.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-11-17 15:31, Ivan Shapovalov wrote:
> This change was discovered and tested using author's own EM7565 device.
> 
> This "MBIM USBIF" configuration corresponds to the `AT!USBCOMP=1,1,xxx`
> on-device USB composition setting. When activated, the VID:PID resets
> to 1199:90b1 ("application" mode) + 1199:90b0 ("boot" mode, i.e. QDL).

Hi Ivan,
for the whole series 1-5, please include an lsusb -v or usb-devices 
listing for any device that you add support for.
What you find in device firmware or in Qualcomm SDK drivers does not 
necessarily reflect what has actually been manufactured and consequently 
  how those Id's could be used for a future different product.

The 1199:90d3 is already supported by the option serial driver and that 
is where devices with interfaces supported by their unique interface 
attributes belong instead of being supported by interface number in 
qcserial.

thanks
Lars




