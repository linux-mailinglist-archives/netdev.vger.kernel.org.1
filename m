Return-Path: <netdev+bounces-189295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A68AB17D1
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99F83B785C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA29231852;
	Fri,  9 May 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="V681hx4K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD921E502
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746802533; cv=none; b=EqlsO0L8bqtk5glYG6XXdJNonqGkilJ9G0b6Zf4XiOZSmSgWKpZ069nU7HO01Ki/bxEt/kwtWgVkefkpJ8DmCDgR58THDuHt6ERIW8jqSNgPg3ids8hBH9qk+eydR3lJtyVEaKXsSnrC0VP+nPIewaohpvK4dRfToruoavpbx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746802533; c=relaxed/simple;
	bh=K9lwXbHR6Ah8Yp4qMG0ZGUiACo6OJ2LXSmmZwhE9D64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLriR7RdILKf6uggxD/L/Pf7JaWCJ3WOWGt+yixvPiYJF8AB/WJDlg+hEtRv7ZsWOz4FxV7H8De8E/pys6o8spUNHoraWXoiw7neJ7EvvKC10to2HLNE4CKEiJTGnqWsrV1tRe2Y+H7groNIjWOyaOqmS5XGsrLJjPlNhum0P04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=V681hx4K; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fc8c68dc9fso3895910a12.1
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1746802529; x=1747407329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BC+wJAMfghs2d/LExGV1hbdhiTjWlkz/mNNYmR+QAw4=;
        b=V681hx4Kjs1YLpfwsiLkI/a7k0kyX2DBSme5CpAmfzhi6uxzD4j/KunVwN1T04vCgR
         47ocr23z52hBFaa20k3PnAs25aN0N0JvQjhlsxpnknOWwycTAnvfonGGActMXQlnWyZp
         c1toSkMUE9dap3BUT2FHjRskjTFXYS4FgAHaDQoIq2GJdPL3pjAAdbttkrDP0s+4ouke
         ZIL8vrqmwM0XLxmGVqEkznwhcogWiGgJPvbjfR0qa8wUD32Rw955q0b/VqhQuIS2HOlk
         H/mRjCc+l/hRzai3FuTHjA0lVTtai8FyWbwv+x2jOxWVdlai/qIga79cS1CT5a/fAOfK
         /JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746802529; x=1747407329;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BC+wJAMfghs2d/LExGV1hbdhiTjWlkz/mNNYmR+QAw4=;
        b=SArryd8uVAT5kYj2cl2CMueEN4F0eXQCGvO2qiktXCZNP8TJkbJbAuGu7ZTejkWgAk
         YFd+9H0Anp1H3cVGpybSZSHY3pP7N2dEXXq/hREnMV7UejZW/c5SyAtVu34afVOPQY99
         JxB0YFIibv7AbzAVUNWI281lAjO/QOPJIuQLU1KETT7SpToa3QZt87hxSA3I6dULCJnH
         DziX+9uFgi13M1VAcpk+J88LP9WRiAg/harxLlQ4mu0lYO9lL/aiZrnbkhxlLhUm6KJc
         ShSvasbWkF9t6b8PUApKZb89hWP13PRcLbEe56KtvBKs7M4NZP31Hs3etXhg47HgBrDb
         mEMA==
X-Gm-Message-State: AOJu0YyeU1c+sl6fe8YDSQktdsRBHxjL4foUgvEGBiSkuHTsBW50EXrB
	RaGsMvzGIVVs4gxgMK/2h1KS8qlM3/RJp8dY41Q0udEuHz8J2IwwYxB9r5zvxZRiaMzD4/kmNhY
	TzUOHq+oJjWkfWWCDH6j8hNM6OiuD4v+kIbsig9g1/lP6pmLkptZmed7eN5Xb
X-Gm-Gg: ASbGncv7JYGn5irZJdD7YcY641lt3WH6vckh+Ymkhgn4jO19nNZsq2uZoUSBrg3lUUq
	UuOLD30IJRvn4QNayxAGJ9oho/NuCObe9Cv0U4R4WRRFRNidd+197gcyZx1RMoftalf9GPrVJwE
	/5BSo5tPO89+MbxNO1KwtBEgt/Qcrmar1j1NI4w6m48wS8tSL4bBUJYak2ojtID6aLD0wRyiQgX
	fiiOwZl8UL/ObPKVYMgViVfq3PZ2aCZ0uKfYUFYwctqEXiALVPMRYIDVlJ1FEfXRYAAL1/OoiEu
	unzyeNAY5hHFS+LcVmlFFaSm2xBa11cLPEm1fAFOmXFmUa1So0fY++kvtJeiMT2M9d+td37a4h1
	F
X-Google-Smtp-Source: AGHT+IEUCPevvUOsn+NQT9mpaYkXbw/lMPlnIaR4sZbir/GNloeO7+j0y6snOgEx+cR8zpn/7zPVzg==
X-Received: by 2002:a05:6402:2112:b0:5f8:604a:3a74 with SMTP id 4fb4d7f45d1cf-5fca0794fdamr2921958a12.20.1746802529223;
        Fri, 09 May 2025 07:55:29 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:4ed9:2b6:f314:5109? ([2001:67c:2fbc:1:4ed9:2b6:f314:5109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe4c83sm1526821a12.8.2025.05.09.07.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 07:55:28 -0700 (PDT)
Message-ID: <1da26f53-634b-4562-849d-c1c7d5be2d18@openvpn.net>
Date: Fri, 9 May 2025 16:55:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] pull request for net-next: ovpn 2025-05-09
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <5e2b95fd-4bb5-43fd-bba6-680a6f2d41fa@lunn.ch>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <5e2b95fd-4bb5-43fd-bba6-680a6f2d41fa@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/05/2025 16:40, Andrew Lunn wrote:
> On Fri, May 09, 2025 at 04:26:10PM +0200, Antonio Quartulli wrote:
>> Hi Jakub,
>>
>> here is my first pull request for the ovpn kernel module!
>>
>> As you can see in the patches, we have various tags from
>> Gert Döring, the main maintainer of openvpn userspace,
>> who was eager to test and report malfunctionings.
>> He reported bugs, stared at fixes and tested them, hence
>> the Reported/Acked/Tested-by tags. If you think such
>> combination of tags is not truly appropriate, please let
>> me know.
> 
> Ideally, all this discussion should have happened on the netdev, where
> others can take part and learn more about how ovpn works. If this
> happened in the open on some other list, please could you include a
> link in the patches.

Reporting happens often on our IRC channel (#openvpn-devel @ 
irc.libera.chat) and then we track bugs on GitHub[1].

After getting the bug report I sent bugfixes/patches to our public 
mailing list (the one listed in MAINTAINERS).
At that point Gert reported his findings (with his tags) in response to 
the patches.

I can add a "Link:" tag to each patch, where I provide the URL of the 
patch on the openvpn-devel mailing list (with following discussion).

I don't know if I should also include the URL to the GitHub issue?
If yes, which tag should I use?


Thanks a lot!


[1]https://github.com/OpenVPN/ovpn-net-next/issues

-- 
Antonio Quartulli
OpenVPN Inc.


