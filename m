Return-Path: <netdev+bounces-270158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAHLLrEMvmlQFwMAu9opvQ
	(envelope-from <netdev+bounces-270158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:12:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242FC2E30C7
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D973058BA2
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119032F617C;
	Sat, 21 Mar 2026 03:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYBODqR4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11932EB5AF;
	Sat, 21 Mar 2026 03:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774062687; cv=none; b=f5zqvFrZuvKGrbzhrNwPN9F7JE+4Qf48jKW6HOl8uOC00cG0uHxcGHewXFOdLHVfzdbvrUZ9Xfd931dBLXRO/hX5uJOrMivQOFvzaDqa9UWnEYjRPgy69IOmp5GGP2lcF+T29ECcIBhqd1zDwgJxrbEZAU6KdFOCfuokMnXkE5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774062687; c=relaxed/simple;
	bh=oMev0YieXrKdI+ZoTSCFnQZqc+vL+PWAqCPpGMIYySM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMhsjioL0dlAayrLjuDBv9Gb5uFaoX2MaT/rDtT2pyIDhHl9of9t6Wy8J4Lq3u0/xH4UxFCaOXK2MilNpqZW0kexmfB7Clkt5q4Lv62lXoe7iZIotE18Ii1dMSfSCwg05g/jwaCZODR1jhl6jz4wZLtJ+tdA97ngbKqjf3+zmzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYBODqR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE10FC19425;
	Sat, 21 Mar 2026 03:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774062686;
	bh=oMev0YieXrKdI+ZoTSCFnQZqc+vL+PWAqCPpGMIYySM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YYBODqR4lg1+xMIEbowzFhD7/pAy3oVEh6ijXtkkZIIq/SPzVtPSJxoCueURHCj7h
	 kf5NZ5lgiZU6kJzoG2O3XQiiA8IuAP+vj0PTZN4dyTQ9xfawUO2/uz7OitpsaZdnsk
	 T2mGBEHYy1UTGiX1hq3ZSnoGO2r6ADqrZ79/aWK3TJXFYKio7EIDnJc3NsHXIaThsg
	 cGBWkbBnS3R4/LirItA9XvU03AKFAG+vRDPKyiZH7LCZpXHLywVbCf664RxA/3z5Na
	 N/GYeT1BSfK737vn1JnTBunv3cL5W752kJtum2EqA877WW8n+kfvsOQNkrrlx2Nw5e
	 ejkoJS829Y+XQ==
Date: Fri, 20 Mar 2026 20:11:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, ajit.khaparde@broadcom.com, Bhargava
 Marreddy <bhargava.marreddy@broadcom.com>
Subject: Re: [PATCH net-next v8 03/10] bng_en: add ethtool link settings,
 get_link, and nway_reset
Message-ID: <20260320201124.7cab8b5d@kernel.org>
In-Reply-To: <20260319055124.1350670-4-vikas.gupta@broadcom.com>
References: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
	<20260319055124.1350670-4-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270158-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 242FC2E30C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 11:21:17 +0530 Vikas Gupta wrote:
> +bnge_force_link_speed(struct net_device *dev, u32 ethtool_speed, u32 lanes)
> +{
> +	u16 support_pam4_spds, support_spds2, support_spds;
> +	struct bnge_ethtool_link_info *elink_info;
> +	struct bnge_net *bn = netdev_priv(dev);
> +	struct bnge_link_info *link_info;
> +	u8 sig_mode = BNGE_SIG_MODE_NRZ;
> +	struct bnge_dev *bd = bn->bd;
> +	u32 lanes_needed = 1;
> +	u16 fw_speed = 0;
> +
> +	elink_info = &bn->eth_link_info;
> +	link_info = &bd->link_info;
> +	support_pam4_spds = link_info->support_pam4_speeds;
> +	support_spds2 = link_info->support_speeds2;
> +	support_spds = link_info->support_speeds;
> +
> +	switch (ethtool_speed) {
> +	case SPEED_50000:
> +		if (((support_spds & BNGE_LINK_SPEED_MSK_50GB) ||
> +		     (support_spds2 & BNGE_LINK_SPEEDS2_MSK_50GB)) &&
> +		    lanes != 1) {
> +			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_50GB;
> +			lanes_needed = 2;
> +		} else if (support_pam4_spds & BNGE_LINK_PAM4_SPEED_MSK_50GB) {
> +			fw_speed = PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_50GB;
> +			sig_mode = BNGE_SIG_MODE_PAM4;
> +		} else if (support_spds2 & BNGE_LINK_SPEEDS2_MSK_50GB_PAM4) {
> +			fw_speed = BNGE_LINK_SPEED_50GB_PAM4;
> +			sig_mode = BNGE_SIG_MODE_PAM4;
> +		}

Looking thru this review:
https://sashiko.dev/#/patchset/20260319055124.1350670-1-vikas.gupta%40broadcom.com

I agree that you are playing a little loose with the requested lane
count. Why are you calculating your own lanes_needed if user provided
explicit lane count? We must match user request if set or return an
error.

Another thing that jumped out at me was that stats may transiently go
backwards in patch 8.

Please look carefully thru that review, there may be more worth
addressing.

Bhargava is correct in the responses to patches 9 and 10 FWIW.
The AI was wrong on those.
-- 
pw-bot: cr

