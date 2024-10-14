Return-Path: <netdev+bounces-135116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA999C5D2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191EA1C22642
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8432015852F;
	Mon, 14 Oct 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDhmbHqK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603ED13DDAA
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898422; cv=none; b=ojFG5StipIroqGaNgvIHc6MAoPTNKo06Cy6Co+R8iM67gIqyrjD7ruCUHFnw5m1SHCBKwthHI46goKPiFp3Cd4DXjIecazu9/Km07vYfJn0jsGcOwk+udocnD1Frsbpnm9JZzpTa2f0bklU31e8EEp+Hz/EZZjh37I31MuHqey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898422; c=relaxed/simple;
	bh=xD/7Z17GUo3FS/Qwf2HwQrZxZeU5+TIPnrejZZPnquk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bot4YvBK0nhQ3xs5q4y8rgEXgXF14cmKz50lBWjXH8HbUAF1or8wNHY6ZYayi9rQ6x82Z8AjwSSG9/JDGM2fwqEjI1kkWUqi0fqNJ/DUlRYW+tjpMTDX7zx0WF+BcyPWZUVI+8QAUdwq/mw90fKSoZkRYfjGGVQY3jEGt0TTak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDhmbHqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8CFC4CEC3;
	Mon, 14 Oct 2024 09:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728898421;
	bh=xD/7Z17GUo3FS/Qwf2HwQrZxZeU5+TIPnrejZZPnquk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDhmbHqKdum/XDffbbarHgahvqp4Ct2tXEHoBR9xoWFXdtfzqpKaRdp3/Ua9VZZUA
	 AmVP0yd/mGN1na5DajVA5oxlp5olOlAqf1FgkM9YZ9zXDUhmAtQGa4iHCkNQzBUpeW
	 WdOv/GO418BP6zXcCB5ZTE/lxP8xgqeH2bFYtlPP+bg1ftzXPgOW02TXPhqmWyBOMH
	 aBqKCGA7AfvAhCIZdkoIUnpISHYNtN7UyErQZE4CLcaSALKjTLOwbK8p3krfsKk5pq
	 ZqfKYm/1wnNpZ2vyh017oEvpTzF7SRQV7F5nQK9hcF7ig+jbGBnfkgbWAmec2N4ZlM
	 KF2iO36R1UW2A==
Date: Mon, 14 Oct 2024 10:33:37 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, cjubran@nvidia.com,
	cratiu@nvidia.com
Subject: Re: [PATCH net-next 08/15] net/mlx5: Refactor vport QoS to use
 scheduling node structure
Message-ID: <20241014093337.GR77519@kernel.org>
References: <20241013064540.170722-1-tariqt@nvidia.com>
 <20241013064540.170722-9-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013064540.170722-9-tariqt@nvidia.com>

On Sun, Oct 13, 2024 at 09:45:33AM +0300, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Refactor the vport QoS structure by moving group membership and
> scheduling details into the `mlx5_esw_sched_node` structure.
> 
> This change consolidates the vport into the rate hierarchy by unifying
> the handling of different types of scheduling element nodes.
> 
> In addition, add a direct reference to the mlx5_vport within the
> mlx5_esw_sched_node structure, to ensure that the vport is easily
> accessible when a scheduling node is associated with a vport.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Hi Carolina and Tariq,

Some minor feedback from my side.

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c

...

> +struct mlx5_esw_sched_node *
> +mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
>  {
> -	list_del_init(&vport->qos.parent_entry);
> -	vport->qos.parent = parent;
> -	list_add_tail(&vport->qos.parent_entry, &parent->children);
> +	if (!vport->qos.sched_node)
> +		return 0;

As the return type of this function is a pointer,
perhaps returning NULL would be more appropriate.

...

> @@ -718,18 +750,26 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
>  		return err;
>  
>  	err = esw_qos_vport_create_sched_element(vport, esw->qos.node0, max_rate, bw_share,
> -						 &vport->qos.esw_sched_elem_ix);
> +						 &sched_elem_ix);
>  	if (err)
>  		goto err_out;
>  
> -	INIT_LIST_HEAD(&vport->qos.parent_entry);
> -	esw_qos_vport_set_parent(vport, esw->qos.node0);
> +	vport->qos.sched_node = __esw_qos_alloc_rate_node(esw, sched_elem_ix, SCHED_NODE_TYPE_VPORT,
> +							  esw->qos.node0);
> +	if (!vport->qos.sched_node)

Should err be set to a negative error value here so that value will be
returned?

> +		goto err_alloc;
>  
>  	vport->qos.enabled = true;
> +	vport->qos.sched_node->vport = vport;
> +
>  	trace_mlx5_esw_vport_qos_create(vport->dev, vport, bw_share, max_rate);
>  
>  	return 0;
>  
> +err_alloc:
> +	if (mlx5_destroy_scheduling_element_cmd(esw->dev,
> +						SCHEDULING_HIERARCHY_E_SWITCH, sched_elem_ix))
> +		esw_warn(esw->dev, "E-Switch destroy vport scheduling element failed.\n");
>  err_out:
>  	esw_qos_put(esw);
>  

...

> @@ -746,20 +787,23 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
>  	esw_qos_lock(esw);
>  	if (!vport->qos.enabled)
>  		goto unlock;
> -	WARN(vport->qos.parent != esw->qos.node0,
> +	vport_node = vport->qos.sched_node;
> +	WARN(vport_node->parent != esw->qos.node0,
>  	     "Disabling QoS on port before detaching it from node");
>  
> -	dev = vport->qos.parent->esw->dev;
> +	trace_mlx5_esw_vport_qos_destroy(dev, vport);

dev does not appear to be initialised here.

> +
> +	dev = vport_node->esw->dev;
>  	err = mlx5_destroy_scheduling_element_cmd(dev,
>  						  SCHEDULING_HIERARCHY_E_SWITCH,
> -						  vport->qos.esw_sched_elem_ix);
> +						  vport_node->ix);
>  	if (err)
>  		esw_warn(dev,
>  			 "E-Switch destroy vport scheduling element failed (vport=%d,err=%d)\n",
>  			 vport->vport, err);
>  
> +	__esw_qos_free_node(vport_node);
>  	memset(&vport->qos, 0, sizeof(vport->qos));
> -	trace_mlx5_esw_vport_qos_destroy(dev, vport);
>  
>  	esw_qos_put(esw);
>  unlock:

...

