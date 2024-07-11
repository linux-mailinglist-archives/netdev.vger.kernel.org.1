Return-Path: <netdev+bounces-110717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D2392DE5F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 04:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA941F21E2D
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 02:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E0FC129;
	Thu, 11 Jul 2024 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="L613fLYY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E838D512
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 02:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665245; cv=none; b=LrDGPWbETvMdSO7e87pqr0/x2Zx//v9bLC26PFCJoXYnCcMvu6AlS1CA2+JVNIWTmCIb6MqKP+/6iM4es5j5BD7Wq+8Tvy7/uTplOBd/CqM5LfOtc+v1r0OZE39sE0jlIJe/DQY4dMAetCcDBhu7jeS9S0rQXGTXcP+VaCNv3RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665245; c=relaxed/simple;
	bh=Zza7HMru+afXnNzFQ89OfFXWt0Dm/KHqgl5j9g8x40Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lam37KbrL8377NvzXfk65mB781MIWHoCxHTqx2e6tg4HgCF/NMKl9jIBA6vOJKKcAEv8rKisYrPQg1TnRYABrHSt4ZMWk1bk26lNgurHbJcDXiOXPME0iPw8mKJdxMxCkBwclj6p+Hzs4sVA56lvR4mFVUZ8jUu/lRjeTI0M7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=L613fLYY; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E58173F42E
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 02:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720665238;
	bh=qtD7p00bOLCnUQsPR58KZ6QvTu7RksJRr8D5W3n7NiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=L613fLYYlgeJssAYaY9yV+D2MbZ+BDxB6Wp9wDsRUnnTBc4Ig9kogN9cgd6x9sIXK
	 8UKorvJgahWmJTiVpaORH0pOLb26QjDV3Yp8ZM7kRNOfolf7aLSI1MpmlWqNxNgu8V
	 u37gyGWrXpRzk8SCgAjtkyvs5xKsFnZZhmJm4HvZk1Xv0bWYgIKqQj0fLXkAwYYCRR
	 qC0k2HsFas3G8xsCMX82FqCIk3d8L3/HqaJrV08fdynOqs/t9R48IH6MHw4pCPN7s2
	 Lq0T6fKAnBSTEntd/cD+bPAy9YLUawQ0AJj2kyYrjQ+/UcNCgxhXmThzbkPRLACsHs
	 mJlt9bwPeoVJg==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77de2c6583so24387966b.0
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 19:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720665238; x=1721270038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtD7p00bOLCnUQsPR58KZ6QvTu7RksJRr8D5W3n7NiY=;
        b=OzI7kS0mZjacvENRgrIjng2zpMT4tszDs91IgaC+A7UOQHh3Z2COqj+awS5mmS4Usy
         nLDXkixv9WHtQ5w2z/5xzmdlPo8HxC9MIuHRXDRq6P801l0+wCqv05JBYy/jdL19qS6L
         feFSbDaiFZii/lvkznR1iPeKH1E3fhzQ4inuiPR/FfzyWv+ouyOScAf4uqgv736Z+ENK
         pjFiV9AHHilTpVeba8e2TQdu1YO1P4HXDnPKSe0ztElH9pGTdT4yxMnCT+e8TR//RXtO
         Zkgtf2xh7EbIaqlCIU1gcGPplUh7aWwl5BQkL43LLu4n4aI0IZTKhfDLgGRIzEi+Msx0
         X6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCIhWlGevxkmQvaHlmXmNdFmvGO1ffXdR5MvEAR8ICPyvKj6zW3RER2TiXc5r+ob3J5na3fDuIlnMdmxEvz4na0x+vJgsk
X-Gm-Message-State: AOJu0YwvZQKotnx5K6QalD0wvRIf1EGoBOdpBNzdyAQuz7LjWdpk80Re
	LdRlspiIsGQmJx6X2PqvG2oiCxNhvF/yshjmZaLezVRHnE+pVc+AKLq/J29/fmDsdfio3oTRThP
	DW2VTQzip+pIQJD50+T4bITtVRwtt1VpPRidMZW5G1HNWssQ5nEAVQH5D9KrLNVNfxijh3gqRbn
	r5ihwLdnkNQoJ5LYzluVQjYjj6ZEnh9YXa7MOIxoWugw1R
