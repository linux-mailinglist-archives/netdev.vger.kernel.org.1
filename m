Return-Path: <netdev+bounces-85614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC1C89B954
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 09:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833E91C208CE
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 07:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B235FBB7;
	Mon,  8 Apr 2024 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKebCT+t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7399B5FB96
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562519; cv=none; b=E5B55sUmC+bK17k3Pvf770QVzK8xP1/gGKWjSeucRQfm/olL04lxNR3ElEl0tIxPEy4HyaJaDgmw+197/3JvKh2e26aFpK4PiDMxtJn5LF7RU+fS1BOC9WR6aGrErUfSXwOFo0rr6NwgHsPuIiQGHB2QA4ilkVGl3CB9ABNVlM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562519; c=relaxed/simple;
	bh=AO6S3J1UkADcOuG3dtHKoKni47rzKE/2aQXWNVAMaa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+jGc85n2UbnEbvukfWj/8SUV3vsAByuWSp0XZBqnV/jwmuDp7tm5sJUiyw9w2tWM7rEb9LWpNrkJGlTxvpm3Ow9ujW0buo9FKG3fnhqLAtXvyyZByDYxX6TcSBYi2hFRyM+jiecL2KWIsnH9/zOiH8Q+e3qKoKdu7k9ewGDMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKebCT+t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712562516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8TYgCFyRlI1iTv2tcyJ+PG3jxVx5/GPjyqoQsuNov1k=;
	b=VKebCT+tFu1IP6hOTZ4YAH0o9N+Y13bgx2cBXVZ5HK8b5eT95UpA0j92xwTvnZ5ZEMXCdt
	ayZ9D8kxrV0nd7cZH5DcZqRKwswlaoFpX5aYAU++fic7bXcyoNIZa8LSqJhM09sowctxoZ
	CkWqS3L7RRbUs6jpPFDd9hdfzagJXXY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-gv6tBVc3PFydVL3RcYl-2w-1; Mon, 08 Apr 2024 03:48:34 -0400
X-MC-Unique: gv6tBVc3PFydVL3RcYl-2w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343f5059c5fso1618366f8f.2
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 00:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562512; x=1713167312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TYgCFyRlI1iTv2tcyJ+PG3jxVx5/GPjyqoQsuNov1k=;
        b=STajnu5zxVxnlXUylRDvWd4hNBhaRg84yQ6nrXtStuClzM0Asmy+Y9SA+BcM0QZ5K1
         0ARUmtIo2Cmqzrz5VIZogvCRtdzyJENyD3RcisPzAoRRrM6TV3xyJ5TRm6RGvXq0fu98
         LOEhfQDmJ0ZKGd8Rp5ziqVFh0+8HWSW4nVCYwCqT1TdfpnXMdZgoRWQG0vB056briQjJ
         BTmvySORDyxwxXagknFosZ8vuKyIb1e09AW0caKLXMW5zdfrOnArwPPGdc8k6Anm+udg
         9TdsgSv2sGAS0P/u6zZd65hcD5O6T0MtK/5RzPYPbJ3zfmQkEYsx9EsRh/aPwAon1Qde
         R12A==
X-Forwarded-Encrypted: i=1; AJvYcCUDHOqOmtakunh5tdc39kf8/rSM1DqYo85e6m/SntGNddLZ6OZlGxIxlPL4Qt/3MNWm1gEk2DuEvWbGOdEAjsc+K+bOUtRH
X-Gm-Message-State: AOJu0YyWegGohCZ7aMON2Loikbty/u8HkYd+mcARA2ZC7q6oVIsYPeTc
	tGm82WBka3Rrp276SoiL4/DXghbZ4ETmK+z5G/4mutH+PL6W0j3n/WDVDPH2kDuZevM4NOVtsGa
	kXi5I6wh9O19mAaYhOMA3WD4qBgkPjrHGwJNZQwzUg8pkDS5f1tVmFA==
X-Received: by 2002:a5d:6048:0:b0:33e:a5e1:eccc with SMTP id j8-20020a5d6048000000b0033ea5e1ecccmr6531794wrt.68.1712562511804;
        Mon, 08 Apr 2024 00:48:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdSMdusIIBkkxRUY3+EQubBPog0K+ZjLJesgUXee5bP5avEYpbgMpmWO+ePhpK1P9BnrPA5g==
X-Received: by 2002:a5d:6048:0:b0:33e:a5e1:eccc with SMTP id j8-20020a5d6048000000b0033ea5e1ecccmr6531772wrt.68.1712562511220;
        Mon, 08 Apr 2024 00:48:31 -0700 (PDT)
Received: from redhat.com ([2.52.152.188])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d4564000000b00343826878e8sm8278091wrc.38.2024.04.08.00.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:48:30 -0700 (PDT)
Date: Mon, 8 Apr 2024 03:48:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v6 0/5] remove page frag implementation in
 vhost_net
Message-ID: <20240408034726-mutt-send-email-mst@kernel.org>
References: <20240228093013.8263-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228093013.8263-1-linyunsheng@huawei.com>

