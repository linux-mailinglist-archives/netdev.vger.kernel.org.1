Return-Path: <netdev+bounces-181127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B34A83BB5
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA0E17D760
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4211CEEBB;
	Thu, 10 Apr 2025 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYeOhx9L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F438130A54;
	Thu, 10 Apr 2025 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271543; cv=none; b=F8O/jntRRhNb9Ie6Y3PFYM04HOUphX0Es6/pVZ0pwE8UInxzaYK/7l5eX0xyN31VyWSyx7oAV7mVNf6fBlEwT6rJYy/eMkNcwKWoZwl7CeWhTMx+KMigWaNpJlsZoq899CFQXlWt59DEHRIYcpOzHYuCL11BiuCOWnwlAiiV/yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271543; c=relaxed/simple;
	bh=WjIIYhaS9Rv5kyJoUwOUYfZ9+oirV43H1dKift/3PWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mH+j33mBwBSvYS1ZM8WMwt00VPUyp9OC7KHgYF+XCLXkDx/0VwIURzs5qY9CAiBSXfd/OwfCqRBYRTC/k8YW/yt520C+z84dXynw8fEqckFuo2h6AZ3M2GMbX1WqQ5Ouj9OqNjBXpMyOI0ncyEN+DVqOR5hAeoLDKABSJWunEXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYeOhx9L; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e904f53151so4217136d6.3;
        Thu, 10 Apr 2025 00:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744271541; x=1744876341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rPgrAp1ioPsOu1pRk1UNApK8KW8zvUTEfp5lJdooVAQ=;
        b=NYeOhx9LBmOwyYgKNvrJqrsUdzmzwAch5tqa/d//poooR6lol7T2c0q5np1/Et8vJf
         y2nNP9rDPuCWNODHFisSTYYgDjGtYk/ITeZv3hXIQ+nYAmer7aHzKPsPJKymmIJ8C8cc
         91sLA51slMs8MuWWgUL1CjZ/9xFA4yp6zlcjQpQKGOGisDbNhT5XWQmeTG422Wy/RsZd
         98kejaAGggLOd+N7UUo2CeP22xZUSgXl7YrOJ3PfBoA5h+ZTckLMP3lZS+2+XyxZU2rc
         BgFOnyEFGph0vdqP7f8Y74pPQ6IrMvhhON4IUtQ1UEJi4bGxOkmCTodkENkdIXHurHT2
         KM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744271541; x=1744876341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPgrAp1ioPsOu1pRk1UNApK8KW8zvUTEfp5lJdooVAQ=;
        b=TcVRS6pO7WMrEn61bHD6+oBgF2zWBGMjyGr36lI4w02fb3vCYYOaBLg+eTSAINAC73
         /be8AVcZEO4EgReTgcnEPBQLQ0f2Dk+wtGZkDxKRpVJxZXpLzX49bSH8CvXRMHHQ49VN
         ZGdpn6REkaOVX5ufvtVUNPRys7gXll3DQP5d7AJ95rnoh/fB0QKC+muGBj7VTPh3gCi8
         TTnXFM7k/MqaSBXcQwBkYMzPW6flKSDXQYA4Sj8hw8UA9hN/4hA6iDtxFZfVYTZAtlzG
         21qwPNqrtFobPnhOGcl4yCKkPYzbh+cuCSg5biRfNKfbOaWbVXPa44WSdMcK0OpyoyGp
         Bo9g==
X-Forwarded-Encrypted: i=1; AJvYcCUm5I2rGhhtIqpl9r2MIu7E3ntZkUAOnh1IFeWTBTv2WChnQBmQiaCZxWPWg8e1SNAXrbCdSzT9@vger.kernel.org, AJvYcCXQAY9yOKLiLo1+YkVjS/dV7MofWWBOiHg26sz9tMZ/6ZQ+uh4mRC7fryPW7QrvA6BUnsOAyjzgqcFpYIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/f1SU/xiiHZZGs89janw8GUVVIzlEmZh//hu45AMgZxNweSzW
	gG74+zknCLg5ZkLYud+lUWv3y1EqE9PNMiMtTYrAdengN/P2DMOCVsYxfZ97NaYyNNW/r+YQQyP
	9Kr8zfknhei3cyTaLFhiUapyIU4Y=
X-Gm-Gg: ASbGncsKU4IqB83043Z3JDq1J1eZS5qb6laEg0Pt8j2hJ1loKsZQJfzKflkv/TFrNQC
	/vL8Tvrm8+JMClKEBjpY5ODw99Upq83L6OFjxw9/iHqsoyh2Hoy8UqATn/Ki2/29svYKhf01oLf
	uiXCs14heudkJCRuBmaHUtQFU=
