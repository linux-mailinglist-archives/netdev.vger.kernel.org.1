Return-Path: <netdev+bounces-151891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2ED9F1786
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093C3188C56F
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73817192B90;
	Fri, 13 Dec 2024 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7r3JnMS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D3D192D83
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122704; cv=none; b=IDmAXM98u2t8EvGqncVXi6Xs/Xf3M9LgkH5g+O/+xkj6ijBNHEIMCcFhni0fRfSgl93y9PAQ2CDKOwpuWyPTxtVTfJxekc4q+s8z5YcHhuxszMC7pN1TeRmQf6gvdcFQoueX5/F56THTncn58EEFnipGuc8gfphDvCWNMwUvMw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122704; c=relaxed/simple;
	bh=kd3JnKNd3M7UCENvNoHh9/+kSdmtOG0LDUGSvtxp5Vc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sTttCETAWXLLm9ImgMHR7t1vyNhppisLB9SnF2XpbduoKS7aCrYUGH7XksYKTd/JdlOaZl90Va0EmEa1c10S8l4dd9urFpO96A5nhftPcVIFRE9ADGs1FqCqxK4UhK69k0QBpitABGbX8mU51UJ8Ljf36go4Pk6eGM1e0HRvYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7r3JnMS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734122701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTF1gVQdFWBwy6Q3LPxWOLONRVmdA/eRNrvwR4+gyAY=;
	b=R7r3JnMSDdEuypVELRJh1Hqm6h1dVfRb+dw/S03oaaaHZPYH+q0nHHwiNZwGwklOdidvRo
	t3XRz4v0wkPu6DmEnCjtVq8Y2La8OmMH6fSsGNw6qTmnWZ/AUWY6aSrJAl92NJJOye4uYZ
	R6Iz09r23jkjJXHKzufa/sc62SLrCXc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-pUcshJIwMgKwIrNgPqjwVA-1; Fri, 13 Dec 2024 15:44:52 -0500
X-MC-Unique: pUcshJIwMgKwIrNgPqjwVA-1
X-Mimecast-MFC-AGG-ID: pUcshJIwMgKwIrNgPqjwVA
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6f1595869so180892085a.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734122691; x=1734727491;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTF1gVQdFWBwy6Q3LPxWOLONRVmdA/eRNrvwR4+gyAY=;
        b=A5MYoeKxFkljN/jZdfzmIdioce4nKotXGvvPI4gEZKs+u+8B1wzvydPrdNMc7DuLDX
         yleGTVe0pGKfv2HwCgCpxv0WHWVt7yKyx94RaBqYnx5UhG/CFYw/40SXVw14RwM7cnUk
         P1C/8FKD2C9I+biHx41F+fkRui//0Qto5R9VdNFwbfAx+CUcb/PmkHwkzm5zGewSwHfM
         Q2iJndx1DCKHtA8C3roeoVeDCE/zsexaKkchRvylExCMWSJoqTXc4bHNiO2gGha5f1NV
         CmzN2+HShOXHV/zKG9y0InUe9OMyAA5W3rp+LPvwz3kB04H8InFjt6otqL/DkBShK5nb
         JHgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXES8coIezVyQ++zvpRtRuWCyhdjugFJRnLpu3nqEU0vJ2UxOF6qQgidkDUZqnim2gzBD65ZZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEqkGAtv+FSevKejphUqXJWspVhl9DtIDh+pxmYwhtE6d/uyT
	RssSb1tDeF0PdmTJ4BMrcsAPD7exlQGPgMlUl5zVnTdF6ehSnOl6yemfgeTV/vQqByuq1qhVo2e
	b4EzuU0QhpobnXkroe+PqTGEMUT9Ghdm6HRsoTTAih8449rv31TjTXUseClDLww==
