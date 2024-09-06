Return-Path: <netdev+bounces-126031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E45C96FB2B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 20:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F22D1F277B1
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D971B85C8;
	Fri,  6 Sep 2024 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7vN0sZL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3351B85C4
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646885; cv=none; b=cGijmOHe6U70fUugU0DJ1jqXFlKz6OpYwuVDMsACqx7ZPtms1WdZNCfBtzMcOS8vL79FMfabMafGtKvC1x38mG+ih9jM+wlUwLk9rJc1GNb0kDhyUcgc43WVeCCHIQ2dbpm0FVQKf1/NiTCIKroeNjEUUqVDwwwAIg/CRpC+e48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646885; c=relaxed/simple;
	bh=BjBHk3+UHXT8eRjY0dxh5QmsL7S9JeZOUcbGpgxNDcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNmfksa+Np0ei/r+mh4oY91ZC+Y3ITvJsc1YrREoIfnsT2138DIkyRMD1621SQDqXiZQYOXhsBj5p8W4SeGoF6znPzKJBZxXpLWr6LLACmEEQpha7jPtIRdrFmWzQEnXGOYOqT2IbcajJ3n6e/7qGHuTkj3W9VmiBUwZ8DxeoHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7vN0sZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06816C4CEC7;
	Fri,  6 Sep 2024 18:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725646884;
	bh=BjBHk3+UHXT8eRjY0dxh5QmsL7S9JeZOUcbGpgxNDcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7vN0sZLkusqpYd40KE/xj8U04hzdMuqqI/aUw7nZHebLdv2Ha2KGKfK6Rzf2BpM1
	 cgKIZ+zqVApPHbivcfY3w2ZGlKSr8vOvecEGOhUv3tFA9DY65NQTMkJoWrH7KnYthR
	 ZAdso62TzYrS4pyvXzDyjhl5p9g18bU1E8C54YOVRVqF9nQVY+wH712//CZlRx9Q1G
	 JZS28dMT9UGcOhIBTco93O2h5KyU1f2T2FkArLsl3eSlWk7LMo8kKZ+g0xZuFnH8lX
	 8lgy1eVVOMHdwM6tFajv4qFkBuFQcUXlbZb97xjhGoZigCYTHL0HJfrIwddjgSOp0K
	 aKJ+FYyRP+h7Q==
Date: Fri, 6 Sep 2024 19:21:19 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Itamar Gozlan <igozlan@nvidia.com>
Subject: Re: [net-next V2 14/15] net/mlx5: HWS, added send engine and context
 handling
Message-ID: <20240906182119.GJ2097826@kernel.org>
References: <20240905062752.10883-1-saeed@kernel.org>
 <20240905062752.10883-15-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905062752.10883-15-saeed@kernel.org>

On Wed, Sep 04, 2024 at 11:27:49PM -0700, Saeed Mahameed wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> Added implementation of send engine and handling of HWS context.
> 
> Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

...

> +static int hws_send_ring_open_cq(struct mlx5_core_dev *mdev,
> +				 struct mlx5hws_send_engine *queue,
> +				 int numa_node,
> +				 struct mlx5hws_send_ring_cq *cq)
> +{
> +	void *cqc_data;
> +	int err;
> +
> +	cqc_data = kvzalloc(MLX5_ST_SZ_BYTES(cqc), GFP_KERNEL);
> +	if (!cqc_data)
> +		return -ENOMEM;
> +
> +	MLX5_SET(cqc, cqc_data, uar_page, mdev->priv.uar->index);
> +	MLX5_SET(cqc, cqc_data, cqe_sz, queue->num_entries);
> +	MLX5_SET(cqc, cqc_data, log_cq_size, ilog2(queue->num_entries));
> +
> +	err = hws_send_ring_alloc_cq(mdev, numa_node, queue, cqc_data, cq);
> +	if (err) {
> +		goto err_out;
> +		return err;

Hi Saeed, Yevgeny, all,

A minor nit: the line above cannot be reached.

Flagged by Smatch.

> +	}
> +
> +	err = hws_send_ring_create_cq(mdev, queue, cqc_data, cq);
> +	if (err)
> +		goto err_free_cq;
> +
> +	kvfree(cqc_data);
> +
> +	return 0;
> +
> +err_free_cq:
> +	mlx5_wq_destroy(&cq->wq_ctrl);
> +err_out:
> +	kvfree(cqc_data);
> +	return err;
> +}

...

