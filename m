Return-Path: <netdev+bounces-241967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3F4C8B24E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF783A58A9
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0DE33A00A;
	Wed, 26 Nov 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJPXZNn9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384A31E231E
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177049; cv=none; b=a3/EV3Orw3zFwSD3oVrHky90TPBRtXwyp5x3c7YTX8g7REtp9gnlA6C7Me3eOUMO4yy4gdwKyuTFt/eKsGSUzcCSYwQVWnjZjmlouoZq+KND/mUlKY9ZnbhWOrSisjHkPSDSPgZVtvYEzPOGZQjEDvm67usLF8kGt4Izz9h3neM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177049; c=relaxed/simple;
	bh=DdgmFLHLd31gAoRxTAe/7gSMmXxXIZvrnIWTUIvdJLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7kVq2cYXUrqpndO3jUMQ5FEpvxXzrpU15+70yLyZAIM4EiIfQK5nnqspfomWK6dktcZlCESl72sxjnaWBCRE88rwvdKEj3Lq6Lju11tBczBCch+JdXzt1Xm9E8hURSM1nmVywRmvQwTLehnGUBj4C6Ys2Vqy/9nRj0WhNNNDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJPXZNn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74038C4CEF7;
	Wed, 26 Nov 2025 17:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764177048;
	bh=DdgmFLHLd31gAoRxTAe/7gSMmXxXIZvrnIWTUIvdJLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJPXZNn9YadHwZKOe9LpfqJ2JD0iM9MVCeOt7oTseQ4x9ast17puZfmk4qFmVWvpd
	 MiqUNPkwyuwyWATzpIiQUXczEmliSPC6DW/siLKFlkU8nYMeBD8apZLzqKkBgyVX4c
	 4s3KpW4AtSXCaSAwxVrroFrOgX5UapaqNKeoYeAtx6Iu5/JTc670EGNRH1SPV1TrU7
	 msaZOOSJd87dSEvISKuYKEs81k8/ARopCAkematbPrU8P0b2i9n4xPVxa3NF+hgGh2
	 1SkD6HHA3f/Tl4K3J9Yfuq24Nw209+8b7GWz9cs+BuA38Zry7YBYRIL3VgtQgP7cOC
	 dYz0l8FVhjEsQ==
Date: Wed, 26 Nov 2025 17:10:43 +0000
From: Simon Horman <horms@kernel.org>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, decot@google.com, willemb@google.com,
	joshua.a.hay@intel.com, madhu.chittim@intel.com,
	aleksander.lobakin@intel.com, larysa.zaremba@intel.com,
	iamvivekkumar@google.com
Subject: Re: [PATCH iwl-net v2 2/5] idpf: detach and close netdevs while
 handling a reset
Message-ID: <aSc0k8qUqQyXr3VV@horms.kernel.org>
References: <20251121001218.4565-1-emil.s.tantilov@intel.com>
 <20251121001218.4565-3-emil.s.tantilov@intel.com>
 <aSWyYIsoXNlpsQn-@horms.kernel.org>
 <3e9dc8fd-9052-4c53-ba40-5904306d09fb@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e9dc8fd-9052-4c53-ba40-5904306d09fb@intel.com>

