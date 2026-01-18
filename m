Return-Path: <netdev+bounces-250778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B873CD3922E
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73C27300ACC2
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 02:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200211E5201;
	Sun, 18 Jan 2026 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vInzlM8T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18AC2BB13
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 02:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703283; cv=none; b=NccHMQR6TJ0tHX9zJYxcACL7AhUxPHGmwW2TBtTFecj6kX+aqcYuQ4dy/bxOwnPR6+HQQu7vObMudlbT35KlNxoyFOfKraK4dPtmIDPQnlfgHVngp85Z7Wrv8sR6UouF8VLwLW/dvvvvJswg7p/PdwrNtLn8fJzNxDm1xSNkiic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703283; c=relaxed/simple;
	bh=cAzUT8OIyU3N18hB1bnswPp+VzqqcnjQeFBVJipb2zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jb1FEGVYSMm8s6iqb6ice/Hfc8KvViDH2eDkKwIW8CzvZN2GRWeWKs9RN4ReltGKOT0YR6fqlGHBjUuVpR847WNn3wUyEhTg1n/HI35okqYZNqez8okW6Dn2c+p9t8xIoItj+oVg0QR6DV5OHpRZTj8+JQ9PLyUmJV6E3p3UX4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vInzlM8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D53C4CEF7;
	Sun, 18 Jan 2026 02:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768703282;
	bh=cAzUT8OIyU3N18hB1bnswPp+VzqqcnjQeFBVJipb2zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vInzlM8TNVJ3HPiKSVsjnJbJcimmSANbVlDDeWAsI9k9/9Lo5i8A3bZ3uv5cd0r4d
	 nkcmQpcqRSUEqvXVqCH9ls6Z7fsTqSETCk0RVstCAE4X5yBYESBh8QJpKHBbxBwDGl
	 XDjsLXACE019PN+ir2EXoIHYsxaB4U8feWVZPoRmf3d90dFLjmu+vPoDZQfCtcU2PS
	 0qdHN6RqCkuEZN+9LeQDMkIpHUQ0wx+E0ONrDGvH/JJPe+TOjxJMweVHH50rJCwKcO
	 EvmygrMyCDb3kL/fis7WAytBOXjIXeX0cWqIYOOJTvtCoVnVJihTflCS0D7KiD4FjY
	 d6xRGJeTNVQSw==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	davem@davemloft.net,
	aleksandr.loktionov@intel.com,
	netdev@vger.kernel.org,
	Samuel.salin@intel.com,
	pabeni@redhat.com,
	madhu.chittim@intel.com,
	andrew+netdev@lunn.ch,
	milena.olech@intel.com,
	joshua.a.hay@intel.com
Subject: Re: [net-next,03/10] idpf: move queue resources to idpf_q_vec_rsrc structure
Date: Sat, 17 Jan 2026 18:27:58 -0800
Message-ID: <20260118022758.1106078-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115234749.2365504-4-anthony.l.nguyen@intel.com>
References: <20260115234749.2365504-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
idpf: move queue resources to idpf_q_vec_rsrc structure

This patch moves TX and RX queue resources from struct idpf_vport to
the newly introduced idpf_q_vec_rsrc structure as part of a refactoring
effort.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 48557c67dda8..25c15d2990d6 100644

[ ... ]

> @@ -438,9 +440,10 @@ static void idpf_rx_buf_rel_all(struct idpf_rx_queue *rxq)
>   *
>   * Free a specific rx queue resources
>   */
> -static void idpf_rx_desc_rel(struct idpf_rx_queue *rxq, struct device *dev,
> -			     u32 model)
> +static void idpf_rx_desc_rel(struct idpf_rx_queue *rxq, u32 model)
>  {
> +	struct device *dev;
> +
>  	if (!rxq)
>  		return;
>

[ ... ]

>  	if (!rxq->desc_ring)
>  		return;
>
> +	dev = &rxq->q_vector->vport->adapter->pdev->dev;
                 ^^^^^^^^^

Is this safe when q_vector has not been initialized yet? Looking at
idpf_vport_open(), the call sequence is:

  idpf_vport_queues_alloc()  -> allocates desc_ring
  idpf_vport_queue_ids_init() -> can fail, goes to queues_rel
  idpf_vport_intr_init()      -> sets q_vector via
                                 idpf_vport_intr_map_vector_to_qs()

If idpf_vport_queue_ids_init() fails, the error path jumps to queues_rel
which calls idpf_vport_queues_rel() -> idpf_rx_desc_rel_all() ->
idpf_rx_desc_rel(). At this point desc_ring is allocated but q_vector
is still NULL, causing a NULL pointer dereference here.

The old code passed dev as a parameter derived from vport->adapter->pdev->dev
which was always valid.

> 	dmam_free_coherent(dev, rxq->size, rxq->desc_ring, rxq->dma);
>  	rxq->desc_ring = NULL;
>  }

> @@ -467,9 +471,10 @@ static void idpf_rx_desc_rel(struct idpf_rx_queue *rxq, struct device *dev,
>   * @bufq: buffer queue to clean the resources from
>   * @dev: device to free DMA memory
>   */
> -static void idpf_rx_desc_rel_bufq(struct idpf_buf_queue *bufq,
> -				  struct device *dev)
> +static void idpf_rx_desc_rel_bufq(struct idpf_buf_queue *bufq)
>  {
> +	struct device *dev;
> +
>  	if (!bufq)
>  		return;
>

[ ... ]

>  	if (!bufq->split_buf)
>  		return;
>
> +	dev = &bufq->q_vector->vport->adapter->pdev->dev;
                 ^^^^^^^^^

The same concern applies here. bufq->q_vector may be NULL if we reach
this cleanup path before idpf_vport_intr_init() has been called.

> 	dma_free_coherent(dev, bufq->size, bufq->split_buf, bufq->dma);
>  	bufq->split_buf = NULL;
>  }