X-Gm-Gg: ASbGncvY3AtrfkIYeTde5Tg8XXMz8sfJoamWi+T5h/co8Q170ias4+ajGQY4hFZN6Nv
	QtiVFYJhVjEpA+ouZAyMUdBancKli98uR3c7XURPvFS5cKk3ovMcy+P4HSmkRbRPFhrTJ/Fcwr6
	pzjZ3kPuxlys2V/4e9HfE+T19DeOcgUl01Ec7UVWGfeKsjIVPe3SiT3j3Nzq4HAi9Ff6IWsLU36
	HIOcLjqP6WPcROHCkSkXDLXxhmERTS9Deh258GCogIf6ZvvEpW6wRrgfgczliQqEJ0lNkJ5t3V5
	sKITlHfR5tbm3M+KVQZGKYAoAGPkiX3NdH1vOKCsCJJ1SJEh
X-Received: by 2002:a05:620a:4882:b0:7b6:d5b2:e6d with SMTP id af79cd13be357-7b6fbf17b58mr595602885a.35.1734122691513;
        Fri, 13 Dec 2024 12:44:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0uolEOXymN5WV0ZUnXHMN+TRmyOizKeSVecI47gbXLuJww4t78opCPP3mIhmQWs+Ptl3PyQ==
X-Received: by 2002:a05:620a:4882:b0:7b6:d5b2:e6d with SMTP id af79cd13be357-7b6fbf17b58mr595599385a.35.1734122691162;
        Fri, 13 Dec 2024 12:44:51 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e81810sm1337551cf.55.2024.12.13.12.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 12:44:50 -0800 (PST)
Message-ID: <84e3d3e998f1a02dd742727c2e18b7c364c36389.camel@redhat.com>
Subject: Re: [PATCH net-next] net/bridge: Add skb drop reasons to the most
 common drop points
From: Radu Rendec <rrendec@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu
 <roopa@nvidia.com>,  bridge@lists.linux.dev, netdev@vger.kernel.org, Simon
 Horman <horms@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,  "David S. Miller"
 <davem@davemloft.net>
Date: Fri, 13 Dec 2024 15:44:49 -0500
In-Reply-To: <Z1sLyqZQCjbcCOde@shredder>
References: <20241208221805.1543107-1-rrendec@redhat.com>
	 <Z1sLyqZQCjbcCOde@shredder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-12 at 18:14 +0200, Ido Schimmel wrote:
> On Sun, Dec 08, 2024 at 05:18:05PM -0500, Radu Rendec wrote:
> > The bridge input code may drop frames for various reasons and at variou=
s
> > points in the ingress handling logic. Currently kfree_skb() is used
> > everywhere, and therefore no drop reason is specified. Add drop reasons
> > to the most common drop points.
> >=20
> > The purpose of this patch is to address the most common drop points on
> > the bridge ingress path. It does not exhaustively add drop reasons to
> > the entire bridge code. The intention here is to incrementally add drop
> > reasons to the rest of the bridge code in follow up patches.
> >=20
> > Most of the skb drop points that are addressed in this patch can be
> > easily tested by sending crafted packets. The diagram below shows a
> > simple test configuration, and some examples using `packit`(*) are
> > also included. The bridge is set up with STP disabled.
> > (*) https://github.com/resurrecting-open-source-projects/packit
> >=20
> > The following changes were *not* tested:
> > * SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT in br_multicast_flood(). I coul=
d
> > =C2=A0 not find an easy way to make a crafted packet get there.
> > * SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD in br_handle_frame_finish()
> > =C2=A0 when the port state is BR_STATE_DISABLED, because in that case t=
he
> > =C2=A0 frame is already dropped in the switch/case block at the end of
> > =C2=A0 br_handle_frame().
> >=20
> > =C2=A0=C2=A0=C2=A0 +---+---+
> > =C2=A0=C2=A0=C2=A0 |=C2=A0 br0=C2=A0 |
> > =C2=A0=C2=A0=C2=A0 +---+---+
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0=C2=A0=C2=A0 +---+---+=C2=A0 veth pair=C2=A0 +-------+
> > =C2=A0=C2=A0=C2=A0 | veth0 +-------------+ xeth0 |
> > =C2=A0=C2=A0=C2=A0 +-------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------+
> >=20
> > SKB_DROP_REASON_MAC_INVALID_SOURCE - br_handle_frame()
> > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > =C2=A0 -e 01:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
> > =C2=A0 -p '0x de ad be ef' -i xeth0
> >=20
> > SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL - br_handle_frame()
> > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > =C2=A0 -e 02:22:33:44:55:66 -E 01:80:c2:00:00:01 -c 1 \
> > =C2=A0 -p '0x de ad be ef' -i xeth0
> >=20
> > SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD - br_handle_frame()
> > bridge link set dev veth0 state 0 # disabled
> > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > =C2=A0 -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
> > =C2=A0 -p '0x de ad be ef' -i xeth0
> >=20
> > SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD - br_handle_frame_finish()
> > bridge link set dev veth0 state 2 # learning
> > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > =C2=A0 -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
> > =C2=A0 -p '0x de ad be ef' -i xeth0
> >=20
> > SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT - br_flood()
> > packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
> > =C2=A0 -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
> > =C2=A0 -p '0x de ad be ef' -i xeth0
> >=20
> > Signed-off-by: Radu Rendec <rrendec@redhat.com>
> > ---
> > =C2=A0include/net/dropreason-core.h | 18 ++++++++++++++++++
> > =C2=A0net/bridge/br_forward.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 ++--
> > =C2=A0net/bridge/br_input.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 24 +++++++++++++++---------
> > =C2=A03 files changed, 35 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
> > index c29282fabae6..1f2ae5b387c1 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -108,6 +108,9 @@
> > =C2=A0	FN(TUNNEL_TXINFO)		\
> > =C2=A0	FN(LOCAL_MAC)			\
> > =C2=A0	FN(ARP_PVLAN_DISABLE)		\
> > +	FN(MAC_IEEE_MAC_CONTROL)	\
> > +	FN(BRIDGE_INGRESS_PORT_NFWD)	\
> > +	FN(BRIDGE_NO_EGRESS_PORT)	\
> > =C2=A0	FNe(MAX)
> > =C2=A0
> > =C2=A0/**
> > @@ -502,6 +505,21 @@ enum skb_drop_reason {
> > =C2=A0	 * enabled.
> > =C2=A0	 */
> > =C2=A0	SKB_DROP_REASON_ARP_PVLAN_DISABLE,
> > +	/**
> > +	 * @SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL: the destination MAC address
> > +	 * is an IEEE MAC Control address.
> > +	 */
>=20
> IMO, dropping pause frames is not among "the most common drop points".
> Are you planning on reusing this reason in other modules? If not, then I
> prefer removing it. My understanding is that we should not try to
> document every obscure drop with these reasons.

Fair enough. I don't have an immediate plan to reuse this reason, and
to be honest, I'm not that familiar with the networking stack to be
able to tell off hand if it's likely to be useful elsewhere.

Would you prefer to stick to not specifying a drop reason at all at
that particular drop point, or to reuse an existing reason? Two
existing reasons that could be used (although they are not entirely
accurate) are:
SKB_DROP_REASON_UNHANDLED_PROTO
SKB_DROP_REASON_MAC_INVALID_SOURCE

> > +	SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL,
> > +	/**
> > +	 * @SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD: the STP state of the
> > +	 * ingress bridge port does not allow frames to be forwarded.
> > +	 */
> > +	SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD,
>=20
> Are you intending on reusing this for other ingress drops (e.g., VLAN,
> locked port) or is this specific to ingress STP filtering? I think it
> will be useful to distinguish between the different cases, so I suggest
> renaming this reason to make it clear it is about ingress STP.

No, it's specific to ingress STP filtering. I will rename it to
SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE as I said in the other thread.

