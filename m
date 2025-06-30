Return-Path: <netdev+bounces-202353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69418AED828
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765FE175ADB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF75238D22;
	Mon, 30 Jun 2025 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQI7JdHs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F1238C20
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274365; cv=none; b=dCV4GF1N2pyxvazE+SQNVE37oVSzSy3FSNJ/+s8bFIvHf9JlVYwSM+ZEr5LdfH4fi8yOIRZRVSfpnVWxEHB9opUhTfcdK7kjDSYgdgQP8JW5F2v8wbd/V8VnAUoomHWfgDdRWA65oYiUjM4U5Gny3mjiVIzY95xLoq7s9Ci3MiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274365; c=relaxed/simple;
	bh=wRPjo9rf+tUKuB78jhsyCXImccziciYaYS7TdDqiExs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGqTGFTaOv3bwetBnQwmwt8hQcRkUI0ZjFC6ph7p6F+EhIk4BZbUyZwUGaNhT4kNAUOyQV1JFTEAqNqY837Jz8yZnRvDGIvmylr7FULHuNcZJBuR/2XL/HQUwoljsEObgg5Y7sUsruA9Gbv/L6fzkEKZZ0BycvJWs4OA90aAgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQI7JdHs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751274362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IP0b5VG41bBhmyGe33Uf59EFBAK0BAw5ZnVY9pFjKm8=;
	b=BQI7JdHspgVuosHSDVVPntPUw/9vAWlMDne76CJ25nyYUkLU4b3hTtnqtppmW7p4DojiBJ
	a9yM7hHKvQDDKpMP0g0ePfMb1PaB+eyzAAUUJr8hqwJh8Fu74jJrRyvoAad5tpOq4fXS2G
	DSAG+KkFd3G3TtPqR7kLNvBiJrxSwYc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-1grcedupPZWJ2Rbf4q169A-1; Mon, 30 Jun 2025 05:06:00 -0400
X-MC-Unique: 1grcedupPZWJ2Rbf4q169A-1
X-Mimecast-MFC-AGG-ID: 1grcedupPZWJ2Rbf4q169A_1751274360
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4067aeea8c0so1430679b6e.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 02:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751274360; x=1751879160;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IP0b5VG41bBhmyGe33Uf59EFBAK0BAw5ZnVY9pFjKm8=;
        b=Z8lPmLkmAJ/VCvYJ7iPnrpLf2ObXKGq24s2Nlr3V96z6P3rQTtLvdTfRZfMPl8Qk1n
         Oi1qpbbc0W0TwI6/pFLtmaM66gggDHyDBo4BzQH38lYyrwqGSWtJV7+lKpEp6Y/fjR9E
         NhLJ22xB3KRGPnqD79JvJ/dG+zIKX+2ce+WQeNvcEL7Wk+ij7ZH0fG6Cd/W6vJ/BAGzk
         u3xiFwrWXgn0tt7GqrA7tCawljzzc9dPAe+SQGYYcHi7jZ8SRAh/z+PfMwX68R0TWM5N
         pdXSltNwfUCmCRr6YWQ6c2P3KyzWQIDFfBSOhM8wZ6LoUh9E9XFO3kNPoyRC+pcSaUqz
         dpqw==
X-Forwarded-Encrypted: i=1; AJvYcCW6O+PW32SD5E1nF88sqFQ3MJSz84AEM/btQSPHUM9EXnWscqMpJ2c79xWQg+DKI3kV2CL6cvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZ0WQT7MsHBz81ZPDN0Pg6R3Fy8eRWr/b5jqGX+EnKPmnHkhr
	AkxaP0zxIeLXn3FVJ4JQPa1B4rie2xgv3ylfX8GlAT0wrmS5zD4869+gbkbwLwo5yuBwrdbMoWe
	gIZdVA1EFelgx+LKmdF38B3hjqMQJ4lS437Dl9DfkBFAN4cP8/KmJ3WShNQ==
X-Gm-Gg: ASbGncuxO8ciRhSQ8sRUu4QeiLLVSnRvYhZNGkayBlvbssGu/DKNDxClUAjYTnfWHGG
	A+3F1CDTgc5q6aL8kAe9V4ADW4ZqEOKVn01sjRZDK5xehWia9Gj2meBLPOaRRk/LyxGoqHjECaZ
	WnHMMjzLSry0xua79vdO0A2eywWrE/p20A8D7BsJFkJJL/Hib2ZWvamoK09Rr5HYg2b6RnByVl1
	bauvW06imiMOsUDrQoHesRuaKlRvncsCG3x9+h6p0qxT9MWMrWnkqM7xFLfeG2oVrOafgVjkVZy
	/VH3lzFBvk7sBmlK7lnIMtI2Dr3W
