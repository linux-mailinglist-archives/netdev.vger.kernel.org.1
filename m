Return-Path: <netdev+bounces-27064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC6577A172
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 19:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9572280FDC
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167E38833;
	Sat, 12 Aug 2023 17:35:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D320EE
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 17:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91823C433C7;
	Sat, 12 Aug 2023 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691861701;
	bh=s7NR+MioVWfbUYMOJj5jSg2ONA9cpOi9OaWQnY0Hq4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoVl68ioNVwYRCVONID2qSUARe1bi384vwGBhyUW31qi3WIsYE6ks0SY8YTWQXA2W
	 hNK1jaXyJwbxeb3kiCbVwoIe5qAafcozNCJTFPxBKcVjVXwdp2ZTdWDim1ieOpSpbj
	 Ohzw40QPRk/0i12WGYn4v0BGYWWodVv5PgzN9HCm7/IfR+no/zCzcEhQqHrrmuliw2
	 liRmBy66u2zOFjvhlRivZeuYo09JWN9vr7RycfNWF100UGwc5v3HJLRDTwXcHdau3T
	 gSlq8F+EllsB0n4GLCVsVXQK0+sHC4yp3P8lUt83JEPwpgqqYkyLqZS2ykOod5XXZN
	 avBbaSTFalkDw==
Date: Sat, 12 Aug 2023 19:34:56 +0200
From: Simon Horman <horms@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 6/8] virtio-net: support rx netdim
Message-ID: <ZNfCwDi/NvLR/WTm@vergenet.net>
References: <20230811065512.22190-1-hengqi@linux.alibaba.com>
 <20230811065512.22190-7-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811065512.22190-7-hengqi@linux.alibaba.com>

On Fri, Aug 11, 2023 at 02:55:10PM +0800, Heng Qi wrote:
> By comparing the traffic information in the complete napi processes,
> let the virtio-net driver automatically adjust the coalescing
> moderation parameters of each receive queue.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 124 +++++++++++++++++++++++++++++++++------
>  1 file changed, 106 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0318113bd8c2..3fb801a7a785 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -19,6 +19,7 @@
>  #include <linux/average.h>
>  #include <linux/filter.h>
>  #include <linux/kernel.h>
> +#include <linux/dim.h>
>  #include <net/route.h>
>  #include <net/xdp.h>
>  #include <net/net_failover.h>
> @@ -168,8 +169,17 @@ struct receive_queue {
>  
>  	struct virtnet_rq_stats stats;
>  
> +	/* The number of rx notifications */
> +	u16 calls;
> +
> +	/* Is dynamic interrupt moderation enabled? */
> +	bool dim_enabled;
> +
>  	struct virtnet_interrupt_coalesce intr_coal;
>  
> +	/* Dynamic Iterrupt Moderation */

Hi Heng Qi,

nit: Iterrupt -> interrupt

     Also, elsewhere in this patchset.

     ./checkpatch.pl --codespell is your friend here

> +	struct dim dim;
> +
>  	/* Chain pages by the private ptr. */
>  	struct page *pages;
>  

...

