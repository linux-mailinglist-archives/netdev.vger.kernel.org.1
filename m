Return-Path: <netdev+bounces-125368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A239996CEF9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FF9287B90
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 06:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611AB185941;
	Thu,  5 Sep 2024 06:16:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-25.us.a.mail.aliyun.com (out198-25.us.a.mail.aliyun.com [47.90.198.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52014A4F5;
	Thu,  5 Sep 2024 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725516978; cv=none; b=GqTbCVSUbzRhJ3dt/DJfZht7+dBXZ0cEMK0oRVV5fkTCYkuTdz2m5HX+IuI/9LkC/pQLtPtdbHdbB496OhXrXG/NAljKu6XhuAhTaZvU/NIQFOTZ5TMs14j5qEnOJ6yqYOA0s1U6Oelx2jxOg2Rjci3CTeeqokCWQ3gvMpzB7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725516978; c=relaxed/simple;
	bh=gfMtjPwjTjyRydQwVV0HApg+Urd9OeQk2HGwtZrKqHQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=jAcrxpfKeDZszIv8m99qrUtXa3RBIU2RevcMctAMGQAKkxNYcq8aaSsMHbxJCoyCO86PRp6jK2+F2kX5fUnLJ4AEI+OlJJcPZund5aGZuws+FPb/unc0kLFQovs8fq/B/2A9dqF0xDNzlOLiw8THOpVH8x2FHXabHzSw9a8mBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inceptio.ai; spf=pass smtp.mailfrom=inceptio.ai; arc=none smtp.client-ip=47.90.198.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inceptio.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inceptio.ai
Received: from JunjieWan(mailfrom:junjie.wan@inceptio.ai fp:SMTPD_---.ZBatxYi_1725516953)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 14:15:53 +0800
From: <junjie.wan@inceptio.ai>
To: "'Ioana Ciornei'" <ioana.ciornei@nxp.com>
Cc: "'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240902015051.11159-1-junjie.wan@inceptio.ai> <kywc7aqhfrk6rdgop73koeoi5hnufgjabluoa5lv4znla3o32p@uwl6vmnigbfk>
In-Reply-To: <kywc7aqhfrk6rdgop73koeoi5hnufgjabluoa5lv4znla3o32p@uwl6vmnigbfk>
Subject: RE: [PATCH v2] dpaa2-switch: fix flooding domain among multiple vlans
Date: Thu, 5 Sep 2024 14:15:53 +0800
Message-ID: <000201daff5b$101e77f0$305b67d0$@inceptio.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJnHAQGh1btYvjGEtAQYjLpzrvB4wIoUD5JsR867nA=
Content-Language: zh-cn

Hi Ioana,

Thank you for your comments.

> > Currently, dpaa2 switch only cares dst mac and egress interface
> > in FDB. And all ports with different vlans share the same FDB.
> > 
>
> Indeed, the DPAA2 switch driver was written in such a way that learning
> is shared between VLANs. The concern at that time was the limited amount
> of resources which are allocated at DPSW creation time and which need to
> be managed by the driver in the best way possible.
>
> That being said, I would suggest actually changing the title of the
> commit to something like "dpaa2-switch: add support for per-VLAN
> learning" so that it's clear that the driver did not support this prior.

LGTM.

> > This will make things messed up when one device connected to
> > dpaa2 switch via two interfaces. Ports get two different vlans
> > assigned. These two ports will race for a same dst mac entry
> > since multiple vlans share one FDB.
> > 
> > FDB below may not show up at the same time.
> > 02:00:77:88:99:aa dev swp0 self
> > 02:00:77:88:99:aa dev swp1 self
> > But in fact, for rules on the bridge, they should be:
> > 02:00:77:88:99:aa dev swp0 vlan 10 master br0
> > 02:00:77:88:99:aa dev swp1 vlan 20 master br0
> > 
> > This patch address this by borrowing unused form ports' FDB
> > when ports join bridge. And append offload flag to hardware
> > offloaded rules so we can tell them from those on bridges.
>
> Borrowing from the unused FDBs is fine as long as no switch port wants
> to leave the bridge. In case all available FDBs are used for the
> per-VLAN FDBs, any port that wants to leave the bridge will silently
> fail to reserve a private FDB for itself and will just continue to use
> the bridge's one.
>
> This will break behavior which previously worked and it's not something
> that we want.
>
> The following commands demonstrate this unwanted behavior:
>
>	$ ls-addsw --flooding-cfg=DPSW_FLOODING_PER_FDB --broadcast-cfg=DPSW_BROADCAST_PER_FDB
dpni.2 dpni.3 dpmac.3 dpmac.4
>	Created ETHSW object dpsw.0 with the following 4 ports: eth2,eth3,eth4,eth5
>
>	$ ip link add br0 type bridge vlan_filtering 1
>	$ ip link set dev eth2 master br0
>	[  496.653013] fsl_dpaa2_switch dpsw.0 eth2: Joining a bridge, got FDB #1
>	$ ip link set dev eth3 master br0
>	[  544.891083] fsl_dpaa2_switch dpsw.0 eth3: Joining a bridge, got FDB #1
>	$ ip link set dev eth4 master br0
>	[  547.807707] fsl_dpaa2_switch dpsw.0 eth4: Joining a bridge, got FDB #1
>	$ ip link set dev eth5 master br0
>	[  556.491085] fsl_dpaa2_switch dpsw.0 eth5: Joining a bridge, got FDB #1
>
>	$ bridge vlan add vid 10 dev eth2
>	[  667.742585] br0: Using FDB#2 for VLAN 10
>	$ bridge vlan add vid 15 dev eth2
>	[  672.296365] br0: Using FDB#3 for VLAN 15
>	$ bridge vlan add vid 30 dev eth3
>	[  679.156295] br0: Using FDB#4 for VLAN 30
>	$ bridge vlan add vid 35 dev eth3
>	[  682.220775] fsl_dpaa2_switch dpsw.0 eth3: dpsw_fdb_add err -6
>	RTNETLINK answers: No such device or address
>
>	# At this point, there are no more unused FDBs that could be
>	# used for VLAN 35 so the last command fails.
>
>	# We now try to instruct eth5 to leave the bridge. As we can see
>	# below, the driver will continue to use the bridge's FDB for
>	# PVID instead of finding and using a private FDB.
>	$ ip link set dev eth5 nomaster
>	[  841.427875] fsl_dpaa2_switch dpsw.0 eth5: Leaving a bridge, continue to use FDB #1 since
we assume we are the last port to become  standalone
>

I want to check one thing first with you. For dpsw, a 'standalone' interface is not usable, right?
It is just in a state 'standalone' and needs more configurations before we use it for forwarding.
If this is the case, can we just assign all standalone interfaces to a single FDB. Or even no FDB
before they join a bridge. And if there are no VLANs assigned to any port, bridge should
create a shared FDB for them.  So num of FDB is associated with VLAN rather than interfaces.

I'm not sure about this, so I'm trying to make it work in the previous way. But as you see
in your test, it doesn't when you make them leave the bridge. 
If it is, I suggest we follow the new way above. In this way, the max_fdbs could only count
how many VLANs we are going to have. Of source plus 1 extra default FDB for bridge.
Now in this patch I did not take care of VLAN 0. It will create a new FDB. But later, it could
reuse default FDB as well.

>
> The debug prints were added on top of your patch and the diff is below:
>
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
b/drivers/net/ethernet/freescale/dpaa2/dpaa2- switch.c
> index 217c68bb0faa..8d922a70e154 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -81,12 +81,17 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
>  
>                 if (!fdb) {
>                         port_priv->fdb->bridge_dev = NULL;
> +
> +                       netdev_err(port_priv->netdev, "Leaving a bridge, continue to use FDB #%d
since we assume we are the last port to become standalone\n",
> +                                  port_priv->fdb->fdb_id);
>                         return 0;
>                 }
>  
>                 port_priv->fdb = fdb;
>                 port_priv->fdb->in_use = true;
>                 port_priv->fdb->bridge_dev = NULL;
> +
> +               netdev_err(port_priv->netdev, "Leaving a bridge, got FDB #%d\n",
port_priv->fdb->fdb_id);
>                 return 0;
>         }
>  
> @@ -127,6 +132,8 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
>         /* Keep track of the new upper bridge device */
>         port_priv->fdb->bridge_dev = bridge_dev;
>  
> +       netdev_err(port_priv->netdev, "Joining a bridge, got FDB #%d\n", port_priv->fdb->fdb_id);
> +
>         return 0;
>  }
>  
> @@ -240,6 +247,8 @@ static int dpaa2_switch_add_vlan(struct ethsw_port_priv *port_priv, u16 vid)
>                 fdb->in_use = true;
>                 fdb->bridge_dev = NULL;
>                 vcfg.fdb_id = fdb->fdb_id;
> +
> +               netdev_err(port_priv->fdb->bridge_dev, "Using FDB#%d for VLAN %d\n", fdb->fdb_id,
vid);
>         } else {
>                 /* Standalone, port's private fdb shared */
>                 vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
> @@ -444,8 +453,10 @@ static int dpaa2_switch_dellink(struct ethsw_core *ethsw, u16 vid)
>         /* mark fdb as unsued for this vlan */
>         for (i = 0; i < ethsw->sw_attr.max_fdbs; i++) {
>                 fdb = ethsw->fdbs;
> -               if (fdb[i].vid == vid)
> +               if (fdb[i].vid == vid) {
>                         fdb[i].in_use = false;
> +                       dev_err(ethsw->dev, "VLAN %d was removed, FDB #%d no longer in use\n",
vid, fdb[i].fdb_id);
> +               }
>         }
>  
>         for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
> @@ -475,6 +486,8 @@ static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
>         if (err)
>                 netdev_err(port_priv->netdev,
>                            "dpsw_fdb_add_unicast err %d\n", err);
> +
> +       netdev_err(port_priv->netdev, "Added unicast address in FDB #%d\n", fdb_id);
>         return err;
>  }
>
>
> What I would suggest as a possible way to avoid the issue above is to
> set aside at probe time the FDBs which are required for the usecase in
> which all the ports are standalone. If there are more FDBs than the
> number of switch ports, then independent VLAN learning is possible, if
> not the driver should just go ahead and revert to shared VLAN learning.
> In case VLAN learning is shared, the driver could print a warning and
> let the user know why is that and what could be done.
>
Please comment on my question and suggest above.

