Return-Path: <netdev+bounces-167801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D1AA3C638
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983DF1899D01
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4152144DE;
	Wed, 19 Feb 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDruFDP+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2221423F
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986125; cv=none; b=RgKCt3y4XN1hrH/IMg8ighAVdBUF6upnNBYSOg3Pw9MuGbOltpTvFFmVKqen0DvyBQ7cnv/kDPSLS1f3yuHHoH8et3ae/uSAlliDvDv+KEIgYLENmD8RCp3QhnD64sNzJYZv64LzGvejCb0xwxG1vjS0xXWUs/39HtkmIAy/PUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986125; c=relaxed/simple;
	bh=p9iPedWdfZzlKiXb67pWsPJLepND9xegKrclEPsHyWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7GgZ7CZwOMVZSJeaEedfzJkrl9nkzsG+YGsRvRdBRh3FCuN9n4ih/vxi950wHmhvzmRaTPIrmaQ4nfnudjcRLunGKfI8qjscaqrhFYVZgBRyyZ3sRW+2pbsFHoLtnGkymw+vQhYBUusfZrH9fpPACpFnv1+RQVJaGmfnUjqNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDruFDP+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso9538977a12.2
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 09:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739986122; x=1740590922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a+CbdEGAAiY10HRve5+Oy/ibDNPh2yLdZ7U0vmW532c=;
        b=KDruFDP+/deV6GUULNrYx4fiwEc1DD5DNZY4BNi9zedP+0mLFANov+CPwnVHNK9iCV
         dBkAgZDmgwK5GHyL1Gc9NmlBq6b2la5I1t0+EDw69JzaZWPBJp223R9I98UFnBmpm4zW
         zikfoFAOGmAMW24+GNKS6TF83ZHj2b/fibsYRbB02uOSrXQStRPxeCzTtV8yGHbFGxCy
         aVMe/K5w7xIgzgMX/Hdi2w7XMMxguJOvS0ajRtj6MwuaUE6DCERfEUdh9/2x6YjZT0ck
         G+S6bBVx9S3g4WDqjvmOpLmZJeD/td6h9BpQ7nuLvcZtmN7X/s3QP9L3xaQvmM2hOceN
         yM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739986122; x=1740590922;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+CbdEGAAiY10HRve5+Oy/ibDNPh2yLdZ7U0vmW532c=;
        b=w6f/tkMd8TT6hefQ8IPDNFZEPAy5NAf0eXiKwMtRMOI/+0zTqoF/Qhur2k7qA95zMS
         DWiOuD0Sa+yorpbrtuMMM0lpzvegWiiWWdFMWRlbMuWiLNmZqCr0D9JJGYT0/gezRY4h
         XsehXh1xGqxp0LHg3o/YD08IkrikMnt0f/9zh8w9iZO58Jzw+P+vY3FWcQmOgFWL5TIi
         MOb+RBKtUFLpE1Ku3n1CNN6VFpaYOg7ihn/FB4OlVLmGr5jpHwQFrcul4SCckcHBWFp8
         SXzUGNLB2Bk+cWc2QH6SZecAbJz7aNEU3ukblIPEFGWFbNdZplHhoaKydq964BrGIuWw
         teUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYiBi8bFtQ0dXfvvpctpcmWg5VUG7ZDRifrxidQ/BboaJ6nJ7JLraINv1jTJUNK1Hc0JeftqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVfzL2A7YNe3dJnHHOzO6ibS45vjIJvYMCrE8cY82U8pedEu1t
	LB3rhfukwXLB1KZDgpg9/m7+XyinuUfmdlHWh6WvMPioKoGGkcQg
