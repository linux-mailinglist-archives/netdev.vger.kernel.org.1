Return-Path: <netdev+bounces-240853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCA9C7B5B4
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 19:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04493A463E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEDD2E92B0;
	Fri, 21 Nov 2025 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="akYE9vnT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20FC2F1FF4
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763750433; cv=none; b=obL35I1zvD7wm3HAgbjpfwAPxnxXeV98eQI2l+HdiNhBKzcnsFa3hhEOWDWkIDO0qcmlJt22xPi0uFegu7CdtfFtIpBbVz0bMlzfeaAHVOvPxzSusHrHkc0761F87cQkGUf/FEghI9q0i2fFWwZWCforCK8P06clqSR0wFz4gfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763750433; c=relaxed/simple;
	bh=OWPvmfjNSoouYgfC8nrnAoGSa5RyygLIEpw44TqMlDw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHxMtG/eBrlrlrDfo6db5RXJN1iisdTdOhS5EOJeMbJAStvN8gscxlG/qvv1uqs8xG72DhOa0sL4UFrBVQHequ/JN71GsEZlKFRLl8Vzq1vHuvMKRNAXwhwW9fmJUJTl9EdHpMmCJ2shHkJgBImGeaJbSDxyObUvgOkQ6FnxstI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=akYE9vnT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso14931025e9.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 10:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1763750428; x=1764355228; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lAqqA25GNVvwzcOocSfr1yKLWMK28hFLjIoWbX+oy5g=;
        b=akYE9vnTepecz7u5ZtwnNHxVFWEgqwQjm5FVw2MYkTw8BqQnDHKy9e4/ve5mS6an1t
         wqGeRK/l5mF9F96rDhVNDjXqv5+87MOCOfa9xzzpAi3DRGka9NWhRNKIKMbBgKvyO8Zq
         mCm/T34iNvh5oSnDPDNx4xNOqWnfQcROsFURoyZGd6yIELW23XZiVhGIJoaCsJCJ3+eq
         mlkVdkIcrO9M1QPykSs8ryn7SP+FIvP0eAAKm5Eypn8yfqYTjvG9iU/a1bROoPt74DUi
         kAGbMeOk2WCXTtPExyd/HJUpYssMn/sb8QQ9TjbVBFn+N7kDGNvIb2gIOGej9PVDf5np
         +qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763750428; x=1764355228;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAqqA25GNVvwzcOocSfr1yKLWMK28hFLjIoWbX+oy5g=;
        b=FoIJM1DA3b18MrakyYiahPystToJHNa78hdMp28ewkRsHI3EL2GrK0kPa/c0LcQzYy
         gjVqhlMtprmicE9FCgxywHK6s/WAjtLxTGXwIAsJsclvTmcZ2NleXiI46bZz62lAktyK
         UACxoQ7wI1DBoJK6fB/DqZkWlHj0C7v6tEmdBaitQN1UT2JIxdrJYi+velPwbJfWSfAN
         xBn/Qmo20zcpaueCH/uypY8SyePhTki5i/CTJLwvhvJplCb4d7HFZJRRVcmsKGfxp+3u
         VlAWsuw+uN+Sxida7nT+Mb/TnaS/lE0fch7qs2ff5D3ZXkxw0RaEJZ2nQfPioakmSNGa
         HwJA==
X-Gm-Message-State: AOJu0YzrWS0ODZxFJ4bYoKTnYy3HO8j9uU0jVNbSkVkAPD5eCSPxthBI
	IWCh4VjLzEhZWzKGBx5BQ3+QYyzvUqXc1SO1QoPBQrjiNIRmJ1aqEb/Up2hcxQFOOUg=
