Return-Path: <netdev+bounces-102309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9913E9024F8
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 17:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448F2B22C38
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7CF137C35;
	Mon, 10 Jun 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ckuMeac0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563C136E21
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031985; cv=none; b=PMRt3TmskQHuCHHmCfrNB9xecxb2tj4LadZYvwnV/4Us2lnstHlE41VKqxFK0KYsz0sC58GzGb+RbrrceMykmXfVkcm/rhRw2OS/ie/y4KlZr3FlSujy0Wa4g8yJZnbatlunXSjJy+3GketCkrpus13H6/4b3muANe5N+TQY/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031985; c=relaxed/simple;
	bh=aDAccP97Vrv882n4aLdL6X9An1ESDEwpDibDVG0Cpgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUx0uA0qR9j1kibRPtUb7tYuQiPENdyjkeZzLkeaqlIJjCyfM5sd0d+Alf8Z+XOmeOyk9BVvFrz8TMZkqWOpBh3Hgq1MqRoTprfL0Lb9kyOnJ66YmCh0FGOeFnwieZaKEYak9q0d0H9X3ITM1cGHqkFPHkxJNBZJaOeGKNHCDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ckuMeac0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 191403F72E
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 15:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718031975;
	bh=mMes71e0JY86wpVNx6ZKgnFS0gZH4kPa59mAztM3PFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ckuMeac06UjkR/KxYiGPoDZ6m8cH3h7gnsnP2j+c753Wy9A7dleK8cXzdvl5UTFC2
	 rqx53Fxr5nT83xLPFq3rF4IA8rguuerT1k94/Bua7TeGmrH42hbakaB2Lt7BP9/6KV
	 /FEqZw1yHLOrcyU4WUOWSrj7nA935yO8FjqzRLp/+GA360wmJdjEosIc6EKKK8Bz+7
	 RdsTn24+YzP3IwgjHv7MFEbCaykkjHGdRzIwnqafH9EuOaOM5YUSB79VT5DqcfaytB
	 RTzpu1ieOeSBAIB8jT/5m5r5PTllLV7aSH3LkMubu2AGTgMQa1kPoDcPpws3uWt0PP
	 upozV+l0iLeOA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6f0f7d6eaaso192023966b.1
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 08:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718031973; x=1718636773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMes71e0JY86wpVNx6ZKgnFS0gZH4kPa59mAztM3PFg=;
        b=rphbC5MRRuFM50r3sz6MHQsQkoe9LsbjQ9wLFJ1fFAok1TZVPGgvvdzrY7jSODqe7D
         z0AM/+XTMmI5SexNcMFNsNtZcLHe9dPzspbZO+r6/uPNLx4l5aox56qk/M8Si/VwBRx0
         2+uBRlbxE/AQflxnKYwZ22tEeY6reuaI5lBqgyc4Bs3i47mDVqidyJYqACMrwmu/WgK/
         j2oBjX6t8CAuyFsrdiKEIqL2KGGTaGnjYfcDNf9RqqmWtBYyKG9+uMy1hbjIa3p2DL6H
         eRCsabf55xdBG6uDa/S6q+RGr/dKC9Omj+2GFLkWj6wis2pLPOSpl/OICcgqh9IGDvP5
         a30Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsILNVrDMaOLvegnKT5WGf8z5gYBefT6sQRWlq1LRTEzB0XI0ci2GRC0fC5/QlZpkzPU+KmCv2AnnDglM6FjKScjKWsPcc
X-Gm-Message-State: AOJu0YzhMxd7Kegq8ZWCGwmJMDYeoiFaROk5evCI4b0AFWjZNJuZuhYW
	DaKFYkenTQNaOCii/P2b5fEnH3A4eVPMqP61hD+koj2in+9hT88B/qcD7vI0ETjTQL9m8G/gzrm
	VtJcTdbKnOxPXPwKRTHC4agg4uJEA0hyrLBugojgQpk1RdXHKFSVr/OqoRT3ClSbiitG/nhbfKh
	RMHduYv5fHEBHnuuoTAmwte+zPZaBDQLRTzIG/zHbxovWbxM4+k6U3Oo8=
X-Received: by 2002:a17:906:394c:b0:a6e:f53c:8da0 with SMTP id a640c23a62f3a-a6ef53c9238mr604628066b.8.1718031973183;
        Mon, 10 Jun 2024 08:06:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrmJ35SEN1PL/TpF5aHavYb6tYg73JpLbRO8e6rXdtU1yng691KZtQfvzY9ns5aX5osUkfarAW018EnSL3A58=
