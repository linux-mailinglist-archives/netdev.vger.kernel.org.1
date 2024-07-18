Return-Path: <netdev+bounces-112050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAB5934BE1
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB06C1F21A03
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69FF80C13;
	Thu, 18 Jul 2024 10:46:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E257E8
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299601; cv=none; b=ebcyha4oF1nDrzEaY9Gk/3UptP5iQlEbUvB630snqzrv9xtSk0+xpFVgDnnqSNxRzRp1CU/ZA9f9y/BnvA+gXRWrC3XmL0oKpdHviX2FT/h/nyTuT6qDf9X0AsMJcu2H4kGUGqMI1zbZWxU3IvQSMsKoPlLMjelsZ5ZhwIjR5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299601; c=relaxed/simple;
	bh=zAzEAPdghyyCZne/ZHv8jRb/7L4WxfE2nzPerbgBjZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QnBa7eNQL31RCz284AtBjAGIdN99Kjc0VLVn/ryc8WQcdp1Hj9/4pk8Y1KxOxYvpunYebno06EUJLdE+zNtYNgA5hN33X8ADCSGqJc6sTf3g2hGf32pJDCrSGvLSdAuPmoSXQuo0BED3r8fdHFRGL5zp+2HLBo3Hrb4OdaVToe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-FggzwLMeOuStl-H22AqoqA-1; Thu,
 18 Jul 2024 06:46:34 -0400
X-MC-Unique: FggzwLMeOuStl-H22AqoqA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA5531955D45;
	Thu, 18 Jul 2024 10:46:32 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B3393000185;
	Thu, 18 Jul 2024 10:46:29 +0000 (UTC)
Date: Thu, 18 Jul 2024 12:46:27 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 10/24] ovpn: implement basic RX path (UDP)
Message-ID: <Zpjyg-nO42rA3W_0@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-11-antonio@openvpn.net>
 <Zj4k9g1hV1eHQ4Ox@hog>
 <eb9558b3-cd7e-4da6-a496-adca6132a601@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <eb9558b3-cd7e-4da6-a496-adca6132a601@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry Antonio, I'm only coming back to this now.

2024-05-10, 16:41:43 +0200, Antonio Quartulli wrote:
> On 10/05/2024 15:45, Sabrina Dubroca wrote:
> > 2024-05-06, 03:16:23 +0200, Antonio Quartulli wrote:
> > > diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> > > index 36cfb95edbf4..9935a863bffe 100644
> > > --- a/drivers/net/ovpn/io.c
> > > +++ b/drivers/net/ovpn/io.c
> > > +/* Called after decrypt to write the IP packet to the device.
> > > + * This method is expected to manage/free the skb.
> > > + */
> > > +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff=
 *skb)
> > > +{
> > > +=09/* packet integrity was verified on the VPN layer - no need to pe=
rform
> > > +=09 * any additional check along the stack
> >=20
> > But it could have been corrupted before it got into the VPN?
>=20
> It could, but I believe a VPN should only take care of integrity along it=
s
> tunnel (and this is guaranteed by the OpenVPN protocol).
> If something corrupted enters the tunnel, we will just deliver it as is t=
o
> the other end. Upper layers (where the corruption actually happened) have=
 to
> deal with that.

I agree with that, but I don't think that's what CHECKSUM_UNNECESSARY
(especially with csum_level =3D MAX) would do. CHECKSUM_UNNECESSARY
tells the networking stack that the checksum has been verified (up to
csum_level+1, so 0 means the first level of TCP/UDP type headers has
been validated):

// include/linux/skbuff.h

 * - %CHECKSUM_UNNECESSARY
 *
 *   The hardware you're dealing with doesn't calculate the full checksum
 *   (as in %CHECKSUM_COMPLETE), but it does parse headers and verify check=
sums
 *   for specific protocols. For such packets it will set %CHECKSUM_UNNECES=
SARY
 *   if their checksums are okay.

 *   &sk_buff.csum_level indicates the number of consecutive checksums foun=
d in
 *   the packet minus one that have been verified as %CHECKSUM_UNNECESSARY.
 *   For instance if a device receives an IPv6->UDP->GRE->IPv4->TCP packet
 *   and a device is able to verify the checksums for UDP (possibly zero),
 *   GRE (checksum flag is set) and TCP, &sk_buff.csum_level would be set t=
o
 *   two. If the device were only able to verify the UDP checksum and not
 *   GRE, either because it doesn't support GRE checksum or because GRE
 *   checksum is bad, skb->csum_level would be set to zero (TCP checksum is
 *   not considered in this case).

I think you want CHECKSUM_NONE:

 *   Device did not checksum this packet e.g. due to lack of capabilities.

Then the stack will check if the packet was corrupted.

>=20
> >=20
> > > +=09 */
> > > +=09skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > > +=09skb->csum_level =3D ~0;
> > > +
> >=20

--=20
Sabrina


