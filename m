Return-Path: <netdev+bounces-270048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJa2IC6jvWkM/wIAu9opvQ
	(envelope-from <netdev+bounces-270048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:42:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F20992E0404
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D3A1307A54B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD2E3E3158;
	Fri, 20 Mar 2026 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkoTiZaE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2093B3E1D18
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035200; cv=none; b=RyJx8VyIzYSZsq0CSRbkapFhi4TXzFyfp1reSL2cgUOh6SnR6lYjDcxovNdgyV1b9ACFoXVzCRg5xgORrwMB7KM3Hz3aJO5GFMZ6bwlKTsAmrBfmxteryBCyoaS6wefm+OSuYWgspINF+q/iOAQMwKblBgWT/jRXtVF012Z0zGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035200; c=relaxed/simple;
	bh=54I0tzUts4x3NXl1LeohI/qgD2qdo+/1/ND8yVEEsiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2WCwBHDh8vB0kJZuN6n9dogTpZVljEzjvOD4iihYpU7CtN9x6WXnX3BgneWK8kd/BBsYxJfRxLBkeRZBvSNJcECQFuJw3YAOb/bdpqQJbxn6radj4aS7EWsgkkfbcoZGvL5enPT7zGotXAO/LnjCAROaJ4X8fUB5yhqVFW7pYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkoTiZaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F9EC2BCC6;
	Fri, 20 Mar 2026 19:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774035199;
	bh=54I0tzUts4x3NXl1LeohI/qgD2qdo+/1/ND8yVEEsiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hkoTiZaEXvskL0gEFvykoMJgxgG7HC8L6R+Ki8kZzonvCQeKfLvdJKvZIfo48/e24
	 F/7ZpbNWvDcdU0ntns6UCHogQJRied1gUV223U+jCCcRX1c3Ls2oNVHKuGbHnvNKqc
	 NAoJRKoW4ZAZipKhmCOOLSvmbvYlX9tHki39OzsFI9IgT1bOZUXJ2EY0Q7amHXKNX4
	 fSfdWBFGQmKznAL1ax/hBq2ZN+O0kkMK8cC9CsNdvhQMfCmekjTUUiP8XNjw3N/iNK
	 pJpgIfpR2//XnOjJa6VoOeStUunJs7gStzXc2QNrDdQa2iHc27AAnN4pwezLlI7RBH
	 4w2ltkkvd4hWg==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-next] ice: do not carry link status over to link event data
Date: Fri, 20 Mar 2026 19:33:14 +0000
Message-ID: <20260320193314.171338-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320050525.422403-1-aleksandr.loktionov@intel.com>
References: <20260320050525.422403-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270048-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F20992E0404
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: do not carry link status over to link event data

This patch removes code that updated the link_up parameter with the
current firmware state after calling ice_update_link_info().

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index e7308e381e2f..348c86b7328d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -1127,12 +1127,6 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>
>  	ice_check_link_cfg_err(pf, pi->phy.link_info.link_cfg_err);
>
> -	/* Check if the link state is up after updating link info, and treat
> -	 * this event as an UP event since the link is actually UP now.
> -	 */
> -	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP)
> -		link_up = true;
> -

Could removing this check create a race condition with stale link events?

Consider this scenario: firmware generates a link DOWN event, but before
the driver processes it, the link comes back UP. When the driver later
processes the event and calls ice_update_link_info(), the firmware query
returns the current state (UP).

Previously, the removed code would check phy_info->link_info.link_info &
ICE_AQ_LINK_UP and override link_up to true, reflecting the current
reality. Now link_up stays false (the stale event data).

Later in ice_link_event(), the comparison checks:

    if (link_up == old_link && link_speed == old_link_speed)

If the link was previously UP (old_link=true), the comparison fails
(false != true), and the driver proceeds to process a link DOWN event
even though the firmware reports the link is UP. This leads to
ice_vsi_link_event() calling netif_carrier_off() and
netif_tx_stop_all_queues() inappropriately, marking the network interface
DOWN and causing packet loss until the next link event.

The removed comment explicitly documented this protection: "Check if the
link state is up after updating link info, and treat this event as an UP
event since the link is actually UP now."

The commit message states "changes that occurred from update link
info...will be handled appropriately by itself" but doesn't explain what
mechanism handles this. The ice_update_link_info() function only queries
firmware state; it doesn't generate events or trigger link state change
handling.

How does the new code prevent stale link DOWN events from incorrectly
bringing down an interface when the link is actually UP?

>  	vsi = ice_get_main_vsi(pf);
>  	if (!vsi || !vsi->port_info)
>  		return -EINVAL;