X-Gm-Gg: ASbGncsvDu8KuugHqnKWsLxldORgY6CkuFiQz5X8f76hbQuoYCKXtB/JobMPqWp5lg5
	u7VNwg8HPzYkgMeqNqmzjY9ZJfeQOBbSEFafmFyjid6CyeKrlhNVXT2urjT2CUcOC8ejCY2PmNv
	LiT0sopbqGOTr+pkjjKvzkQMn2OiiFYSDafTBql7Mtko6FzhRLi33Rhkq8Nt8eL9YxO2RY8lteR
	R7N5rLq9jOY8Z4jld40mHdQLOcndn1Ag/Ucdn+JUJdN5POhfV+KFXixLC6X9OgIur4S3xztRKVi
	GRyRoutSbpKDt7l72e0w/zgTJrX9nI/+Co07h0dR6qWT39aSr2iyiji0xSdYtL1txmOj0H9MJ5W
	dDBwM58FApcxLyHiAbbUNxnyzMTdyd+rAHfc8WNG0dzRjS2qCGctnsrPhoymmucdohR3UfDZdfO
	nA0hEPUzpBygJET9w1rDj/vQeNsse9uQ+6X0+a0jWZKENj5tl8tYRVNOa/1Q==
X-Google-Smtp-Source: AGHT+IHfh26jWetth2C0z/mhAEunrO50cEbL1CMDyZ3piUmSayg04ilNMG2qbN6eWUhNUprD9du1XA==
X-Received: by 2002:a05:600c:4685:b0:477:7768:8da4 with SMTP id 5b1f17b1804b1-477c10c84eamr33821575e9.7.1763750427330;
        Fri, 21 Nov 2025 10:40:27 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f3635bsm12549789f8f.17.2025.11.21.10.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 10:40:27 -0800 (PST)
Message-ID: <3900940954b09afab46f7cedaf3c19adfbcbc211.camel@mandelbit.com>
Subject: Re: [RFC net-next] ovpn: allocate smaller skb when TCP headroom
 exceeds u16
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Antonio Quartulli <antonio@openvpn.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni	 <pabeni@redhat.com>
Date: Fri, 21 Nov 2025 19:40:26 +0100
In-Reply-To: <aRycMp7hlhY3ZC5U@krikkit>
References: <20251113122143.357579-1-ralf@mandelbit.com>
	 <aRycMp7hlhY3ZC5U@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-18 at 17:17 +0100, Sabrina Dubroca wrote:
> 2025-11-13, 13:21:43 +0100, Ralf Lici wrote:
> > Hi all,
> >=20
> > While testing openvpn over TCP under high traffic conditions,
> > specifically on the same machine using net namespaces (with veth
> > pairs
> > interconnecting them), we consistently hit a warning in
> > skb_reset_network_header. The culprit is an attempt to store an
> > offset
> > (skb->data - skb->head) larger than U16_MAX in skb->network_header,
> > which is a u16. This leads to packet drops.
> >=20
> > In ovpn_tcp_recv, we're handed an skb from __strp_rcv and need to
> > linearize it and pull up to the beginning of the openvpn packet. If
> > it's
>=20
> We don't currently linearize (=3D move all the data into ->head), right?

Actually, my understanding is that we effectively do, though it happens
implicitly in the crypto layer rather than in the RX callback.

While ovpn_tcp_rcv pulls up to the beginning of the openvpn packet in
the skb, the subsequent call to ovpn_aead_decrypt invokes skb_cow_data
to ensure the *whole* skb is writable for decryption. Since strparser
hands us cloned skbs, skb_cow_data calls __pskb_pull_tail(skb,
__skb_pagelen(skb)). As I understand it, this forces a full
linearization for every single packet in the huge skb.

>=20
> > a data-channel packet, we then pull an additional 24 bytes of
> > openvpn
> > encapsulation header so that skb->data points to the inner IP
> > packet.
> > This is necessary for authentication, decryption, and reinjection
> > into
> > the networking stack of the decapsulated packet, but when the skb is
> > too
> > large, the network header offset overflows the field.
> >=20
> > AFAWCT, these oversized skbs can result from:
> > - GRO,
> > - TCP skb coalescing (tcp_try_coalesce, skb_try_coalesce),
> > - streamparser (__strp_rcv appends more skbs when an openvpn packet
> > =C2=A0 spans multiple skbs).
> >=20
> > Note that this issue is likely affecting espintcp as well, since its
> > logic similarly involves extracting discrete packets from a
> > coalesced
> > TCP stream handed off by streamparser, and reinjecting them into the
> > stack.
>=20
> Most likely yes. I'll see if I can reproduce the problem on espintcp.