X-Received: by 2002:a17:906:394c:b0:a6e:f53c:8da0 with SMTP id
 a640c23a62f3a-a6ef53c9238mr604624866b.8.1718031972662; Mon, 10 Jun 2024
 08:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608025347.90680-1-chengen.du@canonical.com> <66660e3cd5636_8dbbb294c@willemb.c.googlers.com.notmuch>
In-Reply-To: <66660e3cd5636_8dbbb294c@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Mon, 10 Jun 2024 23:06:01 +0800
Message-ID: <CAPza5qfVzV7NFiVY1jcZR-+0ey-uKgUjV6OcjmDFvKG3T-2SXA@mail.gmail.com>
Subject: Re: [PATCH v6] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

I'm sorry, but I would like to confirm the issue further.

On Mon, Jun 10, 2024 at 4:19=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Chengen Du wrote:
> > The issue initially stems from libpcap. The ethertype will be overwritt=
en
> > as the VLAN TPID if the network interface lacks hardware VLAN offloadin=
g.
> > In the outbound packet path, if hardware VLAN offloading is unavailable=
,
> > the VLAN tag is inserted into the payload but then cleared from the sk_=
buff
> > struct. Consequently, this can lead to a false negative when checking f=
or
> > the presence of a VLAN tag, causing the packet sniffing outcome to lack
> > VLAN tag information (i.e., TCI-TPID). As a result, the packet capturin=
g
> > tool may be unable to parse packets as expected.
> >
> > The TCI-TPID is missing because the prb_fill_vlan_info() function does =
not
> > modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in th=
e
> > payload and not in the sk_buff struct. The skb_vlan_tag_present() funct=
ion
> > only checks vlan_all in the sk_buff struct. In cooked mode, the L2 head=
er
> > is stripped, preventing the packet capturing tool from determining the
> > correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
> > which means the packet capturing tool cannot parse the L3 header correc=
tly.
> >
> > Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@=
canonical.com/T/#u
> > Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chengen Du <chengen.du@canonical.com>
>
> Overall, solid.
>
> > ---
> >  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 55 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index ea3ebc160e25..8cffbe1f912d 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -538,6 +538,43 @@ static void *packet_current_frame(struct packet_so=
ck *po,
> >       return packet_lookup_frame(po, rb, rb->head, status);
> >  }
> >
> > +static u16 vlan_get_tci(struct sk_buff *skb)
> > +{
> > +     struct vlan_hdr vhdr, *vh;
> > +     u8 *skb_orig_data =3D skb->data;
> > +     int skb_orig_len =3D skb->len;
> > +
> > +     skb_push(skb, skb->data - skb_mac_header(skb));
> > +     vh =3D skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &vhdr);
>
> Don't harcode Ethernet.
>
> According to documentation VLANs are used with other link layers.
>
> More importantly, in practice PF_PACKET allows inserting this
> skb->protocol on any device.
>
> We don't use link layer specific constants anywhere in the packet
> socket code for this reason. But instead dev->hard_header_len.
>
> One caveat there is variable length link layer headers, where
> dev->min_header_len !=3D dev->hard_header_len. Will just have to fail
> on those.

Thank you for pointing out this error. I would like to confirm if I
need to use dev->hard_header_len to get the correct header length and
return zero if dev->min_header_len !=3D dev->hard_header_len to handle
variable-length link layer headers. Is there something I
misunderstand, or are there other aspects I need to consider further?

