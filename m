Return-Path: <netdev+bounces-201394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9256AE9420
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 04:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC696A3ACE
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB141FC0F0;
	Thu, 26 Jun 2025 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+0itSvi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40C20C03E
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905439; cv=none; b=dHLa+U9w1TND2syZsASR22Q2DqX1JG45NOPddQm7D6lH5hfNpSYbnfWyyqUg2Y2LN0JRPyZrBAnbsa14iLpjeyA+l4iydwDwa8noIfhcdWkrbIvCJTdwYzXYYNyJB/cGKE0OjkWI4y8g7FsYI0plR3sMNtj0EC14gmI0V6srUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905439; c=relaxed/simple;
	bh=e5C9qrU3fsOpfaDgADgkrynMWd5GzhKtqGQzdriNJ3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pasT++0yFHxCcnTZzkFQ7fPzYZQIKomixAHy89OjXE+WqqxuGqILpY9uiMkLCgYGO00JETSRJ5He8UqiGcGTDjbX83K7zn7gAda5C369RtGA5XScleEpH3JyV4mEZ4sLak5TLRbo776SM7WBfKgQJK7FrDNQQbfuRnnEAfVb6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+0itSvi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750905437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EW+I1QQIKlTT7W9a4yuMAmimMoHXfs6dlaepoS7uBM4=;
	b=L+0itSvi7S7RE2UyumHfj9k9c+e6ns43ANlRJb43K9G8m7BWEbPa0KNkk5Mky63WrEfNO6
	p7hc/i10cJJY3C9hhNAN5qnrA/ftV6J6yBkmw5CUsfwGnjCSP1aitRTFktHpHGWSVXEeTj
	YsdLNYMAA2yoAWIZyBsAA+cyorm1svU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-OTSr5kpxPo-yj9L2wJe0Kg-1; Wed, 25 Jun 2025 22:37:15 -0400
X-MC-Unique: OTSr5kpxPo-yj9L2wJe0Kg-1
X-Mimecast-MFC-AGG-ID: OTSr5kpxPo-yj9L2wJe0Kg_1750905434
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-313c3915345so673242a91.3
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 19:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750905434; x=1751510234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EW+I1QQIKlTT7W9a4yuMAmimMoHXfs6dlaepoS7uBM4=;
        b=IgBaNS9m5yJmHxxvnrmwdlYtyzXdsBj/kVxUG5gug2m2xxgISKK/asFTnMvfNPCdFd
         KEVgbmYpehk4hQjQSqjXZHKR70iloBziJRn5Zi8PDiHSSVAdU3ugGUsMVh++bGNFHBv4
         bjZiJt5+3+mboSEc075HDew/YF2D3i3NCS1DolWPl1lmZkUHTUInGtDwazj8FrKLxzU1
         aeg8/zHdGxQj9KLMhT1CvzmHzSmVKfd7aL/K2d7nOSTkeuQKsMXp7frGArdqRQW0OlBa
         4Vx/NU0nyS//6UfhbuXfB3wUbPTPbqs8PoavSTmg1fv84Jd6hg56U06sW1Mb0v27DEsL
         X28A==
X-Gm-Message-State: AOJu0Yysmgt2a4pniqstDmdNVG7mHmCDiYzxRFAM09bEzKZPW33n/ktQ
	vuw5liheNKZfYNwBLLG8Yh6rvHtMdnK1dz7fbuvMhq+61/d9j8LUAYTbffe2zAieeIB4DFVkzPw
	njn0DwouXEq2B3GQCyHTx70Nkly3NCGf/WSA2fJiHlu8ibtn6w81GQ4TPLSvb8sn1IiY9h/QahV
	PlWQwVXw54ZXSjhMgel9QiX9RXgErl8Gav
X-Gm-Gg: ASbGncunDbudvr5oybSjqQydqeRpxZ9pHtEdcR3KIffkXlV9UoXuxvp5UFt1e5xBYvv
	WqXo7cNqWOJ+baNl36SLVstM5/HEhBaDaVmMg+4va8nO6MHK+0nhlWzW3ZItbNfOeEd/tmstQI3
	MO9bs2
X-Received: by 2002:a17:90b:2b4c:b0:313:fb08:4261 with SMTP id 98e67ed59e1d1-315f269fa56mr6541990a91.32.1750905434009;
        Wed, 25 Jun 2025 19:37:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnFq27uptoJBVoGMseNGObxmjNsAzQWtsl9oanE1SD186q54jLA9zURCaRw/XaQvClcZpVeAk2VlfUN6l6Dn8=
X-Received: by 2002:a17:90b:2b4c:b0:313:fb08:4261 with SMTP id
 98e67ed59e1d1-315f269fa56mr6541958a91.32.1750905433553; Wed, 25 Jun 2025
 19:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com> <20250625160849.61344-3-minhquangbui99@gmail.com>
In-Reply-To: <20250625160849.61344-3-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Jun 2025 10:37:01 +0800
X-Gm-Features: Ac12FXzafcvLIIRlWLmpr_5VBnu8UJoZzPPLlWXuQNGXda7Uc4uun2EikZbgBz8
Message-ID: <CACGkMEuZTP+xPCWuSGwiApWEj_PuOxb5yOeR3t-Bga1t+svawQ@mail.gmail.com>
Subject: Re: [PATCH net 2/4] virtio-net: remove redundant truesize check with PAGE_SIZE
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> The truesize is guaranteed not to exceed PAGE_SIZE in
> get_mergeable_buf_len(). It is saved in mergeable context, which is not
> changeable by the host side,

This really depends on the security model.

> so the check in receive path is quite
> redundant.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2a130a3e50ac..6f9fedad4a5e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2144,9 +2144,9 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>  {
>         struct virtio_net_hdr_mrg_rxbuf *hdr =3D buf;
>         unsigned int headroom, tailroom, room;
> -       unsigned int truesize, cur_frag_size;
>         struct skb_shared_info *shinfo;
>         unsigned int xdp_frags_truesz =3D 0;
> +       unsigned int truesize;
>         struct page *page;
>         skb_frag_t *frag;
>         int offset;
> @@ -2194,9 +2194,8 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>                 tailroom =3D headroom ? sizeof(struct skb_shared_info) : =
0;
>                 room =3D SKB_DATA_ALIGN(headroom + tailroom);
>
> -               cur_frag_size =3D truesize;
> -               xdp_frags_truesz +=3D cur_frag_size;
> -               if (unlikely(len > truesize - room || cur_frag_size > PAG=
E_SIZE)) {
> +               xdp_frags_truesz +=3D truesize;
> +               if (unlikely(len > truesize - room)) {
>                         put_page(page);
>                         pr_debug("%s: rx error: len %u exceeds truesize %=
lu\n",
>                                  dev->name, len, (unsigned long)(truesize=
 - room));
> --
> 2.43.0
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