X-Received: by 2002:a17:906:4c57:b0:a6f:ab9c:7778 with SMTP id a640c23a62f3a-a780b6fd1e3mr459595366b.34.1720665238113;
        Wed, 10 Jul 2024 19:33:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEICvsPD94BhayUA82kagKaGmrWFaOQeS+h4xhHQxr08gVMcrERmVAZtimTn5i5m+2OIvmBtqiwgLOiJLW4zfw=
X-Received: by 2002:a17:906:4c57:b0:a6f:ab9c:7778 with SMTP id
 a640c23a62f3a-a780b6fd1e3mr459593666b.34.1720665237669; Wed, 10 Jul 2024
 19:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617054514.127961-1-chengen.du@canonical.com>
 <ZnAdiDjI_unrELB8@nanopsycho.orion> <6670898e1ca78_21d16f2946f@willemb.c.googlers.com.notmuch>
 <ZnEmiIhs5K4ehcYH@nanopsycho.orion> <66715247c147c_23a4e7294a7@willemb.c.googlers.com.notmuch>
 <CAPza5qfQtPZ-UPF97CG+zEwoQunbzg8F8kX0Q1y5Fzt4Zoc=4w@mail.gmail.com>
 <6673dc0ee45dd_2a03042941e@willemb.c.googlers.com.notmuch>
 <CAPza5qfqoJeSe3=nEuMAhWygiu0+N3v2Qe1TPB1eywMEyfGLrw@mail.gmail.com> <66794d8c1d425_3637da294d8@willemb.c.googlers.com.notmuch>
In-Reply-To: <66794d8c1d425_3637da294d8@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Thu, 11 Jul 2024 10:33:46 +0800
Message-ID: <CAPza5qeh+vDAv_Xe5Duz53GFDef2UNxSdPAbgivk=XmdVkJbMQ@mail.gmail.com>
Subject: Re: [PATCH v8] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 6:42=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Chengen Du wrote:
> > On Thu, Jun 20, 2024 at 3:36=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Chengen Du wrote:
> > > > On Tue, Jun 18, 2024 at 5:24=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jiri Pirko wrote:
> > > > > > Mon, Jun 17, 2024 at 09:07:58PM CEST, willemdebruijn.kernel@gma=
il.com wrote:
> > > > > > >Jiri Pirko wrote:
> > > > > > >> Mon, Jun 17, 2024 at 07:45:14AM CEST, chengen.du@canonical.c=
om wrote:
> > > > > > >> >The issue initially stems from libpcap. The ethertype will =
be overwritten
> > > > > > >> >as the VLAN TPID if the network interface lacks hardware VL=
AN offloading.
> > > > > > >> >In the outbound packet path, if hardware VLAN offloading is=
 unavailable,
> > > > > > >> >the VLAN tag is inserted into the payload but then cleared =
from the sk_buff
> > > > > > >> >struct. Consequently, this can lead to a false negative whe=
n checking for
> > > > > > >> >the presence of a VLAN tag, causing the packet sniffing out=
come to lack
> > > > > > >> >VLAN tag information (i.e., TCI-TPID). As a result, the pac=
ket capturing
> > > > > > >> >tool may be unable to parse packets as expected.
> > > > > > >> >
> > > > > > >> >The TCI-TPID is missing because the prb_fill_vlan_info() fu=
nction does not
> > > > > > >> >modify the tp_vlan_tci/tp_vlan_tpid values, as the informat=
ion is in the
> > > > > > >> >payload and not in the sk_buff struct. The skb_vlan_tag_pre=
sent() function
> > > > > > >> >only checks vlan_all in the sk_buff struct. In cooked mode,=
 the L2 header