X-Google-Smtp-Source: AGHT+IGmo10EO6VRBCzkr/4u6V0/nISxHfmr8hPwwCaYWSsM4gVz3GgJIMnBEl9wRop/Dy+dQqdBz+CLv4b6Uj4wcYE=
X-Received: by 2002:a05:6214:27c1:b0:6ea:d604:9e5b with SMTP id
 6a1803df08f44-6f0e75ff30fmr15906146d6.2.1744271540867; Thu, 10 Apr 2025
 00:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250409125216eucas1p150b189cd13807197a233718302103a02@eucas1p1.samsung.com>
 <20250409142011.82687-1-e.kubanski@partner.samsung.com>
In-Reply-To: <20250409142011.82687-1-e.kubanski@partner.samsung.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 10 Apr 2025 09:52:10 +0200
X-Gm-Features: ATxdqUHDXRydohpF4LyJdWYoG0wuyL72TUWel4GcvGw5MasjmOcFYrB_FkNWfII
Message-ID: <CAJ8uoz2DtSGWy3EcQoAUz7BmJW4znAcb+xhfP7rE__Ddy71W9g@mail.gmail.com>
Subject: Re: Re: [PATCH] xsk: Fix race condition in AF_XDP generic RX path
To: "e.kubanski" <e.kubanski@partner.samsung.com>
Cc: magnus.karlsson@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 16:21, e.kubanski <e.kubanski@partner.samsung.com> wrote:
>
> > I do not fully understand what you are doing in user space. Could you
> > please provide a user-space code example that will trigger this
> > problem?
>
> We want to scale single hardware queue AF_XDP setup to
> receive packets on multiple threads through RPS mechanisms.
> The problem arises when RPS is enabled in the kernel.
> In this situation single hardware queue flow can scale across
> multiple CPU cores. Then we perform XDP/eBPF load-balancing
> to multiple sockets, by using CPU_ID of issued XDP call.
>
> Every socket is binded to queue number 0, device has single queue.
>
> User-space socket setup looks more-or-less like that (with libxdp):
> ```
> xsk_ring_prod fq{};
> xsk_ring_cons cq{};
>
> xsk_umem_config umem_cfg{ ... };
> xsk_umem* umem;
> auto result = xsk_umem__create(&umem, umem_memory, pool_size_bytes, &fq, &cq, &umem_cfg);
>
> ...
>
> xsk_socket_config xsk_cfg{
>     ...
>     .xdp_flags = XDP_FLAGS_SKB_MODE,
>     ...
> };
>
> xsk_socket* sock1{nullptr};
> xsk_ring_cons rq1{};
> xsk_ring_prod tq1{};
> auto result = xsk_socket__create_shared(
>     &sock1,
>     device_name,
>     0,
>     &rq1,
>     &tq1,
>     &fq,
>     &cq,
>     &cfg
> );
>
> xsk_socket* sock2{nullptr};
> xsk_ring_cons rq2{};
> xsk_ring_prod tq2{};
> auto result = xsk_socket__create_shared(
>     &sock2,
>     device_name,
>     0,
>     &rq2,
>     &tq2,
>     &fq,
>     &cq,
>     &cfg
> );
>
> ...
> ```
>
> We're working on cloud native deploymetns, where
> it's not possible to scale RX through RSS mechanism only.
>
> That's why we wanted to use RPS to scale not only
> user-space processing but also XDP processing.
>
> This patch effectively allows us to use RPS to scale XDP
> in Generic mode.
>
> The same goes for RPS disabled, where we use MACVLAN
>
> child device attached to parent device with multiple queues.
> In this situation MACVLAN allows for multi-core kernel-side
> processing, but xsk_buff_pool isn't protected.
>
> We can't do any passthrough in this situation, we must rely
> on MACVLAN with single RX/TX queue pair.
>
> Of course this is not a problem in situation where every device
> packet is processed on single core.

Thanks, this really helped. You are correct that there is a race and
that the previous fix (6 years ago) did not take into account this
shared umem case. I am fine with your fix, just a few things you need
to add to the patch and resubmit a v2.

* Write [PATCH bpf] in your subject and base your code on the bpf
tree, if you did not do that already.

* You need to add a Fixes tag.

And yes, let us worry about performance at some later stage, if it
needs addressing at all. The important thing for this patch is to make
the code solid.

Thank you for spotting this. Highly appreciated.

> > Please note that if you share an Rx ring or the fill ring between
> > processes/threads, then you have to take care about mutual exclusion
> > in user space.
>
> Of course, RX/TX/FILL/COMP are SPSC queues, we included mutual
> exclusion for FILL/COMP because RX/TX are accessed by single thread.
> Im doing single process deployment with multiple threads, where every
> thread has it's own AF_XDP socket and pool is shared across threads.

Good. Just wanted to make sure.

> > If you really want to do this, it is usually a better
> > idea to use the other shared umem mode in which each process gets its
> > own rx and fill ring, removing the need for mutual exclusion.
>
> If I understand AF_XDP architecture correctly it's not possible for single
> queue deployment, or maybe Im missing something? We need to maintain
> single FILL/COMP pair per device queue.

This is correct. You cannot use that mode in your setup.

>

