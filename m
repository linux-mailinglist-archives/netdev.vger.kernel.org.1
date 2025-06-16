Return-Path: <netdev+bounces-197937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6EEADA6C0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 05:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3D87A702F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 03:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4909C13AD1C;
	Mon, 16 Jun 2025 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elQ9Xdih"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB82AD00
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750044061; cv=none; b=nL4DdvR/4HT1Q7rriqOkpvwNYbZdn49SVc79z4Rg1qfysMBUiwf6uVMtnSyFLN1WMfMNDdaklg/NQw2U4zhiQAirbM1wNm1HAGQ6Ehfc7Zlbb/LgxMcbyqM+/5qpKRRS6WEiaBc8hKw3A6dGsCl5ZqAvi8avf3RYnyYDk0bplwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750044061; c=relaxed/simple;
	bh=Xb8ZB+hzl3/PgjKH84Qe0GJ4l9p6RG18ctrJ+WN2ZBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpniCjfDKVd5iwk8Zf5Lopmpo33SUfuZqpRN4sxQubwbjW/eDbdmtyjYqv5vrveV+rK3s+S0UWUDE09FLtYDQLaJH6/YF91MqLMr3E+akF3plKCZZm0wTLmG4gP5blX1JsH1n/AJ0lbh7H+ezxQws68cM846sgIPcUcc3wLdtzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elQ9Xdih; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750044057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkkBksMILzJsHOSEEUzBsixchf0bVF/1eD7X0jYzbYo=;
	b=elQ9XdihFryhq/vusFS/Y8LqLCpRQ6e9TksJliZ3xLgIpJEe2JXigJHP5QwPaLz6SZFi4B
	uyF5XDtCUgWR3sK/LOAThUwaecgz/ST0wcFd6PYM+h+v2jc7OzqO543pYq/vXVGkVNlYRR
	BdGF36D82Kg0P/42Ry/nPYn0G9gN3rc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-MM5aMaWqODejh_s-EShWig-1; Sun, 15 Jun 2025 23:20:54 -0400
X-MC-Unique: MM5aMaWqODejh_s-EShWig-1
X-Mimecast-MFC-AGG-ID: MM5aMaWqODejh_s-EShWig_1750044053
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2f5cb0c101so2777429a12.1
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 20:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750044053; x=1750648853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkkBksMILzJsHOSEEUzBsixchf0bVF/1eD7X0jYzbYo=;
        b=wlcaZ5wLqxHIG4LHi6OwfBXTVCkPmlbbiMT2Jm/kKTUPJ9ZKJ70ki45aCllvG+6lzu
         wTgcruPXmfGefIeMBa7ix/8lmDhoMa/GtxUrlXuKbNUNXJO9NLZAPTkbJ7dyUm80OwWR
         oQxVjgixzpZFDoolLGWAJUzyeeGZ05lyTikM8K8OCP8gdAFr73Jj0+HwssN//j30oJBs
         epLEn3Jf4UyVAQEyTQBTzFv641VahhRTiPm9GvzS8c6Q2TXOMlRhpxGzsxbkdAjAu3qR
         xoZ5twrTG84mnusTeQrLS7/NsO2IpiZQwZsVGJsSJgUG66ebyfpFDE8Beu/fZRg7/peB
         OAgQ==
X-Gm-Message-State: AOJu0YxQD+IIdRpSf9pfzFpw1yYsNlIzsA/ZPgdnm/Uu3ofY5LcQrNgK
	+4DlJp6U95ZtFcri8lBpBYEkT2vDf1Ki/pdEQIfQtbQPXbt89kwZZpL5oNXXgN0myuLfwVhWcLQ
	JA63wUN0KOQYssLhW3lyB6VxBgLT0dHoSCTMMLHqR4duLQ9ophX76DCdcP44r1C66swVAgeWTxw
	ANI5G60pKAFLF3Xshar5mrRmJlO+B+hBE1
X-Gm-Gg: ASbGncsaaqj7/KoDxKswrTyBCgHDyY8YNMCu4bINn1LHBOcrMsczddROL9J54wp3Do3
	nVRpiLmNRVA3UFUqQSyNKx2jswdhQeXudTCvDbae0dDe3zBvBrG2GvSVKvcv9WvjSH++cX3DSLu
	+EPw==
X-Received: by 2002:a05:6a21:9ccb:b0:218:59b:b2f4 with SMTP id adf61e73a8af0-21fbd7b59ecmr8820173637.42.1750044053367;
        Sun, 15 Jun 2025 20:20:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMwbgcnLKrhlTEJEDMFYM1KoYy/fzCWCxZU/fH/gRHgjb1RUZF0CaSe6P5JM6N+6bD/puQ2FH1JTmngw0Qm3k=
X-Received: by 2002:a05:6a21:9ccb:b0:218:59b:b2f4 with SMTP id
 adf61e73a8af0-21fbd7b59ecmr8820140637.42.1750044052956; Sun, 15 Jun 2025
 20:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749210083.git.pabeni@redhat.com> <d10b01bd14473ad95fb8d7f83ab1cd7c40c2a10e.1749210083.git.pabeni@redhat.com>
 <CACGkMEtP5PoxS+=veyQimHB+Mui2+71tpJUYg5UcQCw9BR8yrg@mail.gmail.com> <91fcc95c-8527-4b4c-9c19-6a8dfea010ac@redhat.com>
