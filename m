Return-Path: <netdev+bounces-204153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E8DAF9387
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 15:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4551C8342B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 13:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831630113B;
	Fri,  4 Jul 2025 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPFmYIHc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E32FC3D4
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634050; cv=none; b=iB4eRM7yBgsu53T0gJcGo1juWkUqfmKo9EEuFdc6ZehYBY7315SaWc2KywzZNY3TJiSsy05qUi/mDuvqgcsPSc0SegJVY9oNihkMDHK43V+EjDT28dyJBgSgABunHMavNpEfYjI1XPMpvApT4Q6dmeWEjpquw9YY0tDGqup4R3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634050; c=relaxed/simple;
	bh=NdhINJYDzJpYgHW5Fj1UH7L/8JMERHyNTyr2NaoYoyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2KqH532I2+oJo00mfONS5TdIhkzIIWMeHb2KdANrb2S84UGQmJTYjt6W6ir58ILLNDxPQQEMXEiRjNW8aBNXCQYFqnUkwF8/EdDEHlVtqJTvu0z3Nlmc/l0BRlv1B6QVySmVEMz9EM+8BjuOX13pwIfzPNxBch2V4vIQfiyDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPFmYIHc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751634046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXQCVREPP6j1xMSTefP6W64EZBhJxFWqjEZUcvvKuzE=;
	b=NPFmYIHc8LCNFCo/3i3FoTLpYbdpZxO9kcaL8xvgtBtQbZ+MvcH6WP7I3o0q92aslQDhoi
	LAub6/KaATcWXuTV/uG9Xf7mf1/QJa+a7KTy8FnxSJnQXKS8GZgyF2mFD6ZSi9ln9D0UVc
	GAowi0+kUaljZ9gsghdV8/kUluR0oLc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-0skal7tBM7Si_l--cCOLZg-1; Fri, 04 Jul 2025 09:00:45 -0400
X-MC-Unique: 0skal7tBM7Si_l--cCOLZg-1
X-Mimecast-MFC-AGG-ID: 0skal7tBM7Si_l--cCOLZg_1751634044
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d30992bcso6266145e9.2
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 06:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751634044; x=1752238844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXQCVREPP6j1xMSTefP6W64EZBhJxFWqjEZUcvvKuzE=;
        b=DENWs8NXozbs5c7luAZcrsjndv/gqAQk5HIZLACKW02EW3y7CKfvzq+gicUXVf9wqX
         z1EY8Z972GjGyV3jhrEr5C1/oYNZuFBzHdxkAyZsGEfrONTWz8itJJzALuNJCjXgE0Vq
         pmUIcJ0OqYzXCdPZClB14hfEee0bq7Zc6hrB7/eqbvQHP1fzRgGaMEsa1wfh6dl47Jhn
         DpURbNT8LQ69Kg47vpIuw8KpudMxXXs/AWHa3EN7uYIa2go3zchXAICvjGHwkZIKBUgA
         J6J/UfFr86wW8hpbZyRXOlovMrny+NSDwgCu0TzzKZYYNoqJAK21C3FCNaFODRuY7ras
         rIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWykl0Imsb7meDIw1cDAOe6bdyfyzpUJ+9UkL8o0CuDA9NBbzbgWT58/9kLu0MdX6YV8sVory0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNoKXM6s+xLrRk+4zFzS6WQY1m2WIH0lFRG14f9M+UlI6EjE6v
	6x9nLLCgn88H1kRser2mzvncPrIZ0+Dkm0l+6kBG2adT7rfYhs2JgXpagFTiwoYX0hpfB6uPG4v
	p0iJtMvmU8xQ/izwA46WCwqOTXnVU7nVCh1lM93e67vKtCOP4eLPfF96ebA==
X-Gm-Gg: ASbGnctv5awkiC3EE1fumsts99i+utOUsnw7GJ/QTda7g1D39z0EcOSFCpRaADET9mX
	ql4J5D1QfYfMrYUlxkuw8Edb9jqN3gEjWAGnyYsOA3HeBoxyQ2mMSOwaLaZjg1YzqWMJqUY7n0f
	NNG9oYZF4v0cMS/cX7e463BU5d2FxKDUeOoE87tJcHzHaizIJgUn13sQ7P91NNWoGYYbx+8wIpL
	KAoUpsBBdg/lnz4EHhwMgMKvLd6GW1ZdbJ8t0ZFhxwrccikqahu1pxPO7imdNPMEcjjcSgcvGdy
	hNqhuepQjA21KKfY6DXl6kk5Ns91X8WRwMTqLc5SNH6UrNm865GwY/G3gIp9PgETmGl1/Q==
