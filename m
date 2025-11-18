Return-Path: <netdev+bounces-239632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53632C6A905
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D9AA92BFF1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC222F28E2;
	Tue, 18 Nov 2025 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="k1NOmQUO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L2+CBMro"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C372773F0
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482682; cv=none; b=A9q0NR6dHjvP2g+/P1+dMA1LjmUakqzzqisLMpHLzRkhGJVo3u8GLmFcwb2/F8G2oMRCqCGaBiZE26bDs+sgad8l6QhkLt6NsPRJWE8+ZAUqmhcWHc3uypElTKZRngb6FDenptEuwnFO8D4rS9opGGgeLyQLDXVGkhHVNBLbwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482682; c=relaxed/simple;
	bh=u0gtnaApiZnq2cPIW561zxzQmzLaZijW9TS6GXU/uOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGGi9oEdxzy0SO1Z5l1iOfGNjkcjpc80wmwSWQNLaq4xcBWna0FT603Uz7FpwvlhubYqYuZWcf361YLRmXNhfT+RNPKTKqUq5pZh2R79vghMvBgOXdOOEoI99Vl/BdrH7T7GKT31pd22cPENByPUx5SA8VhfQpG4tVlyD8sX8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=k1NOmQUO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L2+CBMro; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1227614001DC;
	Tue, 18 Nov 2025 11:17:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 18 Nov 2025 11:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1763482678; x=1763569078; bh=K2SJWdI2pMzWtqve5cGpGa8V1uLBi7xp
	WBS/PA2N3rc=; b=k1NOmQUOcEwHAooLrT0l63ehlh8dIrjGOZRllWlH4cspKoGg
	IcgDIngVL05/3qHV/6LrCeBCNrHWE6RXndWawHrHipDP4CtPTFscVIUUGU8eq31I
	bHfuX3l8y80YdAQ8joq4CmPH1HmFOH2bZinkozbSHsEhEP1bMUvFTf6BfVgWDuke
	0lcUyLUHRl/u8MmTRoYQ1R2o36RYgtOdbMNecGCXVOiIxchaiw3/xNsOUUa0sjV0
	u+HpxT6Xx/uK6JteAEy1ec6DzCqolD26A+iqLtgK8q8jsTX5nKQvQThQ4wT4eitA
	txXfkAah1v0WucSnuCuxLGA9nKKwGDd/I4+bEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763482678; x=
	1763569078; bh=K2SJWdI2pMzWtqve5cGpGa8V1uLBi7xpWBS/PA2N3rc=; b=L
	2+CBMro2125lXmpoPzBs1IbyrR8neNoFGZa6UmDbIQXpvqMGTwPjtm+0WF5xi40Z
	wqgsSPfTe+RntBfE6jTq92bKAqCeZugdxHZ7y7XV/TIu91oeVeRZpg7PcRDYkLt/
	BUrC8HsrldWDboYeLcHFESongN+1D1PxtknyYYCF6OBlP3/1sS/Iu6PSmpXuNBcf
	D0DRhxapCpOVFR1y1OV8apcsrCzHZuPtcS2MtADdHliO+syT+epTgLOqn/ZRiNhG
	h8YtKhpRcfppn5qqnLV5zQRQXbwAmiNYgW2NprSxkX1sHr709gn76mBH+hNSwnnb
	yE98vskHUH/2FBA8MQq1g==
X-ME-Sender: <xms:NZwcaf5nfIMaHPA8cvWgZppscc9ngzBBiLeIvcbe74deIVm3xO3n-Q>
    <xme:NZwcaT9293Hoj7uWo6SzxFlMfw2_x97xRAHgXwVUT8OfkilVPPPlWSbxZwTdAJUqf
    zkF9_-QISX9B7k3d2jAvLd-nvpyYSJU6Y-yb_s2BqlMyx9xG2SxGw>