>
> > +     if (skb_orig_data !=3D skb->data) {
> > +             skb->data =3D skb_orig_data;
> > +             skb->len =3D skb_orig_len;
> > +     }
> > +     if (unlikely(!vh))
> > +             return 0;
> > +
> > +     return ntohs(vh->h_vlan_TCI);
> > +}
> > +
>
> Only since I had to respond above: this is non-obvious enough to
> deserve a function comment. Something like the following?
>
> /* For SOCK_DGRAM, data starts at the network protocol, after any VLAN
>  * headers. sll_protocol must point to the network protocol. The
>  * (outer) VLAN TCI is still accessible as auxdata.
>  */
>
> > +static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> > +{
> > +     __be16 proto =3D skb->protocol;
> > +
> > +     if (unlikely(eth_type_vlan(proto))) {
> > +             u8 *skb_orig_data =3D skb->data;
> > +             int skb_orig_len =3D skb->len;
> > +
> > +             skb_push(skb, skb->data - skb_mac_header(skb));
> > +             proto =3D __vlan_get_protocol(skb, proto, NULL);
> > +             if (skb_orig_data !=3D skb->data) {
> > +                     skb->data =3D skb_orig_data;
> > +                     skb->len =3D skb_orig_len;
> > +             }
> > +     }
> > +
> > +     return proto;
> > +}
> > +
> >  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> >  {
> >       del_timer_sync(&pkc->retire_blk_timer);
> > @@ -1007,10 +1044,16 @@ static void prb_clear_rxhash(struct tpacket_kbd=
q_core *pkc,
> >  static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
> >                       struct tpacket3_hdr *ppd)
> >  {
> > +     struct packet_sock *po =3D container_of(pkc, struct packet_sock, =
rx_ring.prb_bdqc);
> > +
> >       if (skb_vlan_tag_present(pkc->skb)) {
> >               ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->skb);
> >               ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_proto);
> >               ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> > +     } else if (unlikely(po->sk.sk_type =3D=3D SOCK_DGRAM && eth_type_=
vlan(pkc->skb->protocol))) {
> > +             ppd->hv1.tp_vlan_tci =3D vlan_get_tci(pkc->skb);
> > +             ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->protocol);
> > +             ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> >       } else {
> >               ppd->hv1.tp_vlan_tci =3D 0;
> >               ppd->hv1.tp_vlan_tpid =3D 0;
> > @@ -2428,6 +2471,10 @@ static int tpacket_rcv(struct sk_buff *skb, stru=
ct net_device *dev,
> >                       h.h2->tp_vlan_tci =3D skb_vlan_tag_get(skb);
> >                       h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> >                       status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> > +             } else if (unlikely(sk->sk_type =3D=3D SOCK_DGRAM && eth_=
type_vlan(skb->protocol))) {
> > +                     h.h2->tp_vlan_tci =3D vlan_get_tci(skb);
> > +                     h.h2->tp_vlan_tpid =3D ntohs(skb->protocol);
> > +                     status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> >               } else {
> >                       h.h2->tp_vlan_tci =3D 0;
> >                       h.h2->tp_vlan_tpid =3D 0;
> > @@ -2457,7 +2504,8 @@ static int tpacket_rcv(struct sk_buff *skb, struc=
t net_device *dev,
> >       sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr);
> >       sll->sll_family =3D AF_PACKET;
> >       sll->sll_hatype =3D dev->type;
> > -     sll->sll_protocol =3D skb->protocol;
> > +     sll->sll_protocol =3D (sk->sk_type =3D=3D SOCK_DGRAM) ?
> > +             vlan_get_protocol_dgram(skb) : skb->protocol;
> >       sll->sll_pkttype =3D skb->pkt_type;
> >       if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
> >               sll->sll_ifindex =3D orig_dev->ifindex;
> > @@ -3482,7 +3530,8 @@ static int packet_recvmsg(struct socket *sock, st=
ruct msghdr *msg, size_t len,
> >               /* Original length was stored in sockaddr_ll fields */
> >               origlen =3D PACKET_SKB_CB(skb)->sa.origlen;
> >               sll->sll_family =3D AF_PACKET;
> > -             sll->sll_protocol =3D skb->protocol;
> > +             sll->sll_protocol =3D (sock->type =3D=3D SOCK_DGRAM) ?
> > +                     vlan_get_protocol_dgram(skb) : skb->protocol;
> >       }
> >
> >       sock_recv_cmsgs(msg, sk, skb);
> > @@ -3539,6 +3588,10 @@ static int packet_recvmsg(struct socket *sock, s=
truct msghdr *msg, size_t len,
> >                       aux.tp_vlan_tci =3D skb_vlan_tag_get(skb);
> >                       aux.tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> >                       aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> > +             } else if (unlikely(sock->type =3D=3D SOCK_DGRAM && eth_t=
ype_vlan(skb->protocol))) {
> > +                     aux.tp_vlan_tci =3D vlan_get_tci(skb);
> > +                     aux.tp_vlan_tpid =3D ntohs(skb->protocol);
> > +                     aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> >               } else {
> >                       aux.tp_vlan_tci =3D 0;
> >                       aux.tp_vlan_tpid =3D 0;
> > --
> > 2.43.0
> >
>
>

