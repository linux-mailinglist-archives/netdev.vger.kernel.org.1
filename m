Return-Path: <netdev+bounces-304605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aWPeDtrlR2oZhQAAu9opvQ
	(envelope-from <netdev+bounces-304605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:39:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5FB70453F
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:39:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=I0rnaYEi;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304605-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304605-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A0C8300A3B1
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123EC308F26;
	Fri,  3 Jul 2026 16:34:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089D307AF4;
	Fri,  3 Jul 2026 16:34:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096485; cv=none; b=TMVTnlJza8cFITd+rdkr8QFvZRbeKrN0zPA0yD1Z6wl61U+ARM2b6WL2fMJczDftl0ErSjDt448iWTNNjFXYPHFBkvvRJVZ4SmnPPRXSry7Jf9O7noxerunAQKg7vLUl+25ewEQZxUbLxv4/3qHGZp3DkcrIIFR+/NfZtJ9P0Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096485; c=relaxed/simple;
	bh=ACxblYsNsfjZ17Jv48lG1b3yhVoLo/k8vyHrcDPicYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFH9xdLxP+tUIKGIamzbnenFaUFAGjWSKeZg2PJMbwdZd7RkS59WdbYZ33Af2mmX1G1G4lgUolwBejZ6JOGfAuHBOob8EiIW64nfKMdXPmlYVAtVwncjKt+9NKTPt/g2dgOaZ9u+R+1RriYyZBhjVBjngDRZFaNA5rxFjz4p9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0rnaYEi; arc=none smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783096483; x=1814632483;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ACxblYsNsfjZ17Jv48lG1b3yhVoLo/k8vyHrcDPicYU=;
  b=I0rnaYEiEiKRaqnHyPjTe+3hBcOxjHxwHTsR4NqayaBb/aOd5nMa+bq3
   mFp6jgtJ3u3kf4AccKQqV+lu1dzx9l9mUcl9vcu4oDg3Denwpmi6ABhjB
   0HS30KANPvo803DbaUN3pXKMR3VFx6Kup3AmZ6RQx8XzBUrRXYkLo8CNN
   +rs9OQv5WplK8Sk3yg2n+BFjRlQvDZ5qfjO6FzkIZT53vvGP+Anti0kBa
   NzyiLcGY0zwACoxrWC/XDNQRxzghBpCB6+y0r0wzIMa/hGeYofqoAYM79
   TpNZv0EpML1bJRoqzJLuPdtZYNvVdSHjfi8hHXpoig0Rd3k9YSP5yZwV2
   Q==;
X-CSE-ConnectionGUID: GElepTUzSqa6i0JskDnGBg==
X-CSE-MsgGUID: AngmnVk0S7itbhSm/QrOww==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="82837471"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="82837471"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 09:34:42 -0700
X-CSE-ConnectionGUID: EDvex0NrQnWFq1H2Cj02vA==
X-CSE-MsgGUID: F1C4AHSuTY+LKcx3YIHpXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="253283164"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.245.114.103]) ([10.245.114.103])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 09:34:37 -0700
Message-ID: <f03d0930-9f51-45ad-9ed4-e9df335b8fa7@linux.intel.com>
Date: Fri, 3 Jul 2026 18:34:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3 1/2] ice: skip per-VLAN
 promisc rules when default VSI Rx rule is set
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Alice Michael
 <alice.michael@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 intel-wired-lan@lists.osuosl.org, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20260701133601.2118382-1-poros@redhat.com>
 <20260701133601.2118382-2-poros@redhat.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260701133601.2118382-2-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304605-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:poros@redhat.com,m:netdev@vger.kernel.org,m:ivecera@redhat.com,m:alice.michael@intel.com,m:przemyslaw.kitszel@intel.com,m:edumazet@google.com,m:linux-kernel@vger.kernel.org,m:martyna.szapar-mudlaw@linux.intel.com,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:horms@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,linux.intel.com:from_mime,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A5FB70453F



