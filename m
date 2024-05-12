Return-Path: <netdev+bounces-95816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8268C37FE
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 20:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB2E1C20C5F
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFC44436B;
	Sun, 12 May 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wdMvA4Qv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A203AF4F1
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715539046; cv=none; b=d7xv6nn/lo3Rh688hTTZYyf40KnuYthFTkzq11FK7ruySqrQiEeNws98XG0B01mx8Zy0rzpwNcMjvM4cURfnTIk6Ci3z+tBxeZM2H2hBgOMLnmKp9rbtePnrnnz0+1E09m+ddWizc3/SF2/87oPN1R2wN816mVfGtBGIyFXSTI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715539046; c=relaxed/simple;
	bh=EsBxKjiK3YT2IXz67XdPLB6hnSXRyOnEnLz6QQoWq/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkjnEYDgR48uFGCoUCn+rDwpJUszWUxK7fEQEt3h9PIjh0hzr9/2viu0MYcYK2Ucl3TeWxF7deI15faNlo6yoRwR76B5eVDguclRpi5ZCoju4t50+k8jCkUsWN2+rLNztJQMBR22McfKF6rOTptGMsrLhq42i5OaMWBmduMA7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wdMvA4Qv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec486198b6so26590085ad.1
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715539044; x=1716143844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvDALX2Uri5RTgIn6pzRLr5p/TpABW6ze+cHJXhnhz0=;
        b=wdMvA4QvO9dUJ6/CsD1KXqndM/gwWX/PlXL09eiIqLKMVjvLAyYRzkLxxbOa8OgN9K
         TiiYmLKLrMg71pBy5XAc1Hwp1Fmeli8fVtTmj36MHgcMccKSQk5IfwlCpxUz0rXFYhEG
         8zPbHhf+BSqCyEcSzNLG09alINutQhD5JTv5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715539044; x=1716143844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvDALX2Uri5RTgIn6pzRLr5p/TpABW6ze+cHJXhnhz0=;
        b=GxW9QPoaIOWdyUeYnmS+HVI5Cyk2M2gxKeenjRW/Fm71MHhPNPb8RUASV2ICzey6cP
         PhnPyo6zHolJCWOPqmen/ZjzAWHZauRxlUrsqIxlg7Kw2eUUtEexFWjeXaEkfC/zjLWb
         YZ+4JrHJQB4Jrq3giXidrZsmxM1I7RhERIj+4MQOkzSYsE/7+x2+3AjyjpzdKSj71oTZ
         9W6+ymXAJP+mtCZUCPsp/imG6fhKkvPRaASe08G3AXlfT/VCygnAPaW3PAUZJHh/L+yG
         obQ/ycDOZm5Bsen5davWMSzm2JjbHBwCwYfQDOnqjD9FnEPJq5tHWoxEFezYxBNObuoi
         7Lmg==
X-Forwarded-Encrypted: i=1; AJvYcCX0Kv8z8xTwhhlcUcfS9jK6H87N5PSkXhiv4SB1D3mzLxaWA0pkDo9zdMlP/obrYUBfS95zrTAVrlSNJuxcPddAr1/2xEzp
X-Gm-Message-State: AOJu0YzXGHIeinhPK+dBgHnU7IXaGYodmQw1BJKBgVP/YexTIjGLQ/0h
	6AWF4g//LPAICQ0Y8LpigG0TAjQfYb1dc1lvHZElT5XmSUQN0VJ175Qol4/Gjzs=
X-Google-Smtp-Source: AGHT+IFkxbq3Rkzvs5WbT/T22/l24x4EHoOEeAsDjLGj1lSmdme4hW/JDJacIPGNIS8Nz9h/fW+3zQ==
X-Received: by 2002:a17:903:2442:b0:1e4:17e4:3a1f with SMTP id d9443c01a7336-1ef43d2e2b7mr105905115ad.4.1715539043815;
        Sun, 12 May 2024 11:37:23 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1a57sm64970295ad.11.2024.05.12.11.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 11:37:23 -0700 (PDT)
Date: Sun, 12 May 2024 11:37:20 -0700
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, nalramli@fastly.com,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/3] net/mlx4: Track RX allocation failures
 in a stat
Message-ID: <ZkEMYDP586iKp1vT@LQ3V64L9R2>
References: <20240509205057.246191-1-jdamato@fastly.com>
 <20240509205057.246191-2-jdamato@fastly.com>
 <a4efd162-5dc0-4ed1-b875-de12521a6618@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4efd162-5dc0-4ed1-b875-de12521a6618@gmail.com>

On Sun, May 12, 2024 at 11:17:09AM +0300, Tariq Toukan wrote:
> 
> 
> On 09/05/2024 23:50, Joe Damato wrote:
> > mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
> > fails but does not increment a stat field when this occurs.
> > 
> > A new field called alloc_fail has been added to struct mlx4_en_rx_ring
> > which is now incremented in mlx4_en_rx_ring when -ENOMEM occurs.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > ---
> >   drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 4 +++-
> >   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h | 1 +
> >   2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > index 8328df8645d5..15c57e9517e9 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > @@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
> >   	for (i = 0; i < priv->num_frags; i++, frags++) {
> >   		if (!frags->page) {
> > -			if (mlx4_alloc_page(priv, frags, gfp))
> > +			if (mlx4_alloc_page(priv, frags, gfp)) {
> > +				ring->alloc_fail++;
> >   				return -ENOMEM;
> > +			}
> >   			ring->rx_alloc_pages++;
> >   		}
> >   		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> > index efe3f97b874f..cd70df22724b 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> > +++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> > @@ -355,6 +355,7 @@ struct mlx4_en_rx_ring {
> >   	unsigned long xdp_tx;
> >   	unsigned long xdp_tx_full;
> >   	unsigned long dropped;
> > +	unsigned long alloc_fail;
> >   	int hwtstamp_rx_filter;
> >   	cpumask_var_t affinity_mask;
> >   	struct xdp_rxq_info xdp_rxq;
> 
> Counter should be reset in mlx4_en_clear_stats().

OK, thanks. I'll add that to the v5, alongside any other feedback that
comes in within the next ~24 hours or so.

> BTW, there are existing counters that are missing there already.
> We should add them as well, not related to your series though...

Yea, I see what you mean about the other counters. I think those can
potentially be sent as a 'Fixes' later?

