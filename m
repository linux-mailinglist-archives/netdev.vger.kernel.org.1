Return-Path: <netdev+bounces-233231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3F9C0EFD6
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80B83A51C5
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5848E25C6FF;
	Mon, 27 Oct 2025 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="NLTFfCAB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lAheerMx"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACCD2C21DC
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579207; cv=none; b=RiFDycGCUT5cRKpIQYzzxv9fOp5UphTgJWkeO0hg/u9zl/UTq1z7xkSQz/JVSFs166GXBBHzDeOGnpvp0z+MktNBX2mPC15FPkYS1lM4ybnVcK3EP4uwnQeUvUy/zkEI5LWwe1i39614YhT7a4/+vZgXGrMuRDDUNsGdE5Yhpyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579207; c=relaxed/simple;
	bh=bl5ZEtE2ZTjL+CZF+ZGvmn1gylRlFfUoXKA3jQIjrkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMQciQIu28+dIE0wfQ61WpaeOjAzpUaLh1um4c0ukQKsqx8GCdd+cXzasZ1q5VU5gXhNvMLFY2WcfS3t4eNxCvWeRqAZ77bVWYs3dsW4JgxtxR4zx76Rz1OhP/jFzbD0zGHM9kRwZm9ZO9KlGQO8GE7OAmQUMhb4J7Qclpl+AZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=NLTFfCAB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lAheerMx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ADB401400204;
	Mon, 27 Oct 2025 11:33:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 27 Oct 2025 11:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761579201; x=
	1761665601; bh=fbHI2YBz8jk5m9kPXoHIUADu8vi8crwsg4smerYH19I=; b=N
	LTFfCABx+e6meT2jMx1aWDCnkYp7px2VD/CuaJU/vhAbJupd70HjzMtSoojBph0N
	8NxiayCDfXq57X2ldhQ12/X02dJZEYFCQMLMa5yfko3NPHYC5rgl5WtyWdbW9Wnz
	1khjvXcd8UkSXAnklmS0wDvmD1yssSGJOJMJu6rnM9NRMakS6TasnbgyJbZdPNSB
	izVQqR2DJ5Gwk9Pck4bxkZbZfEsRgQHoYC0FWNWcaQAvI67IEpRF7wsfV4S4S6PQ
	9eV62Q46w0DYTnmhyT0dR4NbhlNlfw1hRuYA1wo92IwyWNd83dqnkgkXYYlg271F
	Cn4EylfxIu8pP+ajIPu6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761579201; x=1761665601; bh=fbHI2YBz8jk5m9kPXoHIUADu8vi8crwsg4s
	merYH19I=; b=lAheerMxUl78mJ93AQG1J/8MRP4FNVSko+juBGha9y09Zg5vVrK
	um3bKdjejb2Tx+4Qa7S3wUUlJ5aggPuO24SRWw8UL3AhzPv1kVz2A4EzRRUvLTPq
	vG8tLnftnIsoIl2qPf2scH1vgYfrnqqftot84gW4DJxYkrsHFKEVjmIal49/XVkh
	0pZKss4sGr3f8yANPL/jBLPn6PoXnXw2aSkh3XdhPtyvvYCan94ujha85OEKtNW5
	nE06iEDPeyn5GBffO0CvUoNPSfcX+fBBrCvLRmE32yx1S7SagNnKrAlEnWznifQK
	xXkboGXup7txlihQXE2jdyy0iaVxr+ACXsg==
X-ME-Sender: <xms:wJD_aDxEwZ1dG6ZeWMfFzX8jZj18dRxkClPXEGi8DEbnrdSKqFNMJw>
    <xme:wJD_aHLIzLThLhP4gmFsBsQVZqvLqf6bf7jpgd6vH3MFjX3DeS3ej1OPD_48ORx4B
    MzxEpKHt9ZXUNMwmfWwpdpqy4en1j8dDzCUc2AWf7t3Npx95BLMc2df>
X-ME-Received: <xmr:wJD_aKXfKmx35KlJysr-rf0pYoYMtJkDwGYoTrd1K6qKJjNMuTqZdh3Awruw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepueeuleevieefveefjeevhfeuleefvefgveegkeffvdeugeduffevueek
    leelueejnecuffhomhgrihhnpehtrghgrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvght
    pdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    hirghnsgholhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfth
    drnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhmpdhrtghpthhtoh
    eptghrrghtihhusehnvhhiughirgdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehg
    ohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepughsrghhvghrnheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtgho
    mh
