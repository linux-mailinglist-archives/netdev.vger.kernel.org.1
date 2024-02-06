Return-Path: <netdev+bounces-69356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5366984AC57
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 03:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A6B1C233F9
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 02:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712D6DCE4;
	Tue,  6 Feb 2024 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WyEjg2d1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131B57870
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187919; cv=none; b=C4/2p1BcxedAtwsN5fX72c9TvewdKChP372HSqxmggQKiydbuRaXhmbqzQmz8IM3C2eZdHTeXTzS7KsLazIZQXSwIO2KBU9+6DailGKvsP45SdF8t6DwbwDvrmQNyY7j/0rKht2nK0hhWiaxfpB66v7/K5ae+wd+DLomG4wgIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187919; c=relaxed/simple;
	bh=H20o2pRiAp3zDlj6ATk2ndhSE7u7Z7yBRRi7B1Fd9VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEYWyVC73Llw6dMprpt/Ee+UaWmV5Yu0lQc6zq/+8lB/+1p3UN/uCf10jQy8YzIeuyCV4c2iyQx5gRDBPt+R8YF6bZlRxX2HIkN+EikJxlmYcZQWlJN9N3/QeAk/IY2klhWtpP8A89YnAb0yzQfroPXpwqaNgsRfGSLdvV64NKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WyEjg2d1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d76671e5a4so41120895ad.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 18:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707187917; x=1707792717; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRmaSESydCye1Hb8v6UAZsKFe9t/+9o70Uany0m6D1I=;
        b=WyEjg2d1C5gA7WHPGdVE3dtYTyHWA+9bRppzSWee/EELVASTnU2bf1+ajzoVfE27d8
         FoWVPylSaruFyS8hdUyqdvCWJ5CWtKmIsARTvFjyXcFxXeibHQ9VqlgKb9dGKz1hAbOk
         0l/IXOhIgByj2Rcr/fsCo/eyXCcqVD1uk1NJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187917; x=1707792717;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRmaSESydCye1Hb8v6UAZsKFe9t/+9o70Uany0m6D1I=;
        b=T9CbwkJRPRqsBSzynCqwvVfwonJCq2o+jhRTktbU4LKP42j3M5H5dpFLjOoDAgxK45
         7FcKuB80GeW7zDCT99zf71jOxft/Xsadn96eWJjV3xoijCkC5JIFDq3a3wLYnwKGIy8v
         622DnfWGBpK4sJz112/SyC213tC1fCghFp1F/NttOl7fnD/McjZZzqqY9zo33ETo/guA
         sBlHUpBeH2w7k2USf5Y/HcOLVgjR9iSDa41p4IdOc7PTIBsKZOoO4Diy14cDSgHU2d74
         4GMLNAE28sSkR0E2qwvRsh/O1rvjqTm+gEr+BGXlDkisD4vEOGiTta6mFeZutg1j/QvB
         WL2w==
X-Gm-Message-State: AOJu0YzBF2j/2bPxchW08hpWdgZUPGPtBzCQ0oZL8eRkyb2dUa1P2sxo
	A6gauxb3nc5HCxM7f1VcPl8zc4UWYeMgArkl5EJidQSWV2zSMJjLmm3fx5OQ9+o=
X-Google-Smtp-Source: AGHT+IGXrYULDcQXPMN47tiyvO4o5wW9ipPo6hAslswaupw5MVYTStW+rdwUzXOweN3lE/gIJUnt8A==
X-Received: by 2002:a17:903:11d1:b0:1d9:859f:b529 with SMTP id q17-20020a17090311d100b001d9859fb529mr553891plh.19.1707187917497;
        Mon, 05 Feb 2024 18:51:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU9bZ1WC8hcxV9Y1WfuNZk+4rS0vmwVdNP40966oBIlZQcjEkOXNgUEyoaNGSIPgAg1c6bA/Fz4rS7lvMxmofCuYiLS7j/ahCGNezmKeTPy1MZ8Jl1GztxxcQVeon7P4dsLSz4qUFwmtC5Ph+dPBjgDKQ4R7IXTaePmiufAxX3gjbfa8Cha+KrBYcaz+3L4sZIaG+y1ie4P/N65iQEidqN45PsxJthEWgMMwze7oxCQyB0eZ9hp1zH27Oi2XetcKorlAjueB5RmaqEWWoGD3yyCHm88WsOmlbyVi0hSgDwBwTvv96/M6oQ=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id jg14-20020a17090326ce00b001d9711d3e83sm606826plb.204.2024.02.05.18.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 18:51:57 -0800 (PST)
Date: Mon, 5 Feb 2024 18:51:54 -0800
From: Joe Damato <jdamato@fastly.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and
 IRQs
