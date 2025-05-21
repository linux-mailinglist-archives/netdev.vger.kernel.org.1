Return-Path: <netdev+bounces-192201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE0ABEE1A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3183A3BCBA4
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB85238176;
	Wed, 21 May 2025 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPK/HI8B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427223645D
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816759; cv=none; b=ol6rT3x5Prk65V+Gklxsd/mCW1PRPEn4Sd8qtWFnXjgawbChv36kRLNS6PGFT3IVmi0OFDjPrVeOYZVKCCVDELusKDzR170TBBFdG0Vase6tb+crZYetDl1P2phJ97FGglXnVw1kcG+ffSyJol5fV938vPYXkpwMcZoAmjm+188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816759; c=relaxed/simple;
	bh=CkUBVwbDNPEiCdx+vE9vtsmverrjjlnw6olGhWcPbak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVB7iQESjoRKkkCShpLm7x5wh/WmRIeQhOAmQVr7pP+AeOFj3uKdN0buKiwSPFhYZKUYrFcIduSL0XkrAkOXSNMTug2fCM2kh8ojIeGhWDHDP7isKffPqS0St96OXby+6e7LkFgixfmN7zk4CR9YCl+uhlA4rXocaJdSJkbm0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPK/HI8B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747816754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GFksJjggCprNFSzGRwTHSRmMMvVHOZx3NGfBTWPDq0=;
	b=XPK/HI8BBeHKvVpWGv5rjAsrAOccmVHIN/JxH5VhjDhyWuxf1UP3IW/Komgs3d12SvK2Da
	XM0zT86y+lXF+ufv4+RVIBSdsQCmpYrAukx8RoX9vTXqtEQ3WvEb9iIfBMk7xj3PavKQvJ
	BsUjdwNXH0Ug3+zUNKiudtfgEWm3c+o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-8CHitixDMsOcy_x9gRm4jw-1; Wed, 21 May 2025 04:39:13 -0400
X-MC-Unique: 8CHitixDMsOcy_x9gRm4jw-1
X-Mimecast-MFC-AGG-ID: 8CHitixDMsOcy_x9gRm4jw_1747816752
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a36bbfbd96so1630148f8f.0
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 01:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747816752; x=1748421552;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GFksJjggCprNFSzGRwTHSRmMMvVHOZx3NGfBTWPDq0=;
        b=sA9UnNHQg9Yy949qScBFjJC2IsLawrvsGaJMwGq/QCl1QOke39lxG+nWjZML7Fav/P
         X4c3qTFbvfvxN+t/LQuWMOaiy8y19RR+IaIOuuNcs5OPQrojcFgegd6SvQd1yZCbCVqb
         fCJC03e0sNs2f2PcWFUeCNoPuyve5/ZET/NfzKDn7gXUNrAbZP/nPG5u+oh2Gq7eRWNJ
         ir3Coj4CYRXYG715fBhSevjMxmsNYIsJdp6eVVWrnywZjKNJ9jFca0I4XF0QcIxAcl0M
         PZI0SWvIDtjM8E1s+FvdThmRz9QuWAFZ87Y/FtgDkDOldFnHSbh1KKQsfTy/Y7hVHNht
         +2wg==
X-Forwarded-Encrypted: i=1; AJvYcCWnVNyKakJNoOKKwvXcpw21PIMgnFhwek7mbls+W1H5LwTI0Qb8CYRR78TWb0twp/QBwZm4D7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjOX1a1IyWzADKFrWYY6Gog9YOnGcGqY8+OEkxHfCysmOg3zum
	ZV+R2dnrrDp+3v50Ki1655xppGqHR0mCqKdNQ+fY01iP2f2t4CIHJq02e9snRsuj4z/BmZuj3+7
	sLZrPXoqzPpwuagHamxDNFIFZnotT2p8juwVnyrosFvc9I7N3loaQNUHAOg==
X-Gm-Gg: ASbGnct3t297T6zQUvCtXjvzu1nVRuy+Ov77uXaWajZwSUpyUCeURhHCsoaHkqeOPPW
	gddwH1h8vqeW3/vK/bFJque+psdkqlHCGCjBWQJNnQlE8yxvCIiTJ5kZxCrviG0nXyo+e6RhA/N
	VhF1Kgikj9QNRtevtUyrGkJmSPp0h8hj4zbz5UNIVyjsYrkmpIJ1ADeBU4viniFl2+kq6fvCJoR
	I3cXUIEujzqDHiI9kf30ta66zkVg0Ld9r0Bfw7pigwoB54lQghgSOMjYCJLn1uFfIzLUcQIxPG8
	1tWsOQ==
