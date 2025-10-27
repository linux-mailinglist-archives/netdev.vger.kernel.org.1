Return-Path: <netdev+bounces-233210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FE5C0E783
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0BE34F7151
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 14:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A730C34A;
	Mon, 27 Oct 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHCghBzJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED31230C621
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575513; cv=none; b=s0m+aBjUndVcqyLCoMr7NWwM8FOm4fLU7UWOeudkmhxzVTqSRH/WwQygM8yehrKG1EGvktenpY0VgHTMNAfQjdNOBTU07WdtMhb4GDjglzaDX773JAdY6LOdv17m3C3OTL7embegtWLpNqwS2rNIYwRkh6CPow3t4i3kH47kGIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575513; c=relaxed/simple;
	bh=5yoCK2fLFx2htBhJqpSHdGHkPxVFQ0/TNvSRi8cTu5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PdrKFjbCJ4jzLQu58QDjZDAZoGkxiQTwRS9Pggh+Jjzl6WmoVp6j6yipvYA1t5Ua8xXgeWdOmVjpq2+ZHFkEIhAeDz0yCj4TkI7FRhjGBRmUAEtFdU4hdtS+6J/u82tkbvyjxweUwcGQHCRQDQySaqjgMjBYAZBA7wxj4kYi5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHCghBzJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761575510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RC2NuXLdnjLHgFfW2yobW9SdnsNBGRycsRCnkqVBmtg=;
	b=WHCghBzJpcoAROOEXTAvhQasHuNCxHagDeLiJ00B3zVigfs4lmLvYvdKCk46Iym6idCnni
	yx+2o2l/K5mcNbUttRHJyqp5btoJ+WPlKMCT7E3UGGRi9I+NT1ufnQfokOdXK+h4UleVRz
	gHBNvi/zU5RKOGJKmSMdVFUx+P49N4I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-TW17gNf2OY-BMFbDPXte0g-1; Mon, 27 Oct 2025 10:31:48 -0400
X-MC-Unique: TW17gNf2OY-BMFbDPXte0g-1
X-Mimecast-MFC-AGG-ID: TW17gNf2OY-BMFbDPXte0g_1761575507
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b6d5f61877eso339753566b.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 07:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575507; x=1762180307;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC2NuXLdnjLHgFfW2yobW9SdnsNBGRycsRCnkqVBmtg=;
        b=ax37v7qVGGnarB/Lr1WSEOthrnrZEiGs8tSjV6bm2wt/E847O+J3fIC5qMzNmoaCka
         DA1Iu1k3SDI6uFo6WMS3eVM2T9kfa0uw+UIsH2gKqLWXSlam88soRMg7u2doguIUl72T
         sFc8MEbhm/XDyyP7dPynqLRz/h/ezSijEMi3BvOIIo6+yHBIPqANtk+L6j9LNwULpkhP
         Qox3lN8iIY2KN2owOdulhBLHlW3QOpia8c4BLxi0Ev+w09MZ71BvQOjNxx3ZKuKL8JhK
         Efxss6bc9s03bIPoNNg+qF8TMTTjz0QX0i4Kl5EHSG3ip+VBhl0BvcpbPE0FCnBKa2QI
         /KRA==
X-Gm-Message-State: AOJu0YyGMyViYA267B1HDapmgheGjJoKxvoY7ogfmm5bbvYEsifklnCO
	IZ2QZgQZBREA5e/4/28kHdZUEZKYYYQwi9Tctn+W3dvA28PtElUoznhWIS2uyG/cZ0sqOQK4fXY
	jadlVOcCrYqB4KNmuQK+IZgXwKYDNuoVBXbm5WMIOONWKvUoE9WbBmLgGyKFRNJQQ0w==
X-Gm-Gg: ASbGncs6tNnyWFuZLetb79oehudotsIFeHutuy0ZRg8E8wDq1GEAkLMrD0JHPED7zfX
	5fJFxQDV5vHHuKrbbpos9BjKuoR+SS/873BxVBripeDZPnLrGFQR+vr9Xz1Z5+Sx/Bvo1dqUb0r
	Nce/MDVoxXF4GFd94km296vsImIoD1pqHxiJXD8uqS5/myVOjWKaOkjCiOBi9fGcpqgfZzPgU/D
	n4xE6vfis6xfL2vngvRGvJi2TcaSsdt18ry39dhmwd1OR5HSrr0MKM/yaYQNnOKcldVhBudKNt7
	4JLtGRvwUj5KcFC8LkhfggpfKxWdR6nmukDUW7E1qPCKAOuB400kQMjxxL/42aekwajwSX4b9Ld
	RifDInA1VTfUrmM1d451hJ4ybYA==
