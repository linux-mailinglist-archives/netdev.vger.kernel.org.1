Return-Path: <netdev+bounces-235971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732AC3791B
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 20:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AECB3A9D99
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 19:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F72B344033;
	Wed,  5 Nov 2025 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nALGEc/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B928C871
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372313; cv=none; b=sZDo2kPIIyVbg1aeBtTbeGvJ/6oubnhWPH+609rLz93lzopCJjOr7W6k3kDOi44+nMzhAKwU7A43URfYb0KAnSkR1KB5DUXfzEq4jvFOUvzCuxgc7kiY3A+5ffKGmSkqKNhs++sLoBSVT/0tktRjY9/aHCNxrJ+tp8FxK6VLKgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372313; c=relaxed/simple;
	bh=SyjnyK2mM7BPl8arvIT1TqAsNFqJsg/GvV58Gk3CgP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBJbEBgTtLH5sdq6TH6TVRoGlIlOQEYEAXf+vCNoaN5dKLZl67uCTN3AkIDrk+ZGFtdSgenwyCVf4EjNaxACYVREVNSw3p0W/+6kgTM64wH6Vka35mMWZQHs8E1CGFN2ue2BFzNoKRr7AkWIrFyOkGwakeu5sgtHys4SxV/O0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nALGEc/+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295f937d4c3so1876405ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 11:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762372312; x=1762977112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksJDtaPRfEdf2wyhHYMWN9wPkaygRfw7CbDDkQ9lv28=;
        b=nALGEc/+SZA0IY4vWvdqu/Tm0hLNqzvjXxAiOUhFBJ/YPAoWxmZv3pHjBkLJroXlDp
         89/fu6UIEIyEdE6QDrRG8lPGSj9f3wL0sqr4NMW8MUQy6HXcFs1W1YtA5LBtBJ5WX5dm
         KO8tay4nX9vTQi+7C0CrF5MS7oowmeSkxqXWUXYS7DTqmbowyYKV6eh7693WkweDIhNC
         gndr3swjfK9qmg2JctGYrCHEEWra5zxcAkU/Akb2+AosAwF3DXc3siUICCCruHiaAiew
         ecsiEYdTLVSLKPIimVsW6eecIL8jn3/QPdu2cspWQ9SFYAl/GGsLwNRHtYr7neHK2qTX
         NGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372312; x=1762977112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksJDtaPRfEdf2wyhHYMWN9wPkaygRfw7CbDDkQ9lv28=;
        b=rZDrBfrRB3Wn20XoO4cV0EOLY0rrr0huIux8Xi4qILDHkSnnIBKvrY77i8oNlDWtj6
         ET9w7IiI7P7sHuodphFJwMPwxMKCS9/7fIvMSg9ET0zwvxm1xm6az6TP0/jmpoH0R5v+
         Dd8UKvb33IZwG4o+lwo3QDdn1KPA0l8D7j8iIo7as1uCLudNXM6YfB6lF/ZoR4k9+ytW
         /oprssRfHUIcT+V/lcYI6QLob3e0vabgzJDA6+yr5jH6PfVN3ej6c/t6x7oOqOYrFfQI
         DhuF/HZjzTW0UxBJ2olsPB77UYCfRpLU/IqZaQUj6VDnHL9RRbkeJBj3tcoMZWpuYVGp
         13eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUppiZR+IyfX4VJR12v6CvAN/d5pNxzS6FCcoFBQSXMdN4iEsx46sSPr+W9JwRGm8jvQifuwXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTngP2eyEASutonmvcI4OFdXPVgcAv9sKRgeficPFiPdSH5gPa
	70ccZe3uB/8Dpu4FLUsb2VdK3khcl4fslnl4wbt+AF9oC7CWn2lgFlI=
X-Gm-Gg: ASbGncuD7yRgScGRYXxQ8e1BSHZVmrJw5nY/5EZufZoXam/cgcwRbM3mOZGN4fCv52y
	4mQWWtd9PaFmn8CMEcNYZsxG0FZpxG7IfaI1IuBxrhUCs3DBy5aB+4c9TUCcUptqfUQOrqZ6TdI
	aoUVXQaKeT0jEyjnTIqcn/TILZYr0nJXX7ql1tw9ieueoFDkS3avfHHEkLobo4/xAshSCn5V8Ru
	h5bUbsukyVsxhW7Guvuvhukow6PuAofBM6iNBB5P6LyydIuvvPeRLrusdaM6wVDiCq/5jp/totk
	VS0PFhVZgwCm0YhoL7Vr07NJNlQDNJJJzKRcf2RKxYkOcxC8/HNbEdHICEWh6A/TreKdeGSF4+C
	CWecJRkWUVfA2QXVk1PP8qw0DYpUotLHB1FVR9qVViOJHMo4R5i0vqkAVq+joyO7Mo0DB+rsmd1
	ixFhT8CXrGDynDLzgh27fKvzSsErH5UWV+9h3WXbA4pqvTjUakrIuDZPdJbDGd1+1xyRid2wxLZ
	n8ttTM4BIUKFa2Voqeq8+lOsj9v/UHuQCFwegLXI6GreZqhnequsvM9
