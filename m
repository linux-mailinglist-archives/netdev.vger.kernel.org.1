Return-Path: <netdev+bounces-153142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B269F6FC5
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 22:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1873716C1C6
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 21:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8BA1FD7A2;
	Wed, 18 Dec 2024 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0k7oFQH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AEC1FCD0F
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734558913; cv=none; b=fdQ5G3DAQwDsU62aNV6jjvkiww1S8xsQ/0hKZ67bJKdt5IAyV3WQSHUXnTMvSC9kvc6o33zbl7IOAEoJ/7cw5ZP4OUfCAhPM4LkQenuTEMW+u9zwYQpjAnjSOGLrY0uqqFuVd0m7LviBwA1jeX/q4ijUU7HtHn/cHGNPszlPYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734558913; c=relaxed/simple;
	bh=TTAAoygDcmBWky68LsCKJQtXPPNscIKZEPcaBHkaSMs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XC+4CRAr7OePhkXZF1BKjhWyGIcWx+ygE6M2t86p1TT+f1OSlXFRm2RLO+sjL7VEoPKQvi65HvE+uH44lwQfX5MII/rJooPcRyF22aJQNgsiBcm6GzijURMsJknLzMiixl2YACta/nXdNEJ9X6L5Pks3hN/p0hhV8wDYpyeAIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0k7oFQH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734558910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47mqpRn+BePFgYtH9uYNUOpjcGsj0s5njP7zbQmLNSM=;
	b=e0k7oFQHA3aPwe4BsQlEKhtQ/oz4CYVJkgzphgDUFhyBcmjDy1m8KbR8OugfliK1EukNe8
	dVIzl/yQWAMqh25aB5DwxeixgUigXJoCO36cpGKl/ZdTPRPM8Ddfpg3GqTcGyPYFOLda54
	k0OvPGW182IiMu4hZJArEZAjUqg7Tts=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-cufQj0TAOLGn8zcZVjpU1w-1; Wed, 18 Dec 2024 16:55:08 -0500
X-MC-Unique: cufQj0TAOLGn8zcZVjpU1w-1
X-Mimecast-MFC-AGG-ID: cufQj0TAOLGn8zcZVjpU1w
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6e6cf6742so17595785a.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 13:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734558908; x=1735163708;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47mqpRn+BePFgYtH9uYNUOpjcGsj0s5njP7zbQmLNSM=;
        b=ucbZYe0r7O9iwXvlMlp+6KRvulmT6qYV3nYI8/WfM5BkZJzeC/mnWatUpX/6gjSkbK
         45jU0OfiuhwA8nYlD7Gse+hHHMuhXwjW+LQmdQ6wq07Ut7/VdLcdgjs4mexR/IIg4ajD
         tQIzgrPRki7TOZF9Xgm6+YMCvcx9TPk39yBOz5mEzWOcYOXLZgoYdXSyVnT1nL2Ecbxb
         Myt2E0E7YpmGown3vsBYOO05hQ3KDoH7tnIPtly7wQYKHs+eHiEeeAp3PqP9F81znTtt
         VaiiQlEIdssdsZKFaB5FlOhUvGriYV8tHgxJYhW2u9XD61GTfotp4BouezL95gDyEqlJ
         ZAYw==
X-Forwarded-Encrypted: i=1; AJvYcCVrDDnutIHw6fPajqmjxdIEm/jXX2+arSW4+YfML1OuolKZ3m/0EXq94m9QkSOlVxiDeExNzgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK8QC1U2Yg2HAGCI2yuiGMzYvXeOZm8wQOxrzMrv6fbZFoMO+V
	YlGJ1I0Szn6z6YJFav+eO31Z2YFjHxdSuKaWIKTZqeJuhlK0c9nxrRZ0bKZKLVElfpMgx1IOwSx
	6zyK+WhvNMtrXMIzD9F87B0xom+pqosjkojSMYSSqQy+2q8OjIsLBZg==
X-Gm-Gg: ASbGncsj49grmlgQ2DKcJ5PPahV5QRp3AyEitPd0pR5B0h7ap3nxlatw37nbu2KDb5J
	sxUG51NHLzTW8/LDHPYyrHuKhuMu7fL0wNbotSoaSG5Yr3T/oj/KSqA9GeiHVE2ISlFcknAxWDO
	weoECzJWT/NOHuOX7ZcOubo+S4V8ZYFZILFUPD/B/d/I4YvMPWiKFttmyHduOAH1k7DaMlbEahY
	9zNYI2xc+1P2jw1aseqZtUpeKFnATvvUplELWTVuX78xwlB6PHAQ6eF8qN5kLXBTjBBPykWhoUZ
	weHzp8DLb9SfLbQ7n8kCmZEBVvQiN3j61ccWULp3z5xTgKoU
