Return-Path: <netdev+bounces-23950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE2476E451
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6691C214B4
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B6A154AA;
	Thu,  3 Aug 2023 09:28:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA87E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39DFC433C8;
	Thu,  3 Aug 2023 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691054917;
	bh=g+JwMnsby1YBZpUSTQl6bD8vMZ6aGe4PqzLO6EkpF6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iphVwkAPoYtyWJtukne3bI5wgiuJFhf8lyklCrDf89Rq9GruYFmDkKSYEDV8GXqhY
	 9kR70EyxINd3b3x9an3/f7auXKGJLF9E5fkJ8XSr7ZMhHd3FqCZyE2nBEKBHaIRxZB
	 VMrYqmRl+Zf2qWLUsJ6C6qvDer0dlLtCJzARfIrNigKSuqqHv9QNvJbA8ugJ7uRvu+
	 4tWEFjxiWXwde1ywjwPJEra9gM2ZigIuXbyrq6cajuWEptdNRXiEbKxn4D5TDoyXY5
	 rvK66MXdQDeKi9rJRjZA90gipavngpx7A9gIwvYdiUhqxhkwoH3yq00SFWjYS/g1/A
	 1Sy+sRVvyGR5A==
Date: Thu, 3 Aug 2023 11:28:33 +0200
From: Simon Horman <horms@kernel.org>
To: Rushil Gupta <rushilg@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	willemb@google.com, edumazet@google.com, pabeni@redhat.com,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Bailey Forrest <bcf@google.com>
Subject: Re: [PATCH net-next 1/4] gve: Control path for DQO-QPL
Message-ID: <ZMtzQfUsdf8iJL6F@kernel.org>
References: <20230802213338.2391025-1-rushilg@google.com>
 <20230802213338.2391025-2-rushilg@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802213338.2391025-2-rushilg@google.com>

On Wed, Aug 02, 2023 at 09:33:35PM +0000, Rushil Gupta wrote:

...

Hi Rashil,

> @@ -505,12 +524,24 @@ static int gve_adminq_create_tx_queue(struct gve_priv *priv, u32 queue_index)
>  
>  		cmd.create_tx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
>  	} else {
> +		u16 comp_ring_size = 0;
> +		u32 qpl_id = 0;
> +
> +		if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
> +			qpl_id = GVE_RAW_ADDRESSING_QPL_ID;
> +			comp_ring_size =
> +				priv->options_dqo_rda.tx_comp_ring_entries;
> +		} else {
> +			qpl_id = tx->dqo.qpl->id;

The qpl field does not appear to be added to struct gve_tx_ring
until a following patch.

> +			comp_ring_size = priv->tx_desc_cnt;
> +		}
> +		cmd.create_tx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
>  		cmd.create_tx_queue.tx_ring_size =
>  			cpu_to_be16(priv->tx_desc_cnt);
>  		cmd.create_tx_queue.tx_comp_ring_addr =
>  			cpu_to_be64(tx->complq_bus_dqo);
>  		cmd.create_tx_queue.tx_comp_ring_size =
> -			cpu_to_be16(priv->options_dqo_rda.tx_comp_ring_entries);
> +			cpu_to_be16(comp_ring_size);
>  	}
>  
>  	return gve_adminq_issue_cmd(priv, &cmd);
> @@ -555,6 +586,18 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
>  		cmd.create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
>  		cmd.create_rx_queue.packet_buffer_size = cpu_to_be16(rx->packet_buffer_size);
>  	} else {
> +		u16 rx_buff_ring_entries = 0;
> +		u32 qpl_id = 0;
> +
> +		if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
> +			qpl_id = GVE_RAW_ADDRESSING_QPL_ID;
> +			rx_buff_ring_entries =
> +				priv->options_dqo_rda.rx_buff_ring_entries;
> +		} else {
> +			qpl_id = rx->dqo.qpl->id;

Likewise, the qpl field does not appear to be added to struct gve_rx_ring
until a following patch.

> +			rx_buff_ring_entries = priv->rx_desc_cnt;
> +		}
> +		cmd.create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
>  		cmd.create_rx_queue.rx_ring_size =
>  			cpu_to_be16(priv->rx_desc_cnt);
>  		cmd.create_rx_queue.rx_desc_ring_addr =

...

-- 
pw-bot: changes-requested

