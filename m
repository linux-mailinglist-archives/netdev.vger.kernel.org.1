Return-Path: <netdev+bounces-59081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 731E3819492
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 00:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA56A1F262F5
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 23:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6873D0CB;
	Tue, 19 Dec 2023 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dOwqhfMd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D840C08
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so58292915e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703028301; x=1703633101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jJtlAviAEqHUpEmCol6f8oT3KPiB6Zv+60pl+WH7WI=;
        b=dOwqhfMdQOytMtZlgIuP6QAkWd0QTM3YgDYtUWtsW5l5OItR2INN6EF4pqfBE7wQnI
         pj6dhAG0Ge7rHvx15eis+ppXNc+NZZkfCmCkFGw6N/XngxVx2YYyb7j4rcIsd3okCJtA
         tZrFq8Q556HhzdOU1ldh2gCKI/HJYFmQtSMxG6CbgZ6gkYUQaItau3VSRokDfO4OfTv5
         9vn1PZwSfUVW/pzlLGdSCyHSvROiKEh9BKRAtRAo6b7wgKadh9BC5w9ou+4c2RS1zJrm
         D8elByty0Ht17/O0F9xnguO9iCODCvH34CvXA33dYoFofuUlNJdrfeHcTJ2nss23woQL
         TVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703028301; x=1703633101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jJtlAviAEqHUpEmCol6f8oT3KPiB6Zv+60pl+WH7WI=;
        b=DSbf+GamQkaCaA1gvWar0xt6s3M5873XPgxG2LWf4quVowQ75v/kszMD8OGG+mS9JV
         7WC36RIXh2g/a2F9MzoFadabvNnuKKJw/H/g7yj9gQBoa+VWPe+MY+jrQyYK3W8f6cDV
         OrlJBK3JAVz5MgshbVcuFTLPL0V1r0SHtRG1JSOsT9Q2x38jadVrLsStbemUQUplcOzt
         OXBETVOX6GtniqroyPnPczMEj27cbE21JTikgoGtFEx5Ulle4SZajvxwZlC2U62e9W0D
         rXSpZv+D9QZKsVBW4b9bQU9/i730QjZKA+2aAxuT4cYlUNrid5hZkigKQBC2+2GEp7qD
         Q3Sw==
X-Gm-Message-State: AOJu0Yx8DLprSGqrz6UFgL4uly6ng4tDWICKBGVR0B+la3jRljYMj8b7
	ddoXlcCltpWby2HPMo9KNaKRYLwE6UL8QsQ1B84mwA==
X-Google-Smtp-Source: AGHT+IGjyS8owAoubjnIHkRSsr3sANlRTRlkbfa7qjlypkLg+bw8Xx0wFu4y2R2AfChr/ivDqYOL0QFZ7rhMQeNaPq8=
X-Received: by 2002:a05:600c:ac6:b0:40c:310b:b694 with SMTP id
 c6-20020a05600c0ac600b0040c310bb694mr4396321wmr.333.1703028301270; Tue, 19
 Dec 2023 15:25:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219210357.4029713-1-dw@davidwei.uk> <20231219210357.4029713-3-dw@davidwei.uk>
In-Reply-To: <20231219210357.4029713-3-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Dec 2023 15:24:49 -0800
Message-ID: <CAHS8izO0ADnYqKczEkfNts2VLDfiYEkQ=AzJ-xzb+Kh2ZpFjbg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/20] tcp: don't allow non-devmem originated ppiov
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:04=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> From: Pavel Begunkov <asml.silence@gmail.com>
>
> NOT FOR UPSTREAM
>
> There will be more users of struct page_pool_iov, and ppiovs from one
> subsystem must not be used by another. That should never happen for any
> sane application, but we need to enforce it in case of bufs and/or
> malicious users.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  net/ipv4/tcp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 33a8bb63fbf5..9c6b18eebb5b 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2384,6 +2384,13 @@ static int tcp_recvmsg_devmem(const struct sock *s=
k, const struct sk_buff *skb,
>                         }
>
>                         ppiov =3D skb_frag_page_pool_iov(frag);
> +
> +                       /* Disallow non devmem owned buffers */
> +                       if (ppiov->pp->p.memory_provider !=3D PP_MP_DMABU=
F_DEVMEM) {
> +                               err =3D -ENODEV;
> +                               goto out;
> +                       }
> +

Instead of this, I maybe recommend modifying the skb->dmabuf flag? My
mental model is that flag means all the frags in the skb are
specifically dmabuf, not general ppiovs or net_iovs. Is it possible to
add skb->io_uring or something?

If that bloats the skb headers, then maybe we need another place to
put this flag. Maybe the [page_pool|net]_iov should declare whether
it's dmabuf or otherwise, and we can check frag[0] and assume all
frags are the same as frag0.

But IMO the page pool internals should not leak into the
implementation of generic tcp stack functions.

>                         end =3D start + skb_frag_size(frag);
>                         copy =3D end - offset;
>
> --
> 2.39.3
>


--=20
Thanks,
Mina

