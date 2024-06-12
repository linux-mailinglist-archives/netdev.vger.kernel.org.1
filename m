Return-Path: <netdev+bounces-102813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21801904E6B
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 10:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF5E2845FC
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD616D4DA;
	Wed, 12 Jun 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oNDsTNQ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050C757F8
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182043; cv=none; b=DRdNTStcy2bX1/rJUaVRO/hY/qW3k4M47/MYvmrwJzqfYbts015vM2Xcd4NVW6H3uVQFVA2InNw2Vee9DPuMT5kvm9Aw3RtpnIRzxpMBhEVZXfK6xeSOqDXpekiz4MaXwilyVkavmgwgzAgAjNMRO8CQ5LAyydze7EN05S7FcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182043; c=relaxed/simple;
	bh=NCqG+cxi6ENhun4XB9fyg9tID2Z5hfw1lyoqEHgbieA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gx2FzpydJZ5S0eSgPXmbMdSZCHUa/4cCaJjraYZwzgkxUYc+7tvD1gT02qc9qTNGEXQ55CP/xC1iPWZrEthX7N8Nje6gWS5e7+uPeRl1irMjoatHQnV7Rj0r4KyAwi/BJ+Hiv4mozx7tLf/ti1++Z4ygjJoMTcu7DDXkVapanYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oNDsTNQ3; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA4F540C8B
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 08:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718182035;
	bh=QCgoiR1FNu5yMhX4TrSw5jXqsK7VlpYhCw5LiGx0UTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=oNDsTNQ39Miyzb1rfPZHFE/SvDDYE24q2GWHz9a5wWE3YMJMSyGVYb5DWlehniF9y
	 e/szz5NoIaLneZSzYrsSJw8kphxflTlpmf66gfM95lDPdW6fSDgQtyBdof9A+HBG7p
	 Q0VB9+OR8F19Upd4nOx1ewRBIWONQKU/4g7bXNPL9OXlS9Uf8O/pGmTevGarbtnvby
	 Rww5uYatvnrLmLGV9a0SaSCj0IUx85VVmLfGi8+LjDtZ9h5o/KpEmUI8StNB0huy0W
	 obfFtI+9ubZ1vsvSZ8SrEtS1Rv2mxkLKv3gctRS9+i938QoOrNwTcSrk1LdVZtXoY5
	 gtWz3iPunXiQw==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ebe9c0ac47so26141841fa.0
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 01:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718182035; x=1718786835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCgoiR1FNu5yMhX4TrSw5jXqsK7VlpYhCw5LiGx0UTk=;
        b=jgFA1BS2i+agGLZMXlVUqur7cfiKmE/C3sG/qNiLQVckNNWha2SZomic/MBpv/dJhF
         TN3xw4pltYrKPFRalV0VSTeLz213fYSMpUMScl+leDvWHFIpEGBVW13ZmzsPpr8u5VL6
         YbtmIxzD0SeBG45HN7kcYjue9x//R2QecitDeQBa+DKgZA4zYLz3CuBeZSuPBXZEHPxo
         bJiNqTF7tjIB4xYAlolpD9RN2QKEdkQBZYHBXoFNp/G0Mkw7YLioNlY10pQinlzsPg9M
         YlsqXPFIfYMW5E0brBbDk29nd4stK06lkVkS51iBPWcdlbaPHO8U+y5H57g1KML/msZW
         ZqTA==
X-Forwarded-Encrypted: i=1; AJvYcCWoPqgnDk6z5V5qJxPbNmWm5Y4I5v03bxZVdlV0IE/HKHAyZGQbD17umZrm2nmOm0MXfpjbTqfxBOP7F9lLUI21Hm4Gle1W
X-Gm-Message-State: AOJu0YwhJRT2YV5KcMuAIaaXyHbC3xFLG5kDE+lYRXEetPzkcX99ySWf
	Huqt42pveK7wmbLQj1FhyAnfJ4mcKU+kPOvwgAeuLGlCRxN7HB/j72m+pM716/mT7SugPSnK2D7
	bJSFB++CUlVXknHuOIVIyzoL25mTJ/YjEp75H4UeGkvT1XYDM7N6c2VVHK9BRY+rJDyXitNiaXA
	K1URTja06gg2CmCXoauhKjnhi8MhbmmlksBXosu0V3JNZ7
X-Received: by 2002:a2e:8608:0:b0:2eb:e9bb:ba16 with SMTP id 38308e7fff4ca-2ebfca3418dmr8920971fa.38.1718182035282;
        Wed, 12 Jun 2024 01:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUSS0J0jX8Cu9Zc/Ts8VtHtZf93LRYh78QU3x5Uaf5MhWK7nrOT/wgMTxXLkTVxy8EiGeoQQx2V+zw/gZKA3s=
X-Received: by 2002:a2e:8608:0:b0:2eb:e9bb:ba16 with SMTP id
 38308e7fff4ca-2ebfca3418dmr8920651fa.38.1718182034230; Wed, 12 Jun 2024
 01:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608025347.90680-1-chengen.du@canonical.com>
 <66660e3cd5636_8dbbb294c@willemb.c.googlers.com.notmuch> <CAPza5qfVzV7NFiVY1jcZR-+0ey-uKgUjV6OcjmDFvKG3T-2SXA@mail.gmail.com>
 <666789d3d9d2a_bf52c294e9@willemb.c.googlers.com.notmuch>
