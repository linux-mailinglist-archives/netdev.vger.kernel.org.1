Return-Path: <netdev+bounces-233004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE55C0AC4B
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 16:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17D084E83E5
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CBD22B8A6;
	Sun, 26 Oct 2025 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N3C6ExUH"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086F1D5CEA
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761491625; cv=none; b=LxSj1zAi4UoY+fUviMJGLfMJGheDkzZCAM0cytsglV0t7W7OviWfkw6mUTvhNowsGzxFDwZuBc3Ko9xpUyZdink2DkrYgiavf9BPH8KLGLbniB55Nnm1V+SEI7C7spgGMk4Nx6dmBFIpGiUQ7FXL10UX7HZmGNvsBw5k6wVGz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761491625; c=relaxed/simple;
	bh=cOjttaAjSm7yNNI7nxwQbZp8OCUScBzi24xPAb2YSGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWpCBKLCXCqrUsbuaI4WXWgtTonQwslnpGhgrCG0QQhO3hLtUuP7TxGQgzhCUDA9WkTR1LSib0Vehs0CJPt+wr2PBNV0t5OZC1xuUfyjcbEcroTy+FHrzKQmPMcTiGTHiS9YvRQwPzbeKDm1IQ8b4+PJNzKOj6j1AOzlUs827Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N3C6ExUH; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 074857A031E;
	Sun, 26 Oct 2025 11:13:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 26 Oct 2025 11:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761491622; x=1761578022; bh=IHfNz/sipEJLgMNG9q18b9VMHpSNu9eFV3c
	vtOplTmw=; b=N3C6ExUH2k2VH5bmJvdinbHZvFCEwFSYTzGW/l+WUO+F6kEN1h0
	+B9LCCvtJHdwdQaPvb1FW60M0IRMRV1WvCucBwBegnbNdrNdra14Zw9zLoxrQY9E
	PSmFKkfmN3wNFhnRUx1K6Z44PXvDHDyLm32It3pLvv2BNQgBFpjtZi+o0wSAwGDj
	cm3fmvCDs/lUnYXHV1he+tkPk8yvpyUEl7Bx/WRhdIM5ylvCLGa7OxO9/lY8LU2J
	4qQE86mbIgjpyQdUUPfdQqXo4NTy2gr30dwJt3Rujq+i+st5HGGWqwLhFhmQMju+
	f59+AC8vkQj75uMu/ZH+qRSxFXkjsshbkmw==
X-ME-Sender: <xms:pTr-aNJyj_0WOBRnMO28JSQ_dJCo8L9v6AR-V2Q9isbULvm_Jm9KhQ>
    <xme:pTr-aM3QRcQwJbtZ1H_hFwaHfs_nNzKnrBgCC3UB_4KiEqbUI9qRs_cnErIbtnjRy
    GNyxYC3-mBUJSDJJKh64EZFZwjmZ7QLG9GFbYs2vRh-RodDKuvo>
X-ME-Received: <xmr:pTr-aPhvEdfYbo78CNEEmNQoo6A2FBYNCKEFO17Uyfsuswp7Uykzd6fd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheehgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguoh
    hstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepthhonhhghhgrohessggrmhgrihgtlhhouhgurdgtohhmpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghrrghnsggvsehmvghllhgrnhhogidrtghomhdprhgtphhtthhopehjihhrihesmh
    gvlhhlrghnohigrdgtohhmpdhrtghpthhtohepgihihihouhdrfigrnhhgtghonhhgsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pTr-aFXskmn-PnSJlFirK9cfYSheEUVTcFRiywPG2Oiq8BVNcVVJRw>
    <xmx:pTr-aGXNtO7lc8eaGtsSw5HQVLvK7t582-B5RRoBLAGkXAd7JidT-g>
    <xmx:pTr-aNhQ0JEVnWDjcCFlCWhqAFXEBIyWNQ-jyqcUo3hEj1-FlY3WAw>
    <xmx:pTr-aJbyfCOVHUBdnAmX8t-yC7JjlpjUEKmn4vSJqV3ka6jzR1nS-w>
    <xmx:pjr-aP8ulngj_HwzIC5-wgNL4uFjoykegcK45Il8t1_PvwbwANonxGIn>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 11:13:41 -0400 (EDT)
Date: Sun, 26 Oct 2025 17:13:39 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v2] net: add net cookie for
 trace_net_dev_xmit_timeout
Message-ID: <aP46o8SvNCOICTxP@shredder>
References: <20251024121853.94199-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024121853.94199-1-tonghao@bamaicloud.com>

On Fri, Oct 24, 2025 at 08:18:53PM +0800, Tonghao Zhang wrote:
> In a multi-network card or container environment, provide more information.

I suggest explaining that this is needed in order to differentiate
between trace events relating to net devices that exist in different
network namespaces and share the same name.

> 
> [002] ..s1.  1838.311662: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3
> [007] ..s1.  1839.335650: net_dev_xmit_timeout: dev=eth4 driver=virtio_net queue=10 net_cookie=4100
> [007] ..s1.  1844.455659: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3
> [007] ..s1.  1845.479663: net_dev_xmit_timeout: dev=eth4 driver=virtio_net queue=10 net_cookie=4100
> [002] ..s1.  1850.087647: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3
> 
> Cc: Eran Ben Elisha <eranbe@mellanox.com>
> Cc: Jiri Pirko <jiri@mellanox.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> ---
> v2: use net cookie instead of ifindex.
> ---
>  include/trace/events/net.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> index d55162c12f90..8d064bf1ae7f 100644
> --- a/include/trace/events/net.h
> +++ b/include/trace/events/net.h
> @@ -107,16 +107,20 @@ TRACE_EVENT(net_dev_xmit_timeout,
>  		__string(	name,		dev->name	)
>  		__string(	driver,		netdev_drivername(dev))
>  		__field(	int,		queue_index	)
> +		__field(	u64,		net_cookie	)

Seems a bit random to only patch one trace event in this file. There are
other events that also print the net device name. I suggest patching
them as well.

>  	),
>  
>  	TP_fast_assign(
>  		__assign_str(name);
>  		__assign_str(driver);
>  		__entry->queue_index = queue_index;
> +		__entry->net_cookie = dev_net(dev)->net_cookie;
>  	),
>  
> -	TP_printk("dev=%s driver=%s queue=%d",
> -		__get_str(name), __get_str(driver), __entry->queue_index)
> +	TP_printk("dev=%s driver=%s queue=%d net_cookie=%llu",
> +		__get_str(name), __get_str(driver),
> +		__entry->queue_index,
> +		__entry->net_cookie)
>  );
>  
>  DECLARE_EVENT_CLASS(net_dev_template,
> -- 
> 2.34.1
> 

