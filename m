Return-Path: <netdev+bounces-279084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHrkFW8C4WmJoQAAu9opvQ
	(envelope-from <netdev+bounces-279084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:38:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4053411049
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C251D300D14C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3183E3C48;
	Thu, 16 Apr 2026 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQDDjBwz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B133E025E
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353724; cv=none; b=JHVZDCxY1PdLYnsqEbu7YMtM4ydz24TtJFUhQX/NDoLYtvI9RdAyp4h3UjfSpd1Fjgv1keypSzZX4Tfaso9MX1VhKUN9IGTdKXDVqdrz65WchlG71WHRU2P/eYtlmEJY2owGpWaybhjfdb3ZPD7NIoYaEutUhTUffPjkRnPRQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353724; c=relaxed/simple;
	bh=8FfjymGAZxK/xN8hy7FutAHj5tyBKeFyfluTizfoP1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIqisWgAQGKiiCPU/eaz5IAkoJtkEQWb7RoJYYXoE9SJEry346R+dZMv3ozeannD7C0ZuutMakd3UvX9ck0qQT7YcjTb+WHy/p/yfyMByuMjrdvq77rUUkJ5zgAemGHzAfhzwM6qDE3LnihsdwN4vVqirNdnvR7sfW7LPK4nVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQDDjBwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA62C2BCAF;
	Thu, 16 Apr 2026 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776353724;
	bh=8FfjymGAZxK/xN8hy7FutAHj5tyBKeFyfluTizfoP1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQDDjBwzJgFg0GuwxXn1S+fV8XAtGeIQEkF0dbcxB4uDhtOStZRRqHKZpKjW37H2G
	 6yRlNGMrZROYxavfe++NAbko/120DTjGZxj9oIu8UNQljG3LqMJE4HpTOrbAqHzK4C
	 IrUoJHBQSBLQQtlBr7JAFre1ihN2Vq2brlW4CG3kpLNJdqM7gBbDv4In8yYGRW2j73
	 7mEUcR3DKa0QR1ebiS5s5fjONpyzqYetLU4ec5TpZE1hMVnbo9g4Syz2FPO+whSIIH
	 axBt1NptCLmAdN8vX1lSNYswTiLQD+vOxeSjHThI7qqQfdHrJc4AXp6w0u3uaZ9pgQ
	 I6Tm4xDTZfr2Q==
From: Simon Horman <horms@kernel.org>
To: jtornosm@redhat.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net v3 2/5] i40e: skip unnecessary VF reset when setting trust
Date: Thu, 16 Apr 2026 16:31:47 +0100
Message-ID: <20260416153146.886427-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414110006.124286-3-jtornosm@redhat.com>
References: <20260414110006.124286-3-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279084-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4053411049
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
i40e: skip unnecessary VF reset when setting trust

This commit skips the VF reset when setting VF trust, unless trust is
being removed from a VF with ADQ cloud filters. The goal is to avoid
a 10-second delay caused by the reset during trust changes.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index a26c3d47ec156..fea267af7afe6 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -4987,16 +4987,21 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
>  	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
>  	pf->vsi[vf->lan_vsi_idx]->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
>  
> -	i40e_vc_reset_vf(vf, true);

By skipping the VF reset here, does the VF's privilege capability flag
become permanently desynchronized from its trust state?

The underlying capability flag I40E_VIRTCHNL_VF_CAP_PRIVILEGE is used by
Virtchnl handlers like i40e_check_vf_permission() to authorize privileged
actions. This flag is exclusively updated in i40e_alloc_vf_res(), which is
only invoked during a VF reset.

Without the reset, it appears that granting trust fails to give the VF
actual privileged capabilities, and revoking trust leaves the privilege
bit set indefinitely, allowing an untrusted VF to perform unauthorized
privileged operations.

Additionally, could revoking trust fail to scrub the VF's actively
configured privileged hardware state, such as promiscuous mode and excess
MAC/VLAN filters?

Trusted VFs can explicitly enable promiscuous mode and configure MAC/VLAN
filters beyond strict limits. In the original code, i40e_vc_reset_vf()
dismantled these states by calling i40e_cleanup_reset_vf(), which
explicitly invokes i40e_config_vf_promiscuous_mode(..., false, false) and
destroys the VSI.

By skipping the reset, an untrusted VF retains its previously configured
promiscuous mode, allowing it to continue intercepting unauthorized traffic.

>  	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
>  		 vf_id, setting ? "" : "un");
>  
> +	/* Only reset VF if we're removing trust and it has ADQ cloud filters.
> +	 * Cloud filters can only be added when trusted, so they must be
> +	 * removed when trust is revoked. Other trust changes don't require
> +	 * reset - MAC/VLAN filter sync happens through normal operation.
> +	 */
>  	if (vf->adq_enabled) {
>  		if (!vf->trusted) {
>  			dev_info(&pf->pdev->dev,
>  				 "VF %u no longer Trusted, deleting all cloud filters\n",
>  				 vf_id);
>  			i40e_del_all_cloud_filters(vf);
> +			i40e_vc_reset_vf(vf, true);

Is it possible that reordering i40e_del_all_cloud_filters() before
i40e_vc_reset_vf() creates a race condition on vf->cloud_filter_list?

i40e_del_all_cloud_filters() performs lockless modifications on
vf->cloud_filter_list while running from the netlink context.

In the original code, i40e_vc_reset_vf() ran first, which immediately
cleared I40E_VF_STATE_ACTIVE. This prevented concurrent Virtchnl requests
like VIRTCHNL_OP_ADD_CLOUD_FILTER from modifying the list, because their
handlers in i40e_vc_process_vf_msg() abort if I40E_VF_STATE_ACTIVE is
not set.

By calling i40e_del_all_cloud_filters() first, the VF is left in the
active state. The PF service task could concurrently process an
ADD_CLOUD_FILTER message, executing hlist_add_head() simultaneously with
hlist_for_each_entry_safe(), which might cause list corruption.

>  		}
>  	}
>

