Return-Path: <netdev+bounces-14153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D036473F4C4
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 08:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6CD1C20A3F
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 06:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07B379F2;
	Tue, 27 Jun 2023 06:46:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2120F3
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:46:46 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121C0194
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 23:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687848405; x=1719384405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GZgeDmX0WNtdX3Q+sQKsNg1N8SVJMfrKyXLDmK8NE34=;
  b=CRqB7oc3uDdWMBhZqCLmzONeYwzyemksHKtXxRsKyezH1LvKjFC19o7N
   cK6zGzyt+8cVySazqcHn/KEQtbsDJdyx8Y1v/v8wMImofLPBXdKWkYZeB
   hllJ6YWmrqgKarHwwhopxpnBv8YEKCiFrqiiaTb/13/ffXGuurq9wvJQw
   JEU890NUnW/yS9bZzU2WpV/dXzpAkj4ttqjwkVVBKMneyIhD5NzQHgcbB
   4cHrLgIIVBYE78tlBX1V729xyrdhrO3M3f037iuvYb9TAvNnqRdUu6yes
   0sdYfF1EoajBAmWpaETLBCV5qWJmT0Xr+M3PQ9cBv8bbrSszGGXeI4AVI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="341833480"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="341833480"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 23:46:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="781740963"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="781740963"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 23:46:41 -0700
Date: Tue, 27 Jun 2023 08:46:38 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, Wojciech Drewek <wojciech.drewek@intel.com>,
	jiri@resnulli.us, ivecera@redhat.com, simon.horman@corigine.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next 06/12] ice: Implement basic eswitch bridge setup
Message-ID: <ZJqFzmzilCHCbqXH@localhost.localdomain>
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
 <20230620174423.4144938-7-anthony.l.nguyen@intel.com>
 <ZJmgB9fUPE+nfmoh@localhost.localdomain>
 <871qhyuwa5.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qhyuwa5.fsf@nvidia.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 05:31:14PM +0300, Vlad Buslov wrote:
> On Mon 26 Jun 2023 at 16:26, Michal Swiatkowski <michal.swiatkowski@linux.intel.com> wrote:
> > On Tue, Jun 20, 2023 at 10:44:17AM -0700, Tony Nguyen wrote:
> >> From: Wojciech Drewek <wojciech.drewek@intel.com>
> >> 
> >> With this patch, ice driver is able to track if the port
> >> representors or uplink port were added to the linux bridge in
> >> switchdev mode. Listen for NETDEV_CHANGEUPPER events in order to
> >> detect this. ice_esw_br data structure reflects the linux bridge
> >> and stores all the ports of the bridge (ice_esw_br_port) in
> >> xarray, it's created when the first port is added to the bridge and
> >> freed once the last port is removed. Note that only one bridge is
> >> supported per eswitch.
> >> 
> >> Bridge port (ice_esw_br_port) can be either a VF port representor
> >> port or uplink port (ice_esw_br_port_type). In both cases bridge port
> >> holds a reference to the VSI, VF's VSI in case of the PR and uplink
> >> VSI in case of the uplink. VSI's index is used as an index to the
> >> xarray in which ports are stored.
> >> 
> >> Add a check which prevents configuring switchdev mode if uplink is
> >> already added to any bridge. This is needed because we need to listen
> >> for NETDEV_CHANGEUPPER events to record if the uplink was added to
> >> the bridge. Netdevice notifier is registered after eswitch mode
> >> is changed to switchdev.
> >> 
> >> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> >> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> >> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> >> ---
> >>  drivers/net/ethernet/intel/ice/Makefile       |   2 +-
> >>  drivers/net/ethernet/intel/ice/ice.h          |   4 +-
> >>  drivers/net/ethernet/intel/ice/ice_eswitch.c  |  26 +-
> >>  .../net/ethernet/intel/ice/ice_eswitch_br.c   | 384 ++++++++++++++++++
> >>  .../net/ethernet/intel/ice/ice_eswitch_br.h   |  42 ++
> >>  drivers/net/ethernet/intel/ice/ice_main.c     |   2 +-
> >>  drivers/net/ethernet/intel/ice/ice_repr.c     |   2 +-
> >>  drivers/net/ethernet/intel/ice/ice_repr.h     |   3 +-
> >>  8 files changed, 456 insertions(+), 9 deletions(-)
> >>  create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> >>  create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> >> +
> >> +static int
> >> +ice_eswitch_br_port_changeupper(struct notifier_block *nb, void *ptr)
> >> +{
> >> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> >> +	struct netdev_notifier_changeupper_info *info = ptr;
> >> +	struct ice_esw_br_offloads *br_offloads;
> >> +	struct netlink_ext_ack *extack;
> >> +	struct net_device *upper;
> >> +
> >> +	br_offloads = ice_nb_to_br_offloads(nb, netdev_nb);
> >> +
> >> +	if (!ice_eswitch_br_is_dev_valid(dev))
> >> +		return 0;
> >> +
> >> +	upper = info->upper_dev;
> >> +	if (!netif_is_bridge_master(upper))
> >> +		return 0;
> >> +
> >> +	extack = netdev_notifier_info_to_extack(&info->info);
> >> +
> >> +	if (info->linking)
> >> +		return ice_eswitch_br_port_link(br_offloads, dev,
> >> +						upper->ifindex, extack);
> >> +	else
> >> +		return ice_eswitch_br_port_unlink(br_offloads, dev,
> >> +						  upper->ifindex, extack);
> >> +}
> >> +
> >> +static int
> >> +ice_eswitch_br_port_event(struct notifier_block *nb,
> >> +			  unsigned long event, void *ptr)
> >> +{
> >> +	int err = 0;
> >> +
> >> +	switch (event) {
> >> +	case NETDEV_CHANGEUPPER:
> >> +		err = ice_eswitch_br_port_changeupper(nb, ptr);
> >> +		break;
> >> +	}
> >> +
> >> +	return notifier_from_errno(err);
> >> +}
> > Hi Vlad,
> >
> > We found out that adding VF and corresponding port representor to the
> > bridge cause loop in the bridge. Packets are looping through the bridge.
> > I know that it isn't valid configuration, howevere, it can happen and
> > after that the server is quite unstable.
> >
> > Does mellanox validate the port for this scenario? Or we should assume
> > that user will add port wisely? I was looking at your code, but didn't
> > find that. You are using NETDEV_PRECHANGEUPPER, do you think we should
> > validate if user is trying to add VF when his PR is currently added?
> 
> Hmm, no, it is not something we validate. Also, I assume it will be
> quite tricky to properly test for it, since user could try to add some
> other netdevice connected to the VF (VLAN, tunneling dev, bonding, etc.)
> which will probably lead to same result.
> 

Agree, thanks. As Jakub wrote, STP should be turned on to prevent this kind
of problem.