X-Received: by 2002:a05:6808:2448:b0:406:6efa:3595 with SMTP id 5614622812f47-40b33e15bb8mr9814804b6e.24.1751274359687;
        Mon, 30 Jun 2025 02:05:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEepeaV8KclWnT/fUB+9LJI7sNEW53kR2xRdO2kaJqSt6uJ0a2hZ7/U6zTmIrJ8UvZVW5bmTA==
X-Received: by 2002:a05:6808:2448:b0:406:6efa:3595 with SMTP id 5614622812f47-40b33e15bb8mr9814779b6e.24.1751274359216;
        Mon, 30 Jun 2025 02:05:59 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.177.127])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b32421052sm1617002b6e.37.2025.06.30.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 02:05:58 -0700 (PDT)
Date: Mon, 30 Jun 2025 11:05:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 1/3] vsock: Fix transport_{g2h,h2g} TOCTOU
Message-ID: <4vsrtxs3uttx6w2zyk6rxescpwvrikypiw6tvjheplht6yzonc@ch6k3xlftikw>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-1-02ebd20b1d03@rbox.co>
 <zdiqu6pszqwb4y5o7oqzdovfvzkbrvc6ijuxoef2iloklahyoy@njsnvn7hfwye>
 <d8d4edb2-bf14-42b2-8592-79d7b014e1a7@rbox.co>
 <owafhdinyjdnol4zwpcdqsz26nfndawl53wnosdhhgmfz6t25n@2dualdqgpq3q>
 <e97b5cae-f6ef-4221-98e1-6efd7fdc6676@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e97b5cae-f6ef-4221-98e1-6efd7fdc6676@rbox.co>

On Sun, Jun 29, 2025 at 11:26:12PM +0200, Michal Luczaj wrote:
>On 6/27/25 10:02, Stefano Garzarella wrote:
>> On Wed, Jun 25, 2025 at 11:23:30PM +0200, Michal Luczaj wrote:
>>> On 6/25/25 10:43, Stefano Garzarella wrote:
>>>> On Fri, Jun 20, 2025 at 09:52:43PM +0200, Michal Luczaj wrote:
>>>>> vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
>>>>> transport_{g2h,h2g} may become NULL after the NULL check.
>>>>>
>>>>> Introduce vsock_transport_local_cid() to protect from a potential
>>>>> null-ptr-deref.
>>>>>
>>>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>>>> RIP: 0010:vsock_find_cid+0x47/0x90
>>>>> Call Trace:
>>>>> __vsock_bind+0x4b2/0x720
>>>>> vsock_bind+0x90/0xe0
>>>>> __sys_bind+0x14d/0x1e0
>>>>> __x64_sys_bind+0x6e/0xc0
>>>>> do_syscall_64+0x92/0x1c0
>>>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>>
>>>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>>>> RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>>>>> Call Trace:
>>>>> __x64_sys_ioctl+0x12d/0x190
>>>>> do_syscall_64+0x92/0x1c0
>>>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>>
>>>>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>> ---
>>>>> net/vmw_vsock/af_vsock.c | 23 +++++++++++++++++------
>>>>> 1 file changed, 17 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>>> index 2e7a3034e965db30b6ee295370d866e6d8b1c341..63a920af5bfe6960306a3e5eeae0cbf30648985e 100644
>>>>> --- a/net/vmw_vsock/af_vsock.c
>>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>>> @@ -531,9 +531,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>>>> }
>>>>> EXPORT_SYMBOL_GPL(vsock_assign_transport);
>>>>>
>>>>> +static u32 vsock_transport_local_cid(const struct vsock_transport **transport)
>>>>
>>>> Why we need double pointer?
>>>
>>> Because of a possible race. If @transport is `struct vsock_transport*` and
>>> we pass `transport_g2h`, the passed non-NULL pointer value may immediately
>>> become stale (due to module unload). But if it's `vsock_transport**` and we
>>> pass `&transport_g2h`, then we can take the mutex, check `*transport` for
>>> NULL and safely go ahead.
>>>
>>> Or are you saying this could be simplified?
>>
>> Nope, you're right! I was still thinking about my old version where we
>> had the switch inside...
>>
>> BTW I'd like to change the name, `vsock_transport_local` prefix is
>> confusing IMO, since it seems related only to the `transport_local`.
>>
>> Another thing I'm worried about is that we'll then start using it on
>> `vsk->transport` when this is only to be used on registered transports
>> (i.e. `static ...`), though, I don't think there's a way to force type
>> checking from the compiler (unless you wrap it in a struct). (...)
>
>I've found (on SO[1]) this somewhat hackish compile-time `static`-checking:
>
>static u32 __vsock_registered_transport_cid(const struct vsock_transport
>**transport)
>{
>	u32 cid = VMADDR_CID_ANY;
>
>	mutex_lock(&vsock_register_mutex);
>	if (*transport)
>		cid = (*transport)->get_local_cid();
>	mutex_unlock(&vsock_register_mutex);
>
>	return cid;
>}
>
>#define ASSERT_REGISTERED_TRANSPORT(t)					\
>	__always_unused static void *__UNIQUE_ID(vsock) = (t)
>
>#define vsock_registered_transport_cid(transport)			\
>({									\
>	ASSERT_REGISTERED_TRANSPORT(transport);				\
>	__vsock_registered_transport_cid(transport);			\
>})
>
>It does the trick, compilation fails on
>vsock_registered_transport_cid(&vsk->transport):
>
>net/vmw_vsock/af_vsock.c: In function ‘vsock_send_shutdown’:
>net/vmw_vsock/af_vsock.c:565:59: error: initializer element is not constant
>  565 |         __always_unused static void *__UNIQUE_ID(vsock) = (t)
>      |                                                           ^
>net/vmw_vsock/af_vsock.c:569:9: note: in expansion of macro
>‘ASSERT_REGISTERED_TRANSPORT’
>  569 |         ASSERT_REGISTERED_TRANSPORT(transport);
>    \
>      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>net/vmw_vsock/af_vsock.c:626:9: note: in expansion of macro
>‘vsock_registered_transport_cid’
>  626 |         vsock_registered_transport_cid(&vsk->transport);
>      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>But perhaps adding a comment wouldn't hurt either, e.g.
>
>/* Provide safe access to static transport_{h2g,g2h,dgram,local} callbacks.
> * Otherwise we may race with module removal. Do not use on
> * `vsk->transport`.
> */