> > > > > > >> >is stripped, preventing the packet capturing tool from dete=
rmining the
> > > > > > >> >correct TCI-TPID value. Additionally, the protocol in SLL i=
s incorrect,
> > > > > > >> >which means the packet capturing tool cannot parse the L3 h=
eader correctly.
> > > > > > >> >
> > > > > > >> >Link: https://github.com/the-tcpdump-group/libpcap/issues/1=
105
> > > > > > >> >Link: https://lore.kernel.org/netdev/20240520070348.26725-1=
-chengen.du@canonical.com/T/#u
> > > > > > >> >Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace=
")
> > > > > > >> >Cc: stable@vger.kernel.org
> > > > > > >> >Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > > > > > >> >---
> > > > > > >> > net/packet/af_packet.c | 86 ++++++++++++++++++++++++++++++=
+++++++++++-
> > > > > > >> > 1 file changed, 84 insertions(+), 2 deletions(-)
> > > > > > >> >
> > > > > > >> >diff --git a/net/packet/af_packet.c b/net/packet/af_packet.=
c
> > > > > > >> >index ea3ebc160e25..84e8884a77e3 100644
> > > > > > >> >--- a/net/packet/af_packet.c
> > > > > > >> >+++ b/net/packet/af_packet.c
> > > > > > >> >@@ -538,6 +538,61 @@ static void *packet_current_frame(stru=
ct packet_sock *po,
> > > > > > >> >  return packet_lookup_frame(po, rb, rb->head, status);
> > > > > > >> > }
> > > > > > >> >
> > > > > > >> >+static u16 vlan_get_tci(struct sk_buff *skb, struct net_de=
vice *dev)
> > > > > > >> >+{
> > > > > > >> >+ struct vlan_hdr vhdr, *vh;
> > > > > > >> >+ u8 *skb_orig_data =3D skb->data;
> > > > > > >> >+ int skb_orig_len =3D skb->len;
> > > > > > >> >+ unsigned int header_len;
> > > > > > >> >+
> > > > > > >> >+ if (!dev)
> > > > > > >> >+         return 0;
> > > > > > >> >+
> > > > > > >> >+ /* In the SOCK_DGRAM scenario, skb data starts at the net=
work
> > > > > > >> >+  * protocol, which is after the VLAN headers. The outer V=
LAN
> > > > > > >> >+  * header is at the hard_header_len offset in non-variabl=
e
> > > > > > >> >+  * length link layer headers. If it's a VLAN device, the
> > > > > > >> >+  * min_header_len should be used to exclude the VLAN head=
er
> > > > > > >> >+  * size.
> > > > > > >> >+  */
> > > > > > >> >+ if (dev->min_header_len =3D=3D dev->hard_header_len)
> > > > > > >> >+         header_len =3D dev->hard_header_len;
> > > > > > >> >+ else if (is_vlan_dev(dev))
> > > > > > >> >+         header_len =3D dev->min_header_len;
> > > > > > >> >+ else
> > > > > > >> >+         return 0;
> > > > > > >> >+
> > > > > > >> >+ skb_push(skb, skb->data - skb_mac_header(skb));
> > > > > > >> >+ vh =3D skb_header_pointer(skb, header_len, sizeof(vhdr), =
&vhdr);
> > > > > > >> >+ if (skb_orig_data !=3D skb->data) {
> > > > > > >> >+         skb->data =3D skb_orig_data;
> > > > > > >> >+         skb->len =3D skb_orig_len;
> > > > > > >> >+ }
> > > > > > >> >+ if (unlikely(!vh))
> > > > > > >> >+         return 0;
> > > > > > >> >+
> > > > > > >> >+ return ntohs(vh->h_vlan_TCI);
> > > > > > >> >+}
> > > > > > >> >+
> > > > > > >> >+static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> > > > > > >> >+{
> > > > > > >> >+ __be16 proto =3D skb->protocol;
> > > > > > >> >+
> > > > > > >> >+ if (unlikely(eth_type_vlan(proto))) {
> > > > > > >> >+         u8 *skb_orig_data =3D skb->data;
> > > > > > >> >+         int skb_orig_len =3D skb->len;
> > > > > > >> >+
> > > > > > >> >+         skb_push(skb, skb->data - skb_mac_header(skb));
> > > > > > >> >+         proto =3D __vlan_get_protocol(skb, proto, NULL);
> > > > > > >> >+         if (skb_orig_data !=3D skb->data) {
> > > > > > >> >+                 skb->data =3D skb_orig_data;
> > > > > > >> >+                 skb->len =3D skb_orig_len;
> > > > > > >> >+         }
> > > > > > >> >+ }
> > > > > > >> >+
> > > > > > >> >+ return proto;
> > > > > > >> >+}
> > > > > > >> >+
> > > > > > >> > static void prb_del_retire_blk_timer(struct tpacket_kbdq_c=
ore *pkc)
> > > > > > >> > {
> > > > > > >> >  del_timer_sync(&pkc->retire_blk_timer);
> > > > > > >> >@@ -1007,10 +1062,16 @@ static void prb_clear_rxhash(struct=
 tpacket_kbdq_core *pkc,
> > > > > > >> > static void prb_fill_vlan_info(struct tpacket_kbdq_core *p=
kc,
> > > > > > >> >                  struct tpacket3_hdr *ppd)
> > > > > > >> > {
> > > > > > >> >+ struct packet_sock *po =3D container_of(pkc, struct packe=
t_sock, rx_ring.prb_bdqc);
> > > > > > >> >+
> > > > > > >> >  if (skb_vlan_tag_present(pkc->skb)) {
> > > > > > >> >          ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->sk=
b);
> > > > > > >> >          ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_pr=
oto);
> > > > > > >> >          ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> > > > > > >> >+ } else if (unlikely(po->sk.sk_type =3D=3D SOCK_DGRAM && e=
th_type_vlan(pkc->skb->protocol))) {
> > > > > > >> >+         ppd->hv1.tp_vlan_tci =3D vlan_get_tci(pkc->skb, p=
kc->skb->dev);
> > > > > > >> >+         ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->protoco=
l);
> > > > > > >> >+         ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> > > > > > >> >  } else {
> > > > > > >> >          ppd->hv1.tp_vlan_tci =3D 0;
> > > > > > >> >          ppd->hv1.tp_vlan_tpid =3D 0;
> > > > > > >> >@@ -2428,6 +2489,10 @@ static int tpacket_rcv(struct sk_buf=
f *skb, struct net_device *dev,
> > > > > > >> >                  h.h2->tp_vlan_tci =3D skb_vlan_tag_get(sk=
b);
> > > > > > >> >                  h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_pr=
oto);
> > > > > > >> >                  status |=3D TP_STATUS_VLAN_VALID | TP_STA=
TUS_VLAN_TPID_VALID;
> > > > > > >> >+         } else if (unlikely(sk->sk_type =3D=3D SOCK_DGRAM=
 && eth_type_vlan(skb->protocol))) {
> > > > > > >> >+                 h.h2->tp_vlan_tci =3D vlan_get_tci(skb, s=
kb->dev);
> > > > > > >> >+                 h.h2->tp_vlan_tpid =3D ntohs(skb->protoco=
l);
> > > > > > >> >+                 status |=3D TP_STATUS_VLAN_VALID | TP_STA=
TUS_VLAN_TPID_VALID;
> > > > > > >> >          } else {
> > > > > > >> >                  h.h2->tp_vlan_tci =3D 0;
> > > > > > >> >                  h.h2->tp_vlan_tpid =3D 0;
> > > > > > >> >@@ -2457,7 +2522,8 @@ static int tpacket_rcv(struct sk_buff=
 *skb, struct net_device *dev,
> > > > > > >> >  sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr);
> > > > > > >> >  sll->sll_family =3D AF_PACKET;
> > > > > > >> >  sll->sll_hatype =3D dev->type;
> > > > > > >> >- sll->sll_protocol =3D skb->protocol;
> > > > > > >> >+ sll->sll_protocol =3D (sk->sk_type =3D=3D SOCK_DGRAM) ?
> > > > > > >> >+         vlan_get_protocol_dgram(skb) : skb->protocol;
> > > > > > >> >  sll->sll_pkttype =3D skb->pkt_type;
> > > > > > >> >  if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
> > > > > > >> >          sll->sll_ifindex =3D orig_dev->ifindex;
> > > > > > >> >@@ -3482,7 +3548,8 @@ static int packet_recvmsg(struct sock=
et *sock, struct msghdr *msg, size_t len,
> > > > > > >> >          /* Original length was stored in sockaddr_ll fiel=
ds */
> > > > > > >> >          origlen =3D PACKET_SKB_CB(skb)->sa.origlen;
> > > > > > >> >          sll->sll_family =3D AF_PACKET;
> > > > > > >> >-         sll->sll_protocol =3D skb->protocol;
> > > > > > >> >+         sll->sll_protocol =3D (sock->type =3D=3D SOCK_DGR=
AM) ?
> > > > > > >> >+                 vlan_get_protocol_dgram(skb) : skb->proto=
col;
> > > > > > >> >  }
> > > > > > >> >
> > > > > > >> >  sock_recv_cmsgs(msg, sk, skb);
> > > > > > >> >@@ -3539,6 +3606,21 @@ static int packet_recvmsg(struct soc=
ket *sock, struct msghdr *msg, size_t len,
> > > > > > >> >                  aux.tp_vlan_tci =3D skb_vlan_tag_get(skb)=
;
> > > > > > >> >                  aux.tp_vlan_tpid =3D ntohs(skb->vlan_prot=
o);
> > > > > > >> >                  aux.tp_status |=3D TP_STATUS_VLAN_VALID |=
 TP_STATUS_VLAN_TPID_VALID;
> > > > > > >> >+         } else if (unlikely(sock->type =3D=3D SOCK_DGRAM =
&& eth_type_vlan(skb->protocol))) {
> > > > > > >>
> > > > > > >> I don't understand why this would be needed here. We spent q=
uite a bit
> > > > > > >> of efford in the past to make sure vlan header is always str=
ipped.
> > > > > > >> Could you fix that in tx path to fulfill the expectation?
> > > > > > >
> > > > > > >Doesn't that require NETIF_F_HW_VLAN_CTAG_TX?
> > > > > > >
> > > > > > >I also wondered whether we should just convert the skb for thi=
s case
> > > > > > >with skb_vlan_untag, to avoid needing new PF_PACKET logic to h=
andle
> > > > > > >unstripped tags in the packet socket code. But it seems equall=
y
> > > > > > >complex.
> > > > > >
> > > > > > Correct. skb_vlan_untag() as a preparation of skb before this f=
unction
> > > > > > is called is exactly what I was suggesting.
> > > > >
> > > > > It's not necessarily simpler, as that function expects skb->data =
to
> > > > > point to the (outer) VLAN header.
> > > > >
> > > > > It will pull that one, but not any subsequent ones.
> > > > >
> > > > > SOCK_DGRAM expects skb->data to point to the network layer header=
.
> > > > > And we only want to make this change for SOCK_DGRAM and if auxdat=
a is
> > > > > requested.
> > > > >
> > > > > Not sure that it will be simpler. But worth a look at least.
> > > >
> > > > Thank you for your suggestion.
> > > >
> > > > I have analyzed the code and considered a feasible approach. We cou=
ld
> > > > call skb_vlan_untag() in packet_rcv before pushing skb into
> > > > sk->sk_receive_queue.
> > >
> > > Only for SOCK_DGRAM.
> > >
> > > And there is some user risk, as they will see different packets on
> > > the same devices as before. A robust program should work for both
> > > vlan stripped and unstripped, and the unstripped case is already
> > > broken wrt sll_protocol returned, so I suppose this is acceptable.
> > >
> > > > We would also need to determine if auxdata is
> > > > required to maintain performance, which might cause the logic of
> > > > judging PACKET_SOCK_AUXDATA to be spread across both the packet_rcv=
()
> > > > and packet_recvmsg() functions.
> > >
> > > You mean to only make the above change if SOCK_DGRAM and auxdata is
> > > requested?
> >
> > Yes, we can constrain the performance overhead to specific scenarios th=
is way.
> >
> > >
> > > Btw, also tpacket_rcv, where auxdata is always returned.
> > >
> > > > The skb_vlan_untag() function handles VLANs in a more comprehensive
> > > > way, but it seems to have a greater performance impact compared to =
our
> > > > current approach.
> > >
> > > I was afraid of that too. The skb_share_check is fine, as this also
> > > exists in packet_rcv, before we would call skb_vlan_untag.
> > >
> > > A bigger issue: this only pulls the outer tag. So we still need to
> > > handle the vlan stacking case correctly manually.
> >
> > It seems we are on the same page. The need to manually handle VLAN
> > stacking is a significant concern. Since the code is in the critical
> > path, we must carefully manage the performance overhead. Given that
> > the current method is more efficient than calling skb_vlan_untag(), I
> > propose retaining the patch as is. Please let me know if there are any
> > other concerns.
>
> I agree.

I apologize for any inconvenience. May I ask when this patch will be
merged? Or is there anything I need to do to help the patch proceed?

