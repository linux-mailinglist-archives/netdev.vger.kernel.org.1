Return-Path: <netdev+bounces-156959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B48FA0863A
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 05:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3ADC188B447
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 04:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90711205E16;
	Fri, 10 Jan 2025 04:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="uH4pIbdU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465B4AEE0
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 04:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736483895; cv=none; b=U23f4IX/mXwrJretOOnRGwyOqKYCi/CAom8w2llTgkwl3w7Lgk1Dfwd2iimhwYJqhqzvID/rZJNY7i+jTgh63i2iNLFyqRkps/It2pWD36yG7O4rjlwgvTQNDlX8jc3tK2515UABf+X9fercy4w4KuozLM1IyEcTZnvTsmu0rxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736483895; c=relaxed/simple;
	bh=NQABrOdJjxGKaiqAIDo3XL0V9WgsqmrsrgDnSsJEpZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqoFhZi635A8kX5Fc2TbzcBQv+HFHAuAQqKgzt6P95LHQJ/NV4Oa66Of/aHByFe4BrpMJ2qEjKjEUZnAenPTvovQtbSV4ve6zu4ab2sh9Bsv7SDzGYGyc8hXu7n8OUcqpBJV45v7/zHfp3gTEufSRMzMAj8xBkRZxXDhY4q3a3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=uH4pIbdU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216634dd574so18258035ad.2
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 20:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736483893; x=1737088693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2VRHR34mrz0IlpIAFdzRMCZZmZsA3d1rUTcqvnksKWQ=;
        b=uH4pIbdUHeoZaQWiz2CcH8v1Yi2mgcrs14D7QdDm+GLCUrpakmP2nl2ESc4D2IBfEh
         QFVqvv+bnLZJqj68Cp6A/msW1oI1IOfVJQjUjPmqu/xTtc04qUHVrgCy6NnNgW72jKXC
         n2b0SJ5hzGAGcDXbF7yJwokmefpqJawAC8h4O/3VBrGe5Wo9pfiTB+45puy5488K32/C
         2ZJg90bY/pCJ2izf1eeokL4B7MkXv3A/Hi7C+y0gGmb9rcAy+d4w9tUH5jNTYLdfkjZn
         64cpVr79FP0e1jnclELLHEFPn+vRM2aQXq92XaEQVFr4B5u/EpEILxoBU5262OuZnRpV
         gxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736483893; x=1737088693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VRHR34mrz0IlpIAFdzRMCZZmZsA3d1rUTcqvnksKWQ=;
        b=BiK6jGK1WrjZkNkaHyetjuvw+siTYF9eqA1HKJ/s33g4IDEWxs9OGuoxLbTuD297T8
         Bwb4yH2HQXwtXKs9mFyWvK/HO+/KcIVVQ4tHUQBUe2Nn1jRYqjIk7PXpRePeyBt4FsLA
         7/qqhC3l2/rpzTE+g+LLnomLpzxnOOqvZoZF63NDFm4k6tPopz4//uh4ykGg2cgkddJG
         sD6yD7mCZ8FluGU6sEYnNgPjb84hc+LYGA/rgnSrSYf4ep/W41zVFG/c2K65FoRPZGOm
         HN7LKyvnogIytl3NCGoEiOKHTgU7Yef/9HNicv+OFhR4UMidabFJYu00TujQKdfAVx6V
         o0xg==
X-Forwarded-Encrypted: i=1; AJvYcCWi57fhtVfJT2WjEhTVoi+gFlaEQlgLZZLZvrRRIjc2Zsme5gP7uIh5sZ7oLJphclzDIr9xVnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUlbzUppUJghObCFytAMNcutD8UCY57QHB0bTo+a/0bAq5FAr
	rF/m+iuOXxQIYozcKllPawW3OqkeG/JCeXk9DqLnEPE6Wq8IpatcC6lzZUPFyN4=
X-Gm-Gg: ASbGncuezLmgjyYZjd7q2gWS64xRYSOs1y1XgdvQZ1moyFHeVd2WU3faPfrfmGUElc3
	F8XrnhppVpF9599TteXmEns4a4BnFIP5iOmjCq2dg3N24vZp/HjS1PKcIP4n6+Q/XOTvTkCXSr5
	4LsxDtykOvU5J6RQr9sQCcsLr3QhV3dGB5cIig2D+4CVl9UCafeXGCDX44zZq6icB0Lh1jo+G0q
	4TOPlZDtsF4MsAFSr8dgZqP+ncMrocZnwRpWw0g8cbohevJLUaJrdx4mqXjBZ0T7Ps=
X-Google-Smtp-Source: AGHT+IGIzSe99ixGVZWcgiRWGgX+k+OXNMhmSVlKwOwyHf8ERTDIVn5bxtWt8REsRDYstEUOtvnfEg==
X-Received: by 2002:a17:902:ce8d:b0:216:282d:c697 with SMTP id d9443c01a7336-21a83f62877mr120429985ad.27.1736483893141;
        Thu, 09 Jan 2025 20:38:13 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f26d996sm5709995ad.257.2025.01.09.20.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 20:38:12 -0800 (PST)
Message-ID: <5e193a94-8f5a-4a2a-b4c4-3206c21c0b63@daynix.com>
Date: Fri, 10 Jan 2025 13:38:06 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
 <677fc517b7b6e_362bc12945@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <677fc517b7b6e_362bc12945@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/09 21:46, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> On 2025/01/09 16:31, Michael S. Tsirkin wrote:
>>> On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
>>>> tun used to simply advance iov_iter when it needs to pad virtio header,
>>>> which leaves the garbage in the buffer as is. This is especially
>>>> problematic when tun starts to allow enabling the hash reporting
>>>> feature; even if the feature is enabled, the packet may lack a hash
>>>> value and may contain a hole in the virtio header because the packet
>>>> arrived before the feature gets enabled or does not contain the
>>>> header fields to be hashed. If the hole is not filled with zero, it is
>>>> impossible to tell if the packet lacks a hash value.
> 
> Zero is a valid hash value, so cannot be used as an indication that
> hashing is inactive.

Zeroing will initialize the hash_report field to 
VIRTIO_NET_HASH_REPORT_NONE, which tells it does not have a hash value.

> 
>>>> In theory, a user of tun can fill the buffer with zero before calling
>>>> read() to avoid such a problem, but leaving the garbage in the buffer is
>>>> awkward anyway so fill the buffer in tun.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>> But if the user did it, you have just overwritten his value,
>>> did you not?
>>
>> Yes. but that means the user expects some part of buffer is not filled
>> after read() or recvmsg(). I'm a bit worried that not filling the buffer
>> may break assumptions others (especially the filesystem and socket
>> infrastructures in the kernel) may have.
> 
> If this is user memory that is ignored by the kernel, just reflected
> back, then there is no need in general to zero it. There are many such
> instances, also in msg_control.

More specifically, is there any instance of recvmsg() implementation 
which returns N and does not fill the complete N bytes of msg_iter?

> 
> If not zeroing leads to ambiguity with the new feature, that would be
> a reason to add it -- it is always safe to do so.
>   
>> If we are really confident that it will not cause problems, this
>> behavior can be opt-in based on a flag or we can just write some
>> documentation warning userspace programmers to initialize the buffer.


