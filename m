Return-Path: <netdev+bounces-285286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MWIJzJ8/Gl0QgAAu9opvQ
	(envelope-from <netdev+bounces-285286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:49:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E6B4E7B9E
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAEAD303A263
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFDB37189B;
	Thu,  7 May 2026 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxDvMBSR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ED1391E4B
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154422; cv=none; b=a2D55cFoapPkd7VCXihvdPgClrm7gJpdY28tHT8OfCFBiNXMl/TPt1ZKv6KgHGSxN1VnjUhy7ojJy4NMk5ivbEvtt3Xi35jZ7QQCq99SFkhaB/LA+MlzACvW2FllYayctfDcvarHpKq6y3dz9bXUzEGEGsUZqjjdS1PLAWdkN4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154422; c=relaxed/simple;
	bh=h3EAL/S01YS8fybSqcWD1qgy/RTvjx3UPUp6EuoYrGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KirtJG4UTFFoczD6DtsN2CsMirSk7qRC+QarYnilCRzn6Jxy2LAJK45HB13iGWeBzFjJBrvNWG6tYtvsMPyAsAeVMwsufjNkRqpUCjMSaamBZe7EYqHxLRnMOabLXNi48tYhphnkWJ1Ra33JStuL2UZ1VK0e3MRU8uBBSY1UFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxDvMBSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E2FC2BCC7;
	Thu,  7 May 2026 11:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778154421;
	bh=h3EAL/S01YS8fybSqcWD1qgy/RTvjx3UPUp6EuoYrGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxDvMBSR+KTVU1wY7BS+di8mIKjFNZru+csLiT0ysg0yGADHxFtdeA7CuPOmKoLLo
	 6fXBWGJKD4IpvUZWC8WWNamvfglBJG27bdFHeng9mLttN2ESB5nvTWdtwihqJIYH+P
	 xyRRNc0hmAysyI8Jy75wPwKVZqBAn67IPGQyDlBic1a4Q1cVbxPJK9Lw4Ktnu0uSCG
	 9BgSEaZ7XcFy2ku0TIUU5kqTD4eHO06nb8z9EOMagvsgqG7dP0Er2deoOgHxBV3mxL
	 BG/bCxf5osAiRtzWJaaiysuMGSXN0H2P4ZvjCmtSKTheLJYJJdJ4m6QPgv8Gp1vG9G
	 guUCimo/JV6EA==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 5/5] ice: use element-by-element comparison for DCB config changes
Date: Thu,  7 May 2026 12:46:54 +0100
Message-ID: <20260507114654.916528-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504142451.4161845-6-aleksandr.loktionov@intel.com>
References: <20260504142451.4161845-6-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0E6B4E7B9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285286-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Subject: ice: use element-by-element comparison for DCB config changes

This commit replaces the use of memcmp() for DCB configurations with an
element-by-element comparison using ice_dcb_need_recfg(). It exports this
function and applies it to the SW DCB netlink setters to prevent issues
with uninitialized padding bytes.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
> index a10c1c8d86977..13a52c1a4da3e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
> @@ -108,11 +108,17 @@ static int ice_dcbnl_setets(struct net_device *netdev, struct ieee_ets *ets)
>  	if (!bwrec)
>  		new_cfg->etsrec.tcbwtable[0] = 100;
>  
> +	if (!ice_dcb_need_recfg(pf, &pf->hw.port_info->qos_cfg.local_dcbx_cfg,
> +				new_cfg)) {
> +		err = ICE_DCB_NO_HW_CHG;
> +		goto ets_out;
> +	}

Does ice_dcb_need_recfg() correctly detect bandwidth changes?

Looking at the implementation of ice_dcb_need_recfg(), it only logs a debug
message but doesn't set need_reconfig to true when only the ETS Bandwidth
Table or TSA Table changes:

drivers/net/ethernet/intel/ice/ice_dcb_lib.c:ice_dcb_need_recfg() {
    ...
    if (memcmp(&new_cfg->etscfg.tcbwtable,
               &old_cfg->etscfg.tcbwtable,
               sizeof(new_cfg->etscfg.tcbwtable)))
        dev_dbg(dev, "ETS TC BW Table changed.\n");
    ...
}

Since the function returns false, will this cause ice_dcbnl_setets() to
abort early and silently drop user-requested bandwidth modifications?

Also, since new_cfg points to the shared desired_dcbx_cfg state, does this
early return leave uncommitted modifications in the software state?

If a subsequent unrelated operation (like setting PFC) correctly returns
true from ice_dcb_need_recfg(), it appears it could unintentionally push
these abandoned ETS bandwidth changes to the hardware.

>  	err = ice_pf_dcb_cfg(pf, new_cfg, true);
>  	/* return of zero indicates new cfg applied */
> -	if (err == ICE_DCB_HW_CHG_RST)
> +	if (!err)
>  		ice_dcbnl_devreset(netdev);

This isn't a bug introduced by this patch, but can ice_dcbnl_devreset()
cause a deadlock against hardware reset tasks?

The ice_dcbnl_devreset() function spins in a usleep_range() loop while
ice_is_reset_in_progress() is true.

Since DCBNL callbacks like ice_dcbnl_setets() run with the global
rtnl_lock held, and a concurrent hardware or PCIe reset worker likely
requires rtnl_lock to complete the reset, will the reset task block
forever while this thread waits for it?

> -	if (err == ICE_DCB_NO_HW_CHG)
> +	else if (err == ICE_DCB_NO_HW_CHG)
>  		err = ICE_DCB_HW_CHG_RST;
>  
>  ets_out:

Does this change cause the function to return a positive error code to
userspace when applying an identical configuration?

By bypassing the translation from ICE_DCB_NO_HW_CHG (which is 1) to
ICE_DCB_HW_CHG_RST (which evaluates to 0) in the early goto added
above, err remains 1 at the ets_out label.

The DCBNL core evaluates any non-zero return value as an error:

net/dcb/dcbnl.c:dcbnl_ieee_set() {
    ...
    err = netdev->dcbnl_ops->ieee_setets(netdev, ets);
    if (err)
        goto err;
    ...
}

Will this cause tools like lldptool to fail when configuring an
existing setup?

[ ... ]

> @@ -845,6 +858,12 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
>  	new_cfg->dscp_map[app->protocol] = app->priority;
>  	new_cfg->app[new_cfg->numapps++] = new_app;

This isn't a bug introduced by this patch, but does this array append
lack bounds checking against ICE_DCBX_MAX_APPS?

The app array has a capacity of 64. The function restricts duplicate
DSCP protocols using the dscp_mapped bitmap, but since DSCP_MAX is also
64, a user could map all 64 unique values.

If numapps starts greater than 0 due to existing EtherType applications,
adding 64 valid DSCP mappings would cause numapps to exceed 64, leading
to an out-of-bounds write that overwrites the adjacent dscp_mapped
bitmap.

