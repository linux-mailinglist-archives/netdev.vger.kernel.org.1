Return-Path: <netdev+bounces-237021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C49C4353D
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 23:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A5DE4E25EF
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 22:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77572749E4;
	Sat,  8 Nov 2025 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="KeZx0z5c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF334D38B
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640315; cv=none; b=jXltmYGgHRM+A3xCjNu/PsueEdbtJCIBXXPFAApHMBLSOV61PTmh2JIekWWmsFlf0zn+MMVuX0ueOJnk87DQGl/jcduZ7C1wdeXwR5YE4+63/VlhjYSnax6z7ucord8qI/lqI7rsPfvMwt6zcYa8yaSSN/ABwuTr6qRwzHILgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640315; c=relaxed/simple;
	bh=sOyWUH4PJlEt0W4EDV6GU7ywI9tQ+pHIBDmOGSIJvzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwHsx2KFDHCUkqFGxYGjmosztvsTZ9RuNfgL105+IMoeqMt2yYt5/nQVlmc3WC39Iv+bTXIGQP4v2s90PVDxWUglhzSobqSSn0mbGb2IOWksQK2ASVXk504J8MD6N6HvcVz9bubMSwVfmKGXoZe1ET+5MlJmQaSp1M5LR64TPtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=KeZx0z5c; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b0c3451272so2416965b3a.0
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 14:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762640313; x=1763245113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3zx7ylCByFKgLwnrdIb/dt/z22++1cxZrkl9z5eA2Bk=;
        b=KeZx0z5cPlvDxue1VbN1WJMlYI4gLxBuUGi7DQ7eeVZyUJ61fwoCEf8pNnObN8nBQT
         gL+UY3r/0ctrW7S25bbx7R6b5igiSEoMjPS6OBw2f5O4lPtij1wXahH/aVJNngL6Nvb5
         RdkFmAgOVpJ+LQUyABO+ri9euocCDZ2ZeUcVtFyUgScc059V60+MQ3sp86khQ8ECuvuD
         KhVhv+180a4Cacr2BA6mBC39+Z1tGBtDTvSWziJnvn0tNbJjX4J94/26FZ4poMKoEFsO
         4QSQo21ph5VykJV7DcWqXjGBLFZr6/8l+EB6kn2mKWKt0ELeSIpI6kPGo9d1gcDOXBf5
         GLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762640313; x=1763245113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zx7ylCByFKgLwnrdIb/dt/z22++1cxZrkl9z5eA2Bk=;
        b=JS5yLBBXiDs36Lm79HUPzdCWyoJws+8B2cc5+Nj8I2sBcogsuhHJ1SPOYa4MJjvmOJ
         PmGtyRNhGrUTSwqWyTeTjAI8/Xz2nkDdluFtx7g4G61fjDQr+1nAkv6qSihStauczILz
         WSTN0/hnQ3mbBWkOCuQiNiuDPtMqwR64mysmLgS4EanJV2JhnuWEj0xChfDLoEJX57qr
         jazh+0pkgBHeEHA7iRfe29N5ZsdHqKlpVSCUL/kdV5z+TIY+9p7lyD2BPqglf3CszV3I
         IvNpyPqUmdTO4VxKcxz0cDd4NZQAwaktUB2AOjWtZvqKlMB8gMV0RbxCwXfo5S7t0ZFz
         u/SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC4DCI3bsNXhrW56QK3W6r8cWN2bYz7QwDJ4tON3LMURCINPLASIcDB9uYrph0njfDyyZ3QOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYoSfNwwsdnW7FRzXLklB862SsiRaH+K11Vlca3Qs8Ifg96FMj
	IjY1lIgSdNDwQBYRPZ6lPBaLpiri1IUX7vm8j8UoLb7IHU02dZybm+Kk7RcK8iiCXuw=
X-Gm-Gg: ASbGncuMvSml7FVkF9KflOysFn+lKLLprmep/rZKJC4GyAcvbzjg0vka76Y7wsboqeK
	hyS8j5Js4L3tJScZKCzdtFkMHmNp64Cpw5xqqu7XdNiH8ru1OLFNo+hR6A20tyJ/l+58jARpKSb
	QhpEJ5Pw/EnBPPg3UL570aQ6/EwFEpCTInZY/125YbfBQ1TSJ5eY89hf+yPPL/WKuH6IWPhuX3C
	GamuzWHIEnC1+5YDYKHSeAnX0XC8cpu0TDFu+tMkgrZpDZj07KYDfmZKuKV9WWe6uxyhI8+QCDk
	hMycwhd4B44DFc81wOSwxT9tHqsOYHy+z0G31SxInxGqVyaRUXdwVJzmR6oLAiy7ukw0Ki237c/
	jMgzH5H7qWRZfvPAhaGEn3865Sy+xjzqTk98DG945aPgXlLLZJ5oHOa0J2i5RVl+cpqxMGDieda
	FJemgV/EMsDOyGkrnmrGM3X73E8rXOpAgZfICKVEA=
