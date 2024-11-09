Return-Path: <netdev+bounces-143554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 029459C2F5F
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 20:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC9E282295
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 19:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051D81A08B8;
	Sat,  9 Nov 2024 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y7dZg3qy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33619D08A
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731181397; cv=none; b=jbJzouxA0XaQAty6P4TaweHCnwPysyjgKL2Fl7Lxp1S78qmbNTikoQVhZg5wOAiCDN+0afc8QUn6am74+SOyA136W1EJB+PnyBXaeLs7QGgGAESciaO9ZtKhPTPY2i2ZAEnYt6Zh8o0YMM7npuBBfvCxLg8XIQybLkNxgklxjeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731181397; c=relaxed/simple;
	bh=2NP4YZItbCFRkc7TokCYdlza4/Fi4F6Gw9+u+u1TBag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vy2EnZ7uX2JCS1GRUWvXkxnvimeF8X8j4yjdf1YskljqA7SC/rN8Jhn9q4sviwtqVXtuhUeufLySKM68ufrASGxTs2QBQLdsQ4Mtv13JfufhiMTkZdqhtbPwsn0sRwiAJbrxmH0UQF9fF4LhA3QhiC9xRgWQvCWHOjYQKauJWrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y7dZg3qy; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460a8d1a9b7so159741cf.1
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 11:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731181395; x=1731786195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/gchnhVFxW0rHCEyp2aG9r/EAAdKXS6HrTgVM7VDjo=;
        b=y7dZg3qyz0kvjgfSrRobD6lPxYo4W8hYImcZLutkEQ67C65W6PVmN3vE+rNlFXGurG
         koF/Hgobf0yM5Sj60V9yEJC137pR7g/5CU/SXY4Lt1W71exqo+O9V7lZFSa8mzJR4mSY
         +NTyqLPHl+ZCOZCKh8FSGfWsuB6n3B5HT+lYvkAUgdj3MN6qbvXtcytcNeKM9+Xnz5ui
         I5oFo6YG6m53mDsaKZVZMMd2TGzA6pHkMad5G5ebb7t/UZafkXLGf/u2DE7QmTwkUGCw
         SMlPfiqkJ1Hbc0oYdiQ0J6gbHM9QO9Zpq20kvuK3W5/KUC0mntfgKa8VFmy3K1pa5Yff
         FdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731181395; x=1731786195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/gchnhVFxW0rHCEyp2aG9r/EAAdKXS6HrTgVM7VDjo=;
        b=Vb0eQEd0KwtJp8dqR8wRYXLhz3yoqFuskoujAGDWsMO5lvYd4JvASNwdEDkXo1TG3n
         i2pZwKxLvlxSvEzvrezcpbfvA3+QuZvXFmVFG+DbcaJohLxEpelBokqhQVBXzCOCrUmZ
         A7jhkDO/uS1njAaOIsEpepr6KFS/opGnTbfBck0SKXFWAW2u7J6QesDpZAUVJSOLBVcE
         faQ4rz8gfwJWlefvy6BdIAHImmzBcK2E5ONPA0B1ih50lFV5ttVedLUnXhnQsLYtrLBS
         OqgmONAgkQKnhCsPYf8trYmHwIoB37zwA8GNQS3GI/hjDPq2u7ZtSW/fP5l8OqMEb8Hn
         Dqbg==
X-Forwarded-Encrypted: i=1; AJvYcCUeIYK1iXVXrSYnIZu808aNas5Yb7FatNIhUkyUYjz8Iv9kLcBfhFrn+MtuVNqq1D6mhx6s4qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBWT8hKoByupapf0biNY8YxJmmQI3bxmochWfnj3ti6zUwIYG7
	FViPMkr9YLMzNjwycFugv1LK+anjGoorFwGxOhnie67IFDKE8nM8YdZMGrWWkO5X83Dd+2AvyDu
	EA//C0rCM/KdM7/iVl1Q9hght0WCfCUyt28UO
X-Gm-Gg: ASbGnctL23/2/nCMpvHXAf+pRt2C9F8vIAuM2X4K+acteTaAmXmdcsVSHFXJaiLpw8a
	EuihfvXD3gvTM3VngrKsZtWhsJdzBE7LTxaSt6WAnnAOoaa9DWiYPBYB5IYBwkfEK
X-Google-Smtp-Source: AGHT+IGbds3miw2J0hHitR89F5/BahlOYcx1uoJy4Q3QYIdxJE6a2yg8t+Hc+5fZLIC9qbdfozJXmuP3OujDHOnNwag=
X-Received: by 2002:a05:622a:c6:b0:461:48f9:4852 with SMTP id
 d75a77b69052e-46316a17c5amr2497981cf.28.1731181394831; Sat, 09 Nov 2024
 11:43:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105100647.117346-1-chia-yu.chang@nokia-bell-labs.com>
 <20241105100647.117346-9-chia-yu.chang@nokia-bell-labs.com> <661b9e25-0237-ef1f-e2fa-86ca52f676a2@kernel.org>
