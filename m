Return-Path: <netdev+bounces-124801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D5396AF78
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 05:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7AF2853CA
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 03:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0312482D8;
	Wed,  4 Sep 2024 03:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjKICXcq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36293211
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 03:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725420830; cv=none; b=KoVBFr5yjnatAwJS+Y/PBDZcD/n97T9r/RVYlQviDTkLzKmXNsdppUA8/nF34YRmwjjcGRBzJfiWT9rCYIe/JM038P8s9vBjcxRsRCyHPfPc1NjT7W9OjDDcEGwBXGb3TGIUgvx9CEA7KM0D7oFUnufdNpltoILQNrUztE+008k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725420830; c=relaxed/simple;
	bh=hgAJ0G+zWRgAsGuwuikNrsCbsktLUkO9C80k/m7wAwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+XwXCvlMz8eBrInWDBstx1U6ZthGsZaz72UNyHejbPULJt3XZHz9eGzJA/uvhNwSJvZvYSOLsnpfxaQz0Vfxo3DXPtIwr+HK85b9227fuzVmHSfFskjMp4tKE0OI2bSGUlq4p7umDwsNUfm4fpCO3u3KXBddCMZqBlTOBiBcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjKICXcq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725420827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPH/NDUA6JCfNpeXnclr1Ul7poQshF471VRZNTn0m0A=;
	b=DjKICXcq53Q3uTbAVFkM92hi1pIEAqLgu5gnyNyUWOE7Ilf5hnM+wAspRwXKL5aEJ/rAOy
	4U3pVWLFkBq/0iw1uQXy5Sk2yUrJhM1OwANfhicT8za0RjzforQZPQ7WJ+cRKU8WqdkFti
	OjX1gXPtsnBkoW1tcysh2V1rls0DupM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-iR8xSThzPy-sULfr_k3iiQ-1; Tue, 03 Sep 2024 23:33:45 -0400
X-MC-Unique: iR8xSThzPy-sULfr_k3iiQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7cd98f27becso6338681a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 20:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725420824; x=1726025624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPH/NDUA6JCfNpeXnclr1Ul7poQshF471VRZNTn0m0A=;
        b=Kt8nZ9YEx8rlUf7A6onNayyFm8FsE7rGOA+xKBzUO72DtPT8f/I1gU+Mxk8gUq4pME
         KRzToibreAR9MlOMBUBHRYCqCjUJm7o4vCAGIP5cIOaRY4gtL4ELRKBkjeD6HAtY3kt9
         zcKmcxAG66+uMCMXvg5GwJJzRTz22bywT1tkn1OWcoH4W6ScmBKvtDSQiW/HxHDKnunJ
         x9+A+xbA6MPcnDxdRDozQpN7wtwzKxhs0g97c3MJVbkOY1WuaeXY8RfUz5XxU8qZaxbv
         foaLTX/BlpsaL0SfTvMekWlHXPEsw1KOoNPzeYB5e8KOG3nsJrI4SAgjKaTQ+I0dhvem
         ytfg==
X-Forwarded-Encrypted: i=1; AJvYcCWMhcx9rjybPia3PehhedLM6ClwemSR77YMunuDDo0BhcRWCfwL5JX2kMY+y94xFFOskMFAEpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyleVaOnwDMa2OhUWgs4X6v+LYlxJuyql8VoynrDzZhznEK1HDW
	9QJzBatHGl4jBLa9nFdK+kkJprYIp/g0Odt3S07/DUEPFoIeTr3zqM1rq8M0oajrRJa2BZKZgxJ
	RP/ncuHE91eulHr4Hfa9Eek1BR9xzwZ1uSeE4/WT+lkDBkfYC6S00ZHpva06hlkTKJKQUf58QUE
	rQEl7PdxMA5F+gLQe459h9qGip2KgB
X-Received: by 2002:a05:6a20:b40a:b0:1ce:f77a:67e5 with SMTP id adf61e73a8af0-1cef77a69f1mr6272674637.47.1725420824272;
        Tue, 03 Sep 2024 20:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHynsWjnc8t9TYg6z41C4ZK79KT9vx1+7WyBbowaBWG6oiBmeW9D+MnJkJXz5si8RSgMEcmX6LwYH2QcayKr4=
X-Received: by 2002:a05:6a20:b40a:b0:1ce:f77a:67e5 with SMTP id
 adf61e73a8af0-1cef77a69f1mr6272655637.47.1725420823770; Tue, 03 Sep 2024
 20:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904023339.77456-1-liwenbo.martin@bytedance.com>
In-Reply-To: <20240904023339.77456-1-liwenbo.martin@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Sep 2024 11:33:32 +0800
Message-ID: <CACGkMEuH4ERuvGPPzBvmAT0B51ccbeBvE=PiQxn2s-J_wXugOg@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Fix mismatched buf address when unmapping for
 small packets
To: Wenbo Li <liwenbo.martin@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiahui Cen <cenjiahui@bytedance.com>, 
	Ying Fang <fangying.tommy@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:51=E2=80=AFAM Wenbo Li <liwenbo.martin@bytedance.=
com> wrote:
>
> Currently, the virtio-net driver will perform a pre-dma-mapping for
> small or mergeable RX buffer. But for small packets, a mismatched address
> without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
>
> That will result in unsynchronized buffers when SWIOTLB is enabled, for
> example, when running as a TDX guest.
>
> This patch handles small and mergeable packets separately and fixes
> the mismatched buffer address.
>

Missing fixes tag.

> Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
> ---
>  drivers/net/virtio_net.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948..6215b66d8 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -891,6 +891,20 @@ static void *virtnet_rq_get_buf(struct receive_queue=
 *rq, u32 *len, void **ctx)
>         return buf;
>  }
>
> +static void *virtnet_rq_get_buf_small(struct receive_queue *rq,
> +                                     u32 *len,
> +                                     void **ctx,
> +                                     unsigned int header_offset)
> +{
> +       void *buf;
> +
> +       buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> +       if (buf)
> +               virtnet_rq_unmap(rq, buf + header_offset, *len);
> +
> +       return buf;
> +}
> +
>  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, =
u32 len)
>  {
>         struct virtnet_rq_dma *dma;
> @@ -2692,13 +2706,23 @@ static int virtnet_receive_packets(struct virtnet=
_info *vi,
>         int packets =3D 0;
>         void *buf;
>
> -       if (!vi->big_packets || vi->mergeable_rx_bufs) {
> +       if (vi->mergeable_rx_bufs) {
>                 void *ctx;
>                 while (packets < budget &&
>                        (buf =3D virtnet_rq_get_buf(rq, &len, &ctx))) {
>                         receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stat=
s);
>                         packets++;
>                 }
> +       } else if (!vi->big_packets) {
> +               void *ctx;
> +               unsigned int xdp_headroom =3D virtnet_get_headroom(vi);

I wonder if this is safe. The headroom is stored as the context, it
looks to me we should fetch the headroom there.

The rx buffer could be allocated before XDP is disabled. For example we had=
 this

        unsigned int xdp_headroom =3D (unsigned long)ctx;

at the beginning of receive_small().


> +               unsigned int header_offset =3D VIRTNET_RX_PAD + xdp_headr=
oom;
> +
> +               while (packets < budget &&
> +                      (buf =3D virtnet_rq_get_buf_small(rq, &len, &ctx, =
header_offset))) {
> +                       receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stat=
s);
> +                       packets++;
> +               }
>         } else {
>                 while (packets < budget &&
>                        (buf =3D virtqueue_get_buf(rq->vq, &len)) !=3D NUL=
L) {
> --
> 2.20.1
>

Thanks


