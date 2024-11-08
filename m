Return-Path: <netdev+bounces-143417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D404C9C25AF
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D6E1F24A0C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC21AA1CD;
	Fri,  8 Nov 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdFt1qqx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441BF1AA1D9
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094831; cv=none; b=gLE4sIvaq2hAZdsOPk1CN6Cpf6Cuvy8jS65ECCN+IUsgjVbGxfryG6fVyezBu4QmXboqRLxY7zqaZM/CY1z1WxQh2t5uCgmU7VJRj5blLORvuc2MjodBhF7hkaJuXIGyk7qJfq/Sd4yC2m3U4BEImqOqyjHWfoI3nZPwXQzPoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094831; c=relaxed/simple;
	bh=hI/GbviGAktnyoSM4qIHLcR6DTA2gG75nZHLTTXZ9lc=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=TuoDqQXuHaU4xvun7xIxs2mTfwe98MjePUcM862PYq05v5vA6aLUZ0n3g5k7nZT8FJL0fn91Yy3Npv7hw8sa9eCeRaxFphhCKjCjAl4oNVuEs6cea0RV41BRaTzv87NsFZJQtPEcCQT/NlTBWRbar0VvKfK0owqQ19JabN0X+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdFt1qqx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731094828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oEsZc6W1u5d3TDswrbxG30C8tt+8yJ6AtfaxfiOswHg=;
	b=SdFt1qqxxB5WAYCVlSSq8obMQlWRmRnHxHNztvVWgoFTsMNd3h0UAe8AhELuRJa/yuPAfQ
	iNW0FepgaeVqKzV193h85H+U1jmljLQ4/UXJQu0TPVCegrW1mV3YUZiMZTQKfMTaqyGPBT
	n18SDElTCrl4EKSLYT5/Li3hCge3KSw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-EhhXrNHTOk-2Moe1_cC9zw-1; Fri, 08 Nov 2024 14:40:26 -0500
X-MC-Unique: EhhXrNHTOk-2Moe1_cC9zw-1
X-Mimecast-MFC-AGG-ID: EhhXrNHTOk-2Moe1_cC9zw
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d3a68951ccso4082386d6.3
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 11:40:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731094826; x=1731699626;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEsZc6W1u5d3TDswrbxG30C8tt+8yJ6AtfaxfiOswHg=;
        b=NGGYI/BjRGEtVIkcGJexvOf4GDcPExKO6eHOKAeJOWIXO/RKUXhpbzaMYtKK8LjQQQ
         VRUIEjmsL8qXP7vV9n60lhFVEDQl6qw8wz/6JbX54y7K9R51vq2agZHWQ4nWbrIPoyCy
         Cz2dSXGAMopfbeGxjQrAs0ENUQdjIQwoxK1ZdcnxUke5nymtjxosIHRL6893mdLLMB5t
         piQ9kUTBW+yOuOI3iiiUZlGgHNZzdwTYsYgKVQJy6fZWnFvKGKe0ZM4p7yQ31ml/XNiK
         lfruCoNOsDjHFVxRfovF24YWD1GlKkB4giOyLsJlHLokS0PYbUBMbOapOPHjrdEY4i9e
         m+yg==
X-Forwarded-Encrypted: i=1; AJvYcCWzHq3xr363yfp5LJt6Gllgp9fnXQmiUI09BIkf6j//jzMFHVBN4KYm8tiwLbuQU/cnFAGSG3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDf//cNA+Bm0p60MLW0RonbPSZ2TpzA1U5S06lqL/CmhRgoA/V
	EUuIOksQmj2gkedpJu1smivP/ohpnUYNqB1lgj3Ojo+pNC+Y+B1+whMKN2+O8sKXILwmCO/6Z4f
	J0Kpaf1DKOE8ii46WOVVzuq7ivm/xBVZmmlYEDayLd6yq/sRaOvIEbZE+2jUiKg==
X-Received: by 2002:a05:6214:3c8c:b0:6d3:4640:58ba with SMTP id 6a1803df08f44-6d39e155650mr46653766d6.6.1731094825951;
        Fri, 08 Nov 2024 11:40:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjCHOTwgwHMvYUhldMnpW7KiJWkXiiJDDfuYH9mQ+wg7BiI7BZcuNyKjdCiW90WC0iIkZb7w==
X-Received: by 2002:a05:6214:3c8c:b0:6d3:4640:58ba with SMTP id 6a1803df08f44-6d39e155650mr46653636d6.6.1731094825533;
        Fri, 08 Nov 2024 11:40:25 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d39620be5dsm22591786d6.65.2024.11.08.11.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 11:40:24 -0800 (PST)
Message-ID: <f4539cfe06be027d210d2af121c37d1c67a6a53a.camel@redhat.com>
Subject: kmemleak reports related to napi_get_frags_check
From: Radu Rendec <rrendec@redhat.com>
To: linux-mm@kvack.org, netdev@vger.kernel.org
Date: Fri, 08 Nov 2024 14:40:24 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-3.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi everyone,

I'm investigating some kmemleak reports that are related to the
napi_get_frags_check() function. Similar issues have been reported
before in [1] and [2], and the upper part of the stack trace, starting
at gro_cells_init(), is identical in my case.