X-Received: by 2002:a05:620a:1a94:b0:7b7:25d:d7c9 with SMTP id af79cd13be357-7b9aa8d5861mr190202685a.19.1734558908363;
        Wed, 18 Dec 2024 13:55:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN0nV7r1Aq8rsr9PRc5HhqjMf11OPyLoniGp8EXIXKnhfyQAVUE5qtwUD0N2KZFrTisIGbsg==
X-Received: by 2002:a05:620a:1a94:b0:7b7:25d:d7c9 with SMTP id af79cd13be357-7b9aa8d5861mr190200185a.19.1734558908055;
        Wed, 18 Dec 2024 13:55:08 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2f8fe6sm1111285a.51.2024.12.18.13.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 13:55:07 -0800 (PST)
Message-ID: <d3533bbaa4c91d228dceb449a24eb7cba969c345.camel@redhat.com>
Subject: Re: [PATCH net-next v2 2/2] net: bridge: add skb drop reasons to
 the most common drop points
From: Radu Rendec <rrendec@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu
 <roopa@nvidia.com>,  bridge@lists.linux.dev, netdev@vger.kernel.org, Simon
 Horman <horms@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,  "David S. Miller"
 <davem@davemloft.net>
Date: Wed, 18 Dec 2024 16:55:05 -0500
In-Reply-To: <Z2MEOvn4dNToq5Fq@shredder>
References: <20241217230711.192781-1-rrendec@redhat.com>
	 <20241217230711.192781-3-rrendec@redhat.com> <Z2MEOvn4dNToq5Fq@shredder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-18 at 19:19 +0200, Ido Schimmel wrote:
> On Tue, Dec 17, 2024 at 06:07:11PM -0500, Radu Rendec wrote:
> > @@ -520,6 +522,16 @@ enum skb_drop_reason {
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
>=20
> s/SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD/SKB_DROP_REASON_BRIDGE_INGRESS=
_STP_STATE/

Oops :) Good catch!

