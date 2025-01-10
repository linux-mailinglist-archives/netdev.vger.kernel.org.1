Return-Path: <netdev+bounces-157098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E074A08E56
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45639188B9CC
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEE0205AB6;
	Fri, 10 Jan 2025 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="p+9k1nB1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A7205512
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505953; cv=none; b=ZVvOjUEVc4TUslyRbkotfns9mov8Z5mUppMbMRzeXvWldjnd4SI0LWIm3hBUPdkSksk6xzO8xm3/cMhvUzdc3QrSA9xev6a9FKIFvPbChe1IkkfVSrRr5WGkvtMg0ALGqRMgPSXt6AyaYAbK4sGjao8qzCDXq7Moe3ZsCqfXGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505953; c=relaxed/simple;
	bh=xwTt7EqwBQG9jsW/MlOAUi0BI8IrI3gTou3huVPPuY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEOnxYHQ0HipBQFU0SRYAQINefZKfilMxznJ+sddmW4kXfod9KqfSWI+Qun3JTW4bCxHsKi7/ZHDxVq489CqlW6V/QEco6Y1IMdUIH7cnXS+roe+O7C7krPgoak75MFDEAuiUz/Q6TCkhJUsQH0WcXrchN2E3EhXTg/yHuFQcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=p+9k1nB1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21619108a6bso31237115ad.3
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 02:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736505950; x=1737110750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsqFmJrwySuAsgeQ23Hdp8zYfHgcqjGeQVThq/MnWD0=;
        b=p+9k1nB1y1wLV4WAMd6GxCzPpVGINnfcjx4nS24pw7fZ/hn3Ly9tYIkV5IySy0AbyK
         aOXcSz4wHFF9tbEmM93KdWsCVwG5WqVjTyWSOk65sD/ojHlm9ICq09k1pWkhKAleJW2Y
         GTpwiuoMSgAUOr/YqrhWk0gdTtaC6LTn5HtGSjUDFQo8I1HMsLOeti+9umCaqx44hAZc
         QTyJXAhs//a1i3RM15mcLV/fA+lMeyVQITdrIQtXuahzFtoXTgRyQ4kghTD5jz7Z9KMq
         0wMQx+ee12Ua1YNIKaehndgJ07Kvrs3dmjzDAheUSpLTmyVK9vJRpmy333GkrjNXUT/F
         IiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736505950; x=1737110750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsqFmJrwySuAsgeQ23Hdp8zYfHgcqjGeQVThq/MnWD0=;
        b=Il6+4UUmGcqpQ5Fw8bhPQL/EFFsJHqQ6y0/FhYcBMPS+yGdCVEGGauAkEfjSmMHhkk
         vf1E9RRRlyTj7PwrWsksfLaVJSfMnkNQm9Z7Pvw5OAWQ9YnGsd6OCRXBFw1D1/unRYEG
         cT1cprACekT/4NSOPWt6df4Wi7eEBO4XZjVwV208fvjhkngth/ikHo9diYOrn593Y+Q/
         +j9govPTtEqZtKCLHKQaewrMZq1Mwm6pr9tYGS8BUZp/jLVtAokUfJTEsO1FfoXAbIyZ
         7ZxzcmWAPv7SCQwEyHVWgCXfPCYBGY/JwM1/Fbx6tKv/lBu9FB03VGg3c4aBE4807HwX
         OEsA==
X-Forwarded-Encrypted: i=1; AJvYcCVjK730hr0H7fDdv3nznFyPxSck1THJYUZiphWsbw+BiikCzwUYxo1ZWQJyxIeZ3tJ1Uhk4LbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWN9LjhVS5uFqEHWZTLzKiTqJr9RUBILJfhV56YXwvnCNdSPcF
	d383rO9ydY64Maf+z9oPNcglL0WUlEqxBNaFbR8WaZ0GrhdVnKl+uYfNihZvGqc=
