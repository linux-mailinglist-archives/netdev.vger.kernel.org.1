Return-Path: <netdev+bounces-108469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CF8923EC3
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5D41F21F6E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7F21B47A5;
	Tue,  2 Jul 2024 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoaspPxJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038E1AD9E7;
	Tue,  2 Jul 2024 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926450; cv=none; b=cZpnGZoaGWsSoRBfDAEiZINL2OoHKnA/TFZt4H5m6k8I+aduNsX06R7bBS1boEt/mJGKXFjkWMapu39plW5b7z7q4BYCyhBqhO0xYDE5pdxPL5MZWwnVtoA5o3RQoWCVt5nrvPmYu6U+7n8biWkL5Mu0JpXr2nT/XeV3ML1rLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926450; c=relaxed/simple;
	bh=YzMgt8NPVbiKvdfIVs9fw6Z/6jwp6e5dkQwwcuxR/8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2YRFrXZAmH6JbhYwRc2OZooyzsFzXsZpU3IuS0+KcWJJcwW9KhtNj+0gVJAqFb0RsxzhqxirKlSTrpGpTlvv9gcKtnk0S8Gw5HICGK6tjyXaqZ5gg6/vw8qhq23/X16QV2c1tqHP1eqMO3OSnToxmvmoXDiY9EqWuY/650uvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoaspPxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEA7C4AF0F;
	Tue,  2 Jul 2024 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719926449;
	bh=YzMgt8NPVbiKvdfIVs9fw6Z/6jwp6e5dkQwwcuxR/8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoaspPxJLCtu0LeiMfVbFVCsUYc/tJW4q8C/k3mSfU/LkdFURAMJbUg5dklJme7uR
	 CvltNQJfiW3TcOky1rr9VgKNUymiIFXFJUgaCcX/SaMYkdO4SCCks94bGqKSiAioey
	 FnTCktpMEoEW48FGKnRltWieiLYAdw9aTWmIXh440uFESxW4yprvLMajh9CY8HqbyL
	 EAVhMR12j65EpsIWd5pYaWryTho/5bdIE6BU7/RL/dKulripMIcnVeSkVgtsLw7SdY
	 jjhq1iRviXxVWrYFKLGJbqIpyF0MbfkyZVN1/bX4+ArzYcdEM8nPXCrNomndkyjnvk
	 wWC/6/JCw5dAw==
Date: Tue, 2 Jul 2024 14:20:44 +0100
From: Simon Horman <horms@kernel.org>
To: Peter Yin <peteryin.openbmc@gmail.com>
Cc: patrick@stwcx.xyz, amithash@meta.com,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Cosmo Chou <cosmo.chou@quantatw.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/1] net/ncsi: specify maximum package to probe
Message-ID: <20240702132044.GA615643@kernel.org>
References: <20240701154336.3536924-1-peteryin.openbmc@gmail.com>
 <20240702130024.GJ598357@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702130024.GJ598357@kernel.org>

[ + netdev, which I accidently dropped from the CC list ]

On Tue, Jul 02, 2024 at 02:00:30PM +0100, Simon Horman wrote:
> [ As this seems to relate to: DT, ASPEED and ARM, CC:
>   Rob Herring, Krzysztof Kozlowski, Conor Dooley, Joel Stanley, Andrew Jeffery,
>   devicetree, linux-arm-kernel, linux-aspeed. ]
> 
> On Mon, Jul 01, 2024 at 11:43:36PM +0800, Peter Yin wrote:
> > Most NICs have a single package. For OCP3.0 NICs, the package ID is
> > determined by the slot ID. Probing all 8 package IDs is usually
> > unnecessary. To reduce probe time, add properties to specify the
> > maximum number of packages.
> > 
> > Signed-off-by: Cosmo Chou <cosmo.chou@quantatw.com>
> > Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> > ---
> >  net/ncsi/internal.h    |  1 +
> >  net/ncsi/ncsi-manage.c | 16 ++++++++++++----
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
> > index ef0f8f73826f..bd7ad0bf803f 100644
> > --- a/net/ncsi/internal.h
> > +++ b/net/ncsi/internal.h
> > @@ -341,6 +341,7 @@ struct ncsi_dev_priv {
> >  #define NCSI_MAX_VLAN_VIDS	15
> >  	struct list_head    vlan_vids;       /* List of active VLAN IDs */
> >  
> > +	unsigned int        max_package;     /* Num of packages to probe   */
> >  	bool                multi_package;   /* Enable multiple packages   */
> >  	bool                mlx_multi_host;  /* Enable multi host Mellanox */
> >  	u32                 package_whitelist; /* Packages to configure    */
> > diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> > index 5ecf611c8820..159943ee1317 100644
> > --- a/net/ncsi/ncsi-manage.c
> > +++ b/net/ncsi/ncsi-manage.c
> > @@ -1358,12 +1358,12 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
> >  		nd->state = ncsi_dev_state_probe_deselect;
> >  		fallthrough;
> >  	case ncsi_dev_state_probe_deselect:
> > -		ndp->pending_req_num = 8;
> > +		ndp->pending_req_num = ndp->max_package;
> >  
> >  		/* Deselect all possible packages */
> >  		nca.type = NCSI_PKT_CMD_DP;
> >  		nca.channel = NCSI_RESERVED_CHANNEL;
> > -		for (index = 0; index < 8; index++) {
> > +		for (index = 0; index < ndp->max_package; index++) {
> >  			nca.package = index;
> >  			ret = ncsi_xmit_cmd(&nca);
> >  			if (ret)
> > @@ -1491,7 +1491,7 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
> >  
> >  		/* Probe next package */
> >  		ndp->package_probe_id++;
> > -		if (ndp->package_probe_id >= 8) {
> > +		if (ndp->package_probe_id >= ndp->max_package) {
> >  			/* Probe finished */
> >  			ndp->flags |= NCSI_DEV_PROBED;
> >  			break;
> > @@ -1746,7 +1746,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
> >  	struct platform_device *pdev;
> >  	struct device_node *np;
> >  	unsigned long flags;
> > -	int i;
> > +	int i, ret;
> >  
> >  	/* Check if the device has been registered or not */
> >  	nd = ncsi_find_dev(dev);
> > @@ -1795,6 +1795,14 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
> >  		if (np && (of_property_read_bool(np, "mellanox,multi-host") ||
> >  			   of_property_read_bool(np, "mlx,multi-host")))
> >  			ndp->mlx_multi_host = true;
> > +
> 
> Should the "ncsi-package" (and above multi-host properties) be
> documented in DT bindings somewhere? I was unable to locate such
> documentation.
> 
> > +		if (np) {
> > +			ret = of_property_read_u32(np, "ncsi-package",
> > +						   &ndp->max_package);
> > +			if (ret || !ndp->max_package ||
> > +			    ndp->max_package > NCSI_MAX_PACKAGE)
> > +				ndp->max_package = NCSI_MAX_PACKAGE;
> > +		}
> >  	}
> 
> It seems that ndp->max_package will be 0 unless pdev != NULL and np != NULL.
> Would it be better set to NCSI_MAX_PACKAGE in such cases?
> 
> >  
> >  	return nd;
> > -- 
> > 2.25.1
> > 
> > 

