Return-Path: <netdev+bounces-93427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449D68BBB0F
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 14:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F1F282A37
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77191CF9A;
	Sat,  4 May 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMMnIi4M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37AF1CA92
	for <netdev@vger.kernel.org>; Sat,  4 May 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714824721; cv=none; b=DpIrKVABkIqREEadlrV/as961HQNOGG2HzdANa6dNvzXHPuh2WOJSRCSqyxKrwNxKGwPMS0whXVgzilJoYv0EwZRy88u0zCtP3EFQBlLvWfwGIjTcaeFBOeG8dt7eXTizyovZ1hen/fYksL1DJ5erVfmCxhEJub0SR/VdKv6bbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714824721; c=relaxed/simple;
	bh=aQmBD7+28QO7aI9/k2YbrZUk1qQlrUaZNVnfjyhRLtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFtKGvtZo8yNDAWjqnF9rG7KyRuGHCn3b/Rfd58wedA+PxdGzYksMTvqBHQq8x8fyVIi3uIOD7TkbSfLTUoZ46Qn4QArsNfyzKE/5ISakCNdePHUmPLTwremMSd0ePxYDFKfewo4+Lz0E0BydDSpIDp8WHtxjkFHQBi4cBrUpkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMMnIi4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B78C072AA;
	Sat,  4 May 2024 12:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714824721;
	bh=aQmBD7+28QO7aI9/k2YbrZUk1qQlrUaZNVnfjyhRLtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMMnIi4M7paIy/HIHdkJIp412FxuwQbGS5NjpkNRktS/gvyywTzUTLw9PcrkGAhXj
	 T8SaO0KCwPAxR35aSHNikXlR/yxV/FlZNiw9yLr5T2n3l93eskYsXMeP9K0P9Ab87V
	 GP08IDdFYs5lvt50pxNf5ZWCWCP3fjrnOlq7eBmESsLRhv7dvGppzASGn4TsRB+ifc
	 Ss6oI6SS0X/BTGYTuUnofqCjYURiEE49sCvRIaiwscc1b7ZL05wNVwmHFonuiDxl40
	 pGfTRYmVwQBvVDGR4vYQZoLlpORCn5M1M2WnEHW1PMWiiFvrvp8vPfSGlKHZkhyVA3
	 CC7SybP7vDHQQ==
Date: Sat, 4 May 2024 13:11:54 +0100
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH net-next v2 1/9] queue_api: define queue api
Message-ID: <20240504121154.GF3167983@kernel.org>
References: <20240502045410.3524155-1-dw@davidwei.uk>
 <20240502045410.3524155-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502045410.3524155-2-dw@davidwei.uk>

On Wed, May 01, 2024 at 09:54:02PM -0700, David Wei wrote:
> From: Mina Almasry <almasrymina@google.com>
> 
> This API enables the net stack to reset the queues used for devmem TCP.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: David Wei <dw@davidwei.uk>

...

> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index 1ec408585373..58042957c39f 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -60,6 +60,33 @@ struct netdev_stat_ops {
>  			       struct netdev_queue_stats_tx *tx);
>  };
>  
> +/**
> + * struct netdev_queue_mgmt_ops - netdev ops for queue management
> + *
> + * @ndo_queue_mem_alloc: Allocate memory for an RX queue. The memory returned
> + *			 in the form of a void* can be passed to
> + *			 ndo_queue_mem_free() for freeing or to ndo_queue_start
> + *			 to create an RX queue with this memory.
> + *
> + * @ndo_queue_mem_free:	Free memory from an RX queue.
> + *
> + * @ndo_queue_start:	Start an RX queue at the specified index.
> + *
> + * @ndo_queue_stop:	Stop the RX queue at the specified index.
> + */
> +struct netdev_queue_mgmt_ops {
> +       void *                  (*ndo_queue_mem_alloc)(struct net_device *dev,
> +                                                      int idx);
> +       void                    (*ndo_queue_mem_free)(struct net_device *dev,
> +                                                     void *queue_mem);
> +       int                     (*ndo_queue_start)(struct net_device *dev,
> +                                                  int idx,
> +                                                  void *queue_mem);
> +       int                     (*ndo_queue_stop)(struct net_device *dev,
> +                                                 int idx,
> +                                                 void **out_queue_mem);

Nit: The indentation (before the return types) should use tabs rather than
     spaces. And I'm not sure I see the value of the large indentation after
     the return types. Basically, I suggest this:

	void * (*ndo_queue_mem_alloc)(struct net_device *dev, int idx);
	void   (*ndo_queue_mem_free)(struct net_device *dev, void *queue_mem);
	int    (*ndo_queue_start)(struct net_device *dev, int idx,
				  void *queue_mem);
	int    (*ndo_queue_stop)(struct net_device *dev, int idx,
				 void **out_queue_mem);

> +};
> +
>  /**
>   * DOC: Lockless queue stopping / waking helpers.
>   *
> -- 
> 2.43.0
> 
> 