Yeah, I'd just go with the comment, without introduce complex macros.
Also because in the worst case we don't do anything wrong.

BTW if we have some macros already defined in the kernel that we can 
re-use, it's fine.

>
>? ...which begs another question: do we stick to the netdev special comment
>style? See commit 82b8000c28b5 ("net: drop special comment style").

If checkpatch is fine, I'm fine :-)

>
>Oh, and come to think of it, we don't really need that (easily contended?)
>mutex here. Same can be done with RCU. Which should speed up vsock_bind()
>-> __vsock_bind() -> vsock_find_cid(), right? This is what I mean, roughly:
>
>+static u32 vsock_registered_transport_cid(const struct vsock_transport
>__rcu **trans_ptr)
>+{
>+	const struct vsock_transport *transport;
>+	u32 cid = VMADDR_CID_ANY;
>+
>+	rcu_read_lock();
>+	transport = rcu_dereference(*trans_ptr);
>+	if (transport)
>+		cid = transport->get_local_cid();
>+	rcu_read_unlock();
>+
>+	return cid;
>+}
>...
>@@ -2713,6 +2726,7 @@ void vsock_core_unregister(const struct
>vsock_transport *t)
> 		transport_local = NULL;
>
> 	mutex_unlock(&vsock_register_mutex);
>+	synchronize_rcu();
> }
>
>I've realized I'm throwing multiple unrelated ideas/questions, so let me
>summarise:
>1. Hackish macro can be used to guard against calling
>vsock_registered_transport_cid() on a non-static variable.
>2. We can comment the function to add some context and avoid confusion.

I'd go with 2.

>3. Instead of taking mutex in vsock_registered_transport_cid() we can use RCU.

Since the vsock_bind() is not in the hot path, maybe a mutex is fine.
WDYT?

Thanks,
Stefano

>
>> So, if we can't do much, I'd add a comment and make the function name
>> more clear. e.g. vsock_registered_transport_cid() ? or something
>> similar.
>
>Sure, will do.
>
>Thanks!
>
>[1]:
>https://stackoverflow.com/questions/5645695/how-can-i-add-a-static-assert-to-check-if-a-variable-is-static/5672637#5672637
>