X-Received: by 2002:a17:907:7ba8:b0:b3d:200a:bd6e with SMTP id a640c23a62f3a-b6dba5a54e7mr10307366b.47.1761575506839;
        Mon, 27 Oct 2025 07:31:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu+GLRLPMVOA9xC7zkvI5UmwsYsI28Ty7IQo5OH1Hkudxl2thVOn2YkMHx0f0USc0NQF4l6A==
X-Received: by 2002:a17:907:7ba8:b0:b3d:200a:bd6e with SMTP id a640c23a62f3a-b6dba5a54e7mr10305466b.47.1761575506419;
        Mon, 27 Oct 2025 07:31:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548ed8fsm782554466b.73.2025.10.27.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:31:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 300D92EAA60; Mon, 27 Oct 2025 15:31:45 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 aleksander.lobakin@intel.com, ilias.apalodimas@linaro.org,
 lorenzo@kernel.org, kuba@kernel.org, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v4 bpf 2/2] veth: update mem type in xdp_buff
In-Reply-To: <20251027121318.2679226-3-maciej.fijalkowski@intel.com>
References: <20251027121318.2679226-1-maciej.fijalkowski@intel.com>
 <20251027121318.2679226-3-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 27 Oct 2025 15:31:45 +0100
Message-ID: <87ms5ce7qm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> When skb's headroom is not sufficient for XDP purposes,
> skb_pp_cow_data() returns new skb with requested headroom space. This
> skb was provided by page_pool.
>
> For CONFIG_DEBUG_VM=3Dy and XDP program that uses bpf_xdp_adjust_tail()
> against a skb with frags, and mentioned helper consumed enough amount of
> bytes that in turn released the page, following splat was observed:
>
> [   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
> [   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000 index=
:0x0 pfn:0x11c98b
> [   32.210084] flags: 0x1fffe0000000000(node=3D0|zone=3D1|lastcpupid=3D0x=
7fff)
> [   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b000 00=
00000000000000
> [   32.218056] raw: 0000000000000000 0000000000000001 00000000ffffffff 00=
00000000000000
> [   32.220900] page dumped because: page_pool leak
> [   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
> [   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G O     =
   6.17.0-rc5-gfec474d29325 #6969 PREEMPT
> [   32.224638] Tainted: [O]=3DOOT_MODULE
> [   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   32.224641] Call Trace:
> [   32.224644]  <IRQ>
> [   32.224646]  dump_stack_lvl+0x4b/0x70
> [   32.224653]  bad_page.cold+0xbd/0xe0
> [   32.224657]  __free_frozen_pages+0x838/0x10b0
> [   32.224660]  ? skb_pp_cow_data+0x782/0xc30
> [   32.224665]  bpf_xdp_shrink_data+0x221/0x530
> [   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
> [   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
> [   32.224673]  ? xsk_destruct_skb+0x321/0x800
> [   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0xd6
> [   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
> [   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
> [   32.224688]  ? veth_set_channels+0x920/0x920
> [   32.224691]  ? get_stack_info+0x2f/0x80
> [   32.224693]  ? unwind_next_frame+0x3af/0x1df0
> [   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
> [   32.224700]  ? common_startup_64+0x13e/0x148
> [   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
> [   32.224706]  ? stack_trace_save+0x84/0xa0
> [   32.224709]  ? stack_depot_save_flags+0x28/0x820
> [   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
> [   32.224716]  ? timerqueue_add+0x217/0x320
> [   32.224719]  veth_poll+0x115/0x5e0
> [   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
> [   32.224726]  ? update_load_avg+0x1cb/0x12d0
> [   32.224730]  ? update_cfs_group+0x121/0x2c0
> [   32.224733]  __napi_poll+0xa0/0x420
> [   32.224736]  net_rx_action+0x901/0xe90
> [   32.224740]  ? run_backlog_napi+0x50/0x50
> [   32.224743]  ? clockevents_program_event+0x1cc/0x280
> [   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
> [   32.224749]  handle_softirqs+0x151/0x430
> [   32.224752]  do_softirq+0x3f/0x60
> [   32.224755]  </IRQ>
>
> It's because xdp_rxq with mem model set to MEM_TYPE_PAGE_SHARED was used
> when initializing xdp_buff.
>
> Fix this by using new helper xdp_convert_skb_to_buff() that, besides
> init/prepare xdp_buff, will check if page used for linear part of
> xdp_buff comes from page_pool. We assume that linear data and frags will
> have same memory provider as currently XDP API does not provide us a way
> to distinguish it (the mem model is registered for *whole* Rx queue and
> here we speak about single buffer granularity).
>
> Before releasing xdp_buff out of veth via XDP_{TX,REDIRECT}, mem type on
> xdp_rxq associated with xdp_buff is restored to its original model. We
> need to respect previous setting at least until buff is converted to
> frame, as frame carries the mem_type. Add a page_pool variant of
> veth_xdp_get() so that we avoid refcount underflow when draining page
> frag.
>
> Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3=
aJw7hE+4E2_iPA@mail.gmail.com/
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


