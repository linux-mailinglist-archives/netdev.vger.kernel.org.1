Return-Path: <netdev+bounces-248100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05754D03A6B
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 937163041A5C
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54DE36E467;
	Thu,  8 Jan 2026 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LR/nXuzw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7sjFu/e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5219E97F
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881880; cv=none; b=XkflUOd2Nhcboj+bsqdpR593pTidals5RD0wg+nlM1Dgw2lMjEbiKmWfE7HF+HR/keNj6U6y8aUc3KH9uCnPRsDbyR1M3LEplx9fedtDZOnWbBWVAX9+l4VvJDUuCvHvqef28AsDpBVq9jOH/f+yzuq24D33pExzEN2vBOVKj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881880; c=relaxed/simple;
	bh=OyIQ4x46NnhuAF46QiC0P1xvTdYkXW0VaN1yOEbVEDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POfTDjyLnbJYvypyuoR3gK6QFP1XQgjTaMV6lZUZm+alB4oYy/LUldP/yqduDjnAtPXrdx53yn7FNDCAFtx6h7WXappZeIXKhbJG1CI6N9kdfVsxPrgMOoDpOuFoFvsF9cS4j61xvYAhLbvBujs9q4X7Wi7+iIHM/6EB4CSoXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LR/nXuzw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7sjFu/e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767881877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJ1lT1EolLhB5JifwSURg3jL1WOY3ilSvQ0LTyMqODM=;
	b=LR/nXuzwop/FXzYCptdu4OOiq9sC3521JW2+LXEkxN/lUr5IwaNlZD/6UimSJt1m6gxeBD
	lB7QbyX2z8bVdRHRJv6oOFIszLGwLh6VqbO40t9znAg9vBzizZv6dWGSifYoud15A6ovfH
	ZAqlftreaEAyOM95ouDMq2ilQkrIhak=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-PrYoLbBGPPmlbZ9XjDsgAg-1; Thu, 08 Jan 2026 09:17:55 -0500
X-MC-Unique: PrYoLbBGPPmlbZ9XjDsgAg-1
X-Mimecast-MFC-AGG-ID: PrYoLbBGPPmlbZ9XjDsgAg_1767881875
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fdaba167so1570186f8f.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767881874; x=1768486674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ1lT1EolLhB5JifwSURg3jL1WOY3ilSvQ0LTyMqODM=;
        b=g7sjFu/eqYd8CduJmJi5LBL/NthqffZdBfVYNP9sT9LiRma1mmPz+uA55dl8r3o+P2
         9aBN8RtpmX+EPt+OSU70NItWuFCpzVP9lTzO0S3kjaEAW0RFCE4C7CO2Ltl1cdLuMs3p
         W8sWdOuDHqIBIt0/cnPwvqgIdzHzd87cOZFurOKy2x8JxaKVsuYFUzU7ZK+2zl8wtf9T
         Tb7WN5/aoUOwSPnXG3rg8+yL4DHPmPSzDFUEmdDn5I8bj2p8nMFEBa2BpHH2YHRdGGOh
         Et33RI16Zoj2qaq8Cp0r6TJxLtyzonv2QFxTt5Bsh4ILImaEXYrqpadVDKj6B2lb4ABZ
         4AYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881874; x=1768486674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ1lT1EolLhB5JifwSURg3jL1WOY3ilSvQ0LTyMqODM=;
        b=F3uH/uo/vJNU9AdIAACHdp8c19LGor6fPkNgCOzmyTUOMgZ3Tt8l0Tpz/FrhDoiQhl
         yc3uMfpF4vdsEzkh+pB6nNBM3OfDb5PC5hdsxM4OZeQsA+XBUEDZjljbZLUA6XQpOBIM
         XX/EwnJ5qnIucFvhV36B0kreqO2Urjvd7jjYdqtZUxL7BbFQAvplzxSADW14Do/Z049j
         4x3x8I+aNZoLQllRA4esEG+PGHAgk5WyJJta3dmgrfoWxYsnZ420+vRllLQMgrXhg8M2
         BzXSaPK0Pvc+ocfpnnYowslSrr8gGZ/AWWVJr13Aqaq+cHdAPN48+sZy5E/ggrMyIaoK
         +0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqKt1AvBMyw9IA925Gcjnt1+W2VCPK1/rpP9KGxEtjZXGP3UDB88bymfftuSvhtRcVStpZ/LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZm2vg8IUbRxtqY95p0oLSEGKKO00wZ7d+7oUwki0LIeCOEyKb
	vneTQMfdUW7zn/I7aVI8ukcrdwTxQ2ahCw6O+FPhzmGifr//He7bSwLexjvKo/gFg9ndj8FPTqC
	X6g0QIXo+8b12+Rq4Btc6S1o0ifOIrFW36AeNWN4+u6lvi7diu9NxgUvNIg==