In-Reply-To: <661b9e25-0237-ef1f-e2fa-86ca52f676a2@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 9 Nov 2024 14:42:58 -0500
Message-ID: <CADVnQym4VF9dmV9Q4GGXXoBr-0nNrM181rSZFR2cNJv+MDGO8w@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 08/13] gso: AccECN support
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, netdev@vger.kernel.org, 
	dsahern@gmail.com, davem@davemloft.net, edumazet@google.com, 
	dsahern@kernel.org, pabeni@redhat.com, joel.granados@kernel.org, 
	kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Bob Briscoe <ietf@bobbriscoe.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 5:09=E2=80=AFAM Ilpo J=C3=A4rvinen <ij@kernel.org> w=
rote:
>
> On Tue, 5 Nov 2024, chia-yu.chang@nokia-bell-labs.com wrote:
>
> > From: Ilpo J=C3=A4rvinen <ij@kernel.org>
> >
> > Handling the CWR flag differs between RFC 3168 ECN and AccECN.
> > With RFC 3168 ECN aware TSO (NETIF_F_TSO_ECN) CWR flag is cleared
> > starting from 2nd segment which is incompatible how AccECN handles
> > the CWR flag. Such super-segments are indicated by SKB_GSO_TCP_ECN.
> > With AccECN, CWR flag (or more accurately, the ACE field that also
> > includes ECE & AE flags) changes only when new packet(s) with CE
> > mark arrives so the flag should not be changed within a super-skb.
> > The new skb/feature flags are necessary to prevent such TSO engines
> > corrupting AccECN ACE counters by clearing the CWR flag (if the
> > CWR handling feature cannot be turned off).
> >
> > If NIC is completely unaware of RFC3168 ECN (doesn't support
> > NETIF_F_TSO_ECN) or its TSO engine can be set to not touch CWR flag
> > despite supporting also NETIF_F_TSO_ECN, TSO could be safely used
> > with AccECN on such NIC. This should be evaluated per NIC basis
> > (not done in this patch series for any NICs).
> >
> > For the cases, where TSO cannot keep its hands off the CWR flag,
> > a GSO fallback is provided by this patch.
> >
> > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > ---
> >  include/linux/netdev_features.h | 8 +++++---
> >  include/linux/netdevice.h       | 2 ++
> >  include/linux/skbuff.h          | 2 ++
> >  net/ethtool/common.c            | 1 +
> >  net/ipv4/tcp_offload.c          | 6 +++++-
> >  5 files changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/netdev_features.h b/include/linux/netdev_fea=
tures.h
> > index 66e7d26b70a4..c59db449bcf0 100644
> > --- a/include/linux/netdev_features.h
> > +++ b/include/linux/netdev_features.h
> > @@ -53,12 +53,12 @@ enum {
> >       NETIF_F_GSO_UDP_BIT,            /* ... UFO, deprecated except tun=
tap */
> >       NETIF_F_GSO_UDP_L4_BIT,         /* ... UDP payload GSO (not UFO) =
*/
> >       NETIF_F_GSO_FRAGLIST_BIT,               /* ... Fraglist GSO */
> > +     NETIF_F_GSO_ACCECN_BIT,         /* TCP AccECN w/ TSO (no clear CW=
R) */
> >       /**/NETIF_F_GSO_LAST =3D          /* last bit, see GSO_MASK */
> > -             NETIF_F_GSO_FRAGLIST_BIT,
> > +             NETIF_F_GSO_ACCECN_BIT,
> >
> >       NETIF_F_FCOE_CRC_BIT,           /* FCoE CRC32 */
> >       NETIF_F_SCTP_CRC_BIT,           /* SCTP checksum offload */
> > -     __UNUSED_NETIF_F_37,
> >       NETIF_F_NTUPLE_BIT,             /* N-tuple filters supported */
> >       NETIF_F_RXHASH_BIT,             /* Receive hashing offload */
> >       NETIF_F_RXCSUM_BIT,             /* Receive checksumming offload *=
/
> > @@ -128,6 +128,7 @@ enum {
> >  #define NETIF_F_SG           __NETIF_F(SG)
> >  #define NETIF_F_TSO6         __NETIF_F(TSO6)
> >  #define NETIF_F_TSO_ECN              __NETIF_F(TSO_ECN)
> > +#define NETIF_F_GSO_ACCECN   __NETIF_F(GSO_ACCECN)
> >  #define NETIF_F_TSO          __NETIF_F(TSO)
> >  #define NETIF_F_VLAN_CHALLENGED      __NETIF_F(VLAN_CHALLENGED)
> >  #define NETIF_F_RXFCS                __NETIF_F(RXFCS)
> > @@ -210,7 +211,8 @@ static inline int find_next_netdev_feature(u64 feat=
ure, unsigned long start)
> >                                NETIF_F_TSO_ECN | NETIF_F_TSO_MANGLEID)
> >
> >  /* List of features with software fallbacks. */
> > -#define NETIF_F_GSO_SOFTWARE (NETIF_F_ALL_TSO | NETIF_F_GSO_SCTP |    =
    \
> > +#define NETIF_F_GSO_SOFTWARE (NETIF_F_ALL_TSO | \
> > +                              NETIF_F_GSO_ACCECN | NETIF_F_GSO_SCTP | =
\
> >                                NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIS=
T)
> >
> >  /*
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 6e0f8e4aeb14..480d915b3bdb 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -5076,6 +5076,8 @@ static inline bool net_gso_ok(netdev_features_t f=
eatures, int gso_type)
> >       BUILD_BUG_ON(SKB_GSO_UDP !=3D (NETIF_F_GSO_UDP >> NETIF_F_GSO_SHI=
FT));
> >       BUILD_BUG_ON(SKB_GSO_UDP_L4 !=3D (NETIF_F_GSO_UDP_L4 >> NETIF_F_G=
SO_SHIFT));
> >       BUILD_BUG_ON(SKB_GSO_FRAGLIST !=3D (NETIF_F_GSO_FRAGLIST >> NETIF=
_F_GSO_SHIFT));
> > +     BUILD_BUG_ON(SKB_GSO_TCP_ACCECN !=3D
> > +                  (NETIF_F_GSO_ACCECN >> NETIF_F_GSO_SHIFT));
> >
> >       return (features & feature) =3D=3D feature;
> >  }
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 48f1e0fa2a13..530cb325fb86 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -694,6 +694,8 @@ enum {
> >       SKB_GSO_UDP_L4 =3D 1 << 17,
> >
> >       SKB_GSO_FRAGLIST =3D 1 << 18,
> > +
> > +     SKB_GSO_TCP_ACCECN =3D 1 << 19,
> >  };
> >
> >  #if BITS_PER_LONG > 32
> > diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> > index 0d62363dbd9d..5c3ba2dfaa74 100644
> > --- a/net/ethtool/common.c
> > +++ b/net/ethtool/common.c
> > @@ -32,6 +32,7 @@ const char netdev_features_strings[NETDEV_FEATURE_COU=
NT][ETH_GSTRING_LEN] =3D {
> >       [NETIF_F_TSO_BIT] =3D              "tx-tcp-segmentation",
> >       [NETIF_F_GSO_ROBUST_BIT] =3D       "tx-gso-robust",
> >       [NETIF_F_TSO_ECN_BIT] =3D          "tx-tcp-ecn-segmentation",
> > +     [NETIF_F_GSO_ACCECN_BIT] =3D       "tx-tcp-accecn-segmentation",
> >       [NETIF_F_TSO_MANGLEID_BIT] =3D     "tx-tcp-mangleid-segmentation"=
,
> >       [NETIF_F_TSO6_BIT] =3D             "tx-tcp6-segmentation",
> >       [NETIF_F_FSO_BIT] =3D              "tx-fcoe-segmentation",
> > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > index 2308665b51c5..0b05f30e9e5f 100644
> > --- a/net/ipv4/tcp_offload.c
> > +++ b/net/ipv4/tcp_offload.c
> > @@ -139,6 +139,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb=
,
> >       struct sk_buff *gso_skb =3D skb;
> >       __sum16 newcheck;
> >       bool ooo_okay, copy_destructor;
> > +     bool ecn_cwr_mask;
> >       __wsum delta;
> >
> >       th =3D tcp_hdr(skb);
> > @@ -198,6 +199,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb=
,
> >
> >       newcheck =3D ~csum_fold(csum_add(csum_unfold(th->check), delta));
> >
> > +     ecn_cwr_mask =3D !!(skb_shinfo(gso_skb)->gso_type & SKB_GSO_TCP_A=
CCECN);
> > +
> >       while (skb->next) {
> >               th->fin =3D th->psh =3D 0;
> >               th->check =3D newcheck;
> > @@ -217,7 +220,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb=
,
> >               th =3D tcp_hdr(skb);
> >
> >               th->seq =3D htonl(seq);
> > -             th->cwr =3D 0;
> > +
> > +             th->cwr &=3D ecn_cwr_mask;
>
> Hi all,
>
> I started to wonder if this approach would avoid CWR corruption without
> need to introduce the SKB_GSO_TCP_ACCECN flag at all:
>
> - Never set SKB_GSO_TCP_ECN for any skb
> - Split CWR segment on TCP level before sending. While this causes need t=
o
> split the super skb, it's once per RTT thing so does not sound very
> significant (compare e.g. with SACK that cause split on every ACK)
> - Remove th->cwr cleaning from GSO (the above line)
> - Likely needed: don't negotiate HOST/GUEST_ECN in virtio
>
> I think that would prevent offloading treating CWR flag as RFC3168 and CW=
R
> would be just copied as is like a normal flag which is required to not
> corrupt it. In practice, RFC3168 style traffic would just not combine
> anything with the CWR'ed packet as CWRs are singletons with RFC3168.
>
> Would that work? It sure sounds too simple to work but I cannot
> immediately see why it would not.

The above description just seems to describe the dynamics for the
RFC3168 case (since it mentions the CWR bit being set as just a "once
per RTT thing").

Ilpo, can you please describe how AccECN traffic would be handled in
your design proposal? (Since with established AccECN connections the
CWR bit is part of the ACE counter and may be set on roughly half of
outgoing data skbs...)

Sorry if I'm misunderstanding something...

Thanks,
neal

