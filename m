Return-Path: <netdev+bounces-133817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF84199726B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DF2281264
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCACC1CACDC;
	Wed,  9 Oct 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNp3E01P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E84522098
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492922; cv=none; b=j+eTE4qGtKDObtw1Hw0stFvgrx36Xklz/Aq2ajofVf9hgTfIOP87VErhDDR9gXr5BN7t5uZOB3Nx8WllSxNiy6iT020ayafF6UcRzt9KlM8yDj2DE6d/8QXW/YAOzjlLqw6yMhLNLgxQS+ntXzPBJ/tS+9BLKcgW0mKVmlvV3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492922; c=relaxed/simple;
	bh=0PJsXBoEaFPWaUIm0ZVeqQpC6ANbFMULHizJJdTycWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9a7G6jRxYA4WHGTktrF0tCgnVmhmmgZtANj3uA7VPEsRTQYjiR+C0lT0qrJzCKMGuo1xknrI2asfHmkKU/XEiOvGdkmnA6sH3rst/D74uJ4SxJADiUKw3ftGKwsfS7YePKQiIMJFJtyW3MSxUYBicRuN2fLh1FmgIkY/ZUGaKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNp3E01P; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4601a471aecso4601cf.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728492920; x=1729097720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cC9l2viWn9IDaL1bo4zr4cF3h0+KvuGEH5ImtIhCJaY=;
        b=jNp3E01P9OOGOwiht7Vjy1ICpZQuCz0wONsjfKirqNOl1hZNWDhGETMgfAAXIjpXlT
         l4Zb07RqZhmgTF0kGMYQsPItKuupcQ85NCBsOLOoF5SrRzOSYUz4XmklCk41vBpMLNB6
         dvwNB4L0jRtXF7SNsAJlYQRngcMZOs3vsHzql98KCT2YcE6A6v5jmKoIgiVqy7rThqb2
         NfFp0xoAyqfCa7ZCsmiGkogLUxbd1Q7OnbEpkj/O3wxmVekZSo3hxkuL5dSedHrNkm+8
         4+MqjAL+GEO1sYPC3uAKPSn+GrRJT06UnGXRZzFeQSmLLMmwxLMGs6jVPdqvap5IhRBy
         NVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728492920; x=1729097720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cC9l2viWn9IDaL1bo4zr4cF3h0+KvuGEH5ImtIhCJaY=;
        b=O7xT1aMYBvuC46zknm/x/eojzKqTjFwx1SlPHxpxyJpOI+7iDQgpczgixl2NvOuC0N
         0kXRITEO/WbOAb2D0n+HrHF1GAL9WXJSdkE9fMjUME1XkVlvVtmOqmb7Qrw79ZHVKDIO
         UeXa1b7WozqWeTiaN4/57KQCnM9YA8I+tVjaw2Uibd5hgJ427VuQNJYY7E52rysYVBIs
         To3sqAJV8Q+uHwJQJRESaWbYDCs+sI9L/prmR0vH3hS4bp23sNAoGGKpnkIsHFzZriLR
         USI9oYJRp6aacrpZT6nm2itLpXsGW4zH1CBAdeJUTtAuJC4C9g68sKYZKm2RegEryJcM
         DgVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLR3ycL9tUr8PUrBxp7w+MfgSzQSVbkIMVwS/sguhgR/zcHc+kkcINYek1Z5EabxYp3sp3alE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywquEzWlpRGvxoWKiih0dzo8x0DRtri5caDR079V1jca18lQML
	zVB31/f/GLpvjEbilKfNyJWhOeN3T7SzgxnfYwTK+4QEzMJfip6SVBIxnQF1TgrBXE7aSFD8SbF
	MZukZ0UFhdCY5lyFiLLz4vzeByG+hPuHLUNHj
