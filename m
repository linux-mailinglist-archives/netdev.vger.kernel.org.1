Return-Path: <netdev+bounces-24197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 893B176F367
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 21:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B721D1C21629
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75D625920;
	Thu,  3 Aug 2023 19:29:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F52514AB6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 19:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98713C433C7;
	Thu,  3 Aug 2023 19:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691090986;
	bh=SzD6mLWXBeRO+za53POXhdBCgv8KiAzF/i4NjDRIS8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0i+JQtBNRBqg3BZOsF012kHvX6aeQoV7b5HpqRsPTW8rqYNjmweL+fpQ/3wGLxAN
	 aZ7j7i0Zcah44YMxFHZCTL8peJL1nLbv0du0/DE/iNwrtRMtGS7nStLQfGfpV6Tl5N
	 gEkUfIOuZziEO01aUc+4LQtLFsY6TfJ+FjdW4ih2hFOe7gXmouosSkOC+dUVHE0SXQ
	 ERWlYXOsDd5dX8jVwdBXBTIeU0bL7DDe5tpGeeS1ctUPdOfzei7FUSSaXoKselhJn/
	 hyJzkxhlJkhaluBldQ7F181vMR5AK87LmcVGCxNE23WNeTdYi/EqBcoNG6+wKmYRzZ
	 4MRsMCq52/K4A==
Date: Thu, 3 Aug 2023 21:29:38 +0200
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Colin Foster <colin.foster@in-advantage.com>
Subject: Re: [PATCH net] net: dsa: ocelot: call dsa_tag_8021q_unregister()
 under rtnl_lock() on driver remove
Message-ID: <ZMwAImhL8nH+6KLf@kernel.org>
References: <20230803134253.2711124-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803134253.2711124-1-vladimir.oltean@nxp.com>

On Thu, Aug 03, 2023 at 04:42:53PM +0300, Vladimir Oltean wrote:
> When the tagging protocol in current use is "ocelot-8021q" and we unbind
> the driver, we see this splat:
> 
> $ echo '0000:00:00.2' > /sys/bus/pci/drivers/fsl_enetc/unbind
> mscc_felix 0000:00:00.5 swp0: left promiscuous mode
> sja1105 spi2.0: Link is Down
> DSA: tree 1 torn down
> mscc_felix 0000:00:00.5 swp2: left promiscuous mode
> sja1105 spi2.2: Link is Down
> DSA: tree 3 torn down
> fsl_enetc 0000:00:00.2 eno2: left promiscuous mode
> mscc_felix 0000:00:00.5: Link is Down
> ------------[ cut here ]------------
> RTNL: assertion failed at net/dsa/tag_8021q.c (409)
> WARNING: CPU: 1 PID: 329 at net/dsa/tag_8021q.c:409 dsa_tag_8021q_unregister+0x12c/0x1a0
> Modules linked in:
> CPU: 1 PID: 329 Comm: bash Not tainted 6.5.0-rc3+ #771
> pc : dsa_tag_8021q_unregister+0x12c/0x1a0
> lr : dsa_tag_8021q_unregister+0x12c/0x1a0
> Call trace:
>  dsa_tag_8021q_unregister+0x12c/0x1a0
>  felix_tag_8021q_teardown+0x130/0x150
>  felix_teardown+0x3c/0xd8
>  dsa_tree_teardown_switches+0xbc/0xe0
>  dsa_unregister_switch+0x168/0x260
>  felix_pci_remove+0x30/0x60
>  pci_device_remove+0x4c/0x100
>  device_release_driver_internal+0x188/0x288
>  device_links_unbind_consumers+0xfc/0x138
>  device_release_driver_internal+0xe0/0x288
>  device_driver_detach+0x24/0x38
>  unbind_store+0xd8/0x108
>  drv_attr_store+0x30/0x50
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> RTNL: assertion failed at net/8021q/vlan_core.c (376)
> WARNING: CPU: 1 PID: 329 at net/8021q/vlan_core.c:376 vlan_vid_del+0x1b8/0x1f0
> CPU: 1 PID: 329 Comm: bash Tainted: G        W          6.5.0-rc3+ #771
> pc : vlan_vid_del+0x1b8/0x1f0
> lr : vlan_vid_del+0x1b8/0x1f0
>  dsa_tag_8021q_unregister+0x8c/0x1a0
>  felix_tag_8021q_teardown+0x130/0x150
>  felix_teardown+0x3c/0xd8
>  dsa_tree_teardown_switches+0xbc/0xe0
>  dsa_unregister_switch+0x168/0x260
>  felix_pci_remove+0x30/0x60
>  pci_device_remove+0x4c/0x100
>  device_release_driver_internal+0x188/0x288
>  device_links_unbind_consumers+0xfc/0x138
>  device_release_driver_internal+0xe0/0x288
>  device_driver_detach+0x24/0x38
>  unbind_store+0xd8/0x108
>  drv_attr_store+0x30/0x50
> DSA: tree 0 torn down
> 
> This was somewhat not so easy to spot, because "ocelot-8021q" is not the
> default tagging protocol, and thus, not everyone who tests the unbinding
> path may have switched to it beforehand. The default
> felix_tag_npi_teardown() does not require rtnl_lock() to be held.
> 
> Fixes: 7c83a7c539ab ("net: dsa: add a second tagger for Ocelot switches based on tag_8021q")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/ocelot/felix.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
> index fd7eb4a52918..9a3e5ec16972 100644
> --- a/drivers/net/dsa/ocelot/felix.c
> +++ b/drivers/net/dsa/ocelot/felix.c
> @@ -1619,8 +1619,10 @@ static void felix_teardown(struct dsa_switch *ds)
>  	struct felix *felix = ocelot_to_felix(ocelot);
>  	struct dsa_port *dp;
>  
> +	rtnl_lock();
>  	if (felix->tag_proto_ops)
>  		felix->tag_proto_ops->teardown(ds);
> +	rtnl_unlock();

Hi Vladimir,

I am curious to know if RTNL could be taken in
felix_tag_8021q_teardown() instead.

>  
>  	dsa_switch_for_each_available_port(dp, ds)
>  		ocelot_deinit_port(ocelot, dp->index);
> -- 
> 2.34.1
> 
> 

