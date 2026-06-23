Return-Path: <netdev+bounces-301406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TZJIA5KzOmo9EQgAu9opvQ
	(envelope-from <netdev+bounces-301406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:25:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 709076B8B4A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:25:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L6TByLOH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301406-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301406-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A5E6301DDB6
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB02830F815;
	Tue, 23 Jun 2026 16:25:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4A30BF69
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 16:25:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231951; cv=none; b=sQzXmfTUaa5aDuCnOOaoLzvSi0xFOldVihCUjY+PhlpWv17pQHGeEA2T+MWP9slYOd3b5qVbdazkb02vVx2nkd/gN86aSIhhcf0xLMAKOpbAl8j+8NBCuj4a57PVMgzHMwVJnpl6jijW7TJXxLYrUT8s8X8wGN1erkBzy1MAl5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231951; c=relaxed/simple;
	bh=eykH2HUbjr/1DyGU71Z9JYt9zH6YNWHF9N1c/Pj+oJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqX08RoEcZTGA0YVvnBUPyKxUS3rsQN9JKMx12e7FnUo7CCpAu72+EgVY4tXcUZzeFiWVJmLMPV6n6Y0TiI0ccE90kmurpauOFDcLd3gAR3XED+lNQiiOybbYKLWzkqDfH0+JslQeQTnl/UksLOrFD0q6qtiXxmiBtgn79hXvXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6TByLOH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691351F000E9;
	Tue, 23 Jun 2026 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782231950;
	bh=X4qclOH+GM0q9kUF3r5VNGXMuLNAeYN7GThgAUUko88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L6TByLOHbBACOxPDIIJLjKZb9GAn59Lb3vzrUboi8RVqFH1dv1258nnBpcep5C0fi
	 57X69KiV7vCa+Qah0BSXVXO4hoAsgPWr/Z01k+sNbVbITE0fadEjsXvXS3cC17wiLb
	 GizINoivH/0fHf0PLmzIBQUFpjts7SqXeQi5/V5e+EsRZf1g1vYqOuUzIZ7zsTmPNU
	 bf93rhpIlhlZJYkcMb9Y/2mnDUEKlhQKW70dSppnqBPawxP7Zz7OkwenUBcUXLASkx
	 SxJVo9Uwq9ZJYHKGVsOWznpyhVvIScsWhpgX4V+QTTYYSCvFo6fOkFX6FJHzS/n9kT
	 vK2WLtlRB5nJQ==
From: Simon Horman <horms@kernel.org>
To: poros@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	aleksandr.loktionov@intel.com
Subject: Re: [PATCH iwl-net v2 1/2] ice: skip per-VLAN promisc rules when default VSI Rx rule is set
Date: Tue, 23 Jun 2026 17:25:27 +0100
Message-ID: <20260623162526.1099096-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622113428.2565255-2-poros@redhat.com>
References: <20260622113428.2565255-2-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:poros@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301406-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 709076B8B4A

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Subject: ice: skip per-VLAN promisc rules when default VSI Rx rule is set

This patch optimizes the number of hardware switch rules used when an ice
port is part of a vlan-filtering bridge. It avoids installing per-VLAN
promiscuous rules if the broad default VSI Rx rule is already catching
all traffic.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index e2fbe111f8496..efb1f536de6c7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
[ ... ]
> @@ -442,17 +496,12 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)

[Severity: High]
This is a pre-existing issue, but does MAC filter overflow fail to force
promiscuous mode, resulting in silent packet drops?

When the hardware MAC filter limit is reached (LIBIE_AQ_RC_ENOSPC), the driver
attempts to fall back to promiscuous mode by setting promisc_forced_on = true.

However, the execution flow then reaches a check for IFF_PROMISC:

    if (vsi->current_netdev_flags & IFF_PROMISC) {
        /* Apply Rx filter rule to get traffic from wire */
        ...
    } else {
        /* Clear Rx filter to remove traffic from wire */

Since the user never explicitly requested IFF_PROMISC, this evaluates to false,
causing the driver to take the else branch. The else branch actively disables
the default VSI rule and clears promiscuous mode instead of enabling it. The
fallback feature appears to be non-functional, leading to lost traffic for
newly added MACs.

[Severity: High]
This is a pre-existing issue, but could this function prevent retries of
incomplete configurations and break multicast promiscuity if any default
VSI is already active?

In ice_vsi_sync_fltr(), the setup of multicast promiscuity and disabling of
Rx filtering is gated:

    if (!ice_is_dflt_vsi_in_use(vsi->port_info)) {
        err = ice_set_dflt_vsi(vsi);
        ...
        err = ice_set_promisc(vsi, ICE_MCAST_PROMISC_BITS);
        if (err)
            goto out_promisc;
    }

If ice_set_dflt_vsi() succeeds but the subsequent ice_set_promisc() fails,
the function jumps to out_promisc to trigger a retry. On the next cycle,
ice_is_dflt_vsi_in_use() returns true because this VSI is now the default,
causing the entire block to be skipped and leaving the VSI misconfigured.

Furthermore, if another VSI (such as a VF) is already the default VSI,
the PF VSI entirely skips setting multicast promiscuity, breaking multicast
reception in promiscuous mode.

>  		} else {
>  			/* Clear Rx filter to remove traffic from wire */
>  			if (ice_is_vsi_dflt_vsi(vsi)) {
> -				err = ice_clear_dflt_vsi(vsi);
> +				err = ice_vsi_exit_dflt_promisc(vsi);
>  				if (err) {
> -					netdev_err(netdev, "Error %d clearing default VSI %i Rx rule\n",
> -						   err, vsi->vsi_num);
>  					vsi->current_netdev_flags |=
>  						IFF_PROMISC;
>  					goto out_promisc;
>  				}
> -				if (vsi->netdev->features &
> -				    NETIF_F_HW_VLAN_CTAG_FILTER)
> -					vlan_ops->ena_rx_filtering(vsi);
>  			}
[ ... ]
> @@ -3675,10 +3724,9 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
>  	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state))
>  		usleep_range(1000, 2000);

