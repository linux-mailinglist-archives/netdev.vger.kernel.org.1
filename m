Return-Path: <netdev+bounces-40875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 688877C8FFE
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B5C1C20E45
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 22:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE06C286AB;
	Fri, 13 Oct 2023 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2trp5+/r"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9C21A0A
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 22:04:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A44B7
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=sd5NYqgGOlSeHETHK6YaVAyDF8OaAVoJZDSvEe0oBks=; b=2trp5+/rGLHFPNU8Okkl1NxXBr
	X8dQkh/V5ygFGFkT2KLtxgMhoAk2r++bBsXUICwhJ6gzzaJK8LUdULdefJtXYIpMlh8bVeAh1CF92
	gQeny/yO2PgkWlAtVnaxq5oErYFpouXayQCA4y7xU22RIeRXbLXpsFVILsDxnz/OTBVD3RxBfWRSd
	03rLbrmBOen1A5ENF98gqLftPbRwUQrgb67Y8f+op5Uv+qeEPnyS1Azrcf/h/Wdq/MUbbboG15WgZ
	miEGfoCKKHNILUS+YKrKzxokdqt5o62bkiiV1tL1Az6VyKpXwAkSY6BfW7v4CjPi+qufXn5Gly8IJ
	I/I6QiVw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qrQGq-004M4h-0H;
	Fri, 13 Oct 2023 22:04:36 +0000
Message-ID: <113bb0a0-b3f4-4220-a33d-d32091740634@infradead.org>
Date: Fri, 13 Oct 2023 15:04:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stub tcp_gro_complete if CONFIG_INET=n
Content-Language: en-US
To: Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski
 <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Arnd Bergmann <arnd@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
References: <20231013185502.1473541-1-jacob.e.keller@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231013185502.1473541-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/13/23 11:54, Jacob Keller wrote:
> A few networking drivers including bnx2x, bnxt, qede, and idpf call
> tcp_gro_complete as part of offloading TCP GRO. The function is only
> defined if CONFIG_INET is true, since its TCP specific and is meaningless
> if the kernel lacks IP networking support.
> 
> The combination of trying to use the complex network drivers with
> CONFIG_NET but not CONFIG_INET is rather unlikely in practice: most use
> cases are going to need IP networking.
> 
> The tcp_gro_complete function just sets some data in the socket buffer for
> use in processing the TCP packet in the event that the GRO was offloaded to
> the device. If the kernel lacks TCP support, such setup will simply go
> unused.
> 
> The bnx2x, bnxt, and qede drivers wrap their TCP offload support in
> CONFIG_INET checks and skip handling on such kernels.
> 
> The idpf driver did not check CONFIG_INET and thus fails to link if the
> kernel is configured  with CONFIG_NET=y, CONFIG_IDPF=(m|y), and
> CONFIG_INET=n.
> 
> While checking CONFIG_INET does allow the driver to bypass significantly
> more instructions in the event that we know TCP networking isn't supported,
> the configuration is unlikely to be used widely.
> 
> Rather than require driver authors to care about this, stub the
> tcp_gro_complete function when CONFIG_INET=n. This allows drivers to be
> left as-is. It does mean the idpf driver will perform slightly more work
> than strictly necessary when CONFIG_INET=n, since it will still execute
> some of the skb setup in idpf_rx_rsc. However, that work would be performed
> in the case where CONFIG_INET=y anyways.
> 
> I did not change the existing drivers, since they appear to wrap a
> significant portion of code when CONFIG_INET=n. There is little benefit in
> trashing these drivers just to unwrap and remove the CONFIG_INET check.
> 
> Using a stub for tcp_gro_complete is still beneficial, as it means future
> drivers no longer need to worry about this case of CONFIG_NET=y and
> CONFIG_INET=n, which should reduce noise from buildbots that check such a
> configuration.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> I've only compile tested this.
> 
>  include/net/tcp.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 7fdedf5c71f0..32146088a095 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2081,7 +2081,11 @@ INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb, int thoff))
>  INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb));
>  INDIRECT_CALLABLE_DECLARE(int tcp6_gro_complete(struct sk_buff *skb, int thoff));
>  INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb));
> +#ifdef CONFIG_INET
>  void tcp_gro_complete(struct sk_buff *skb);
> +#else
> +static inline void tcp_gro_complete(struct sk_buff *skb) { }
> +#endif
>  
>  void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr);
>  

-- 
~Randy