X-ME-Received: <xmr:NZwcacqwOhJdnUMI81F8r219Lhf0JZnyxozGw-Mhn2pDJ9D2bUIzaxm6pQEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddujeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpeefkefgfefgtdejvdejhedtffelteetteeuudfgffeileeiteejtedu
    geeuudeggfenucffohhmrghinhepshhkpggtsgdrshhknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhn
    vghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hrrghlfhesmhgrnhguvghlsghithdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvph
    hnrdhnvghtpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdp
    rhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvg
    guuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:NZwcacrf8xhjT6tWdCI1UMNt6ElHpquzBUBlOn0phy_bkNOk3ISVqw>
    <xmx:NZwcaX1TXF1LK20Y6qKdvPqcYRASpsJH1aubKmApRs9XYt7B1xgQ0Q>
    <xmx:NZwcaSHYRfEDiGrT83ymAYPzs0ncQp5GMR8TeukYKxK79_JFO78hrQ>
    <xmx:NZwcaaH8GdoH8zNtj2cINPgC37rdBk7iiH6D7k-x0Nvw2FrRiur01A>
    <xmx:NpwcacTW9aWwK2lJ4RHBdNJ19ATs0ktvvX1JtUHOh7goxdIkdPZSFG77>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 11:17:56 -0500 (EST)
Date: Tue, 18 Nov 2025 17:17:54 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, Antonio Quartulli <antonio@openvpn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC net-next] ovpn: allocate smaller skb when TCP headroom
 exceeds u16
Message-ID: <aRycMp7hlhY3ZC5U@krikkit>
References: <20251113122143.357579-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113122143.357579-1-ralf@mandelbit.com>

2025-11-13, 13:21:43 +0100, Ralf Lici wrote:
> Hi all,
> 
> While testing openvpn over TCP under high traffic conditions,
> specifically on the same machine using net namespaces (with veth pairs
> interconnecting them), we consistently hit a warning in
> skb_reset_network_header. The culprit is an attempt to store an offset
> (skb->data - skb->head) larger than U16_MAX in skb->network_header,
> which is a u16. This leads to packet drops.
> 
> In ovpn_tcp_recv, we're handed an skb from __strp_rcv and need to
> linearize it and pull up to the beginning of the openvpn packet. If it's

We don't currently linearize (= move all the data into ->head), right?

> a data-channel packet, we then pull an additional 24 bytes of openvpn
> encapsulation header so that skb->data points to the inner IP packet.
> This is necessary for authentication, decryption, and reinjection into
> the networking stack of the decapsulated packet, but when the skb is too
> large, the network header offset overflows the field.
> 
> AFAWCT, these oversized skbs can result from:
> - GRO,
> - TCP skb coalescing (tcp_try_coalesce, skb_try_coalesce),
> - streamparser (__strp_rcv appends more skbs when an openvpn packet
>   spans multiple skbs).
>
> Note that this issue is likely affecting espintcp as well, since its
> logic similarly involves extracting discrete packets from a coalesced
> TCP stream handed off by streamparser, and reinjecting them into the
> stack.

Most likely yes. I'll see if I can reproduce the problem on espintcp.

> We've brainstormed a few possible directions, though we haven't yet
> assessed their feasibility:
> - introduce a u32 field in struct tcp_sock to limit skb->len during TCP
>   coalescing (each socket user can set the limit if needed);

I doubt the TCP maintainers would accept a patch to TCP for a problem
that affects only (some of) the users of strp.

> - modify strp to build an skb containing only the relevant frags for the
>   current openvpn packet in frag_list.

This would penalize the other users of strp. It may make sense to
introduce such a mechanism in strp, but only on request (eg via a bool
in strp_init, a flag in the cb struct).

> In this patch, we implement a solution entirely contained within ovpn:
> we allocate a new skb and copy the content of the current openvpn packet
> into it. This avoids the large headroom issue, but it’s not ideal
> because the kernel keeps coalescing skbs while we effectively undo that
> work, which isn’t very efficient.

Well, that coalescing is useful, and the un-coalescing is necessary
(because even without this offset problem, we have to get back the
individual packets from the stream).


