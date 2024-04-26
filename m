Return-Path: <netdev+bounces-91851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C6C8B42C6
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 01:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1EDB21DDE
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 23:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10043BBF5;
	Fri, 26 Apr 2024 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IhX7zM1/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02573BBCB
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175040; cv=none; b=lbgy8DiP9rW+zSHkcvO8lOQxOdLw09MH4hfBf3p/83MRNcpBtZLEq5BUm0q2gme6ilhYVxFvYSuhPxoo7Qjj4LUc/SlXgmavNGoUeBAE3fWlLkle76Wmi46qoConGLa3y3iBCOhNd9Kohtp3U3Iz2ByAr9RD7b3cMAZhHrIlMIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175040; c=relaxed/simple;
	bh=4ueyqqnpjdsObXYQLrGKJPTks4tRyI8543d9ZFbHrOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIFVMMznfypN3VC79rjhbz+8mnjb3+bC4rqZ3oppc7yZCyDSGmEcr6Ix3jhO8LwsyZCKEtJDnWDjU/4syvWl1e5SqY4ggS31sgJnA8sL/1lk4vDHehcWPY3A8dVdkFJ2w0slFP3Fm6zOKQ3WZQsct2EZTRQ8e9wdwBVlETI9xSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IhX7zM1/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1eac92f7c74so18745215ad.3
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714175037; x=1714779837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xerjZH1LN9t/EbZJjFMz8CuRYI7uIyIo8baSo7KdOs=;
        b=IhX7zM1/7pb5c693f8gJ2cp55boZQXnhTLqD1NClqQxf2ySQQV6kkVG5en5ZGJoXc1
         e5phRm5iHeFA5eCsmLDP0MOE78EuE51jYGa/EWfgxeeCF0cEq5PNbb/bb3YwUD5AXCg2
         IgIHZrsWT4ZKYndT1sXB6IrFoIreDo5arkxDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714175037; x=1714779837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xerjZH1LN9t/EbZJjFMz8CuRYI7uIyIo8baSo7KdOs=;
        b=tYGV/5sKc7AxcVpYNDU+iCAWH00V3/+btn7Nq04+WcFg2oIFEYy5lJA9SO9UyPRY3B
         neHdUAwCrukO1Vqdh06+69NgI+Y7P42BLSgmfU3XJkoZ5aop7iONX5wx+klgAtqiqc/t
         g50qI+rptHPW/SJ76ZQWsUzWPtBj27bMNuvkG4sGGg7tyYo0Wmr+oIvQEahXJo0gwHue
         CUUq69G1uEDhpj2fF5Vs01AEUuyyazK8GFN4ryewyf+IfvrrkXjkD2hFtw/OVDIxbIIR
         Jk1ZvI8dr3LbFp+p+te0F1NJc1/QPfOfnskfxNY14ItEyTkhN2kIJwWpn5DJLQ2yrloA
         RbuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpc9zafN0xdxnXyyEd+y/e+Dscn3lLANKi929LkR4qc7UcqGpmQITIRSGdK4MXbv77pjUeFczW5r8SQcIAx6UB7Tio3/H/
X-Gm-Message-State: AOJu0YxwAFxOBtSUt7+IsbcS4ns+sy4GC9X4+nWRKwsW8AmLfGfgeCfy
	MLa6odloFEaexyU4VeAfBevBRI7Jpyx31QIfRAqJxbHyKckvOPMvxbQfOJJQ96I=
X-Google-Smtp-Source: AGHT+IE6WzeXHsbW09YXMiqu2unoxhHneGg3mX9h87VQbGAG4TkH8P1ic+5LvFrztWVLdS1z6yY5uQ==
X-Received: by 2002:a17:903:1103:b0:1e2:aa62:2fbf with SMTP id n3-20020a170903110300b001e2aa622fbfmr4937308plh.45.1714175037242;
        Fri, 26 Apr 2024 16:43:57 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id ix19-20020a170902f81300b001e895c9ec6asm15549325plb.152.2024.04.26.16.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 16:43:56 -0700 (PDT)
Date: Fri, 26 Apr 2024 16:43:53 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net/mlx4: Track RX allocation failures
 in a stat
Message-ID: <Ziw8OSchaOaph1i8@LQ3V64L9R2>
References: <20240426183355.500364-1-jdamato@fastly.com>
 <20240426183355.500364-2-jdamato@fastly.com>
 <20240426130017.6e38cd65@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426130017.6e38cd65@kernel.org>

On Fri, Apr 26, 2024 at 01:00:17PM -0700, Jakub Kicinski wrote:
> On Fri, 26 Apr 2024 18:33:53 +0000 Joe Damato wrote:
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_port.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_port.c
> > @@ -151,7 +151,7 @@ void mlx4_en_fold_software_stats(struct net_device *dev)
> >  {
> >  	struct mlx4_en_priv *priv = netdev_priv(dev);
> >  	struct mlx4_en_dev *mdev = priv->mdev;
> > -	unsigned long packets, bytes;
> > +	unsigned long packets, bytes, dropped;
> >  	int i;
> >  
> >  	if (!priv->port_up || mlx4_is_master(mdev->dev))
> > @@ -159,14 +159,17 @@ void mlx4_en_fold_software_stats(struct net_device *dev)
> >  
> >  	packets = 0;
> >  	bytes = 0;
> > +	dropped = 0;
> >  	for (i = 0; i < priv->rx_ring_num; i++) {
> >  		const struct mlx4_en_rx_ring *ring = priv->rx_ring[i];
> >  
> >  		packets += READ_ONCE(ring->packets);
> >  		bytes   += READ_ONCE(ring->bytes);
> > +		dropped += READ_ONCE(ring->dropped);
> >  	}
> >  	dev->stats.rx_packets = packets;
> >  	dev->stats.rx_bytes = bytes;
> > +	dev->stats.rx_missed_errors = dropped;
> 
> I'd drop this chunk, there's a slight but meaningful difference in
> definition of rx_missed vs alloc-fail:
> 
>  * @rx_missed_errors: Count of packets missed by the host.
>  *   Folded into the "drop" counter in `/proc/net/dev`.
>  *
>  *   Counts number of packets dropped by the device due to lack
>  *   of buffer space. This usually indicates that the host interface
>  *   is slower than the network interface, or host is not keeping up
>  *   with the receive packet rate.
> ---
>         name: rx-alloc-fail
>         doc: |
>           Number of times skb or buffer allocation failed on the Rx datapath.
>           Allocation failure may, or may not result in a packet drop, depending
>           on driver implementation and whether system recovers quickly.
> 
> tl;dr "packets dropped" vs "may, or may not result in a packet drop"
> 
> In case of mlx4 looks like the buffer refill is "async", the driver
> tries to refill the buffers to max, but if it fails the next NAPI poll
> will try again. Allocation failures are not directly tied to packet
> drops. In case of bnxt if "replacement" buffer can't be allocated -
> packet is dropped and old buffer gets returned to the ring (although 
> if I'm 100% honest bnxt may be off by a couple, too, as the OOM stat
> gets incremented on ifup pre-fill failures).

Yes, I see that now. I'll drop this patch entirely from v3 and just leave
the other two and remove alloc_fail from the queue stats patch.

Thanks for the careful review.

