Return-Path: <netdev+bounces-141109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F889B9949
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 21:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2360C1C20F6F
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 20:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FC31CCB21;
	Fri,  1 Nov 2024 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+eqrW5s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2F1D9A50
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492214; cv=none; b=KxRUp99udZpQqcJUOrg3yJtgV50i4/3qO0RZn+InalQ0DJCfEULOamnCgPwV3hkQ6CqZMLPmumgDL9AoHYXsHvA9t9JI9oVu3NRst6C2tvdEMW3UY+hGDv22vIIWlSvJdIDrZj896xoQ71iBBihkCWzGage4TXGNDnHK3srC27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492214; c=relaxed/simple;
	bh=Neq2taM8S5zc3+C2OTWpu8fNI6E1Ypyk9B14+qIRqyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INoNJqyK0+cLRqnqFg/oz2l88IlMHhrPIvMfUdkvDPe5rS8dzx0LYvc66QfNZEcIXYvOwZy3cLWmZd3jc+9JeB8rsduzbIROYaIjUicZI5o0o9jsEQTqAICrWIinAaqFamrQKYmX0/n9GzhnL6+HdSkXHyI7iHobk81s4avC+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+eqrW5s; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4608dddaa35so76831cf.0
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 13:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730492211; x=1731097011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0pmXdKRRehOTDxxZcS9Rlf0z5oyVOgg9mgnJxfzU+4=;
        b=G+eqrW5s8586h2weWLiXdnwb3dkkfqyEejh9G/JQDjpfDjh3fQ54vmQbrVTwwtMkPg
         FlLO7qlahLANtJmy4U+uSZeYlgzEHHmwxNzg/0+GGt8iKuNDRGvqBvKf9mQAVwO0j+0o
         P70AOqClXEbXtsEP2WmIbnFPoQLla6hx6dB5mRRTrkRpkfYlc9zN1wDEvGeP0V+al/Eq
         p2nGgyIaULRRdmT5O5Sm7P4/aF4PWCyybQ1etfOEp3I4AXVqaQXAVWBpEA+uuDw+qhxG
         W0DcX4L9YT2446ZTjG54sM4O70H9IO9TyApjv8N19bYZS6xxWvpu4BCB6z6vnOOMVDd0
         5ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730492211; x=1731097011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0pmXdKRRehOTDxxZcS9Rlf0z5oyVOgg9mgnJxfzU+4=;
        b=QNN13DDpHg16nQiGYjsigIIR2MEsNYreNYHTSjt2rZ7X5h+WLjFshFGVkd8Q7oICZe
         3OnIn8NJgg/z+tNAhQ3pjTgViL2RWlEWKSzlAbJYtVvFEF6l/C+kjhlF588MNJ4Wsci2
         ynOP9qRoQud8PgjKRriALtk9og9ewVXUp20eBkAEDRrw0Cufbe0bThijrfa/yO8bV0Ec
         spjHhmHNArRLSOozabP8T0Gn0Mv7SMFrLTC3NcQzcTrduvVoHtDgKiY6Dtd+qcrg4L6G
         TfidgoeSa/rSt2DCk/+3buHfesyT6i0QUQQDOvoZrt7aiBDJfLJvNhEX0zNf1u2DJ5xW
         pEDw==
X-Forwarded-Encrypted: i=1; AJvYcCXvm5DP0BUh0lmdWV0HBrwfEVC/4S8XhVQLO0V/7jqwUrDdleZ3FBCsuHdT/2vRIjGbiRkTmw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKCwNNaddKlf9B9fBjnICBHYZU5Ht/6eeP9g3QLQB/8/RPIk3J
	mYzh2BacnCMXPgOCH7LsKWe4kx3rDH+ujvBZtF0VTUJn0eHemFyNPvbndxAm9UeBdZPJ9Ig5vyY
	igWU0YyRJPzTslQK3NDGu6O/X2z0d88o5qqfa
