Return-Path: <netdev+bounces-142264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7EA9BE15B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2529C1F244DC
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3131D79B1;
	Wed,  6 Nov 2024 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0rULdsM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663201D54F2
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883279; cv=none; b=tt9I3ZFoxCtS8YXVf7mom/F4NFFpbrheT3OlGF9QMwtNOcfpmp8LvhdXcgt60mSrsLND3CdJhVBJ0DU4hrM+HYKGebjSJHB8kZh/zqPQ9BMwF41fBttt8XwZuxUjjOXSQtg8RkfbG9h05VXPx4D/gNAYj5Xfgut+90IfRnUAMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883279; c=relaxed/simple;
	bh=UNYKLzF4r5hBnINqn9birE+zQ/11rAm97XqSomm41EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGupLpMJtGqDlkDScjmWUWt7Ws0IX9bjJxSV6Zkn9gQaqsJZLwj0Y7DQte89NkI85rT2Tt6OyFNoPerkVzUk1bUWrcb9IKstrfk0vca9p0VkN5fAGxtcjXHSKOnE5lDArRcLLeR/6xo/rn0C9oH/LV7gbkm9EHpSKbTsP2Xe2c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0rULdsM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730883276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fmyYpFxsyQqqojb1lv2cOtlXLCoNWTfRHptpZLl1D5g=;
	b=B0rULdsMtxkMBAhE8H1InLd8OlFhkl8F6FFtoMj4T84AcjT+mivW848GFZCdJVqmHDlz+a
	DZ1HeBiBWSpW2i4IQbqqrYqGggpVuKD7UGuUJhFpSsNY8JNQEYLieuoOaE2Ry2T3SrIQr6
	lU3zr56Z6++7b0JypPHZ+Zn7KjedAKw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-m0Hzs00aPtSWYk6EQ2B2Qw-1; Wed, 06 Nov 2024 03:54:33 -0500
X-MC-Unique: m0Hzs00aPtSWYk6EQ2B2Qw-1
X-Mimecast-MFC-AGG-ID: m0Hzs00aPtSWYk6EQ2B2Qw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d47fdbbd6so3595286f8f.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 00:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883272; x=1731488072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmyYpFxsyQqqojb1lv2cOtlXLCoNWTfRHptpZLl1D5g=;
        b=Ju13QofCl+MYhGnVJtjmw+DJojV0A4CJFqeALuneKaG9UAyZ8erZAyVi4kwkrFRhAg
         hbZWobdx7t7OfIYtARqukk/lEwYndNc/Hj7ozNctoBb23RlXH4pORiMum32rlfrLuIh6
         J9uKxur8o+hkOxUORH36/PJX7MWxI2j5uXVO5L5VU7Ois3STKUR8/3i8jihB0GJPbiAD
         xruS4wpJQlnviHt8stjNETbviI11A2l9OtwfuG0AMpZWtUjFXj8pTR+lWIlMDyf5xzQ1
         7qpjgVvP0n+o9uV+p18+NntDNfHAs3FjP+hI2iPyKkNsmMdDgTlezmXlHmAEqQxVjJm+
         SLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUJIjoNxNjNyPFTklCqDq+mY3YhBJeRSdwj8tEI1ZSgQgVCn3wzlYV7f1aFn5czRqtqvxtSYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdryFficgkG5FVx7B4aj8InX/vpRNW0Aa2rslRT3bdOqiFCatJ
	hNfB+sY5Iz6nQkB5Vatc856qKLoDOTR12oULkzVJ8i0Knj9tgBTjv/thLlhXUqLJIfHELQXYiar
	g/cYrLYj+Eo18bA73P8bkzrPpPYraw//e6M3xWznzp2DV4lRz8YU2Jg==
X-Received: by 2002:a05:6000:4601:b0:381:e702:af15 with SMTP id ffacd0b85a97d-381e702b189mr2660252f8f.37.1730883271946;
        Wed, 06 Nov 2024 00:54:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEs4dAlZ/Ixnt7FpOJvTxE+WzTktExbu7DVSB0TSOaCg2HjETlp7pqbWm4LVa4ZdPMRcAZxg==
X-Received: by 2002:a05:6000:4601:b0:381:e702:af15 with SMTP id ffacd0b85a97d-381e702b189mr2660237f8f.37.1730883271620;
        Wed, 06 Nov 2024 00:54:31 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1168afcsm18469576f8f.91.2024.11.06.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:54:30 -0800 (PST)
Date: Wed, 6 Nov 2024 03:54:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: Set num_buffers for virtio 1.0
Message-ID: <20241106035029-mutt-send-email-mst@kernel.org>
References: <20240915-v1-v1-1-f10d2cb5e759@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915-v1-v1-1-f10d2cb5e759@daynix.com>

On Sun, Sep 15, 2024 at 10:35:53AM +0900, Akihiko Odaki wrote:
> The specification says the device MUST set num_buffers to 1 if
> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> 
> Fixes: 41e3e42108bc ("vhost/net: enable virtio 1.0")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

True, this is out of spec. But, qemu is also out of spec :(

Given how many years this was out there, I wonder whether
we should just fix the spec, instead of changing now.

Jason, what's your take?


> ---
>  drivers/vhost/net.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f16279351db5..d4d97fa9cc8f 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1107,6 +1107,7 @@ static void handle_rx(struct vhost_net *net)
>  	size_t vhost_hlen, sock_hlen;
>  	size_t vhost_len, sock_len;
>  	bool busyloop_intr = false;
> +	bool set_num_buffers;
>  	struct socket *sock;
>  	struct iov_iter fixup;
>  	__virtio16 num_buffers;
> @@ -1129,6 +1130,8 @@ static void handle_rx(struct vhost_net *net)
>  	vq_log = unlikely(vhost_has_feature(vq, VHOST_F_LOG_ALL)) ?
>  		vq->log : NULL;
>  	mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
> +	set_num_buffers = mergeable ||
> +			  vhost_has_feature(vq, VIRTIO_F_VERSION_1);
>  
>  	do {
>  		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
> @@ -1205,7 +1208,7 @@ static void handle_rx(struct vhost_net *net)
>  		/* TODO: Should check and handle checksum. */
>  
>  		num_buffers = cpu_to_vhost16(vq, headcount);
> -		if (likely(mergeable) &&
> +		if (likely(set_num_buffers) &&
>  		    copy_to_iter(&num_buffers, sizeof num_buffers,
>  				 &fixup) != sizeof num_buffers) {
>  			vq_err(vq, "Failed num_buffers write");
> 
> ---
> base-commit: 46a0057a5853cbdb58211c19e89ba7777dc6fd50
> change-id: 20240908-v1-90fc83ff8b09
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


