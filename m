Return-Path: <netdev+bounces-249001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F60AD12880
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 401A9300D29B
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115D3352C46;
	Mon, 12 Jan 2026 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="WXPyeiKl"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644B352C3F
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220644; cv=none; b=jUl7G0bld7EArWltQqOEQ3quCugElbJDXoB2O49hv5WHbWp19wyLkIsMwsL11fPG3lfPhebzYhsF/v/6b/yqB1tX51su1SddzOcaqyj3bB2mRR+jHIShVWISFxy9LTS1t+dquzDQT8WIVPZnpsm/oBKxAFQnsUYrqJZEYivFTCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220644; c=relaxed/simple;
	bh=OLKdb8chvw7R4HEuCyJOjvQb561sK52IZueEj8urZnk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMc4rgBapMLTrSSSdK8h54SjcaYvwSThd0AagQxqIgH5je9d73LVJ/JxtN9+iSawYobUEXHyPg2olfrIo7dMuzt3c3hePJa5E7yAw2dRX248rngpkhvvaxVb977ghGtz7L8RcGV3KOXX4W9Z3HiMlaufz6fR5wQAfbhAnar9E7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=WXPyeiKl; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id F28012019D;
	Mon, 12 Jan 2026 13:23:52 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hvk8T0Lh0Oyn; Mon, 12 Jan 2026 13:23:52 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 401A620049;
	Mon, 12 Jan 2026 13:23:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 401A620049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768220632;
	bh=6qr9f591+B+r8XmaBooH0ts7PpuPkLvzaFcN/46qPgs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=WXPyeiKlzY75Zt5o7Ff23oXbUjz7hAssv9Uf0JLwWYewxd15keWSeKQE7x8naIGp7
	 0H3iBEFz8SCIMkxDB4XyWBNsRUUNYtCz1k7dAWiG1aWlk/Y5yMX9kisrZzPJj1j7YQ
	 dtGiw0N2ltw3mRe3wgSV3q/hLAPWrcx0OEcUaMh4ZkDckGQxqvfk+hVbe1J3MyKl9Q
	 +QCCUAxnBotWlucMqCl6ZqgdHAnYayGo9aZbjMlsWyvkkrmkTiLAYSqZIDdI0+Lr/M
	 ZKp80NetJ7p9OvW7JQrzwTC6iyjQaPcgaFO5RTw+dIBAv9BCoxIjVnPv12+lvmPZFg
	 xqYs+IW52qD/w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 13:23:51 +0100
Received: (nullmailer pid 3018200 invoked by uid 1000);
	Mon, 12 Jan 2026 12:23:51 -0000
Date: Mon, 12 Jan 2026 13:23:51 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: Re: [PATCH RFC ipsec-next] esp: Consolidate esp4 and esp6.
Message-ID: <aWTn12LAh-KnSoeM@secunet.com>
References: <aPhzm0lzMXGSpf22@secunet.com>
 <aP-jXvmys9D37Hp6@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aP-jXvmys9D37Hp6@krikkit>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Oct 27, 2025 at 05:52:46PM +0100, Sabrina Dubroca wrote:
> 2025-10-22, 08:03:07 +0200, Steffen Klassert wrote:
> > This patch merges common code of esp4.c and esp6.c into
> > xfrm_esp.c. This almost halves the size of the ESP
> > implementation for the prize of three indirect calls
> > on UDP/TCP encapsulation.
> 
> If that turns out to be a problem, maybe we can figure out a way to
> use the INDIRECT_CALL* helpers here as well (but currently they don't
> work for modules, I played with that a while back and could look into
> it again).

I have no indication that it could be a problem so far,
but would be nice to have the INDIRECT_CALL* helpers
for modules anyway!

