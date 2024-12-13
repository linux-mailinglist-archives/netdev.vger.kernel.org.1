Return-Path: <netdev+bounces-151888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132FC9F1768
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538671887A87
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC79191473;
	Fri, 13 Dec 2024 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEtJfdnR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B1286A1
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122031; cv=none; b=N61Dlh4RAztpDNw/18NN3REExBInRhw4PXdoDnnIGx4mUMhjPRNzVlAPZzF9ZP71z8tORPop3u854DhsH8JEy6RH4UJXjUtcRaHMBQCtdweAfB6ErIv3xscMzJIj6tOLh4X/D9FPxP7clzcRt551ZjT5KQKwYDMUZeyqzSOgoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122031; c=relaxed/simple;
	bh=Vq/DGMKdQkVEERjQHLyYqaISbj4csEZ3RZnmM7peMnA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bkxmPjksug5CP/tA356m2ozmzC+rhiyE1nf/7aja7a0E+u7DhCnDD9WDPiLIV1Su8LYJbL1b6q8AmEdyppUcY5ZTUWpVNen+sYSbu8LM787e+NxafzresdXz626HTjSXeMzL7HSsnpqzoKZxXieLWVDouDzLsI52I8RaZPUvZ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEtJfdnR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734122028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aba5BsXsQ7FqAiNGIDyNoYncM/5KyydK70Yz1i+dzmA=;
	b=BEtJfdnR0p9DVU2bZSKo8/dKYhe03UxeroY0F8rMsrOn6tQ245tkqnxUrg9vQVZcQFHmgC
	Dpnk4rrAYoa3vt1BVZeQmPguYhonBMgZkyRhfvjcf78ByGlwiP/gvhu+WKr5aBiX9k6DRB
	A1jwmX7CfVyf2sHIwjV4wF2Kn82TPWw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-03Hex9lBN5-g7dVcsJ7UZA-1; Fri, 13 Dec 2024 15:33:47 -0500
X-MC-Unique: 03Hex9lBN5-g7dVcsJ7UZA-1
X-Mimecast-MFC-AGG-ID: 03Hex9lBN5-g7dVcsJ7UZA
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8f94518c9so47201406d6.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734122027; x=1734726827;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aba5BsXsQ7FqAiNGIDyNoYncM/5KyydK70Yz1i+dzmA=;
        b=NM4DIKgECltdTHBSAYXkd72qMpEMSqSx1ScuoO6Dex4QMfGKQlBEquO6FjXIARYjBB
         c74TeuKZbOERstlShafKGy6HuDxKMiyk5VihKlgmT0P77/HwMSJ7HfKh7DRSKiQSkeRa
         Sx1zY9tajZ1k3nB/wdTlNSxf5AgA8lcbeUL7DX7zEOFLQPSNHo2vZhxzsdMQxv+rENTU
         fPZdrILajtrqL3SeIjNDepkoEjMJ0QEFCQyNge7dkGYahTjdBgXS/nX8XZkq1du7SdWj
         iHmFwz8hXwO3v/hxVd18Zrn10EJeO1aXBjYURyFo4GFf55XNbg5Fc5HKIjGSnWdcC4Pg
         jq6w==
X-Forwarded-Encrypted: i=1; AJvYcCV9LvNZntRFUwAZi3iF7Kwy+VLk837PbAtpy4UpID2KKegz+8f2sDqdULAQye8arHiJ6EKlPl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbSEpulF079wtjIJSwTScqIjnetB9eVV7heTgQ++zR/YsoZAre
	YnH7VQVTCPnjekQjQfvwOlQ5VTbuntfmt9pHeu2QeyeKSlJq304gMbtH+fby50gl3NIPF5wMaX3
	54vHWressIeGl/4EyUCcCGA1K+INGM/pVBZnH8JgM4nQXQXnsDBcxNQ==
