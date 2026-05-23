Return-Path: <netdev+bounces-290973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLrPD+zxEGp7fwYAu9opvQ
	(envelope-from <netdev+bounces-290973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:16:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD155BBB83
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EAA830028B4
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55890135A53;
	Sat, 23 May 2026 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZykKG7qA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238C7823DE
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495402; cv=none; b=benFbFXupXxneDvyoU9EGbl1Ul3Wx4jM6xOnOKXW63rpHCSD45fjhacE2R76h38tqhZaWsm8+7+4uSbOvoQ82tqnO4Q4KtX9HHJWRb0YOIx1K+wgUr9F5IolPe2Ica/bwPfESLT4TFug4q4r4JegvGw/MqGJuB3sCS74H7BKE5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495402; c=relaxed/simple;
	bh=nzkta7yf6T0RjqyZ/gzNZGQp2knVWpItls1pRe/uZqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loLPd9bDGQ6iPsF/XNNuynEnHb43D/vZ0ldgY+z+xoY1XmmseNR1ThLutf9cNwH2E69GBTVAHN0XOMR79q/Wy8OO22PIaJhrBxRnU3ynIJp0fmTfouFhQOmHiMkz5S8nWjL9pxU44ksMHiYHvFFQc2fdTtymQp1NlqekAOLtrD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZykKG7qA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6431F000E9;
	Sat, 23 May 2026 00:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779495400;
	bh=KwjK78QghP4NQeDcN4g0HRhvIL2HuWRCBUHuW2lfM80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZykKG7qAg7YI03FtHxFCNl92Yh4/NV6SWKVbDN3yg30Isf8a00gBfpAwcki5wVWCG
	 awyzbcbPDky+Lfgn9jBEVgeK1hOHK9qIocDp+LJPaLm5Dzl+ncQ11fF315Dj0S6Yxg
	 JzEPgotwaAoExPPDE6I5/JfwFqQB3PWaazrJXIC/1ltPTPRy5EwWxxi0lRQOoI2AYx
	 fjHQTlgx3CV2f6aQa7Oe5mCaj3wtEOsVh+3U+9upkKbWf7mF6qZ/abghleTcZOPUYj
	 zW8v/pFP9HaQplazKJsqq+i0hNXLQXoyeF8Z9z04GpxEhrIE5yA83pXisjiiVEvy0C
	 K9BdSC4kndAiA==
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
Date: Fri, 22 May 2026 17:16:23 -0700
Message-ID: <20260523001623.1757343-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290973-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DFD155BBB83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ice: skip unnecessary VF reset when setting trust

Similar to the i40e fix, ice_set_vf_trust() unconditionally calls
ice_reset_vf() when the trust setting changes. While the delay is smaller
than i40e this reset is still unnecessary in most cases.

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c

[ ... ]

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

[Severity: High]
When revoking trust, ice_reset_vf() is called before updating vf->trusted
to false.

During ice_reset_vf(), the VSI is rebuilt and synchronizes the
ICE_VIRTCHNL_VF_CAP_PRIVILEGE bit in vf->vf_caps with the current value of
vf->trusted, which is still true. The else block below is bypassed, and
although vf->trusted is later set to false, vf_caps will retain the
privileged capability bit.

Because ice_is_vf_trusted() strictly checks vf_caps, won't the VF
incorrectly retain privileged capabilities indefinitely after this operation?

> +		while (vf->num_mac_lldp)
> +			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);

[Severity: High]
Is the MAC LLDP filter cleanup loop dead code?

ice_reset_vf() internally calls ice_vf_pre_vsi_rebuild(), which
unconditionally clears vf->num_mac_lldp to 0 via ice_vf_clear_counters().
As a result, the while condition evaluates to false immediately upon
returning from the reset, completely bypassing the intended cleanup logic.

Furthermore, because vf->num_mac_lldp is abruptly zeroed without going
through ice_vf_update_mac_lldp_num(), does the driver skip calling
ice_vsi_cfg_sw_lldp(), silently leaking the software LLDP switch filters
from its bookkeeping?

> +	} else {
> +		ice_setup_vf_trust(vf, trusted);
> +	}

[Severity: High]
If we skip the VF reset when granting trust, what happens to expected VM
configuration workflows for promiscuous mode?

The PF driver intentionally lies to untrusted VFs that attempt to enable
promiscuous mode: it returns success to the VF without actually programming
the hardware. Historically, granting trust forced a full VF reset. This reset
prompted the VF driver to re-initialize and replay its configuration (including
promiscuous mode) to the PF, which would then correctly program the hardware
because the VF was now trusted.

By skipping the reset when granting trust, it appears a VF that previously
requested promiscuous mode will remain permanently desynchronized. The guest
OS believes it is in promiscuous mode, but the hardware is not programmed to
reflect this, which could result in dropped traffic.

[Severity: High]
When skipping the VF reset on trust revocation (because the VF lacks MAC
LLDP or promiscuous mode), are we allowing the VF to persistently retain
resources allocated while it was trusted?

The 'trusted' capability grants a VF the ability to bypass administrative
limits, such as ICE_MAX_MACADDR_PER_VF (which restricts standard VFs to 18
MAC addresses) and the maximum VLAN limit checked in ice_vf_has_max_vlans().

Prior to this patch, revoking trust unconditionally triggered a VF reset,
which rebuilt the VSI and completely wiped all dynamically allocated hardware
filters, effectively enforcing the demoted limits.

Without the reset, might a VF that allocated an excessive number of MAC
addresses or VLANs while trusted retain them in hardware indefinitely after
trust is revoked, creating a persistent resource limit bypass?

>  	vf->trusted = trusted;
> -	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +
>  	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
>  		 vf_id, trusted ? "" : "un");

