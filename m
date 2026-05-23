Return-Path: <netdev+bounces-290967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOi2EvjxEGp7fwYAu9opvQ
	(envelope-from <netdev+bounces-290967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:16:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3865BBB91
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CD273022FA5
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CC935959;
	Sat, 23 May 2026 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H79qEhG4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0F1A6809
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495366; cv=none; b=rVSbQCCsKOCAcfJqaBnt3dkUgUMO2mV7eBczZjkGIG/WPS3iJOwkxWsuIE0Eo71AQYNv1AmOlQgCxyogyQ3E0uMaR9v5eLQUgPc9gmevsECSwhyZMoPE1xci5PprAmhvXIL3BzmZq+Z8W/j2IQvbjAsc225VOcra7Qfksf7cYpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495366; c=relaxed/simple;
	bh=qr1ofEGZGt8K3+fujjKW21dSxUE5CFF4wmGaDlTW8EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gxhefgg2y/J3XIpInOMsewpdnRR+pG9AI2ZBNP9G/zdGP4Fy3j38GaxLCl14c1zzE4p1aYxEonP/55Kmk658ZGI70vdHcPNSuVhuNfEzKqq9OeltbclWBfdQWk3NsNeOV1pA/sACSmbqlh6LLlFaWblLGIKacAYh5Au0e2Yq4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H79qEhG4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C221F000E9;
	Sat, 23 May 2026 00:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779495365;
	bh=kBlOihFOZnCz3NRpfROo2YSMQD+dbwjUKmkwTTJFi1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H79qEhG4kRyBjbkf42C2KyhhOMVLrEmh8Y/imoRh6vvt3CPSnbr8LH71jjvj/TWS0
	 aIuNtyebC/Il126Zwk/hNoHGJpEkeDYQkiLvRKC3Z6m67zwqPcvHk/pR4KxtgwzVQE
	 99I4peZQirKIGcndGZl2aBaGpWK0ejT51aV0U4dPFn2n6mSAZwi0HM+oiyrj3B6uX5
	 yNBxSnr2Bg6bvi5Q/nX5kYJuHezrwzlnC6c/8bvT7mMxY4GKOyTbchVbgNnkpF8bmf
	 U7Rk4gkLSJdTYm20EMT6wVJVtKRaGlJPg6ENZosyKCj5iQYtqVxCFCgbtJmQxZgNmw
	 VYhovXENprpFQ==
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
Subject: Re: [PATCH net 6/8] ice: skip unnecessary VF reset when setting trust
Date: Fri, 22 May 2026 17:16:04 -0700
Message-ID: <20260523001604.1756999-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520183501.3360810-7-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-7-anthony.l.nguyen@intel.com>
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
	TAGGED_FROM(0.00)[bounces-290967-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: AD3865BBB91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Based on my verification, all three findings are confirmed. Let me now generate the report.

commit 848ee33529de0af7967f298f70c37bfb75ea5498
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

ice: skip unnecessary VF reset when setting trust

This patch makes ice_set_vf_trust() skip the VF reset for both the
grant-trust path and for revocation when the VF has not configured
LLDP filters or promiscuous mode. When a reset is still needed, it
reorders the work so the reset runs before the LLDP filter teardown.

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 7e00e091756d..3c64ed1b41a8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1399,11 +1416,19 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
>  
>  	mutex_lock(&vf->cfg_lock);
>  
> -	while (!trusted && vf->num_mac_lldp)
> -		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
> -
> +	/* Reset only if revoking trust and VF has advanced features configured */
> +	if (!trusted &&
> +	    (vf->num_mac_lldp > 0 ||
> +	     test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
> +	     test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))) {
> +		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);

[Critical]
Can the privilege capability bit get left set after revocation here?

The actual trust check used at runtime is ice_is_vf_trusted(), which
reads the bit, not vf->trusted:

  bool ice_is_vf_trusted(struct ice_vf *vf)
  {
          return test_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
  }

The new code calls ice_reset_vf() while vf->trusted is still true (the
assignment is deferred to after the reset so ice_vf_is_lldp_ena() works
during cleanup). Inside the reset, the rebuild path runs:

  ice_reset_vf()
    -> ice_vf_post_vsi_rebuild()
       -> ice_vf_rebuild_host_cfg()
          -> ice_vf_set_host_trust_cfg()
             assign_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE,
                        &vf->vf_caps, vf->trusted);