> > 
> > Signed-off-by: Wan Junjie <junjie.wan@inceptio.ai>
> > ---
> > v2: fix coding style issues
> > ---
> >  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 216 +++++++++++++-----
> >  .../ethernet/freescale/dpaa2/dpaa2-switch.h   |   3 +-
> >  2 files changed, 167 insertions(+), 52 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > index a293b08f36d4..217c68bb0faa 100644
> > --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > @@ -25,8 +25,17 @@
> >  
> >  #define DEFAULT_VLAN_ID			1
> >  
> > -static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv)
> > +static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv, u16 vid)
> >  {
> > +	struct ethsw_core *ethsw = port_priv->ethsw_data;
> > +	int i;
> > +
> > +	if (port_priv->fdb->bridge_dev) {
> > +		for (i = 0; i < ethsw->sw_attr.max_fdbs; i++)
> > +			if (ethsw->fdbs[i].vid == vid)
> > +				return ethsw->fdbs[i].fdb_id;
> > +	}
> > +	/* Default vlan, use port's fdb id directly */
> >  	return port_priv->fdb->fdb_id;
> >  }
> >  
> > @@ -34,7 +43,7 @@ static struct dpaa2_switch_fdb *dpaa2_switch_fdb_get_unused(struct ethsw_core
*e
> >  {
> >  	int i;
> >  
> > -	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
> > +	for (i = 0; i < ethsw->sw_attr.max_fdbs; i++)
> >  		if (!ethsw->fdbs[i].in_use)
> >  			return &ethsw->fdbs[i];
> >  	return NULL;
> > @@ -125,17 +134,29 @@ static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16
fdb_id,
> >  					   enum dpsw_flood_type type,
> >  					   struct dpsw_egress_flood_cfg *cfg)
> >  {
> > -	int i = 0, j;
> > +	u16 vid = 4096;
> > +	int i, j;
> >  
> >  	memset(cfg, 0, sizeof(*cfg));
> >  
> > +	for (i = 0; i < ethsw->sw_attr.max_fdbs; i++) {
> > +		if (ethsw->fdbs[i].fdb_id == fdb_id) {
> > +			vid = ethsw->fdbs[i].vid;
> > +			break;
> > +		}
> > +	}
> > +
> > +	i = 0;
> >  	/* Add all the DPAA2 switch ports found in the same bridging domain to
> >  	 * the egress flooding domain
> >  	 */
> >  	for (j = 0; j < ethsw->sw_attr.num_ifs; j++) {
> >  		if (!ethsw->ports[j])
> >  			continue;
> > -		if (ethsw->ports[j]->fdb->fdb_id != fdb_id)
> > +
> > +		if (vid == 4096 && ethsw->ports[j]->fdb->fdb_id != fdb_id)
> > +			continue;
> > +		if (vid < 4096 && !(ethsw->ports[j]->vlans[vid] & ETHSW_VLAN_MEMBER))
> >  			continue;
> >  
> >  		if (type == DPSW_BROADCAST && ethsw->ports[j]->bcast_flood)
> > @@ -191,10 +212,38 @@ static void *dpaa2_iova_to_virt(struct iommu_domain *domain,
> >  static int dpaa2_switch_add_vlan(struct ethsw_port_priv *port_priv, u16 vid)
> >  {
> >  	struct ethsw_core *ethsw = port_priv->ethsw_data;
> > +	struct net_device *netdev = port_priv->netdev;
> > +	struct dpsw_fdb_cfg fdb_cfg = {0};
> >  	struct dpsw_vlan_cfg vcfg = {0};
> > +	struct dpaa2_switch_fdb *fdb;
> > +	u16 fdb_id;
> >  	int err;
> >  
> > -	vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
> > +	/* If ports are under a bridge, then
> > +	 * every VLAN domain should use a different fdb.
> > +	 * If ports are standalone, and
> > +	 * vid is 1 this should reuse the allocated port fdb.
> > +	 */
> > +	if (port_priv->fdb->bridge_dev) {
> > +		fdb = dpaa2_switch_fdb_get_unused(ethsw);
> > +		if (!fdb) {
> > +			/* if not available, create a new fdb */
> > +			err = dpsw_fdb_add(ethsw->mc_io, 0, ethsw->dpsw_handle,
> > +					   &fdb_id, &fdb_cfg);
> > +			if (err) {
> > +				netdev_err(netdev, "dpsw_fdb_add err %d\n", err);
> > +				return err;
> > +			}
> > +			fdb->fdb_id = fdb_id;
>
>			This leads to a NULL pointer dereference.
>			Variable 'fdb' is NULL in this case and you are
>			trying to assign its fdb_id field.
>
>			What I would suggest is to actually create all
>			the possible FDBs at probe time, initialize them
>			as unused and then just grab them when needed.
>			When there are no more unused FDBs, no more
>			VLANs can be created and an error is returned
>			directly.
Exactly, Simon has noticed this in a previous email. And I have proposed the same as you suggest
here.

> > +		}
> > +		fdb->vid = vid;
> > +		fdb->in_use = true;
> > +		fdb->bridge_dev = NULL;
> > +		vcfg.fdb_id = fdb->fdb_id;
> > +	} else {
> > +		/* Standalone, port's private fdb shared */
> > +		vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
> > +	}
> >  	err = dpsw_vlan_add(ethsw->mc_io, 0,
> >  			    ethsw->dpsw_handle, vid, &vcfg);
> >  	if (err) {
> > @@ -298,7 +347,7 @@ static int dpaa2_switch_port_add_vlan(struct ethsw_port_priv *port_priv,
> >  	 */
> >  	vcfg.num_ifs = 1;
> >  	vcfg.if_id[0] = port_priv->idx;
> > -	vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
> > +	vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
> >  	vcfg.options |= DPSW_VLAN_ADD_IF_OPT_FDB_ID;
> >  	err = dpsw_vlan_add_if(ethsw->mc_io, 0, ethsw->dpsw_handle, vid, &vcfg);
> >  	if (err) {
> > @@ -326,7 +375,7 @@ static int dpaa2_switch_port_add_vlan(struct ethsw_port_priv *port_priv,
> >  			return err;
> >  	}
> >  
> > -	return 0;
> > +	return dpaa2_switch_fdb_set_egress_flood(ethsw, vcfg.fdb_id);
> >  }
> >  
> >  static enum dpsw_stp_state br_stp_state_to_dpsw(u8 state)
> > @@ -379,6 +428,7 @@ static int dpaa2_switch_port_set_stp_state(struct ethsw_port_priv
*port_priv, u8
> >  static int dpaa2_switch_dellink(struct ethsw_core *ethsw, u16 vid)
> >  {
> >  	struct ethsw_port_priv *ppriv_local = NULL;
> > +	struct dpaa2_switch_fdb *fdb = NULL;
> >  	int i, err;
> >  
> >  	if (!ethsw->vlans[vid])
> > @@ -391,6 +441,13 @@ static int dpaa2_switch_dellink(struct ethsw_core *ethsw, u16 vid)
> >  	}
> >  	ethsw->vlans[vid] = 0;
> >  
> > +	/* mark fdb as unsued for this vlan */
>
>	s/unsued/unused/
Oops
> > +	for (i = 0; i < ethsw->sw_attr.max_fdbs; i++) {
> > +		fdb = ethsw->fdbs;
> > +		if (fdb[i].vid == vid)
> > +			fdb[i].in_use = false;
> > +	}
> > +
> >  	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
> >  		ppriv_local = ethsw->ports[i];
> >  		if (ppriv_local)
> > @@ -401,7 +458,7 @@ static int dpaa2_switch_dellink(struct ethsw_core *ethsw, u16 vid)
> >  }
> >  
> >  static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
> > -					const unsigned char *addr)
> > +					const unsigned char *addr, u16 vid)
> >  {
> >  	struct dpsw_fdb_unicast_cfg entry = {0};
> >  	u16 fdb_id;
> > @@ -411,7 +468,7 @@ static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
> >  	entry.type = DPSW_FDB_ENTRY_STATIC;
> >  	ether_addr_copy(entry.mac_addr, addr);
> >  
> > -	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
> > +	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
> >  	err = dpsw_fdb_add_unicast(port_priv->ethsw_data->mc_io, 0,
> >  				   port_priv->ethsw_data->dpsw_handle,
> >  				   fdb_id, &entry);
> > @@ -422,7 +479,7 @@ static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
> >  }
> >  
> >  static int dpaa2_switch_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
> > -					const unsigned char *addr)
> > +					const unsigned char *addr, u16 vid)
> >  {
> >  	struct dpsw_fdb_unicast_cfg entry = {0};
> >  	u16 fdb_id;
> > @@ -432,10 +489,11 @@ static int dpaa2_switch_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
> >  	entry.type = DPSW_FDB_ENTRY_STATIC;
> >  	ether_addr_copy(entry.mac_addr, addr);
> >  
> > -	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
> > +	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
> >  	err = dpsw_fdb_remove_unicast(port_priv->ethsw_data->mc_io, 0,
> >  				      port_priv->ethsw_data->dpsw_handle,
> >  				      fdb_id, &entry);
> > +
> >  	/* Silently discard error for calling multiple times the del command */
> >  	if (err && err != -ENXIO)
> >  		netdev_err(port_priv->netdev,
> > @@ -444,7 +502,7 @@ static int dpaa2_switch_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
> >  }
> >  
> >  static int dpaa2_switch_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
> > -					const unsigned char *addr)
> > +					const unsigned char *addr, u16 vid)
> >  {
> >  	struct dpsw_fdb_multicast_cfg entry = {0};
> >  	u16 fdb_id;
> > @@ -455,7 +513,7 @@ static int dpaa2_switch_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
> >  	entry.num_ifs = 1;
> >  	entry.if_id[0] = port_priv->idx;
> >  
> > -	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
> > +	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
> >  	err = dpsw_fdb_add_multicast(port_priv->ethsw_data->mc_io, 0,
> >  				     port_priv->ethsw_data->dpsw_handle,
> >  				     fdb_id, &entry);
> > @@ -467,7 +525,7 @@ static int dpaa2_switch_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
> >  }
> >  
> >  static int dpaa2_switch_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
> > -					const unsigned char *addr)
> > +					const unsigned char *addr, u16 vid)
> >  {
> >  	struct dpsw_fdb_multicast_cfg entry = {0};
> >  	u16 fdb_id;
> > @@ -478,7 +536,7 @@ static int dpaa2_switch_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
> >  	entry.num_ifs = 1;
> >  	entry.if_id[0] = port_priv->idx;
> >  
> > -	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
> > +	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
> >  	err = dpsw_fdb_remove_multicast(port_priv->ethsw_data->mc_io, 0,
> >  					port_priv->ethsw_data->dpsw_handle,
> >  					fdb_id, &entry);
> > @@ -778,11 +836,12 @@ struct ethsw_dump_ctx {
> >  };
> >  
> >  static int dpaa2_switch_fdb_dump_nl(struct fdb_dump_entry *entry,
> > -				    struct ethsw_dump_ctx *dump)
> > +				    struct ethsw_dump_ctx *dump, u16 vid)
> >  {
> >  	int is_dynamic = entry->type & DPSW_FDB_ENTRY_DINAMIC;
> >  	u32 portid = NETLINK_CB(dump->cb->skb).portid;
> >  	u32 seq = dump->cb->nlh->nlmsg_seq;
> > +	struct ethsw_port_priv *port_priv;
> >  	struct nlmsghdr *nlh;
> >  	struct ndmsg *ndm;
> >  
> > @@ -798,7 +857,7 @@ static int dpaa2_switch_fdb_dump_nl(struct fdb_dump_entry *entry,
> >  	ndm->ndm_family  = AF_BRIDGE;
> >  	ndm->ndm_pad1    = 0;
> >  	ndm->ndm_pad2    = 0;
> > -	ndm->ndm_flags   = NTF_SELF;
> > +	ndm->ndm_flags   = NTF_SELF | NTF_OFFLOADED;
>
> Maybe the changes around the FDB dump could be in a different patch?
>
> Ioana

Sure, Let me split it. But I'm going to have a two-week vacation from tomorrow. 
During this period, I can't work on the patch. You will have to wait a bit long before I return
back to the office. Or if you like, please send a new patch for this as you wish. 

Wan Junjie


