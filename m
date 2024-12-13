Return-Path: <netdev+bounces-151895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8829F181C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 22:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A741644F8
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9217F192B84;
	Fri, 13 Dec 2024 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Qh5UyClu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE0186294
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126085; cv=none; b=q25qJOU1GhleeoG9GZLeySbtjt3hKo2kGbbLAO5ItQ5rHffmQPRiQeGfiolTqJT1fpkps7S98liMHhcNzIyowAu5XY2fWD2Tlalq+EJSLXJn6zWBZ/k1hTizimOcZkyjqy1YfPSFmNH7Y/QBwgtRN79SOwU1SByEsJy8LARXVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126085; c=relaxed/simple;
	bh=zTw26Y7OzbKOvlxIYxsgIZdcYna385VZJQI77fddmMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWfLl49aetQrBHCPOb9vqQNDE+/zskY/2kNP7fumjP9zLQt890cA7873xyfFVkRtiowQXbjMy4+vF+3CBRiAtLbOOo0bx5uFi5jRNKCtV79y3UFDMK/IFp+5tBhxngpfN0GjZ6iFQn1b7ArSu4HSO1v2DkuIGbvWWE0Nzmoks0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Qh5UyClu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72909c459c4so1084815b3a.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734126083; x=1734730883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYYZ/R00ivPL1c0reAqtix6sUfCk3p5lfmf8zGLOIbw=;
        b=Qh5UyCluqbeZvpO8kpwDhJlvPFaOD18v0F8JM447hxhtSiPjpJMX63/+vGc72exV+3
         Xrzv5MR8KC5OCIFuoL+9GDG3LiXjDAaJpk0SRMGF2b0GtTuc+GAxqszl8GqIPtr2OMee
         tRWuK4+nc7K5Dp5XYbr8dvUW69ekaeoNKtKDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734126083; x=1734730883;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYYZ/R00ivPL1c0reAqtix6sUfCk3p5lfmf8zGLOIbw=;
        b=dHbxcZH3IFWzuzIeyZVBowxsz+zM35JdtXd702Vru3/H7UVFpmSclym9o0balQorA9
         Pv8Iy5xeXkqPN8HIY/vNcIJEXLzUIwmpGw099wacIKTGLLZwxcD7gkOVmNBwjpkKPv0P
         b8McsSwNxUeOkflLSA3oNV+EGom5aJiTr/0EnN7tlnpo/k+tjNnSTk8G+oqpmcV9irMU
         W6u59v5LQZIVGl9ZvxIkBmglenKjKD1tmsn9e9FWUL4pY1R5uvQ22ILPM2GRxQClc/yf
         /lQlWYhoE9hNar/+D6n5QGGgLA9+DT2KA5Myb55PJ4xOai6Z6LX6LbOJd7YhNwOdtiT7
         ruPg==
X-Forwarded-Encrypted: i=1; AJvYcCVOP/tOIKlHAS7ieo0BXODL+FzRdC5sVyrIWVxzb3bYgMGVu+80w8230T0siPNBfuptG9u8aMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBMRt9er8TMZYu8psTMM6Ma8lYL4ur2zZ2FE99MRL1kq1orvq4
	wA5eV6bYoB8vdxCl1rrh7DEvGKh0RdF6DIhbK/S0SrMdCqmjSzZhCRfsRcTO+u8=
X-Gm-Gg: ASbGnct+ggoaMnUlbjcrKd04NHqwyKWLBtRgsbxlda4yvzLoYBzTE8zmiHbO3qq66j9
	VKf5nFfb4nEnTymTOwzq7y9LaswhbU9Flq4JYotNDxCbpiTCISpizdHlJ0nWyGTHgqA53SfQ7fE
	bVXXcHBteWSTYuhWANntE9udtBtdgMrT2g0tDdq+pr6HClZ7jmVwT1oSNK4qv3+K37JnCNhsRNp
	L7NW/bKJAm+z4FX4W43NnBqP+UekK2bZr70OMJ+qMl0NltsciUjsWETlQX78r94nV7WMkPhFvFn
	w6fFVLFiOeVhzgUYHo80GqD+7eBk
X-Google-Smtp-Source: AGHT+IEWVbcadVHttNGvh1FMzCYjlgc4sx4n0D3Pyl+868sh17GjBrmHKBccX778WhViCSEVTXbGkw==
X-Received: by 2002:a17:90b:5108:b0:2ee:e18b:c1fa with SMTP id 98e67ed59e1d1-2f2900a986dmr5585484a91.28.1734126083065;
        Fri, 13 Dec 2024 13:41:23 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2434a3fsm236676a91.35.2024.12.13.13.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:41:22 -0800 (PST)
Date: Fri, 13 Dec 2024 13:41:20 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, almasrymina@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com
Subject: Re: [PATCH net 1/5] netdev: fix repeated netlink messages in queue
 dump
Message-ID: <Z1yqANqrEGyvWboT@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	almasrymina@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com
References: <20241213152244.3080955-1-kuba@kernel.org>
 <20241213152244.3080955-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213152244.3080955-2-kuba@kernel.org>

On Fri, Dec 13, 2024 at 07:22:40AM -0800, Jakub Kicinski wrote:
> The context is supposed to record the next queue do dump,

extremely minor nit: "next queue to dump" ?

[...]
 
> Fixes: 6b6171db7fc8 ("netdev-genl: Add netlink framework functions for queue")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jdamato@fastly.com
> CC: almasrymina@google.com
> CC: amritha.nambiar@intel.com
> CC: sridhar.samudrala@intel.com
> ---
>  net/core/netdev-genl.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 9527dd46e4dc..9f086b190619 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -488,24 +488,21 @@ netdev_nl_queue_dump_one(struct net_device *netdev, struct sk_buff *rsp,
>  			 struct netdev_nl_dump_ctx *ctx)
>  {
>  	int err = 0;
> -	int i;
>  
>  	if (!(netdev->flags & IFF_UP))
>  		return err;
>  
> -	for (i = ctx->rxq_idx; i < netdev->real_num_rx_queues;) {
> -		err = netdev_nl_queue_fill_one(rsp, netdev, i,
> +	for (; ctx->rxq_idx < netdev->real_num_rx_queues; ctx->rxq_idx++) {
> +		err = netdev_nl_queue_fill_one(rsp, netdev, ctx->rxq_idx,
>  					       NETDEV_QUEUE_TYPE_RX, info);
>  		if (err)
>  			return err;
> -		ctx->rxq_idx = i++;
>  	}
> -	for (i = ctx->txq_idx; i < netdev->real_num_tx_queues;) {
> -		err = netdev_nl_queue_fill_one(rsp, netdev, i,
> +	for (; ctx->txq_idx < netdev->real_num_tx_queues; ctx->txq_idx++) {
> +		err = netdev_nl_queue_fill_one(rsp, netdev, ctx->txq_idx,
>  					       NETDEV_QUEUE_TYPE_TX, info);
>  		if (err)
>  			return err;
> -		ctx->txq_idx = i++;
>  	}
>  
>  	return err;

Reviewed-by: Joe Damato <jdamato@fastly.com>

