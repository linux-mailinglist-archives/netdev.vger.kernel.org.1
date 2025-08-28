Return-Path: <netdev+bounces-217870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E30B3A398
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2E17B9A23
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929FA189BB0;
	Thu, 28 Aug 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjxD/Kbl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57432586E8
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756393799; cv=none; b=ooXaGcQMesyeykewK5RIcE1Mq/EVuYv5j3w77Fx4C5KEqGNaxkwJHCCNHl4gYQY0epcv54vB+6Y7bxSMY8MlpMSU+QKAMluwB99ha7HAv5/QxAdR4fK7X65PFmpLRqUOOIOkuAs4Y9BbyQvK/Jt7EedcXzTmi4vOxC/sbcyStTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756393799; c=relaxed/simple;
	bh=QcfCcnrvOQmhOm7p8qX+0A/vbTjVI9mWnuhrQjHxCuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5pm2sgJQMLYx53WMwfvX8qG2ETq9sltGT6AI3LFbmH6svmDRoTBhDIfffwqXbfMi4MmMirRdNeEZK9S3U37tNpvyT6bbd+9sKP1UfVKXQVdRZ5an0uZjbszQLEHIRqQzxbG2IdqDooaMKb3ph/KPzy9gc5ufSPiyxs91w15ED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjxD/Kbl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c79f0a604aso671048f8f.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756393796; x=1756998596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjJYNrr5WT/wrYsKr9gUmQcRLcssi3aqGCkxeDsau4A=;
        b=PjxD/KblQUGvsUqMSkoAio/6FayQ6LxzZ7I7OpXqWUz0G/sx2ZzaESSFvwH2E09HTc
         ck6x0e0h9rXxcI87fXlfJ7uNkEsMc8HbKTSty/WRq10p9/KV3JiYnhJcunWeDZ7UAj1r
         kU6gVpERwKoVLTPzTlNUxRjhJdS9pWsccIBY9YK6vG9i937OR7jYrvLY5Bx0m5JnXG82
         Ff9X3KT9m5EJcHNeP8AEvsadzia6Go/S0+gsz94gmD+3nw9KMekZ5kQl3zq/fL1I7Zqa
         JXBGQO+K9+eWddGcinwgSAuNdy8HbudJy6NyFJ0qrPV7ZY2pU8dkdp/goFCeRw++93lF
         uQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756393796; x=1756998596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjJYNrr5WT/wrYsKr9gUmQcRLcssi3aqGCkxeDsau4A=;
        b=m0mbxpguVgVxmhHEW+58fKpj2NTGePzF4lbJbGtlPJGO/U1gxd+Oy/g6Q8OJYwNSi/
         ixeUpWGeNPi3d3vPolduR/38PntEgn7n4XoyXvRDU2NBlr4JGKAsYcTWFYZynb24WAco
         ShzGQEkMSmXjH1WQN/S49WnMbAaBVtwMRYyyChrb9aFNqP6wvuE+zLfhIqzOV+xZsNt2
         sGSu97SK82gkjA1D0T0KknwM+6+z5MLCm55VOn8inv60uI9z9GgI4l8s7ykRbOeAREuP
         dR9wRk6f5tX5bXdP44aJFUQUKWGImgnIePoxrk9PWCtWe4YwK+FHUQWdxPqmqART5y0V
         SzRA==
X-Gm-Message-State: AOJu0YyKrgyb7pkfBjCyGWr4YtZ4c1RhD5TfdJA08qu3XrIJm4C5G9UA
	mwkgMR/V4tA8fLQ+7pYWZJkzwAC39EFB1bH4mMPaXx5ZaW7JOd7P9smxMvGWOPPAifOJlLJedgK
	KApjsYNkJf84gKUSVcXxRF9KChy1Dz00=
X-Gm-Gg: ASbGncsfBQNxcja7oWmDDydJYbHTqyv8saoWV51K1HnW5tVmn9WKdJC34osLsfWscD3
	M+rELjtvlO9KwjzCFh++U+hUm58vVhc3cUXNawW9bk1AOQcpZHff9UH+/8p1aqmgXtfgIjW9/EQ
	PyVsv5z82CdzYpuIyqfmZDxqTwBFg+Kl8Oxp7o2k1mukQTFZMghchUwiq7Ig1wuLM5bVejXnOIx
	pGzIgEpWMYFzTdLx2qwhR/oJvHuVqhocbXn+5QBnfL2MWHTWq4=
X-Google-Smtp-Source: AGHT+IEYW+tmlve9IeSdb7Ukh+jWALbdITP3HDju7B+kJpqUn6BM7RJtv7u2YaWy46nzMRvu/lD812Biqp31g2bKUSs=
X-Received: by 2002:a05:6000:4212:b0:3c7:f9a9:7b44 with SMTP id
 ffacd0b85a97d-3c7f9a97f14mr14918328f8f.14.1756393795711; Thu, 28 Aug 2025
 08:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
 <bc846535-a5f5-4e24-9325-22f9d8b887f9@redhat.com> <2861b6ca-4b65-4500-addf-ca13b415a56f@redhat.com>
