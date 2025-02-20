Return-Path: <netdev+bounces-167941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 915F9A3CEF3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 02:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3519189C3B7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 01:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42331C4A24;
	Thu, 20 Feb 2025 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="OTgnT6nr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJP2K8IK"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085534CF5
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740016689; cv=none; b=SSsZkThq9Ebr4vwTBDl+5Re+pk35J/QKCTu22B4H7V7JPlGb3KrbCjezVyLGTBvOHlWPWROuoaF0VINQ0YI1EOSKQBjl0Ulrsr5TAVJPq09U1VtFM8MZnIaRewttuE1Ze7+S+mlM0oQoG3B70UMqpfGWZIjViEZ54qT9WlJesJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740016689; c=relaxed/simple;
	bh=hEAHSBnMtgNnluSx1E597kISUVgVm+tG7vhqKIAuGyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G81o42Ex4jBdg2W8qdxVjOy0vcPM+JNzrIYSvyvLdI9h6yAh9B7r53JvQpTT9rowZibsxuSW9KIVXrT2MNZ9mDYqn8rOz9oCYno11OnpRGPvBhjCuCa36rvfC1Q9Y3IJ5hStZk5AQjo6k7dSu7oj+UlkjVignoiOlkgKDZRdCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=OTgnT6nr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJP2K8IK; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 365EB1140181;
	Wed, 19 Feb 2025 20:58:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 19 Feb 2025 20:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740016686; x=1740103086; bh=p64Dog0SjP
	lkDfLxxNsT1XhDJFTwkpuAX3U3pC053vY=; b=OTgnT6nrTCf4Tzg0UaPDvs15nT
	X8/GU5hPMaC6IBV5l8fFFZMs2ptA+7YSn73lnVi73LlhEk7Z3YdxY7lr8Q6Ty9PG
	SX3UJi9KULJ3LQ28h2hAOg+tK79l6os/pXk/fIkIsqqxVpr1hKONOirlMm5YhqlJ
	/Kix2kMqZKPtyauFZXZKdc6UwI00NsSsXx8wvuBM7DAoAPEw6lpZVLkamM9lv8Zq
	bN8CBEx7yUN7HQwSXVAzNky7QOEvg16gAy28YOuUOsDKllHVC3dzoHulT87W2Xac
	8H0D1pluPaeU+dp77cfRj6STb923CcWOQzpsukyLVDCDn24/DqOoxZ3J7Njg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740016686; x=1740103086; bh=p64Dog0SjPlkDfLxxNsT1XhDJFTwkpuAX3U
	3pC053vY=; b=CJP2K8IKxACvBeGNvPMqij/ovlscO3NaddUf4T/vKv60MeJ7V7p
	kcGCK9agjhPw2oWvFDa6Ci0bBHM0krAQEDIFoD7i46ukvqbYLdaDXEjFTsy6xaOX
	necE2rLjYdyLikhRtxL/pCak54lgXyav3bFsQ8PhsfwcfevYeh5QRgmkZVNJN8Yw
	8CXN3UCn1rcni5FMU2uav4J6Qw7tzxYj8GyWw5EEwnm3poNKlXvjECZRSXUlsSgr
	UG6Wz3U74SSYHgNfGGx8cU53ZikhZ47JQgwZRjdopC8opTOWV/AL6tKkFEYbe0ru
	eK2DWPncIXBur/+sAmpjjDsZH4T4W9Ti0Nw==
X-ME-Sender: <xms:LYy2Z2Wo7MLDF66oW4ylRCbZappE8la75dfZFlg7j7B_ci0eElrs2A>
    <xme:LYy2ZymNILkIiXgZNhClyo9kDN_zLB3JcOzcOqEqok-ufrY8nuqgCezsv87fjF_Xu
    hTbjGAaZkb1Gy-BUQ>
X-ME-Received: <xmr:LYy2Z6ZI27hHKIxIGiROW9N0TzEDUbB5nsDdVepz6gwnc7eEoXr4OwYiMAmxYuJI-CiWHKoGUG_4sP6Q5ci4mQC4me-yEOsUXBys3rEonEY1Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiheeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhep
    ffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrh
    hnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffffgfegiedttefgvdfhvden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihuse
    gugihuuhhurdighiiipdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvg
    hmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    rghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhsse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidr
    nhgvthdprhgtphhtthhopehhrgifkheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LYy2Z9V-jur7tmMt411NdsE2lEBjh5O_P7cAv_0xBB5UQLpcXpWGgg>
    <xmx:LYy2ZwkjP8OLTVXigBid3UqN91CAuj9pxConwc_S5Kf_Yft1Oq2tWQ>
    <xmx:LYy2ZyedjnaXKlyeiHyynHHeUqR8XyC_LWLm9o4YpOxpN3t7Y9O2Nw>
    <xmx:LYy2ZyGFe8CkbdCWQVF2IvlpuRtv0SI2VEXQZiyiSJv9kvCYYNl2bw>
    <xmx:Loy2Z-nJnFuuW7OZJOLiU-75ZQugldfvmWubYXuF49G7DYTVhsxoHTtO>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 20:58:03 -0500 (EST)
Date: Wed, 19 Feb 2025 18:58:02 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, ap420073@gmail.com
Subject: Re: [PATCH net 1/2] bnxt: don't reject XDP installation when HDS
 isn't forced on
Message-ID: <w3kr4zyocloibq6mniumhtcbp6hqfur6uzqeem6hpoe76t2gqr@4jmz72w3wrw3>
References: <20250220005318.560733-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220005318.560733-1-kuba@kernel.org>

On Wed, Feb 19, 2025 at 04:53:17PM -0800, Jakub Kicinski wrote:
> HDS flag is often set because GRO-HW is enabled. But we call
> bnxt_set_rx_skb_mode() later, which will clear it. So make
> sure we reject XDP when user asked for HDS, not when it's
> enabled for other reasons.
> 
> Fixes: 87c8f8496a05 ("bnxt_en: add support for tcp-data-split ethtool command")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: daniel@iogearbox.net
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: michael.chan@broadcom.com
> CC: pavan.chebbi@broadcom.com
> CC: ap420073@gmail.com
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index e6c64e4bd66c..ff208c4b7d70 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -11,10 +11,12 @@
>  #include <linux/pci.h>
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
> +#include <linux/ethtool_netlink.h>
>  #include <linux/if_vlan.h>
>  #include <linux/bpf.h>
>  #include <linux/bpf_trace.h>
>  #include <linux/filter.h>
> +#include <net/netdev_queues.h>
>  #include <net/page_pool/helpers.h>
>  #include "bnxt_hsi.h"
>  #include "bnxt.h"
> @@ -395,7 +397,7 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
>  			    bp->dev->mtu, BNXT_MAX_PAGE_MODE_MTU);
>  		return -EOPNOTSUPP;
>  	}
> -	if (prog && bp->flags & BNXT_FLAG_HDS) {
> +	if (prog && dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
>  		netdev_warn(dev, "XDP is disallowed when HDS is enabled.\n");
>  		return -EOPNOTSUPP;
>  	}
> -- 
> 2.48.1
> 

Nice, that fixed it.

Tested-by: Daniel Xu <dxu@dxuuu.xyz>