On 01.07.2026 15:36, Petr Oros wrote:
> When an ice port in a vlan-filtering bridge goes promiscuous (typical for
> bond slaves), the driver installs a per-VLAN ICE_SW_LKUP_PROMISC_VLAN rule
> for every VID on top of the broad ICE_SW_LKUP_DFLT VSI Rx rule. Each rule
> consumes one of the ~32K Flow Lookup Unit (FLU) entries the device shares
> across PFs, so a wide trunk (vid 2-4094) over several PFs overruns the
> pool: firmware rejects further Add Switch Rules with ENOSPC (AQ 0x10) and
> the DFLT Rx rule itself fails to install:
> 
>   ice 0000:5c:00.1: Failed to set VSI 14 as the default forwarding
>                     VSI, error -5
>   ice 0000:5c:00.1 ens1f1: Error -5 setting default VSI 14 Rx rule
> 
> Once a switch context is overrun the retries can also come back as ENOENT
> (AQ 0x2), which has misled triage toward a perceived recipe binding defect
> rather than a capacity issue.
> 
> The DFLT rule already catches every packet on the port regardless of VLAN
> tag, so the per-VLAN promisc expansion is redundant while it is installed.
> Skip it at the two sites that drive it, ice_set_promisc() and
> ice_vlan_rx_add_vid(), keyed on ice_is_vsi_dflt_vsi() rather than the
> netdev IFF_PROMISC flag so a failed or LAG-suppressed DFLT install still
> falls back to the per-VLAN rules.
> 
> IFF_ALLMULTI and IFF_PROMISC can reach ice_vsi_sync_fltr() in separate
> passes (a bridge join sets them through separate calls), so the allmulti
> pass may expand the per-VID rules before the DFLT rule exists. Drop those
> now-redundant rules right after ice_set_dflt_vsi() installs the DFLT rule;
> ice_vsi_exit_dflt_promisc() reinstates them when promisc is cleared.
> 
> ice_vsi_sync_fltr() subscribed multicast promiscuity only inside the
> "default VSI not yet in use" branch, so a promiscuous VSI that finds the
> default VSI rule already present (owned by another VSI, or preserved
> across a switchdev session) ended up in unicast promisc with no multicast
> subscription. Issue ice_set_promisc(ICE_MCAST_PROMISC_BITS) whenever the
> netdev is promiscuous; it is idempotent and returns 0 if the rule is
> already present.
> 
> Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v3:
> - Dropped the two vid=0 ICE_SW_LKUP_PROMISC <-> ICE_SW_LKUP_PROMISC_VLAN
>   recipe-swap guards in ice_vlan_rx_add_vid() and ice_vlan_rx_kill_vid();
>   each swap is net-zero and guarding the demote stranded the vid=0 rule
>   in ICE_SW_LKUP_PROMISC_VLAN when the last VLAN was removed under the
>   DFLT rule. Reported by review.
> - Drop the now-redundant per-VID multicast promisc rules right after
>   ice_set_dflt_vsi(). A bridge join raises IFF_ALLMULTI and IFF_PROMISC
>   in separate sync passes, so the allmulti pass expands the per-VID rules
>   before the DFLT rule exists; the cleanup keeps them from lingering and
>   exhausting the FLU pool. ice_vsi_exit_dflt_promisc() reinstates them on
>   promisc off. Reported by review.
> - Issue ice_set_promisc(ICE_MCAST_PROMISC_BITS) whenever the netdev is
>   promiscuous, not only when this VSI installs the default VSI rule, so
>   multicast promisc is not lost when the rule is already in use (owned by
>   another VSI, or preserved across a switchdev session). Reported by
>   review.
> - Hoisted the combined VLAN promisc mask in ice_clear_promisc() into a
>   local for alignment. Dropped Aleksandr's Reviewed-by since the code
>   changed.
> 
> v2: https://lore.kernel.org/all/20260622113428.2565255-2-poros@redhat.com/
> v1: https://lore.kernel.org/all/89efbea9831175e6f57e9fe8557f7a0e48e050b7.1781786935.git.poros@redhat.com/
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 111 ++++++++++++++++++----
>  1 file changed, 90 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index b43d420ece99ca..a84de6cf6eb078 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -274,7 +274,8 @@ static int ice_set_promisc(struct ice_vsi *vsi, u8 promisc_m)
>  	if (vsi->type != ICE_VSI_PF)
>  		return 0;
>  
> -	if (ice_vsi_has_non_zero_vlans(vsi)) {
> +	/* skip per-VID expansion; the DFLT Rx rule already covers every VID */
> +	if (ice_vsi_has_non_zero_vlans(vsi) && !ice_is_vsi_dflt_vsi(vsi)) {
>  		promisc_m |= (ICE_PROMISC_VLAN_RX | ICE_PROMISC_VLAN_TX);
>  		status = ice_fltr_set_vlan_vsi_promisc(&vsi->back->hw, vsi,
>  						       promisc_m);
> @@ -304,9 +305,20 @@ static int ice_clear_promisc(struct ice_vsi *vsi, u8 promisc_m)
>  		return 0;
>  
>  	if (ice_vsi_has_non_zero_vlans(vsi)) {
> -		promisc_m |= (ICE_PROMISC_VLAN_RX | ICE_PROMISC_VLAN_TX);
> +		u8 vlan_promisc_m = promisc_m | ICE_PROMISC_VLAN_RX |
> +				    ICE_PROMISC_VLAN_TX;
> +		int vid0_status;
> +
> +		/* set time used either recipe (per-VID PROMISC_VLAN, or vid=0

I find this sentence hard to understand - did you mean "ice_set_promisc() used
either recipe..."?

> +		 * PROMISC via the ice_set_promisc() else branch), so clear
> +		 * both; clearing an absent rule succeeds

What do you mean by this? Both will return -EEXIST if rule is absent. There can
also be other errors.

> +		 */
>  		status = ice_fltr_clear_vlan_vsi_promisc(&vsi->back->hw, vsi,
> -							 promisc_m);
> +							 vlan_promisc_m);
> +		vid0_status = ice_fltr_clear_vsi_promisc(&vsi->back->hw,
> +							 vsi->idx, promisc_m, 0);
> +		if (status == 0)
> +			status = vid0_status;
>  	} else {
>  		status = ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
>  						    promisc_m, 0);
> @@ -317,6 +329,59 @@ static int ice_clear_promisc(struct ice_vsi *vsi, u8 promisc_m)
>  	return status;
>  }
>  
> +/**
> + * ice_vsi_exit_dflt_promisc - drop the default VSI Rx rule on promisc off
> + * @vsi: the VSI leaving promiscuous mode
> + *
> + * For an IFF_ALLMULTI VSI with VLANs the per-VID multicast rules are
> + * reinstated before the default rule is cleared so coverage never lapses;
> + * the then redundant vid=0 rule is dropped best-effort. The callees log
> + * their own failures, so error returns are not re-logged here.
> + *
> + * Return: 0 on success, negative on error with the default rule left in place.
> + */
> +static int ice_vsi_exit_dflt_promisc(struct ice_vsi *vsi)
> +{
> +	struct ice_vsi_vlan_ops *vlan_ops = ice_get_compat_vsi_vlan_ops(vsi);
> +	struct net_device *netdev = vsi->netdev;
> +	struct ice_hw *hw = &vsi->back->hw;
> +	bool restore_mc;
> +	int err;
> +
> +	restore_mc = (vsi->current_netdev_flags & IFF_ALLMULTI) &&
> +		     ice_vsi_has_non_zero_vlans(vsi);
> +
> +	if (restore_mc) {
> +		err = ice_fltr_set_vlan_vsi_promisc(hw, vsi,
> +						    ICE_MCAST_VLAN_PROMISC_BITS);
> +		if (err && err != -EEXIST)
> +			return err;
> +	}
> +
> +	err = ice_clear_dflt_vsi(vsi);
> +	if (err)
> +		return err;
> +
> +	if (netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
> +		vlan_ops->ena_rx_filtering(vsi);
> +
> +	if (restore_mc)
> +		ice_fltr_clear_vsi_promisc(hw, vsi->idx, ICE_MCAST_PROMISC_BITS,
> +					   0);
> +
> +	return 0;
> +}
> +
> +/* Drop the per-VID multicast promisc rules, redundant once the default
> + * VSI Rx rule covers every VID. A no-op when the VSI has no VLANs.
> + */
> +static void ice_vsi_clear_vlan_mc_promisc(struct ice_vsi *vsi)
> +{
> +	if (ice_vsi_has_non_zero_vlans(vsi))

Nit: could flip condition to decrease indent level.

> +		ice_fltr_clear_vlan_vsi_promisc(&vsi->back->hw, vsi,
> +						ICE_MCAST_VLAN_PROMISC_BITS);

Error code ignored, not sure if intentionally.

> +}
> +
>  /**
>   * ice_vsi_sync_fltr - Update the VSI filter list to the HW
>   * @vsi: ptr to the VSI
> @@ -429,30 +494,35 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
>  				err = 0;
>  				vlan_ops->dis_rx_filtering(vsi);
>  
> -				/* promiscuous mode implies allmulticast so
> -				 * that VSIs that are in promiscuous mode are
> -				 * subscribed to multicast packets coming to
> -				 * the port
> +				/* DFLT now covers every VID; drop the per-VID
> +				 * multicast promisc rules a prior IFF_ALLMULTI
> +				 * pass may have installed (separate passes on a
> +				 * bridge join) so they do not linger and exhaust
> +				 * the FLU pool. exit_dflt_promisc() reinstates

Please use the full function name.

> +				 * them on promisc off.
>  				 */
> -				err = ice_set_promisc(vsi,
> -						      ICE_MCAST_PROMISC_BITS);
> -				if (err)
> -					goto out_promisc;
> +				ice_vsi_clear_vlan_mc_promisc(vsi);
>  			}
> +
> +			/* Promiscuous mode implies allmulticast. Subscribe
> +			 * the VSI to all multicast even when the default VSI
> +			 * rule is already in use and the block above is
> +			 * skipped (it may be owned by another VSI, or
> +			 * preserved across a switchdev session); the unicast
> +			 * catch-all does not cover the multicast subscription.
> +			 */
> +			err = ice_set_promisc(vsi, ICE_MCAST_PROMISC_BITS);
> +			if (err)
> +				goto out_promisc;
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
>  
>  			/* disable allmulti here, but only if allmulti is not
> @@ -3676,10 +3746,9 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
>  	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state))
>  		usleep_range(1000, 2000);
>  
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
Thanks,
Marcin

