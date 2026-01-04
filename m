Return-Path: <netdev+bounces-246718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDD9CF0A5B
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 07:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAAA43008EBB
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 06:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B7B280037;
	Sun,  4 Jan 2026 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUbTE/dp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/lAcmiN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6922097
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767507007; cv=none; b=ePHn/StensXfQLn2cYC1nJSsjngkkEPLrjsz/Ihrw7HGUkM1HVLP28fxKNEsZTPM5ewlAgy9wgS89GV/fOr9La+q/+srzZ6UgZ3KAPuxrKKq/2ILikbXJsC+P2IjLeZlq0mLY0K63KilGNniJWVw9qINo4fq8iyX3cWjhmexirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767507007; c=relaxed/simple;
	bh=CgWb+bYt9Ztv1n+WAJLut3SYzPdUQOxyY6BOp6CaO0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQmfJcm0gO1ZTEtmmSck1Shz4blV2qeI3aJ7gGXMsnL7LToVVFyNeHlyLT8QzL/5gk9gMRw/lUUlEVSCuMykxWVBO4PAKT1BsbJFqXQ8pH16KgjssZeWqgpRtOiqhU8X0GY2IdWAyxI/En2jkRo/RFa8RXFKIhBYXRsGf3oz1Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUbTE/dp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/lAcmiN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767507004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDUhJa7ns/wkThtFrvNhjQ5Dkrpl1vZh0STVmQokDz0=;
	b=YUbTE/dpvtwvTWMfLR5O65dm0pspAs5nehPSPHfghtXP7oj0nXgaEY5dbuZZarA89FnExn
	+oRJklbm9wZHGVXehamjlzkKz1V5CNgedgrFWQSge58dGWoygYKfNI8OIdNDZSSjwGb5XD
	fr2wLpjF+35wBgmEYJUhL66shmt6YGc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-1sLr9W69PZekY-LX5-JXtw-1; Sun, 04 Jan 2026 01:10:03 -0500
X-MC-Unique: 1sLr9W69PZekY-LX5-JXtw-1
X-Mimecast-MFC-AGG-ID: 1sLr9W69PZekY-LX5-JXtw_1767507002
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c5d6193daso27046346a91.1
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 22:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767507002; x=1768111802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDUhJa7ns/wkThtFrvNhjQ5Dkrpl1vZh0STVmQokDz0=;
        b=A/lAcmiNXAy02zkyZmxsOojErT69YZr4cacbokhhNVjid2Sysgcz7oL3OACxWL4glj
         ahNcnlcuFF0ja3AfVVt29n25dYW6ANhbeO3o6Qk35bfGRFrgwIrFJyplt+ex7s6buSun
         89PR4TfBrH/0WIEb2TIrnMFBzEJq/boOst+Tb3mxWc+V838elZzX+T/B0Z0kpj8A4gGX
         R4qmm9Jc/0fSohbIStR31vwCUDpZ0ILKgY9LdP09DWEm4cSHZBHKUPslTCfmG8wgGJgG
         bj31pAbpdG8SC89K1wKZBdGnekjHS3MO5tQFb51EJZqZKSUXAs8/fE9HTN2bxdrBYqlX
         Fq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767507002; x=1768111802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UDUhJa7ns/wkThtFrvNhjQ5Dkrpl1vZh0STVmQokDz0=;
        b=IM3tHbhEApcW5XzRaXNfayVDfnh3MS6t3pLKQGnZUm7WRz5U0CF+eqYhHd/UaeHj8O
         ZZjrm+MYmj44vxuxEuiGF9QnuyzKeF8wZeQygf7rRmQjRKOElhOqbX5oko2wyK2GFgPM
         bocpuLmAJgMXhahKa3bY9tNC1CVfgezonXGrsn/w+TewtTC8OG2E7sloq7v63RZT1phS
         tkHoXnusGl1a/sg34cTW+zv40l/kinHtpmFUyb6kjcZgMNM+v9dqw0vpuxWlT3WNnMMm
         M0+DdMc7Sk5kNS3UDRGrf/LuvDfNd/9d3u+zKHhGZFhAzvzQzo1I/t3YIAsUIhEn+k2A
         1Z3g==
