Return-Path: <netdev+bounces-95401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D730E8C22BF
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E177283583
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B0D16EC06;
	Fri, 10 May 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KhEMRQeb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE4016D4CE
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339141; cv=none; b=VpNcIaKAg/+7Krld7Z5Aj5iL9ThTwZc2ZbFwUc6daBPCh4yJSHzKePBPDR7JolwCvat32MkBLOy1bbKSkR22I/ipQAWQkdC/hQVevVbfUYJfopw2KhOnWP2tlelY+WvNh6KVXTr6Jb0l7gpSzoEsONbR/L8BL3myUxcNuEumwGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339141; c=relaxed/simple;
	bh=IdD0geyCgha8VS/BJJbZ2rMQETiQIKdL30h5k0jCJsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAi2lVSdL76dHSaGAXoOPqh043EID6ghqF3skyh5pneq21Lxf0y9ZnXN2Z9NPiEYSAaK+8ooKickV69PSmZDuQOCVOcTlAN6WKC/cPiZBlmee+OiikJbGkxIQg8854GN7+rbPgX9Rhxj+BXOZInCsk9aAWiRmMuKv7kqiU9htQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KhEMRQeb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b7a26326eso13383825e9.3
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 04:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715339137; x=1715943937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIzMd3pmerCGCWxaOFrSvqqI66QCicZGgwtZuHgdqfA=;
        b=KhEMRQebtc31Wxb2tfm5Y9stJ7t/HkRiljLnR1zC3hTR9ovSlDNwowcWurgtQQyhxE
         V3cuPAohLwFYJVhBtR290B3P/jokXZC0Th9ZHnFkssA4gMIq7umEsk+MKSuREeol5HmI
         bd/iiQu466NnbZ1Mq8iyCjmk+KSYAjkhb9vZvofQbSQQT4eIYY/EWuYaA0JHGIwzQrgq
         PE+Wk0fXTnjJFk1R1zAWrnXqkPKP2TBZd2tltxkOOV2lUYlNyN0kVvIoX5KmNcB7yJin
         Cq30L0qKf9WPCJOUOR6DDVhZBXWJ/GQLcHHlLL6/VHnjCisb69D+bJenqbSzEEZxubHi
         0rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339137; x=1715943937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIzMd3pmerCGCWxaOFrSvqqI66QCicZGgwtZuHgdqfA=;
        b=eBHvXUG2yWpq0z2oPY1WgKj8HY3tufj4QOYfUhT6Cl483BehJxGoK4jP1+/FEkXR0x
         SxQhxMzMFt98cf6b2GbJobfygwa+KnY20hYlWN9xkvOyx7DBDUP2943q9U1fEbb4cX7h
         Y0t+m5wB2jnDe/M7dRqZZaItuFxeva4JNKiFQ3eTiQmMXhD04GSVrXGwHxOonVx02iX1
         Q6GtyfwMAxXmYIYOESLTkV+o2SKIHQ79jBZp7vYyjXYkNu8hxkEjKyMAhF2w37j9kk4F
         aHpDtikvhK7a9EE2UauXEhgTVg9AxE9J8jUWlyuhoOjNPdMAnYkXqVS6LZr37kHLCgsR
         PZLA==
X-Forwarded-Encrypted: i=1; AJvYcCV8JunrXCxmZfgtD5PsaajPG4GVgFk/78Lh94SL5zHKeY7IimobJeW7bnozje+awprk/QdmHhxMUQ0jAa7ZYPyZU5DKROs7
X-Gm-Message-State: AOJu0Yzz3Hmjou9iY/1HusABjoGSxnvZghOgzwCnlbrszbecO6Yd+ueB
	noQ5o6PKB2JxI9qk3+xYMLO061B0Sqc7eIRe2MfWTqQZMtVhmHSntQWpCuf4e9A=
X-Google-Smtp-Source: AGHT+IGAvltDozpPCODHuDAohCnPruKVr3r91Fm6AKklrkFBI3T8y9GyCvQrTCwwbNIa/xKEYrxYHg==
X-Received: by 2002:a5d:618d:0:b0:34c:9393:4c29 with SMTP id ffacd0b85a97d-3504a737a07mr1720129f8f.21.1715339136535;
        Fri, 10 May 2024 04:05:36 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bd09sm4244662f8f.14.2024.05.10.04.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:05:35 -0700 (PDT)
Date: Fri, 10 May 2024 13:05:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 03/14] ice: add basic devlink subfunctions support
Message-ID: <Zj3_fVh2QD7awpWN@nanopsycho.orion>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-4-michal.swiatkowski@linux.intel.com>
 <ZjyuTA_zMXzZSa7L@nanopsycho.orion>
 <Zj3JLw/mT/MZJu9G@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj3JLw/mT/MZJu9G@mev-dev>