X-Gm-Gg: ASbGncv53jUlSJ1bAm/Q8dlB4GUh39ODUzufX5M6R+IqHYeaQkvEbOTzH5QAxN3vpb4
	O2Lf/hNK7Wk2UL8ziZiNjAaDwjzTzqOjV6qI3pYgxcMBp2tg7Xq92nhEt9EWFfw==
X-Google-Smtp-Source: AGHT+IGQlnMovoi5lGZ5r+xc2iOTrOWS9RcVERrIUE0qklnzO30h74p7/gLLkEvfHRWyOdgZxsJcaMWekAkfadGD3mI=
X-Received: by 2002:a05:622a:4e9b:b0:45f:89c:e55 with SMTP id
 d75a77b69052e-462c5ed23c0mr637391cf.8.1730492211131; Fri, 01 Nov 2024
 13:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029230521.2385749-1-dw@davidwei.uk> <20241029230521.2385749-14-dw@davidwei.uk>
In-Reply-To: <20241029230521.2385749-14-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 1 Nov 2024 13:16:39 -0700
Message-ID: <CAHS8izMFV=1oRR6Tq-BVJxCL3hbEjNa0CBzWmWxbnk_0MZOs6w@mail.gmail.com>
Subject: Re: [PATCH v7 13/15] io_uring/zcrx: set pp memory provider for an rx queue
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:06=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> From: David Wei <davidhwei@meta.com>
>
> Set the page pool memory provider for the rx queue configured for zero
> copy to io_uring. Then the rx queue is reset using
> netdev_rx_queue_restart() and netdev core + page pool will take care of
> filling the rx queue from the io_uring zero copy memory provider.
>
> For now, there is only one ifq so its destruction happens implicitly
> during io_uring cleanup.
>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  io_uring/zcrx.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++--
>  io_uring/zcrx.h |  2 ++
>  2 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index 477b0d1b7b91..3f4625730dbd 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -8,6 +8,7 @@
>  #include <net/page_pool/helpers.h>
>  #include <net/page_pool/memory_provider.h>
>  #include <trace/events/page_pool.h>
> +#include <net/netdev_rx_queue.h>
>  #include <net/tcp.h>
>  #include <net/rps.h>
>
> @@ -36,6 +37,65 @@ static inline struct io_zcrx_area *io_zcrx_iov_to_area=
(const struct net_iov *nio
>         return container_of(owner, struct io_zcrx_area, nia);
>  }
>
> +static int io_open_zc_rxq(struct io_zcrx_ifq *ifq, unsigned ifq_idx)
> +{
> +       struct netdev_rx_queue *rxq;
> +       struct net_device *dev =3D ifq->dev;
> +       int ret;
> +
> +       ASSERT_RTNL();
> +
> +       if (ifq_idx >=3D dev->num_rx_queues)
> +               return -EINVAL;
> +       ifq_idx =3D array_index_nospec(ifq_idx, dev->num_rx_queues);
> +
> +       rxq =3D __netif_get_rx_queue(ifq->dev, ifq_idx);
> +       if (rxq->mp_params.mp_priv)
> +               return -EEXIST;
> +
> +       ifq->if_rxq =3D ifq_idx;
> +       rxq->mp_params.mp_ops =3D &io_uring_pp_zc_ops;
> +       rxq->mp_params.mp_priv =3D ifq;
> +       ret =3D netdev_rx_queue_restart(ifq->dev, ifq->if_rxq);
> +       if (ret)
> +               goto fail;
> +       return 0;
> +fail:
> +       rxq->mp_params.mp_ops =3D NULL;
> +       rxq->mp_params.mp_priv =3D NULL;
> +       ifq->if_rxq =3D -1;
> +       return ret;
> +}
> +

I don't see a CAP_NET_ADMIN check. Likely I missed it. Is that done
somewhere? Binding user memory to an rx queue needs to be a privileged
operation.

--=20
Thanks,
Mina

