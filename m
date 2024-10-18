Return-Path: <netdev+bounces-136859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB089A344B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C562328641E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 05:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF817837F;
	Fri, 18 Oct 2024 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDHtLo/W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C1170A13
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229549; cv=none; b=jzRzDh+gy0cFaCL9wuccORbN4k+huYgS268jRcFfryedTlnNe+1+hCC6IgWtHzlHONKUsW3Xah6wY13YP1CpDhtI6cFMM9F8HyqbXyqBSuOOdlKRTZPnsxpYaZD438p/rwa05LRmGNTO1W1yUo3TLt1oJ5GPCj+lY1pPR06ORtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229549; c=relaxed/simple;
	bh=d3LOY+TPF27F+/nXs0JZIiy4CWJ3hOk9F1uqabWn/+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5PjCx93UQ4RX9HDt5Dpkq3APPqkZXlDZKw1hh3QrHgvLv2h0XbCbdQgh6twHm/XekNK+uUn7hWnarAiJ7/FMPJTM//WBlBqKGCkg4jp56m6Le0fmmJ+i8ljVCR+YSUCkZVcMTM3c6KxsGzEpwaszAoTkGUv0wpssAUgi8NQVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDHtLo/W; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so3024806a12.0
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 22:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729229546; x=1729834346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7pNsFm9mVvkfFe7qEl9dgb52vvvuDDus0bdywlfPYTg=;
        b=lDHtLo/WxSYRAzEcwCUHMchEHonNN/D1gGP9XQyMlBCk2UfcEpWpioX8ajwQ6iMwOx
         rMLVSgZ35vjdQboRtdqAUar4ct1oSfFqoo4Q2w32yY4lmzlx5QZENuxKvUrg9Cql52u1
         ac1b16b2+bhJ/4/1gx3r4+XLTjCFnUegVvgckPW5C3i5fvY9Q4YnkTVF1NryGPHqV7sA
         q3x6EKowxcTBIkHgga8UadYxqNrHYkgtXtAjKAF/x9ot6rwDj5J8i1oL95I9xoPbwPBv
         9hj3/WhcSeJUFH96D98XSXPxmBYeJiAMmovbh5iZRsjXFHOHvPlGbxqJrIGZOlf+Tu/B
         eMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729229546; x=1729834346;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pNsFm9mVvkfFe7qEl9dgb52vvvuDDus0bdywlfPYTg=;
        b=bn0FrFF/XnYzpCUiPHaBHiAalQQXGyWehXqZoE53fKgR7S3XjCUTKa0vrJd6l+UWzz
         xabqSNnAWqNKOBM5eQJZ+rIVev0d6fEE4FmIc2XxwZgjLwrAQdFpI9Shizx0ODt2dPr5
         z4hI/UsQeoJSQwyQ3GQXYiZE+j9DprRa8uOJKsjh5iVesPU4Oi0E9SNrSLG01JZlYGK1
         37V+CtefqCJonOdvBdRKPWOWNyR0Gw551pniF62Q55nNw+B28Z81k3n0cV77+ddk7Psu
         CBvBit6mEG5onJdxb6rJOricxAoEhLuMdjhPULJKXL6z5UkPyNYU5upwdF82UO5PIl1g
         l5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJmXvYwHs7qjHAmhD7wUX0C+pM8fiVfL4GMQ8xglms7QgnpwgQ2ivXKeOTVOs7IWOluaAtsrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhci3yFl6jsFvaK5h/bTK8bke4Rv0xSG3J7m71OT2FU0HAgCWx
	6ezw4sNqirjlX+v2siFjFUws7rk4TtpKuBsahAKdG3TKJNpKltNM
X-Google-Smtp-Source: AGHT+IHX1u6NZUUPsrj+GX8UGPJ+qewhwT3SWnVbhqrjAQxZ3Jb/v+Zq57/5SfmsSxFu+aLWwWNE4g==
X-Received: by 2002:a05:6402:26cb:b0:5c5:c444:4e3a with SMTP id 4fb4d7f45d1cf-5ca0afd391cmr785030a12.0.1729229545468;
        Thu, 17 Oct 2024 22:32:25 -0700 (PDT)
Received: from ?IPV6:2a02:3100:b04f:2200:1951:f27b:a227:6064? (dynamic-2a02-3100-b04f-2200-1951-f27b-a227-6064.310.pool.telefonica.de. [2a02:3100:b04f:2200:1951:f27b:a227:6064])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b08c3easm275555a12.50.2024.10.17.22.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 22:32:24 -0700 (PDT)
Message-ID: <c580367c-7f66-4f3a-bfe4-53e5103e200c@gmail.com>
Date: Fri, 18 Oct 2024 07:32:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: avoid unsolicited interrupts
To: Andrew Lunn <andrew@lunn.ch>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Pengyu Ma <mapengyu@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b8e7df14-d95e-4aab-b0e3-3b90ae0d3c21@gmail.com>
 <e34dad2c-7920-4024-9497-f4f9aea4a93f@gmail.com>
 <83fc1742-5cd6-4e67-a96d-62d5ec88dfb7@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <83fc1742-5cd6-4e67-a96d-62d5ec88dfb7@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.10.2024 04:52, Andrew Lunn wrote:
> On Thu, Oct 17, 2024 at 11:22:20PM +0200, Heiner Kallweit wrote:
>> On 17.10.2024 08:05, Heiner Kallweit wrote:
>>> It was reported that after resume from suspend a PCI error is logged
>>> and connectivity is broken. Error message is:
>>> PCI error (cmd = 0x0407, status_errs = 0x0000)
>>> The message seems to be a red herring as none of the error bits is set,
>>> and the PCI command register value also is normal. Exception handling
>>> for a PCI error includes a chip reset what apparently brakes connectivity
>>> here. The interrupt status bit triggering the PCI error handling isn't
>>> actually used on PCIe chip versions, so it's not clear why this bit is
>>> set by the chip.
>>> Fix this by ignoring interrupt status bits which aren't part of the
>>> interrupt mask.
>>> Note that RxFIFOOver needs a special handling on certain chip versions,
>>> it's handling isn't changed with this patch.
>>>
>>> Fixes: 0e4851502f84 ("r8169: merge with version 8.001.00 of Realtek's r8168 driver")
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219388
>>> Tested-by: Pengyu Ma <mapengyu@gmail.com>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>
>> When doing some unrelated performance tests I found that this patch breaks
>> connectivity under heavy load. Please drop it.
>> I'll investigate and come up with an alternative way to fix the reported issue.
> 
> You should be able to mark your own patches are change request etc.
> 
When doing this years ago, don't recall which subsystem it was, the maintainer
wasn't too happy that somebody else was changing the status of patches in patchwork.
Next time I'll do so, thanks for the hint.

>     Andrew
> 
Heiner
> ---
> pw-bot: cr


