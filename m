Return-Path: <netdev+bounces-129038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0282D97D148
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 08:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FABAB21E1B
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 06:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4682743155;
	Fri, 20 Sep 2024 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="d2cyRI9D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8E3BB21
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814549; cv=none; b=tpktbrJFVmTvvcvFlGrhUiXGo0bg0sjZNhiF896tHtEjRYn7I/5VO5foQPei0PI22Hsvw6ElC1Y3FioEH9W12LKGsJHRHH/00xAj1mwEodQPwooI3EaTnVtQLLQ+AZXe1vDY6JGXCBpcWNZXLc5BGDlMrzVw71Xh3SBJswUaG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814549; c=relaxed/simple;
	bh=Hb2b/+q+hToRh61WxWnw+lJdABcYLPuii7nIFRD9qsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoZfRT9I6mT6rzyqF+NPdgB+VlnulLohtbTBHRDeBu5onvOH2J71npbRBBMasOm4p5r+sft+hBs16U9QcAUlfb2wWxkfEkP816L0pQFgP0KUk1QVzxhjYUWbQMARAxlT2F0EHCOJvXJRbqyjrtZ/bkHKh9AQMVCpVj6TdtyeqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=d2cyRI9D; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d4093722bso229845666b.0
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726814545; x=1727419345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98uSNXWBdtIj2loX7w9P5NmjIJ5+wZsoyxlrEw5OdHs=;
        b=d2cyRI9DpNUsiiiwbwqNaVc8IDC83X/gjCOLiQYqWNOfpJvci0X1/KAomOY9kOfd5+
         xP7KuzxA+7cQ3QBc+ORnS71nq+y9/GP4JCe4aUqZ+vDAs5bju2hMhcuY4xXom+qR16NZ
         myoEudhNOGQ706QDUHhqorUZy9jFTyzi4694O/2BKJ3W0qtvyxwZ9Hml0HPgVSVXwEBn
         IIgxqHNTu+pth+nopXdxRvH9qq800ISDzG9yDp+gf0MlBE89l2jsEGjIhakAw0B4DbHI
         7lIpoOhrLDk0AAxCJczpd2vZE8BRuQHcAikU1dBFXZ/T1qX7syJeR/KQ/sDySYjX30+4
         PQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726814545; x=1727419345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98uSNXWBdtIj2loX7w9P5NmjIJ5+wZsoyxlrEw5OdHs=;
        b=AE6YI/u7pFOG0fVAc1Z0aGtbdWrP9dRTQM7fT9RU+fxIImKU9iPPXprylm4rMjFZN6
         oLlZFYzW5CXVWk6Ldk1ygtqxadXKXurH4CNp3p6iY8dkb8JVrAo60cwFxh4g0grAlzHi
         TnP49TaHRZhSwv1aO0AbMIEjNkWX/MleVTyQIsir292/lwfnaNG0rSf/voCEez1FYG4q
         Eb/MwcYYqTL+Mgu9v4C9xSCMbsrwxh79EnfPZ5+DeO4bhTqUrxE6Ud0AK6VTgGRkT7tL
         l0nRNOAf0XZJAhncsLmy6qgCYP7mdVRmPzVYxpBvavGjG8wMM5KMk13Fx/zjK13Hl6xD
         2ziA==
X-Forwarded-Encrypted: i=1; AJvYcCVShdwWilNJH62hp42dczgKUuBJCoz8tAhnJdBhde69ihSXs+LZh4wqrGQBMkft6LUUw4iAEpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCqqKtY/zL80IVyNB0Fh7f59QjuUANuOFK+SiGSrKWkBFgrq0n
	HXfnzhoM3u2kNVZ/WTTC+axSz0CmlPykWKSa0gp8Jq889vsq9UlRmcS7SPySa/E=
X-Google-Smtp-Source: AGHT+IFK3LECOgNL2LQB34zytpe20wT+mFRQaW0BYumib9GiIXC7awb6RQOknCMw9j46sSiKv4IBmw==
X-Received: by 2002:a17:907:e6de:b0:a86:68a1:6a08 with SMTP id a640c23a62f3a-a90d56b44a3mr138829566b.29.1726814544477;
        Thu, 19 Sep 2024 23:42:24 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90d21bc502sm76613066b.25.2024.09.19.23.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 23:42:24 -0700 (PDT)
