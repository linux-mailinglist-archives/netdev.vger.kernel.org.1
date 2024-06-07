Return-Path: <netdev+bounces-101755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2921C8FFFA1
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A41C22E67
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF6515CD53;
	Fri,  7 Jun 2024 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="QlyqLUVA"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D615B971;
	Fri,  7 Jun 2024 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752855; cv=none; b=FhYiHH9vbYgGSskAcbcdsTOgnS++xAqhXTmmhuRCkGuUeb08UMsdhadky9cFt83zxPvHmDEomfZkBOTaUWZxNG2d/SBZSNvj1c2VoKnfWdoe9G3chB9yr/8a8IcZe6my+1HZjKyICHF7ZeAOASKiExae92LcXAxIdJYbU7cotFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752855; c=relaxed/simple;
	bh=SOOtO0XHuLqKjOQScdVc+s1HzOLvyL9RyAWHuIxxChI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnDDxcbPJL4lVXRyxF9PtXDpQNAU7LKU2bOhQS3XJ5jVeI9DOoEsvZPyBJcDlSem1NEalwzibFBS8lbn8lbMql42kHR85+9JbpbDciLWvHHwxkQ4V0UdGq2lgLY2gleMXDTJWQ2Epu2k/dtiINw0+3zYjh79mcPbYkRtzBSV3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=QlyqLUVA; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AF61E87F6F;
	Fri,  7 Jun 2024 11:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717752850;
	bh=sLPV3Zi8zZlAfuwKZkNa6TymR0omJjYS7Kp3TCHG/A0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QlyqLUVAiQJPSQDJ3gnRuvDDrrPhkg0shSfynp0aapogSTrLxJBTFRxB3rJC6aAaa
	 l+TK+vsDLAAAqI4Lx9+bGEHc6SL/g1wwJwdnea/6m/sMuDgoD1s+bTnLHw0NkBfAlL
	 hHhVbgDiGqLnph+auJjTn8Ym87Fih+91ggFnmwsQMumjPJJdiHJo/77WLCIGZ9bPD8
	 pXdJwvXeYYq0K/Hr/rSK2jZBa+dFTfFqdPUc3oO1myMyDnIXvYOJ+Qv7pm8ioMmXKv
	 uZqjX04h5jex3fLIgiGOYZsHeIIoM8B1UtcXW/Qxj5Uz3V1W2Z/ytrqhg8eUo6k/o+
	 f8xPTyGMacFeQ==
Date: Fri, 7 Jun 2024 11:34:07 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Wojciech
 Drewek <wojciech.drewek@intel.com>, Eric Dumazet <edumazet@google.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Tristram.Ha@microchip.com, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon
 Horman <horms@kernel.org>, Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Murali Karicheri <m-karicheri2@ti.com>, Arvid Brodin
 <Arvid.Brodin@xdin.com>, Dan Carpenter <dan.carpenter@linaro.org>, "Ricardo
 B. Marliere" <ricardo@marliere.net>, Casper Andersson
 <casper.casan@gmail.com>, linux-kernel@vger.kernel.org, Hangbin Liu
 <liuhangbin@gmail.com>, Geliang Tang <tanggeliang@kylinos.cn>, Shuah Khan
 <shuah@kernel.org>, Shigeru Yoshida <syoshida@redhat.com>
Subject: Re: [PATCH v2 net-next] net: hsr: Send supervisory frames to HSR
 network with ProxyNodeTable data
Message-ID: <20240607113407.50cdb10c@wsk>
In-Reply-To: <e962a2e2ba7856a6e5282238819637204feed2ba.camel@redhat.com>
References: <20240604084348.3259917-1-lukma@denx.de>
	<e962a2e2ba7856a6e5282238819637204feed2ba.camel@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k/2PbKb7LftwGzPElY85F6l";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/k/2PbKb7LftwGzPElY85F6l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On Tue, 2024-06-04 at 10:43 +0200, Lukasz Majewski wrote:
> > This patch provides support for sending supervision HSR frames with
> > MAC addresses stored in ProxyNodeTable when RedBox (i.e. HSR-SAN) is
> > enabled.
> >=20
> > Supervision frames with RedBox MAC address (appended as second TLV)
> > are only send for ProxyNodeTable nodes.
> >=20
> > This patch series shall be tested with hsr_redbox.sh script. =20
>=20
> I don't see any specific check for mac addresses in hsr_redbox.sh, am
> I missing something? Otherwise please update the self-tests, too.

Could you be more specific here?