X-Google-Smtp-Source: AGHT+IGknZDI0RIp9MDKoXJAV6z0wE1VaL9uWwnuTElyN5zkmvIS2AgQuEsjlf3A2gyxYwGAY2phdL/NBRpuRyxc1fo=
X-Received: by 2002:a05:622a:2a1a:b0:460:371b:bfd9 with SMTP id
 d75a77b69052e-460371bc52dmr2795741cf.5.1728492919806; Wed, 09 Oct 2024
 09:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007221603.1703699-1-dw@davidwei.uk>
In-Reply-To: <20241007221603.1703699-1-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 9 Oct 2024 09:55:06 -0700
Message-ID: <CAHS8izOv9cB60oUbxz_52BMGi7T4_u9rzTOCb23LGvZOX0QXqg@mail.gmail.com>
Subject: Re: [PATCH v1 00/15] io_uring zero copy rx
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:16=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> This patchset adds support for zero copy rx into userspace pages using
> io_uring, eliminating a kernel to user copy.
>
> We configure a page pool that a driver uses to fill a hw rx queue to
> hand out user pages instead of kernel pages. Any data that ends up
> hitting this hw rx queue will thus be dma'd into userspace memory
> directly, without needing to be bounced through kernel memory. 'Reading'
> data out of a socket instead becomes a _notification_ mechanism, where
> the kernel tells userspace where the data is. The overall approach is
> similar to the devmem TCP proposal.
>
> This relies on hw header/data split, flow steering and RSS to ensure
> packet headers remain in kernel memory and only desired flows hit a hw
> rx queue configured for zero copy. Configuring this is outside of the
> scope of this patchset.
>
> We share netdev core infra with devmem TCP. The main difference is that
> io_uring is used for the uAPI and the lifetime of all objects are bound
> to an io_uring instance.

I've been thinking about this a bit, and I hope this feedback isn't
too late, but I think your work may be useful for users not using
io_uring. I.e. zero copy to host memory that is not dependent on page
aligned MSS sizing. I.e. AF_XDP zerocopy but using the TCP stack.

If we refactor things around a bit we should be able to have the
memory tied to the RX queue similar to what AF_XDP does, and then we
should be able to zero copy to the memory via regular sockets and via
io_uring. This will be useful for us and other applications that would
like to ZC similar to what you're doing here but not necessarily
through io_uring.

> Data is 'read' using a new io_uring request
> type. When done, data is returned via a new shared refill queue. A zero
> copy page pool refills a hw rx queue from this refill queue directly. Of
> course, the lifetime of these data buffers are managed by io_uring
> rather than the networking stack, with different refcounting rules.
>
> This patchset is the first step adding basic zero copy support. We will
> extend this iteratively with new features e.g. dynamically allocated
> zero copy areas, THP support, dmabuf support, improved copy fallback,
> general optimisations and more.
>
> In terms of netdev support, we're first targeting Broadcom bnxt. Patches
> aren't included since Taehee Yoo has already sent a more comprehensive
> patchset adding support in [1]. Google gve should already support this,

This is an aside, but GVE supports this via the out-of-tree patches
I've been carrying on github. Uptsream we're working on adding the
prerequisite page_pool support.

> and Mellanox mlx5 support is WIP pending driver changes.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Performance
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Test setup:
> * AMD EPYC 9454
> * Broadcom BCM957508 200G
> * Kernel v6.11 base [2]
> * liburing fork [3]
> * kperf fork [4]
> * 4K MTU
> * Single TCP flow
>
> With application thread + net rx softirq pinned to _different_ cores:
>
> epoll
> 82.2 Gbps
>
> io_uring
> 116.2 Gbps (+41%)
>
> Pinned to _same_ core:
>
> epoll
> 62.6 Gbps
>
> io_uring
> 80.9 Gbps (+29%)
>

Is the 'epoll' results here and the 'io_uring' using TCP RX zerocopy
[1]  and io_uring zerocopy respectively?

If not, I would like to see a comparison between TCP RX zerocopy and
this new io-uring zerocopy. For Google for example we use the TCP RX
zerocopy, I would like to see perf numbers possibly motivating us to
move to this new thing.

[1] https://lwn.net/Articles/752046/


--=20
Thanks,
Mina

