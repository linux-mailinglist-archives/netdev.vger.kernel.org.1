Return-Path: <netdev+bounces-298964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sRpfIytaLWrpfAQAu9opvQ
	(envelope-from <netdev+bounces-298964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 15:24:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF23767EAB3
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 15:24:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mandelbit.com header.s=MBO0001 header.b=grBG0Lj9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298964-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298964-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F03E30252B1
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719BD39C00F;
	Sat, 13 Jun 2026 13:24:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C8A1547C0;
	Sat, 13 Jun 2026 13:24:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781357095; cv=none; b=b5Zi4fQDgkjwlhJZ0LhXyI2Qh1R7Dxp4McVMPIF7i+E49Ow2Y+ZI/lJtKbxbeIb9WWvclGluv7izyh8n1edrATCvppKU1Ys0aRHs4n1YGRY7xV1ROmado6nFT9W0wDtx+vXSty1zpUb69LWhjpTwBVurMwHm/jTTz7YV1GHe2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781357095; c=relaxed/simple;
	bh=tgD9nPZkqA72gwF3WI70oFKSopYHCgNOQHp5knzFuO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gb2CGhc9G3WjEU9olKC6kDaV/pTuRg/Wn3KMmgk/gX+by2S0Xnh2l3T7y0x/s3ybhrrugVzsKB25t8WZUUMaBd1IBQFt1+siKYNjAbQTte2FKjELGxcnqRjgHUgIsTVdMtCkiVuz8J25yDN9P63KDAnBaTyMc9E4eQ2wj92JVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=grBG0Lj9; arc=none smtp.client-ip=195.10.208.46
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4gcxkk2k79zDsNV;
	Sat, 13 Jun 2026 15:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1781356654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwUQc5Mm3QSbVGMnXY9Z1okMH71TGy+fY+XanYcVZ9E=;
	b=grBG0Lj9NrpmxIk1kNYJdnuT/ZFdsHJoI6vA+TEmdzpAThKkqF/SRq/3gR2h+6Hqv/AN0z
	tDn2qJs8Lqagu42kKBqn1ZVh3+Y4w4nhU0r44brhRgymdnuWQvSGctKHRE2R/PYjVzk2bV
	gswQLNRPDmToS2omQ6wkq812mfFwugJNaAeTkf3+bXaFuF5nd8hJCGMZq07KbJcJXmpY5+
	+G2k+RsIa+b2x4T70JFtmM8oLjhH0VMSG8Lb0xfVxu/uw0eRX1X2nnmyHtXCZfUceJ94bW
	LXemFxxfmR7V3ct6X3MuQn3DouCnUM6LL+9NW7Ird/COpDEmTgtvJ/VuraGUJA==
From: Ralf Lici <ralf@mandelbit.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 08/15] ipxlat: add translation engine and dispatch core
Date: Sat, 13 Jun 2026 15:17:17 +0200
Message-ID: <20260613131720.253936-1-ralf@mandelbit.com>
In-Reply-To: <87y0gm8x5k.fsf@toke.dk>
References: <87y0gm8x5k.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298964-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mandelbit.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:toke@kernel.org,m:netdev@vger.kernel.org,m:dxld@darkboxed.org,m:antonio@mandelbit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF23767EAB3