X-Gm-Gg: ASbGnctxlqSw4m9D1Hh04MiZ5ZxbSpVuTaFfk7u6V9NnXOXpU9lQEyRWe+6MyHmY0Si
	h3wnpcHTQC+wR6ajyp5498PZKEZhWuYh0EG/O7w+OetG7ym+BMYmJsxd0VNHudK2J6W2q6vqSZ4
	NuDcDF86OIPYo58O7yGwJnOh3R9j/rFldtIri9441XeqR6y9DIu8v7tHT1SosLGgle8Xf7YXxZY
	nebQ5wItRwkdelLLBaCovkoj10X8ZZ6Q4Ow39BeDntP36MnX/li11wq5jp5fpuQ7LWVxGJYmd8/
	OgdEEdEZgFI1pTDffSahMK2yavur1zs0rfiCpt6PpPFLZQo3
X-Received: by 2002:a05:6214:2388:b0:6d8:8f14:2f5d with SMTP id 6a1803df08f44-6dc8ca84f7fmr77246066d6.28.1734122026834;
        Fri, 13 Dec 2024 12:33:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI59cbLihxqo6dRtJ9/I263Qa7r2Dauau6XnHrvUGdnT2sw703rf6gpaHmUVH/f2YnaGfNEQ==
X-Received: by 2002:a05:6214:2388:b0:6d8:8f14:2f5d with SMTP id 6a1803df08f44-6dc8ca84f7fmr77245636d6.28.1734122026416;
        Fri, 13 Dec 2024 12:33:46 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd363142sm845396d6.81.2024.12.13.12.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 12:33:45 -0800 (PST)
Message-ID: <c8ab80bb8e3735d301104f29d7f04275ad054214.camel@redhat.com>
Subject: Re: [PATCH net-next] net/bridge: Add skb drop reasons to the most
 common drop points
From: Radu Rendec <rrendec@redhat.com>
To: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu
 <roopa@nvidia.com>,  Ido Schimmel <idosch@idosch.org>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, Simon Horman
	 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
	 <davem@davemloft.net>
Date: Fri, 13 Dec 2024 15:33:44 -0500
In-Reply-To: <2283799b-e1fe-42c2-aecc-50c4ae1f9afa@blackwall.org>
References: <20241208221805.1543107-1-rrendec@redhat.com>
	 <2283799b-e1fe-42c2-aecc-50c4ae1f9afa@blackwall.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-10 at 11:18 +0200, Nikolay Aleksandrov wrote:
> On 12/9/24 00:18, Radu Rendec wrote:
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
>=20
> Hi,
> Thanks for working on this, a few comments below.

Sure, thanks for reviewing! Please see my comments below.

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
> > +	SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL,
> > +	/**
> > +	 * @SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD: the STP state of the
> > +	 * ingress bridge port does not allow frames to be forwarded.
> > +	 */
> > +	SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD,
>=20
> Since this is used only when the port state causes the packet to drop, wh=
y not
> rename it to something that suggests it was the state?

Yes, Ido had a similar suggestion [1], so it's clear that it must be
renamed. I will go with SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE in the
next version, unless you have a better idea.

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
>=20
> This is not entirely correct, we can get here if we had an error forwardi=
ng
> the packet to some port, but it may already have been forwarded to others=
.
> The reason should distinguish between those two cases.

I will follow Ido's suggestion [2] and rename SKB_DROP_REASON_VXLAN_NO_REMO=
TE
to SKB_DROP_REASON_NO_TX_TARGET, and then use that.

But it will only cover the case when there are no errors, so I still
need a different reason for the error case. I looked, and I couldn't
find an existing one that's close enough, so I think I should create a
new one. How about SKB_DROP_REASON_TX_ERROR? I would not use "BRIDGE"
in the name because I'm thinking it may be reused elsewhere, outside
the bridge module.

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
>=20
> Same comment as above (br_flood).
>=20
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
> > +	}>=C2=A0=20
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

[1] https://lore.kernel.org/bridge/Z1sLyqZQCjbcCOde@shredder/
[2] https://lore.kernel.org/bridge/Z1sUsSFfBC9GoiIA@shredder/

--
Best regards,
Radu


