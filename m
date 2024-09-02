Return-Path: <netdev+bounces-124199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA069687BE
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7CAB23267
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E3919C540;
	Mon,  2 Sep 2024 12:43:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD019E99E;
	Mon,  2 Sep 2024 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281015; cv=none; b=kyWW2pR52kGvKnF8vBFtRbriIoe+yjidg8M469GWvmxP3xx2wUtyQoRKU+PQbxN0h54F5oQ/VIAK9dFh6ry1jxb1gg8QBfTkpZO3JnHhgZRBUMoDSdAsugCEf9pLOrs2KS205x/ef2PYQ0Ht7/cj1AQeej8lheyaELDbsjUgLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281015; c=relaxed/simple;
	bh=QqLgtho2VPe4uk3Z/TNXYAPGt2xMCUiSaF4pv/07XkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C34AYOaD4C5GjA/yP+PW4/+G8VOoWAE+2chB7KM7lQB+G5J3/1mQHtLAH5svJ1IsXSEducvo2zXuyVO6OajXhdV3N+tiCGoDpSXCT8OvGc+TNKujLSENnvRwvI5yRKj41uDB5tq6t7qM/NyG6mRrGiaZn1hj991DvyUdp6A12ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inceptio.ai; spf=pass smtp.mailfrom=inceptio.ai; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inceptio.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inceptio.ai
Received: from localhost.localdomain(mailfrom:junjie.wan@inceptio.ai fp:SMTPD_---.Z8k9nMo_1725280998)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 20:43:23 +0800
From: Wan Junjie <junjie.wan@inceptio.ai>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	ioana.ciornei@nxp.com,
	junjie.wan@inceptio.ai,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v2] dpaa2-switch: fix flooding domain among multiple vlans
Date: Mon,  2 Sep 2024 20:43:18 +0800
Message-Id: <20240902124318.263883-1-junjie.wan@inceptio.ai>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902105714.GH23170@kernel.org>
References: <20240902105714.GH23170@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Mon, Sep 02, 2024 at 09:50:51AM +0800, Wan Junjie wrote:
> > Currently, dpaa2 switch only cares dst mac and egress interface
> > in FDB. And all ports with different vlans share the same FDB.
> > 
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
> > 
> > Signed-off-by: Wan Junjie <junjie.wan@inceptio.ai>
>
> Hi Wan Junjie,
>
> Some minor feedback from my side.
>
> ...

Hi Simon Horman,

Thanks for your commnets.

> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > index a293b08f36d4..217c68bb0faa 100644
> > --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > @@ -25,8 +25,17 @@
> >  
> >  #define DEFAULT_VLAN_ID			1
> >  
> > -static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv)
> > +static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv, u16 vid)
> 
> This, and several other lines in this patch, could be trivially
> line wrapped in order for them to be <= 80 columns wide, as is
> still preferred in Networking code.
> 
> This and a number of other minor problems are flagged by:
> ./scripts/checkpatch.pl --strict --codespell --max-line-length=80

It is hard to keep all lines limited to the length of 80 since some function
names are really long. I have tried to make the line length to 85 without
breaking some if conditions into multiple lines. You will see in v3.

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
> 
> ...
> 
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
> 
> fdb is still NULL here. Based on my reading of dpaa2_switch_port_init()
> I think you need the following. Possibly also with an error check.
> 
> 			fdb = dpaa2_switch_fdb_get_unused(ethsw);
> 
> Flagged by Smatch.

Nice catch. The fdb is not assigned anyway. And num of fdbs is limited by HW.
So here I can do a judge instead of creating a new one.
	if (port_priv->fdb->bridge_dev) {
		fdb = dpaa2_switch_fdb_get_unused(ethsw);
		if (!fdb) {
			netdev_err(netdev, "vlan nums reach max_fdbs limits\n");
			return -ENOENT;
		}

Thank you.

> > +			fdb->fdb_id = fdb_id;
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
> 
> ...