This patch adds support for sending supervisory frames on behalf of
RedBox device. The result of it could be visible in proxy_node table.
However, no special check is required.

>=20
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >=20
> > Changes for v2:
> > - Fix the Reverse Christmas Tree formatting
> > - Return directly values from hsr_is_node_in_db() and
> > ether_addr_equal()
> > - Change the internal variable check
> > ---
> >  net/hsr/hsr_device.c   | 63
> > ++++++++++++++++++++++++++++++++++-------- net/hsr/hsr_forward.c  |
> > 37 +++++++++++++++++++++++-- net/hsr/hsr_framereg.c | 12 ++++++++
> >  net/hsr/hsr_framereg.h |  2 ++
> >  net/hsr/hsr_main.h     |  4 ++-
> >  net/hsr/hsr_netlink.c  |  1 +
> >  6 files changed, 105 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> > index e6904288d40d..ad7cb9b29273 100644
> > --- a/net/hsr/hsr_device.c
> > +++ b/net/hsr/hsr_device.c
> > @@ -73,9 +73,15 @@ static void hsr_check_announce(struct net_device
> > *hsr_dev) mod_timer(&hsr->announce_timer, jiffies +
> >  				  msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
> >  		}
> > +
> > +		if (hsr->redbox &&
> > !timer_pending(&hsr->announce_proxy_timer))
> > +			mod_timer(&hsr->announce_proxy_timer,
> > jiffies +
> > +
> > msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL) / 2); } else {
> >  		/* Deactivate the announce timer  */
> >  		timer_delete(&hsr->announce_timer);
> > +		if (hsr->redbox)
> > +			timer_delete(&hsr->announce_proxy_timer);
> >  	}
> >  }
> > =20
> > @@ -279,10 +285,11 @@ static struct sk_buff *hsr_init_skb(struct
> > hsr_port *master) return NULL;
> >  }
> > =20
> > -static void send_hsr_supervision_frame(struct hsr_port *master,
> > -				       unsigned long *interval)
> > +static void send_hsr_supervision_frame(struct hsr_port *port,
> > +				       unsigned long *interval,
> > +				       const unsigned char
> > addr[ETH_ALEN]) =20
>=20
> please use 'const unsigned char *addr' instead. The above syntax is
> misleading
>=20

Ok.

> >  {
> > -	struct hsr_priv *hsr =3D master->hsr;
> > +	struct hsr_priv *hsr =3D port->hsr;
> >  	__u8 type =3D HSR_TLV_LIFE_CHECK;
> >  	struct hsr_sup_payload *hsr_sp;
> >  	struct hsr_sup_tlv *hsr_stlv; =20
>=20
> [...]
>=20
> > @@ -340,13 +348,14 @@ static void send_hsr_supervision_frame(struct
> > hsr_port *master, return;
> >  	}
> > =20
> > -	hsr_forward_skb(skb, master);
> > +	hsr_forward_skb(skb, port);
> >  	spin_unlock_bh(&hsr->seqnr_lock);
> >  	return;
> >  }
> > =20
> >  static void send_prp_supervision_frame(struct hsr_port *master,
> > -				       unsigned long *interval)
> > +				       unsigned long *interval,
> > +				       const unsigned char
> > addr[ETH_ALEN]) =20
>=20
> Same here.

Ok.