X-Gm-Gg: ASbGncsKxN+WDuoVRWxW1acq8OgIAgI1vA6k08n6OlCx2j5MeRHzqdy+Mt/SfeQiWTZ
	6QfE3I3zqFamIaUbrVGQZPtEdMbLmTKI8GL8YT+WKM2bKybxtJDyeaALME4VGqaLnjEztaRPs/L
	28dzYAC8/Yy/UYKohIxdHSpxgchOL3Lwsr1DLBvupdg9TWgq3AFXvyCDG62evyUSq675yTr6v4I
	AD2ZRSNFr3GUqLsp2cUFvTDP+5paZ4IZXf1oewfS3YRS8arsWJ8nml8wMx61Uzm7ufB9Nluwl8p
	uyhKv8VTU7OEZ+0kpf3gqjAXmE8Kqk3WUfNsDcfMO6So+qUWQ1aFDAu0hv8nV67wK8UFJSR7f4j
	gvp99H3CF6rRrMGXp5QpQXmnW9is8j3ZiAgs0QCjDfOnMpGgR1DHcN2p83LTlneTONrOdniVdBI
	EEd1DyNnQ=
X-Google-Smtp-Source: AGHT+IGki8B3FafxfNlZc250XgPAl8rsyo8RX5kqKxNWXwV1eoHBlNdCBdDBhQ6f36pP/Y846zaHog==
X-Received: by 2002:a05:6402:1f13:b0:5dc:80ba:dda1 with SMTP id 4fb4d7f45d1cf-5e03602e5d6mr43758998a12.9.1739986121447;
        Wed, 19 Feb 2025 09:28:41 -0800 (PST)
Received: from ?IPV6:2a02:3100:a982:e400:6dd0:628c:981b:2783? (dynamic-2a02-3100-a982-e400-6dd0-628c-981b-2783.310.pool.telefonica.de. [2a02:3100:a982:e400:6dd0:628c:981b:2783])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abbe1326bd1sm109196466b.172.2025.02.19.09.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 09:28:40 -0800 (PST)
Message-ID: <5a1c646d-1e02-4980-8cf5-4a3dfc670836@gmail.com>
Date: Wed, 19 Feb 2025 18:29:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: add phylib-internal.h
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <290db2fb-01f3-46af-8612-26d30b98d8b3@gmail.com>
 <8f7cf3ac-14f4-4120-a8ed-01b83737e6b8@gmail.com>
 <4b2ebf2e-28b3-4b6a-9772-e5495c18b1d6@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <4b2ebf2e-28b3-4b6a-9772-e5495c18b1d6@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.02.2025 14:35, Andrew Lunn wrote:
> On Wed, Feb 19, 2025 at 07:37:52AM +0100, Heiner Kallweit wrote:
>> On 18.02.2025 23:43, Heiner Kallweit wrote:
>>> This patch is a starting point for moving phylib-internal
>>> declarations to a private header file.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/net/phy/phy-c45.c          |  1 +
>>>  drivers/net/phy/phy-core.c         |  3 ++-
>>>  drivers/net/phy/phy.c              |  2 ++
>>>  drivers/net/phy/phy_device.c       |  2 ++
>>>  drivers/net/phy/phy_led_triggers.c |  2 ++
>>>  drivers/net/phy/phylib-internal.h  | 25 +++++++++++++++++++++++++
>>>  include/linux/phy.h                | 13 -------------
>>>  7 files changed, 34 insertions(+), 14 deletions(-)
>>>  create mode 100644 drivers/net/phy/phylib-internal.h
> 
> Maybe we should discuss a little where we are going with this...
> 
> I like the idea, we want to limit the scope of some functions so they
> don't get abused. MAC drivers are the main abusers here, they should
> have a small set of methods they can use.
> 
> If you look at some other subsystems they have a header for consumers,
> and a header for providers. include/linux/gpio/{consumer|driver}.h,
> clk-provider.h and clk.h, etc.
> 
> Do we want include/linux/phy.h to contain the upper API for phylib,
> which MAC drivers can use? Should phylib-internal.h be just the
> internal API between parts of the core? There will be another header
> which has everything a PHY driver needs for the lower interface of
> phylib?
> 
> Is this what you are thinking?
> 
Exactly. Not sure in which category phylink would fall: part of core,
or similar to a PHY driver?

> 	Andrew
Heiner

