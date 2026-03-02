Return-Path: <netdev+bounces-262616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GASSH9tzpWkNBgYAu9opvQ
	(envelope-from <netdev+bounces-262616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:26:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6681D771C
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D2E33016ED6
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F44362130;
	Mon,  2 Mar 2026 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="K2+r/Le+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aRzIV7bS"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4DB199EAD
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450776; cv=none; b=hrkBi4NzegH2JOl/0zbyZcmbYa6fIfSiiS9lYdGxYhTLmM5RMX3Fdg1kKYpZzrRxFn6nf4wUp3zptd54zeZLt2IV6hAvXchgNZmW/vD/n7s7Oz20Qv9xvRaCHp5ZNNGj17+m+P2ronnIoA1Oq/NRYI5u6KCNf4A71f1MuBmwpic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450776; c=relaxed/simple;
	bh=lCUzj0wrPvIj/RAFom1OT7zDz2gIPv1xsVe2Hd0Tym8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ml9V6BrKhk1tDnDETXQVIRlimv91Ts38VU4JHoFBxAaQDBsQQC1VptUKdG0lnCQZ0L7I19q52s+6Y49a1O8Q1aefmSQocF5gRCA/M2daJzL8QsfgMyll+8nc1ajurLq6RRW0qM7/ct2EEc4zB1F95dLaazg2mvxyaROlYF+cKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=K2+r/Le+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aRzIV7bS; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 48E53EC05D1;
	Mon,  2 Mar 2026 06:26:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 02 Mar 2026 06:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772450771; x=
	1772537171; bh=fR777Bm+TPENdmLm+vwFU3y9vWoFsIPtmEonhVffb6U=; b=K
	2+r/Le+uV/BOcNyEZbF9UcgS3+Pizh0iVs7fjpuOzW5CLTs18qI3PVZgtFhawWuC
	fqIwMGjlOgSxfFnIwyntnmNu6UOAZ+W1SE+htQKO2putOnb0yqnbJS6A9zEje//p
	HYX8xB6OdCAhf9uTJLV7SITlE7cbaqaa9vk23PZjnbz1m3o13CAG0/KgHK+qk3zo
	HBkrh4sUbZ25ObEBxjKlsy1T5AG9U5/If3H5lhy4PD/1LqXr3hccE3M0iCBbRuCH
	t/09InyLf1doYjKl0NA1dqmx/Si8AbUsNFtdS2TVnZSDCmnbunPs07UrHd6x3qZQ
	LidyS0z4iTkCHP2f6XU4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772450771; x=1772537171; bh=fR777Bm+TPENdmLm+vwFU3y9vWoFsIPtmEo
	nhVffb6U=; b=aRzIV7bSTycF02le8vhUaBTqdDW54Gg2YOVCd+vYBxpif78tnpc
	3RioUPzZRID9DT+4m9r8wgavBs51av+blEten3OgXjs8cPMtgd+pntITrB0NMG+R
	OJQOWtAD5Wgoo5l9pJIk9/JktpPG3Hh3zWGb/yoEpN/bJuLDCIKeau7xrvWpK0uA
	uGM8qPaaIg0ETdihGrVI9ivH9H9Nwj7y76ZFB7FB4Ai8yG/K/pWawytYpq58dEuW
	YMKw3bFRKC0AqwNQRgVjFdR41XwQ5QwJbIdpCO0bJKQeZRJr34r27aq1V6ZH26HS
	/EuwvVCerF6xAVWlr7qh6iaxe/rwlDZgYOg==
X-ME-Sender: <xms:0XOlaeRvcEzlOI1mnEiPtl6psPx1ns-VDqAt4WLQXUkPzHoPGCIFcQ>
    <xme:0XOlabLynny6zoK22as5KS-Yidfw_UTv0SUgCg8J9dKwg3lOMCyp5DZNGGO-wSCgd
    p2qnCPkUPjCn_RdUDwmZM41Y8d2plINj21hgf0YU02gCDvNipv97Svd>
X-ME-Received: <xmr:0XOlaRZGn_TAA9ESN94K82rqiGbV4uQ_uk5T1gvVVy5zKIjyV0Bt6zwM5pQ1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthessh
    gvtghunhgvthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehtohgsihgrshesshhtrhhonhhgshifrghnrdhorhhgpdhrtghpthhtohephhgvrhgs
    vghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopeguvghvvg
    hlsehlihhnuhigqdhiphhsvggtrdhorhhg
X-ME-Proxy: <xmx:0XOlaV93VNwPCDKIt4YIfCXP2cRTbrXaHMp3L_B0Uf6_1cC-dCiSTA>
    <xmx:0XOlaaabea_xdNnAfTo8-Y7wphzHIdJMK1Bn0GzmTxVw91phR00xtA>
    <xmx:0XOlaRM-W7F2IxZ0PXLzoM42exjm-OgewEpT0uyEn2OGdQN0lfQROA>
    <xmx:0XOlaeDfb4MsITyGlkGf36r1hNbltJ8O2Cu1O9bhnYaklNlMGgnb1w>
    <xmx:03OlaQ45G1WLBqhW5LGKEJBSlCaTKRrxHrUs_yLUtJ1VWCHsgT4ridQp>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 06:26:09 -0500 (EST)
Date: Mon, 2 Mar 2026 12:26:07 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Tobias Brunner <tobias@strongswan.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next] esp: Consolidate esp4 and esp6.
Message-ID: <aaVzz834HRXnR-to@krikkit>
References: <aZ_8Adz1m47-yzhp@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZ_8Adz1m47-yzhp@secunet.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262616-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Queue-Id: CA6681D771C
X-Rspamd-Action: no action