Message-ID: <34a42cfa-9f72-4a66-be63-e6179e04f86e@blackwall.org>
Date: Fri, 20 Sep 2024 09:42:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: bridge: drop packets with a local
 source
To: Thomas Martitz <tmartitz-oss@avm.de>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Nixdorf <jnixdorf-oss@avm.de>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240919085803.105430-1-tmartitz-oss@avm.de>
 <934bf1f6-3f1c-4de4-be91-ba1913d1cb0e@blackwall.org>
 <7aa4c66e-d0dc-452f-aebd-eb02a1b15a44@avm.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <7aa4c66e-d0dc-452f-aebd-eb02a1b15a44@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/09/2024 14:13, Thomas Martitz wrote:
> Am 19.09.24 um 12:33 schrieb Nikolay Aleksandrov:
>> On 19/09/2024 11:58, Thomas Martitz wrote:
>>> Currently, there is only a warning if a packet enters the bridge
>>> that has the bridge's or one port's MAC address as source.
>>>
>>> Clearly this indicates a network loop (or even spoofing) so we
>>> generally do not want to process the packet. Therefore, move the check
>>> already done for 802.1x scenarios up and do it unconditionally.
>>>
>>> For example, a common scenario we see in the field:
>>> In a accidental network loop scenario, if an IGMP join
>>> loops back to us, it would cause mdb entries to stay indefinitely
>>> even if there's no actual join from the outside. Therefore
>>> this change can effectively prevent multicast storms, at least
>>> for simple loops.
>>>
>>> Signed-off-by: Thomas Martitz <tmartitz-oss@avm.de>
>>> ---
>>>   net/bridge/br_fdb.c   |  4 +---
>>>   net/bridge/br_input.c | 17 ++++++++++-------
>>>   2 files changed, 11 insertions(+), 10 deletions(-)
>>>
>>
>> Absolutely not, I'm sorry but we're not all going to take a performance hit
>> of an additional lookup because you want to filter src address. You can filter
>> it in many ways that won't affect others and don't require kernel changes
>> (ebpf, netfilter etc). To a lesser extent there is also the issue where we might
>> break some (admittedly weird) setup.
>>
> 
> Hello Nikolay,
> 
> thanks for taking a look at the patch. I expected concerns, therefore the RFC state.
> 
> So I understand that performance is your main concern. Some users might
> be willing to pay for that cost, however, in exchange for increased
> system robustness. May I suggest per-bridge or even per-port flags to
> opt-in to this behavior? We'd set this from our userspace. This would
> also address the concern to not break weird, existing setups.
> 

That is the usual way these things are added, as opt-in. A flag sounds good
to me, if you're going to make it per-bridge take a look at the bridge bool
opts, they were added for such cases.

> This would be analogous to the check added for MAB in 2022
> (commit a35ec8e38cdd "bridge: Add MAC Authentication Bypass (MAB) support").
> 
> While there are maybe other methods, only in the bridge code I may
> access the resulting FDB to test for the BR_FDB_LOCAL flag. There's
> typically not only a single MAC adress to check for, but such a local
> FDB is maintained for the enslaved port's MACs as well. Replicating
> the check outside of the bridge receive code would be orders more
> complex. For example, you need to update the filter each time a port is
> added or removed from the bridge.
> 

That is not entirely true, you can make a solution that dynamically compares
the mac addresses of net devices with src mac of incoming frames, you may need
to keep a list of the ports themselves or use ebpf though. It isn't complicated
at all, you just need to keep that list updated when adding/removing ports
you can even do it with a simple ip monitor and a bash script as a poc, there's nothing
complicated about it and we won't have to maintain another bridge option forever.

> Since a very similar check exists already using a per-port opt-in flag,
> would a similar approach acceptable for you? If yes, I'd send a
> follow-up shortly.
> 

Yeah, that would work although I try to limit the new options as the bridge
has already too many options.

> PS: I haven't spottet you, but in case you're at LPC in Vienna we can
> chat in person about it, I'm here.
> 

That would've been nice, but unfortunately I couldn't make it this year.

Cheers,
 Nik

> Best regards.
> 
> 
>> Cheers,
>>   Nik
>>
> 


