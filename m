Return-Path: <netdev+bounces-105130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0918C90FC5C
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F592861C7
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17511B974;
	Thu, 20 Jun 2024 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wWmm48Rw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2774538385
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862870; cv=none; b=TTduGaAK07hMdtAZisf1lytdeRh6FZbNYjPrnRKg2izqjYWau204mcWQX8kVm9mAHUH/unMsFm4IqXEzzEiBzkYEl3GutMTOC8UN/LmIE1pp/jsfeuCaa6POYld5i3HIIN3yILthZq0qP8a1L0BlOr81++4tRYcKfcNooeasQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862870; c=relaxed/simple;
	bh=t7roCUb8NL8OIpO+y5voJGSHJkTpKan65ePPQ0HDiec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPhuipmOiKj1AjAb6uAa1au3XVwm6ihIS1OmmucBOYmw3AgF25snXd82kgiq0oQzR/JR3cMg2eRL/NeOeIbuO4mvmwT9n1+eMnKaziboPQmbde5ET8IZWZ5crwolM+AeR6EgShqPRFTE2ss7akUi4Q3Dk5evmTfhngDwlNV1xYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wWmm48Rw; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 50EB63F6B7
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 05:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718862864;
	bh=DkefC6FKpDoZpklVVtSL6j5J+R1cwOLFzUu97GzrjUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=wWmm48Rwf7jbEfeCvJbzJ7UwqCXVjiQ1Nd2NykO8UjbOrNPJzOlysMJ2XvCL5iDXi
	 +m1EFPE4HMNUcQ7MeOhJwQXWASm6B2RmmlKAVH1XVMHF6kNgFlGq3O0bTS2DgAHeK8
	 BjnAtP1KnXiMdxgmSdEwayVfS0QtuOpXd3OoC3uoCqczmz4BoaMEh+tbUeJc29YJ4Y
	 Yb5LFjH2c2DZQ3z9NxzEbKr6qf9JjsWjpUnceu/t3DPo7PWTDBaRw4rKRrzk43zBd4
	 yokgL8W+f+FQdEPqOfxGwFA+tv+U0H6gH1OzAbjVMcP6MgdA4gfUtruYWRYqcgY3br
	 YFJdA0caCJh5A==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6fad35a585so19343866b.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 22:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718862860; x=1719467660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkefC6FKpDoZpklVVtSL6j5J+R1cwOLFzUu97GzrjUs=;
        b=cBkoZI9wNzFTn5b2IEbGSKeaFc3fypimzRobNjLHqBTY5bZmtvtJrou6303Q7o1uzx
         KIWP9+jmZWsck5MwnN0xUyLjm+QQe/fu/q+BwYDY2z38UyHNv3WshwA+kXVJq0PveBr6
         ZCRAWhQmjdfeupnG2eNtCv/PFBnnPHjBnjkM3jPZFM95KzI1aaA8KAeZU7AWUO5dDuBj
         04LbfDuWK7LgygFnsBeGwxf99SMd073rZQ7FUnTG9wEX01oj0KyEwGPJlqpbWZXkeUv+
         XqBEUuad9meo+nxiQw5N/D9/lm0soHqNGk6PKVMtBWFGfhBep7pUrBsSdsTOtrHu9yKq
         Nl6A==
X-Forwarded-Encrypted: i=1; AJvYcCVL2Zo9qswsSMh6wbgamTA6NIAKFPvGuFvX7SGh2NvmewK/Fe10d82btAHRSS3oz8w96nZkzx0H6oJfaQLD8LGb4WGMDLln
X-Gm-Message-State: AOJu0Yzn2nLGp14rDR/MjEjQwUjnw6AqLMmuGnY0MbaJ8Fu4yeoEdXjT
	z1WK5o1D6ugkArBZWuFtlRSdXJe2H8XW9P8coiyKwi2ritwhKXuUcIiqG4EPx6I7EqbrmbkPgoD
	p4kF980GzvEad/8tLnXNaeusOW2PUOAB8i4uaSURdm8pBwhUXiCCWz6TlyekcmNXv7NZLbF6zHE
	ibHzP5o4YY6pAI94iMconVu2YZQrBG7T9GzkM/PC+x14hIDpnmEXXdzBI=
