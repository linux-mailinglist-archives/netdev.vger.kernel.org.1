Return-Path: <netdev+bounces-176815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E78A6C457
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 21:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75BC2467B22
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 20:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874DA22FE0E;
	Fri, 21 Mar 2025 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlrUOX2S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C22309A6
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589445; cv=none; b=glLWlMk2sAB758g7OzLmGzd4Buk8LQ24708P1my6GV6Cee0ROn6XNmlBEVSZrzpeXTnutBrMPTKv6lyuFD/RqZjD640Y7lBZLBuR/+xUF9NWEObuUBQehtBsSOjPCgu3fq7QAK9aKEGdu+jwtW0JHLpPiLilDNWjNZyqPxiIv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589445; c=relaxed/simple;
	bh=JqLC8Hx0DambRc2RFuJvdQgKgMpMaa69lYJq4p8fPoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmcwZA6NAJGIHHyT/EjbUOzMWRBsBIy036vYqQd9FU694oS0YmAfcncvUkjERa27N2820UooWjhgAErmUAhB8QEe4YKONBuik9Kveadae4SSFwOJbDRYEaJ2psROIG8px/gNSDjatYqaZJAqhaCEm/3KwEpNhI4GXE+JwyJqeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlrUOX2S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742589441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3nrAPNCqv+uMph7FOR38ygPrAkDx5/grua1l5sijvE=;
	b=dlrUOX2S/WH9X+7VTzyxi0sJGwYgo1zDs6PQteO3nQ/uH5GXSxnrlEQlPfdK/ZjWP2xB6H
	f6v7WQqnzZyroG5U7zteT+fs3XfYEXTVZwxFyaoC3MwdgSf6TBMOch0Qt+F5ufBCRf5fBd
	gD1l4eMTKBlvK2UxNTK6OvFtqLss3Eg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-dKCS8XGBNjGyxzIbdItWgA-1; Fri, 21 Mar 2025 16:37:20 -0400
X-MC-Unique: dKCS8XGBNjGyxzIbdItWgA-1
X-Mimecast-MFC-AGG-ID: dKCS8XGBNjGyxzIbdItWgA_1742589439
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912fe32a30so972875f8f.1
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 13:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589439; x=1743194239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3nrAPNCqv+uMph7FOR38ygPrAkDx5/grua1l5sijvE=;
        b=rwhZjFD2bJVwihjUVPmfcw4f12uNjr5ExvZe2vhDmsgzjfSW9qyHoHk3c0tcapnW6I
         K43mULLnUyEuhYiNe6uQNPeoYX99nJKi6BJCOSPdb8eLA1ULqxYjzfzfIUCuorT6RJ73
         36GzMiSR1EVrY++3+I3309Nf0RhHZCi3RmNVZqK5w3ZZx1iAYJQwg4jwzizYX1UnrYkB
         ULqsKjvsdOizBKlGVeqB/fZyM19J8lGn15z9UfOgTtdDmTAUki6z/2o/u/EdUY1pkmLr
         EceMLd0Fq1AjbyJWqZYXYB7k9B6ifSwpnViOqa1ZzmYbcaMmxyVkjTjcrPmOiCCOTNUf
         xHLg==
X-Forwarded-Encrypted: i=1; AJvYcCWoNuKSVjmqJIB0R17bgVqe2k9JnpuqNx5rLGOxdHJy6xak0nk2eXn3bmjquPELtER7uwcfAd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB6Lgk/1LaRI43dDsHclaZWpIsY55P7DY+jXlwms6oxUq9xGP2
	bgOBYCkLagrHv0aGNViQMmezUmkZvNHr3ml2SS4o+2mRi8yih2QtA3y0fHZQGru4qxECZ1NEkKn
	P1szji0u96Ut4VfjeQXsXHl0OF+/3o0ADWoZMV0qCfLpf4whzIUIGTA==
X-Gm-Gg: ASbGncso4kMP7q8Q+ABS6Iez4AZeccaKTtHIUDg+WZEJaKBELe4oAdc+e82MJRWTonC
	dFRdGgK3Pd0jTZePGVMfG8oBWnLXUUDLzW4KU5pHX02NIbf+OSAGFP54bYEy8GTTzTQVES5zAjm
	RG5kNHjAmGg5Fy2PgoYQo2m8umEH4LN8KPi5bAm9xYUyveMhVzwrxBi8ZGoFczfaCeB1tFrPP/A
	sTs8C66smrw0gF4UxMPsyMmO2eKw/kqzxew0bxpiZmPJQhjd7dmrli4MBGngsxMpuPJH2BhUHMT
	ZawkYMKpMO7ASUjmzQ/Z2cNkV5+pFSA7NfFk88TTxHag3g==
X-Received: by 2002:a05:6000:1867:b0:391:2eb9:bdc5 with SMTP id ffacd0b85a97d-3997f90d2bdmr4543346f8f.23.1742589438705;
        Fri, 21 Mar 2025 13:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJGJ04UqTM5mJpscFLEySJ8yQ0dp9I9ZT9RgN2HjfsRDgC7ejFbHBNNNgZWfsMQqglWX4Y3Q==
X-Received: by 2002:a05:6000:1867:b0:391:2eb9:bdc5 with SMTP id ffacd0b85a97d-3997f90d2bdmr4543325f8f.23.1742589438306;
        Fri, 21 Mar 2025 13:37:18 -0700 (PDT)
Received: from [192.168.88.253] (146-241-77-210.dyn.eolo.it. [146.241.77.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd181b6sm36766785e9.9.2025.03.21.13.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:37:17 -0700 (PDT)
Message-ID: <9fe63634-9961-451a-b98d-0a9df1eef8b4@redhat.com>
Date: Fri, 21 Mar 2025 21:37:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] net: phy: marvell-88q2xxx: Enable temperature sensor
 for mv88q211x
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250316112033.1097152-1-niklas.soderlund+renesas@ragnatech.se>
 <c17d4b58-9efd-4c09-8e20-e4f9e2e10100@gmail.com>
 <20250316120214.GA360499@ragnatech.se>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250316120214.GA360499@ragnatech.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/16/25 1:02 PM, Niklas Söderlund wrote:
> On 2025-03-16 12:47:55 +0100, Heiner Kallweit wrote:
>> On 16.03.2025 12:20, Niklas Söderlund wrote:
>>> The temperature sensor enabled for mv88q222x devices also functions for
>>> mv88q211x based devices. Unify the two devices probe functions to enable
>>> the sensors for all devices supported by this driver.
>>>
>>> The same oddity as for mv88q222x devices exists, the PHY must be up for
>>> a correct temperature reading to be reported.
>>>
>> In this case, wouldn't it make sense to extend mv88q2xxx_hwmon_is_visible()
>> and hide the temp_input attribute if PHY is down? 
>> Whatever down here means in detail: Link down? In power-down mode?
> 
> These are good suggestions, this issue is being worked on [1]. I just 
> wanted to highlight that this entablement behaves the same as the 
> current models that support the temperature sensor and log how this was 
> tested on mv88q211x.
> 
> 1.  https://lore.kernel.org/all/20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com/

My take is that you should at least clarify in the commit message the
state required for a correct reading - e.g. link up vs power-up.

Thanks,

Paolo


