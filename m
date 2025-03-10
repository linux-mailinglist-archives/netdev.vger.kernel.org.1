Return-Path: <netdev+bounces-173443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E935A58DCB
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 09:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F3C3AC5D8
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 08:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E22206B7;
	Mon, 10 Mar 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="NBn0+jdL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F034014A09E
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594608; cv=none; b=j+5eZwBOVhcXTm5VrbZdVXSLo9BwV7hZ0XCLPP1Rjr/JiSHE21yLQfRwL/HR4wcVTbca31WeDSYsv45GkgV6VGNpfIbA6H/D/fMU1lWLpymJllU2XZJGu6/pJgS/7EBkbz6Zabc5uZBXBXu3RgDEeuckRMAAsf2xgTnMh5Qf3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594608; c=relaxed/simple;
	bh=bYJgB5J1rWOwdnYTlKo6V+nCLjOSgt8m+waOje7Vwoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/4/y9zRaXN/VR3UJSqoMbhct6odraL7ZC8OQTjiwgNRUxh1PN5xtTpFjPz9fgIDRsQLP5wxj+DmiglduSguYSgVGEWJkIbTlGzrApFLRHqVLx94Y4OJfc7tJva7p5CBM+CE0Wfqmm+qPLG50E1tr09qB+Qoe+g9pIx8LjLQL5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=NBn0+jdL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22409077c06so49991105ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741594606; x=1742199406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmMfWN/YjTztlUTbhbD2bh8ol9HLPI3qHdmgf2q4Pyk=;
        b=NBn0+jdL7TtqMlPl4/KtYMrMunRagWlS6tO3+ay0X4H+WhhkJwuU7ueUX5D1NIZkas
         f4mKJHieBq5ypC7rZFa17DbwcsoAZmVGWhBL/rOXx9A23dx2C7BlUkJAh52Hs3XqSLTn
         P/NdUhRLn1WqIq649kD06QH/sKTYmp6f5xsgAYLb0hbTseeN8/lwpnQz/sTvn6ovc4K/
         v3HT23f/dOxrK0E5TojvrnqXTL7CF2iQBKuWSD+ipN5FjjJGO/VVyV/Razy7Q9Q4ZORc
         EZj3GrVfAZOt9kAAjcCD9SBJOObn+r+LQ8H92CSYYwOeefZeTaIAEvC/61vA2CfDGZDM
         EkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741594606; x=1742199406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmMfWN/YjTztlUTbhbD2bh8ol9HLPI3qHdmgf2q4Pyk=;
        b=XZjugc2QdxuLDGyBqL29al1gwPzNlt136Swm12wyeRZkLTuRgNgDfu42qgI0xbvBWu
         uh5IK4XMyPUJM3mWs3Uqk/OsbKutJprH32omkCZ+UVnNcou7/SjHSfD+4act/EQAg95a
         +WCIrw/T6t4J7z0kt1xx+gbtipj9D/Al6DKzysAbmC5V4DkW4jZt0NzHdSMB9yWWLL0M
         EKLtoobjpVHU/a3xT2CDmDyKBjKLPj1gfx38BrDN1mwCc3HbjBkKeZmlfZOln+sH5sRm
         8UbboTlKUFepf3R89FvcfdQwBv0P4RyIDO/RM88HXIlvMAv8V77c2DqWg3vuzzWcARV/
         USCw==
X-Forwarded-Encrypted: i=1; AJvYcCWU1Fp0fL93RztHkTWhco+r0B7z4V+VmbdLj4Oocipm5s9FG1Wgf2onUYeDozYHtZceaHY5mow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHWjsOrZL8c0almnLVoxmrnx5Hs5ub2Mg4ZQvZLh8i4is3xhY
	0MeGbDWsGaAtmQfTYuRt9ZcKmVVKAKTSQ+TfIVL8kKYwy5gCFmzTsBH6YgkWK4E=