[Severity: High]
This is a pre-existing issue, but isn't there a risk of TOCTOU races with
this ad-hoc lock pattern lacking memory barriers?

The driver spins on ICE_CFG_BUSY using test_and_set_bit() and usleep_range()
to guard VSI filter synchronization. The lock is subsequently dropped using
clear_bit(ICE_CFG_BUSY, vsi->state) at the exit label.

Because clear_bit() lacks a memory release barrier, the CPU or compiler can
reorder memory stores from the critical section to occur after the flag is
cleared, leading to data races and corruption of shared filter state on
weakly ordered architectures.

> -	/* Add multicast promisc rule for the VLAN ID to be added if
> -	 * all-multicast is currently enabled.
> -	 */
> -	if (vsi->current_netdev_flags & IFF_ALLMULTI) {
> +	/* skip the per-VID rule when the DFLT Rx rule already covers this VID */
> +	if ((vsi->current_netdev_flags & IFF_ALLMULTI) &&
> +	    !ice_is_vsi_dflt_vsi(vsi)) {
>  		ret = ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx,
>  					       ICE_MCAST_VLAN_PROMISC_BITS,
>  					       vid);
> @@ -3696,11 +3744,12 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
>  	if (ret)
>  		goto finish;

[Severity: High]
This is a pre-existing issue, but what happens if vlan_ops->add_vlan()
fails here? Is the hardware switch rule leaked?

When adding a VLAN to an interface with IFF_ALLMULTI enabled, this function
first allocates a promiscuous switch rule in hardware via
ice_fltr_set_vsi_promisc().

If this succeeds but the subsequent call to vlan_ops->add_vlan() fails
(e.g., due to ENOSPC or memory allocation failure), the function returns
early without rolling back the promiscuous rule. Because the network stack
considers the VLAN addition to have failed, ice_vlan_rx_kill_vid() will
never be called for this VID, permanently leaking a Flow Lookup Unit (FLU).

> -	/* If all-multicast is currently enabled and this VLAN ID is only one
> -	 * besides VLAN-0 we have to update look-up type of multicast promisc
> -	 * rule for VLAN-0 from ICE_SW_LKUP_PROMISC to ICE_SW_LKUP_PROMISC_VLAN.
> +	/* On the first non-zero VLAN, promote the VLAN-0 multicast promisc
> +	 * rule from ICE_SW_LKUP_PROMISC to ICE_SW_LKUP_PROMISC_VLAN. Skip when
> +	 * the DFLT Rx rule is installed; it already covers every VID.
>  	 */
>  	if ((vsi->current_netdev_flags & IFF_ALLMULTI) &&
> +	    !ice_is_vsi_dflt_vsi(vsi) &&
>  	    ice_vsi_num_non_zero_vlans(vsi) == 1) {
[ ... ]
> @@ -3763,11 +3812,12 @@ int ice_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
>  					   ICE_MCAST_VLAN_PROMISC_BITS, vid);
>  
>  	if (!ice_vsi_has_non_zero_vlans(vsi)) {
> -		/* Update look-up type of multicast promisc rule for VLAN 0
> -		 * from ICE_SW_LKUP_PROMISC_VLAN to ICE_SW_LKUP_PROMISC when
> -		 * all-multicast is enabled and VLAN 0 is the only VLAN rule.
> +		/* Last non-zero VLAN gone: demote the VLAN-0 multicast promisc
> +		 * rule back to ICE_SW_LKUP_PROMISC. Skip when the DFLT Rx rule
> +		 * is installed; no recipe swap is needed.
>  		 */
> -		if (vsi->current_netdev_flags & IFF_ALLMULTI) {
> +		if ((vsi->current_netdev_flags & IFF_ALLMULTI) &&
> +		    !ice_is_vsi_dflt_vsi(vsi)) {

[Severity: High]
Will this modification cause a stale switch rule (ICE_SW_LKUP_PROMISC_VLAN for
vid=0) to be permanently leaked if the last VLAN is removed while the DFLT VSI
rule is active?

This patch skips demoting the vid=0 multicast promiscuous rule from
ICE_SW_LKUP_PROMISC_VLAN back to ICE_SW_LKUP_PROMISC when the last VLAN is
removed, if ice_is_vsi_dflt_vsi(vsi) is true.

However, if the interface later drops IFF_PROMISC (removing the DFLT VSI rule)
and then drops IFF_ALLMULTI, ice_clear_promisc() is called. Because the
interface now has zero VLANs, ice_clear_promisc() executes its else branch:

    } else {
        status = ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
                                            promisc_m, 0);
    }

This only searches and clears rules from the ICE_SW_LKUP_PROMISC recipe. The
stranded rule in the ICE_SW_LKUP_PROMISC_VLAN recipe is never cleared,
resulting in a permanent hardware switch rule leak.

>  			ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
>  						   ICE_MCAST_VLAN_PROMISC_BITS,
>  						   0);

