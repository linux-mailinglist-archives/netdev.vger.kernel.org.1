Return-Path: <netdev+bounces-41778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFB67CBE29
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 207CEB21007
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF613CCE7;
	Tue, 17 Oct 2023 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QvpuElHW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3811ABE6D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:52:48 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BBA8E
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XpJFQdtTNM08OYpV/0DOd2X8y3GdHtNjw25UEXlKEZs=; b=QvpuElHWICz3CClLrt8G+BxfQy
	fSYHKgyYLf76FW1Pw8EUFbaJM+FWLNQbeZ3d73vMBP75EM4o0EZtaBLIhU0X02JlNZVp+T8uDno1s
	Bj8xiz3sqq0a5g01UdAqs5Yko9jtaB2D6tvLKSz0tMM4ydPl5b1hbIitcsVZK4HxnfqM69Eq+ZJek
	BNItSyjFciLXwvgC5x+5fAj5W3RY9xEzhoAdgllhvZMN4vI9EY6qSv1XHesmWVg+I8PHmPGAocUe2
	ymB5hsT+qw3N81eHR31WNPHewV8btCkjlTQTHLLECkzewpwq1DYlsjrusUIQSEFDcQgWOvwWl2jYA
	cMwxDCqQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsfoe-000LHn-3T; Tue, 17 Oct 2023 10:52:40 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsfod-000V05-Nn; Tue, 17 Oct 2023 10:52:39 +0200
Subject: Re: [PATCH v2 net-next 4/5] net-device: reorganize net_device fast
 path variables
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>, David Ahern <dsahern@kernel.org>
References: <20231017014716.3944813-1-lixiaoyan@google.com>
 <20231017014716.3944813-5-lixiaoyan@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2965be9f-72b8-4972-0580-f96b2a562018@iogearbox.net>
Date: Tue, 17 Oct 2023 10:52:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231017014716.3944813-5-lixiaoyan@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27063/Mon Oct 16 10:02:17 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Coco,

Thanks for looking into this, awesome work!

On 10/17/23 3:47 AM, Coco Li wrote:
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
>   include/linux/netdevice.h | 99 ++++++++++++++++++++-------------------
>   1 file changed, 52 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1c7681263d302..d72b71b76bf82 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2053,6 +2053,58 @@ enum netdev_ml_priv_type {
>    */
>   
>   struct net_device {
> +	/* Caacheline organization can be found documented in

tiny nit: typo

> +	 * Documentation/networking/net_cachelines/net_device.rst.

I think this doc is not based on current struct net_device as I saw
some members in there which are not in net_device anymore today?

For the doc, please document also tcx_ingress member as fastpath_rx_access
(sch_handle_ingress) and tcx_egress member as fastpath_tx_access
(sch_handle_egress).

> +	 * Please update the document when adding new fields.
> +	 */
> +
> +	/* TX read-mostly hotpath */
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

As mentioned above, please also add tcx_egress to TX read-mostly
hotpath cacheline.

Thanks,
Daniel