2026-02-26, 08:53:37 +0100, Steffen Klassert wrote:
> This patch merges common code of esp4.c and esp6.c into
> xfrm_esp.c. This almost halves the size of the ESP
> implementation for the price of three indirect calls
> on UDP/TCP encapsulation. No functional changes.
> 
> Changes from the RFC version:
> 
> - Fix a typo in the commit mesage.

the commit "mesage"? :)

> - Remove some old comments that don't make sense anymore.
> 
> - Let the ->input_encap functions return the needed offsets.
> 
> - Remove the IP_MAX_MTU check from UDP/TCP encap.
>   The IPv4/IPv6 local_out function will do that ceck later.
> 
> - The comment on IPv4 ESP offload with UDP encapsulation
>   is true for IPv4 and IPv6, so remove the IPv4 from the
>   comment.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> Tested-by: Tobias Brunner <tobias@strongswan.org>
> ---
>  include/net/esp.h       |    6 +
>  include/net/xfrm.h      |    4 +
>  net/ipv4/esp4.c         | 1065 ++------------------------------------
>  net/ipv6/esp6.c         | 1081 ++-------------------------------------
>  net/ipv6/esp6_offload.c |    6 +-
>  net/xfrm/Makefile       |    1 +
>  net/xfrm/xfrm_esp.c     | 1017 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 1132 insertions(+), 2048 deletions(-)
>  create mode 100644 net/xfrm/xfrm_esp.c
> 
> diff --git a/include/net/esp.h b/include/net/esp.h
> index 322950727dd0..5761c762c69a 100644
> --- a/include/net/esp.h
> +++ b/include/net/esp.h
> @@ -47,4 +47,10 @@ int esp_input_done2(struct sk_buff *skb, int err);
>  int esp6_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *esp);
>  int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *esp);
>  int esp6_input_done2(struct sk_buff *skb, int err);

Those 3 are gone now and can be removed.

> +int esp_init_aead(struct xfrm_state *x, struct netlink_ext_ack *extack);
> +int esp_init_authenc(struct xfrm_state *x, struct netlink_ext_ack *extack);
> +void esp_destroy(struct xfrm_state *x);
> +int esp_input(struct xfrm_state *x, struct sk_buff *skb);
> +int esp_output(struct xfrm_state *x, struct sk_buff *skb);
> +
>  #endif
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 0a14daaa5dd4..e3217cafe582 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -455,7 +455,11 @@ struct xfrm_type {
>  					      struct netlink_ext_ack *extack);
>  	void			(*destructor)(struct xfrm_state *);
>  	int			(*input)(struct xfrm_state *, struct sk_buff *skb);
> +	int			(*input_encap)(struct sk_buff *skb, struct xfrm_state *x);
>  	int			(*output)(struct xfrm_state *, struct sk_buff *pskb);
> +	struct sock		*(*find_tcp_sk)(struct xfrm_state *x);
> +	void			(*output_encap_csum)(struct sk_buff *skb);
> +	int			(*output_tcp_encap)(struct xfrm_state *x, struct sk_buff *skb);

This CB is unused.


> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index 2c922afadb8f..6c5568a96f0a 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
[...]
> +static int esp4_input_encap(struct sk_buff *skb, struct xfrm_state *x)
>  {
> +	const struct iphdr *iph = ip_hdr(skb);
> +	int ihl = iph->ihl * 4;
>  	struct xfrm_encap_tmpl *encap = x->encap;
[...]
> +	struct tcphdr *th = (void *)(skb_network_header(skb) + ihl);
> +	struct udphdr *uh = (void *)(skb_network_header(skb) + ihl);
> +	int ret = 0;
> +	__be16 source;
>  
> +	switch (x->encap->encap_type) {
>  	case TCP_ENCAP_ESPINTCP:
> -		esph = esp_output_tcp_encap(x, skb, esp);
> +		source = th->source;
> +		ret -= sizeof(struct tcphdr);

I'm trying to check how all those offset combine, isn't that
susceptible to the same problem as 17175d1a27c6 ("xfrm: esp6: fix
encapsulation header offset computation")?

Also, since those new ->input_encap should return a negative value on
success, the "return -1" for error is a bit confusing.
Maybe:
 - make them return +1 on error, without going through "goto out"
   (return -1 on error should be fine since that's not an expected
   offset)
 - make the final return (the one that returns the negative offset)
   have a DEBUG_NET_WARN_ON_ONCE(ret >= 0)

Or if my math is correct, the caller's hdr_len after adding
->input_encap's return value is the full length of the ipv* header
including options/extensions, so let ->input_encap return that
directly instead of doing the "hdr_len += ret" dance (and keep the
return -1 on error)? That would make things a bit clearer than
"skb_network_header_len + skb_network_offset + [whatever
ipv6_skip_exthdr returns]".


[...]
> @@ -1164,13 +194,16 @@ static int esp4_rcv_cb(struct sk_buff *skb, int err)
>  
>  static const struct xfrm_type esp_type =
>  {
> -	.owner		= THIS_MODULE,
> -	.proto	     	= IPPROTO_ESP,
> -	.flags		= XFRM_TYPE_REPLAY_PROT,
> -	.init_state	= esp_init_state,
> -	.destructor	= esp_destroy,
> -	.input		= esp_input,
> -	.output		= esp_output,
> +	.owner			= THIS_MODULE,
> +	.proto	     		= IPPROTO_ESP,

nit: since you're reworking the whitespace, this is:

\t.proto\t     \t\t= IPPROTO_ESP,

(with a few spaces in the middle)

[...]
> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index e75da98f5283..b90e93fc1a70 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
[...]
> -int esp6_input_done2(struct sk_buff *skb, int err)
> -{
[...]
> -		/*
> -		 * 2) ignore UDP/TCP checksums in case
> -		 *    of NAT-T in Transport Mode, or
> -		 *    perform other post-processing fixes
> -		 *    as per draft-ietf-ipsec-udp-encaps-06,
> -		 *    section 3.1.2
> -		 */
> -		if (x->props.mode == XFRM_MODE_TRANSPORT)
> -			skb->ip_summed = CHECKSUM_UNNECESSARY;
>  	}
>  
> -	skb_postpull_rcsum(skb, skb_network_header(skb),
> -			   skb_network_header_len(skb));

This doesn't get carried over to the new common function
esp_input_done2. It originally came from commit a9b28c2bf05d ("esp6:
Fix RX checksum after header pull"), not sure if it's still needed but
I guess so?


> -	skb_pull_rcsum(skb, hlen);
> -	if (x->props.mode == XFRM_MODE_TUNNEL ||
> -	    x->props.mode == XFRM_MODE_IPTFS)
> -		skb_reset_transport_header(skb);
> -	else
> -		skb_set_transport_header(skb, -hdr_len);
> -
> -	/* RFC4303: Drop dummy packets without any error */
> -	if (err == IPPROTO_NONE)
> -		err = -EINVAL;
> -
> -out:
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(esp6_input_done2);

[...]
> diff --git a/net/xfrm/xfrm_esp.c b/net/xfrm/xfrm_esp.c
> new file mode 100644
> index 000000000000..f277dc114ba6
> --- /dev/null
> +++ b/net/xfrm/xfrm_esp.c
[...]
> +
> +
> +#ifdef CONFIG_INET_ESPINTCP
> +static struct ip_esp_hdr *esp_output_tcp_encap(struct xfrm_state *x,
> +						    struct sk_buff *skb,
> +						    struct esp_info *esp)

nit: alignment

(checkpatch complains about this and a few other whitespace things in
this new file, probably all carried over from the existing code)


[...]
> +EXPORT_SYMBOL_GPL(esp_init_authenc);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Generic ESP");
> +

nit: git complains about the empty line

-- 
Sabrina

