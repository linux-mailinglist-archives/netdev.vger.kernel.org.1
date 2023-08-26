Return-Path: <netdev+bounces-30853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3128789354
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 04:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5C62819F5
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905B465A;
	Sat, 26 Aug 2023 02:21:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CDB393
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 02:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337C2C433C7;
	Sat, 26 Aug 2023 02:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693016463;
	bh=oKfVMpYnpbBGn3qOXCYjJDyruyKisnmPmmEdkrL9WDM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UK2lnJ8gdD3aTCVdcNnR876+1T8pf7lh73wEcgo7ZSaWjs8vK76BPXjfBsukgZV/o
	 M79ZONgrXvlerFDraw6iMf1Yqi4YZHuYG7lQzqZI1ijQeXqCNjYEbCz+mEw5D+ufPr
	 cwebRob1g0UV58vGvDxNHez8Uj7d4pIqlhG0dWI3bwILqafOFEd6hGtFEHOVnvoOE+
	 wE1w/+k9NADciQEdvCZvP/5R9gKbuaNmkUGwEyxbQhEKjyjnT5/Hw25rwpYBhFvAKO
	 A8auuqfKbKfDRZECY6NsWxNKscDoCf2DyiLpLjQ87Ha7IpHTG5vA6F6TxD/qxBLn2C
	 rDJZxNgSL2bZw==
Message-ID: <ac2d595a-c803-b512-84c9-a5ab35615637@kernel.org>
Date: Fri, 25 Aug 2023 20:21:02 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 03/11] netdev: add XDP_SETUP_ZC_RX command
Content-Language: en-US
To: David Wei <dw@davidwei.uk>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20230826011954.1801099-1-dw@davidwei.uk>
 <20230826011954.1801099-4-dw@davidwei.uk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230826011954.1801099-4-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/23 6:19 PM, David Wei wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 08fbd4622ccf..a20a5c847916 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1000,6 +1000,7 @@ enum bpf_netdev_command {
>  	BPF_OFFLOAD_MAP_ALLOC,
>  	BPF_OFFLOAD_MAP_FREE,
>  	XDP_SETUP_XSK_POOL,
> +	XDP_SETUP_ZC_RX,

Why XDP in the name? Packets go from nic to driver to stack to io_uring,
no? That is not XDP.


>  };
>  
>  struct bpf_prog_offload_ops;
> @@ -1038,6 +1039,11 @@ struct netdev_bpf {
>  			struct xsk_buff_pool *pool;
>  			u16 queue_id;
>  		} xsk;
> +		/* XDP_SETUP_ZC_RX */
> +		struct {
> +			struct io_zc_rx_ifq *ifq;
> +			u16 queue_id;
> +		} zc_rx;
>  	};
>  };
>  