X-Google-Smtp-Source: AGHT+IHvedoObPI3pxxfxclSW2jn0qBK9jIAa7IzRD3SI3wu5p6eqVzGifMv2Q3vbiXXa0p/BG3eIA==
X-Received: by 2002:a17:902:d4c7:b0:292:fe19:8896 with SMTP id d9443c01a7336-2962add623emr61147975ad.52.1762372311486;
        Wed, 05 Nov 2025 11:51:51 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5d790sm3591555ad.26.2025.11.05.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:51:51 -0800 (PST)
Date: Wed, 5 Nov 2025 11:51:50 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: David Wei <dw@davidwei.uk>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
	sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
	jordan@jrife.io, maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com, toke@redhat.com,
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v4 00/14] netkit: Support for io_uring zero-copy
 and AF_XDP
Message-ID: <aQuq1mhm7cM8kkLY@mini-arch>
References: <20251031212103.310683-1-daniel@iogearbox.net>
 <aQqKsGDdeYQqA91s@mini-arch>
 <458d088f-dace-4869-b4af-b381d6ca5af1@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <458d088f-dace-4869-b4af-b381d6ca5af1@davidwei.uk>

On 11/04, David Wei wrote:
> On 2025-11-04 15:22, Stanislav Fomichev wrote:
> > On 10/31, Daniel Borkmann wrote:
> > > Containers use virtual netdevs to route traffic from a physical netdev
> > > in the host namespace. They do not have access to the physical netdev
> > > in the host and thus can't use memory providers or AF_XDP that require
> > > reconfiguring/restarting queues in the physical netdev.
> > > 
> > > This patchset adds the concept of queue peering to virtual netdevs that
> > > allow containers to use memory providers and AF_XDP at native speed.
> > > These mapped queues are bound to a real queue in a physical netdev and
> > > act as a proxy.
> > > 
> > > Memory providers and AF_XDP operations takes an ifindex and queue id,
> > > so containers would pass in an ifindex for a virtual netdev and a queue
> > > id of a mapped queue, which then gets proxied to the underlying real
> > > queue. Peered queues are created and bound to a real queue atomically
> > > through a generic ynl netdev operation.
> > > 
> > > We have implemented support for this concept in netkit and tested the
> > > latter against Nvidia ConnectX-6 (mlx5) as well as Broadcom BCM957504
> > > (bnxt_en) 100G NICs. For more details see the individual patches.
> > > 
> > > v3->v4:
> > >   - ndo_queue_create store dst queue via arg (Nikolay)
> > >   - Small nits like a spelling issue + rev xmas (Nikolay)
> > >   - admin-perm flag in bind-queue spec (Jakub)
> > >   - Fix potential ABBA deadlock situation in bind (Jakub, Paolo, Stan)
> > >   - Add a peer dev_tracker to not reuse the sysfs one (Jakub)
> > >   - New patch (12/14) to handle the underlying device going away (Jakub)
> > >   - Improve commit message on queue-get (Jakub)
> > >   - Do not expose phys dev info from container on queue-get (Jakub)
> > >   - Add netif_put_rx_queue_peer_locked to simplify code (Stan)
> > >   - Rework xsk handling to simplify the code and drop a few patches
> > >   - Rebase and retested everything with mlx5 + bnxt_en
> > 
> > I mostly looked at patches 1-8 and they look good to me. Will it be
> > possible to put your sample runs from 13 and 14 into a selftest form? Even
> > if you require real hw, that should be doable, similar to
> > tools/testing/selftests/drivers/net/hw/devmem.py, right?
> 
> Thanks for taking a look. For io_uring at least, it requires both a
> routable VIP that can be assigned to the netkit in a netns and a BPF
> program for skb forwarding. I could add a selftest, but it'll be hard to
> generalise across all envs. I'm hoping to get self contained QEMU VM
> selftest support first. WDYT?

You can start at least with having what you have in patch 3 as a
selftest. NIPA runs with fbnic qemu model, you should be able to at
least test the netns setup, make sure peer-info works as expected, etc.
You can verify that things like changing the number of channels are
blocked when you have the queued bound to netkit..

But also, regarding the datapath test, not sure you need another qemu. Not
even sure why you need a vip? You can carve a single port and share
the same host ip in the netns? Alternatively I think you can carve
out 192.168.x.y from /32 and assign it to the machine. We have datapath
devmem tests working without any special qemu vms (besides, well,
special fbnic qemu, but you should be able to test on it as well).