Message-ID: <20240206025153.GA11388@fastly.com>
References: <20240206010311.149103-1-jdamato@fastly.com>
 <878r3ymlnk.fsf@nvidia.com>
 <20240206013246.GA11217@fastly.com>
 <874jemml1j.fsf@nvidia.com>
 <20240206014151.GA11233@fastly.com>
 <87zfwel5qi.fsf@nvidia.com>
 <20240206015657.GA11257@fastly.com>
 <87sf26l3go.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf26l3go.fsf@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Mon, Feb 05, 2024 at 06:38:41PM -0800, Rahul Rameshbabu wrote:
> On Mon, 05 Feb, 2024 17:56:58 -0800 Joe Damato <jdamato@fastly.com> wrote:
> > On Mon, Feb 05, 2024 at 05:44:27PM -0800, Rahul Rameshbabu wrote:
> >> 
> >> On Mon, 05 Feb, 2024 17:41:52 -0800 Joe Damato <jdamato@fastly.com> wrote:
> >> > On Mon, Feb 05, 2024 at 05:33:39PM -0800, Rahul Rameshbabu wrote:
> >> >> 
> >> >> On Mon, 05 Feb, 2024 17:32:47 -0800 Joe Damato <jdamato@fastly.com> wrote:
> >> >> > On Mon, Feb 05, 2024 at 05:09:09PM -0800, Rahul Rameshbabu wrote:
> >> >> >> On Tue, 06 Feb, 2024 01:03:11 +0000 Joe Damato <jdamato@fastly.com> wrote:
> >> >> >> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >> >> >> > index c8e8f512803e..e1bfff1fb328 100644
> >> >> >> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >> >> >> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >> >> >> > @@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
> >> >> >> >  	mlx5e_close_tx_cqs(c);
> >> >> >> >  	mlx5e_close_cq(&c->icosq.cq);
> >> >> >> >  	mlx5e_close_cq(&c->async_icosq.cq);
> >> >> >> > +
> >> >> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
> >> >> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
> >> >> >> 
> >> >> >> This should be set to NULL *before* actually closing the rqs, sqs, and
> >> >> >> related cqs right? I would expect these two lines to be the first ones
> >> >> >> called in mlx5e_close_queues. Btw, I think this should be done in
> >> >> >> mlx5e_deactivate_channel where the NAPI is disabled.
> >> >> >> 
> >> >> >> >  }
> >> >> >> >  
> >> >> >> >  static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
> >> >> >> > @@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
> >> >> >> >  	c->stats    = &priv->channel_stats[ix]->ch;
> >> >> >> >  	c->aff_mask = irq_get_effective_affinity_mask(irq);
> >> >> >> >  	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
> >> >> >> > +	c->irq		= irq;
> >> >> >> >  
> >> >> >> >  	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
> >> >> >> >  
> >> >> >> > @@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
> >> >> >> >  		mlx5e_activate_xsk(c);
> >> >> >> >  	else
> >> >> >> >  		mlx5e_activate_rq(&c->rq);
> >> >> >> > +
> >> >> >> > +	netif_napi_set_irq(&c->napi, c->irq);
> >> >> 
> >> >> One small comment that I missed in my previous iteration. I think the
> >> >> above should be moved to mlx5e_open_channel right after netif_napi_add.
> >> >> This avoids needing to save the irq in struct mlx5e_channel.
> >> >
> >> > I couldn't move it to mlx5e_open_channel because of how safe_switch_params
> >> > and the mechanics around that seem to work (at least as far as I could
> >> > tell).
> >> >
> >> > mlx5 seems to create a new set of channels before closing the previous
> >> > channel. So, moving this logic to open_channels and close_channels means
> >> > you end up with a flow like this:
> >> >
> >> >   - Create new channels (NAPI netlink API is used to set NAPIs)
> >> >   - Old channels are closed (NAPI netlink API sets NULL and overwrites the
> >> >     previous NAPI netlink calls)
> >> >
> >> > Now, the associations are all NULL.
> >> >
> >> > I think moving the calls to active / deactivate fixes that problem, but
> >> > requires that irq is stored, if I am understanding the driver correctly.
> >> 
> >> I believe moving the changes to activate / deactivate channels resolves
> >> this problem because only one set of channels will be active, so you
> >> will no longer have dangling association conflicts for the queue ->
> >> napi. This is partially why I suggested the change in that iteration.
> >
> > As far as I can tell, it does.
> >  
> >> As for netif_napi_set_irq, that alone can be in mlx5e_open_channel (that
> >> was the intention of my most recent comment. Not that all the other
> >> associations should be moved as well). I agree that the other
> >> association calls should be part of activate / deactivate channels.
> >
> > OK, sure that makes sense. I make that change, too.
> >
> 
> Also for your v2, it would be great if you can use the commit message
> subject 'net/mlx5e: link NAPI instances to queues and IRQs' rather than
> 'eth: mlx5: link NAPI instances to queues and IRQs'.

Didn't see this before I sent it. If it matters that much, I can send a v3
with an updated commit message.

