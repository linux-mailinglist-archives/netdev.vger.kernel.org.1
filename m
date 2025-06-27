Return-Path: <netdev+bounces-201786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAB8AEB0E1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E509A5624B4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECC5233145;
	Fri, 27 Jun 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjR4XV6I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A31722D4C5
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011394; cv=none; b=OZM+sqlBUKEv3uo3G6OGsHe03mUk6Uo2EjXJZ1q+8bd2/Ag1qOI2BYCy3kxSW7WFkvGsmAH7wEl2I28Oo9UmIngVqi4MFNGarBB7UCR/OiMlfhZ55IIoTFFN8cVOhiJCb29dhIvCC5DL5iDbJT9NW8BUWzVMkgHWOnM5ea0brvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011394; c=relaxed/simple;
	bh=TlipyTpq+zkxi6ZA8xLnUlroRbf/E4O5IFbXL9YlqHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/V3wzEDfJsejHCwIoM5qXzkpdy3MTPa+xWyUhbpgdBRAkRzwyvRWP646P9aTz74b+7iBvLtO9MG6Uj6VOnECCEtguTpGQUAXJSYewDhlAIoEK1O15/cpK6n1dYYZGKw8A2nAjGeQ6DGfiqlYaqgrcy13ck30fhNyUF5+0fH4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjR4XV6I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751011391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fBGuOpjeJcrv22tZz5j3GQyTZme+pLri3Tcax7Iti6c=;
	b=CjR4XV6I8ac1MWkliFwP4LVbJw/QykKCwq3hqJJpvqL6zbK6tyZXk/il4erqqvUz3abG64
	X0eDTUrdfG5Y84gH4U/AVJjiE5bi9bKJf9DYDC/BfhIPAVegSXnG202is1Ed+IBwVS1iqr
	ar1YdLRJ4PCzGPILaXNLSNh0GPTM5dM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-1nHyBRJKNjqllcRB_jv63w-1; Fri, 27 Jun 2025 04:03:09 -0400
X-MC-Unique: 1nHyBRJKNjqllcRB_jv63w-1
X-Mimecast-MFC-AGG-ID: 1nHyBRJKNjqllcRB_jv63w_1751011388
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7394772635dso1432061b3a.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 01:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751011388; x=1751616188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBGuOpjeJcrv22tZz5j3GQyTZme+pLri3Tcax7Iti6c=;
        b=J2i8cKJQSImPVaGxSqodHtdR8wJJLhDU9tOtmOgqrnKkF7gKv24exKUUiS28emP1z4
         rb18k7lLRm1dVrr0wfT2nG0Ew+Ptf/VbKf3SiGSN3wwiIXt9LB0cMWfhCNfSOW/rxEeb
         H+hJdbhUwwY/7csW7R0oJRIGcSRQWmFqQccsl2gi0nuKEdXkJ6y3DHKrSqa3tEQBtSY3
         wQiiaT1+VeM8q74q6QEjPRZJ0dLikxfF7wpBlR9S5joR5AO7wRRYlGy4mGCQbm8G27Eb
         7C/BXO02OY+qk/O0byf9/ZJBmk4nuaArNQEBUeta+3KCLOXKHagoTgl0Uu8Qw+hFA+4m
         JakQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuEnfe/J8FX3lMsFum7P9t1J086JjT30rWgNejfcDydnBsSlkr2BUoot1bjjT/Szka8kDlDG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFNvx9q0O1gAPH0hq28NOTNjc9+/bz5iSmB55HbUpt8CT+9Ds8
	SxiGsQGERKTIcgs/gWN020PQ7beNztGMc1XX3YFY1tAqtHXVxma8eLXg6uh5ojKIhHCDRI62GXS
	HMDfQO8YwbWriYA/IOFNXTMgnC7E/Zq6ZL1PqbRh1pvQo7/ieiyerWGWTIg==
X-Gm-Gg: ASbGncvasLzAA8ZJWvPyLtLPtBxNc3IWbbamp1RkzpoHXVyAUv0a/8N2Rq6up1B3Edg
	iai8XCL3v6k+Fgpvj8Hw6XOtJ10UalPW4u8oaGROpC6y3KDr/zasd7zu2x9sBLTK1GEsr6zYjD+
	NwhsOjeMJjtDvDQ3RrtZxnIJ/bgWsaTDT8+VLpkBNegUYnXXZo4CbMKH36r59CoJUd6w99XT4sL
	gO/ZVPDmyN7ujdan67GjwzW0RzQCiYsnHi5KHH5HqUGeXuxJOf/P6aYwhu7VesC3yB7iEL6rjLw
	VFHrl+20/M9TaJoKqZweiLojKqc=
X-Received: by 2002:a05:6a21:6d8e:b0:1f5:7eb5:72dc with SMTP id adf61e73a8af0-220a12a6756mr3045468637.3.1751011387754;
        Fri, 27 Jun 2025 01:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENKutaEVvhU5X/3wOtUe3CypyD8G+Z3R9VqfGa0fMc8Jzyjr0jAT/okl2FRUtRTn0F5dIhXA==
X-Received: by 2002:a05:6a21:6d8e:b0:1f5:7eb5:72dc with SMTP id adf61e73a8af0-220a12a6756mr3045415637.3.1751011387141;
        Fri, 27 Jun 2025 01:03:07 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.150.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541e548sm1766830b3a.66.2025.06.27.01.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 01:03:06 -0700 (PDT)