In-Reply-To: <91fcc95c-8527-4b4c-9c19-6a8dfea010ac@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Jun 2025 11:20:41 +0800
X-Gm-Features: AX0GCFtK1fpwrecqdTrUaDhwaABw3_jK4BmSuV-8MgyVilg1eX-grahMzqYR0Ec
Message-ID: <CACGkMEvTvYsECf8MOtTd7c1-YskUP-3rbec=qHTUuDgNLjPs6w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 6/8] virtio_net: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 6:18=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 6/12/25 6:05 AM, Jason Wang wrote:
> > On Fri, Jun 6, 2025 at 7:46=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >>
> >> If the related virtio feature is set, enable transmission and receptio=
n
> >> of gso over UDP tunnel packets.
> >>
> >> Most of the work is done by the previously introduced helper, just nee=
d
> >> to determine the UDP tunnel features inside the virtio_net_hdr and
> >> update accordingly the virtio net hdr size.
> >>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >> ---
> >> v2 -> v3:
> >>   - drop the VIRTIO_HAS_EXTENDED_FEATURES conditionals
> >>
> >> v1 -> v2:
> >>   - test for UDP_TUNNEL_GSO* only on builds with extended features sup=
port
> >>   - comment indentation cleanup
> >>   - rebased on top of virtio helpers changes
> >>   - dump more information in case of bad offloads
> >> ---
> >>  drivers/net/virtio_net.c | 70 +++++++++++++++++++++++++++++++--------=
-
> >>  1 file changed, 54 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index 18ad50de4928..0b234f318e39 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -78,15 +78,19 @@ static const unsigned long guest_offloads[] =3D {
> >>         VIRTIO_NET_F_GUEST_CSUM,
> >>         VIRTIO_NET_F_GUEST_USO4,
> >>         VIRTIO_NET_F_GUEST_USO6,
> >> -       VIRTIO_NET_F_GUEST_HDRLEN
> >> +       VIRTIO_NET_F_GUEST_HDRLEN,
> >> +       VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED,
> >> +       VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED,
> >>  };
> >>
> >>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) =
| \
> >> -                               (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> >> -                               (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> >> -                               (1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
> >> -                               (1ULL << VIRTIO_NET_F_GUEST_USO4) | \
> >> -                               (1ULL << VIRTIO_NET_F_GUEST_USO6))
> >> +                       (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> >> +                       (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> >> +                       (1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
> >> +                       (1ULL << VIRTIO_NET_F_GUEST_USO4) | \
> >> +                       (1ULL << VIRTIO_NET_F_GUEST_USO6) | \
> >> +                       (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAP=
PED) | \
> >> +                       (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSU=
M_MAPPED))
> >>
> >>  struct virtnet_stat_desc {
> >>         char desc[ETH_GSTRING_LEN];
> >> @@ -436,9 +440,14 @@ struct virtnet_info {
> >>         /* Packet virtio header size */
> >>         u8 hdr_len;
> >>
> >> +       /* UDP tunnel support */
> >> +       u8 tnl_offset;
> >> +
> >>         /* Work struct for delayed refilling if we run low on memory. =
*/
> >>         struct delayed_work refill;
> >>
> >> +       bool rx_tnl_csum;
> >> +
> >>         /* Is delayed refill enabled? */
> >>         bool refill_enabled;
> >>
> >> @@ -2531,14 +2540,22 @@ static void virtnet_receive_done(struct virtne=
t_info *vi, struct receive_queue *
> >>         if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> >>                 virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
> >>
> >> -       if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >> -               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >> +       /* restore the received value */
> >
> > Nit: this comment seems to be redundant
> >
> >> +       hdr->hdr.flags =3D flags;
> >> +       if (virtio_net_chk_data_valid(skb, &hdr->hdr, vi->rx_tnl_csum)=
) {
> >
> > Nit: this function did more than just check DATA_VALID, we probably
> > need a better name.
>
> What about virtio_net_handle_csum_offload()?

Works for me.

>
> >
> >> +               net_warn_ratelimited("%s: bad csum: flags: %x, gso_typ=
e: %x rx_tnl_csum %d\n",
> >> +                                    dev->name, hdr->hdr.flags,
> >> +                                    hdr->hdr.gso_type, vi->rx_tnl_csu=
m);
> >> +               goto frame_err;
> >> +       }
> >>
> >> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> >> -                                 virtio_is_little_endian(vi->vdev))) =
{
> >> -               net_warn_ratelimited("%s: bad gso: type: %u, size: %u\=
n",
> >> +       if (virtio_net_hdr_tnl_to_skb(skb, &hdr->hdr, vi->tnl_offset,
> >
> > I wonder why virtio_net_chk_data_valid() is not part of the
> > virtio_net_hdr_tnl_to_skb().
>
> It can't be part of virtio_net_hdr_tnl_to_skb(), as hdr to skb
> conversion is actually not symmetric with respect to the checksum - only
> the driver handles DATA_VALID.
>
> Tun must not call virtio_net_chk_data_valid()  (or whatever different
> name will use).

Note that we've already dealt with this via introducing a boolean
has_data_valid:

static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
                                          struct virtio_net_hdr *hdr,
                                          bool little_endian,
                                          bool has_data_valid,
                                          int vlan_hlen)

>
> /P
>

Thanks


