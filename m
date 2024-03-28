Return-Path: <netdev+bounces-82742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E053E88F8A8
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCA41C230C1
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F150A63;
	Thu, 28 Mar 2024 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0vSzLBH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02BF51C55
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610872; cv=none; b=pY9YiZo1o8C6VVZDcmrWoJglKVTYO4uPSXTY4KLmt7VpUhzY8djLIhkZR/HlMnNEeCC2lxRKItQpSMKi5kaxpCw8He9ILYGBoXZuvHYcMgx+RYVZ/sGAeaaTK1Try6OtSSCOTH/F4HnfQp8fs/rIlSt33+VsKWCXYxdE6Sw/8Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610872; c=relaxed/simple;
	bh=NK4LhkkGkViOrXQkM9eRiSSoeESxSpfyTFjwafLMAWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr3s26TLtvai/JP1YjEjD1h2GT4zt827Vun4jf2uCJ3RPWerNf5OMX11+Q9ccaDaE8UYRTBBG7bjlFSKfvOHmMMv75X6m31LQXeVjC+MQkNnq+7GamxBzqW/2onli10WVpcA2bYYDU68zmdyxx4mMLtjHGFUkbJYBixWvj457hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0vSzLBH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711610869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JVkRY3Z6yNB250QlGYIYZCvpeFtWYNvdmsEL/1sVZl0=;
	b=b0vSzLBHDo+tUe5CEfI0cerkEZhOSb2isv+KK24wv2Ab9VxfDoXDDpOrAKsqxe3KKcKM+u
	wRa8wQxaRd3957ZsnrARjZ7dfDOXyElL3bY7ukdn9g6MBv26RhI5hHDckTv5NetM6Qlx+4
	r2OdBqgqCMohCqYarybRcvVhcMStVGI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-Rl0lzgk_NTebbTuIkm1eBA-1; Thu, 28 Mar 2024 03:27:47 -0400
X-MC-Unique: Rl0lzgk_NTebbTuIkm1eBA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4488afb812so28882366b.3
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711610866; x=1712215666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVkRY3Z6yNB250QlGYIYZCvpeFtWYNvdmsEL/1sVZl0=;
        b=J1tZF42reTdlC8rVkHmpzfsNpDrvuXEuzajnQVPiCi07E1ADQNFG3OIcm28YV+cLRd
         3bHnG+DyiZMRmlqG7EPTHTCAhv9wpHKmN/yViyxh6tnBZIYTDHygzn/5xRSWf1b5+ra4
         XvnkHekRh8FvAUq67bed2Ac8QcHp1zeEjFOQy7t3kDezSfPqaggmN6C9IpKCZvX6oTzm
         RJRxR87RnD3FJPhkWEcgjzno4XMF7nf09rCcQ9Ih9TcFdczbJg4FcYTqca0AFebYDeH2
         j1eed9cZM/GeCjiM/bZ8xO/1W0e7uIEQ3ZR0xmYzuwwmkVqP2boVf5AswztzHf0bKiQO
         Bz7A==
X-Forwarded-Encrypted: i=1; AJvYcCULTxtjUVAE/TNeO2pwqNmHuO5yFu33r43hL3dyWa1uTg21iFTi0FOh4pIJca8sS6orp5dyGSpiFSF84xavOX7+0xChc7M7
X-Gm-Message-State: AOJu0YwW+0veOiVg+dCGrxtG4p0jwvhjKTh9H/UeBUaltozl/vx2eflH
	WlEwC5mYHveUD23l0m7tuUV0ni62EeDu6ljKxQhnXm8ZTwBLODTBexGTuCv3BGBVCP5j7LEcYDV
	4WY6q9vnuZvRGjHhmPOdTlbMN6DLbCotQ17FXZXVnrBASMqP+6jDsB/cuLmsHsg==
X-Received: by 2002:a17:906:3389:b0:a46:8daa:436f with SMTP id v9-20020a170906338900b00a468daa436fmr1145272eja.69.1711610865633;
        Thu, 28 Mar 2024 00:27:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA+7qJLz4Tau90+vrMUDhWTn15xnwwECAXggwHYiub8LyZm90ZfdQ59r0/4eKfrdMwhziddA==
X-Received: by 2002:a17:906:3389:b0:a46:8daa:436f with SMTP id v9-20020a170906338900b00a468daa436fmr1145259eja.69.1711610865098;
        Thu, 28 Mar 2024 00:27:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:5969:7af8:be53:dc56:3ccc])
        by smtp.gmail.com with ESMTPSA id t18-20020a17090616d200b00a4664e6ad8esm413813ejd.169.2024.03.28.00.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 00:27:44 -0700 (PDT)
Date: Thu, 28 Mar 2024 03:27:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 2/2] virtio-net: support dim profile
 fine-tuning
Message-ID: <20240328032719-mutt-send-email-mst@kernel.org>
References: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
 <1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>
 <556ec006-6157-458d-b9c8-86436cb3199d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556ec006-6157-458d-b9c8-86436cb3199d@intel.com>

On Wed, Mar 27, 2024 at 03:45:50PM +0100, Alexander Lobakin wrote:
> From: Heng Qi <hengqi@linux.alibaba.com>
> Date: Wed, 27 Mar 2024 17:19:06 +0800
> 
> > Virtio-net has different types of back-end device
> > implementations. In order to effectively optimize
> > the dim library's gains for different device
> > implementations, let's use the new interface params
> > to fine-tune the profile list.
> 
> Nice idea, but
> 
> > 
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 52 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index e709d44..9b6c727 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -57,6 +57,16 @@
> >  
> >  #define VIRTNET_DRIVER_VERSION "1.0.0"
> >  
> > +/* This is copied from NET_DIM_RX_EQE_PROFILES in DIM library */
> > +#define VIRTNET_DIM_RX_PKTS 256
> > +static struct dim_cq_moder rx_eqe_conf[] = {
> > +	{.usec = 1,   .pkts = VIRTNET_DIM_RX_PKTS,},
> > +	{.usec = 8,   .pkts = VIRTNET_DIM_RX_PKTS,},
> > +	{.usec = 64,  .pkts = VIRTNET_DIM_RX_PKTS,},
> > +	{.usec = 128, .pkts = VIRTNET_DIM_RX_PKTS,},
> > +	{.usec = 256, .pkts = VIRTNET_DIM_RX_PKTS,}
> > +};
> 
> This is wrong.

Yes I'd expect anything global to be const.

> This way you will have one global table for ALL the virtio devices in
> the system, while Ethtool performs configuration on a per-netdevice basis.
> What you need is to have 1 dim_cq_moder per each virtio netdevice,
> embedded somewhere into its netdev_priv(). Then
> virtio_dim_{rx,tx}_work() will take profiles from there, not the global
> struct. The global struct can stay here as const to initialize default
> per-netdevice params.
> 
> > +
> >  static const unsigned long guest_offloads[] = {
> >  	VIRTIO_NET_F_GUEST_TSO4,
> >  	VIRTIO_NET_F_GUEST_TSO6,
> 
> Thanks,
> Olek