Date: Fri, 27 Jun 2025 10:02:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 1/3] vsock: Fix transport_{g2h,h2g} TOCTOU
Message-ID: <owafhdinyjdnol4zwpcdqsz26nfndawl53wnosdhhgmfz6t25n@2dualdqgpq3q>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-1-02ebd20b1d03@rbox.co>
 <zdiqu6pszqwb4y5o7oqzdovfvzkbrvc6ijuxoef2iloklahyoy@njsnvn7hfwye>
 <d8d4edb2-bf14-42b2-8592-79d7b014e1a7@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d8d4edb2-bf14-42b2-8592-79d7b014e1a7@rbox.co>

On Wed, Jun 25, 2025 at 11:23:30PM +0200, Michal Luczaj wrote:
>On 6/25/25 10:43, Stefano Garzarella wrote:
>> On Fri, Jun 20, 2025 at 09:52:43PM +0200, Michal Luczaj wrote:
>>> vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
>>> transport_{g2h,h2g} may become NULL after the NULL check.
>>>
>>> Introduce vsock_transport_local_cid() to protect from a potential
>>> null-ptr-deref.
>>>
>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>> RIP: 0010:vsock_find_cid+0x47/0x90
>>> Call Trace:
>>> __vsock_bind+0x4b2/0x720
>>> vsock_bind+0x90/0xe0
>>> __sys_bind+0x14d/0x1e0
>>> __x64_sys_bind+0x6e/0xc0
>>> do_syscall_64+0x92/0x1c0
>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>
>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>> RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>>> Call Trace:
>>> __x64_sys_ioctl+0x12d/0x190
>>> do_syscall_64+0x92/0x1c0
>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>
>>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 23 +++++++++++++++++------
>>> 1 file changed, 17 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 2e7a3034e965db30b6ee295370d866e6d8b1c341..63a920af5bfe6960306a3e5eeae0cbf30648985e 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -531,9 +531,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>> }
>>> EXPORT_SYMBOL_GPL(vsock_assign_transport);
>>>
>>> +static u32 vsock_transport_local_cid(const struct vsock_transport **transport)
>>
>> Why we need double pointer?
>
>Because of a possible race. If @transport is `struct vsock_transport*` and
>we pass `transport_g2h`, the passed non-NULL pointer value may immediately
>become stale (due to module unload). But if it's `vsock_transport**` and we
>pass `&transport_g2h`, then we can take the mutex, check `*transport` for
>NULL and safely go ahead.
>
>Or are you saying this could be simplified?

Nope, you're right! I was still thinking about my old version where we 
had the switch inside...

BTW I'd like to change the name, `vsock_transport_local` prefix is 
confusing IMO, since it seems related only to the `transport_local`.

Another thing I'm worried about is that we'll then start using it on 
`vsk->transport` when this is only to be used on registered transports 
(i.e. `static ...`), though, I don't think there's a way to force type 
checking from the compiler (unless you wrap it in a struct). It's not a 
big issue, but taking the mutex is useless in that cases.

So, if we can't do much, I'd add a comment and make the function name 
more clear. e.g. vsock_registered_transport_cid() ? or something 
similar.

>
>>> +{
>>> +	u32 cid = VMADDR_CID_ANY;
>>> +
>>> +	mutex_lock(&vsock_register_mutex);
>>> +	if (*transport)
>>> +		cid = (*transport)->get_local_cid();
>>> +	mutex_unlock(&vsock_register_mutex);
>>> +
>>> +	return cid;
>>> +}
>>> +
>>> bool vsock_find_cid(unsigned int cid)
>>> {
>>> -	if (transport_g2h && cid == transport_g2h->get_local_cid())
>>> +	if (cid == vsock_transport_local_cid(&transport_g2h))
>>> 		return true;
>>>
>>> 	if (transport_h2g && cid == VMADDR_CID_HOST)
>>> @@ -2536,18 +2548,17 @@ static long vsock_dev_do_ioctl(struct file *filp,
>>> 			       unsigned int cmd, void __user *ptr)
>>> {
>>> 	u32 __user *p = ptr;
>>> -	u32 cid = VMADDR_CID_ANY;
>>> 	int retval = 0;
>>> +	u32 cid;
>>>
>>> 	switch (cmd) {
>>> 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
>>> 		/* To be compatible with the VMCI behavior, we prioritize the
>>> 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
>>> 		 */
>>> -		if (transport_g2h)
>>> -			cid = transport_g2h->get_local_cid();
>>> -		else if (transport_h2g)
>>> -			cid = transport_h2g->get_local_cid();
>>> +		cid = vsock_transport_local_cid(&transport_g2h);
>>> +		if (cid == VMADDR_CID_ANY)
>>> +			cid = vsock_transport_local_cid(&transport_h2g);
>>
>> I still prefer the old `if ... else if ...`, what is the reason of this
>> change? I may miss the point.
>
>Ah, ok, I've just thought such cascade would be cleaner.
>
>So is this what you prefer?

I usually prefer less changes as possibile, but in this case I see your 
point, so up to you ;-)

In your way we save `cid` initialization and an if, so it's fine.

Thanks,
Stefano

>
>if (transport_g2h)
>	cid = vsock_transport_local_cid(&transport_g2h);
>else if (transport_h2g)
>	cid = vsock_transport_local_cid(&transport_h2g);
>
>Thanks,
>Michal
>


