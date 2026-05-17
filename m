Return-Path: <netdev+bounces-288714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNPlOJKXCWqXgwQAu9opvQ
	(envelope-from <netdev+bounces-288714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 12:25:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A89C56075E
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 12:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD553009B28
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D2E31619B;
	Sun, 17 May 2026 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rj+SMoP1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB1224AF1
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779013519; cv=none; b=ch8v0aB9V+h9gSOJTjTMqXwaxyUSteTpd9WtSK9EYQQkXpzmlUMKWAQw5+NBsuRoF3zrlGwiY5msY1t5fRkPB/Z5r5HMUUpM+SnrTuJ8njcQ30ZbBwq7UVnPy6eThsUE738UPRhbcRaUf5+WjD04hl2KEr33zqCtpmKLnkWsywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779013519; c=relaxed/simple;
	bh=8D9fs/PRk1JXXmpJR1ypWxBztd3OCrUpyzGGXF4Cqfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyuBLaJN6dHvv7VP2dhaYFuO5HuaTEu2A0oXLbsQCxUCWr0YqSArMnoLXXYzKjaVySZ1nJ6UHyVh2KGDaqpLHg79vTB1TTXxy6Ryr4exxzQogR236K7JG6/cWR56rH4PiD6MKQOAS6/AX2Qe7FXzdt6Bo2/G8Zl6cx8LgLyaHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rj+SMoP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2BBC2BCB0;
	Sun, 17 May 2026 10:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779013519;
	bh=8D9fs/PRk1JXXmpJR1ypWxBztd3OCrUpyzGGXF4Cqfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rj+SMoP1rgaa2ACXValosTDUUUhc+/XLyeQmxx1aqcFbMH17as72kjO9MZ4OOwRhv
	 NwP3E+jJQnD3nmKarRVk9guZ46EGjavEDR5abug7ALbsVJ9LfMBqXW77yr1HJfPr1R
	 IadiPsXmf1PAblH0IP5KsWTYkNJEaXytDbspFZLzega2meiTtJRXr84a7P17/gSqax
	 IhkGUYk3RQmXpdZDReCq1UHTRUlI7KP0rfmK/wP2Wv8BZVNSLzAt6QJxexvL5HT0pN
	 zHKScZ2DA/3s6z862BmmjMO/B4F5oHwmPjsktY+sIl1fbVHV9sFAHa9tBpB1wMu0WX
	 4AukxFBvWql3A==
Date: Sun, 17 May 2026 11:25:15 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Piotr Skajewski <piotrx.skajewski@intel.com>
Subject: Re: [PATCH iwl-next v2 3/8] ixgbe: prevent adding duplicate FDIR
 perfect filter rules
Message-ID: <20260517102515.GA98116@horms.kernel.org>
References: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
 <20260512140904.4105236-4-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512140904.4105236-4-aleksandr.loktionov@intel.com>
X-Rspamd-Queue-Id: 4A89C56075E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288714-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 04:08:59PM +0200, Aleksandr Loktionov wrote:
> From: Piotr Skajewski <piotrx.skajewski@intel.com>
> 
> When the same flow specification is added twice (same 5-tuple with
> different sw_idx values), ixgbe_add_ethtool_fdir_entry() silently
> programs the duplicate into hardware using a second FDIR table slot.
> This wastes a scarce FDIR entry and can cause confusing behaviour
> when deleting rules.
> 
> Add a helper ixgbe_match_ethtool_fdir_entry() that walks the in-kernel
> filter list before programming hardware.  If an entry with an
> identical filter (excluding the sw_idx) already exists, the new add
> request is rejected with -EEXIST.
> 
> Signed-off-by: Piotr Skajewski <piotrx.skajewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


