Return-Path: <netdev+bounces-163244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E18A29B01
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DAF1883713
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B552212D68;
	Wed,  5 Feb 2025 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQMkzJKl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B420CCDD
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738786464; cv=none; b=ru6IpvwX5tP4XsG8AdLZuar68SJ4GT9bWz1BpP72/j+F7lput43Q2iBBi6on1cLsdpTcAxRxipSbKN+ArTy9jJEAaKpOwADk3kydEv3pOawICzy3GwM27GELhaIx12+D2yncwx3cHIhrDPJnx1pDhna0vZ17npcqJ70uh2lUJlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738786464; c=relaxed/simple;
	bh=5paWUhXR1rOAMff3mPwld/knPMys5QgirJdpEwaSp8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbUhNiYQQmJrQApNsVOhcZ6l/gW7aEJRJJrfUr/OW9fpYex+BfYCo/w0z1bEAdBJQSJ3Fs6qgrwX9HfC+DsAzbQuWH7VAAjkeMSeg0nBlDhqg7/x2Jmy9e1Ew/7D8//o8ozurGUVM/7FBKH/oIXsdF1Ronbmy2FK2Ck8RMSFTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQMkzJKl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-219f6ca9a81so24405ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 12:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738786462; x=1739391262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aykfFszNEUjgkYynV/1gVqvefwgRmwcsH9OuhoxV/A=;
        b=GQMkzJKlOTEJntl2Yc1vFs3ZpynBO1C0jHg8MJDyRaPbN/WXYSQEMBBc3DzeasA6oF
         inzfpoqAv9LtDfR4On8In8fs8sM5wa95Nf3sQQJHVmykuzUnJB8M/51lpEMjbxRJcKLR
         ARj/UiVVtGxfbYfP6TnkuJ4MOPX8450yQqN8OoPKd9shxa4XmlMcZ2b9ndkZG+nBorkh
         ff54sPAyrbEHSMEU7w5B3wvO/scj3XB4CScHi37NXtaMir706Hw8gb+MWrrKmmqZYHU5
         iElGQyFaqJ05ydzRAaLY5B0RUT0PfX5XrzHkbaRyBTYNTPEMqGXVuUNYF17ajZqmSV3U
         bZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738786462; x=1739391262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aykfFszNEUjgkYynV/1gVqvefwgRmwcsH9OuhoxV/A=;
        b=Tl+eXasKf86HAcRfMhptIRkvqmq/gYcoBfIcPgK9LtELEzRnNJrrTB7PjWxtLjEWbU
         Og0k2oAMzfBJ5ceiTvBVh2uosBFMH1xUopPUO3nEye2ktbaOq9e4kj3JZ/qhGapL2huM
         MGEwaEfmeBOCdyaWbdgc7gaVMieNarWpq9e2VFxXH6LkIGfosZYyfa69pr/bwA4lHzny
         pSJq5pUD1blQWJYrsHcqczoS/+FeRA5fC7FzJTnBk+6hkIvLyoBKRxnjJ72hth2n6QcN
         xfwO8m+cUmq9nDVJVMffMpyCkhxUfsa5p7zciHV3pIiM0kH9utFfR0SH75EwRmQlv2fO
         T9aQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4aUvIl4uad1HDA+EGdG3n2t40nVigIjF4Vn5LhD9Hfpa0n73n0Ob/8OK5rqRV59XeUTaDeYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7qkWnHmiBpapiIeCeN/ZJin4Wmq5L3WGSH04kTPjT5UBBUlS/
	oXdJ2+vdExIBR+6fATfzW+VmFMjVFt0Np0ElpK2Xp75UgxV8SH674CNNzG0/kypvru26leUGQYR
	G1D5Ir5IxYtp2VviUtQWA9Z7dbkUZIt0ZWeYx
