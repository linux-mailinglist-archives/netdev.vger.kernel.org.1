Return-Path: <netdev+bounces-176455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076A5A6A688
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E288A5FF7
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 12:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B57D29CE6;
	Thu, 20 Mar 2025 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOumW9nO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1118641
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475344; cv=none; b=ha4N0hYxIAyq2kgOGd/zO//gclZHPAAkNBU7rN6YWsR69TM+N1XM3AIErFGu1PgGE/fH7epEWD+XPDkHy5dNk3LXN4PhNBlwrhi4b48WmiEa4SqGn4DkelIbYIVnUDDY4pa8F5eLv3HSpeWe+RLnCPvArnCVAetjeCl6gmtwtFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475344; c=relaxed/simple;
	bh=XqnyCkR9PaLdrirpUUgfbS1fw8JcxnFYqckykpD0OFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcCJtiGVqDcjuJJy331tTrPhaL5iuy2PmFnLtYC/jesplL4zi4rS4rDbUJYkMW6phdfu/z2yCwyOar/fn9D46/cN+vUFXh9pkTAVyEigvECGTvxC3X8RSmF0Y3bmOaGsL1LUx7OGCZKsGOI5xfalh5d7yl3gV9mGaGpEQe2OC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOumW9nO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742475341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uU76Eu9ghlyg5AgC3XDLkiwwMGgB66PTcG6tUKpdUeM=;
	b=SOumW9nOebqC2LnFonrSKDSyHX4FGc4z0npwwxYDCBPGevPXHPFrQ1IPBzXsNBNNsGz90e
	uEPTTtlHMAHsqqxcKEfI3B60qJJ8iZ9T0QFZEGWT/GjrOx3tkJRuAFpCM5LWwqrBpxjnKh
	22FM7eIl2L0WEvXv+aqvRxuDGc1NhL0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-QKLorqqbPzqm36RgVBHImQ-1; Thu, 20 Mar 2025 08:55:40 -0400
X-MC-Unique: QKLorqqbPzqm36RgVBHImQ-1
X-Mimecast-MFC-AGG-ID: QKLorqqbPzqm36RgVBHImQ_1742475339
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39131f2bbe5so343233f8f.3
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 05:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475339; x=1743080139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uU76Eu9ghlyg5AgC3XDLkiwwMGgB66PTcG6tUKpdUeM=;
        b=qCgmruFPI/BoUDzPZ3wZiYTu4n/pAcyKgEJhBytiNkk8nWjMVGJ6mspIkuwQsIu3iw
         ftzscjxTCM0zIw+fn0bzMYDzXhryw0OHNQqUpvu1kGYRCCwfkff4l1KGfgUN/EZUkAb3
         Ao7XikNypn+IBhQjvCjeDdRPRZ75sOFzyRSeepRQx4FJCr+WfokGPRrSrig05w76wtCF
         Q0gjqMT60J0pyjkA8jSFURXrBNmqT531LWWlbzus5UjghuL7aX3xfaHl51sYMjRoGzVZ
         8MMLdu0qTDg4p7Z3zX3eRlc3wn69vRCoP1RXwi41qEWZyzI6eLgxwwZRWERbD0unvZrZ
         a1hg==
X-Forwarded-Encrypted: i=1; AJvYcCVt9Pq6aoP1Hvjji/GpK6gGo2JboByTNnqRMP31dReNVbiETihmGvx5HA5lKs5QQ/WOtZjchJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4adCQdTDwNCjrdUOOj4dM4QiekXXEp0XLDf6FdJUUbUPKlX2
	ijc8NrYqhWBz1Nh1mnPIJRCXalDJ7JEIe/as+EbsncBYpzk+U1FZcZYlYSMoYiuNzu36zRmQjxm
	AEgkXcXBUt4wW8SkUw1Q/y4/ElAdj7lnR1SveOSwaGQiBH7R0hokZEQ==
