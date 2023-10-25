Return-Path: <netdev+bounces-44098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C80497D61F4
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 08:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63674B20C74
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 06:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF53F4F0;
	Wed, 25 Oct 2023 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jAwUutNt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1AD53AE
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 06:58:10 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906A9A6
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 23:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KpJrnncCwaXU8Z0ZrFxv5FrAqsY4DyltfeWqARuZHS8=; b=jAwUutNt5ERcHPQX1xBGqnmBEk
	CGVi+BH4aJS5pOTDXdtqq+zBgKbJa2JTty7Wc5Cz6OeK8G6gBWPriv3SpM7RQ3PUapw1XyxEPL9hF
	tm2xT2qHDDKD6n69GQXZm5IckaTCC7PawasLhna/EJpGhkPKt0toZlzHYjR4AOmAuiHY6gLgLx7Fl
	f9mbTgnvKvEb2PoGRmJUSEvOGkSZhxaHloD/KIDmFoXbHVCOB3OJWOERU0LXxxQgvK7TRu5bF/ES2
	lyc4YJRYHs1qI86d7zsoDju1/csptoH6N5sx6X1F9507vIRzI/xRy0uaB0Z5pAouJS7LZihtz/dB4
	AiFZfu5A==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvXq5-0005f1-PA; Wed, 25 Oct 2023 08:58:01 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvXq5-000Q8r-8m; Wed, 25 Oct 2023 08:58:01 +0200
Subject: Re: [PATCH v3 net-next 5/6] net-device: reorganize net_device fast
 path variables
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>,
 David Ahern <dsahern@kernel.org>
References: <20231025012411.2096053-1-lixiaoyan@google.com>
 <20231025012411.2096053-6-lixiaoyan@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <44db16a9-0e9f-6191-f6d1-845b05ce08d1@iogearbox.net>
Date: Wed, 25 Oct 2023 08:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231025012411.2096053-6-lixiaoyan@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27071/Tue Oct 24 09:43:50 2023)

Hi Coco,

On 10/25/23 3:24 AM, Coco Li wrote:
> Reorganize fast path variables on tx-txrx-rx order
> Fastpath variables end after npinfo.
> 
> Below data generated with pahole on x86 architecture.
> 
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 4
> 
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> ---
>   include/linux/netdevice.h | 101 ++++++++++++++++++++------------------
>   net/core/dev.c            |  45 +++++++++++++++++
>   2 files changed, 99 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index b8bf669212cce..d4a8c42d9a9aa 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2076,6 +2076,60 @@ enum netdev_ml_priv_type {
>    */
>   
>   struct net_device {
> +	/* Caacheline organization can be found documented in
> +	 * Documentation/networking/net_cachelines/net_device.rst.
> +	 * Please update the document when adding new fields.
> +	 */
> +
> +	/* TX read-mostly hotpath */
> +	__cacheline_group_begin(net_device_read);
> +	unsigned long long	priv_flags;
> +	const struct net_device_ops *netdev_ops;
> +	const struct header_ops *header_ops;
> +	struct netdev_queue	*_tx;
> +	unsigned int		real_num_tx_queues;
> +	unsigned int		gso_max_size;
> +	unsigned int		gso_ipv4_max_size;
> +	u16			gso_max_segs;
> +	s16			num_tc;
> +	/* Note : dev->mtu is often read without holding a lock.
> +	 * Writers usually hold RTNL.
> +	 * It is recommended to use READ_ONCE() to annotate the reads,
> +	 * and to use WRITE_ONCE() to annotate the writes.
> +	 */
> +	unsigned int		mtu;
> +	unsigned short		needed_headroom;
> +	struct netdev_tc_txq	tc_to_txq[TC_MAX_QUEUE];
> +#ifdef CONFIG_XPS
> +	struct xps_dev_maps __rcu *xps_maps[XPS_MAPS_MAX];
> +#endif
> +#ifdef CONFIG_NETFILTER_EGRESS
> +	struct nf_hook_entries __rcu *nf_hooks_egress;
> +#endif

See earlier feedback from v2 [0], please also move tcx_egress over here:

#ifdef CONFIG_NET_XGRESS
         struct bpf_mprog_entry __rcu *tcx_egress;
#endif

   [0] https://lore.kernel.org/netdev/2965be9f-72b8-4972-0580-f96b2a562018@iogearbox.net/

Thanks,
Daniel