X-Received: by 2002:a05:6000:481c:b0:3a4:d64a:3df6 with SMTP id ffacd0b85a97d-3b49700c535mr1725428f8f.3.1751634043559;
        Fri, 04 Jul 2025 06:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa4HKUZ3teX9TCdSk8wN5/izAQSZCR696BxsmgiXVbd0G0YsfWUUcQQ09jyylhGB7fr56W2A==
X-Received: by 2002:a05:6000:481c:b0:3a4:d64a:3df6 with SMTP id ffacd0b85a97d-3b49700c535mr1725369f8f.3.1751634042943;
        Fri, 04 Jul 2025 06:00:42 -0700 (PDT)
Received: from localhost (net-130-25-105-15.cust.vodafonedsl.it. [130.25.105.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b472259842sm2432211f8f.72.2025.07.04.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 06:00:41 -0700 (PDT)
Date: Fri, 4 Jul 2025 15:00:40 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v3 1/2] net: netfilter: Add IPIP flowtable SW
 acceleration
Message-ID: <aGfQeF_6c2W1ecrX@lore-desk>
References: <20250703-nf-flowtable-ipip-v3-0-880afd319b9f@kernel.org>
 <20250703-nf-flowtable-ipip-v3-1-880afd319b9f@kernel.org>
 <aGaVKWKOKj1a-eG1@calendula>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0jKr/ed/cH4ZgbY6"
Content-Disposition: inline
In-Reply-To: <aGaVKWKOKj1a-eG1@calendula>


--0jKr/ed/cH4ZgbY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jul 03, 2025 at 04:16:02PM +0200, Lorenzo Bianconi wrote:
> > Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
> > infrastructure.
> > IPIP SW acceleration can be tested running the following scenario where
> > the traffic is forwarded between two NICs (eth0 and eth1) and an IPIP
> > tunnel is used to access a remote site (using eth1 as the underlay devi=
ce):
>=20
> Question below.
>=20
> > ETH0 -- TUN0 <=3D=3D> ETH1 -- [IP network] -- TUN1 (192.168.100.2)
> >=20
> > $ip addr show
> > 6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state=
 UP group default qlen 1000
> >     link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> >     inet 192.168.0.2/24 scope global eth0
> >        valid_lft forever preferred_lft forever
> > 7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state=
 UP group default qlen 1000
> >     link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
> >     inet 192.168.1.1/24 scope global eth1
> >        valid_lft forever preferred_lft forever
> > 8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue st=
ate UNKNOWN group default qlen 1000
> >     link/ipip 192.168.1.1 peer 192.168.1.2
> >     inet 192.168.100.1/24 scope global tun0
> >        valid_lft forever preferred_lft forever
> >=20
> > $ip route show
> > default via 192.168.100.2 dev tun0
> > 192.168.0.0/24 dev eth0 proto kernel scope link src 192.168.0.2
> > 192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.1
> > 192.168.100.0/24 dev tun0 proto kernel scope link src 192.168.100.1
> >=20
> > $nft list ruleset
> > table inet filter {
> >         flowtable ft {
> >                 hook ingress priority filter
> >                 devices =3D { eth0, eth1 }
> >         }
> >=20
> >         chain forward {
> >                 type filter hook forward priority filter; policy accept;
> >                 meta l4proto { tcp, udp } flow add @ft
> >         }
> > }
> >=20
> > Reproducing the scenario described above using veths I got the following
> > results:
> > - TCP stream transmitted into the IPIP tunnel:
> >   - net-next:				~41Gbps
> >   - net-next + IPIP flowtbale support:	~40Gbps
>                       ^^^^^^^^^
> no gain on tx side.

In this case the IPIP flowtable acceleration is effective just on the ACKs
packets so I guess it is expected we have ~ the same results. The real gain=
 is
when the TCP stream is from the tunnel net_device to the NIC one.

>=20
> > - TCP stream received from the IPIP tunnel:
> >   - net-next:				~35Gbps
> >   - net-next + IPIP flowtbale support:	~49Gbps
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  net/ipv4/ipip.c                  | 21 +++++++++++++++++++++
> >  net/netfilter/nf_flow_table_ip.c | 34 ++++++++++++++++++++++++++++++++=
--
> >  2 files changed, 53 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
> > index 3e03af073a1ccc3d7597a998a515b6cfdded40b5..05fb1c859170d74009d693b=
c8513183bdec3ff90 100644
> > --- a/net/ipv4/ipip.c
> > +++ b/net/ipv4/ipip.c
> > @@ -353,6 +353,26 @@ ipip_tunnel_ctl(struct net_device *dev, struct ip_=
tunnel_parm_kern *p, int cmd)
> >  	return ip_tunnel_ctl(dev, p, cmd);
> >  }
> > =20
> > +static int ipip_fill_forward_path(struct net_device_path_ctx *ctx,
> > +				  struct net_device_path *path)
> > +{
> > +	struct ip_tunnel *tunnel =3D netdev_priv(ctx->dev);
> > +	const struct iphdr *tiph =3D &tunnel->parms.iph;
> > +	struct rtable *rt;
> > +
> > +	rt =3D ip_route_output(dev_net(ctx->dev), tiph->daddr, 0, 0, 0,
> > +			     RT_SCOPE_UNIVERSE);
> > +	if (IS_ERR(rt))
> > +		return PTR_ERR(rt);
> > +
> > +	path->type =3D DEV_PATH_ETHERNET;
> > +	path->dev =3D ctx->dev;
> > +	ctx->dev =3D rt->dst.dev;
> > +	ip_rt_put(rt);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct net_device_ops ipip_netdev_ops =3D {
> >  	.ndo_init       =3D ipip_tunnel_init,
> >  	.ndo_uninit     =3D ip_tunnel_uninit,
> > @@ -362,6 +382,7 @@ static const struct net_device_ops ipip_netdev_ops =
=3D {
> >  	.ndo_get_stats64 =3D dev_get_tstats64,
> >  	.ndo_get_iflink =3D ip_tunnel_get_iflink,
> >  	.ndo_tunnel_ctl	=3D ipip_tunnel_ctl,
> > +	.ndo_fill_forward_path =3D ipip_fill_forward_path,
> >  };
> > =20
> >  #define IPIP_FEATURES (NETIF_F_SG |		\
> > diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_t=
able_ip.c
> > index 8cd4cf7ae21120f1057c4fce5aaca4e3152ae76d..6b55e00b1022f0a2b02d9bf=
d1bd34bb55c1b83f7 100644
> > --- a/net/netfilter/nf_flow_table_ip.c
> > +++ b/net/netfilter/nf_flow_table_ip.c
> > @@ -277,13 +277,37 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_b=
uff *skb,
> >  	return NF_STOLEN;
> >  }
> > =20
> > +static bool nf_flow_ip4_encap_proto(struct sk_buff *skb, u16 *size)
> > +{
> > +	struct iphdr *iph;
> > +
> > +	if (!pskb_may_pull(skb, sizeof(*iph)))
> > +		return false;
> > +
> > +	iph =3D (struct iphdr *)skb_network_header(skb);
> > +	*size =3D iph->ihl << 2;
> > +
> > +	if (ip_is_fragment(iph) || unlikely(ip_has_options(*size)))
> > +		return false;
> > +
> > +	if (iph->ttl <=3D 1)
> > +		return false;
> > +
> > +	return iph->protocol =3D=3D IPPROTO_IPIP;
>=20

what kind of sanity checks are we supposed to perform? Something similar to
what we have in ip_rcv_core()?

> Once the flow is in the flowtable, it is possible to inject traffic
> with forged outer IP header, this is only looking at the inner IP
> header.

what is the difference with the plain IP/TCP use-case?

Regards,
Lorenzo

>=20

--0jKr/ed/cH4ZgbY6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaGfQeAAKCRA6cBh0uS2t
rIKvAP9Fu06jDyIxlsBsoWVIdt9G7Rvr6Z2Dml7eL3PzdlyxFQD+JfVmkkqp6oHy
NNQLk722kxNMwtrugDl9o3+cPyd0uQY=
=pgpa
-----END PGP SIGNATURE-----

--0jKr/ed/cH4ZgbY6--