Because vf->trusted is still true at that moment, the bit gets
re-asserted to 1. After the reset returns, vf->trusted is set to false,
but ice_setup_vf_trust(vf, false) is only called in the else branch, so
the privilege bit is never cleared on this path.

After this returns, ice_is_vf_trusted() still returns true, which gates
ice_can_vf_change_mac(), ice_vc_handle_mac_addr_msg(),
ice_vc_cfg_promiscuous_mode_msg() and ice_vf_has_max_vlans(). The kernel
log says "VF X is now untrusted" but the trust-gated capabilities remain
available to the guest.

Would calling ice_setup_vf_trust(vf, false) (or assigning vf->trusted
before the reset, as the previous code did) be necessary to actually
clear the bit on this path?

> +		while (vf->num_mac_lldp)
> +			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);

[High]
Is this loop reachable after the reset above?

ice_reset_vf() goes through ice_vf_pre_vsi_rebuild() which calls
ice_vf_clear_counters():

  static void ice_vf_clear_counters(struct ice_vf *vf)
  {
          struct ice_vsi *vsi = ice_get_vf_vsi(vf);

          if (vsi)
                  vsi->num_vlan = 0;

          vf->num_mac = 0;
          vf->num_mac_lldp = 0;
          ...
  }

By the time control returns to ice_set_vf_trust(), vf->num_mac_lldp is
already zero, so the while loop never iterates and
ice_vf_update_mac_lldp_num() -> ice_vsi_cfg_sw_lldp(vsi, false, false)
never runs.

ice_vf_reconfig_vsi() inside the reset does invoke ice_fltr_remove_all()
for per-VSI rules, but ice_vsi_cfg_sw_lldp() also drives the AQ-based
ice_lldp_fltr_add_remove() removal, gated by the PF-wide
ICE_FLAG_LLDP_AQ_FLTR flag, which is not torn down by ice_fltr_remove_all().
On firmware that uses the AQ fallback (set when the per-VSI rule add
fails), the AQ LLDP filter rule installed when trust was granted stays
in place, and the VF can keep receiving LLDP frames after revocation.

The commit message says:

    When we do reset (MAC LLDP case), we fix the race condition by
    resetting first to clear VF state (which blocks new MAC LLDP filter
    additions), then delete existing filters safely.

Does the deletion step actually run, given that the loop counter is
zeroed by the reset before the loop is reached? Would saving
num_mac_lldp before ice_reset_vf() and using that saved value (or
unconditionally calling ice_vsi_cfg_sw_lldp(vsi, false, false) when an
LLDP rule was present) be needed for the intended teardown to happen?

> +	} else {
> +		ice_setup_vf_trust(vf, trusted);
> +	}
>  	vf->trusted = trusted;
> -	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +
>  	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
>  		 vf_id, trusted ? "" : "un");

[Medium]
Is the predicate that selects the reset path complete?

The condition only covers num_mac_lldp and the UC/MC promisc state bits.
While trusted, however, a VF can also:

  - override the host-set MAC and add unicast MACs beyond
    ICE_MAX_MACADDR_PER_VF (ice_can_vf_change_mac() and
    ice_vc_handle_mac_addr_msg() consult ice_is_vf_trusted())
  - add VLAN filters beyond ICE_MAX_VLAN_PER_VF
    (ice_vf_has_max_vlans() / ice_vc_get_max_vlan_fltrs() grant a higher
    cap when ice_is_vf_trusted() is true)

A VF that used these higher quotas but is not currently in promisc mode
and has no LLDP filter takes the no-reset path, and the over-quota MAC
and VLAN filters carry over past trust revocation. The previous
unconditional ice_reset_vf() rebuilt the VSI through
ice_vf_rebuild_host_mac_cfg(), which restored only the host-set MAC and
dropped VF-added extras.

The commit message says the reset is taken "if the VF has actually
configured advanced features that require cleanup". Should the
condition also account for VF-installed MAC and VLAN filters that
exceed the untrusted limits?

