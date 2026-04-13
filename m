Return-Path: <netdev+bounces-278035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOLICcDK3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:51:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E643EAE0C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F364030041F6
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002FA3B9DAA;
	Mon, 13 Apr 2026 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckYRyYKK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22EB35AC0A
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077501; cv=none; b=hL/ITJM+1uljSFs/2qZoGt0XU7sEEkC8Y8RBxS8vq+H1WxMQCJRc9pNXCaFvGEiH0/7jhnjq1nEITbtDAaQ3uJ9y4gN40cM8nSEOpBjnPoNckrQ66ki3Ict5xlVGn613X6qmxfZ2A9FT/NVU7p3+mFb6bfvHTBFYoxiYKVCOj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077501; c=relaxed/simple;
	bh=bQAYLLneMNI9jJ1/diAoWNp9Xyr3yX5LkVwGEeYI2S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yyva94DbKz+rJ/LuE4gbpgmZSt7y0MFl7X8lu7FKdewD4iS4j72vkT1GcfFD0olt/epJQh5LCSn/xp4UzPJDpQEkTBfdbDA7z3esczHL2u6escQwH/wgzBQfs0hihRbnwPS1/rGEQOG07BOqmBAeN6y3L2GLh50VhQA7eAIBD/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckYRyYKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8598BC116C6;
	Mon, 13 Apr 2026 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776077501;
	bh=bQAYLLneMNI9jJ1/diAoWNp9Xyr3yX5LkVwGEeYI2S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckYRyYKK5bD0iIR40GZXA42qZENIZOJr1ylDSGcf3h6BYfOwxcW65R74jNxFAYBNU
	 ZWqgQRz2Hq7TvA1vfxbF4OxSvEaLiKyaih/RJwUHxYWCPxD/RP+WwXrjeKO5CcnkAt
	 WfE9fv6F3SvrVD7BWJ7XkchBBcvg9XlKTAnOmRAcwhiqgE6xIANo794HiqRRzPLX2z
	 lNzeJ1RsHfBz/Vt1cfm482NV4wyzVHONFRewnL04Rro8al9N3YaJckxWZPmAJXNZjT
	 M6vL6qY1DV8pI2i3OmQS7BsQxk6DMAy3g8Ax9gpQpNWGOAtCQjn/jUtUAdsIs9j89C
	 HvXelyWsubkxg==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 3/6] ixgbe: call ixgbe_setup_fc() before fc_enable() after NVM update
Date: Mon, 13 Apr 2026 11:51:11 +0100
Message-ID: <20260413105110.695930-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408131154.2661818-4-aleksandr.loktionov@intel.com>
References: <20260408131154.2661818-4-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278035-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5E643EAE0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ixgbe: call ixgbe_setup_fc() before fc_enable() after NVM update

This commit adds a call to hw->mac.ops.setup_fc() before fc_enable() in the
watchdog task when the link comes up, aiming to prevent MDD events after
an NVM update by reprogramming flow-control autonegotiation.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -8031,7 +8031,14 @@ static void ixgbe_watchdog_update_link(struct ixgbe_adapter *adapter)
>  		pfc_en |= !!(adapter->ixgbe_ieee_pfc->pfc_en);
>  
>  	if (link_up && !((adapter->flags & IXGBE_FLAG_DCB_ENABLED) && pfc_en)) {
> -		hw->mac.ops.fc_enable(hw);
> +		/* Re-program flow-control autoneg before applying the result.
> +		 * If setup_fc() fails its output is invalid; skip fc_enable()
> +		 * to avoid committing stale capability bits that trigger MDD.
> +		 */
> +		if (hw->mac.ops.setup_fc && hw->mac.ops.setup_fc(hw))

Will calling setup_fc() unconditionally from the link-up watchdog cause an
infinite link flapping loop on 82599 backplane interfaces?

For backplane interfaces like KX/KX4/KR, setup_fc() resolves to
ixgbe_setup_fc_generic(), which then calls hw->mac.ops.prot_autoc_write().

On 82599 hardware, this calls prot_autoc_write_82599(), which unconditionally
executes ixgbe_reset_pipeline_82599().

Since ixgbe_reset_pipeline_82599() toggles the IXGBE_AUTOC_AN_RESTART bit,
would this drop the link immediately to restart Auto-Negotiation?

If the link drops, it would trigger a link-down LSC interrupt. Once
Auto-Negotiation completes, the link would come back up, triggering another
link-up LSC interrupt. This would cause ixgbe_watchdog_update_link() to run
again, repeating the cycle.

> +			e_warn(drv, "setup_fc failed, skipping fc_enable\n");
> +		else
> +			hw->mac.ops.fc_enable(hw);
>  		ixgbe_set_rx_drop_en(adapter);
>  	}