X-Gm-Gg: ASbGncvcpdRIDVqeeys5695l20s3cvIpWxieXcLvM2REHBjQjehtaOkknS4EA4u2nBb
	w3Vkau3pvxZxYAYLYW8F7LtN5KvAVdLm8vOt+9q6kSVWuTkR/pZh83GC5yN6j9DxXYAhbs/FKac
	AgfgiT+Ye1aiG4HXyrWFJhM/lZRUu2AU0jbbMEmvkCZ/UGAW863rD7qA7v8yvjrR4JWoAc7FsS4
	VKU7YhoyfyCMPlBjwzN5jFN4i88Uoq7HUnl4CA1/LiD92/wN4DPmdzVPxaNOSQS3NTbPeKA0TSL
	49LH9lcz+QGmWxG8+YkFxfn9iLs7wsn5KrzkMjLvwL3R+JDyFZHoD70Ahg==
X-Google-Smtp-Source: AGHT+IF0rPYRbicP0/CqimCD18L/ZR4wVPSR4hAOvttkF0NCrjknQOFhZJD3NGgEaMlKRFPN5jMntA==
X-Received: by 2002:a05:6a00:4f90:b0:736:3d6c:aa64 with SMTP id d2e1a72fcca58-736aab13b03mr19832278b3a.21.1741594606209;
        Mon, 10 Mar 2025 01:16:46 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736e085c030sm819390b3a.14.2025.03.10.01.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 01:16:45 -0700 (PDT)
Message-ID: <5cfedd24-de7c-484b-afa7-ddb4828fb9e8@daynix.com>
Date: Mon, 10 Mar 2025 17:16:41 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/6] tun: Introduce virtio-net hash feature
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
 <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
 <CACGkMEtCEwSB7XvCg7_8ebkcM8o2s8JB2Err2f153L-_i2KtxA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEtCEwSB7XvCg7_8ebkcM8o2s8JB2Err2f153L-_i2KtxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/10 13:01, Jason Wang wrote:
> On Mon, Mar 10, 2025 at 11:55 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> Hash reporting
>>> ==============
>>>
>>> Allow the guest to reuse the hash value to make receive steering
>>> consistent between the host and guest, and to save hash computation.
>>>
>>> RSS
>>> ===
>>>
>>> RSS is a receive steering algorithm that can be negotiated to use with
>>> virtio_net. Conventionally the hash calculation was done by the VMM.
>>> However, computing the hash after the queue was chosen defeats the
>>> purpose of RSS.
>>>
>>> Another approach is to use eBPF steering program. This approach has
>>> another downside: it cannot report the calculated hash due to the
>>> restrictive nature of eBPF steering program.
>>>
>>> Introduce the code to perform RSS to the kernel in order to overcome
>>> thse challenges. An alternative solution is to extend the eBPF steering
>>> program so that it will be able to report to the userspace, but I didn't
>>> opt for it because extending the current mechanism of eBPF steering
>>> program as is because it relies on legacy context rewriting, and
>>> introducing kfunc-based eBPF will result in non-UAPI dependency while
>>> the other relevant virtualization APIs such as KVM and vhost_net are
>>> UAPIs.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>> ---
>>>   Documentation/networking/tuntap.rst |   7 ++
>>>   drivers/net/Kconfig                 |   1 +
>>>   drivers/net/tap.c                   |  68 ++++++++++++++-
>>>   drivers/net/tun.c                   |  98 +++++++++++++++++-----
>>>   drivers/net/tun_vnet.h              | 159 ++++++++++++++++++++++++++++++++++--
>>>   include/linux/if_tap.h              |   2 +
>>>   include/linux/skbuff.h              |   3 +
>>>   include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
>>>   net/core/skbuff.c                   |   4 +
>>>   9 files changed, 386 insertions(+), 31 deletions(-)
> 
> [...]
> 
>>> + *
>>> + * The %TUN_VNET_HASH_REPORT flag set with this ioctl will be effective only
>>> + * after calling the %TUNSETVNETHDRSZ ioctl with a number greater than or equal
>>> + * to the size of &struct virtio_net_hdr_v1_hash.
>>
>> So you had a dependency check already for vnet hdr len. I'd still
>> suggest to split this into rss and hash as they are separated
>> features. Then we can use separate data structure for them instead of
>> a container struct.
>>
> 
> Besides this, I think we still need to add new bits to TUNGETIFF to
> let userspace know about the new ability.

The userspace can peform TUNGETVNETHASHCAP and see if it results in EINVAL.

Regards,
Akihiko Odaki

> 
> Thanks
> 


