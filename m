Return-Path: <netdev+bounces-290971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBW7NIDyEGp7fwYAu9opvQ
	(envelope-from <netdev+bounces-290971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:19:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D195BBC5F
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F9F83032CE3
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB47823DE;
	Sat, 23 May 2026 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQvpUFSO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206901D6DB5
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495383; cv=none; b=GqTJ2RTM4SkBP5Ivv0XLlUm31YKtyWmkFoj/YK33R9iv5L9b7l6+NZx7Azdzhhot+sly6OT9waf49ePruIiVYFXbwhdRYrLC/BhR6wOeJ9OQG8juHLWEsPJLB6bSN2F0M8njKpcM3oJ74f+nW5PYEpLLWKiSu2E9ODvZSW8xHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495383; c=relaxed/simple;
	bh=hqeDuatgS/TlbG29rGm1pIxxtb+rW20ttgRA/VXm5Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBxl5LQn2eNZZYoUa8p+IcBMbqPc2jzT0Csa68gM88/kpDvGgVcjsEMCuSuFyJQA4EnkBNJKwdR10B1BNsL1naEs+V+lcd4rL/a9DnnOeHdfuEfNLAu+nPNifdDGYrZMoK68CIy6cA7oMrT+rXjab2+Ziv+7U0RMUpOIM3W/EmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQvpUFSO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558DE1F000E9;
	Sat, 23 May 2026 00:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779495380;
	bh=/G77MyiL4zqp6Z6Ak/xSug0GBygIMi29Oxg3ssYcY2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hQvpUFSOJ0PTQPgu6YNf3M56GKHOoYI6y2Q5Efx4KU6SQ/tTZZzrUQ5jBhI6yCf23
	 bUGTgrc6bvPsQ0B+EZ5z6ydHgnkdUwptNzrqSr3/E1+98hHmw0Lh3ZyjPaGi0AlHyi
	 zyVJye6sCoSlaEyXErnx1ki1H22FcWDNjtxHJgNEN5zKyZSmTX+zKoot5tyv09hXo+
	 /VQHQrE1KYPQ1v0L3wWsLX3KP5nlGv52jM+Qwm+faVputvR/Dic1fIKI4d9t4+hj4Z
	 tPsAD02v/G+DgaWxOiTGrwy+OPzsPzL4bqGVHfQ7Viw8WbLluhEpduG1aYPHIb7Uqd
	 vgZc213Eo+Hmg==
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
Date: Fri, 22 May 2026 17:16:19 -0700
Message-ID: <20260523001619.1757273-1-kuba@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-290971-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 34D195BBC5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
i40e: skip unnecessary VF reset when setting trust

This commit attempts to skip the ~10 second VF reset delay when changing
the trust setting. It bypasses the reset and only updates the privilege
capability bit when revoking trust if no advanced features are active.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index a26c3d47ec156..0cc434b26eb88 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
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

[Severity: High]
Does skipping the VF reset when revoking trust allow the Virtual Function
to permanently retain privileged resources?

A trusted VF can bypass untrusted limits, allocating a large number of MAC
and VLAN filters and overriding administratively set MAC addresses. By
skipping the reset upon trust revocation if ADq and promiscuous mode are
inactive, the VSI is not destroyed. 

Since i40e_setup_vf_trust() only updates the capability bit without removing
excess filters, could an untrusted VF retain these configurations and bypass
isolation limits?

[Severity: High]
Can this introduce a race condition with concurrent virtchnl messages?

Virtchnl messages are processed in the ARQ workqueue without holding
rtnl_lock or __I40E_VIRTCHNL_OP_PENDING. A concurrent virtchnl request could
verify the privilege capability bit before it is cleared, and successfully
configure an advanced feature like promiscuous mode after these checks have
bypassed the reset.

Will the VF end up untrusted but with advanced features active?

> +		i40e_vc_reset_vf(vf, true);
> +		i40e_del_all_cloud_filters(vf);

[Severity: Critical]
This is a pre-existing issue, but is vf->cloud_filter_list accessed
concurrently without synchronization?

i40e_del_all_cloud_filters() iterates over and deletes elements from
vf->cloud_filter_list. Concurrently, the ARQ processing thread processes
virtchnl messages and adds elements to the same list. 

Since there is no lock protecting this list across the netlink and ARQ
thread contexts, could concurrent modifications corrupt the list pointers
and lead to a use-after-free?

> +	} else {
> +		i40e_setup_vf_trust(vf, setting);
> +	}
> +
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
>  out:
>  	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);

[Severity: High]
This isn't a bug introduced by this patch, but does using the
__I40E_VIRTCHNL_OP_PENDING bit flag as an ad-hoc lock violate networking
driver concurrency guidelines?

The guidelines explicitly forbid using bit flags to guard code regions. This
open-coded locking scheme provides no deadlock detection, lockdep visibility,
or strict memory ordering guarantees. Could this be replaced with a proper
mutex or lock?

>  	return ret;
>  }

