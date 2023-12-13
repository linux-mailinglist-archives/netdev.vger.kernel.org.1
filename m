Return-Path: <netdev+bounces-56912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 971518114C8
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203311F21683
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DE52E85B;
	Wed, 13 Dec 2023 14:37:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5361EE3
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 06:37:04 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-RnP9YVc7OQGSpF9V5jKgeg-1; Wed, 13 Dec 2023 09:36:58 -0500
X-MC-Unique: RnP9YVc7OQGSpF9V5jKgeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 409C183B870;
	Wed, 13 Dec 2023 14:36:57 +0000 (UTC)
Received: from hog (unknown [10.39.192.229])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DD7CC51E3;
	Wed, 13 Dec 2023 14:36:55 +0000 (UTC)
Date: Wed, 13 Dec 2023 15:36:54 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next v1 2/3] macsec: Detect if Rx skb is
 macsec-related for offloading devices that update md_dst
Message-ID: <ZXnBhouKZPf39Hkb@hog>
References: <20231116182900.46052-1-rrameshbabu@nvidia.com>
 <20231116182900.46052-3-rrameshbabu@nvidia.com>
 <ZV9jzHCQy1DZvyfk@hog>
 <87wmu36mhw.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87wmu36mhw.fsf@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2023-11-27, 11:10:19 -0800, Rahul Rameshbabu wrote:
> On Thu, 23 Nov, 2023 15:38:04 +0100 Sabrina Dubroca <sd@queasysnail.net> =
wrote:
> > If the device provided md_dst, either we find the corresponding rx_sc,
> > then we receive on this macsec device only, or we don't and try the
> > other macsec devices.
> >
> > Something like this (completely untested):
> >
> > =09if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
> > =09=09struct macsec_rx_sc *rx_sc =3D NULL;
> > =09=09bool exact =3D false;
> >
> > =09=09if (macsec->offload_md_dst && !is_macsec_md_dst)
> > =09=09=09continue;
> >
> > =09=09if (is_macsec_md_dst) {
> > =09=09=09DEBUG_NET_WARN_ON_ONCE(!macsec->offload_md_dst);
> > =09=09=09rx_sc =3D find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci)=
;
> > =09=09=09if (!rx_sc)
> > =09=09=09=09continue;
> > =09=09=09exact =3D true;
> > =09=09}
> >
> > =09=09if (exact ||
> > =09=09    ether_addr_equal_64bits(hdr->h_dest, ndev->dev_addr)) {
> > =09=09=09/* exact match, divert skb to this port */
> > =09[keep the existing code after this]
> >
> >
> > Am I missing something?
>=20
> I just have one question with regards to this (will be testing this out
> too). For the exact match case, if the receiving traffic was macsec
> encrypted multicast, would the pkt_type be PACKET_HOST or
> PACKET_BROADCAST/PACKET_MULTICAST? My intuition is screaming to me that
> '[keep the existing code after this]' is not 100% true because we would
> want to update the skb pkt_type to PACKET_BROADCAST/PACKET_MULTICAST
> even if we are able to identify the incoming multicast frame was macsec
> encrypted and specifically intended for this device. Does that sound
> right?

Yes, I guess. SW decrypt path calls eth_type_trans, but that does a
lot more than we need here.

--=20
Sabrina