On Wed, 10 Jun 2026 13:14:47 +0200, Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> Ralf Lici <ralf@mandelbit.com> writes:
>
> > Hi Toke,
> >
> > On Thu, 04 Jun 2026 20:23:51 +0200, Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> >> Ralf Lici <ralf@mandelbit.com> writes:
> >>
> >> > This commit introduces the core start_xmit processing flow: validate,
> >> > select action, translate, and forward. It centralizes action resolution
> >> > in the dispatch layer and keeps per-direction translation logic separate
> >> > from device glue. The result is a single data-path entry point with
> >> > explicit control over drop/forward/emit behavior.
> >> >
> >> > Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> >>
> >> This is very cool! Going quickly through the series, this seems like
> >> thorough work that will be cool to have available in the kernel, so
> >> thanks for doing this! I'll be quite happy to retire my barebones
> >> BPF-based implementation once this lands :)
> >>
> >
> > Thanks, glad to hear this looks useful. I have not had much time to work
> > on ipxlat lately, but I hope to respin the RFC soon.
> >
> >> One comment on the device model below (which is also why I chose this
> >> patch to reply to):
> >>
> >> > +static void ipxlat_forward_pkt(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
> >> > +{
> >> > +	const unsigned int len = skb->len;
> >> > +	int err;
> >> > +
> >> > +	/* reinject as a fresh packet with scrubbed metadata */
> >> > +	skb_set_queue_mapping(skb, 0);
> >> > +	skb_scrub_packet(skb, false);
> >> > +
> >> > +	err = gro_cells_receive(&ipxlat->gro_cells, skb);
> >>
> >> So given that you're not resetting skb->dev here, IIUC, this means that
> >> the translated packet will magically re-appear as if it arrived on the
> >> interface it first came in on, right?
> >>
> >> That seems... a bit too magical? Sending a packet to one device making
> >> it suddenly reappear on a different, unrelated, device seems like it
> >> will just create confusion. It's like the ipxlat device can't really
> >> device if it's a device or a tunnel? :)
> >>
> >
> > That's not quite what happens in the routed xmit path. There the stack
> > sets skb->dev to the selected output device before handing the skb to
> > the device. For IPv4 and IPv6 this happens in ip_output/ip6_output,
> > where the output device is taken from the skb dst. So when the route
> > selects the ipxlat device, the skb reaches ndo_start_xmit with skb->dev
> > already pointing at the ipxlat device, not at the original ingress
> > device.
> >
> > The internal 4-to-6 pre-fragmentation path should preserve the same
> > property as well: ip_do_fragment copies the skb metadata to the
> > generated fragments, including skb->dev, and the temporary dst used for
> > that path also points at the ipxlat device. The fragment callback then
> > feeds those fragments back into the same ipxlat processing path.
> >
> > That said, I agree that relying on this implicitly is not great.
> > gro_cells_receive uses skb->dev directly, and the intended receive-side
> > re-injection model should be obvious at the call site. I will set
> > skb->dev = ipxlat->dev explicitly before gro_cells_receive in the next
> > version.
>
> Right, sounds good. I'm also wondering if you actually need the gro_cells
> infrastructure at all? IIUC, the purpose of that is to allow tunnels to
> create GRO superframes of packets after they are decapsulated (and thus
> their l4 commonality becomes apparent). But you're not decapsulating
> anything, you're just translating between protocols the kernel already
> understands. So presumably any opportunity to coalesce GRO packets would
> already have happened pre-translation? So any reason why you can't just
> do what loopback.c does, and do a straight __netif_rx() call in the
> transmit function?
>

No, I think you're right that gro_cells is not justified here, I was
probably biased by my work on tunnel interfaces. Unlike a tunnel decap
path, ipxlat does not reveal a new same-family L4 flow after
decapsulation, so I don't see a translation-specific GRO opportunity
there, and a loopback-style receive handoff would be the simpler version
of that design.

That said, after thinking more about the rest of your feedback, I think
the right fix is probably not just replacing gro_cells with __netif_rx.
The deeper issue is the netdevice/RX-reinjection model itself.

> >> I think a better model is to treat the device as basically a loopback
> >> device that translates packets before looping them back (so when they
> >> come back they appear to be coming from that device).
> >>
> >> Any reason why that wouldn't work?
> >>
> >
> > That's indeed the intended model for the ipxlat netdevice: route packets
> > to it, translate them, then loop them back into the stack as packets
> > received from that same device. That seemed like the simplest model and
> > the one that exposes the translation point most clearly.
>
> Right. I think this could be made a bit more explicit in the
> documentation as well, since it's a bit of an unusual model.
>
> And, well, taking a step back: is it really the right model? Regular NAT
> lives in netfilter, why can't this be a netfilter module as well? Seems
> to me you could have something like:
>
> table ip xlat4 {
> 	chain postrouting {
> 		type nat hook postrouting priority srcnat; policy accept;
> 		ip daddr 0.0.0.0/0 oifname "eth0" xlat to 64:ff9b::/96
> 	}
> }
> table ip6 xlat6 {
> 	chain prerouting {
> 		type nat hook prerouting priority dstnat; policy accept;
> 		ip6 saddr 64::ff0b::/96 iifname "eth0" xlat from 64::ff9b::/96
> 	}
> }
>
> and that would provide the functionality without having to implement a
> new interface type and the associated multiple traversals through the
> stack? Did you consider this as an alternative to the new device type?
>

We did consider netfilter, and your example is syntactically attractive,
but I am no longer convinced it is the cleanest model for SIIT.

An nft expression cannot simply rewrite ETH_P_IP <-> ETH_P_IPV6 and
return ACCEPT as if this were normal NAT because the current hook
invocation, dst, and conntrack-related state were established for the
packet as it entered that hook. A cross-family translator would need to
consume the skb, clear or rebuild route and ct metadata as appropriate,
do an other-family route lookup, and resume at a well-defined point in
that family. That seems possible, but it would be a new stateless
cross-family action, not just a new mode of the existing nft nat
expression (which is built around nf_nat_setup_info and assumes the
packet's L3 family does not change AFAICT).

My second concern is that the SIIT boundary would be a property of rule
and hook placement. That gives flexibility, but it also means the
translation point has to be constrained and documented very carefully to
avoid ambiguous TTL/Hop Limit, PMTU/ICMP, and hook-order behavior. For
this use case I would rather have the route that matches the translation
prefix also be the object that says: leave this family here and continue
in the other one.

After looking at the available kernel mechanisms again, I think the
better model is probably LWT: routes carry an ipxlat encap referencing a
named translator domain configured over netlink. That should represent
the stateless, prefix-based and symmetric nature of ipxlat.

Very roughly, userspace could look like:

    ip xlat add siit0 prefix6 64:ff9b::/96
    ip route add ... encap ipxlat id siit0
    ip -6 route add ... encap ipxlat id siit0

There are some useful precedents for this: ILA is stateless address
translation as LWT, seg6_local already has cross-family LWT actions, and
ioam6 has a similar split between separately configured objects and
route attachments.

The invariant I would like v2 to follow is that the original-family
route lookup selects translation as its terminal route action. The
translated skb then gets a fresh lookup in the other family. From that
point on, TTL/Hop Limit where applicable, PMTU, ICMP errors, and
netfilter visibility belong to the translated family.

So I think your question addresses the core design issue in this RFC. My
current preference is to rework the next version around an LWT/domain
model instead of the virtual netdevice model, unless prototyping shows a
fundamental problem with that approach.

Does that model make sense to you?

Thanks for pushing on this.

-- 
Ralf Lici
Mandelbit Srl