I am pretty sure this is a kmemleak false-positive, which is not
surprising, and I am approaching this from a different perspective -
trying to understand how a false-positive in this particular case is
even possible. So far, I have been unsuccessful. Like Eric Dumazet
pointed out in his reply to [1], napi_get_frags_check() is very self-
contained. It allocates an skb and then immediately frees it.

I would appreciate if anyone could offer any insights or new ideas to
try to explain this behavior. Again, this is not about fixing the
networking code (because I believe there's nothing to fix there) but
rather finding a solid explanation for how the kmemleak report is
possible. That might lead to either direct (code) or indirect (usage)
improvements to kmemleak.

My understanding is that kmemleak immediately removes an object from
its internal list of tracked objects upon deallocation of the object.
It also has a built-in object age threshold of 5 seconds before it
reports a leak, specifically to avoid false-positives when pointers to
the allocated objects are in flight and/or temporarily stored in CPU
registers. Since in this case the deallocation is done immediately
after the allocation and it's unconditional, I can't even imagine how
it can escape the object age guard check.

For the record, this is the kmemleak report that I'm seeing:

unreferenced object 0xffff4fc0425ede40 (size 240):
  comm "(ostnamed)", pid 25664, jiffies 4296402173
  hex dump (first 32 bytes):
    e0 99 5f 27 c1 4f ff ff 40 c3 5e 42 c0 4f ff ff  .._'.O..@.^B.O..
    00 c0 24 15 c0 4f ff ff 00 00 00 00 00 00 00 00  ..$..O..........
  backtrace (crc 1f19ed80):
    [<ffffbc229bc23c04>] kmemleak_alloc+0xb4/0xc4
    [<ffffbc229a16cfcc>] slab_post_alloc_hook+0xac/0x120
    [<ffffbc229a172608>] kmem_cache_alloc_bulk+0x158/0x1a0
    [<ffffbc229b645e18>] napi_skb_cache_get+0xe8/0x160
    [<ffffbc229b64af64>] __napi_build_skb+0x24/0x60
    [<ffffbc229b650240>] napi_alloc_skb+0x17c/0x2dc
    [<ffffbc229b76c65c>] napi_get_frags+0x5c/0xb0
    [<ffffbc229b65b3e8>] napi_get_frags_check+0x38/0xb0
    [<ffffbc229b697794>] netif_napi_add_weight+0x4f0/0x84c
    [<ffffbc229b7d2704>] gro_cells_init+0x1a4/0x2d0
    [<ffffbc2250d8553c>] ip_tunnel_init+0x19c/0x660 [ip_tunnel]
    [<ffffbc2250e020c0>] ipip_tunnel_init+0xe0/0x110 [ipip]
    [<ffffbc229b6c5480>] register_netdevice+0x440/0xea4
    [<ffffbc2250d846b0>] __ip_tunnel_create+0x280/0x444 [ip_tunnel]
    [<ffffbc2250d88978>] ip_tunnel_init_net+0x264/0x42c [ip_tunnel]
    [<ffffbc2250e02150>] ipip_init_net+0x30/0x40 [ipip]=20

The obvious test, which I already did, is to create/delete ip tunnel
interfaces in a loop. I let this test run for more than 24 hours, and
kmemleak did *not* detect anything. I also attached a kprobe inside
napi_skb_cache_get() right after the call to kmem_cache_alloc_bulk(),
and successfully verified that the allocation path is indeed exercised
by the test i.e., the skb is *not* always returned from the per-cpu
napi cache pool. In other words, I was unable to find a way to
reproduce these kmemleak reports.

It is worth noting that in the case of a "manually" created tunnel
using `ip tunnel add ... mode ipip ...`, the lower part of the stack is
different from the kmemleak report (see below). But I don't think this
can affect the skb allocation or pointer handling behavior, and the
upper part of the stack, starting at register_netdevice(), is identical
anyway.

comm: [ip], pid: 101422
        ip_tunnel_init+0
        register_netdevice+1088
        __ip_tunnel_create+640
        ip_tunnel_ctl+956
        ipip_tunnel_ctl+380
        ip_tunnel_siocdevprivate+212
        dev_ifsioc+1096
        dev_ioctl+348
        sock_ioctl+1760
        __arm64_sys_ioctl+288
        invoke_syscall.constprop.0+216
        do_el0_svc+344
        el0_svc+84
        el0t_64_sync_handler+308
        el0t_64_sync+380

Another thing I did consider is whether kmemleak is likely to be
confused by per-cpu allocations, since gcells->cells is per-cpu
allocated in gro_cells_init(). I created a simple test kernel module
that did a similar per-cpu allocation, and I did *not* notice any
problem with kmemleak being able to track dynamically allocated blocks
that are referenced through per-cpu pointers.

One final note is that the reports in [1] seem to have been observed on
x86_64 (judging by the presence of entry_SYSCALL_64_after_hwframe in
the stack trace), while mine were observed on aarch64. So, whatever the
root cause behind these kmemleak reports is, it seems to be
architecture independent.

Thanks in advance,
Radu Rendec

[1] https://lore.kernel.org/all/YwkH9zTmLRvDHHbP@krava/
[2] https://lore.kernel.org/all/1667213123-18922-1-git-send-email-wangyufen=
@huawei.com/