Thanks!

>=20
> > We've brainstormed a few possible directions, though we haven't yet
> > assessed their feasibility:
> > - introduce a u32 field in struct tcp_sock to limit skb->len during
> > TCP
> > =C2=A0 coalescing (each socket user can set the limit if needed);
>=20
> I doubt the TCP maintainers would accept a patch to TCP for a problem
> that affects only (some of) the users of strp.

Perfectly understandable. I will drop this idea.

>=20
> > - modify strp to build an skb containing only the relevant frags for
> > the
> > =C2=A0 current openvpn packet in frag_list.
>=20
> This would penalize the other users of strp. It may make sense to
> introduce such a mechanism in strp, but only on request (eg via a bool
> in strp_init, a flag in the cb struct).

I agree that we should keep strparser generic. Since this issue is
specific to how ovpn/espintcp handle the resulting skbs (decapsulation
and header resetting), it is probably better to handle the output within
the users rather than complicating the strparser API.

>=20
> > In this patch, we implement a solution entirely contained within
> > ovpn:
> > we allocate a new skb and copy the content of the current openvpn
> > packet
> > into it. This avoids the large headroom issue, but it=E2=80=99s not ide=
al
> > because the kernel keeps coalescing skbs while we effectively undo
> > that
> > work, which isn=E2=80=99t very efficient.
>=20
> Well, that coalescing is useful, and the un-coalescing is necessary
> (because even without this offset problem, we have to get back the
> individual packets from the stream).
>=20
>=20
> Copying the full contents (full_len) of the openvpn packet seems a bit
> heavy when what we want is "pull and get rid of that extra space at
> the head". It seems pskb_extract would do the job without manual
> handling in ovpn and without copying the entire payload? (but it will
> clone the skb and realloc the head every time, so we'd only want to
> call it in the "offset too big" case)

Thanks, I was not aware of this function and I believe it would indeed
solve the overflow issue. However, I'm not sure it would be more
efficient. Since the problem arises from huge offsets on non-linear
skbs, AFAICT it's almost certain that we'd take the
pskb_carve_inside_nonlinear path in pskb_carve. That function will
produce a fully non-linear cloned skb by removing the pages that are not
needed. But, following the skb_cow_data explanation above, we would end
up linearizing the content of this skb in the end anyway. So I fear
pskb_extract might not be beneficial in this scenario.

>=20
> > We're sending this RFC to gather ideas and suggestions on how best
> > to
> > address this issue. Any thoughts or guidance would be appreciated.
>=20
> One thing I'm a bit concerned about is if those reduced skbs need to
> be re-sent somewhere else. Then we don't have any headroom to push a
> new header and we'll have to realloc again to create some space. OTOH
> it doesn't really make sense to carry 65kB of extra data through the
> stack.

That's a valid concern and I have the feeling that there must be a
"standard" way of creating an skb with some content and a reasonable
headroom. I thought netdev_alloc_skb could be a good choice because it
builds an skb with NET_SKB_PAD headeroom, but I'm not sure if that's the
proper size.=20

