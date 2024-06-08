Return-Path: <netdev+bounces-101984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A2A900F4B
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 05:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809A31F21D84
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 03:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D99DDDA;
	Sat,  8 Jun 2024 03:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="couFN0qy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE163C8
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 03:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717816048; cv=none; b=e0fRUKSGgx0fJ8mbbH6lXR1aTF5Pn04tb20MbLddvMVssTwAybKs0WVQoI1TGhVppBrDGr8tvB5InvHRKcynUhY/vW26ec/TUhfSv8Yty+1HWYcy3Sx/iLsYZBRhAVdtAPsByDJHgHUgYUcnB5Q/WbFD6w7JuDVkfhATf6DuIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717816048; c=relaxed/simple;
	bh=YCObB8/eNnw7bH9wygFij4MX3iWIIHfFl8zrZ541hJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mX8eLGxHkHCUpL+89kIEhl2OpTyGkzPZTt/3kVGgxL7+12DwsEH6KZ5byWOdBWP/zeCiBjdozXIvDmq3bRWpqXpstv+nQScqsKbvjlsIuWLVHZMGKlwxxga1Iy40EhsCPWfnkQ9v0OAtUu+TPQ0GOh3f4soiJVywoUeIOlQw9K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=couFN0qy; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D31273F13F
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 03:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717816042;
	bh=SV2i825P+LfRV4oSqK4GX2whZN31Ww/kuL3Go7+NkF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=couFN0qyK24ItZPkjiD6G9BHCVUnVfvxFcMrA+7z2XDvli4vg6wErTKrSI3aM41F3
	 O4GBUpFlK7gJRA3mwAP9q39xOOOuih7xlW8+WjlfP9s6c/6XdNEQ3WZ2NLDKFQXifG
	 0f6KfTIQrKrWEhD81gzqcOWmqe35ela1rWhk/3lr+/BKUnr27HSOsWpHmcdoYA3nSN
	 o5A4upoc9X1Frf28rqmnrjXC9dDodAAZ4vbUvN90Vr4SdfleCqC6BuL+P3Ar3+VB2W
	 S0wWsF/LHYsBeXGJHeufmzpi8IfgC/4ydttBxdmI0F/1/qMY2j0H6qhsNC6wQdF9od
	 +tHcpBJxBeMsA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a68f654dc69so194992866b.1
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 20:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717816042; x=1718420842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV2i825P+LfRV4oSqK4GX2whZN31Ww/kuL3Go7+NkF0=;
        b=oAQ30qVvLO9GJTcUUwCIoEqfd7zSjGaoBVFwyb/chk0ye53LGQe2zM8srIJ6KXS8BJ
         4VESe3gho+N9RVpMHQX8+XrCBx3Y4+XaOG7ACYSYP2qdEOgNtR6D0WCzfdZZ2eFFbC9f
         kPnAid65nStMlv5eIN/7ij8c/Nj0SrhypPWQF5eRyNeM33Abj4XfUcZEd0SEeLZ0VM/k
         X25WdyOL9NYjlcFzHiMpsGoj7w4rDwz7AI6cJk5HyKeyd0Hegu8j7/Ya3ZYh5tT+va69
         qpsIK6JHQooKuAA2N4iHb21SjK8Ha+k8/+qh1GOM2IkS6srhIXa8CZi6bfuuQL7Z2vbe
         kTHA==
X-Forwarded-Encrypted: i=1; AJvYcCVUyRmCpAuQRur51UmoqAToj8YisAWA5VCI8gZl/Pgjwi9Lum38hVv8dvKKQKg7Q9eA/NPKekLsqRQBf9hJlagj3NiFXjok
X-Gm-Message-State: AOJu0Yzgsj5g1dy0K2bKJqNvlyqwB5WlwaDHOLSZpm1VUHkt1IcS8PyR
	Ron5kduk/M9jyXKOWQUgJLSBDORts7N9xY8YyRjXv2nkZJ6Gs71Qevg4RX8SkwiCoyBlIsFD7I1
	SMAsZgmUO1vAKE8VF3iLoKm44xbvl1RgzQiwe8xbs7UsDVMYucOh294Hi5jGI1vhRTPcOIlSy2Q
	hK8FBofxrjmtyRUv+1GiZeaG94rkBqmW85uOzRZYH7ZVHl
