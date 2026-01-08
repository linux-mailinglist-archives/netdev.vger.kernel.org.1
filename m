Return-Path: <netdev+bounces-248104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D1D03A1A
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29B8F300E402
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0C038B7C1;
	Thu,  8 Jan 2026 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS1K2Jn3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kLJttVFj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4929C218E91
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882448; cv=none; b=lrcUMmCmhxxdGCbMFvTl9aRyvJQZjyFGRMQDn3v9pIEt/y2duwxqLNjzFSBT+jF2MK8IgN87QZk+NSv44TI2W/ZyXzCCc25Fa+EgYbGrGhX/w7YagJpMmDOWnRF7tjpbZEFI6dh7+Lf+LuU+p8pWUse4eP84My/kpMYUuONfXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882448; c=relaxed/simple;
	bh=9NRW4Rdf/VUGYmBYvief2R2tb60IwahWPnIEBIYe7so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ+orrR3svjoTllKLZa+4sRLoqCHXnLOQDCTKpNff+MdDrwBMu6InvHkqnOVMWMgrTR8hKia4y2zwrMt1+lUtOjti7aYLAUWX5/en1AfvwotNeGMcSTBsAHTPaHK2SPV9Ait+QVawsdgL7kjhEFb+Fu81BvU+0WFvv4WFYFlESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IS1K2Jn3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kLJttVFj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767882444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYUfQokxCybKNz25/1oiXAmTT63P9X7nVn3prJ03xRo=;
	b=IS1K2Jn3TKMrz9zbN6S62Kef1nQn2nsxZGhdfqoQtIv8MYmdkvSJ7tKCoQdVf4238nY1+k
	Mp0UFEGpxegiRWtLO9xDJkEu1wwKOaJVE4VkSJz9GVyV/zn58MQhZqXRwU+7w/j81nD6sp
	M/dYbYao6JOV/sFxy44afCe0RPF98Kc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-CdD5maATP6mmo6uynhCWfQ-1; Thu, 08 Jan 2026 09:27:23 -0500
X-MC-Unique: CdD5maATP6mmo6uynhCWfQ-1
X-Mimecast-MFC-AGG-ID: CdD5maATP6mmo6uynhCWfQ_1767882442
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7d282ac8aaso473778066b.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 06:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767882442; x=1768487242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYUfQokxCybKNz25/1oiXAmTT63P9X7nVn3prJ03xRo=;
        b=kLJttVFjBCRCqGB9ulYsC/FXY1K+0vqWMPqMeAps2axByIovBiVsupp+B3KlPsVRbp
         jehbEE7TzZhznJTj3jvy7oimwNgV/vgaTruulZa9jeJfjWSnUlCI1nqg4aSRwpmW8p23
         fGUy80BBWKb7q96iV1a7NrGJNe8gzCFE2W3+j0o7kWRZ47lqcfyAmvx1v+Bpogd0KjKc
         EQLLQM+LHHvTUZAF9vlEytZebFi/6NEQ1itwV2/oIaTbqWoCM2iMIJ8aveEFzWjcb70G
         igRjHQdX4Yr8/ejMIK8vCQ6vAuAcTulf/gN7lhUxk/7VgFvHRQV2DoeTKfct1nqDa27r
         g1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767882442; x=1768487242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYUfQokxCybKNz25/1oiXAmTT63P9X7nVn3prJ03xRo=;
        b=FO9QPN7va9nM8JMqP/RF816W+FmlWHn6AiWpwBmlCQygahBAyuUYemeca2QFdIAqX4
         G42QiHltuDqXfZIPPGuLSPn30ze9O60W/7xqDuU3S2WUJhkRWvGtUWo8FbuD4VFOwWA+
         Yn22zZlwGda/zj6osOSEyskgYwMEIdDhgtjzbt8J5b59p7XRm/7A3NfUX3qsc0HXRR1M
         NmDlA7u0A98bVgr9nDkmXA/453PnFa9DW8kWFKwOpUGoekJ41wkIuoihVvN5Tw7qxdNL
         P7ax6sAkuILWzVw73A3axOT4WmGTsWRhlMblsPkPn+gNyB25h1cjt+cXUkGRCDb0rnfr
         SlMA==
X-Forwarded-Encrypted: i=1; AJvYcCW1wm5SZG+F32wDDLs0I0HihtoeoQLK8PVMrCh/uO2EmP7RbjIJn+9yM4FIhs/La8emazLwUfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGHoSNLwOubzWcqAnqLteka9LUCrzYy7l234blbddauay3eHG
	U/BrnoKtRJNEHl91ppv3A4TeZ+FJWd8OBxIF5ytA9U+JKUmMi4Wz0GtQ8hTVSZ9b7mTvz37+pxB
	Acm55bF3iwY2eR0c6oM3KFaQ7R2jxPunDoISEwRmnb96+HI8sJBh3ANnvHw==
