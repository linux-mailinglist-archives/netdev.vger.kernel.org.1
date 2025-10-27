Return-Path: <netdev+bounces-233254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AB6C0F7CB
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AEF3BA42E
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBE93148B3;
	Mon, 27 Oct 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="kS2aIyKc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LBrDG07i"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041C31353E
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583974; cv=none; b=AwhqmkPbdZm/2uWL137uNS9Kds89tEJrZmqBepENPPM8AC1EJL719YeRA3B+qXBklufSUpKKM9liivOl+Q3761/yj9+Mi1Euqkc1HoTC62glczZyd1NVtmt9Xgw9NreV5sZPa2ds2xjEgGAQM+ATV0gALESmAwu9YUr0liPH46Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583974; c=relaxed/simple;
	bh=xtCNWvY8VVGzEveq9aN/NUJ0pfFdpRC/c9QaEu8hbNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR1MCO9HDdqOw4W7aLLQUBt9kueVZgkJ4apoPM60qMGHfNgWZezbhx5wdk1gCTUjFPEZfHDClWOyybOvotdrdolsCAIRbq2IfJLtt7F3rUplbcIytWNsQZZ0AwAIBO7aI9xfvfYea9OKCGlpCVtYf/6pm5fdLqwyLYnEBxHjyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=kS2aIyKc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LBrDG07i; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B49381400105;
	Mon, 27 Oct 2025 12:52:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 12:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761583969; x=
	1761670369; bh=EuLLR54NW9wSIS6MNXXHjdo4cVOLTuJj3SO7k+IxrQA=; b=k
	S2aIyKc+vRa+HgSkEGQF67OOdGztfxMwZuF5UqJoE8Q9s1eU6CVDjDIekT+0nkEe
	HpcYn4nMn0ZtuumvTQ+gT+gkTIx528bPaLbRf15DJjYTHq34icwPiMQ0XqzTVEGX
	qBaUI6lbL2ToPjGDiX+jN1BLkFTKwrH0aLEOu/IePeIsny9MKIEVQYkeMclD36X0
	QgCBc7wS/vyRYZ84KP954blW1iuzuAnolpwolaIDciXto7rmVVpoRGOYhJmboEtw
	MpmXok6OBPD7Dkv8OFe4HX1RmnoCM3+PTX8nVeZt+IBvk6QqR43+zUI8Njena9qK
	C3i0yrxhOASAe6Q+hEWPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761583969; x=1761670369; bh=EuLLR54NW9wSIS6MNXXHjdo4cVOLTuJj3SO
	7k+IxrQA=; b=LBrDG07i+i2RkcblKereqO4A55pzSBFKH9WCeq4jBTErAITuEeV
	ehm7KpCqP2kSPIXvlnMxNHS4HO31MspahncOIwNFrprUX+pT6fKirh0uzi43AMtx
	HC7DFCsWPO6gMtZYOm16ALvnfCrCJqQDzjnEw58n4OdD3ZRhZ3P+a0LsFsJqRT1I
	it6xziopQMt8SqHW7KlImBa4yqBI827cN68k7AOMUUNDta7rMum7zTtILzs2HKsW
	Axgb09G8VGondPDIJvW5XAdWVW2lZPLLHc9ujcAdDfi4kaX5XwA1dbxO0dcfjIcU
	GmQR7t8c7N6tdOwXFpsPsx8sNvLoXGfoPBg==
X-ME-Sender: <xms:YKP_aEmllL_JQLcBC5k7Y1qPboDhjvvaJsJqXU6QxY54G9F_441Feg>
    <xme:YKP_aLTt532_Ivbn4nr3ybagDcF_erwqO_GPDWNcbMMMahwF-xDtOKAJ2fOjHjkAK
    dJPwnAI19Krd4KTsi0KMQCL_6R3RcTP7pH71YhY-fQmearuKGSb15I>
X-ME-Received: <xmr:YKP_aAD2vWk01xvcEvwtdqa0_F8AoN2VTRmdWO3lCa8rdf5c1zXvQ27x5DpZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthessh
    gvtghunhgvthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopeguvghvvghlsehlihhnuhigqdhiphhsvggtrdhorhhg
X-ME-Proxy: <xmx:YKP_aKRBsGE3I84Wq1ZW4fBA56CqIf5jGOI1w3T1u5pH5xsnSFHMIg>
    <xmx:YKP_aGrGlhj909WFaakXngxy7RQFIcvMRir9KBHHYdXut52zMrgyNA>
    <xmx:YKP_aEw4v87AcEYg1-nXeze9JIT7tw5pEHOAnYnMJqRPl8ntSxQn4w>
    <xmx:YKP_aDJK4g_VbhDIfQkBw4SnAcC19AG43MZljiOOXHVWsS-RW4IAHQ>
    <xmx:YaP_aLKSkHu6QgxBVwYM88R12RArKw7ideTM3w9aWmDA62ZmqiEuk1eC>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 12:52:48 -0400 (EDT)
Date: Mon, 27 Oct 2025 17:52:46 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, devel@linux-ipsec.org
Subject: Re: [PATCH RFC ipsec-next] esp: Consolidate esp4 and esp6.
Message-ID: <aP-jXvmys9D37Hp6@krikkit>
References: <aPhzm0lzMXGSpf22@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPhzm0lzMXGSpf22@secunet.com>