X-Gm-Message-State: AOJu0YwZOO8Z9i6eStoFH1/w+lUdPfcpvYUCfiKWVl5sHzMA97aeZQae
	TWqsQ4KxQEVEtp9zQI+KD9RFIx3bN9AwTZumjHv05W5B70w0QL9wxQ9WhLTSgyrrEgZft/qaqbF
	ehpoChxK1yznkPBwaNqwadQ2Ie+HOYYvP6iLv55Ev+sZXIDJrUBcFTd45++jFYG7o3QxnI8KMD4
	ajKDrfacOS29YV7Rlaq+EHAaKIPqyBnjLg
X-Gm-Gg: AY/fxX5lOpv/jWExhYsAS77jvojbbpji8RPCBKWvdbiEBSdFTAHKzkZFBaNatWdbUCM
	beTqq0G1mHLQS2wRs3tkp+2oWEod+iG2S+0LZQecyvCl9OH2T/ZLR47Xhy3CDBboWAJtTCXZrxk
	rtLTbSnWxF6ZKXGw3Qc82+vU51aw6lKIE49XIPduuS4zWUq7mcCgGpUjZ8UNkJpG4=
X-Received: by 2002:a17:90b:1346:b0:34a:8c77:d386 with SMTP id 98e67ed59e1d1-34e92139a88mr37176573a91.9.1767507002437;
        Sat, 03 Jan 2026 22:10:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/jIXIp00+3wsBa88rGNq0RCxEkgNfLl5HGczyOGGwUeed+9vlY8qvbYpSjgM2CvilksFvzf0C9su5g49lkl0=
X-Received: by 2002:a17:90b:1346:b0:34a:8c77:d386 with SMTP id
 98e67ed59e1d1-34e92139a88mr37176554a91.9.1767507002029; Sat, 03 Jan 2026
 22:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102101900.692770-1-kshankar@marvell.com>
In-Reply-To: <20260102101900.692770-1-kshankar@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 4 Jan 2026 14:09:50 +0800
X-Gm-Features: AQt7F2opfvGY7kJMOmBx5WfNPjyDArtG_Tzb98wkUc-HQ-rEn7urtxnzwOkQZYQ
Message-ID: <CACGkMEsSbnrRPFicWxMOJyKqpuY1To52qbf-CFSxC+__XjQ1xA@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: fix device mismatch in devm_kzalloc/devm_kfree
To: Kommula Shiva Shankar <kshankar@marvell.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	jerinj@marvell.com, ndabilpuram@marvell.com, schalla@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 6:19=E2=80=AFPM Kommula Shiva Shankar
<kshankar@marvell.com> wrote:
>
> Initial rss_hdr allocation uses virtio_device->device,
> but virtnet_set_queues() frees using net_device->device.
> This device mismatch causing below devres warning
>
> [ 3788.514041] ------------[ cut here ]------------
> [ 3788.514044] WARNING: drivers/base/devres.c:1095 at devm_kfree+0x84/0x9=
8, CPU#16: vdpa/1463
> [ 3788.514054] Modules linked in: octep_vdpa virtio_net virtio_vdpa [last=
 unloaded: virtio_vdpa]
> [ 3788.514064] CPU: 16 UID: 0 PID: 1463 Comm: vdpa Tainted: G        W   =
        6.18.0 #10 PREEMPT