X-Received: by 2002:a17:906:1b03:b0:a64:7c8d:96ed with SMTP id a640c23a62f3a-a6cda9ed2f0mr323315866b.54.1717816042185;
        Fri, 07 Jun 2024 20:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXue1qIPWNKzwrSpiUjmwLUVDiz56tiuygGsbdv/rhDZomoHAj8NYz164W5Sz75yNVDi9rmfP6Lri0MY9Uv2M=
X-Received: by 2002:a17:906:1b03:b0:a64:7c8d:96ed with SMTP id
 a640c23a62f3a-a6cda9ed2f0mr323313866b.54.1717816041518; Fri, 07 Jun 2024
 20:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608025347.90680-1-chengen.du@canonical.com>
In-Reply-To: <20240608025347.90680-1-chengen.du@canonical.com>
From: Chengen Du <chengen.du@canonical.com>
Date: Sat, 8 Jun 2024 11:07:10 +0800
Message-ID: <CAPza5qfuNhDbhV9mau9RE=cNKMwGtJcx4pmjkoHNwpfysnw5yw@mail.gmail.com>
Subject: Re: [PATCH v6] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I would like to provide some additional explanations about the patch.


On Sat, Jun 8, 2024 at 10:54=E2=80=AFAM Chengen Du <chengen.du@canonical.co=
m> wrote:
>
> The issue initially stems from libpcap. The ethertype will be overwritten
> as the VLAN TPID if the network interface lacks hardware VLAN offloading.
> In the outbound packet path, if hardware VLAN offloading is unavailable,
> the VLAN tag is inserted into the payload but then cleared from the sk_bu=
ff
> struct. Consequently, this can lead to a false negative when checking for
> the presence of a VLAN tag, causing the packet sniffing outcome to lack
> VLAN tag information (i.e., TCI-TPID). As a result, the packet capturing
> tool may be unable to parse packets as expected.
>
> The TCI-TPID is missing because the prb_fill_vlan_info() function does no=
t
> modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
> payload and not in the sk_buff struct. The skb_vlan_tag_present() functio=
n
> only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
> is stripped, preventing the packet capturing tool from determining the
> correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
> which means the packet capturing tool cannot parse the L3 header correctl=
y.
>
> Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@ca=
nonical.com/T/#u
> Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengen Du <chengen.du@canonical.com>
> ---
>  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index ea3ebc160e25..8cffbe1f912d 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -538,6 +538,43 @@ static void *packet_current_frame(struct packet_sock=
 *po,
>         return packet_lookup_frame(po, rb, rb->head, status);
>  }
>
> +static u16 vlan_get_tci(struct sk_buff *skb)
> +{
> +       struct vlan_hdr vhdr, *vh;
> +       u8 *skb_orig_data =3D skb->data;
> +       int skb_orig_len =3D skb->len;
> +
> +       skb_push(skb, skb->data - skb_mac_header(skb));
> +       vh =3D skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &vhdr);
> +       if (skb_orig_data !=3D skb->data) {
> +               skb->data =3D skb_orig_data;
> +               skb->len =3D skb_orig_len;
> +       }


The reason for not directly using skb_header_pointer(skb,
skb_mac_header(skb) + ETH_HLEN, ...) to get the VLAN header is due to
the check logic in skb_header_pointer. In the SOCK_DGRAM and
PACKET_OUTGOING scenarios, the offset can be a negative number, which
causes the check logic (i.e., likely(hlen - offset >=3D len)) in
__skb_header_pointer() to not work as expected.

While it is possible to modify __skb_header_pointer() to handle cases
where the offset is negative, this change could affect a wider range
of code.

Please kindly share your thoughts on this approach.


