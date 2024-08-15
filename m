Return-Path: <netdev+bounces-118721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4660795291F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3BA1F21FC0
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42999143748;
	Thu, 15 Aug 2024 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBlWXpxA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B71239FE5
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701824; cv=none; b=IjZqroa00o6yzoWzAI7aZ72z1uZSp0hcaXwHxga4NWC6CV+SUj749v7H+aVBbmNn+pcrmQ4XcUfdOcrl94bqwXRZvR6HXaQCIsdt1hcWrP1oxQsL3XUTpa+TWd+Z6qS8N2jET/ZdIf2mGCOy5Q8rCMVJKXZEsxcADEwyzaYCB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701824; c=relaxed/simple;
	bh=GPmCQM5NNtOtJ+QKbX7iV3ZV7O48A4U90cWlAd0yZ9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lz+LTRV4YdRl0bLfQdiQzszGE9LvEbF+djEvPCdQneBwtBxK6MlbGWeRqfN6lyng/wZT+LUl5/5cPh3/a6XjZZLv7qDzJ2T9VtDsSbO7gu0QkWBR0Aq1vGCmRu4Y2Ntd6Bj7c3gGrwpqoaBCChBjvTb4ElhR5d3tm6Z8q1kdSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBlWXpxA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723701821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nP+XUpr7erg5BEw8ptLFA9XGqDGjBrYwvameBbwmgBo=;
	b=fBlWXpxAjTjSi9qihO6xG8HggapSZepiaZW6d3wkbrUm/z73Mj5AaGuaQgqO2Xv2S8j3+K
	pc98J/FAKqtJSY4sT05Mpnni3peXhS97UX8M1LkZC5nRytaESoZcrqXZT/dyiRUWJiy2nj
	rgtQIFzO7cL8agABUdgrCIHK8VHjr0s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-BLjFngQJMyapu67dhWKs2g-1; Thu, 15 Aug 2024 02:03:39 -0400
X-MC-Unique: BLjFngQJMyapu67dhWKs2g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb6b642c49so1553465a91.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 23:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723701818; x=1724306618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nP+XUpr7erg5BEw8ptLFA9XGqDGjBrYwvameBbwmgBo=;
        b=CHHNhrMppG4ocSNsXGaSfhsWePtE9CUjwMj/veev/Fpkl8ghcRIDRm+0rKhO1DUD0M
         +bnkp/J1i16Ads4DKcVJgIsw3V54iQKUfJsZFWPBOkDAKSExeGZITZbA57+5ZcAEOlor
         nt1umWw0kocjvHv8avF0UewD0JfuwGXVgWnWsAVvnL1VFdqEipices1ta6LSoLqbGiRr
         AZbpfocSPLuCDhvVqHkh1IZH9/Rjci26EWuxj3Y8Ae6lkpNj7zY9OzO1eYxJR5YkY2ya
         BLdsFOGQyrz7ObBvE8/wxWxqFkTy4I6RqzU6LzpYN//jZx+TuLiQn0mgwq78Hj8a27FW
         kMNA==
X-Forwarded-Encrypted: i=1; AJvYcCXnI9H/nuPA2nnLj7UMmEm1dWDvHYg8dk63m/UOaVGye4sgq1b47W2Q0xfTl1jWGvOTq1uZezidyifBFIbX2MzQpjYMPYDK
X-Gm-Message-State: AOJu0Yz66R6zoMfDNNseGohD92xPWnxvwD/xcpkWrjQHT3YCfRXuZTvl
	jmkSkesPxS/HCl3oepjCyPG0dJAnjrV98PB4bAwkRZoToeLCP0Pfns68aLyh9+n8/kLwg3ANyje
	zZhXsrobs97WKjLEtZrrLIaFPTzHkH00DbCNuovL7KywGrCgu0IhfU9Kk6ANJ2Ye7EeXLjqjFUT
	4FN/HtWhXriAauIR2KWGpqRafW9V4v
X-Received: by 2002:a17:90b:fc2:b0:2cb:58e1:abc8 with SMTP id 98e67ed59e1d1-2d3c3a42365mr2924985a91.21.1723701817947;
        Wed, 14 Aug 2024 23:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJMYffQL25EyjWVnQ4NUjaSE8aOAOz8i+jSgGBXnLjj5FeFCVVf+JMIo8QSYAppGmiytb6+co8QXxky2rc1Tc=