X-ME-Proxy: <xmx:wJD_aCbifJII4GKa-rzm3l3-fODjX27b3CEpANVolj4Hg5-fVoLkQg>
    <xmx:wJD_aJyns8mzhnl4gKYtMHUH6ntA4Sn4P_tMUVzpUitVLbZKItSTTg>
    <xmx:wJD_aK3CkkgFXsOWguKhRXQeHijB2zg17q-R6MMHC6SamcvVOUqZyw>
    <xmx:wJD_aCnoaoWNt4K9xGfZptdBtcGovjupxpwq1b1aFBc0jz7vg0RCNw>
    <xmx:wZD_aNkLv4kb7Ez2g3WWAH-10109EdR5aJqMpv0A221RdCI8jxeJhwij>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 11:33:19 -0400 (EDT)
Date: Mon, 27 Oct 2025 16:33:18 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	steffen.klassert@secunet.com, Cosmin Ratiu <cratiu@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH ipsec v2 2/2] xfrm: Determine inner GSO type from packet
 inner protocol
Message-ID: <aP-QvtNf-Vp5oHLX@krikkit>
References: <20251027025006.46596-1-jianbol@nvidia.com>
 <20251027025006.46596-3-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027025006.46596-3-jianbol@nvidia.com>

2025-10-27, 04:40:59 +0200, Jianbo Liu wrote:
> The GSO segmentation functions for ESP tunnel mode
> (xfrm4_tunnel_gso_segment and xfrm6_tunnel_gso_segment) were
> determining the inner packet's L2 protocol type by checking the static
> x->inner_mode.family field from the xfrm state.
> 
> This is unreliable. In tunnel mode, the state's actual inner family
> could be defined by x->inner_mode.family or by
> x->inner_mode_iaf.family. Checking only the former can lead to a
> mismatch with the actual packet being processed, causing GSO to create
> segments with the wrong L2 header type.
> 
> This patch fixes the bug by deriving the inner mode directly from the
> packet's inner protocol stored in XFRM_MODE_SKB_CB(skb)->protocol.
> 
> Fixes: 26dbd66eab80 ("esp: choose the correct inner protocol for GSO on inter address family tunnels")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
> V2:
>  - Change subject prefix, and send to "ipsec".
>  - Add Fixes tag.
> 
>  net/ipv4/esp4_offload.c | 6 ++++--
>  net/ipv6/esp6_offload.c | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
> index e0d94270da28..05828d4cb6cd 100644
> --- a/net/ipv4/esp4_offload.c
> +++ b/net/ipv4/esp4_offload.c
> @@ -122,8 +122,10 @@ static struct sk_buff *xfrm4_tunnel_gso_segment(struct xfrm_state *x,
>  						struct sk_buff *skb,
>  						netdev_features_t features)
>  {
> -	__be16 type = x->inner_mode.family == AF_INET6 ? htons(ETH_P_IPV6)
> -						       : htons(ETH_P_IP);
> +	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x,
> +					XFRM_MODE_SKB_CB(skb)->protocol);

I don't think this is correct. inner_mode_iaf is not always set by
__xfrm_init_state, only when we have a AF_UNSPEC selector, which is
not always the case for cross-family tunnels. So we would end up with
inner_mode->family = 0 here, and pass the wrong type to
skb_eth_gso_segment.

Other users of xfrm_ip2inner_mode (in ip_vti/ip6_vti, xfrmi) only call
it when we have an AF_UNSPEC selector, then we know inner_mode_iaf is
valid and can be used. Otherwise, the selector (ie x->inner_mode)
should have the right family for the packet (and all callers of
xfrm_ip2inner_mode use x->inner_mode when the selector is not
AF_UNSPEC).


Maybe it would be better to move the AF_UNSPEC check into
xfrm_ip2inner_mode, something like:

static inline const struct xfrm_mode *xfrm_ip2inner_mode(struct xfrm_state *x, int ipproto)
{
	if (x->sel.family != AF_UNSPEC)
		return &x->inner_mode;

	if ((ipproto == IPPROTO_IPIP && x->props.family == AF_INET) ||
	    (ipproto == IPPROTO_IPV6 && x->props.family == AF_INET6))
		return &x->inner_mode;
	else
		return &x->inner_mode_iaf;
}


since that's what all the callers are doing anyway?

Then it would be valid to use xfrm_ip2inner_mode like you're doing.

-- 
Sabrina