> +       if (unlikely(!vh))
> +               return 0;
> +
> +       return ntohs(vh->h_vlan_TCI);
> +}
> +
> +static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> +{
> +       __be16 proto =3D skb->protocol;
> +
> +       if (unlikely(eth_type_vlan(proto))) {
> +               u8 *skb_orig_data =3D skb->data;
> +               int skb_orig_len =3D skb->len;
> +
> +               skb_push(skb, skb->data - skb_mac_header(skb));
> +               proto =3D __vlan_get_protocol(skb, proto, NULL);
> +               if (skb_orig_data !=3D skb->data) {
> +                       skb->data =3D skb_orig_data;
> +                       skb->len =3D skb_orig_len;
> +               }
> +       }
> +
> +       return proto;
> +}
> +
>  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>  {
>         del_timer_sync(&pkc->retire_blk_timer);
> @@ -1007,10 +1044,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_=
core *pkc,
>  static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
>                         struct tpacket3_hdr *ppd)
>  {
> +       struct packet_sock *po =3D container_of(pkc, struct packet_sock, =
rx_ring.prb_bdqc);
> +
>         if (skb_vlan_tag_present(pkc->skb)) {
>                 ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->skb);
>                 ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_proto);
>                 ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> +       } else if (unlikely(po->sk.sk_type =3D=3D SOCK_DGRAM && eth_type_=
vlan(pkc->skb->protocol))) {
> +               ppd->hv1.tp_vlan_tci =3D vlan_get_tci(pkc->skb);
> +               ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->protocol);
> +               ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
>         } else {
>                 ppd->hv1.tp_vlan_tci =3D 0;
>                 ppd->hv1.tp_vlan_tpid =3D 0;
> @@ -2428,6 +2471,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct=
 net_device *dev,
>                         h.h2->tp_vlan_tci =3D skb_vlan_tag_get(skb);
>                         h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_proto);
>                         status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> +               } else if (unlikely(sk->sk_type =3D=3D SOCK_DGRAM && eth_=
type_vlan(skb->protocol))) {
> +                       h.h2->tp_vlan_tci =3D vlan_get_tci(skb);
> +                       h.h2->tp_vlan_tpid =3D ntohs(skb->protocol);
> +                       status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
>                 } else {
>                         h.h2->tp_vlan_tci =3D 0;
>                         h.h2->tp_vlan_tpid =3D 0;
> @@ -2457,7 +2504,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct =
net_device *dev,
>         sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr);
>         sll->sll_family =3D AF_PACKET;
>         sll->sll_hatype =3D dev->type;
> -       sll->sll_protocol =3D skb->protocol;
> +       sll->sll_protocol =3D (sk->sk_type =3D=3D SOCK_DGRAM) ?
> +               vlan_get_protocol_dgram(skb) : skb->protocol;
>         sll->sll_pkttype =3D skb->pkt_type;
>         if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
>                 sll->sll_ifindex =3D orig_dev->ifindex;
> @@ -3482,7 +3530,8 @@ static int packet_recvmsg(struct socket *sock, stru=
ct msghdr *msg, size_t len,
>                 /* Original length was stored in sockaddr_ll fields */
>                 origlen =3D PACKET_SKB_CB(skb)->sa.origlen;
>                 sll->sll_family =3D AF_PACKET;
> -               sll->sll_protocol =3D skb->protocol;
> +               sll->sll_protocol =3D (sock->type =3D=3D SOCK_DGRAM) ?
> +                       vlan_get_protocol_dgram(skb) : skb->protocol;
>         }
>
>         sock_recv_cmsgs(msg, sk, skb);
> @@ -3539,6 +3588,10 @@ static int packet_recvmsg(struct socket *sock, str=
uct msghdr *msg, size_t len,
>                         aux.tp_vlan_tci =3D skb_vlan_tag_get(skb);
>                         aux.tp_vlan_tpid =3D ntohs(skb->vlan_proto);
>                         aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> +               } else if (unlikely(sock->type =3D=3D SOCK_DGRAM && eth_t=
ype_vlan(skb->protocol))) {
> +                       aux.tp_vlan_tci =3D vlan_get_tci(skb);
> +                       aux.tp_vlan_tpid =3D ntohs(skb->protocol);
> +                       aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
>                 } else {
>                         aux.tp_vlan_tci =3D 0;
>                         aux.tp_vlan_tpid =3D 0;
> --
> 2.43.0
>