X-Received: by 2002:a17:90b:fc2:b0:2cb:58e1:abc8 with SMTP id
 98e67ed59e1d1-2d3c3a42365mr2924951a91.21.1723701817365; Wed, 14 Aug 2024
 23:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814122500.1710279-1-jiri@resnulli.us> <20240814082835-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240814082835-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 15 Aug 2024 14:03:26 +0800
Message-ID: <CACGkMEs3X8KH3zHLkT74COqHa6N9noKT8TaUj-KRLkaok4Pv_w@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: move netdev_tx_reset_queue() call before
 RX napi enable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Aug 14, 2024 at 02:25:00PM +0200, Jiri Pirko wrote:
> > From: Jiri Pirko <jiri@nvidia.com>
> >
> > During suspend/resume the following BUG was hit:
> > ------------[ cut here ]------------
> > kernel BUG at lib/dynamic_queue_limits.c:99!
> > Internal error: Oops - BUG: 0 [#1] SMP ARM
> > Modules linked in: bluetooth ecdh_generic ecc libaes
> > CPU: 1 PID: 1282 Comm: rtcwake Not tainted
> > 6.10.0-rc3-00732-gc8bd1f7f3e61 #15240
> > Hardware name: Generic DT based system
> > PC is at dql_completed+0x270/0x2cc
> > LR is at __free_old_xmit+0x120/0x198
> > pc : [<c07ffa54>]    lr : [<c0c42bf4>]    psr: 80000013
> > ...
> > Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 10c5387d  Table: 43a4406a  DAC: 00000051
> > ...
> > Process rtcwake (pid: 1282, stack limit =3D 0xfbc21278)
> > Stack: (0xe0805e80 to 0xe0806000)
> > ...
> > Call trace:
> >   dql_completed from __free_old_xmit+0x120/0x198
> >   __free_old_xmit from free_old_xmit+0x44/0xe4
> >   free_old_xmit from virtnet_poll_tx+0x88/0x1b4
> >   virtnet_poll_tx from __napi_poll+0x2c/0x1d4
> >   __napi_poll from net_rx_action+0x140/0x2b4
> >   net_rx_action from handle_softirqs+0x11c/0x350
> >   handle_softirqs from call_with_stack+0x18/0x20
> >   call_with_stack from do_softirq+0x48/0x50
> >   do_softirq from __local_bh_enable_ip+0xa0/0xa4
> >   __local_bh_enable_ip from virtnet_open+0xd4/0x21c
> >   virtnet_open from virtnet_restore+0x94/0x120
> >   virtnet_restore from virtio_device_restore+0x110/0x1f4
> >   virtio_device_restore from dpm_run_callback+0x3c/0x100
> >   dpm_run_callback from device_resume+0x12c/0x2a8
> >   device_resume from dpm_resume+0x12c/0x1e0
> >   dpm_resume from dpm_resume_end+0xc/0x18
> >   dpm_resume_end from suspend_devices_and_enter+0x1f0/0x72c
> >   suspend_devices_and_enter from pm_suspend+0x270/0x2a0
> >   pm_suspend from state_store+0x68/0xc8
> >   state_store from kernfs_fop_write_iter+0x10c/0x1cc
> >   kernfs_fop_write_iter from vfs_write+0x2b0/0x3dc
> >   vfs_write from ksys_write+0x5c/0xd4
> >   ksys_write from ret_fast_syscall+0x0/0x54
> > Exception stack(0xe8bf1fa8 to 0xe8bf1ff0)
> > ...
> > ---[ end trace 0000000000000000 ]---
> >
> > After virtnet_napi_enable() is called, the following path is hit:
> >   __napi_poll()
> >     -> virtnet_poll()
> >       -> virtnet_poll_cleantx()
> >         -> netif_tx_wake_queue()
> >
> > That wakes the TX queue and allows skbs to be submitted and accounted b=
y
> > BQL counters.
> >
> > Then netdev_tx_reset_queue() is called that resets BQL counters and
> > eventually leads to the BUG in dql_completed().
> >
> > Move virtnet_napi_tx_enable() what does BQL counters reset before RX
> > napi enable to avoid the issue.
> >
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Closes: https://lore.kernel.org/netdev/e632e378-d019-4de7-8f13-07c572ab=
37a9@samsung.com/
> > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