On Wed, Feb 28, 2024 at 05:30:07PM +0800, Yunsheng Lin wrote:
> Currently there are three implementations for page frag:
> 
> 1. mm/page_alloc.c: net stack seems to be using it in the
>    rx part with 'struct page_frag_cache' and the main API
>    being page_frag_alloc_align().
> 2. net/core/sock.c: net stack seems to be using it in the
>    tx part with 'struct page_frag' and the main API being
>    skb_page_frag_refill().
> 3. drivers/vhost/net.c: vhost seems to be using it to build
>    xdp frame, and it's implementation seems to be a mix of
>    the above two.
> 
> This patchset tries to unfiy the page frag implementation a
> little bit by unifying gfp bit for order 3 page allocation
> and replacing page frag implementation in vhost.c with the
> one in page_alloc.c.
> 
> After this patchset, we are not only able to unify the page
> frag implementation a little, but also able to have about
> 0.5% performance boost testing by using the vhost_net_test
> introduced in the last patch.
> 
> Before this patchset:
> Performance counter stats for './vhost_net_test' (10 runs):
> 
>      305325.78 msec task-clock                       #    1.738 CPUs utilized               ( +-  0.12% )
>        1048668      context-switches                 #    3.435 K/sec                       ( +-  0.00% )
>             11      cpu-migrations                   #    0.036 /sec                        ( +- 17.64% )
>             33      page-faults                      #    0.108 /sec                        ( +-  0.49% )
>   244651819491      cycles                           #    0.801 GHz                         ( +-  0.43% )  (64)
>    64714638024      stalled-cycles-frontend          #   26.45% frontend cycles idle        ( +-  2.19% )  (67)
>    30774313491      stalled-cycles-backend           #   12.58% backend cycles idle         ( +-  7.68% )  (70)
>   201749748680      instructions                     #    0.82  insn per cycle
>                                               #    0.32  stalled cycles per insn     ( +-  0.41% )  (66.76%)
>    65494787909      branches                         #  214.508 M/sec                       ( +-  0.35% )  (64)
>     4284111313      branch-misses                    #    6.54% of all branches             ( +-  0.45% )  (66)
> 
>        175.699 +- 0.189 seconds time elapsed  ( +-  0.11% )
> 
> 
> After this patchset:
> Performance counter stats for './vhost_net_test' (10 runs):
> 
>      303974.38 msec task-clock                       #    1.739 CPUs utilized               ( +-  0.14% )
>        1048807      context-switches                 #    3.450 K/sec                       ( +-  0.00% )
>             14      cpu-migrations                   #    0.046 /sec                        ( +- 12.86% )
>             33      page-faults                      #    0.109 /sec                        ( +-  0.46% )
>   251289376347      cycles                           #    0.827 GHz                         ( +-  0.32% )  (60)
>    67885175415      stalled-cycles-frontend          #   27.01% frontend cycles idle        ( +-  0.48% )  (63)
>    27809282600      stalled-cycles-backend           #   11.07% backend cycles idle         ( +-  0.36% )  (71)
>   195543234672      instructions                     #    0.78  insn per cycle
>                                               #    0.35  stalled cycles per insn     ( +-  0.29% )  (69.04%)
>    62423183552      branches                         #  205.357 M/sec                       ( +-  0.48% )  (67)
>     4135666632      branch-misses                    #    6.63% of all branches             ( +-  0.63% )  (67)
> 
>        174.764 +- 0.214 seconds time elapsed  ( +-  0.12% )

The perf diff is in the noise, but the cleanup is nice.
Thanks!

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> Changelog:
> V6: Add timeout for poll() and simplify some logic as suggested
>     by Jason.
> 
> V5: Address the comment from jason in vhost_net_test.c and the
>     comment about leaving out the gfp change for page frag in
>     sock.c as suggested by Paolo.
> 
> V4: Resend based on latest net-next branch.
> 
> V3:
> 1. Add __page_frag_alloc_align() which is passed with the align mask
>    the original function expected as suggested by Alexander.
> 2. Drop patch 3 in v2 suggested by Alexander.
> 3. Reorder patch 4 & 5 in v2 suggested by Alexander.
> 
> Note that placing this gfp flags handing for order 3 page in an inline
> function is not considered, as we may be able to unify the page_frag
> and page_frag_cache handling.
> 
> V2: Change 'xor'd' to 'masked off', add vhost tx testing for
>     vhost_net_test.
> 
> V1: Fix some typo, drop RFC tag and rebase on latest net-next.
> 
> Yunsheng Lin (5):
>   mm/page_alloc: modify page_frag_alloc_align() to accept align as an
>     argument
>   page_frag: unify gfp bits for order 3 page allocation
>   net: introduce page_frag_cache_drain()
>   vhost/net: remove vhost_net_page_frag_refill()
>   tools: virtio: introduce vhost_net_test
> 
>  drivers/net/ethernet/google/gve/gve_main.c |  11 +-
>  drivers/net/ethernet/mediatek/mtk_wed_wo.c |  17 +-
>  drivers/nvme/host/tcp.c                    |   7 +-
>  drivers/nvme/target/tcp.c                  |   4 +-
>  drivers/vhost/net.c                        |  91 ++--
>  include/linux/gfp.h                        |  16 +-
>  mm/page_alloc.c                            |  22 +-
>  net/core/skbuff.c                          |   9 +-
>  tools/virtio/.gitignore                    |   1 +
>  tools/virtio/Makefile                      |   8 +-
>  tools/virtio/linux/virtio_config.h         |   4 +
>  tools/virtio/vhost_net_test.c              | 532 +++++++++++++++++++++
>  12 files changed, 609 insertions(+), 113 deletions(-)
>  create mode 100644 tools/virtio/vhost_net_test.c
> 
> -- 
> 2.33.0
> 