> > +	 * ingress bridge port does not allow frames to be forwarded.
> > +	 */
> > +	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
> > =C2=A0	/**
> > =C2=A0	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
> > =C2=A0	 * shouldn't be used as a real 'reason' - only for tracing code =
gen
> > diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> > index e19b583ff2c6d..3e9b462809b0e 100644
> > --- a/net/bridge/br_forward.c
> > +++ b/net/bridge/br_forward.c
> > @@ -201,6 +201,7 @@ void br_flood(struct net_bridge *br, struct sk_buff=
 *skb,
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum br_pkt_type pkt_type, bool l=
ocal_rcv, bool local_orig,
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 vid)
> > =C2=A0{
> > +	enum skb_drop_reason reason =3D SKB_DROP_REASON_NO_TX_TARGET;
> > =C2=A0	struct net_bridge_port *prev =3D NULL;
> > =C2=A0	struct net_bridge_port *p;
> > =C2=A0
> > @@ -234,8 +235,11 @@ void br_flood(struct net_bridge *br, struct sk_buf=
f *skb,
> > =C2=A0			continue;
> > =C2=A0
> > =C2=A0		prev =3D maybe_deliver(prev, p, skb, local_orig);
> > -		if (IS_ERR(prev))
> > +		if (IS_ERR(prev)) {
> > +			WARN_ON_ONCE(PTR_ERR(prev) !=3D -ENOMEM);
>=20
> I don't think we want to see a stack trace just because someone forgot
> to adjust the drop reason to the error code. Maybe just set it to
> 'NOMEM' if error code is '-ENOMEM', otherwise to 'NOT_SPECIFIED'.

Sure, that was my first choice too, but then I changed my mind. I don't
think there's a 100% clean way of doing this because maybe_deliver()
can return only -ENOMEM today, but that may change in the future. I
will change it back to what I had initially, which is essentially the
same as you suggested.

> > +			reason =3D SKB_DROP_REASON_NOMEM;
> > =C2=A0			goto out;
> > +		}
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	if (!prev)
> > @@ -249,7 +253,7 @@ void br_flood(struct net_bridge *br, struct sk_buff=
 *skb,
> > =C2=A0
> > =C2=A0out:
> > =C2=A0	if (!local_rcv)
> > -		kfree_skb(skb);
> > +		kfree_skb_reason(skb, reason);
> > =C2=A0}
> > =C2=A0
> > =C2=A0#ifdef CONFIG_BRIDGE_IGMP_SNOOPING
> > @@ -289,6 +293,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry=
 *mdst,
> > =C2=A0			struct net_bridge_mcast *brmctx,
> > =C2=A0			bool local_rcv, bool local_orig)
> > =C2=A0{
> > +	enum skb_drop_reason reason =3D SKB_DROP_REASON_NO_TX_TARGET;
> > =C2=A0	struct net_bridge_port *prev =3D NULL;
> > =C2=A0	struct net_bridge_port_group *p;
> > =C2=A0	bool allow_mode_include =3D true;
> > @@ -329,8 +334,11 @@ void br_multicast_flood(struct net_bridge_mdb_entr=
y *mdst,
> > =C2=A0		}
> > =C2=A0
> > =C2=A0		prev =3D maybe_deliver(prev, port, skb, local_orig);
> > -		if (IS_ERR(prev))
> > +		if (IS_ERR(prev)) {
> > +			WARN_ON_ONCE(PTR_ERR(prev) !=3D -ENOMEM);
>=20
> Likewise
>=20
> > +			reason =3D SKB_DROP_REASON_NOMEM;
> > =C2=A0			goto out;
> > +		}
> > =C2=A0delivered:
> > =C2=A0		if ((unsigned long)lport >=3D (unsigned long)port)
> > =C2=A0			p =3D rcu_dereference(p->next);
> > @@ -349,6 +357,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry=
 *mdst,
> > =C2=A0
> > =C2=A0out:
> > =C2=A0	if (!local_rcv)
> > -		kfree_skb(skb);
> > +		kfree_skb_reason(skb, reason);
> > =C2=A0}
> > =C2=A0#endif
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index ceaa5a89b947f..0adad3986c77d 100644
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
> > +			kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE);
> > +			return 0;
> > +		}
>=20
> It would be good to keep the error path consolidated with 'goto drop' in
> case we ever want to increment a drop counter or do something else that
> is common to all the drops.
>=20
> Did you consider adding a 'reason' variable that is initialized to
> 'SKB_DROP_REASON_NOT_SPECIFIED' and setting it to the appropriate reason
> before 'goto drop'? Seems like a common pattern.

I did not consider it because I didn't realize there was an intention
to keep the error path consolidated. I did that for the two "flood"
functions though. And now that you explained it, I can see why you'd
want to do it here. I will refactor it and post v3 soon if I don't see
any new comments on v2.

> Same in br_handle_frame().
>=20
> > =C2=A0
> > =C2=A0		state =3D p->state;
> > =C2=A0	}
> > @@ -155,8 +157,10 @@ int br_handle_frame_finish(struct net *net,
> > struct sock *sk, struct sk_buff *skb
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > -	if (state =3D=3D BR_STATE_LEARNING)
> > -		goto drop;
> > +	if (state =3D=3D BR_STATE_LEARNING) {
> > +		kfree_skb_reason(skb,
> > SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE);
> > +		return 0;
> > +	}
> > =C2=A0
> > =C2=A0	BR_INPUT_SKB_CB(skb)->brdev =3D br->dev;
> > =C2=A0	BR_INPUT_SKB_CB(skb)->src_port_isolated =3D !!(p->flags &
> > BR_ISOLATED);
> > @@ -331,8 +335,10 @@ static rx_handler_result_t
> > br_handle_frame(struct sk_buff **pskb)
> > =C2=A0	if (unlikely(skb->pkt_type =3D=3D PACKET_LOOPBACK))
> > =C2=A0		return RX_HANDLER_PASS;
> > =C2=A0
> > -	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
> > -		goto drop;
> > +	if (!is_valid_ether_addr(eth_hdr(skb)->h_source)) {
> > +		kfree_skb_reason(skb,
> > SKB_DROP_REASON_MAC_INVALID_SOURCE);
> > +		return RX_HANDLER_CONSUMED;
> > +	}
> > =C2=A0
> > =C2=A0	skb =3D skb_share_check(skb, GFP_ATOMIC);
> > =C2=A0	if (!skb)
> > @@ -374,7 +380,8 @@ static rx_handler_result_t
> > br_handle_frame(struct sk_buff **pskb)
> > =C2=A0			return RX_HANDLER_PASS;
> > =C2=A0
> > =C2=A0		case 0x01:	/* IEEE MAC (Pause) */
> > -			goto drop;
> > +			kfree_skb_reason(skb,
> > SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL);
> > +			return RX_HANDLER_CONSUMED;
> > =C2=A0
> > =C2=A0		case 0x0E:	/* 802.1AB LLDP */
> > =C2=A0			fwd_mask |=3D p->br->group_fwd_mask;
> > @@ -423,8 +430,7 @@ static rx_handler_result_t
> > br_handle_frame(struct sk_buff **pskb)
> > =C2=A0
> > =C2=A0		return nf_hook_bridge_pre(skb, pskb);
> > =C2=A0	default:
> > -drop:
> > -		kfree_skb(skb);
> > +		kfree_skb_reason(skb,
> > SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE);
> > =C2=A0	}
> > =C2=A0	return RX_HANDLER_CONSUMED;
> > =C2=A0}
> > --=20
> > 2.47.1
> >=20
>=20


