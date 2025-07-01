Return-Path: <netdev+bounces-202842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD19AEF52E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D0E17F8C4
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F39246BC5;
	Tue,  1 Jul 2025 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bywyXmmP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2D26D4D4
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366081; cv=none; b=Kdc/zwpVnL1qKEpr1oCwIA0C41Hhxu8RqDBVwHs260+52utaTUeLMHUemKpln5zKxhOW62eEHyI/TtmkXG4sDlPL1WmGaQiFTBD8L6aBOTt5WLvl1bQUd0CaC+4aRMvafsi8ingJZ2jB/e8Q9jx3CfUYt90LbhP1O6OjLWDHXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366081; c=relaxed/simple;
	bh=Mb60PZKCxPrLuQXD+nGMXcS0bI1nvcxKixTXpIJ6UOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sV4iwG28m4ZOUycXnQaTKZNYobAftP/0CdTMosX4NVLIk1UfPNHUZjVbw3p6aCLBcdheqs5msilPag+FUHWDexZxC6p5jaS4IpiXZXvlH82VDnXymjBUxJsM/nUZJCJQ20ChvSBmEXQCUX0KIDODI0wlstkfQt/6oFZCRpRkwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bywyXmmP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751366078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UpDQ5tS+XCWfCgRZS/6IKZjsLJANA+xHzrICS0TndYM=;
	b=bywyXmmPGd8Jf/bYt0iPnYnVXau8opLr4ddAWQCCeh/SMpHESF2PiQmb7Mz25J6i5g8qX1
	4ehbvZTflV3O1Ht3wjPaZRjyAwlivqfh+gJCZCcy1Kl5KkNt0Frj5YZNvwP5QY/lf1QSfj
	mLtU70HsrjJCsb2MmADunIhMFol//nQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-S_HIhRZ8N7S4sYjQfUPJEA-1; Tue, 01 Jul 2025 06:34:36 -0400
X-MC-Unique: S_HIhRZ8N7S4sYjQfUPJEA-1
X-Mimecast-MFC-AGG-ID: S_HIhRZ8N7S4sYjQfUPJEA_1751366076
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-61198604baeso4074349eaf.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 03:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751366076; x=1751970876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpDQ5tS+XCWfCgRZS/6IKZjsLJANA+xHzrICS0TndYM=;
        b=Q0jClfOy4mCaoCryMDJB3mwwuQ4WZvFMJhJAouDJ76nnJ3DGWFrokLBO1yXkja4Ynd
         4RvjPbwo3bYVEkOInyT+qszmn9/TMi0RE/irOpPody639SBXlLw/fOc+xMlsivn/vsg3
         c5xGIc1k/whB21Ce+xPKz19Vbr3Cblxl3MUZC4cZJbL+uz8QJSSUX+YyAAKQqOW13XrG
         9yKhgdPWpdIFyTySCNYfOddYcTSYF7kiBF3RGmtM/9RIul55wbWaul4vSRu9Lj7ZGBhX
         PygFlcZaf6/LNM3ZrnWFzWV+MKU++DdmmOaGInBLe3Dz4m1iH4c+LBZvQRufyeVzO5zj
         sBRw==
X-Forwarded-Encrypted: i=1; AJvYcCXQW5s9afdDXOby0XbdtcjmZRnstRkuR0TiCFwPTbclfoR5pj+Vg+qewUyf0TULuEwbAfDuq2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIlI4kIQIVOmwSr734tvGBbevbTAqD9/O9T9qBUi8in6t/UMzw
	t7Bl7zDND8LoYnOgczoX6KIv4RSDLFZKiDNTFrmZP6YOz/SQNo+m9fBXsmDk+Ec7TTrpAw/7OXk
	V9BmkJKXaIaAGx5r6D0mfg9K7k6lOKqhAEkZbEuD2Cd+lB1tqavm7Snw/dA==
X-Gm-Gg: ASbGncuCGpZLjNzsLezz93+ycm13JaeIX4qh482dKOVE2tbyfjwfLWPBa/0u3y46cHC
	9wqNUxBf4ZaT4jJSH76z3yXHDnAvs+Cu4/c+lUms/Ns/r1dscImUiIa98paxxroNsGaMZZn+R2s
	gYSaVfAcBvQE9/KTgE74/YYGM6amxFWfoCCQzcxslMpkpfvhH/UP1p4NE9lVSlTB1e70f8i3L2y
	/6uIJr20Csg3Djy32sC8UdTN+3y1yqvz+LLbLDu0O20oZiI/38QJvUJAvB8JZPHg0z+PYIRrwYg
	zuWaOzxl+02+zRs6x6za7pE1uHIY
X-Received: by 2002:a05:6820:994:b0:611:aabf:2b7d with SMTP id 006d021491bc7-611b91b8ba5mr12929316eaf.7.1751366075927;
        Tue, 01 Jul 2025 03:34:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvOyh3XEeOqocDMGLPkqu+zdtIY+/LP4pPv1rkoavjsw1qeTINbjxyfJNBqMBK5Rn7C+6dEQ==
