Return-Path: <netdev+bounces-301714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3rPZNlsGPGouiwgAu9opvQ
	(envelope-from <netdev+bounces-301714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:31:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5AA6BFFBD
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:31:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=avUXvY8w;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301714-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301714-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C94313009989
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE3A2BD58A;
	Wed, 24 Jun 2026 16:31:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5B2F7EE8
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 16:31:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318680; cv=none; b=P1AqKbD5P6VaXetn6mc2/rsGPP62QynrMw9gtmFOsEkWun2MOR2cnT39pkJbChrEEdStsk0rcMZ9cZC/3CDVkEU9w02WlFb3Qi+1RMaSLelH3C4FUv1toMI2C5NoxXS7tc68yGFsLh5Eg3fYDXvTwi0q3xWUO44o+cz3Uv92te8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318680; c=relaxed/simple;
	bh=OoZJTggCVtnrc1vhjX0fS3oe8NmGPp2spvl0vbKitYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDpcidhCy/QdiSyUds8Hd9PC96RXzAayr64RY/WheLhj8yFDHejvxbTVpZabhog/6P2Aj6pogmuqH7rCp8mYn2geBjmCmKs/kV8q2tWWSRWUxzoJP2KqLav7Yc1MIszCLC6lHI40fd57a3oyvDjxcSa+wIlOuzE+gYCd+PSaJbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avUXvY8w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B89D1F000E9;
	Wed, 24 Jun 2026 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782318678;
	bh=wazYbUJgqhR8xpd0IySqVbbECzd3A9b0ORDczmzdtjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=avUXvY8w1AXOVduxO/tTRy1iRjmdGJhuo4pzWmoXFrM6oHXianuWIienD9U4+MB0+
	 EMHNKKrr9zq5OkrZxvSPUxrOmavv8u3H0+XqIkX3TPjCfgSi1ZMFEzY62+ywdmT0Nu
	 uYB6Qpr36+TsACDN9cxsuI57L4Uttu5q3lfiye5sgze2xNMdv+hLfjyhnmjMr/ZCXv
	 gZrDK4N8SVhCNyfgD1legdXXGwVfNoWUcGb0gXBu1SwNWxmDAaWi2mP9mqaBJzIyce
	 GK93JWkM6QYmk9+ybrunZoXa5wBN3yK08iFEpiHHx5BpZfTs8o7/LycVQy/Q8iCQAB
	 i0R2BSFhPTAqA==
From: Simon Horman <horms@kernel.org>
To: jtornosm@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [Intel-wired-lan] [PATCH net v7 2/4] i40e: skip unnecessary VF reset when setting trust
Date: Wed, 24 Jun 2026 17:30:50 +0100
Message-ID: <20260624163050.1145761-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623101800.991293-3-jtornosm@redhat.com>
References: <20260623101800.991293-3-jtornosm@redhat.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301714-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:przemyslaw.kitszel@intel.com,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C5AA6BFFBD

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
i40e: skip unnecessary VF reset when setting trust

This patch avoids the ~10 second VF reset delay on trust changes by
flipping the I40E_VIRTCHNL_VF_CAP_PRIVILEGE bit directly, and only
resorting to a full reset when revoking trust from a VF that has
advanced features (ADQ, cloud filters, UC/MC promisc) configured.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index a26c3d47ec15..0cc434b26eb8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
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

[High]
Does this revoke-trust heuristic miss MAC/VLAN filters that were only
installable while the VF was trusted?

A trusted VF is allowed to add many more MAC addresses than
I40E_VC_MAX_MAC_ADDR_PER_VF (i40e_check_vf_permission() uses
I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF) and more than I40E_VC_MAX_VLAN_PER_VF
VLANs.  These quotas are enforced only at add-time.

The previous always-reset path went through i40e_vc_reset_vf() ->
i40e_cleanup_reset_vf() -> i40e_free_vf_res() -> i40e_vsi_release(),
which destroyed the VSI and its mac_filter_hash, and reset
vf->num_vlan = 0.

The new fast path only flips the PRIVILEGE bit, leaving any
trusted-quota MAC/VLAN filters installed in hardware on an
now-untrusted VF.  Should the heuristic also check
vf->num_vlan > I40E_VC_MAX_VLAN_PER_VF or the size of the lan VSI's
MAC filter hash before taking the no-reset branch?

[Medium]
Is the sampling of vf->adq_enabled, vf->num_cloud_filters and the
UC/MC_PROMISC bits race-free against the admin queue worker?

i40e_ndo_set_vf_trust() runs under rtnl_lock and
__I40E_VIRTCHNL_OP_PENDING, but i40e_vc_process_vf_msg() (called from
i40e_clean_adminq_subtask() in the service workqueue) takes neither.
A virtchnl handler such as i40e_vc_config_promiscuous_mode_msg(),
i40e_vc_add_cloud_filter() or i40e_vc_add_qch_msg() can be running
concurrently and may have already passed its CAP_PRIVILEGE gate but
not yet set vf_states / num_cloud_filters / adq_enabled when this
ndo samples them.

In that window the ndo would observe a "clean" VF, take the no-reset
branch, and clear CAP_PRIVILEGE while the in-flight handler still
goes on to enable promisc / install a cloud filter / set
adq_enabled = true on the now-untrusted VF.

The previous always-reset behaviour masked this because the reset
moved the VF to I40E_VF_STATE_DISABLED, after which
i40e_vc_process_vf_msg() rejects further messages.  Is some additional
serialization (or a recheck after clearing the bit) needed here?

> +		i40e_vc_reset_vf(vf, true);
> +		i40e_del_all_cloud_filters(vf);
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

[Low]
The dedicated "VF %u no longer Trusted, deleting all cloud filters"
dev_info() is dropped in this hunk, and the commit message does not
mention the logging change.  Operators or log scrapers that key on
this specific string for audit of cloud filter teardown will no
longer see it; only the generic "VF %u is now untrusted" line
remains.  Was removing this message intentional, and if so could
that be called out in the changelog?

>  out:
>  	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
>  	return ret;

