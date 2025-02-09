Return-Path: <netdev+bounces-164515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A191A2E061
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 21:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BCE3A335A
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D7C1E04B5;
	Sun,  9 Feb 2025 20:16:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F91119A;
	Sun,  9 Feb 2025 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739132199; cv=none; b=V0bofKBXAodIlssdRprtkIC6Q/YtE/jxWsNm7PjN1jO8nWMHO6xj/xEW/sdOPcRMYlAchV7qPKHdV72rSAFn2coKvc7RiGV6K4dW76PK1yfgkHdd/Bxp8zLWfQpD0wgWmq4Bjt7M3ADyi2ZxfqVB65SUR+esM9Za1M8kzPbpbJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739132199; c=relaxed/simple;
	bh=7PUpceYtqAYnsrUpQIi8LdEBl5dp3+qFOQe5eVTwX0E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TQtHGmDiGL/dL7cMGSfEDhtzwPN2NwDcjjI4Zk80jdpVlf8FLopDBHMSJ5Vpo5R6DXrcX0HJNM0Zd+Z8xvGPq8zAgtKp/w86ZWoAMOU85/n7QgZSl64q+k55SxI3EuuYsnwSiGc/KcYEBcjc15kD75W47O3H+CH7a4MSyjzRO5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5de77a5d2a2so726483a12.0;
        Sun, 09 Feb 2025 12:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739132196; x=1739736996;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcnq3Qcy2LcXlI5p7Yl7QaLicFI76aNuTJDZwMWxRg8=;
        b=wsH/p2noqMY/iQXMrVk+eCQrcKSZMOG8Q3NnCdvex3caWrZXG5UfoWXYYfQbN0Dg6x
         0bCxsPuntEA+7ZKqLXLcI4j7s44lH1FDHlrGin7bMCX47gezB6/qMBRSPn2auGNoYLtk
         BvLffNk2mPZVAHmTMr269/7M/qJEWDBh2uQqIvgTyWBTZd0MpfPVzXqa2WNfjDU2MbLX
         T9rakO0pBB2pJfDe9I6Nkl7jivHtQQK264HabJChOBNqgRVQnYLr635urPvPst738/e1
         GIs2JARvA+bxYvZ2uKOLqLD64m5rwFSXL4iHmNpYXibR0wdIpkF0ApzukBKxm1iPZdGE
         lMxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdbHSHziJP+VzZP5Bab/ewyklGoSC9/9IJiriH+hkRwM1iJUj13ixJ136MzJR6BJ9bA1Taz5EwP9JqtbH8R64=@vger.kernel.org, AJvYcCVMN44Nasy9dttwa+xn/uBuGxb/YfvLIuW49YR/K2mgnHiBfFReYXJAD0hf4a78IESklQy8aFMy@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAPJrHbb9arQLDHQBV1E/VzsY2EBVeHeJVHy65X5wWlD3NBy0
	J+rhtoZD4YE1MyvgTSv2EP35+Fw9W+ckRwA+wQjKkEx32vtV4K5/ReKBOngE
X-Gm-Gg: ASbGncuz6TzJZR/DvdowqoukLQRIza/Zj9uYiX0rE1QnVPOQ2rr5RM/KxawE5rSR3tO
	8THxSAQp30tXXDTYF3mRRz6uQav9EHp6+o853VOeT7n9zwH3wpwzhHq/yl6jLMTjXPOMiZYxxEo
	JA5bYynKPoi45Yto65jGigOs0q3P4tpnd27L8evF4nJfL5Nfu50aXqdilTvZS4LSpAIVRNXxBkb
	FoxOjnp+bezVqeVuQNz9n1UCcOkiMZKNK9qJZxo8D5T1h+ICMdE9q8vt8MkCkGM97DbB2e8QDNf
	2bHqU6fdpIE6YXaUq/aS0Em1r0WXKD/krs0o454ae1sGz4I=