X-Received: by 2002:a17:906:1955:b0:a6e:7e1f:2eae with SMTP id a640c23a62f3a-a6fab7cd5b9mr221052566b.74.1718862859850;
        Wed, 19 Jun 2024 22:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiGNH7yWi3buIhSPFEz3CYpRHWU1yVWjtaacA6tdTXXNjUUqN7P7LGQ1UWguM+qQD6vhyeMpl2lRUQ6Q+nKtA=
X-Received: by 2002:a17:906:1955:b0:a6e:7e1f:2eae with SMTP id
 a640c23a62f3a-a6fab7cd5b9mr221051166b.74.1718862859314; Wed, 19 Jun 2024
 22:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617054514.127961-1-chengen.du@canonical.com>
 <ZnAdiDjI_unrELB8@nanopsycho.orion> <6670898e1ca78_21d16f2946f@willemb.c.googlers.com.notmuch>
 <ZnEmiIhs5K4ehcYH@nanopsycho.orion> <66715247c147c_23a4e7294a7@willemb.c.googlers.com.notmuch>
In-Reply-To: <66715247c147c_23a4e7294a7@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Thu, 20 Jun 2024 13:54:08 +0800
Message-ID: <CAPza5qfQtPZ-UPF97CG+zEwoQunbzg8F8kX0Q1y5Fzt4Zoc=4w@mail.gmail.com>
Subject: Re: [PATCH v8] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 5:24=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jiri Pirko wrote:
> > Mon, Jun 17, 2024 at 09:07:58PM CEST, willemdebruijn.kernel@gmail.com w=
rote:
> > >Jiri Pirko wrote:
> > >> Mon, Jun 17, 2024 at 07:45:14AM CEST, chengen.du@canonical.com wrote=
:
> > >> >The issue initially stems from libpcap. The ethertype will be overw=
ritten
> > >> >as the VLAN TPID if the network interface lacks hardware VLAN offlo=
ading.
> > >> >In the outbound packet path, if hardware VLAN offloading is unavail=
able,
> > >> >the VLAN tag is inserted into the payload but then cleared from the=
 sk_buff
