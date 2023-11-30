Return-Path: <netdev+bounces-52571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152AD7FF3A5
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1CF1F20EE1
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAD0524B7;
	Thu, 30 Nov 2023 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0528410C2
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:35:20 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-OZoaRBMTOGC5jXmSDxUP8A-1; Thu,
 30 Nov 2023 10:35:16 -0500
X-MC-Unique: OZoaRBMTOGC5jXmSDxUP8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AF56381A910;
	Thu, 30 Nov 2023 15:35:15 +0000 (UTC)
Received: from hog (unknown [10.39.192.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CDA002166B26;
	Thu, 30 Nov 2023 15:35:14 +0000 (UTC)
Date: Thu, 30 Nov 2023 16:35:13 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next v2 6/8] iptfs: xfrm: Add mode_cbs module
 functionality
Message-ID: <ZWirsc6i-8n4qSAo@hog>
References: <20231113035219.920136-1-chopps@chopps.org>
 <20231113035219.920136-7-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231113035219.920136-7-chopps@chopps.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2023-11-12, 22:52:17 -0500, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
>=20
> Add a set of callbacks xfrm_mode_cbs to xfrm_state. These callbacks
> enable the addition of new xfrm modes, such as IP-TFS to be defined
> in modules.

Not a big fan of bringing back modes in modules :(
Florian's work made the code a lot more readable.

> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index 662c83beb345..4390c111410d 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -280,7 +280,9 @@ static int xfrm4_tunnel_encap_add(struct xfrm_state *=
x, struct sk_buff *skb)
>  =09skb_set_inner_network_header(skb, skb_network_offset(skb));
>  =09skb_set_inner_transport_header(skb, skb_transport_offset(skb));
> =20
> -=09skb_set_network_header(skb, -x->props.header_len);
> +=09/* backup to add space for the outer encap */
> +=09skb_set_network_header(skb,
> +=09=09=09       -x->props.header_len + x->props.enc_hdr_len);

Since this only gets called for XFRM_MODE_TUNNEL, and only iptfs sets
enc_hdr_len, do we need this change? (and same for xfrm6_tunnel_encap_add)

>  =09skb->mac_header =3D skb->network_header +
>  =09=09=09  offsetof(struct iphdr, protocol);
>  =09skb->transport_header =3D skb->network_header + sizeof(*top_iph);
> @@ -325,7 +327,8 @@ static int xfrm6_tunnel_encap_add(struct xfrm_state *=
x, struct sk_buff *skb)
>  =09skb_set_inner_network_header(skb, skb_network_offset(skb));
>  =09skb_set_inner_transport_header(skb, skb_transport_offset(skb));
> =20
> -=09skb_set_network_header(skb, -x->props.header_len);
> +=09skb_set_network_header(skb,
> +=09=09=09       -x->props.header_len + x->props.enc_hdr_len);
>  =09skb->mac_header =3D skb->network_header +
>  =09=09=09  offsetof(struct ipv6hdr, nexthdr);
>  =09skb->transport_header =3D skb->network_header + sizeof(*top_iph);
> @@ -472,6 +475,8 @@ static int xfrm_outer_mode_output(struct xfrm_state *=
x, struct sk_buff *skb)
>  =09=09WARN_ON_ONCE(1);
>  =09=09break;
>  =09default:
> +=09=09if (x->mode_cbs->prepare_output)

Can x->mode_cbs be NULL here? Every other use of mode_cbs does
    if (x->mode_cbs && x->mode_cbs->FOO)

(I think not at the moment since only IPTFS (and IN_TRIGGER) can reach
this, but this inconsistency with the rest of the series struck me)

--=20
Sabrina


