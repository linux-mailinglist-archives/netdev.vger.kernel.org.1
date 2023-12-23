Return-Path: <netdev+bounces-60093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 480F381D508
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 17:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12831F21D9A
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D60F4FC;
	Sat, 23 Dec 2023 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2opNiBy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72910940
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 16:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BC9C433C7;
	Sat, 23 Dec 2023 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703348185;
	bh=f6XRhGA0PIrVr5jO83uDKPfvkDOspkDBnTp99j76Jrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2opNiByGKD5maRl0kTzi9At2bqp7NG0bWskrbL9ck+ky2pJh9vXhIP3Yv+xLT9Cq
	 vDoJMT4H9l+z5tWY99wzbpudnpSoBLws215w+cq2/XZlfXvX9p6/3DXZ79dft6xQ75
	 MMEV/wkciBjMSOSgDuYCkqaBmwod8NoD9E3qj2GVhJUxHvNzp5Iqtsx+svsAqPabbU
	 zuI84nA3rzqNx28e/bjIrHp5ym5dy2clu8XLxI+vB7RnYpToD9umYYMm39P5wywk0K
	 Lc7OUmDbrfnDWO1J4xBtSIPURPtU821IjrSEim2kGlFID7pq3822NtILUmMWUNt8Lr
	 Cm4uLNRq5Eo0Q==
Date: Sat, 23 Dec 2023 16:16:20 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Coco Li <lixiaoyan@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next] net-device: move gso_partial_features to
 net_device_read_tx
Message-ID: <20231223161620.GF201037@kernel.org>
References: <20231221140747.1171134-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221140747.1171134-1-edumazet@google.com>

On Thu, Dec 21, 2023 at 02:07:47PM +0000, Eric Dumazet wrote:
> dev->gso_partial_features is read from tx fast path for GSO packets.
> 
> Move it to appropriate section to avoid a cache line miss.
> 
> Fixes: 43a71cd66b9c ("net-device: reorganize net_device fast path variables")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Coco Li <lixiaoyan@google.com>
> Cc: David Ahern <dsahern@kernel.org>

Thanks Eric,

FWIIW, this change looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

I have a follow-up question below.

...

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 75c7725e5e4fdf59da55923cd803e084956b0fa0..5d1ec780122919c31e4215358d736aef3f8a0acd 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2114,6 +2114,7 @@ struct net_device {
>  	const struct net_device_ops *netdev_ops;
>  	const struct header_ops *header_ops;
>  	struct netdev_queue	*_tx;
> +	netdev_features_t	gso_partial_features;
>  	unsigned int		real_num_tx_queues;
>  	unsigned int		gso_max_size;
>  	unsigned int		gso_ipv4_max_size;

While looking at this I came to wonder if it would
be worth adding a 16bit pad a little below this hunk
so that tc_to_txq sits on it's own cacheline.

I'm unsure if the access pattern of tc_to_txq makes this worthwhile.
But if so it would be a simple tweak.

With such a change in place, on top of your patch, the diff of pahole output
on x86_64 is:

@@ -7432,10 +7432,9 @@
        s16                        num_tc;               /*    54     2 */
        unsigned int               mtu;                  /*    56     4 */
        short unsigned int         needed_headroom;      /*    60     2 */
-       struct netdev_tc_txq       tc_to_txq[16];        /*    62    64 */
-
-       /* XXX 2 bytes hole, try to pack */
-
+       u16                        pad1;                 /*    62     2 */
+       /* --- cacheline 1 boundary (64 bytes) --- */
+       struct netdev_tc_txq       tc_to_txq[16];        /*    64    64 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        struct xps_dev_maps *      xps_maps[2];          /*   128    16 */
        struct nf_hook_entries *   nf_hooks_egress;      /*   144     8 */

