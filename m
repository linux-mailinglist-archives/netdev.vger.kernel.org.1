Return-Path: <netdev+bounces-54740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA0F808062
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 06:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408371C20976
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 05:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F3511CB1;
	Thu,  7 Dec 2023 05:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUuLd1zA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA09121
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 21:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701928342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSUZB2MS9IXq3JbO5o9diZppcpNs8joa8PI6k/pJS1g=;
	b=bUuLd1zAB94Wp3czypK6KO1DTShTcZhE4ZWPboHv4K20/bMl0XIBjYI+hWHcFzkvSElpQb
	6DP4jwMyk0p1Fb/q/KsrEFg+l6STM9SOFKdGP4dHV9ymL40pjvFs0OJ7+pwa5ehWhHa4ZC
	TBwUVQV1rx3f9F8IdI/zNExebeKBo8Q=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-4NPbP9P_P3-up_IIP80TMA-1; Thu, 07 Dec 2023 00:52:20 -0500
X-MC-Unique: 4NPbP9P_P3-up_IIP80TMA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-286a4fc4e9eso716418a91.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 21:52:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701928339; x=1702533139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSUZB2MS9IXq3JbO5o9diZppcpNs8joa8PI6k/pJS1g=;
        b=mOVZdq8Qx9ZWi+hMsbiEfNhzDaSlhqWkHjWXUzLwJ21LJLBKUtcgz4wdZec2uN0U4K
         CMbvqxzgcdRolxasWJTRo2UGy/foMSxau/fHwR5qrQzVH/Mjgh9LxNWbU6mzKiwlBsb4
         dP1u+p54rw7D2mqdgWlWa8fTVFyw7tHd6iMChi3Q2tGfzgsSDdu4vKeUq6AXBnPpZb/i
         gyY5g1X7u2TTYc8cLnIfkWs5Njy4Xur44ijkD/oHIg5wCYbdEEX8o6srX6cOc/MxH12G
         du5O6MkwEyIY8/6u29aTEsPQe3hvgWmrPAbYWekAYiKVdVCH7JJEzSTP5KPHBu12czM/
         CC0A==
X-Gm-Message-State: AOJu0Ywxwh97mRC5+piZzucFiPNkUtTqag5/581/jZY5XOWem9kW3hZl
	iyFLLTIx+L7rn37Arylz2p/hYdKe8LSmMo/sMPFoP/CXDF49SOXO5oilWcdOy3RJ0oMdXrymZb6
	gIdfH9rjP2whko+gpu5koE/Ba6RhpMV1C
X-Received: by 2002:a17:90a:fd09:b0:286:6cc0:cad3 with SMTP id cv9-20020a17090afd0900b002866cc0cad3mr1949088pjb.74.1701928339212;
        Wed, 06 Dec 2023 21:52:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmSjJEJticrA6iI+yH1lm5XAyMtFr/azBvGsGe1XMJiQigUQ9nLH+oU43aD6xf+IguxCTdguGcxA4sxW4hVuw=
X-Received: by 2002:a17:90a:fd09:b0:286:6cc0:cad3 with SMTP id
 cv9-20020a17090afd0900b002866cc0cad3mr1949085pjb.74.1701928338997; Wed, 06
 Dec 2023 21:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205113444.63015-1-linyunsheng@huawei.com> <20231205113444.63015-5-linyunsheng@huawei.com>
In-Reply-To: <20231205113444.63015-5-linyunsheng@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Dec 2023 13:52:08 +0800
Message-ID: <CACGkMEvwG6EvZ3me9ReqA-YSR1Y_6fb_kotT=+PFARaLS1FTmg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] vhost/net: remove vhost_net_page_frag_refill()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 7:35=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> The page frag in vhost_net_page_frag_refill() uses the
> 'struct page_frag' from skb_page_frag_refill(), but it's
> implementation is similar to page_frag_alloc_align() now.
>
> This patch removes vhost_net_page_frag_refill() by using
> 'struct page_frag_cache' instead of 'struct page_frag',
> and allocating frag using page_frag_alloc_align().
>
> The added benefit is that not only unifying the page frag
> implementation a little, but also having about 0.5% performance
> boost testing by using the vhost_net_test introduced in the
> last patch.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


