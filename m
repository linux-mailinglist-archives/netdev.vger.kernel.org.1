Return-Path: <netdev+bounces-290965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO3EAcjxEGp7fwYAu9opvQ
	(envelope-from <netdev+bounces-290965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:16:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 561685BBB73
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B2EB301224F
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE8235893;
	Sat, 23 May 2026 00:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N293Qnks"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0680883F
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495364; cv=none; b=Y4tTE5zBlWoXomDaUzZfMgwRSfkBxiWu51wstLwTMSg7rZaZCnq7x1og0EJkIB3CoWKM7aj2YdASJn6vIwYtbnM2EVMH6gqszV1QsNT38/4Qn0efPhTOfbpnrOI0pLPdI25HEN8H8BxDt/XCzxL6ve7RdSWwg/yXjfPxSkljfUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495364; c=relaxed/simple;
	bh=QYf3Jg9U9dtlIudSTxKcYAxFTGmABfbP6qH+TgCDem0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR7g+s0ECvd9dKvXpxcYkdBPzLmhpIhJLFBJXmejuZTp6Rg141eGFrRRL5S2raHLPQ33XL+kEBjmBZ/UKHPsPpCB0rk6MNn8kRzoNWDmXyKfshbbPpoZOViH6gsquljpHQiPYlqNYqF11H7OfQ11+LfYKpEU8xpvT0jKmXYhCA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N293Qnks; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9271F000E9;
	Sat, 23 May 2026 00:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779495362;
	bh=TqLiX7ydkggy56FSgCnmlUhlaUeDCMoLnrvOYK9OEuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N293QnksyttrmIeUAvytqDReT4Kgr3sprwVolS99+/bp3dg/3dLrKTiuCLED1AsKG
	 vCgTWLHNlxu/rx4ddTrz7i1/6yoNOdxPVnyUP0xeqmoufOsclB+qt9JCH3VStPVJY7
	 XTknjlNqmMBb631AIKierRfbDgSN8C3uy/wVq6jJXbGS8gUvScP4OHlWIFHjIoFYSQ
	 SN3yk9QVycEHQcAXNt2cYzf4xRsBeuLDWHLDzaGSh5nJ+ow//OvGgYfrxdNDf90jo+
	 hWCTIU2mxq4p0QcT/bBjgxp4vCjKnTqnGdPR7ZPeXWdQsJjc0oq0WXP/rMER8+T/5+
	 iwy2v+XVn2WTA==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	vinschen@redhat.com,
	alexander.nowlin@intel.com
Subject: Re: [PATCH net 4/8] i40e: skip unnecessary VF reset when setting trust
Date: Fri, 22 May 2026 17:16:00 -0700
Message-ID: <20260523001600.1756937-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520183501.3360810-5-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-5-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290965-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 561685BBB73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
i40e: skip unnecessary VF reset when setting trust

This commit changes i40e_ndo_set_vf_trust() to skip the VF reset when
granting trust, and when revoking trust unless one of a few advanced
features (ADQ/cloud filters, UC/MC promisc) is currently set on the VF.
On the no-reset path the new helper i40e_setup_vf_trust() flips the
I40E_VIRTCHNL_VF_CAP_PRIVILEGE bit directly.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index a26c3d47ec15..0cc434b26eb8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -4943,6 +4943,23 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
>  	return ret;
>  }
>  
> +/**
> + * i40e_setup_vf_trust - Enable/disable VF trust mode without reset
> + * @vf: VF to configure
> + * @setting: trust setting
> + *
> + * Update VF flags when changing trust without performing a VF reset.
> + * This is only called when it's safe to skip the reset (VF has no advanced
> + * features configured that need cleanup).
> + */
> +static void i40e_setup_vf_trust(struct i40e_vf *vf, bool setting)
> +{
> +	if (setting)
> +		set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +	else
> +		clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +}
> +

[ ... ]

> @@ -4987,19 +5004,20 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
>  	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
>  	pf->vsi[vf->lan_vsi_idx]->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
>  
> -	i40e_vc_reset_vf(vf, true);
> +	/* Reset only if revoking trust and VF has advanced features configured */
> +	if (!setting &&
> +	    (vf->adq_enabled || vf->num_cloud_filters > 0 ||
> +	     test_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states) ||
> +	     test_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states))) {
> +		i40e_vc_reset_vf(vf, true);
> +		i40e_del_all_cloud_filters(vf);
> +	} else {
> +		i40e_setup_vf_trust(vf, setting);
> +	}