X-Gm-Gg: AY/fxX5N9XhtcFXBkpcIkyR6US0d2XDLjyzbPUIfYAkg6nDr4GPvsfREXSA+M4CSBaV
	tm6YrPx+HXamu++X8WsscjA08oredBMt1elgI5EgJaRsc89gYaIfzch4ZS75+FWuht1GFniie76
	/OKAOTgFxlEgEEja5MissQlIxQhXzfrvrn7NVapCxiKpQN1/sfcODnXPuF7g1tbeblVaG7EOQXG
	a6qUaT8J6FZiH3Y5T0iAleAWTWbGSIPVUBLG/mXVY5n2Bz45quMVmcUeFH0fQJos/68jEwWE71r
	rMA4+vOS1FuoODQ6TSlidX0+Cnzyz7SA2Tnc/lfEOFPVD2wgGvLsEzYeGNGbp33tjIQG8YbM2+m
	Qv+Ei/p/G6TRasbUFEGauqYZp/GmHDQ8+bw==
X-Received: by 2002:a05:6000:2483:b0:42f:b0ab:7b48 with SMTP id ffacd0b85a97d-432c3627fbamr7468073f8f.1.1767881874425;
        Thu, 08 Jan 2026 06:17:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlUVHuOj7/HPTlOMU0+NpCVpFuCnGhMJ1KC00yBihfngclSciPQ4cpm1QXhZzj17NQ1UZXYA==
X-Received: by 2002:a05:6000:2483:b0:42f:b0ab:7b48 with SMTP id ffacd0b85a97d-432c3627fbamr7468022f8f.1.1767881873896;
        Thu, 08 Jan 2026 06:17:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5eesm16735262f8f.34.2026.01.08.06.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:17:53 -0800 (PST)
Date: Thu, 8 Jan 2026 09:17:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 13/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <20260108091514-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
 <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
 <aV-6gniRnZlNvkwc@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV-6gniRnZlNvkwc@sgarzare-redhat>

On Thu, Jan 08, 2026 at 03:11:36PM +0100, Stefano Garzarella wrote:
> On Mon, Jan 05, 2026 at 03:23:41AM -0500, Michael S. Tsirkin wrote:
> > Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
> > last. This eliminates the padding from aligning the struct size on
> > ARCH_DMA_MINALIGN.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > net/vmw_vsock/virtio_transport.c | 8 +++++---
> > 1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index ef983c36cb66..964d25e11858 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -60,9 +60,7 @@ struct virtio_vsock {
> > 	 */
> > 	struct mutex event_lock;
> > 	bool event_run;
> > -	__dma_from_device_group_begin();
> > -	struct virtio_vsock_event event_list[8];
> > -	__dma_from_device_group_end();
> > +
> > 	u32 guest_cid;
> > 	bool seqpacket_allow;
> > 
> > @@ -76,6 +74,10 @@ struct virtio_vsock {
> > 	 */
> > 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
> > 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
> > +
> 
> IIUC we would like to have these fields always on the bottom of this struct,
> so would be better to add a comment here to make sure we will not add other
> fields in the future after this?

not necessarily - you can add fields after, too - it's just that
__dma_from_device_group_begin already adds a bunch of padding, so adding
fields in this padding is cheaper.


do we really need to add comments to teach people about the art of
struct packing?

> Maybe we should also add a comment about the `event_lock` requirement we
> have in the section above.
> 
> Thanks,
> Stefano

hmm which requirement do you mean?

> 
> > +	__dma_from_device_group_begin();
> > +	struct virtio_vsock_event event_list[8];
> > +	__dma_from_device_group_end();
> > };
> > 
> > static u32 virtio_transport_get_local_cid(void)
> > -- 
> > MST
> > 