X-Gm-Gg: AY/fxX72dXTXj337V460cYCW2eKZL86+UApxArOC6N3i8DpDHQPqEU4E2gLWGFVOqFt
	blTKgY+sAlQnBXruyoztQjXiQFDsekHw6we/i4HU6I/dPP4PlY9rIwnW8r8opLTdiP830jD9hpH
	/QIBSNt0xdslpPdIZLCpo/rtVgA/Hjr/IUQZuDKsp3WI0YCY/ANjk182NKAl5o8Xbp9Gy6ykc/d
	Bh9tiEFJm4BziL1ksPU8XAhSYwszwaKAHTVqdBuU8uXcbwV+Df9Z4A2UtWHINody9mJofiWjYVK
	Xdf8jNNIsQ5KXLHYmVbj6cidCoJJDVqKyM4qmdWRuj6oi0xxp/NlB67wztbP7WNGrpli5okXAsm
	FjLLUJC/MSVmjofO8
X-Received: by 2002:a17:907:1c09:b0:b79:eaf6:8f44 with SMTP id a640c23a62f3a-b8444f4f056mr726211266b.40.1767882441992;
        Thu, 08 Jan 2026 06:27:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ6L4DqIanAXgw2ktUhRyngdJSX+H/rkKSIqtNQ9+qAgBUByhlaCVegL7JEtxsi+D3mXwYrw==
X-Received: by 2002:a17:907:1c09:b0:b79:eaf6:8f44 with SMTP id a640c23a62f3a-b8444f4f056mr726205266b.40.1767882441415;
        Thu, 08 Jan 2026 06:27:21 -0800 (PST)
Received: from sgarzare-redhat ([193.207.223.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfd97sm787982066b.36.2026.01.08.06.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:27:20 -0800 (PST)
Date: Thu, 8 Jan 2026 15:27:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Tesarik <ptesarik@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 13/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <aV-9F42fMfKGP4Rg@sgarzare-redhat>
References: <cover.1767601130.git.mst@redhat.com>
 <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
 <aV-6gniRnZlNvkwc@sgarzare-redhat>
 <20260108091514-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260108091514-mutt-send-email-mst@kernel.org>

On Thu, Jan 08, 2026 at 09:17:49AM -0500, Michael S. Tsirkin wrote:
>On Thu, Jan 08, 2026 at 03:11:36PM +0100, Stefano Garzarella wrote:
>> On Mon, Jan 05, 2026 at 03:23:41AM -0500, Michael S. Tsirkin wrote:
>> > Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
>> > last. This eliminates the padding from aligning the struct size on
>> > ARCH_DMA_MINALIGN.
>> >
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > ---
>> > net/vmw_vsock/virtio_transport.c | 8 +++++---
>> > 1 file changed, 5 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> > index ef983c36cb66..964d25e11858 100644
>> > --- a/net/vmw_vsock/virtio_transport.c
>> > +++ b/net/vmw_vsock/virtio_transport.c
>> > @@ -60,9 +60,7 @@ struct virtio_vsock {
>> > 	 */
>> > 	struct mutex event_lock;
>> > 	bool event_run;
>> > -	__dma_from_device_group_begin();
>> > -	struct virtio_vsock_event event_list[8];
>> > -	__dma_from_device_group_end();
>> > +
>> > 	u32 guest_cid;
>> > 	bool seqpacket_allow;
>> >
>> > @@ -76,6 +74,10 @@ struct virtio_vsock {
>> > 	 */
>> > 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
>> > 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
>> > +
>>
>> IIUC we would like to have these fields always on the bottom of this struct,
>> so would be better to add a comment here to make sure we will not add other
>> fields in the future after this?
>
>not necessarily - you can add fields after, too - it's just that
>__dma_from_device_group_begin already adds a bunch of padding, so adding
>fields in this padding is cheaper.
>

Okay, I see.

>
>do we really need to add comments to teach people about the art of
>struct packing?

I can do it later if you prefer, I don't want to block this work, but 
yes, I'd prefer to have a comment because otherwise I'll have to ask 
every time to avoid, especially for new contributors xD

>
>> Maybe we should also add a comment about the `ev`nt_lock` requirement 
>> we
>> have in the section above.
>>
>> Thanks,
>> Stefano
>
>hmm which requirement do you mean?

That `event_list` must be accessed with `event_lock`.

So maybe we can move also `event_lock` and `event_run`, so we can just 
move that comment. I mean something like this:


@@ -74,6 +67,15 @@ struct virtio_vsock {
          */
         struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
         struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
+
+       /* The following fields are protected by event_lock.
+        * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
+        */
+       struct mutex event_lock;
+       bool event_run;
+       __dma_from_device_group_begin();
+       struct virtio_vsock_event event_list[8];
+       __dma_from_device_group_end();
  };

  static u32 virtio_transport_get_local_cid(void)


Thanks,
Stefano