Fri, May 10, 2024 at 09:13:51AM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Thu, May 09, 2024 at 01:06:52PM +0200, Jiri Pirko wrote:
>> Tue, May 07, 2024 at 01:45:04PM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >From: Piotr Raczynski <piotr.raczynski@intel.com>
>> >
>> >Implement devlink port handlers responsible for ethernet type devlink
>> >subfunctions. Create subfunction devlink port and setup all resources
>> >needed for a subfunction netdev to operate. Configure new VSI for each
>> >new subfunction, initialize and configure interrupts and Tx/Rx resources.
>> >Set correct MAC filters and create new netdev.
>> >
>> >For now, subfunction is limited to only one Tx/Rx queue pair.
>> >
>> >Only allocate new subfunction VSI with devlink port new command.
>> >This makes sure that real resources are configured only when a new
>> >subfunction gets activated. Allocate and free subfunction MSIX
>> 
>> Interesting. You talk about actitation, yet you don't implement it here.
>> 
>
>I will rephrase it. I meant that new VSI needs to be created even before
>any activation or configuration.
>
>> 
>> 
>> >interrupt vectors using new API calls with pci_msix_alloc_irq_at
>> >and pci_msix_free_irq.
>> >
>> >Support both automatic and manual subfunction numbers. If no subfunction
>> >number is provided, use xa_alloc to pick a number automatically. This
>> >will find the first free index and use that as the number. This reduces
>> >burden on users in the simple case where a specific number is not
>> >required. It may also be slightly faster to check that a number exists
>> >since xarray lookup should be faster than a linear scan of the dyn_ports
>> >xarray.
>> >
>> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> >Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
>> >Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> >---
>> > .../net/ethernet/intel/ice/devlink/devlink.c  |   3 +
>> > .../ethernet/intel/ice/devlink/devlink_port.c | 357 ++++++++++++++++++
>> > .../ethernet/intel/ice/devlink/devlink_port.h |  33 ++
>> > drivers/net/ethernet/intel/ice/ice.h          |   4 +
>> > drivers/net/ethernet/intel/ice/ice_lib.c      |   5 +-
>> > drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
>> > drivers/net/ethernet/intel/ice/ice_main.c     |   9 +-
>> > 7 files changed, 410 insertions(+), 3 deletions(-)
>> >
>> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> >index 10073342e4f0..3fb3a7e828a4 100644
>> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> >@@ -6,6 +6,7 @@
>> > #include "ice.h"
>> > #include "ice_lib.h"
>> > #include "devlink.h"
>> >+#include "devlink_port.h"
>> > #include "ice_eswitch.h"
>> > #include "ice_fw_update.h"
>> > #include "ice_dcb_lib.h"
>> >@@ -1277,6 +1278,8 @@ static const struct devlink_ops ice_devlink_ops = {
>> > 
>> > 	.rate_leaf_parent_set = ice_devlink_set_parent,
>> > 	.rate_node_parent_set = ice_devlink_set_parent,
>> >+
>> >+	.port_new = ice_devlink_port_new,
>> > };
>> > 
>> >+
>
>[...]
>
>> >+/**
>> >+ * ice_devlink_port_fn_hw_addr_set - devlink handler for mac address set
>> >+ * @port: pointer to devlink port
>> >+ * @hw_addr: hw address to set
>> >+ * @hw_addr_len: hw address length
>> >+ * @extack: extack for reporting error messages
>> >+ *
>> >+ * Sets mac address for the port, verifies arguments and copies address
>> >+ * to the subfunction structure.
>> >+ *
>> >+ * Return: zero on success or an error code on failure.
>> >+ */
>> >+static int
>> >+ice_devlink_port_fn_hw_addr_set(struct devlink_port *port, const u8 *hw_addr,
>> >+				int hw_addr_len,
>> >+				struct netlink_ext_ack *extack)
>> >+{
>> >+	struct ice_dynamic_port *dyn_port;
>> >+
>> >+	dyn_port = ice_devlink_port_to_dyn(port);
>> >+
>> >+	if (hw_addr_len != ETH_ALEN || !is_valid_ether_addr(hw_addr)) {
>> >+		NL_SET_ERR_MSG_MOD(extack, "Invalid ethernet address");
>> >+		return -EADDRNOTAVAIL;
>> >+	}
>> >+
>> >+	ether_addr_copy(dyn_port->hw_addr, hw_addr);
>> 
>> How does this work? You copy the address to the internal structure, but
>> where you update the HW?
>>
>
>When the basic MAC filter is added in HW.

When is that. My point is, user can all this function at any time, and
when he calls it, he expect it's applied right away. In case it can't be
for example applied on activated SF, you should block the request.


>
>> 
>> >+
>> >+	return 0;
>> >+}
>
>[...]
>
>> > 
>> >@@ -5383,6 +5389,7 @@ static void ice_remove(struct pci_dev *pdev)
>> > 		ice_remove_arfs(pf);
>> > 
>> > 	devl_lock(priv_to_devlink(pf));
>> >+	ice_dealloc_all_dynamic_ports(pf);
>> > 	ice_deinit_devlink(pf);
>> > 
>> > 	ice_unload(pf);
>> >@@ -6677,7 +6684,7 @@ static int ice_up_complete(struct ice_vsi *vsi)
>> > 
>> > 	if (vsi->port_info &&
>> > 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
>> >-	    vsi->netdev && vsi->type == ICE_VSI_PF) {
>> >+	    ((vsi->netdev && vsi->type == ICE_VSI_PF))) {
>> 
>> I think this is some leftover, remove.
>>
>
>Yeah, thanks, will remove it.
>
>> 
>> > 		ice_print_link_msg(vsi, true);
>> > 		netif_tx_start_all_queues(vsi->netdev);
>> > 		netif_carrier_on(vsi->netdev);
>> >-- 
>> >2.42.0
>> >
>> >