X-Received: by 2002:a05:6820:994:b0:611:aabf:2b7d with SMTP id 006d021491bc7-611b91b8ba5mr12929286eaf.7.1751366075453;
        Tue, 01 Jul 2025 03:34:35 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b8474da2sm1366811eaf.6.2025.07.01.03.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 03:34:35 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:34:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 1/3] vsock: Fix transport_{g2h,h2g} TOCTOU
Message-ID: <fruzxj3ju4nmm3uipuqq3gcn3jh5et4qpnldzsdahfdcachtyl@o3k7lo2gxzyb>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-1-02ebd20b1d03@rbox.co>
 <zdiqu6pszqwb4y5o7oqzdovfvzkbrvc6ijuxoef2iloklahyoy@njsnvn7hfwye>
 <d8d4edb2-bf14-42b2-8592-79d7b014e1a7@rbox.co>
 <owafhdinyjdnol4zwpcdqsz26nfndawl53wnosdhhgmfz6t25n@2dualdqgpq3q>
 <e97b5cae-f6ef-4221-98e1-6efd7fdc6676@rbox.co>
 <4vsrtxs3uttx6w2zyk6rxescpwvrikypiw6tvjheplht6yzonc@ch6k3xlftikw>
 <c39f22fd-9ede-4cdd-956b-29856e9db20a@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c39f22fd-9ede-4cdd-956b-29856e9db20a@rbox.co>

On Mon, Jun 30, 2025 at 01:02:26PM +0200, Michal Luczaj wrote:
>On 6/30/25 11:05, Stefano Garzarella wrote:
>> On Sun, Jun 29, 2025 at 11:26:12PM +0200, Michal Luczaj wrote:
>>> On 6/27/25 10:02, Stefano Garzarella wrote:
>>>> On Wed, Jun 25, 2025 at 11:23:30PM +0200, Michal Luczaj wrote:
>>>>> On 6/25/25 10:43, Stefano Garzarella wrote:
>>>>>> On Fri, Jun 20, 2025 at 09:52:43PM +0200, Michal Luczaj wrote:
>>>>>>> vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
>>>>>>> transport_{g2h,h2g} may become NULL after the NULL check.
>>>>>>>
>>>>>>> Introduce vsock_transport_local_cid() to protect from a potential
>>>>>>> null-ptr-deref.
>>>>>>>
>>>>>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>>>>>> RIP: 0010:vsock_find_cid+0x47/0x90
>>>>>>> Call Trace:
>>>>>>> __vsock_bind+0x4b2/0x720
>>>>>>> vsock_bind+0x90/0xe0
>>>>>>> __sys_bind+0x14d/0x1e0
>>>>>>> __x64_sys_bind+0x6e/0xc0
>>>>>>> do_syscall_64+0x92/0x1c0
>>>>>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>>>>
>>>>>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>>>>>> RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>>>>>>> Call Trace:
>>>>>>> __x64_sys_ioctl+0x12d/0x190
>>>>>>> do_syscall_64+0x92/0x1c0
>>>>>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>>>>
>>>>>>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>>>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>...
>>> Oh, and come to think of it, we don't really need that (easily contended?)
>>> mutex here. Same can be done with RCU. Which should speed up vsock_bind()
>>> -> __vsock_bind() -> vsock_find_cid(), right? This is what I mean, roughly:
>>>
>>> +static u32 vsock_registered_transport_cid(const struct vsock_transport
>>> __rcu **trans_ptr)
>>> +{
>>> +	const struct vsock_transport *transport;
>>> +	u32 cid = VMADDR_CID_ANY;
>>> +
>>> +	rcu_read_lock();
>>> +	transport = rcu_dereference(*trans_ptr);
>>> +	if (transport)
>>> +		cid = transport->get_local_cid();
>>> +	rcu_read_unlock();
>>> +
>>> +	return cid;
>>> +}
>>> ...
>>> @@ -2713,6 +2726,7 @@ void vsock_core_unregister(const struct
>>> vsock_transport *t)
>>> 		transport_local = NULL;
>>>
>>> 	mutex_unlock(&vsock_register_mutex);
>>> +	synchronize_rcu();
>>> }
>>>
>>> I've realized I'm throwing multiple unrelated ideas/questions, so let me
>>> summarise:
>>> 1. Hackish macro can be used to guard against calling
>>> vsock_registered_transport_cid() on a non-static variable.
>>> 2. We can comment the function to add some context and avoid confusion.
>>
>> I'd go with 2.
>
>All right, will do.
>
>>> 3. Instead of taking mutex in vsock_registered_transport_cid() we can use RCU.
>>
>> Since the vsock_bind() is not in the hot path, maybe a mutex is fine.
>> WDYT?
>
>I wrote a benchmark that attempts (and fails due to a non-existing CID) to
>bind() 100s of vsocks in multiple threads. `perf lock con` shows that this
>mutex is contended, and things are slowed down by 100+% compared with RCU
>approach. Which makes sense: every explicit vsock bind() across the whole
>system would need to acquire the mutex. And now we're also taking the same
>mutex in vsock_assign_transport(), i.e. during connect(). But maybe such
>stress testing is just unrealistic, I really don't know.
>

I still don't think it's a hot path to optimize, but I'm not totally 
against it. If you want to do it though, I would say do it in a separate 
patch.

Thanks,
Stefano