> > -int esp_input_done2(struct sk_buff *skb, int err)
> > -{
> [...]
> > +	if (iph->saddr != x->props.saddr.a4 ||
> > +	    source != encap->encap_sport) {
> > +		xfrm_address_t ipaddr;
> > +
> > +		ipaddr.a4 = iph->saddr;
> > +		km_new_mapping(x, &ipaddr, source);
> > +
> > +		/* XXX: perhaps add an extra
> > +		 * policy check here, to see
> > +		 * if we should allow or
> > +		 * reject a packet from a
> > +		 * different source
> > +		 * address/port.
> >  		 */
> 
> Maybe we can get rid of those "XXX" comments? Unless you think the
> suggestion still makes sense. But the comments (here and in
> esp6_input_done2) have been here a long time and it doesn't seem to
> bother users.

Good point, I'll remove them in the next version.

> 
> [...]
> >  static int esp_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
> 
> Looking at esp_init_state and esp6_init_state, they also have a lot in
> common (pretty much everything except some x->props.header_len
> adjustments) that could be extracted into the new file.

Yes, true. This patch is just a start, there is much more possible.

> [...]
> > +static int esp6_input_encap(struct sk_buff *skb, struct xfrm_state *x)
> >  {
> > +	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
> > +	int offset = skb_network_offset(skb) + sizeof(*ip6h);
> > +	int hdr_len = skb_network_header_len(skb);
> 
> As Simon mentioned, it's set/incremented but not used. The current
> code in esp6_input_done2 would then use that value in
> skb_set_transport_header, but now the common esp_input_done2 calls
> ->input_encap and doesn't get that increased value back. I think we'll
> need to have esp_input_done2 pass &hdr_len when it calls the
> ->input_encap to get the correct value and take into account ipv6
> exthdrs.

Either this, or ->input_encap returns the offset of the ipv6
exthdrs and then add this value to hdr_len in esp_input_done2().

> [...]
> > +static void esp_output_done(void *data, int err)
> > +{
> > +	struct sk_buff *skb = data;
> > +	struct xfrm_offload *xo = xfrm_offload(skb);
> > +	void *tmp;
> > +	struct xfrm_state *x;
> > +
> > +	if (xo && (xo->flags & XFRM_DEV_RESUME)) {
> > +		struct sec_path *sp = skb_sec_path(skb);
> > +
> > +		x = sp->xvec[sp->len - 1];
> > +	} else {
> > +		x = skb_dst(skb)->xfrm;
> > +	}
> > +
> > +	tmp = ESP_SKB_CB(skb)->tmp;
> > +	esp_ssg_unref(x, tmp, skb);
> > +	kfree(tmp);
> > +
> > +	x->type->output_encap_csum(skb);
> 
> Since the ipv4 variant doesn't do anything, maybe
> 
> if (x->type->output_encap_csum)
> 	x->type->output_encap_csum(skb);
> 
> and don't set it in esp_type?
> 
> OTOH it's nice to have a consistent "all CBs are always defined" and
> just call them unconditionally.

Let's keeep the CBs always defined.

> > +static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,
> > +					       int encap_type,
> > +					       struct esp_info *esp,
> > +					       __be16 sport,
> > +					       __be16 dport)
> > +{
> > +	struct udphdr *uh;
> > +	unsigned int len;
> > +	struct xfrm_offload *xo = xfrm_offload(skb);
> > +
> > +	len = skb->len + esp->tailen - skb_transport_offset(skb);
> > +	if (len + sizeof(struct iphdr) > IP_MAX_MTU)
> 
> This is now used by both IPv4 and IPv6, and esp6_output_udp_encap
> didn't have any adjustment in this test.

I wonder whether this check makes sense here at all. We add ESP
headers and trailers, and just in case of UDP/TCP encapsulation,
we check the size of the resulting packet. If we need such a check,
it should be on a more generic place.

Another thing I noticed when looking into this. The code
above is from ipv4 udpencap. All other encap functions do:

len = skb->len + esp->tailen - skb_transport_offset(skb);
if (len > IP_MAX_MTU)
	return ERR_PTR(-EMSGSIZE);

I think this is 'kind of' correct for ipv6, but not for ipv4 tcpencap:

#define IP_MAX_MTU      0xFFFFU
#define IP6_MAX_MTU (0xFFFF + sizeof(struct ipv6hdr))

> > +		return ERR_PTR(-EMSGSIZE);
> > +
> > +	uh = (struct udphdr *)esp->esph;
> > +	uh->source = sport;
> > +	uh->dest = dport;
> > +	uh->len = htons(len);
> > +	uh->check = 0;
> > +
> > +	/* For IPv4 ESP with UDP encapsulation, if xo is not null, the skb is in the crypto offload
> > +	 * data path, which means that esp_output_udp_encap is called outside of the XFRM stack.
> > +	 * In this case, the mac header doesn't point to the IPv4 protocol field, so don't set it.
> > +	 */
> > +	if (!xo || encap_type != UDP_ENCAP_ESPINUDP)
> > +		*skb_mac_header(skb) = IPPROTO_UDP;
> 
> That was absent in esp6_output_udp_encap, commit 447bc4b1906f ("xfrm:
> Support crypto offload for outbound IPv4 UDP-encapsulated ESP packet")
> only took care of IPv4. I'm not sure adding this to the IPv6 code
> without adapting the rest of 447bc4b1906f in the esp6_offload code is
> correct.

Hm, that would mean ipv6 udpencap offload can be configured,
but does not work in the current codebase. Maybe this needs
a separate fix.

> > +
> > +	return (struct ip_esp_hdr *)(uh + 1);
> > +}
> 
> [...]
> > + int esp_output(struct xfrm_state *x, struct sk_buff *skb)
> 
> nit: ' ' at the start of the line

Fixed.

Thanks!