X-Gm-Gg: ASbGncu0y/UYv5fHwXG9bVeOvgHOQOIxoNfMkrXf0jO/r1AkE2Mz4IAe8R85COYQxvy
	+0qD+jioSP96lx/3p3ZZzvgQCAetstYCxqUedKalp5eEugCSxbPOuoeqvHCChHMIEEptND1yOYc
	H1Cdx5SUZgm+C6Fo3NaKDzS6uCdfOd6wEO6y5AgSJ8BWQqdSLjGwAm+tbgl1KAWmZ8K5Yw/OHky
	iLM+gHWW8EjAEBjUy6WLaBL4R0/yR+rwUP7YdspaVrUVVlfspAx4B5J+o2iSr5Sftw=
X-Google-Smtp-Source: AGHT+IFPsdQcQ1JqLrS7hF+DlyZPpDcSA6WD6jF46cfVg9u5bIjzxZ5xlWPHe2yN4Ld9eivHDLICVA==
X-Received: by 2002:a17:902:ecc5:b0:216:7cbf:9500 with SMTP id d9443c01a7336-21a83f36df7mr150799945ad.6.1736505950548;
        Fri, 10 Jan 2025 02:45:50 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e0dfsm11714655ad.41.2025.01.10.02.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 02:45:50 -0800 (PST)
Message-ID: <3a5001b5-9a07-4dfd-8cec-1e5f7180b88a@daynix.com>
Date: Fri, 10 Jan 2025 19:45:44 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
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
 <5e193a94-8f5a-4a2a-b4c4-3206c21c0b63@daynix.com>
 <20250110033306-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250110033306-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/10 17:33, Michael S. Tsirkin wrote:
> On Fri, Jan 10, 2025 at 01:38:06PM +0900, Akihiko Odaki wrote:
>> On 2025/01/09 21:46, Willem de Bruijn wrote:
>>> Akihiko Odaki wrote:
>>>> On 2025/01/09 16:31, Michael S. Tsirkin wrote:
>>>>> On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
>>>>>> tun used to simply advance iov_iter when it needs to pad virtio header,
>>>>>> which leaves the garbage in the buffer as is. This is especially
>>>>>> problematic when tun starts to allow enabling the hash reporting
>>>>>> feature; even if the feature is enabled, the packet may lack a hash
>>>>>> value and may contain a hole in the virtio header because the packet
>>>>>> arrived before the feature gets enabled or does not contain the
>>>>>> header fields to be hashed. If the hole is not filled with zero, it is
>>>>>> impossible to tell if the packet lacks a hash value.
>>>
>>> Zero is a valid hash value, so cannot be used as an indication that
>>> hashing is inactive.
>>
>> Zeroing will initialize the hash_report field to
>> VIRTIO_NET_HASH_REPORT_NONE, which tells it does not have a hash value.
>>
>>>
>>>>>> In theory, a user of tun can fill the buffer with zero before calling
>>>>>> read() to avoid such a problem, but leaving the garbage in the buffer is
>>>>>> awkward anyway so fill the buffer in tun.
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>
>>>>> But if the user did it, you have just overwritten his value,
>>>>> did you not?
>>>>
>>>> Yes. but that means the user expects some part of buffer is not filled
>>>> after read() or recvmsg(). I'm a bit worried that not filling the buffer
>>>> may break assumptions others (especially the filesystem and socket
>>>> infrastructures in the kernel) may have.
>>>
>>> If this is user memory that is ignored by the kernel, just reflected
>>> back, then there is no need in general to zero it. There are many such
>>> instances, also in msg_control.
>>
>> More specifically, is there any instance of recvmsg() implementation which
>> returns N and does not fill the complete N bytes of msg_iter?
> 
> The one in tun. It was a silly idea but it has been here for years now.

Except tun. If there is such an example of recvmsg() implementation and 
it is not accidental and people have agreed to keep it functioning, we 
can confidently say this construct is safe without fearing pushback from 
people maintaining filesystem/networking infrastructure. Ultimately I 
want those people decide if this can be supported for the future or not.

> 
> 
>>>
>>> If not zeroing leads to ambiguity with the new feature, that would be
>>> a reason to add it -- it is always safe to do so.
>>>> If we are really confident that it will not cause problems, this
>>>> behavior can be opt-in based on a flag or we can just write some
>>>> documentation warning userspace programmers to initialize the buffer.
> 