X-Received: by 2002:a5d:5c84:0:b0:3a3:7be3:cb92 with SMTP id ffacd0b85a97d-3a37be3cf2bmr4470920f8f.42.1747816752223;
        Wed, 21 May 2025 01:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnGvwwJZXgUqzhuPB+QPcy0NauaMUdigdJ0ceZemSysXoSiGtKQHY9NJqDZ4Pti9FFApz78w==
X-Received: by 2002:a5d:5c84:0:b0:3a3:7be3:cb92 with SMTP id ffacd0b85a97d-3a37be3cf2bmr4470889f8f.42.1747816751789;
        Wed, 21 May 2025 01:39:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a36c6eeaf8sm11510647f8f.48.2025.05.21.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 01:39:11 -0700 (PDT)
Date: Wed, 21 May 2025 04:39:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 2/2] virtio_net: Enforce minimum TX ring size for
 reliability
Message-ID: <20250521043819-mutt-send-email-mst@kernel.org>
References: <20250520110526.635507-1-lvivier@redhat.com>
 <20250520110526.635507-3-lvivier@redhat.com>
 <CACGkMEudOrbPjwLbQKXeLc9K4oSq8vDH5YD-hbrsJn1aYK6xxQ@mail.gmail.com>
 <4085eec2-6d1c-4769-9b0e-5b5771b3e4bf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4085eec2-6d1c-4769-9b0e-5b5771b3e4bf@redhat.com>

On Wed, May 21, 2025 at 09:45:47AM +0200, Laurent Vivier wrote:
> On 21/05/2025 03:01, Jason Wang wrote:
> > On Tue, May 20, 2025 at 7:05 PM Laurent Vivier <lvivier@redhat.com> wrote:
> > > 
> > > The `tx_may_stop()` logic stops TX queues if free descriptors
> > > (`sq->vq->num_free`) fall below the threshold of (2 + `MAX_SKB_FRAGS`).
> > > If the total ring size (`ring_num`) is not strictly greater than this
> > > value, queues can become persistently stopped or stop after minimal
> > > use, severely degrading performance.
> > > 
> > > A single sk_buff transmission typically requires descriptors for:
> > > - The virtio_net_hdr (1 descriptor)
> > > - The sk_buff's linear data (head) (1 descriptor)
> > > - Paged fragments (up to MAX_SKB_FRAGS descriptors)
> > > 
> > > This patch enforces that the TX ring size ('ring_num') must be strictly
> > > greater than (2 + MAX_SKB_FRAGS). This ensures that the ring is
> > > always large enough to hold at least one maximally-fragmented packet
> > > plus at least one additional slot.
> > > 
> > > Reported-by: Lei Yang <leiyang@redhat.com>
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > ---
> > >   drivers/net/virtio_net.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index e53ba600605a..866961f368a2 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3481,6 +3481,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
> > >   {
> > >          int qindex, err;
> > > 
> > > +       if (ring_num <= 2+MAX_SKB_FRAGS) {
> > 
> > Nit: space is probably needed around "+"
> 
> I agree, but I kept the original syntax used everywhere in the file. It
> eases the search of the value in the file.


it's a mixed bag:

drivers/net/virtio_net.c:       struct scatterlist sg[MAX_SKB_FRAGS + 2];
drivers/net/virtio_net.c:       struct scatterlist sg[MAX_SKB_FRAGS + 2];
drivers/net/virtio_net.c:       if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
drivers/net/virtio_net.c:       if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
drivers/net/virtio_net.c:                       if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
drivers/net/virtio_net.c:       if (*num_buf > MAX_SKB_FRAGS + 1)
drivers/net/virtio_net.c:       if (unlikely(num_skb_frags == MAX_SKB_FRAGS)) {
drivers/net/virtio_net.c:               if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
drivers/net/virtio_net.c:       if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
drivers/net/virtio_net.c:               vi->big_packets_num_skbfrags = guest_gso ? MAX_SKB_FRAGS : DIV_ROUND_UP(mtu, PAGE_SIZE);


we should fix it all. I think MAX_SKB_FRAGS + 2 is also cleaner than the
weird 2 + syntax.



> > 
> > > +               netdev_err(vi->dev, "tx size (%d) cannot be smaller than %d\n",
> > > +                          ring_num, 2+MAX_SKB_FRAGS);
> > 
> > And here.
> > 
> > > +               return -EINVAL;
> > > +       }
> > > +
> > >          qindex = sq - vi->sq;
> > > 
> > >          virtnet_tx_pause(vi, sq);
> > > --
> > > 2.49.0
> > > 
> > 
> > Other than this.
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> > (Maybe we can proceed on don't stall if we had at least 1 left if
> > indirect descriptors are supported).
> 
> But in this case, how to know when to stall the queue?
> 
> Thank,
> Laurent
> > 
> > Thanks
> > 