> > +	/**
> > +	 * SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT: no eligible egress port was
> > +	 * found while attempting to flood the frame.
> > +	 */
> > +	SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT,
> > =C2=A0	/**
> > =C2=A0	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
> > =C2=A0	 * shouldn't be used as a real 'reason' - only for tracing code =
gen
> > diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> > index e19b583ff2c6..e33e2f4fc3d9 100644
> > --- a/net/bridge/br_forward.c
> > +++ b/net/bridge/br_forward.c
> > @@ -249,7 +249,7 @@ void br_flood(struct net_bridge *br, struct sk_buff=
 *skb,
> > =C2=A0
> > =C2=A0out:
> > =C2=A0	if (!local_rcv)
> > -		kfree_skb(skb);
> > +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);
> > =C2=A0}
> > =C2=A0
> > =C2=A0#ifdef CONFIG_BRIDGE_IGMP_SNOOPING
> > @@ -349,6 +349,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry=
 *mdst,
> > =C2=A0
> > =C2=A0out:
> > =C2=A0	if (!local_rcv)
> > -		kfree_skb(skb);
> > +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);
> > =C2=A0}
> > =C2=A0#endif
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index ceaa5a89b947..fc00e172e1e1 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -96,8 +96,10 @@ int br_handle_frame_finish(struct net *net, struct s=
ock *sk, struct sk_buff *skb
> > =C2=A0	if (br_mst_is_enabled(br)) {
> > =C2=A0		state =3D BR_STATE_FORWARDING;
> > =C2=A0	} else {
> > -		if (p->state =3D=3D BR_STATE_DISABLED)
> > -			goto drop;
> > +		if (p->state =3D=3D BR_STATE_DISABLED) {
> > +			kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> > +			return 0;
> > +		}
> > =C2=A0
> > =C2=A0		state =3D p->state;
> > =C2=A0	}
> > @@ -155,8 +157,10 @@ int br_handle_frame_finish(struct net *net, struct=
 sock *sk, struct sk_buff *skb
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > -	if (state =3D=3D BR_STATE_LEARNING)
> > -		goto drop;
> > +	if (state =3D=3D BR_STATE_LEARNING) {
> > +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> > +		return 0;
> > +	}
> > =C2=A0
> > =C2=A0	BR_INPUT_SKB_CB(skb)->brdev =3D br->dev;
> > =C2=A0	BR_INPUT_SKB_CB(skb)->src_port_isolated =3D !!(p->flags & BR_ISO=
LATED);
> > @@ -331,8 +335,10 @@ static rx_handler_result_t br_handle_frame(struct =
sk_buff **pskb)
> > =C2=A0	if (unlikely(skb->pkt_type =3D=3D PACKET_LOOPBACK))
> > =C2=A0		return RX_HANDLER_PASS;
> > =C2=A0
> > -	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
> > -		goto drop;
> > +	if (!is_valid_ether_addr(eth_hdr(skb)->h_source)) {
> > +		kfree_skb_reason(skb, SKB_DROP_REASON_MAC_INVALID_SOURCE);
> > +		return RX_HANDLER_CONSUMED;
> > +	}
> > =C2=A0
> > =C2=A0	skb =3D skb_share_check(skb, GFP_ATOMIC);
> > =C2=A0	if (!skb)
> > @@ -374,7 +380,8 @@ static rx_handler_result_t br_handle_frame(struct s=
k_buff **pskb)
> > =C2=A0			return RX_HANDLER_PASS;
> > =C2=A0
> > =C2=A0		case 0x01:	/* IEEE MAC (Pause) */
> > -			goto drop;
> > +			kfree_skb_reason(skb, SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL);
> > +			return RX_HANDLER_CONSUMED;
> > =C2=A0
> > =C2=A0		case 0x0E:	/* 802.1AB LLDP */
> > =C2=A0			fwd_mask |=3D p->br->group_fwd_mask;
> > @@ -423,8 +430,7 @@ static rx_handler_result_t br_handle_frame(struct s=
k_buff **pskb)
> > =C2=A0
> > =C2=A0		return nf_hook_bridge_pre(skb, pskb);
> > =C2=A0	default:
> > -drop:
> > -		kfree_skb(skb);
> > +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> > =C2=A0	}
> > =C2=A0	return RX_HANDLER_CONSUMED;
> > =C2=A0}
> > --=20
> > 2.47.1
>=20

Thanks for reviewing!

--=20
Best regards,
Radu


