Return-Path: <netdev+bounces-50560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4192E7F61A4
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08C0281F9D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C6826AF0;
	Thu, 23 Nov 2023 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEC1D40
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:38:13 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-KyU1fe1mPIuPTdpAZQ41KA-1; Thu, 23 Nov 2023 09:38:07 -0500
X-MC-Unique: KyU1fe1mPIuPTdpAZQ41KA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EB3C185A785;
	Thu, 23 Nov 2023 14:38:07 +0000 (UTC)
Received: from hog (unknown [10.39.192.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D7C1A40C6EB9;
	Thu, 23 Nov 2023 14:38:05 +0000 (UTC)
Date: Thu, 23 Nov 2023 15:38:04 +0100
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
Message-ID: <ZV9jzHCQy1DZvyfk@hog>
References: <20231116182900.46052-1-rrameshbabu@nvidia.com>
 <20231116182900.46052-3-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231116182900.46052-3-rrameshbabu@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2023-11-16, 10:28:59 -0800, Rahul Rameshbabu wrote:
> This detection capability will enable drivers that update md_dst to be ab=
le
> to receive and handle both non-MACSec and MACsec traffic received and the
> same physical port when offload is enabled.
>=20
> This detection is not possible without device drivers that update md_dst.=
 A
> fallback pattern should be used for supporting such device drivers. This
> fallback mode causes multicast messages to be cloned to both the non-macs=
ec
> and macsec ports, independent of whether the multicast message received w=
as
> encrypted over MACsec or not. Other non-macsec traffic may also fail to b=
e
> handled correctly for devices in promiscuous mode.
>=20
> Link: https://lore.kernel.org/netdev/ZULRxX9eIbFiVi7v@hog/
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> ---
>  drivers/net/macsec.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 8c0b12490e89..e14f2ad2e253 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -1002,6 +1002,7 @@ static enum rx_handler_result handle_not_macsec(str=
uct sk_buff *skb)
>  =09rcu_read_lock();
>  =09rxd =3D macsec_data_rcu(skb->dev);
>  =09md_dst =3D skb_metadata_dst(skb);
> +=09bool is_macsec_md_dst =3D md_dst && md_dst->type =3D=3D METADATA_MACS=
EC;
> =20
>  =09list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
>  =09=09struct sk_buff *nskb;
> @@ -1014,10 +1015,13 @@ static enum rx_handler_result handle_not_macsec(s=
truct sk_buff *skb)
>  =09=09if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
>  =09=09=09struct macsec_rx_sc *rx_sc =3D NULL;
> =20
> -=09=09=09if (md_dst && md_dst->type =3D=3D METADATA_MACSEC)
> +=09=09=09if (macsec->offload_md_dst && !is_macsec_md_dst)
> +=09=09=09=09continue;
> +
> +=09=09=09if (is_macsec_md_dst)
>  =09=09=09=09rx_sc =3D find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sc=
i);
> =20
> -=09=09=09if (md_dst && md_dst->type =3D=3D METADATA_MACSEC && !rx_sc)
> +=09=09=09if (is_macsec_md_dst && !rx_sc)
>  =09=09=09=09continue;
> =20
>  =09=09=09if (ether_addr_equal_64bits(hdr->h_dest,

Why not skip the MAC address matching if you found the rx_sc? The way
you're implementing it, it will still distribute broadcast received
over the macsec port to other macsec ports on the same device, right?

If the device provided md_dst, either we find the corresponding rx_sc,
then we receive on this macsec device only, or we don't and try the
other macsec devices.

Something like this (completely untested):

=09if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
=09=09struct macsec_rx_sc *rx_sc =3D NULL;
=09=09bool exact =3D false;

=09=09if (macsec->offload_md_dst && !is_macsec_md_dst)
=09=09=09continue;

=09=09if (is_macsec_md_dst) {
=09=09=09DEBUG_NET_WARN_ON_ONCE(!macsec->offload_md_dst);
=09=09=09rx_sc =3D find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci);
=09=09=09if (!rx_sc)
=09=09=09=09continue;
=09=09=09exact =3D true;
=09=09}

=09=09if (exact ||
=09=09    ether_addr_equal_64bits(hdr->h_dest, ndev->dev_addr)) {
=09=09=09/* exact match, divert skb to this port */
=09[keep the existing code after this]


Am I missing something?

--=20
Sabrina