X-Gm-Gg: ASbGncsFPn0oOMOh3Q4q0X+V5gPhD7XTRbfo+8PgViJB4+yYqVci4rBazOwfvhdlVKL
	6LFT5JPHyKhaUD2+r3lp//8YLtVW9QDlmb6NQOzN5Z+PNpS46vd31TVZ6ExFLXYZ0pMNGk1Al
X-Google-Smtp-Source: AGHT+IFJL2drsEsHnij5iaeW4ADSn+VN61Jmiapuz2mjIAGBoHqmz6hdc7oZYk31AJFjYJBMNipNVpGLALhIAHJ2BIs=
X-Received: by 2002:a17:902:d9c6:b0:21d:dbe3:fc48 with SMTP id
 d9443c01a7336-21f30334a32mr333785ad.28.1738786461682; Wed, 05 Feb 2025
 12:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116215530.158886-1-saeed@kernel.org> <20250116215530.158886-8-saeed@kernel.org>
In-Reply-To: <20250116215530.158886-8-saeed@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Feb 2025 12:14:08 -0800
X-Gm-Features: AWEUYZnEltJTKqE1HoNd23aEAihqbocvcmRmFeEjBPqCkok3JuEl8VAs1QjzzAs
Message-ID: <CAHS8izOfkLtFzqsfnacQrVaiW0ZkHRoeZwNK4FVV7j3yR1T_vQ@mail.gmail.com>
Subject: Re: [net-next 07/11] net/mlx5e: Convert over to netmem
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 1:56=E2=80=AFPM Saeed Mahameed <saeed@kernel.org> w=
rote:
>
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> mlx5e_page_frag holds the physical page itself, to naturally support
> zc page pools, remove physical page reference from mlx5 and replace it
> with netmem_ref, to avoid internal handling in mlx5 for net_iov backed
> pages.
>
> No performance degradation observed.
>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 80 ++++++++++---------
>  2 files changed, 43 insertions(+), 39 deletions(-)
>
...
> @@ -514,9 +514,9 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, s=
truct skb_shared_info *sinf
>         }
>
>         frag =3D &sinfo->frags[sinfo->nr_frags++];
> -       skb_frag_fill_page_desc(frag, frag_page->page, frag_offset, len);
> +       skb_frag_fill_netmem_desc(frag, netmem, frag_offset, len);
>
> -       if (page_is_pfmemalloc(frag_page->page))
> +       if (!netmem_is_net_iov(netmem) && page_is_pfmemalloc(netmem_to_pa=
ge(netmem)))
>                 xdp_buff_set_frag_pfmemalloc(xdp);

Consider using:

netmem_is_pfmemalloc(netmem_ref netmem)

In general we try to avoid netmem_to_page() casts in the driver. These
assumptions may break in the future.

>         sinfo->xdp_frags_size +=3D len;
>  }
> @@ -527,27 +527,29 @@ mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_b=
uff *skb,
>                    u32 frag_offset, u32 len,
>                    unsigned int truesize)
>  {
> -       dma_addr_t addr =3D page_pool_get_dma_addr(frag_page->page);
> +       dma_addr_t addr =3D page_pool_get_dma_addr_netmem(frag_page->netm=
em);
> +       struct page *page =3D netmem_to_page(frag_page->netmem);
>         u8 next_frag =3D skb_shinfo(skb)->nr_frags;
>
>         dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len,
>                                 rq->buff.map_dir);
>
> -       if (skb_can_coalesce(skb, next_frag, frag_page->page, frag_offset=
)) {
> +       if (skb_can_coalesce(skb, next_frag, page, frag_offset)) {

Similarly here, consider adding skb_can_coalesce_netmem() that handles
this correctly in core code (which future drivers can reuse) rather
than doing 1-off handling in the driver.

Also, from a quick look at skb_can_coalesce(), I think it can work
fine with netmems? Because it just needs to be converted to use
skb_frag_netmem istead of skb_frag_page() inside of the function, but
otherwise the function looks applicable to netmem for me.

--=20
Thanks,
Mina