2025-10-22, 08:03:07 +0200, Steffen Klassert wrote:
> This patch merges common code of esp4.c and esp6.c into
> xfrm_esp.c. This almost halves the size of the ESP
> implementation for the prize of three indirect calls
> on UDP/TCP encapsulation.

If that turns out to be a problem, maybe we can figure out a way to
use the INDIRECT_CALL* helpers here as well (but currently they don't
work for modules, I played with that a while back and could look into
it again).

> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> Tested-by: Tobias Brunner <tobias@strongswan.org>
> ---
>  include/net/esp.h       |    6 +
>  include/net/xfrm.h      |    4 +
>  net/ipv4/esp4.c         | 1067 ++------------------------------------
>  net/ipv6/esp6.c         | 1093 +++------------------------------------
>  net/ipv6/esp6_offload.c |    6 +-
>  net/xfrm/Makefile       |    1 +
>  net/xfrm/xfrm_esp.c     | 1025 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 1156 insertions(+), 2046 deletions(-)

nice!


> -int esp_input_done2(struct sk_buff *skb, int err)
> -{
[...]
> +	if (iph->saddr != x->props.saddr.a4 ||
> +	    source != encap->encap_sport) {
> +		xfrm_address_t ipaddr;
> +
> +		ipaddr.a4 = iph->saddr;
> +		km_new_mapping(x, &ipaddr, source);
> +
> +		/* XXX: perhaps add an extra
> +		 * policy check here, to see
> +		 * if we should allow or
> +		 * reject a packet from a
> +		 * different source
> +		 * address/port.
>  		 */

Maybe we can get rid of those "XXX" comments? Unless you think the
suggestion still makes sense. But the comments (here and in
esp6_input_done2) have been here a long time and it doesn't seem to
bother users.

[...]
>  static int esp_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)

Looking at esp_init_state and esp6_init_state, they also have a lot in
common (pretty much everything except some x->props.header_len
adjustments) that could be extracted into the new file.

[...]
> +static int esp6_input_encap(struct sk_buff *skb, struct xfrm_state *x)
>  {
> +	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
> +	int offset = skb_network_offset(skb) + sizeof(*ip6h);
> +	int hdr_len = skb_network_header_len(skb);

As Simon mentioned, it's set/incremented but not used. The current
code in esp6_input_done2 would then use that value in
skb_set_transport_header, but now the common esp_input_done2 calls
->input_encap and doesn't get that increased value back. I think we'll
need to have esp_input_done2 pass &hdr_len when it calls the
->input_encap to get the correct value and take into account ipv6
exthdrs.


[...]
> +static void esp_output_done(void *data, int err)
> +{
> +	struct sk_buff *skb = data;
> +	struct xfrm_offload *xo = xfrm_offload(skb);
> +	void *tmp;
> +	struct xfrm_state *x;
> +
> +	if (xo && (xo->flags & XFRM_DEV_RESUME)) {
> +		struct sec_path *sp = skb_sec_path(skb);
> +
> +		x = sp->xvec[sp->len - 1];
> +	} else {
> +		x = skb_dst(skb)->xfrm;
> +	}
> +
> +	tmp = ESP_SKB_CB(skb)->tmp;
> +	esp_ssg_unref(x, tmp, skb);
> +	kfree(tmp);
> +
> +	x->type->output_encap_csum(skb);

Since the ipv4 variant doesn't do anything, maybe

if (x->type->output_encap_csum)
	x->type->output_encap_csum(skb);

and don't set it in esp_type?

OTOH it's nice to have a consistent "all CBs are always defined" and
just call them unconditionally.



> +static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,
> +					       int encap_type,
> +					       struct esp_info *esp,
> +					       __be16 sport,
> +					       __be16 dport)
> +{
> +	struct udphdr *uh;
> +	unsigned int len;
> +	struct xfrm_offload *xo = xfrm_offload(skb);
> +
> +	len = skb->len + esp->tailen - skb_transport_offset(skb);
> +	if (len + sizeof(struct iphdr) > IP_MAX_MTU)

This is now used by both IPv4 and IPv6, and esp6_output_udp_encap
didn't have any adjustment in this test.

> +		return ERR_PTR(-EMSGSIZE);
> +
> +	uh = (struct udphdr *)esp->esph;
> +	uh->source = sport;
> +	uh->dest = dport;
> +	uh->len = htons(len);
> +	uh->check = 0;
> +
> +	/* For IPv4 ESP with UDP encapsulation, if xo is not null, the skb is in the crypto offload
> +	 * data path, which means that esp_output_udp_encap is called outside of the XFRM stack.
> +	 * In this case, the mac header doesn't point to the IPv4 protocol field, so don't set it.
> +	 */
> +	if (!xo || encap_type != UDP_ENCAP_ESPINUDP)
> +		*skb_mac_header(skb) = IPPROTO_UDP;

That was absent in esp6_output_udp_encap, commit 447bc4b1906f ("xfrm:
Support crypto offload for outbound IPv4 UDP-encapsulated ESP packet")
only took care of IPv4. I'm not sure adding this to the IPv6 code
without adapting the rest of 447bc4b1906f in the esp6_offload code is
correct.

> +
> +	return (struct ip_esp_hdr *)(uh + 1);
> +}

[...]
> + int esp_output(struct xfrm_state *x, struct sk_buff *skb)

nit: ' ' at the start of the line


-- 
Sabrina