> [ 3788.514067] Tainted: [W]=3DWARN
> [ 3788.514069] Hardware name: Marvell CN106XX board (DT)
> [ 3788.514071] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYP=
E=3D--)
> [ 3788.514074] pc : devm_kfree+0x84/0x98
> [ 3788.514076] lr : devm_kfree+0x54/0x98
> [ 3788.514079] sp : ffff800084e2f220
> [ 3788.514080] x29: ffff800084e2f220 x28: ffff0003b2366000 x27: 000000000=
000003f
> [ 3788.514085] x26: 000000000000003f x25: ffff000106f17c10 x24: 000000000=
0000080
> [ 3788.514089] x23: ffff00045bb8ab08 x22: ffff00045bb8a000 x21: 000000000=
0000018
> [ 3788.514093] x20: ffff0004355c3080 x19: ffff00045bb8aa00 x18: 000000000=
0080000
> [ 3788.514098] x17: 0000000000000040 x16: 000000000000001f x15: 000000000=
007ffff
> [ 3788.514102] x14: 0000000000000488 x13: 0000000000000005 x12: 000000000=
00fffff
> [ 3788.514106] x11: ffffffffffffffff x10: 0000000000000005 x9 : ffff80008=
0c8c05c
> [ 3788.514110] x8 : ffff800084e2eeb8 x7 : 0000000000000000 x6 : 000000000=
000003f
> [ 3788.514115] x5 : ffff8000831bafe0 x4 : ffff800080c8b010 x3 : ffff00043=
55c3080
> [ 3788.514119] x2 : ffff0004355c3080 x1 : 0000000000000000 x0 : 000000000=
0000000
> [ 3788.514123] Call trace:
> [ 3788.514125]  devm_kfree+0x84/0x98 (P)
> [ 3788.514129]  virtnet_set_queues+0x134/0x2e8 [virtio_net]
> [ 3788.514135]  virtnet_probe+0x9c0/0xe00 [virtio_net]
> [ 3788.514139]  virtio_dev_probe+0x1e0/0x338
> [ 3788.514144]  really_probe+0xc8/0x3a0
> [ 3788.514149]  __driver_probe_device+0x84/0x170
> [ 3788.514152]  driver_probe_device+0x44/0x120
> [ 3788.514155]  __device_attach_driver+0xc4/0x168
> [ 3788.514158]  bus_for_each_drv+0x8c/0xf0
> [ 3788.514161]  __device_attach+0xa4/0x1c0
> [ 3788.514164]  device_initial_probe+0x1c/0x30
> [ 3788.514168]  bus_probe_device+0xb4/0xc0
> [ 3788.514170]  device_add+0x614/0x828
> [ 3788.514173]  register_virtio_device+0x214/0x258
> [ 3788.514175]  virtio_vdpa_probe+0xa0/0x110 [virtio_vdpa]
> [ 3788.514179]  vdpa_dev_probe+0xa8/0xd8
> [ 3788.514183]  really_probe+0xc8/0x3a0
> [ 3788.514186]  __driver_probe_device+0x84/0x170
> [ 3788.514189]  driver_probe_device+0x44/0x120
> [ 3788.514192]  __device_attach_driver+0xc4/0x168
> [ 3788.514195]  bus_for_each_drv+0x8c/0xf0
> [ 3788.514197]  __device_attach+0xa4/0x1c0
> [ 3788.514200]  device_initial_probe+0x1c/0x30
> [ 3788.514203]  bus_probe_device+0xb4/0xc0
> [ 3788.514206]  device_add+0x614/0x828
> [ 3788.514209]  _vdpa_register_device+0x58/0x88
> [ 3788.514211]  octep_vdpa_dev_add+0x104/0x228 [octep_vdpa]
> [ 3788.514215]  vdpa_nl_cmd_dev_add_set_doit+0x2d0/0x3c0
> [ 3788.514218]  genl_family_rcv_msg_doit+0xe4/0x158
> [ 3788.514222]  genl_rcv_msg+0x218/0x298
> [ 3788.514225]  netlink_rcv_skb+0x64/0x138
> [ 3788.514229]  genl_rcv+0x40/0x60
> [ 3788.514233]  netlink_unicast+0x32c/0x3b0
> [ 3788.514237]  netlink_sendmsg+0x170/0x3b8
> [ 3788.514241]  __sys_sendto+0x12c/0x1c0
> [ 3788.514246]  __arm64_sys_sendto+0x30/0x48
> [ 3788.514249]  invoke_syscall.constprop.0+0x58/0xf8
> [ 3788.514255]  do_el0_svc+0x48/0xd0
> [ 3788.514259]  el0_svc+0x48/0x210
> [ 3788.514264]  el0t_64_sync_handler+0xa0/0xe8
> [ 3788.514268]  el0t_64_sync+0x198/0x1a0
> [ 3788.514271] ---[ end trace 0000000000000000 ]---
>
> Fix by using virtio_device->device consistently for
> allocation and deallocation
>
> Fixes: 4944be2f5ad8c ("virtio_net: Allocate rss_hdr with devres")
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