X-Google-Smtp-Source: AGHT+IF2CryFI8dyJN2wBpThrDZwkDaSkqSUw353zMPpLy+BhutEea3TRV3WDfJAc7GdISOEnhhCkQ==
X-Received: by 2002:a17:906:7310:b0:ab7:6c4e:8e52 with SMTP id a640c23a62f3a-ab789a9bd9bmr1331859066b.5.1739132195824;
        Sun, 09 Feb 2025 12:16:35 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b77d58bdsm169360766b.130.2025.02.09.12.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 12:16:35 -0800 (PST)
Message-ID: <acf28b0e-5d34-46e0-823f-8028e2fb8356@ovn.org>
Date: Sun, 9 Feb 2025 21:16:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, dev@openvswitch.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Kees Cook <kees@kernel.org>, David Ahern <dsahern@kernel.org>,
 Yotam Gigi <yotam.gi@gmail.com>, Tariq Toukan <tariqt@nvidia.com>,
 linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Cong Wang <xiyou.wangcong@gmail.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [ovs-dev] [PATCH net-next] net: Add options as a flexible array
 to struct ip_tunnel_info
To: Gal Pressman <gal@nvidia.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250209101853.15828-1-gal@nvidia.com>
 <2ef88acc-d4d7-4309-8c14-73ac107d1d07@ovn.org>
 <fe814549-3bd4-4ef6-8e7d-9d21626766e1@nvidia.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <fe814549-3bd4-4ef6-8e7d-9d21626766e1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/25 20:37, Gal Pressman wrote:
> Hi Ilya, thanks for the review.
> 
> On 09/02/2025 18:21, Ilya Maximets wrote:
>> On 2/9/25 11:18, Gal Pressman via dev wrote:
>>> Remove the hidden assumption that options are allocated at the end of
>>> the struct, and teach the compiler about them using a flexible array.
>>>
>>> With this, we can revert the unsafe_memcpy() call we have in
>>> tun_dst_unclone() [1], and resolve the false field-spanning write
>>> warning caused by the memcpy() in ip_tunnel_info_opts_set().
>>>
>>> Note that this patch changes the layout of struct ip_tunnel_info since
>>> there is padding at the end of the struct.
>>> Before this, options would be written at 'info + 1' which is after the
>>> padding.
>>> After this patch, options are written right after 'mode' field (into the
>>> padding).
>>
>> This doesn't sound like a safe thing to do.  'info + 1' ensures that the
>> options are aligned the same way as the struct ip_tunnel_info itself.
> 
> What is special about the alignment of struct ip_tunnel_info? What are
> you assuming it to be, and how is it related to whatever alignment the
> options need?

There is nothing special in it.  But the fact that there was no explicit
alignment of the options before doesn't make them not actually aligned.

> 
>> In many places in the code, the options are cast into a specific tunnel
>> options type that may require sufficient alignment.  And the alignment can
>> no longer be guaranteed once the options are put directly after the 'mode'.
> 
> What guaranteed it was aligned before? A hidden assumption that a u64 is
> hidden somewhere in ip_tunnel_info?

I agree that it may break if the structure changed.  However, there are,
in fact, __be64 fields in the structure that make the whole thing aligned
and it's part of dst_metadata that by itself is also aligned, so any options
in the tunnel info will be inherently aligned for 8-byte accesses.

I didn't check the actual structure layout with this change, but it seems
like the start of the options will be only 2-byte aligned, making them
non-aligned for most types of accesses and likely causing problems after
the cast.

So, not saying that the current code is good, but it's implicitly doing the
right thing.  We should make that more explicit and add some guarantees that
the alignment will not break, but we should not break the alignment itself.

> 
>> May cause crashes on some architectures as well as performance impact on
>> others.
>>
>> Should the alignment attribute be also added to the field?
> 
> Align to what?
> To the first field of every potential options type? To eight bytes?

Ideally we would have a proper union with all the potential option types
instead of this hacky construct.  But if that's not the the way to go, then
8 bytes may indeed be the way, as it is the maximum guaranteed alignment
for allocations and the current alignment of the structure.

But I'll leave this for others to weigh in.

Best regards, Ilya Maximets.