>=20
> >  {
> >  	struct hsr_priv *hsr =3D master->hsr;
> >  	struct hsr_sup_payload *hsr_sp;
> > @@ -396,7 +405,7 @@ static void hsr_announce(struct timer_list *t)
> > =20
> >  	rcu_read_lock();
> >  	master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> > -	hsr->proto_ops->send_sv_frame(master, &interval);
> > +	hsr->proto_ops->send_sv_frame(master, &interval,
> > master->dev->dev_addr);=20
> >  	if (is_admin_up(master->dev))
> >  		mod_timer(&hsr->announce_timer, jiffies +
> > interval); @@ -404,6 +413,37 @@ static void hsr_announce(struct
> > timer_list *t) rcu_read_unlock();
> >  }
> > =20
> > +/* Announce (supervision frame) timer function for RedBox
> > + */
> > +static void hsr_proxy_announce(struct timer_list *t)
> > +{
> > +	struct hsr_priv *hsr =3D from_timer(hsr, t,
> > announce_proxy_timer);
> > +	struct hsr_port *interlink;
> > +	unsigned long interval =3D 0;
> > +	struct hsr_node *node;
> > +
> > +	rcu_read_lock();
> > +	/* RedBOX sends supervisory frames to HSR network with MAC
> > addresses
> > +	 * of SAN nodes stored in ProxyNodeTable.
> > +	 */
> > +	interlink =3D hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
> > +	list_for_each_entry_rcu(node, &hsr->proxy_node_db,
> > mac_list) {
> > +		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
> > +			continue;
> > +		hsr->proto_ops->send_sv_frame(interlink, &interval,
> > +					      node->macaddress_A);
> > +	}
> > +
> > +	if (is_admin_up(interlink->dev)) {
> > +		if (!interval)
> > +			interval =3D
> > msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL); +
> > +		mod_timer(&hsr->announce_proxy_timer, jiffies +
> > interval);
> > +	}
> > +
> > +	rcu_read_unlock();
> > +}
> > +
> >  void hsr_del_ports(struct hsr_priv *hsr)
> >  {
> >  	struct hsr_port *port;
> > @@ -590,6 +630,7 @@ int hsr_dev_finalize(struct net_device
> > *hsr_dev, struct net_device *slave[2],
> > timer_setup(&hsr->announce_timer, hsr_announce, 0);
> > timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
> > timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
> > +	timer_setup(&hsr->announce_proxy_timer,
> > hsr_proxy_announce, 0);=20
> >  	ether_addr_copy(hsr->sup_multicast_addr,
> > def_multicast_addr); hsr->sup_multicast_addr[ETH_ALEN - 1] =3D
> > multicast_spec; diff --git a/net/hsr/hsr_forward.c
> > b/net/hsr/hsr_forward.c index 05a61b8286ec..003070dbfcb4 100644
> > --- a/net/hsr/hsr_forward.c
> > +++ b/net/hsr/hsr_forward.c
> > @@ -117,6 +117,35 @@ static bool is_supervision_frame(struct
> > hsr_priv *hsr, struct sk_buff *skb) return true;
> >  }
> > =20
> > +static bool is_proxy_supervision_frame(struct hsr_priv *hsr,
> > +				       struct sk_buff *skb)
> > +{
> > +	struct hsr_sup_payload *payload;
> > +	struct ethhdr *eth_hdr;
> > +	u16 total_length =3D 0;
> > +
> > +	eth_hdr =3D (struct ethhdr *)skb_mac_header(skb);
> > +
> > +	/* Get the HSR protocol revision. */
> > +	if (eth_hdr->h_proto =3D=3D htons(ETH_P_HSR))
> > +		total_length =3D sizeof(struct hsrv1_ethhdr_sp);
> > +	else
> > +		total_length =3D sizeof(struct hsrv0_ethhdr_sp);
> > +
> > +	if (!pskb_may_pull(skb, total_length)) =20
>=20
> It looks like 'total_length' does not include 'sizeof
> hsr_sup_payload'?

I think that it is expected - I do check if it is possible to pull data
from packet up till the point where I want to further extract the hsr
payload.

>=20
> > +		return false;
> > +
> > +	skb_pull(skb, total_length);
> > +	payload =3D (struct hsr_sup_payload *)skb->data;
> > +	skb_push(skb, total_length); =20
>=20
> No need to actually pull the data, you could do directly:
>=20
> 	payload =3D (struct hsr_sup_payload *)skb->data[total_length];
>=20

Yes, this is better approach - thanks for the idea.

>=20
>=20
> Thanks,
>=20
> Paolo
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/k/2PbKb7LftwGzPElY85F6l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZi1A8ACgkQAR8vZIA0
zr0DWQf9HoDn/MDhxzWW3Ytf3uHaU/38MyDtYqjbwdKizo3Epe8Ht4/3YsGJnGtp
TMCU5b4Sq9xIKyyiIEtWnqBC2i6QG99PR9fApmdYem6r+H0ixQTEw8NVF6vJBiXV
IGLSBtQPQxR50IJ5s7J1lxWI7cQG45Y2VmZu2nUSlYsiyggzewijiBabfChjG0EC
e6Mpx426An9Ama6PbZJfEdgs3oXJPrE1YgfTC+/6Yw2ICrO6QMLZ8wYHaLhFZd0h
iC2xiEOJWqFb51rIMUDmJkl04LB10E3WnqiVMiH4AVNa4MTj9zRRcQeOEAMkwTMO
Uh6RVc2eBnxuLRv0YmVQqWpyHi7n3A==
=FPjU
-----END PGP SIGNATURE-----

--Sig_/k/2PbKb7LftwGzPElY85F6l--