On Tue, Nov 25, 2025 at 06:58:37AM -0800, Tantilov, Emil S wrote:
> 
> 
> On 11/25/2025 5:42 AM, Simon Horman wrote:
> > On Thu, Nov 20, 2025 at 04:12:15PM -0800, Emil Tantilov wrote:
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > > index 2a53f3d504d2..5c81f52db266 100644
> > > --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > > +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > > @@ -752,6 +752,65 @@ static int idpf_init_mac_addr(struct idpf_vport *vport,
> > >   	return 0;
> > >   }
> > > +static void idpf_detach_and_close(struct idpf_adapter *adapter)
> > > +{
> > > +	int max_vports = adapter->max_vports;
> > > +
> > > +	for (int i = 0; i < max_vports; i++) {
> > > +		struct net_device *netdev = adapter->netdevs[i];
> > > +
> > > +		/* If the interface is in detached state, that means the
> > > +		 * previous reset was not handled successfully for this
> > > +		 * vport.
> > > +		 */
> > > +		if (!netif_device_present(netdev))
> > > +			continue;
> > > +
> > > +		/* Hold RTNL to protect racing with callbacks */
> > > +		rtnl_lock();
> > > +		netif_device_detach(netdev);
> > > +		if (netif_running(netdev)) {
> > > +			set_bit(IDPF_VPORT_UP_REQUESTED,
> > > +				adapter->vport_config[i]->flags);
> > > +			dev_close(netdev);
> > > +		}
> > > +		rtnl_unlock();
> > > +	}
> > > +}
> > > +
> > > +static void idpf_attach_and_open(struct idpf_adapter *adapter)
> > > +{
> > > +	int max_vports = adapter->max_vports;
> > > +
> > > +	for (int i = 0; i < max_vports; i++) {
> > > +		struct idpf_vport *vport = adapter->vports[i];
> > > +		struct idpf_vport_config *vport_config;
> > > +		struct net_device *netdev;
> > > +
> > > +		/* In case of a critical error in the init task, the vport
> > > +		 * will be freed. Only continue to restore the netdevs
> > > +		 * if the vport is allocated.
> > > +		 */
> > > +		if (!vport)
> > > +			continue;
> > > +
> > > +		/* No need for RTNL on attach as this function is called
> > > +		 * following detach and dev_close(). We do take RTNL for
> > > +		 * dev_open() below as it can race with external callbacks
> > > +		 * following the call to netif_device_attach().
> > > +		 */
> > > +		netdev = adapter->netdevs[i];
> > > +		netif_device_attach(netdev);
> > > +		vport_config = adapter->vport_config[vport->idx];
> > > +		if (test_and_clear_bit(IDPF_VPORT_UP_REQUESTED,
> > > +				       vport_config->flags)) {
> > > +			rtnl_lock();
> > > +			dev_open(netdev, NULL);
> > > +			rtnl_unlock();
> > > +		}
> > > +	}
> > > +}
> > > +
> > >   /**
> > >    * idpf_cfg_netdev - Allocate, configure and register a netdev
> > >    * @vport: main vport structure
> > 
> > ...
> > 
> > > @@ -1807,27 +1860,6 @@ static int idpf_check_reset_complete(struct idpf_hw *hw,
> > >   	return -EBUSY;
> > >   }
> > > -/**
> > > - * idpf_set_vport_state - Set the vport state to be after the reset
> > > - * @adapter: Driver specific private structure
> > > - */
> > > -static void idpf_set_vport_state(struct idpf_adapter *adapter)
> > > -{
> > > -	u16 i;
> > > -
> > > -	for (i = 0; i < adapter->max_vports; i++) {
> > > -		struct idpf_netdev_priv *np;
> > > -
> > > -		if (!adapter->netdevs[i])
> > > -			continue;
> > > -
> > > -		np = netdev_priv(adapter->netdevs[i]);
> > > -		if (np->state == __IDPF_VPORT_UP)
> > > -			set_bit(IDPF_VPORT_UP_REQUESTED,
> > > -				adapter->vport_config[i]->flags);
> > > -	}
> > > -}
> > > -
> > >   /**
> > >    * idpf_init_hard_reset - Initiate a hardware reset
> > >    * @adapter: Driver specific private structure
> > 
> > > @@ -1836,28 +1868,17 @@ static void idpf_set_vport_state(struct idpf_adapter *adapter)
> > >    * reallocate. Also reinitialize the mailbox. Return 0 on success,
> > >    * negative on failure.
> > >    */
> > > -static int idpf_init_hard_reset(struct idpf_adapter *adapter)
> > > +static void idpf_init_hard_reset(struct idpf_adapter *adapter)
> > >   {
> > >   	struct idpf_reg_ops *reg_ops = &adapter->dev_ops.reg_ops;
> > >   	struct device *dev = &adapter->pdev->dev;
> > > -	struct net_device *netdev;
> > >   	int err;
> > > -	u16 i;
> > > +	idpf_detach_and_close(adapter);
> > >   	mutex_lock(&adapter->vport_ctrl_lock);
> > >   	dev_info(dev, "Device HW Reset initiated\n");
> > > -	/* Avoid TX hangs on reset */
> > > -	for (i = 0; i < adapter->max_vports; i++) {
> > > -		netdev = adapter->netdevs[i];
> > > -		if (!netdev)
> > > -			continue;
> > 
> > Hi Emil,
> > 
> > In this code that is removed there is a check for !netdev.
> > And also there is a similar check in idpf_set_vport_state().
> > But there is no such check in idpf_detach_and_close().
> > Is this intentional?
> 
> This logic is a bit confusing because the reset path is executed on both
> driver load and a reset (since the initialization is identical it makes
> sense to re-use the code). This is what roughly happens on load and
> reset:
> 
> driver load -> reset -> configure vports -> create netdevs
> reset -> de-allocate vports -> re-allocate vports
> 
> The first patch:
> https://lore.kernel.org/intel-wired-lan/20251121001218.4565-2-emil.s.tantilov@intel.com/
> 
> makes sure that we never lose the netdev on a reset, following a
> successful driver load. Previously this could happen in the error path.
> In other words during a reset there is no need to check for a netdev as
> this is guaranteed, but we must make sure that vports are present as
> those can be freed.
> 
> The 5th patch:
> https://lore.kernel.org/intel-wired-lan/20251121001218.4565-6-emil.s.tantilov@intel.com/
> 
> fixes another instance where we could fail in the reset error path by
> ensuring the service task, which handles resets is cancelled as at
> that point we have neither vports, nor netdevs, hence nothing to
> "serve". Hope this makes sense, but the gist of it is that with this
> series applied the reset can be protected by just making sure that
> the vports are allocated. If for whatever reason netdevs happen to
> be NULL, following this series it would be a bug introduced somewhere
> else in the code that will have to be addressed.

I did spend a bit of time trying to figure out the flow,
but not entirely successfully. Thanks for setting me straight.

...