In-Reply-To: <2861b6ca-4b65-4500-addf-ca13b415a56f@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 28 Aug 2025 08:09:19 -0700
X-Gm-Features: Ac12FXzr8x8a04oQRPh2EOuKrIxVzbeABeBWfaKw8GNQrNXh_7XojzIakLFdvuU
Message-ID: <CAKgT0UdrVYpWW-4BVda7A7dwta-d_mod1-3dy2vNcx+b-+YtTQ@mail.gmail.com>
Subject: Re: [net-next PATCH 0/4] fbnic: Synchronize address handling with BMC
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, 
	Mohsin Bashir <mohsin.bashr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 5:50=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/28/25 12:46 PM, Paolo Abeni wrote:
> > On 8/26/25 9:44 PM, Alexander Duyck wrote:
> >> The fbnic driver needs to communicate with the BMC if it is operating =
on
> >> the RMII-based transport (RBT) of the same port the host is on. To ena=
ble
> >> this we need to add rules that will route BMC traffic to the RBT/BMC a=
nd
> >> the BMC and firmware need to configure rules on the RBT side of the
> >> interface to route traffic from the BMC to the host instead of the MAC=
.
> >>
> >> To enable that this patch set addresses two issues. First it will caus=
e the
> >> TCAM to be reconfigured in the event that the BMC was not previously
> >> present when the driver was loaded, but the FW sends a notification th=
at
> >> the FW capabilities have changed and a BMC w/ various MAC addresses is=
 now
> >> present. Second it adds support for sending a message to the firmware =
so
> >> that if the host adds additional MAC addresses the FW can be made awar=
e and
> >> route traffic for those addresses from the RBT to the host instead of =
the
> >> MAC.
> >
> > The CI is observing a few possible leaks on top of this series:
> >
> > unreferenced object 0xffff888011146040 (size 216):
> >   comm "napi/enp1s0-0", pid 4116, jiffies 4295559830
> >   hex dump (first 32 bytes):
> >     c0 bc a0 08 80 88 ff ff 00 00 00 00 00 00 00 00  ................
> >     00 40 02 08 80 88 ff ff 00 00 00 00 00 00 00 00  .@..............
> >   backtrace (crc d10d3409):
> >     kmem_cache_alloc_bulk_noprof+0x115/0x160
> >     napi_skb_cache_get+0x423/0x750
> >     napi_build_skb+0x19/0x210
> >     xdp_build_skb_from_buff+0xda/0x820
> >     fbnic_run_xdp+0x36c/0x550
> >     fbnic_clean_rcq+0x540/0x1790
> >     fbnic_poll+0x142/0x290
> >     __napi_poll.constprop.0+0x9f/0x460
> >     napi_threaded_poll_loop+0x44d/0x610
> >     napi_threaded_poll+0x17/0x30
> >     kthread+0x37b/0x5f0
> >     ret_from_fork+0x240/0x320
> >     ret_from_fork_asm+0x11/0x20
> > unreferenced object 0xffff888008a0bcc0 (size 216):
> >   comm "napi/enp1s0-0", pid 4116, jiffies 4295560865
> >   hex dump (first 32 bytes):
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 40 02 08 80 88 ff ff 00 00 00 00 00 00 00 00  .@..............
> >   backtrace (crc d69e2bd9):
> >     kmem_cache_alloc_node_noprof+0x289/0x330
> >     __alloc_skb+0x20f/0x2e0
> >     __tcp_send_ack.part.0+0x68/0x6b0
> >     tcp_rcv_established+0x69c/0x2340
> >     tcp_v6_do_rcv+0x9b4/0x1370
> >     tcp_v6_rcv+0x1bc5/0x2f90
> >     ip6_protocol_deliver_rcu+0x112/0x1140
> >     ip6_input+0x201/0x5e0
> >     ip6_sublist_rcv_finish+0x91/0x260
> >     ip6_list_rcv_finish.constprop.0+0x55b/0xa10
> >     ipv6_list_rcv+0x318/0x4b0
> >     __netif_receive_skb_list_core+0x4c6/0x980
> >     netif_receive_skb_list_internal+0x63c/0xe50
> >     gro_complete.constprop.0+0x54d/0x750
> >     __gro_flush+0x14a/0x490
> >     __napi_poll.constprop.0+0x319/0x460
> >
> > But AFAICS they don't look related to the changes in this series,
>
> I went over the series with more attention, I'm reasonably sure the leak
> are unrelated. Possibly is kmemleak fouled by some unfortunate timing?
>
> In any case I'm applying this series now.
>
> /P

Yeah, as far as I can tell this would most likely be related to the
recent XDP changes that were added by Mohsin. I added him to the Cc
just so he is aware. As far as I know we haven't seen anything similar
in our CI, but we will keep an eye out for it and will track it
internally as a sighting in the event that we start seeing similar
issues.

Thanks,

- Alex

