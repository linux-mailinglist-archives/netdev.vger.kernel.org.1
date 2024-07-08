Return-Path: <netdev+bounces-109849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA7F92A133
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19B81C2039E
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEDD5579F;
	Mon,  8 Jul 2024 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="V+PhPgcA"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120451DA23
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438235; cv=none; b=FkxkChp2imb9maUDil07gnPJL+q/3TIDjQMB4m1mMivQQZbov6bWG/vT/+DagNykNBUPLp+PMyzUFk/gif4NKbVmDZtEYosQPPDAuxhVt667zEs3bPZ5YllDK1FApPQFWQTlcr2iREAHWMg5H/TVdXHfyT3q9x25QExaq4g5bO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438235; c=relaxed/simple;
	bh=O2YTG3UYLoMKc5Aqhnn76lgFEpKdzLTDAhyQ0Va5vg4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgRuyNQWKlCLiBdH2rXCwECAcR0+ogL6VW8+J/9dAnhNqgHiwg0C9r0GvkLjYQ/KNS3etEFDwQuUVEg5tRgrhg413pZIoE7zdLhLjj9lqBFq1YMPWiOSV3ooYU4R9YCFY9kALZ/D9Z6mI7JwgoyPgTKN29/CEx9BJvlAEoJV690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=V+PhPgcA; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CED88207B2;
	Mon,  8 Jul 2024 13:30:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vzaBr35fjjrE; Mon,  8 Jul 2024 13:30:23 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3213120748;
	Mon,  8 Jul 2024 13:30:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3213120748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720438223;
	bh=j8CcVSIfInpwl//bVS3j68qNkFK5J6DOM80hnFojlSc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=V+PhPgcAXIfKjWzaVzQ9ck1yYRESjGKiyuTHcGW8x44Vx1M0KgBcKwxvRnV41kA/f
	 DkTa9M6zMr1/d16MG9I7rpwC88WJyWkDc8irM2L9+1xr8MwAPZo1jHte4wqc16a/PA
	 303Ux0jBv4MWG1n/l7wndhrUFWIt9evMnGDXeTLDQ0tyZNzOeCMXweMShYwcv3eSYG
	 YvWT/dygGamDYU67v3A0dj3SqSxLGsLznf8vdkbw/othyPgu4CF4iewquNRkWnkrqv
	 bMaWS/qLJIDm0cBQS9m+tqgV0i5WXjZ+5CxBjpZI5aol/vDQj+0N97+0bf4Iks3ZGo
	 hX+c6MsRHJkrA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 29EC980004A;
	Mon,  8 Jul 2024 13:30:23 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 13:30:22 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 13:30:22 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4C9953182B1B; Mon,  8 Jul 2024 13:30:22 +0200 (CEST)
Date: Mon, 8 Jul 2024 13:30:22 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Mike Yu <yumike@google.com>
CC: <netdev@vger.kernel.org>, <stanleyjhu@google.com>, <martinwu@google.com>,
	<chiachangwang@google.com>
Subject: Re: [PATCH ipsec 4/4] xfrm: Support crypto offload for outbound IPv4
 UDP-encapsulated ESP packet
Message-ID: <ZovNzu58oGJv1plS@gauss3.secunet.de>
References: <20240702084452.2259237-1-yumike@google.com>
 <20240702084452.2259237-5-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240702084452.2259237-5-yumike@google.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Jul 02, 2024 at 04:44:51PM +0800, Mike Yu wrote:
> esp_xmit() is already able to handle UDP encapsulation through the call to
> esp_output_head(). The missing part in esp_xmit() is to correct the outer
> IP header.
> 
> Test: Enabled both dir=in/out IPsec crypto offload, and verified IPv4
>       UDP-encapsulated ESP packets on both wifi/cellular network
> Signed-off-by: Mike Yu <yumike@google.com>
> ---
>  net/ipv4/esp4.c         |  7 ++++++-
>  net/ipv4/esp4_offload.c | 14 +++++++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index 3968d3f98e08..cd4b52e131ce 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -349,6 +349,7 @@ static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,
>  {
>  	struct udphdr *uh;
>  	unsigned int len;
> +	struct xfrm_offload *xo = xfrm_offload(skb);
>  
>  	len = skb->len + esp->tailen - skb_transport_offset(skb);
>  	if (len + sizeof(struct iphdr) > IP_MAX_MTU)
> @@ -360,7 +361,11 @@ static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,
>  	uh->len = htons(len);
>  	uh->check = 0;
>  
> -	*skb_mac_header(skb) = IPPROTO_UDP;
> +	// For IPv4 ESP with UDP encapsulation, if xo is not null, the skb is in the crypto offload
> +	// data path, which means that esp_output_udp_encap is called outside of the XFRM stack.
> +	// In this case, the mac header doesn't point to the IPv4 protocol field, so don't set it.

Please use networking style comments.

> +	if (!xo || encap_type != UDP_ENCAP_ESPINUDP)
> +		*skb_mac_header(skb) = IPPROTO_UDP;
>  
>  	return (struct ip_esp_hdr *)(uh + 1);
>  }
> diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
> index b3271957ad9a..ccfc466ddf6c 100644
> --- a/net/ipv4/esp4_offload.c
> +++ b/net/ipv4/esp4_offload.c
> @@ -264,6 +264,7 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
>  	struct esp_info esp;
>  	bool hw_offload = true;
>  	__u32 seq;
> +	int encap_type = 0;
>  
>  	esp.inplace = true;
>  
> @@ -296,8 +297,10 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
>  
>  	esp.esph = ip_esp_hdr(skb);
>  
> +	if (x->encap)
> +		encap_type = x->encap->encap_type;
>  
> -	if (!hw_offload || !skb_is_gso(skb)) {
> +	if (!hw_offload || !skb_is_gso(skb) || (hw_offload && encap_type == UDP_ENCAP_ESPINUDP)) {
>  		esp.nfrags = esp_output_head(x, skb, &esp);
>  		if (esp.nfrags < 0)
>  			return esp.nfrags;
> @@ -324,6 +327,15 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
>  
>  	esp.seqno = cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
>  
> +	if (hw_offload && encap_type == UDP_ENCAP_ESPINUDP) {
> +		// In the XFRM stack, the encapsulation protocol is set to iphdr->protocol by
> +		// setting *skb_mac_header(skb) (see esp_output_udp_encap()) where skb->mac_header
> +		// points to iphdr->protocol (see xfrm4_tunnel_encap_add()).
> +		// However, in esp_xmit(), skb->mac_header doesn't point to iphdr->protocol.
> +		// Therefore, the protocol field needs to be corrected.

Same here.


