Return-Path: <netdev+bounces-241148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D57EEC8043C
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A318341AF1
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6DA2FF165;
	Mon, 24 Nov 2025 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tl1JDRRH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hivwPqy7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE5296BAA
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763985011; cv=none; b=Vah/K6yDcI2ARTE7MOa0meuHzfvCWvn93gHaHZksNn2H+cfNvHH+6/JveZjtnmkK6MyvdB9q8vuArrbLC/hmVb8msF5jEVdiJDj+8NoMbgNJ3fNlTzbVqbwOHP/ec7cYSHkP7hZaLkaSyBWgilhbQAsfuTO0vEr1g154Obv0cuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763985011; c=relaxed/simple;
	bh=Bhfx13V/1EPFjWbLYI/1+XVplSCwXJzEc0+7lmCEVe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4AY0huyJHM9BeEbs0nS0884pSObYmWNTpzEN3fnsqbj0Q2dv/sKjV2rhO0lT75wFg01i/I2WdxFaDJbq2kEyOZJYR17JK1Ak+uoVeL7Td8erJnSeIkb+kZ73KKzF+JVHzuUlOsMrI80AKtxeQF1sFP/+zQjIqGZ+xxo3+2ek9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tl1JDRRH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hivwPqy7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763985009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4Kg/QbITEpZ84Ri1lo2OpOJ/42qXgqIwDaIIHXiNpQ=;
	b=Tl1JDRRHRl2ggL+SDbOaGwd7aLtP9COL+2Ts9QbPmy0y/xNulness7netbiW1o18+zC195
	Pe9cDvDG0WipW+LAalacW2DRKWGdRY2ccXQT7faKOYBNpSFiV9aJc7/8uL5WUfWIQUl54q
	yYyk5H9HvFkuR8lGowRNCgWEjRTtjW0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-SfITN3ewN62EFznRe7aSFA-1; Mon, 24 Nov 2025 06:50:07 -0500
X-MC-Unique: SfITN3ewN62EFznRe7aSFA-1
X-Mimecast-MFC-AGG-ID: SfITN3ewN62EFznRe7aSFA_1763985006
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-641738a10c4so5342254a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 03:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763985006; x=1764589806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4Kg/QbITEpZ84Ri1lo2OpOJ/42qXgqIwDaIIHXiNpQ=;
        b=hivwPqy7w3dQWRxD7Om57HCSaZB32SJayJch1cw/VWGH+shraMubPt71KOAm3qUECM
         yHpTqQt7kZ1EI16Fd0l30u4thwtnmSqxi+/DiidJNcQrR7vDVYskiLjPiwbVT1JzvYfp
         nZhipp5SfuxPK1fryENOw/CcY43IaRUkUug1ofC+Z4ynRgjOiDneSJZkoD0JOZ0Zv6M8
         iG6qaPiWHGgkngK3z+UbWl5o0KklxRP0MKXWrB9183Ruq9CkIruusz4hwHomTJJpJ7G9
         bTzxSjg/pkL4MWW68D34IbYHrkKWXwO2U1ggNO1D40fGoSYleGRsCd+gqKG+jDXsyahA
         CkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763985006; x=1764589806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4Kg/QbITEpZ84Ri1lo2OpOJ/42qXgqIwDaIIHXiNpQ=;
        b=Mm438zZjdvejDINXtE87qTz0WfcS/usplp/NIqseDoJmtz47GCXgV1gDoCS3eipC2m
         s92f6BJAdoV4j18Zhr6PFYdL03aLMc0Do1uxlMGXjJ10iFsvrOn5dA0DjrRBS3Wpx7J3
         4FCYqtxcboRnLjOKbthoaoUeCpV8CzYiJtjNm6MEtgfK29VStaOSY22lG3VEnI9smktl
         YQxcgiZ/CjfArEhVl1+HC80z5+5GepJe6uqbX9lEz2FFznE2jlmEFD/f0/MTwMO+fP3x
         2p7A/TUjZsmB2PASVz2Va8YTam8NQdHPvg3wyqCQrf0jFfeOCrCxbqbFhVXRGrZHQqIz
         i+pw==
X-Forwarded-Encrypted: i=1; AJvYcCUnqeuT9zhoYZT8F9rogawC7ikF90rOv9dbGRSgtdWgBVJRzVZ4YMKYrCYSBlxl9HIE6yunZAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAuUxFvj+K4vkK7xREbpyldM7AX5ftA4URfK8FZBbzikcJrbm
	OxtQDrEBiU872iT8wKjPPek9Go4i5/uaDSauIeViYRP5CjUZcBS3c8pzcDUERVNPM0FtK1BtxZ9
	9FOdNHqASfEBgEZ0ybujbRrdzkPgkUNTCK7T0axzpbPZZD3+7Uz60xDFWYw==