X-Google-Smtp-Source: AGHT+IHVqg/I2K+vXn8GBrbNkUba1q+CpIdME76U3ZTaZG5D0gzbbdMTno/0fMW9E6prqlQF4bKJoQ==
X-Received: by 2002:a05:6a21:9997:b0:334:a72c:806e with SMTP id adf61e73a8af0-353a385c312mr5583647637.43.1762640313406;
        Sat, 08 Nov 2025 14:18:33 -0800 (PST)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ce521dsm8628289a12.9.2025.11.08.14.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 14:18:32 -0800 (PST)
Message-ID: <b226b398-0985-4143-b0ea-14f785fe4d1b@davidwei.uk>
Date: Sat, 8 Nov 2025 14:18:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/14] netkit: Support for io_uring zero-copy
 and AF_XDP
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251031212103.310683-1-daniel@iogearbox.net>
 <aQqKsGDdeYQqA91s@mini-arch>
 <458d088f-dace-4869-b4af-b381d6ca5af1@davidwei.uk>
 <aQuq1mhm7cM8kkLY@mini-arch>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aQuq1mhm7cM8kkLY@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-05 11:51, Stanislav Fomichev wrote:
> On 11/04, David Wei wrote:
>> On 2025-11-04 15:22, Stanislav Fomichev wrote:
>>> On 10/31, Daniel Borkmann wrote:
>>>> Containers use virtual netdevs to route traffic from a physical netdev
>>>> in the host namespace. They do not have access to the physical netdev
>>>> in the host and thus can't use memory providers or AF_XDP that require
>>>> reconfiguring/restarting queues in the physical netdev.
>>>>
>>>> This patchset adds the concept of queue peering to virtual netdevs that
>>>> allow containers to use memory providers and AF_XDP at native speed.
>>>> These mapped queues are bound to a real queue in a physical netdev and
>>>> act as a proxy.
>>>>
>>>> Memory providers and AF_XDP operations takes an ifindex and queue id,
>>>> so containers would pass in an ifindex for a virtual netdev and a queue
>>>> id of a mapped queue, which then gets proxied to the underlying real
>>>> queue. Peered queues are created and bound to a real queue atomically
>>>> through a generic ynl netdev operation.
>>>>
>>>> We have implemented support for this concept in netkit and tested the
>>>> latter against Nvidia ConnectX-6 (mlx5) as well as Broadcom BCM957504
>>>> (bnxt_en) 100G NICs. For more details see the individual patches.
>>>>
>>>> v3->v4:
>>>>    - ndo_queue_create store dst queue via arg (Nikolay)
>>>>    - Small nits like a spelling issue + rev xmas (Nikolay)
>>>>    - admin-perm flag in bind-queue spec (Jakub)
>>>>    - Fix potential ABBA deadlock situation in bind (Jakub, Paolo, Stan)
>>>>    - Add a peer dev_tracker to not reuse the sysfs one (Jakub)
>>>>    - New patch (12/14) to handle the underlying device going away (Jakub)
>>>>    - Improve commit message on queue-get (Jakub)
>>>>    - Do not expose phys dev info from container on queue-get (Jakub)
>>>>    - Add netif_put_rx_queue_peer_locked to simplify code (Stan)
>>>>    - Rework xsk handling to simplify the code and drop a few patches
>>>>    - Rebase and retested everything with mlx5 + bnxt_en
>>>
>>> I mostly looked at patches 1-8 and they look good to me. Will it be
>>> possible to put your sample runs from 13 and 14 into a selftest form? Even
>>> if you require real hw, that should be doable, similar to
>>> tools/testing/selftests/drivers/net/hw/devmem.py, right?
>>
>> Thanks for taking a look. For io_uring at least, it requires both a
>> routable VIP that can be assigned to the netkit in a netns and a BPF
>> program for skb forwarding. I could add a selftest, but it'll be hard to
>> generalise across all envs. I'm hoping to get self contained QEMU VM
>> selftest support first. WDYT?
> 
> You can start at least with having what you have in patch 3 as a
> selftest. NIPA runs with fbnic qemu model, you should be able to at
> least test the netns setup, make sure peer-info works as expected, etc.
> You can verify that things like changing the number of channels are
> blocked when you have the queued bound to netkit..
> 
> But also, regarding the datapath test, not sure you need another qemu. Not
> even sure why you need a vip? You can carve a single port and share
> the same host ip in the netns? Alternatively I think you can carve
> out 192.168.x.y from /32 and assign it to the machine. We have datapath
> devmem tests working without any special qemu vms (besides, well,
> special fbnic qemu, but you should be able to test on it as well).

There's a check in netdev core that prevents forwarding net_iovs. The
only way to forward packets to netkit in a netns is using bpf. If
there's no routable VIP, then the bpf prog also has to do bidirectional
NAT.