Copying the full contents (full_len) of the openvpn packet seems a bit
heavy when what we want is "pull and get rid of that extra space at
the head". It seems pskb_extract would do the job without manual
handling in ovpn and without copying the entire payload? (but it will
clone the skb and realloc the head every time, so we'd only want to
call it in the "offset too big" case)

> We're sending this RFC to gather ideas and suggestions on how best to
> address this issue. Any thoughts or guidance would be appreciated.

One thing I'm a bit concerned about is if those reduced skbs need to
be re-sent somewhere else. Then we don't have any headroom to push a
new header and we'll have to realloc again to create some space. OTOH
it doesn't really make sense to carry 65kB of extra data through the
stack.



A few comments on the implementation:

[...]
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> index b7348da9b040..301fcb1c0495 100644
> --- a/drivers/net/ovpn/tcp.c
> +++ b/drivers/net/ovpn/tcp.c
> @@ -70,39 +70,87 @@ static void ovpn_tcp_to_userspace(struct ovpn_peer *peer, struct sock *sk,
>  	peer->tcp.sk_cb.sk_data_ready(sk);
>  }
>  
> -static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
> +/* takes ownership of orig_skb */
> +static struct sk_buff *ovpn_tcp_skb_packet(const struct ovpn_peer *peer,
> +					   struct sk_buff *orig_skb,
> +					   const int full_len, const int offset)
>  {
> -	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
> -	struct strp_msg *msg = strp_msg(skb);
> -	size_t pkt_len = msg->full_len - 2;
> -	size_t off = msg->offset + 2;
> -	u8 opcode;
> +	struct sk_buff *ovpn_skb = orig_skb;
> +	const int pkt_len = full_len - 2;
> +	int pkt_offset = offset + 2;
> +	int err;
> +
> +	/* If the final headroom will overflow a u16 we will not be able to
> +	 * reset the network header to it so we need to create a new smaller
> +	 * skb with the content of this packet.
> +	 */
> +	if (unlikely(skb_headroom(orig_skb) + pkt_offset + OVPN_HEADER_SIZE >
> +		     U16_MAX)) {
> +		ovpn_skb = netdev_alloc_skb(peer->ovpn->dev, full_len);

From my reading of __strp_recv, strp already gave us a fresh clone, do
we need to reallocate a full skb?

> +		if (!ovpn_skb) {
> +			ovpn_skb = orig_skb;
> +			goto err;
> +		}
> +
> +		skb_copy_header(ovpn_skb, orig_skb);
> +		pkt_offset = 2;
> +
> +		/* copy the entire openvpn packet + 2 bytes length */
> +		err = skb_copy_bits(orig_skb, offset,
> +				    skb_put(ovpn_skb, full_len), full_len);
> +		kfree(orig_skb);
> +		if (err) {
> +			net_warn_ratelimited("%s: skb_copy_bits failed for peer %u\n",
> +					     netdev_name(peer->ovpn->dev),
> +					     peer->id);
> +			goto err;
> +		}
> +	}
>  
>  	/* ensure skb->data points to the beginning of the openvpn packet */
> -	if (!pskb_pull(skb, off)) {
> +	if (!pskb_pull(ovpn_skb, pkt_offset)) {
>  		net_warn_ratelimited("%s: packet too small for peer %u\n",
> -				     netdev_name(peer->ovpn->dev), peer->id);
> +				     netdev_name(peer->ovpn->dev),
> +				     peer->id);
>  		goto err;
>  	}
>  
>  	/* strparser does not trim the skb for us, therefore we do it now */
> -	if (pskb_trim(skb, pkt_len) != 0) {
> +	if (pskb_trim(ovpn_skb, pkt_len) != 0) {
>  		net_warn_ratelimited("%s: trimming skb failed for peer %u\n",
> -				     netdev_name(peer->ovpn->dev), peer->id);
> +				     netdev_name(peer->ovpn->dev),
> +				     peer->id);
>  		goto err;
>  	}
>  
> +	return ovpn_skb;
> +err:
> +	kfree(ovpn_skb);

This needs to be kfree_skb/consume_skb in all cases where you're
freeing an skb.

> +	return NULL;
> +}

-- 
Sabrina