[High]
Are the four conditions used here a complete description of "VF in a
clean state" for the purposes of trust revocation?

A trusted VF can install several pieces of privileged state that this
predicate does not consult:

  - more than I40E_VC_MAX_VLAN_PER_VF (16) VLAN filters, accepted by
    i40e_vc_add_vlan_msg() only because the VF is trusted

  - more than I40E_VC_MAX_MAC_ADDR_PER_VF (18) unicast MAC filters,
    permitted by i40e_check_vf_permission() only because the VF is
    trusted

  - a VF-side override of an administratively-set MAC (vf->pf_set_mac),
    where the comment in i40e_check_vf_permission() reads:

        /* ... Unless the VF is privileged and then it can do whatever */

Before this patch, the unconditional i40e_vc_reset_vf() drove
i40e_cleanup_reset_vf() -> i40e_free_vf_res(), which wiped the VF
filter table and re-derived the privilege bit from vf->trusted in
i40e_alloc_vf_resources().

On the new no-reset branch, only the I40E_VIRTCHNL_VF_CAP_PRIVILEGE bit
is cleared, so over-limit VLAN filters, over-limit MAC filters, and the
admin-MAC override remain installed in hardware while the driver
prints "VF %u is now untrusted".

Should this predicate also cover those cases (for example by checking
the VLAN/MAC filter counts on the VF VSI and vf->pf_set_mac), or by
performing the resource cleanup explicitly on the no-reset path?

[High]
Can the no-reset branch race with concurrent virtchnl message handling?

i40e_ndo_set_vf_trust() serializes against other ndo callbacks via
__I40E_VIRTCHNL_OP_PENDING, but i40e_vc_process_vf_msg() (driven from
i40e_clean_adminq_subtask() in the service workqueue) does not test
that bit. It rejects messages only when I40E_VF_STATE_DISABLED is set,
which the no-reset path never sets.

A revoke-trust sequence could then look like:

  CPU0 (ndo_set_vf_trust, setting=false)
     reads vf->num_cloud_filters == 0, !vf->adq_enabled,
           !UC_PROMISC, !MC_PROMISC
     selects the else branch

  CPU1 (i40e_vc_process_vf_msg, e.g. ADD_CLOUD_FILTER /
        ADD_VLAN / ADD_ETH_ADDR / CONFIG_PROMISCUOUS_MODE)
     tests I40E_VIRTCHNL_VF_CAP_PRIVILEGE -- still set
     installs privileged state (++num_cloud_filters,
        sets UC/MC_PROMISC, adds an over-limit VLAN/MAC, ...)

  CPU0
     i40e_setup_vf_trust(vf, false)
        clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);

End state: trust is "revoked" and the privilege bit is cleared, but
privileged state was installed during the window and is never cleaned
up.

The previous unconditional i40e_vc_reset_vf() path masked this because
i40e_trigger_vf_reset() clears I40E_VF_STATE_ACTIVE (so the
i40e_sync_vf_state(I40E_VF_STATE_ACTIVE) check at the top of most
virtchnl handlers fails) and i40e_cleanup_reset_vf() then wipes any
state that did get installed.

Should the no-reset path take a stronger form of synchronisation
against virtchnl processing, or sample the gating conditions and clear
the privilege bit under that synchronisation?

>  
>  	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
>  		 vf_id, setting ? "" : "un");
>  
> -	if (vf->adq_enabled) {
> -		if (!vf->trusted) {
> -			dev_info(&pf->pdev->dev,
> -				 "VF %u no longer Trusted, deleting all cloud filters\n",
> -				 vf_id);
> -			i40e_del_all_cloud_filters(vf);
> -		}
> -	}
> -

[Low]
The dev_info() "VF %u no longer Trusted, deleting all cloud filters"
is removed here. The new code still calls i40e_del_all_cloud_filters()
in the equivalent scenario (inside the conditional reset branch), but
the message is no longer emitted and the commit message does not
mention this change.

Was the removal intentional, and if so should it be noted in the
changelog?

>  out:
>  	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
>  	return ret;
>  }
-- 
pw-bot: cr

