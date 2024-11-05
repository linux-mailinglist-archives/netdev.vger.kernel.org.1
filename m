Return-Path: <netdev+bounces-141961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC3B9BCCA1
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3805B20A3A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398B41D5160;
	Tue,  5 Nov 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dt5RjY59"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0601D460E
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809447; cv=none; b=LE+i2QJ6KHJV/A5HToTGk2ydP2xpyA9he3COfpOPXXtoVf6/D6qI73Dz9p+8db1BFwgq9n9CETps+7G0b1p8e79dXbFog0maKv6bG9V/vx3XH537JCrGzd/CgopC1IdyrOdSaDcLYbx6cgWnRfpVATtCbPgZxphnyDcurdg1+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809447; c=relaxed/simple;
	bh=Z3RxKyFF+Ak9RYp0Y7HGuKQtSUXZCbiRnqXg63PqVbU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E+wtC7wohCxXtCNk1R8NRqgJ+yl65TspR+XCOsAHVsW6WpUwCpSJoJ9FvKffpOfVC1d/CG8Y9s1ZhwhRKliYXXBO6cIziqdGL8hQ75LteYsOgPFjr6AOqgMR/yGoOBkSnU1xESG87pjT4JA4CO7xLqcG/ClovqOw/ACH8AV8srw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dt5RjY59; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730809444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3RxKyFF+Ak9RYp0Y7HGuKQtSUXZCbiRnqXg63PqVbU=;
	b=Dt5RjY59mGDJpoephCqIToYmQpaJHJHWIiszVDkZLvZqLa8/EjTDWP1esFQhULlROC7zQJ
	3fxDRy13t9E/YGCOZr+Nv2qiEshHtcktrREEJy9pgSNKAatevaD/UtlqN0l9PD6MogGMgD
	jGaMgPAIIroLPCHNioU03ZIBZgbUqg4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-tP0pFUZJMPuOyFvT7xkX4w-1; Tue, 05 Nov 2024 07:24:03 -0500
X-MC-Unique: tP0pFUZJMPuOyFvT7xkX4w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d5ca192b8so3298268f8f.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 04:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730809442; x=1731414242;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3RxKyFF+Ak9RYp0Y7HGuKQtSUXZCbiRnqXg63PqVbU=;
        b=jsIEJmgT4Ljs1lIQWCn6gi5JyBgNXcpxNNlTKZHQ0vwFqHQtcPz1Gc0Hz3XtDd/Rm0
         GHNRLvQO96/4iqanUOmXp4npIyV6qdPf30Z8qP1fR5faNXDJeA4P+kKm/KR9yoTxEbri
         VQwXc0O9nFrCXzoDB9opbhajJvzU/ZmhFci1u4rHFOrQOvaOvl0U2QYX9dI2qY4lY8nE
         gK3A+nIOmjfjwAqkHQYd2KnFbyvmJniLkE1SVONWGpGsf2tA8WydRCvR/Q5bld5oyAzS
         LquR48hFsSlEY5JGKHAP63+9OzN6YhvYPFJ+BanU206kryYQb9latRU1weLvA3dKp0WL
         avMg==
X-Forwarded-Encrypted: i=1; AJvYcCX4DALE5nfuTUjsKDJXR9wEgj+E8XPMZ3fjAFvSbUKrTmdLcwqeUKyR6U41x9J3Y5yNEMZTK5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQaLX7J1/dpofCooEWjwOhC01V3lfoIoDlhGFwK5KBgPiAbAhB
	zHxF9UT+CyGEHLMoH8Zo3B4+/tzDgYLZWMnqvYe4UE20Ret2UNGLlPBcGXiJhLW9mGjv0DjShpZ
	fKLoM/PsD6WjfP8C7NAM4UmhEQccBwZzLkOuHc+9VLOKZmPkJn0c/SQ==
X-Received: by 2002:a5d:64a7:0:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-381c79e366dmr13150405f8f.22.1730809442219;
        Tue, 05 Nov 2024 04:24:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzZvOHp9mDNLf51xpdI90j858qfaPZWduW8ds6lyIOgmL+9RgRFkJgWVGEH17X6Wx/BjpnPQ==
X-Received: by 2002:a5d:64a7:0:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-381c79e366dmr13150378f8f.22.1730809441710;
        Tue, 05 Nov 2024 04:24:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e69fsm16050891f8f.69.2024.11.05.04.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 04:24:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 061B0164C230; Tue, 05 Nov 2024 13:24:00 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Qingfang Deng <dqfext@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ppp@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: ppp: convert to IFF_NO_QUEUE
In-Reply-To: <20241029103656.2151-1-dqfext@gmail.com>
References: <20241029103656.2151-1-dqfext@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 05 Nov 2024 13:23:59 +0100
Message-ID: <87msid98dc.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Qingfang Deng <dqfext@gmail.com> writes:

> When testing the parallel TX performance of a single PPPoE interface
> over a 2.5GbE link with multiple hardware queues, the throughput could
> not exceed 1.9Gbps, even with low CPU usage.
>
> This issue arises because the PPP interface is registered with a single
> queue and a tx_queue_len of 3. This default behavior dates back to Linux
> 2.3.13, which was suitable for slower serial ports. However, in modern
> devices with multiple processors and hardware queues, this configuration
> can lead to congestion.
>
> For PPPoE/PPTP, the lower interface should handle qdisc, so we need to
> set IFF_NO_QUEUE.

This bit makes sense - the PPPoE and PPTP channel types call through to
the underlying network stack, and their start_xmit() ops never return
anything other than 1 (so there's no pushback against the upper PPP
device anyway). The same goes for the L2TP PPP channel driver.

> For PPP over a serial port, we don't benefit from a qdisc with such a
> short TX queue, so handling TX queueing in the driver and setting
> IFF_NO_QUEUE is more effective.

However, this bit is certainly not true. For the channel drivers that
do push back (which is everything apart from the three mentioned above,
AFAICT), we absolutely do want a qdisc to store the packets, instead of
this arbitrary 32-packet FIFO inside the driver. Your comment about the
short TX queue only holds for the pfifo_fast qdisc (that's the only one
that uses the tx_queue_len for anything), anything else will do its own
thing.

(Side note: don't use pfifo_fast!)

I suppose one option here could be to set the IFF_NO_QUEUE flag
conditionally depending on whether the underlying channel driver does
pushback against the PPP device or not (add a channel flag to indicate
this, or something), and then call the netif_{wake,stop}_queue()
functions conditionally depending on this. But setting the noqueue flag
unconditionally like this patch does, is definitely not a good idea!

-Toke


