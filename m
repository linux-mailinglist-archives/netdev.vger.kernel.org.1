Return-Path: <netdev+bounces-112078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F12934DD6
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6243B20B2E
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C64913C80F;
	Thu, 18 Jul 2024 13:11:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C6513C806
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308302; cv=none; b=s4fKNA/YDkYj6dqhnRq4F01f4cB+6mJW/A1xjLsmyj+U+gWr8eiocsUIf5R/ASt6oC49atn4Wsru+R0G1XqFQJFPKbKN9ucP745Nbj/tYKGv3RPZ6NZcCpR2pumOgc9ox/YFdGzhmb131raKMtekWifWIjGTmdP5KVOmOTzVj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308302; c=relaxed/simple;
	bh=8F91+bwd5UNSlYlbtgiHGL0qf9JVAMjN+dj14ao8eHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JRMggB+LUDOwOhr1lqytWcG81kPd/PTkitL21GWQkaP5hYSBvTgLoQltiGxIuLsaqtr6GJHQi+EdbxbaJ5IkpYU9fJ04hqvORt2meO95gPNrIMHESz9nvcmxtqHeys1Lh95vGfr0LFkcsSa7lOH87YXMmYNrg0Y4ZIyqD1SUxXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-6sY8JhTLNCWnPaVnZJOIOA-1; Thu,
 18 Jul 2024 09:11:33 -0400
X-MC-Unique: 6sY8JhTLNCWnPaVnZJOIOA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BB961955D4E;
	Thu, 18 Jul 2024 13:11:30 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA50E1955F40;
	Thu, 18 Jul 2024 13:11:26 +0000 (UTC)
Date: Thu, 18 Jul 2024 15:11:24 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 10/24] ovpn: implement basic RX path (UDP)
Message-ID: <ZpkUfMtdrsXc-p6k@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-11-antonio@openvpn.net>
 <Zj4k9g1hV1eHQ4Ox@hog>
 <eb9558b3-cd7e-4da6-a496-adca6132a601@openvpn.net>
 <Zpjyg-nO42rA3W_0@hog>
 <10c01ca1-c79a-41ab-b99b-deab81adb552@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <10c01ca1-c79a-41ab-b99b-deab81adb552@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-07-18, 15:06:19 +0200, Antonio Quartulli wrote:
> On 18/07/2024 12:46, Sabrina Dubroca wrote:
> > Sorry Antonio, I'm only coming back to this now.
>=20
> No worries and thanks for fishing this email.
>=20
> >=20
> > 2024-05-10, 16:41:43 +0200, Antonio Quartulli wrote:
> > > On 10/05/2024 15:45, Sabrina Dubroca wrote:
> > > > 2024-05-06, 03:16:23 +0200, Antonio Quartulli wrote:
> > > > > diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> > > > > index 36cfb95edbf4..9935a863bffe 100644
> > > > > --- a/drivers/net/ovpn/io.c
> > > > > +++ b/drivers/net/ovpn/io.c
> > > > > +/* Called after decrypt to write the IP packet to the device.
> > > > > + * This method is expected to manage/free the skb.
> > > > > + */
> > > > > +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_=
buff *skb)
> > > > > +{
> > > > > +=09/* packet integrity was verified on the VPN layer - no need t=
o perform
> > > > > +=09 * any additional check along the stack
> > > >=20
> > > > But it could have been corrupted before it got into the VPN?
> > >=20
> > > It could, but I believe a VPN should only take care of integrity alon=
g its
> > > tunnel (and this is guaranteed by the OpenVPN protocol).
> > > If something corrupted enters the tunnel, we will just deliver it as =
is to
> > > the other end. Upper layers (where the corruption actually happened) =
have to
> > > deal with that.
> >=20
> > I agree with that, but I don't think that's what CHECKSUM_UNNECESSARY
> > (especially with csum_level =3D MAX) would do. CHECKSUM_UNNECESSARY
> > tells the networking stack that the checksum has been verified (up to
> > csum_level+1, so 0 means the first level of TCP/UDP type headers has
> > been validated):
> >=20
> > // include/linux/skbuff.h
> >=20
> >   * - %CHECKSUM_UNNECESSARY
> >   *
> >   *   The hardware you're dealing with doesn't calculate the full check=
sum
> >   *   (as in %CHECKSUM_COMPLETE), but it does parse headers and verify =
checksums
> >   *   for specific protocols. For such packets it will set %CHECKSUM_UN=
NECESSARY
> >   *   if their checksums are okay.
> >=20
> >   *   &sk_buff.csum_level indicates the number of consecutive checksums=
 found in
> >   *   the packet minus one that have been verified as %CHECKSUM_UNNECES=
SARY.
> >   *   For instance if a device receives an IPv6->UDP->GRE->IPv4->TCP pa=
cket
> >   *   and a device is able to verify the checksums for UDP (possibly ze=
ro),
> >   *   GRE (checksum flag is set) and TCP, &sk_buff.csum_level would be =
set to
> >   *   two. If the device were only able to verify the UDP checksum and =
not
> >   *   GRE, either because it doesn't support GRE checksum or because GR=
E
> >   *   checksum is bad, skb->csum_level would be set to zero (TCP checks=
um is
> >   *   not considered in this case).
> >=20
> > I think you want CHECKSUM_NONE:
> >=20
> >   *   Device did not checksum this packet e.g. due to lack of capabilit=
ies.
> >=20
> > Then the stack will check if the packet was corrupted.
>=20
> I went back to the wireguard code, which I used for inspiration for this
> specific part (we are dealing with the same problem here):
>=20
> https://elixir.bootlin.com/linux/v6.10/source/drivers/net/wireguard/recei=
ve.c#L376
>=20
> basically the idea is: with our encapsulation we can guarantee that what
> entered the tunnel is also exiting the tunnel, without corruption.
> Therefore we claim that checksums are all correct.

Can you be sure that they were correct when they went into the tunnel?
If not, I think you have to set CHECKSUM_NONE.

--=20
Sabrina


