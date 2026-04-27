Return-Path: <netdev+bounces-281407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UArlGlaS72nRCwEAu9opvQ
	(envelope-from <netdev+bounces-281407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:44:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB61F4769D0
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BFF8301D4D0
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529CC3D646C;
	Mon, 27 Apr 2026 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVfMjh1c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F43C73EA
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308191; cv=none; b=gK2tv+3GENNOsj8MSpuIvldeQpSAKl456QF3vH44FrfFX0hqQfy2Wze9HzT3xasyekEKfRPgh6nYfav5V6YVKt34FN64oj/Us0EekLsPKX/xEjpNNra2M9mIZRvh0gA6GZ/uk+wThJuTN26hRcyZBRmuC6RiTPEpej2jcYD5wdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308191; c=relaxed/simple;
	bh=sop+jYumr5WtvqsHY9B185SKGiwtvPmTo1JFw0Tpae8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QL6w53R0nIHOsM2rDsKnAXOTTNa3H1XpfMW4YtBQBnGnW/4TYgI8D0dniG343VWpPWFa/kGUyqqkiATTTFGAyTLaKgkWvhxsPK02o8IxzfWEQgknDSMkORjhdsPv6Uh8HFNFqKq0klofE2NE19KPuaEi6k41WQvnr7BCdB541lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVfMjh1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A9CC19425;
	Mon, 27 Apr 2026 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777308190;
	bh=sop+jYumr5WtvqsHY9B185SKGiwtvPmTo1JFw0Tpae8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVfMjh1cSBeqXGQ1jpCQ9zi8y+sTNtFMx7uFJIqELSbHlu3wvQxMojZMmnqDmqbfI
	 tFjd2V+4VIB0HgXqW1NBUPrSi6+cDpagxMVB+g47/MnI2pxC0xiASjCYRIbeTKkNJe
	 MKCj29fZj+er3mkIukGaLhf9e4b776AdAPqs/T6DDrbkq66nQX4GZBi1XYd4G5S60z
	 OLZXEVb4aXabZiunIscGt6OQBGWvSuQNwlaIJbRrhUD6keCnQ+OmH/W8rpdHDMMCT9
	 NihTpn9E5yhPUptzF+iUMSD7arywiQ+u7rg+2jcqUHfvEIPsJz3yQyrqOeE1R3ICVz
	 dbFc7rxsS052Q==
From: Simon Horman <horms@kernel.org>
To: jtornosm@redhat.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v4 2/4] i40e: skip unnecessary VF reset when setting trust
Date: Mon, 27 Apr 2026 17:25:48 +0100
Message-ID: <20260427162548.1221245-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423130405.139568-3-jtornosm@redhat.com>
References: <20260423130405.139568-3-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DB61F4769D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281407-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
i40e: skip unnecessary VF reset when setting trust

This commit attempts to reduce the bonding setup delay by skipping the
synchronous VF reset when changing the trust setting, manually handling
the capability flag and promiscuous mode instead.

> When we do reset (ADQ case), we reset first to clear VF_STATE_ACTIVE
> (which blocks new cloud filter additions), then delete existing cloud
> filters safely. This avoids the race condition where VF could add filters
> during deletion.

Is this description accurate?

i40e_vc_reset_vf() is synchronous and restores I40E_VF_STATE_ACTIVE before
returning. When i40e_del_all_cloud_filters() traverses
vf->cloud_filter_list locklessly afterwards, the VF is already active again.

Could a concurrent VIRTCHNL_OP_ADD_CLOUD_FILTER message from the guest be
processed asynchronously and corrupt the list?

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index a26c3d47ec1561..26b62650aac9aa 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
[ ... ]
> @@ -4943,6 +4943,30 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
>  	return ret;
>  }
>  
> +/**
> + * i40e_setup_vf_trust - Enable/disable VF trust mode without reset
> + * @vf: VF to configure
> + * @setting: trust setting
> + *
> + * Manually handle capability flag and promiscuous mode when changing trust
> + * without performing a VF reset.
> + * When reset is performed, this is not necessary as the reset procedure
> + * already handles this.
> + **/
> +static void i40e_setup_vf_trust(struct i40e_vf *vf, bool setting)
> +{
> +	if (setting) {
> +		set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +	} else {
> +		clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +
> +		if (test_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states) ||
> +		    test_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states))
> +			i40e_config_vf_promiscuous_mode(vf, vf->lan_vsi_idx,
> +							false, false);

Does this pass the internal software array index (vf->lan_vsi_idx) instead of
the firmware VSI ID (vf->lan_vsi_id)?

i40e_config_vf_promiscuous_mode() uses i40e_find_vsi_from_id() which matches
against the firmware ID. Could this cause the lookup to fail and silently
leave promiscuous mode enabled on the hardware?

Also, should this clear the I40E_VF_STATE_UC_PROMISC and
I40E_VF_STATE_MC_PROMISC flags from vf->vf_states?

If an untrusted VF performs a valid operation like adding a new VLAN, could
i40e_vc_add_vlan_msg() check the uncleared state bit and automatically issue
an AdminQ command to re-enable promiscuous mode, bypassing the revocation?

> +	}
> +}
> +
>  /**
>   * i40e_ndo_set_vf_trust
>   * @netdev: network interface device structure of the pf
> @@ -4987,19 +5011,17 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
>  	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
>  	pf->vsi[vf->lan_vsi_idx]->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
>  
> -	i40e_vc_reset_vf(vf, true);
> +	/* Reset only if revoking trust with ADQ (for cloud filter cleanup) */
> +	if (vf->adq_enabled && !setting) {
> +		i40e_vc_reset_vf(vf, true);
> +		i40e_del_all_cloud_filters(vf);

Could this lead to a memory leak of the cloud filters?

The synchronous reset in i40e_vc_reset_vf() destroys the VF's VSI and
allocates a new one with a new firmware SEID. When
i40e_del_all_cloud_filters() executes afterwards, it looks up the VSI using
the old SEID from the filters, which might fail and cause it to skip the
free operation entirely.

> +	} else {
> +		i40e_setup_vf_trust(vf, setting);
> +	}

By skipping the reset when revoking trust for non-ADQ VFs, do we leave excess
hardware filters intact? Trusted VFs can configure MAC and VLAN filters
beyond standard limits. Without a reset to flush them, does the untrusted
VF retain its configured spoofed MAC addresses and excessive VLANs
indefinitely?

Furthermore, when granting trust, skipping the reset prevents sending the
VIRTCHNL_EVENT_RESET_IMPENDING event to the guest. Since virtchnl VF drivers
negotiate their capabilities and resource requests during initialization,
does this mean the guest driver remains unaware of its newly granted
privileges until the interface is manually restarted?

> +
>  	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
>  		 vf_id, setting ? "" : "un");
>