X-Gm-Gg: ASbGncvbsY2kKsyxrDG8H2UCjo/BG7BWhRfKiY2oNcW+WaoguJtCc2Yh65DBEW1xXIn
	aZ5r/2lSUK6NmbL13wVqGe/T3byzioy3NVbZ9AGHwRjORrpnfeLv+5THz/MqHf3d/awmuOteNV2
	dUcwtJTURY7nxomWIxm5rsoAJLEWzQ9Tz0FfQVzRpVZM2IwjSiS2WbVrm29JOh4UwkcWbsbnKfA
	kdipYpsUkjnGcE8jseqAQG3aubOEkX03/UXneQvI6vI/xZoVwXyEIUesEyPqjipPtck9AoYBXt2
	lCloEOHqR549Q9L+eXc9z0NVt1/y1h8KjgwU+m4/UgMy6w==
X-Received: by 2002:a5d:648e:0:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-399795add2dmr2937688f8f.25.1742475338817;
        Thu, 20 Mar 2025 05:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVyhKnTFE+P2/7j9GGvHMrQKyFkRwtXXAFWRCzOhdCzCZGUHga7gonRw/o8WPG2tCQOD4bkA==
X-Received: by 2002:a5d:648e:0:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-399795add2dmr2937650f8f.25.1742475338377;
        Thu, 20 Mar 2025 05:55:38 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb9ccsm24137143f8f.96.2025.03.20.05.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 05:55:37 -0700 (PDT)
Message-ID: <1811bd9a-846a-48f4-95f3-6badc3e063f0@redhat.com>
Date: Thu, 20 Mar 2025 13:55:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] mptcp: sockopt: fix getting IPV6_V6ONLY
To: Matthieu Baerts <matttbe@kernel.org>, Simon Horman <horms@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
 <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-2-122dbb249db3@kernel.org>
 <20250319153827.GC768132@kernel.org>
 <a2b61202-a257-4317-b454-799da27951e8@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a2b61202-a257-4317-b454-799da27951e8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 5:26 PM, Matthieu Baerts wrote:
> On 19/03/2025 16:38, Simon Horman wrote:
>> On Fri, Mar 14, 2025 at 09:11:32PM +0100, Matthieu Baerts (NGI0) wrote:
>>> When adding a socket option support in MPTCP, both the get and set parts
>>> are supposed to be implemented.
>>>
>>> IPV6_V6ONLY support for the setsockopt part has been added a while ago,
>>> but it looks like the get part got forgotten. It should have been
>>> present as a way to verify a setting has been set as expected, and not
>>> to act differently from TCP or any other socket types.
>>>
>>> Not supporting this getsockopt(IPV6_V6ONLY) blocks some apps which want
>>> to check the default value, before doing extra actions. On Linux, the
>>> default value is 0, but this can be changed with the net.ipv6.bindv6only
>>> sysctl knob. On Windows, it is set to 1 by default. So supporting the
>>> get part, like for all other socket options, is important.
>>>
>>> Everything was in place to expose it, just the last step was missing.
>>> Only new code is added to cover this specific getsockopt(), that seems
>>> safe.
>>>
>>> Fixes: c9b95a135987 ("mptcp: support IPV6_V6ONLY setsockopt")
>>> Cc: stable@vger.kernel.org
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/550
>>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>
>> Hi Matthieu, all,
>>
>> TBH, I would lean towards this being net-next material rather than a fix
>> for net. But that notwithstanding this looks good to me.
> I understand. This patch and the next one target "net" because, with
> MPTCP, we try to mimic TCP when interacting with the userspace.
> 
> Not supporting "getsockopt(IPV6_V6ONLY)" breaks some legacy apps forced
> to use MPTCP instead of TCP. These apps apparently "strangely" check
> this "getsockopt(IPV6_V6ONLY)" before changing the behaviour with
> "setsockopt(IPV6_V6ONLY)" which is supported for a long time. The "get"
> part should have been added from the beginning, and I don't see this
> patch as a new feature. Because it simply sets an integer like most
> other "get" options, it seems better to target net and fix these apps
> ASAP rather than targeting net-next and delay this "safe" fix.
> 
> If that's OK, I would then prefer if these patches are applied in "net".
> Or they can be applied in "net-next" if we can keep their "Cc: stable"
> and "Fixes" tags, but that looks strange.

As per off-line discussion I'm going to apply only the first patch in
this series to net, and leave the other for net-next.

/P


