Return-Path: <netdev+bounces-185681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA19A9B536
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2110C926D0A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ACA288CA5;
	Thu, 24 Apr 2025 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="sl8qK1og"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700DD284681
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745515773; cv=none; b=d0i52oha9HDKLmCLjosA63fY18L11dGxTZ2+kKT/EYP4PECA1Xlilot8hcsjo9Hs7HPsbDzz29X2/csJS8k6tedFbowN/74bKFuH3Ryme823YnAOQarHkZc4HgSxj1lTgNTXnwOLgcBudouegKzK7rTZybhyJPq0vDC31xsbVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745515773; c=relaxed/simple;
	bh=zDw7BMwmQ7Zzhu3em6h7WuB+uJk8Ll8pW5o+G0j0JPw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YG3NsooDe9LPESiHnbfXs+0f2OrgGR/hJeQv0/KN32GL/ceo9DFp66kPVTxXJX/ZAMFLyfWqK44lAdiPjoc7l4ki7ilHfsr6JHT7hEn27RR7TdBWioO0QtmXstqWA/bcYfTtuyqP/Z4Y3VlnpdjX8te8cZ/8Oa6aMLGwG0jT7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=sl8qK1og; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so2404147a12.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1745515770; x=1746120570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JLHhBvGwHoD14XYoD4WUPVU9+Bb1BKcDzuKit79fgsI=;
        b=sl8qK1ogUFiW0mh44xZ/byXLtlKD8jF7YnW6TxN9yYdK+oIVfj8CMBGuv1c6S/kv2J
         E7ahCstLKU4EhFw2AuSSRofJ9PwLCOcz0X82W7loZTXSr8BPFvCOdafiR8n+a3OXEgTM
         HxqTSoamY8Z8Pb8h/toZh9V7Pbk4yKgNxYSdycN1fkbT2cxHEwUY9UHdUuEofwylNjZ+
         czVHmpS8o7qjpbyExSqKVNV1MFXuSDKllNwdmsxPym1tCn/O75aqsTG4vcnOdhUtMivH
         TThXNbDb7j9pUUEKtvuX5qiaBQM+FAVKHFTJugLaP0YStsoOYvjfXUfMbeSNKDjWeg0j
         98aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745515770; x=1746120570;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLHhBvGwHoD14XYoD4WUPVU9+Bb1BKcDzuKit79fgsI=;
        b=R9RlmD3B2SO/sydCBNtWNrBtz9MyuaFQkGaXeKsyXKwUrup1OVdeAW42g0m6iem1yK
         KL0IDWOHVNd6uYBwC1xWj2ckJoT0HXrhST5PJJcnuit01rOAJmm+Gae49PWU6YD+3pme
         +Ssl1cbbzGFQuAH/g36cANqhl/Hk6EyOy+qqvLqAV1CF4IbOOSRkd4y/2zOc+b9JQYWm
         O0UQ5FQNaoJlGcWGF06Hm9gLNyoHZ/fz6Wr9l3bpT5MxQDJAmt8zSi/Bn9LgUGT6Ef+h
         PPKAJxdOFeDxAAEGjgSEGN5PlregLoV2CmxkA+LvVj7as++1/w+4Akri4gPHihL01GrQ
         v5Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXUphZyXRq8wkWMdva+FMs3WHyNNK8+HPlEGJ0nuK1EvN0klBFN3PRzTg+2wG83cmhIoV1yE00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lxKIdbtfWjyraM2XKdawyzL+R3zOHwg8UD2A6x3UNcE3KXdR
	w8MCSL882WF8BjKw/Rmmj1nidWnl68PbMrbxwWQfzUX51SgH8ziH+YSUIM67aQ==
X-Gm-Gg: ASbGncsC4JU8v5bxovcbtKHKQ3pDon8N1EHWXcHxodkUxfjsMPEkH1hwjgtJiraHRId
	p7RgO6mhnlwvVmm5Ksc7lSxH0icgYcIBN2VZWza+dFoF+SmdogFBsSQK6m7Mz7OCWiQE6qlRNE0
	WAL961nwNQBeVlgHm6JnD5umVFqM2P1mZCldKC2KmzG51ssfB+YCC3MKGWTmarzhnWCVgwXPssh
	2bHj7hr+tSxGnsGUGlZSfR/odi3wDqvoSIFgMo3lC4PF3Dmnf2LbQdars1f4HsJFC6cR29tGMOa
	W00keBtm2p9y3eYOVAZNupZilbCqgEJPFgDiH5Y=
X-Google-Smtp-Source: AGHT+IE2ovPWtaSR1CwyZflNLkJWQlZGCejIdOULuu/FjYId4ZaicaBupsaFG9P4tzlR01R9OMB2kQ==
X-Received: by 2002:a05:6402:845:b0:5f3:4194:187 with SMTP id 4fb4d7f45d1cf-5f6de6980d6mr3197899a12.18.1745515769548;
        Thu, 24 Apr 2025 10:29:29 -0700 (PDT)
Received: from [10.2.1.132] ([194.53.194.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f6eb32368bsm1383533a12.10.2025.04.24.10.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 10:29:29 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <e6899d87-9ec4-42aa-9952-11653bc27092@jacekk.info>
Date: Thu, 24 Apr 2025 19:29:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: disregard NVM checksum on tgp
 when valid checksum mask is not set
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
 Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
 <20250424162444.GH3042781@horms.kernel.org>
 <879abd6b-d44b-5a3d-0df6-9de8d0b472a3@intel.com>
Content-Language: en-US
In-Reply-To: <879abd6b-d44b-5a3d-0df6-9de8d0b472a3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>>> Because it is impossible to determine whether the NVM write would finish
>>> correctly or hang (see https://bugzilla.kernel.org/show_bug.cgi?id=213667)
>>> it makes sense to skip the validation completely under these conditions.

> It is not completely accurate. All the NVMs starting from Tiger Lake are locked for writes, so NVM writes will always result in a failure.

Check my message in a thread of an earlier patch:

Message-ID: <1c4b00b6-f6e3-4b04-a129-24452df60903@jacekk.info>
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20250407/047551.html

On my laptop NVM write operation *does not fail* (nor hangs), driver loads and ethtool shows corrected checksum.

This lasts only until module reload (rmmod/insmod) or reboot.

I guess only shadow RAM is updated (or something like that) and not the non-volatile memory, but the operation itself does not error out.

It might also be because I've disabled Secure Boot...

-- 
Best regards,
   Jacek Kowalski


