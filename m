Return-Path: <netdev+bounces-218347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B22FB3C0D8
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CECD1621A2
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1567C32A3C7;
	Fri, 29 Aug 2025 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHnRz+cj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A631B13D
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485283; cv=none; b=r3Vo5NIM8stsTltamGYaQmqDn1W3D4ah+p52tKkO1LQ3AV4INfzan2k6U+AIqZEeG8EmXbkRpec2K/a2Lfx0RGfNKxs9kjVjymBtfJ58BqmWVAESo4f9p/x9zE2zdcdU4uu8upglFT7o8BCLrMRolEY+VJ4+PvKQ9ymdMgFuzh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485283; c=relaxed/simple;
	bh=w02vc4ZIN2Yf79bTdKCIFILkHtJW+xpLkB9Df766SjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr53wJlq0zP5c0MMQxyRqqqra3YPkBUs1MLxVnZISbIqHJFcv3zlYrdzgK+cO9VOTJ4A8mcl5zoGkb85eh7vGwSos5HmFdw/KpIiLmXZtGqvYJcyhin5JwAx814kgH/iqfTyBRRId97bNtA+R9sXwmZNHBHuZJd0JMdGqf5lHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QHnRz+cj; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b30d24f686so12512651cf.1
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756485280; x=1757090080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJbh/xt21xx/+x2x94uAOCLVyNPUW7zvmYwO/H9Z7jc=;
        b=QHnRz+cjDY/mgKzxuPt78ZpNXWVfWbziHFV3x+bLHOnFVW7LXESld6sTynR1q6r9g8
         XjbE7Ix9bss1axAVYT0i3i75BwS6MuZ8kc0GJeIcH3hD9J4nMimogA10AhUL2h6I3mR3
         LHVsFcxZPWOf3kpLY6o33yMjUfZAtvdJgtDuKEoL7KJo5wqw9Fup0X5jsxqueKxzFmkf
         8SuMiLvQvPCXCYdW8IqvJbc4+53WlURWqFyCrAqURH4WgymhGTcbx9ydHYR161QMSmBK
         kuXg+GJOY8HAV0+iDW837t8FXKfY4/yjEXJjMGCd55FOrs9AmvpbLjtPnUgGuUFieRJo
         H6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756485280; x=1757090080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJbh/xt21xx/+x2x94uAOCLVyNPUW7zvmYwO/H9Z7jc=;
        b=PZLjWXfrUEzp9BC1pqlNjOKN3fNxXr/PnZ/QVbOE6r5V2uQQaEDn57FLuae/sKt1dH
         5oj9C7IAdzEZ1LVu5SW6vILPUQ/VRpKJyJPENfd9dibM4ugi+LcbTq7RT5LM/rtcnpTR
         LcfwAR1I9St5dQGqW5l2mT74e9GBzjyiHbNCzHWkig+0fkbThQONsDYJdyEfEJKPqHIB
         M9sMgYp8TemkT+iVySvTDfQ0pIXRQDabsYijMB+9XrLgcTOpGtgh56jIOOigKZRmo4yI
         +a4yynjfwJ8hsu0spoSxlAEjhoHe4ORaSxh0i5oV5SBUwC9aqA5xLhXoDmNot3IiozyH
         vuYg==
X-Forwarded-Encrypted: i=1; AJvYcCVaX1Pk47kJfNzWQRVcbGAa2PqJIk4E0f+m6t656EJM87dxGZaTElbG7rR5vq/Cyg90ipoJ2P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVztbE7cqJriMg+VE1LjPIt2FdC+ATVLujLjk3SqSu9bce0Hnf
	bu37ycByNkYHYbJYc6roEDIzTQS9ohQTPNzc4cPcxBSpOcPmXe79o19EZ6uU5oqzu4mxrYwgv7r
	5SGKkzTNlo1MMFFTkRQR2wei6FFQEqrfDyPrWYQmj
X-Gm-Gg: ASbGncs7vs04ONaZ4JSHPs2u+PQahFidRLQmoz1ZY4yMgapVo2TVSZ/JLs9F46/z+20
	0/+vJcZ2KWk9lrVVcqFZgoCFMF7DwabVYUCz//VbxwcgXyP6PMnkktPN/IFL4cDM1Bal7T1gKmb
	qrflOC1syPFI8XzSlnGY4UZH+OdH7MrS19ftb27IhMtU1yU5O3hzYuUWeTylqH3Uvk5hFkHNBL4
	wofTP9/RCcFeC1BoNPbz01wvonBLzCW81Uaz1MK+tTqs5cBmLZTXrvMnqo=
X-Google-Smtp-Source: AGHT+IENd4Z0R9bs0yr+ss5hcDT2iTdZpCbQuWcpSCFPXVpeEPiccjbKYZO4LaH+miGYLmYc3pfD6qG5WCFK1qvIYh4=
X-Received: by 2002:ac8:58cf:0:b0:4b2:fe63:ae03 with SMTP id
 d75a77b69052e-4b2fe63b804mr87346471cf.22.1756485278738; Fri, 29 Aug 2025
 09:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-2-bfcd5033a77c@openai.com>
In-Reply-To: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-2-bfcd5033a77c@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Aug 2025 09:34:26 -0700
X-Gm-Features: Ac12FXzW_w7AW6j0jAtk0R2jBActMK4XmdvL7HZnq7aTeIkGOtaz1bYi8RYYyM4
Message-ID: <CANn89iJbbqCvTWnaWgRQd1KEVveaPL+qLPfsfNkCrDFenAjEgA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: cpaasch@openai.com
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 8:36=E2=80=AFPM Christoph Paasch via B4 Relay
<devnull+cpaasch.openai.com@kernel.org> wrote:
>
> From: Christoph Paasch <cpaasch@openai.com>
>
> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> bytes from the page-pool to the skb's linear part. Those 256 bytes
> include part of the payload.
>
> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> (and skb->head_frag is not set), we end up aggregating packets in the
> frag_list.
>
> This is of course not good when we are CPU-limited. Also causes a worse
> skb->len/truesize ratio,...
>
> So, let's avoid copying parts of the payload to the linear part. We use
> eth_get_headlen() to parse the headers and compute the length of the
> protocol headers, which will be used to copy the relevant bits ot the
> skb's linear part.
>
> We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking
> stack needs to call pskb_may_pull() later on, we don't need to reallocate
> memory.
>
> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> LRO enabled):
>
> BEFORE:
> =3D=3D=3D=3D=3D=3D=3D
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.01    32547.82
>
> (netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52531.67
>
> AFTER:
> =3D=3D=3D=3D=3D=3D
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52896.06
>
> (netserver pinned to adjacent core receiving interrupts)
>  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    85094.90
>
> Additional tests across a larger range of parameters w/ and w/o LRO, w/
> and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
> TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> better performance with this patch.
>
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