X-Gm-Gg: ASbGnct9a31CMXrPVvNzUeGEQQbl5Hg+8hp4qtY4zMTGak19+X4JxSLpOHd+Cz8co+e
	vq9qxeLwxrSZMP8u/B0ZiUL8UNS1DVymIkaV8qrKztgrqBA13EUYQCGFdNZCFNHbqHpK32TokB/
	A/5TwxWm/KAGR/6de6tGu/xBVvPhIfArh2TixBIVLSDjnfb9oMF+B0kuKGZMUEPcEtMgEZ9QWQW
	lx1KjS6qyuNPUn3hKDIO4/5NfzY+HjHxYiFII6d138Wk3AimwqALnFaCOGtyabUFwFRVNNXij2t
	ymEZhY+zLc8xARq+AkKlTK1lvaGbd7UjdI04kFSOuq/3FPRrc9+e9zvHQb00FkgEq+3BDIUGA/a
	4xj/Yn5FMnTkKVqQDW1M4WZr71iuQ+6XaKQypSFp+uJfq+hhvgRaTx3Be47y6YQ==
X-Received: by 2002:a17:906:9fcb:b0:b76:3397:cfb5 with SMTP id a640c23a62f3a-b7671a17153mr1396872466b.58.1763985006385;
        Mon, 24 Nov 2025 03:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrAsnNU59J4LdNJ/Blq3Kbo6ZrloTHMBy4gsInF2R9s60UpJ8zgkaM/qwmrjZvMM9522v2ow==
X-Received: by 2002:a17:906:9fcb:b0:b76:3397:cfb5 with SMTP id a640c23a62f3a-b7671a17153mr1396862566b.58.1763985005019;
        Mon, 24 Nov 2025 03:50:05 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d7cb3bsm1286766966b.27.2025.11.24.03.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:50:04 -0800 (PST)
Date: Mon, 24 Nov 2025 12:49:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
Message-ID: <pstj7youxwwrpj3bl2a76kh2t62by2vdakv5elqvueobw3o4pj@tnknzlqdt344>
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
 <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
 <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
 <rptu2o7jpqw5u5g4xt76ntyupsak3dcs7rzfhzeidn6vcwf6ku@dcd47yt6ebhu>
 <09c6de68-06aa-404d-9753-907eab61b9ab@rbox.co>
 <663yvkk2sh5lesfvdeerlca567xb64qbwih52bxjftob3umsah@eamuykmarrfr>
 <1b2255c7-0e97-4b37-b7ab-e13e90b7b0b9@rbox.co>
 <06936b55-b359-4e3d-bec0-b157ca32d237@rbox.co>
 <fy3ep725gwaislzz6lyu27ckswp2iyy5gj6afw6jji6c3get3l@lqa6wpptq5ii>
 <69a3d223-dd95-43df-af3a-522968d6b850@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <69a3d223-dd95-43df-af3a-522968d6b850@rbox.co>

On Sun, Nov 23, 2025 at 10:46:22PM +0100, Michal Luczaj wrote:
>On 11/21/25 10:21, Stefano Garzarella wrote:
>> On Thu, Nov 20, 2025 at 10:12:20PM +0100, Michal Luczaj wrote:
>>> On 11/19/25 20:52, Michal Luczaj wrote:
>>>> ...
>>>> To follow up, should I add a version of syzkaller's lockdep warning repro
>>>> to vsock test suite? In theory it could test this fix here as well, but in
>>>> practice the race window is small and hitting it (the brute way) takes
>>>> prohibitively long.
>>>
>>> Replying to self to add more data.
>>>
>>> After reverting
>>>
>>> f7c877e75352 ("vsock: fix lock inversion in vsock_assign_transport()")
>>> 002541ef650b ("vsock: Ignore signal/timeout on connect() if already
>>> established")
>>>
>>> adding
>>>
>>> --- a/tools/testing/vsock/vsock_test.c
>>> +++ b/tools/testing/vsock/vsock_test.c
>>> @@ -2014,6 +2014,7 @@ static void test_stream_transport_change_client(const
>>> struct test_opts *opts)
>>>                        perror("socket");
>>>                        exit(EXIT_FAILURE);
>>>                }
>>> +               enable_so_linger(s, 1);
>>>
>>>                ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>>>                /* The connect can fail due to signals coming from the
>>>
>>> is enough for vsock_test to trigger the lockdep warning syzkaller found.
>>>
>>
>> cool, so if it's only that, maybe is worth adding.
>
>Ok, there it is:
>https://lore.kernel.org/netdev/20251123-vsock_test-linger-lockdep-warn-v1-1-4b1edf9d8cdc@rbox.co/

Great!

>
>And circling back to [1], let me know if you think it's worth adding to the
>suit. I guess it would test the case #2 from [2], but it'd take another 2s

If you think it is better to put them in vsock tests, instead of bpf,
it's fine by me. 2s more is okay IMO.

>and would require both h2g and non-h2g transports enabled.

This should be fine, IIRC we recently added something to check
transports and print warninng or skip tests in that cases.

Thanks,
Stefano

>
>[1]:
>https://lore.kernel.org/netdev/fjy4jaww6xualdudevfuyoavnrbu45cg4d7erv4rttde363xfc@nahglijbl2eg/
>[2]:
>https://lore.kernel.org/netdev/20251119-vsock-interrupted-connect-v2-1-70734cf1233f@rbox.co/
>