In-Reply-To: <666789d3d9d2a_bf52c294e9@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Wed, 12 Jun 2024 16:47:02 +0800
Message-ID: <CAPza5qe8KAjjZsZdTupXx27kvdPzhBNcDC=Nk5Xjc4O2obEAAA@mail.gmail.com>
Subject: Re: [PATCH v6] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

On Tue, Jun 11, 2024 at 7:18=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Chengen Du wrote:
> > Hi Willem,
> >
> > I'm sorry, but I would like to confirm the issue further.
> >
> > On Mon, Jun 10, 2024 at 4:19=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Chengen Du wrote:
> > > > The issue initially stems from libpcap. The ethertype will be overw=
ritten
> > > > as the VLAN TPID if the network interface lacks hardware VLAN offlo=
ading.
> > > > In the outbound packet path, if hardware VLAN offloading is unavail=
able,
> > > > the VLAN tag is inserted into the payload but then cleared from the=
 sk_buff
> > > > struct. Consequently, this can lead to a false negative when checki=
ng for
> > > > the presence of a VLAN tag, causing the packet sniffing outcome to =
lack
> > > > VLAN tag information (i.e., TCI-TPID). As a result, the packet capt=
uring
> > > > tool may be unable to parse packets as expected.
> > > >
> > > > The TCI-TPID is missing because the prb_fill_vlan_info() function d=
oes not
> > > > modify the tp_vlan_tci/tp_vlan_tpid values, as the information is i=
n the
> > > > payload and not in the sk_buff struct. The skb_vlan_tag_present() f=
unction
> > > > only checks vlan_all in the sk_buff struct. In cooked mode, the L2 =
header
> > > > is stripped, preventing the packet capturing tool from determining =
the
> > > > correct TCI-TPID value. Additionally, the protocol in SLL is incorr=
ect,
> > > > which means the packet capturing tool cannot parse the L3 header co=
rrectly.
> > > >
> > > > Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > > > Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen=
.du@canonical.com/T/#u
> > > > Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > >
> > > Overall, solid.
> > >
> > > > ---
> > > >  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++++++=
++--
> > > >  1 file changed, 55 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > > index ea3ebc160e25..8cffbe1f912d 100644
> > > > --- a/net/packet/af_packet.c
> > > > +++ b/net/packet/af_packet.c
> > > > @@ -538,6 +538,43 @@ static void *packet_current_frame(struct packe=
t_sock *po,
> > > >       return packet_lookup_frame(po, rb, rb->head, status);
> > > >  }
> > > >
> > > > +static u16 vlan_get_tci(struct sk_buff *skb)
> > > > +{
> > > > +     struct vlan_hdr vhdr, *vh;
> > > > +     u8 *skb_orig_data =3D skb->data;
> > > > +     int skb_orig_len =3D skb->len;
> > > > +
> > > > +     skb_push(skb, skb->data - skb_mac_header(skb));
> > > > +     vh =3D skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &vhdr)=
;
> > >
> > > Don't harcode Ethernet.
> > >
> > > According to documentation VLANs are used with other link layers.
> > >
> > > More importantly, in practice PF_PACKET allows inserting this
> > > skb->protocol on any device.
> > >
> > > We don't use link layer specific constants anywhere in the packet
> > > socket code for this reason. But instead dev->hard_header_len.
> > >
> > > One caveat there is variable length link layer headers, where
> > > dev->min_header_len !=3D dev->hard_header_len. Will just have to fail
> > > on those.
> >
> > Thank you for pointing out this error. I would like to confirm if I
> > need to use dev->hard_header_len to get the correct header length and
> > return zero if dev->min_header_len !=3D dev->hard_header_len to handle
> > variable-length link layer headers. Is there something I
> > misunderstand, or are there other aspects I need to consider further?
>
> That's right.
>
> The min_header_len !=3D hard_header_len check is annoying and may seem
> pedantic. But it's the only way to trust that the next header starts
> at hard_header_len.

Thank you for your advice.
I have implemented the modification, but I found that the
(min_header_len !=3D hard_header_len) check results in unexpected
behavior in the following test scenario:
    ip link add link ens18 ens18.24 type vlan proto 802.1ad id 24
    ip link add link ens18.24 ens18.24.25 type vlan proto 802.1Q id 25
    ifconfig ens18.24 1.0.24.1/24
    ifconfig ens18.24.25 1.0.25.1/24
    ping -n 1.0.25.3 > /dev/null 2>&1 &
    tcpdump -nn -i any -y LINUX_SLL -Q out not tcp and not udp

While receiving a packet from ens18.24.25 (802.1Q), the min_header_len
and hard_header_len are 14 and 18, respectively.
This check results in the TCI being 0 instead of 25.
Should we skip this check to display the correct value, or is there
another check that can achieve the same purpose?