>=20
>=20
> A few comments on the implementation:
>=20
> [...]
> > diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> > index b7348da9b040..301fcb1c0495 100644
> > --- a/drivers/net/ovpn/tcp.c
> > +++ b/drivers/net/ovpn/tcp.c
> > @@ -70,39 +70,87 @@ static void ovpn_tcp_to_userspace(struct
> > ovpn_peer *peer, struct sock *sk,
> > =C2=A0	peer->tcp.sk_cb.sk_data_ready(sk);
> > =C2=A0}
> > =C2=A0
> > -static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff
> > *skb)
> > +/* takes ownership of orig_skb */
> > +static struct sk_buff *ovpn_tcp_skb_packet(const struct ovpn_peer
> > *peer,
> > +					=C2=A0=C2=A0 struct sk_buff
> > *orig_skb,
> > +					=C2=A0=C2=A0 const int full_len,
> > const int offset)
> > =C2=A0{
> > -	struct ovpn_peer *peer =3D container_of(strp, struct
> > ovpn_peer, tcp.strp);
> > -	struct strp_msg *msg =3D strp_msg(skb);
> > -	size_t pkt_len =3D msg->full_len - 2;
> > -	size_t off =3D msg->offset + 2;
> > -	u8 opcode;
> > +	struct sk_buff *ovpn_skb =3D orig_skb;
> > +	const int pkt_len =3D full_len - 2;
> > +	int pkt_offset =3D offset + 2;
> > +	int err;
> > +
> > +	/* If the final headroom will overflow a u16 we will not be
> > able to
> > +	 * reset the network header to it so we need to create a
> > new smaller
> > +	 * skb with the content of this packet.
> > +	 */
> > +	if (unlikely(skb_headroom(orig_skb) + pkt_offset +
> > OVPN_HEADER_SIZE >
> > +		=C2=A0=C2=A0=C2=A0=C2=A0 U16_MAX)) {
> > +		ovpn_skb =3D netdev_alloc_skb(peer->ovpn->dev,
> > full_len);
>=20
> From my reading of __strp_recv, strp already gave us a fresh clone, do
> we need to reallocate a full skb?

As explained above, the reason is the call to skb_cow_data in
ovpn_aead_decrypt, which, in the end, would linearize the whole cloned
skb.

>=20
> > +		if (!ovpn_skb) {
> > +			ovpn_skb =3D orig_skb;
> > +			goto err;
> > +		}
> > +
> > +		skb_copy_header(ovpn_skb, orig_skb);
> > +		pkt_offset =3D 2;
> > +
> > +		/* copy the entire openvpn packet + 2 bytes length
> > */
> > +		err =3D skb_copy_bits(orig_skb, offset,
> > +				=C2=A0=C2=A0=C2=A0 skb_put(ovpn_skb, full_len),
> > full_len);
> > +		kfree(orig_skb);
> > +		if (err) {
> > +			net_warn_ratelimited("%s: skb_copy_bits
> > failed for peer %u\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 netdev_name(peer-
> > >ovpn->dev),
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 peer->id);
> > +			goto err;
> > +		}
> > +	}
> > =C2=A0
> > =C2=A0	/* ensure skb->data points to the beginning of the openvpn
> > packet */
> > -	if (!pskb_pull(skb, off)) {
> > +	if (!pskb_pull(ovpn_skb, pkt_offset)) {
> > =C2=A0		net_warn_ratelimited("%s: packet too small for peer
> > %u\n",
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 netdev_name(peer->ovpn->dev),
> > peer->id);
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 netdev_name(peer->ovpn->dev),
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 peer->id);
> > =C2=A0		goto err;
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	/* strparser does not trim the skb for us, therefore we do
> > it now */
> > -	if (pskb_trim(skb, pkt_len) !=3D 0) {
> > +	if (pskb_trim(ovpn_skb, pkt_len) !=3D 0) {
> > =C2=A0		net_warn_ratelimited("%s: trimming skb failed for
> > peer %u\n",
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 netdev_name(peer->ovpn->dev),
> > peer->id);
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 netdev_name(peer->ovpn->dev),
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 peer->id);
> > =C2=A0		goto err;
> > =C2=A0	}
> > =C2=A0
> > +	return ovpn_skb;
> > +err:
> > +	kfree(ovpn_skb);
>=20
> This needs to be kfree_skb/consume_skb in all cases where you're
> freeing an skb.

Yep, sorry. Something got lost during the refactoring.

>=20
> > +	return NULL;
> > +}

Thanks a lot for your input.

--=20
Ralf Lici
Mandelbit Srl