> > >> >struct. Consequently, this can lead to a false negative when checki=
ng for
> > >> >the presence of a VLAN tag, causing the packet sniffing outcome to =
lack
> > >> >VLAN tag information (i.e., TCI-TPID). As a result, the packet capt=
uring
> > >> >tool may be unable to parse packets as expected.
> > >> >
> > >> >The TCI-TPID is missing because the prb_fill_vlan_info() function d=
oes not
> > >> >modify the tp_vlan_tci/tp_vlan_tpid values, as the information is i=
n the
> > >> >payload and not in the sk_buff struct. The skb_vlan_tag_present() f=
unction
> > >> >only checks vlan_all in the sk_buff struct. In cooked mode, the L2 =
header
> > >> >is stripped, preventing the packet capturing tool from determining =
the
> > >> >correct TCI-TPID value. Additionally, the protocol in SLL is incorr=
ect,
> > >> >which means the packet capturing tool cannot parse the L3 header co=
rrectly.
> > >> >
> > >> >Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > >> >Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen=
.du@canonical.com/T/#u
> > >> >Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > >> >Cc: stable@vger.kernel.org
> > >> >Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > >> >---
> > >> > net/packet/af_packet.c | 86 ++++++++++++++++++++++++++++++++++++++=
+++-
> > >> > 1 file changed, 84 insertions(+), 2 deletions(-)
> > >> >
> > >> >diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > >> >index ea3ebc160e25..84e8884a77e3 100644
> > >> >--- a/net/packet/af_packet.c
> > >> >+++ b/net/packet/af_packet.c
> > >> >@@ -538,6 +538,61 @@ static void *packet_current_frame(struct packe=
t_sock *po,
> > >> >  return packet_lookup_frame(po, rb, rb->head, status);
> > >> > }
> > >> >
> > >> >+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *de=
v)
> > >> >+{
> > >> >+ struct vlan_hdr vhdr, *vh;
> > >> >+ u8 *skb_orig_data =3D skb->data;
> > >> >+ int skb_orig_len =3D skb->len;
> > >> >+ unsigned int header_len;
> > >> >+
> > >> >+ if (!dev)
> > >> >+         return 0;
> > >> >+
> > >> >+ /* In the SOCK_DGRAM scenario, skb data starts at the network
> > >> >+  * protocol, which is after the VLAN headers. The outer VLAN
> > >> >+  * header is at the hard_header_len offset in non-variable
> > >> >+  * length link layer headers. If it's a VLAN device, the
> > >> >+  * min_header_len should be used to exclude the VLAN header
> > >> >+  * size.
> > >> >+  */
> > >> >+ if (dev->min_header_len =3D=3D dev->hard_header_len)
> > >> >+         header_len =3D dev->hard_header_len;
> > >> >+ else if (is_vlan_dev(dev))
> > >> >+         header_len =3D dev->min_header_len;
> > >> >+ else
> > >> >+         return 0;
> > >> >+
> > >> >+ skb_push(skb, skb->data - skb_mac_header(skb));
> > >> >+ vh =3D skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
> > >> >+ if (skb_orig_data !=3D skb->data) {
> > >> >+         skb->data =3D skb_orig_data;
> > >> >+         skb->len =3D skb_orig_len;
> > >> >+ }
> > >> >+ if (unlikely(!vh))
> > >> >+         return 0;
> > >> >+
> > >> >+ return ntohs(vh->h_vlan_TCI);
> > >> >+}
> > >> >+
> > >> >+static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> > >> >+{
> > >> >+ __be16 proto =3D skb->protocol;
> > >> >+
> > >> >+ if (unlikely(eth_type_vlan(proto))) {
> > >> >+         u8 *skb_orig_data =3D skb->data;
> > >> >+         int skb_orig_len =3D skb->len;
> > >> >+
> > >> >+         skb_push(skb, skb->data - skb_mac_header(skb));
> > >> >+         proto =3D __vlan_get_protocol(skb, proto, NULL);
> > >> >+         if (skb_orig_data !=3D skb->data) {
> > >> >+                 skb->data =3D skb_orig_data;
> > >> >+                 skb->len =3D skb_orig_len;
> > >> >+         }
> > >> >+ }
> > >> >+
> > >> >+ return proto;
> > >> >+}
> > >> >+
> > >> > static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc=
)
> > >> > {
> > >> >  del_timer_sync(&pkc->retire_blk_timer);
> > >> >@@ -1007,10 +1062,16 @@ static void prb_clear_rxhash(struct tpacket=
_kbdq_core *pkc,
> > >> > static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
> > >> >                  struct tpacket3_hdr *ppd)
> > >> > {
> > >> >+ struct packet_sock *po =3D container_of(pkc, struct packet_sock, =
rx_ring.prb_bdqc);
> > >> >+
> > >> >  if (skb_vlan_tag_present(pkc->skb)) {
> > >> >          ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->skb);
> > >> >          ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_proto);
> > >> >          ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> > >> >+ } else if (unlikely(po->sk.sk_type =3D=3D SOCK_DGRAM && eth_type_=
vlan(pkc->skb->protocol))) {
> > >> >+         ppd->hv1.tp_vlan_tci =3D vlan_get_tci(pkc->skb, pkc->skb-=
>dev);
> > >> >+         ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->protocol);
> > >> >+         ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> > >> >  } else {
> > >> >          ppd->hv1.tp_vlan_tci =3D 0;
> > >> >          ppd->hv1.tp_vlan_tpid =3D 0;
> > >> >@@ -2428,6 +2489,10 @@ static int tpacket_rcv(struct sk_buff *skb, =
struct net_device *dev,
> > >> >                  h.h2->tp_vlan_tci =3D skb_vlan_tag_get(skb);
> > >> >                  h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> > >> >                  status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> > >> >+         } else if (unlikely(sk->sk_type =3D=3D SOCK_DGRAM && eth_=
type_vlan(skb->protocol))) {
> > >> >+                 h.h2->tp_vlan_tci =3D vlan_get_tci(skb, skb->dev)=
;
> > >> >+                 h.h2->tp_vlan_tpid =3D ntohs(skb->protocol);
> > >> >+                 status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> > >> >          } else {
> > >> >                  h.h2->tp_vlan_tci =3D 0;
> > >> >                  h.h2->tp_vlan_tpid =3D 0;
> > >> >@@ -2457,7 +2522,8 @@ static int tpacket_rcv(struct sk_buff *skb, s=
truct net_device *dev,
> > >> >  sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr);
> > >> >  sll->sll_family =3D AF_PACKET;
> > >> >  sll->sll_hatype =3D dev->type;
> > >> >- sll->sll_protocol =3D skb->protocol;
> > >> >+ sll->sll_protocol =3D (sk->sk_type =3D=3D SOCK_DGRAM) ?
> > >> >+         vlan_get_protocol_dgram(skb) : skb->protocol;
> > >> >  sll->sll_pkttype =3D skb->pkt_type;
> > >> >  if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
> > >> >          sll->sll_ifindex =3D orig_dev->ifindex;
> > >> >@@ -3482,7 +3548,8 @@ static int packet_recvmsg(struct socket *sock=
, struct msghdr *msg, size_t len,
> > >> >          /* Original length was stored in sockaddr_ll fields */
> > >> >          origlen =3D PACKET_SKB_CB(skb)->sa.origlen;
> > >> >          sll->sll_family =3D AF_PACKET;
> > >> >-         sll->sll_protocol =3D skb->protocol;
> > >> >+         sll->sll_protocol =3D (sock->type =3D=3D SOCK_DGRAM) ?
> > >> >+                 vlan_get_protocol_dgram(skb) : skb->protocol;
> > >> >  }
> > >> >
> > >> >  sock_recv_cmsgs(msg, sk, skb);
> > >> >@@ -3539,6 +3606,21 @@ static int packet_recvmsg(struct socket *soc=
k, struct msghdr *msg, size_t len,
> > >> >                  aux.tp_vlan_tci =3D skb_vlan_tag_get(skb);
> > >> >                  aux.tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> > >> >                  aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> > >> >+         } else if (unlikely(sock->type =3D=3D SOCK_DGRAM && eth_t=
ype_vlan(skb->protocol))) {
> > >>
> > >> I don't understand why this would be needed here. We spent quite a b=
it
> > >> of efford in the past to make sure vlan header is always stripped.
> > >> Could you fix that in tx path to fulfill the expectation?
> > >
> > >Doesn't that require NETIF_F_HW_VLAN_CTAG_TX?
> > >
> > >I also wondered whether we should just convert the skb for this case
> > >with skb_vlan_untag, to avoid needing new PF_PACKET logic to handle
> > >unstripped tags in the packet socket code. But it seems equally
> > >complex.
> >
> > Correct. skb_vlan_untag() as a preparation of skb before this function
> > is called is exactly what I was suggesting.
>
> It's not necessarily simpler, as that function expects skb->data to
> point to the (outer) VLAN header.
>
> It will pull that one, but not any subsequent ones.
>
> SOCK_DGRAM expects skb->data to point to the network layer header.
> And we only want to make this change for SOCK_DGRAM and if auxdata is
> requested.
>
> Not sure that it will be simpler. But worth a look at least.

Thank you for your suggestion.

I have analyzed the code and considered a feasible approach. We could
call skb_vlan_untag() in packet_rcv before pushing skb into
sk->sk_receive_queue. We would also need to determine if auxdata is
required to maintain performance, which might cause the logic of
judging PACKET_SOCK_AUXDATA to be spread across both the packet_rcv()
and packet_recvmsg() functions.

The skb_vlan_untag() function handles VLANs in a more comprehensive
way, but it seems to have a greater performance impact compared to our
current approach.

As I am not an expert in this domain, I might have overlooked some
important aspects. I would appreciate it if you could share your
thoughts on this decision.

