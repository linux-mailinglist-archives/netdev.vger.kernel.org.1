Return-Path: <netdev+bounces-279859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBvuNT5l5mlmvwEAu9opvQ
	(envelope-from <netdev+bounces-279859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:41:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 686EE431D29
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 995C532280CB
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A314D3396EE;
	Mon, 20 Apr 2026 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md5E8DjZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C19329C6D
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700453; cv=none; b=JpyU+7TVDwVsQFE0QHqJH1hZ6W5bQwWZmHFZ+ez8UowdYSzUhg8nkbsOaHD34Q5Y1Au9CPz4m3w3cvDCmNmbDxUitAqfdmBrwGlO362an+6oDS8qFSa6IV1mRua85y+Am9UtV/yCfOxF4juSCUigROc2v2CyDv0sZWzZFQO3+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700453; c=relaxed/simple;
	bh=KjHyxxjPDBim6sQ9KYPdRWv3pfyjQHkMzJZQEGKI5R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGPUBWuIDYuizAtzZ+RgyO6Qyf7MjQ/eghi/k617VsK8D5uqDXYhcyFBuN6yvX6gtFEr6gjLopHPfUXlLBQThLZ81qQYYcN4EHodfhXSSBA5X7116u2i5KpuA2n7L8XtfFkRuIPUTNlL+u0kRuR7muWgZboyRIm3HWvvvK56hWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md5E8DjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10939C19425;
	Mon, 20 Apr 2026 15:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776700453;
	bh=KjHyxxjPDBim6sQ9KYPdRWv3pfyjQHkMzJZQEGKI5R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=md5E8DjZIOSFg8J9sBuryhu60e/wjXlftP7tYt1NXoHXTc9pfr9SQohuJfb3bmkM2
	 ftBxgWfg9FHJtRzqdQTWfijvvXCDRWQe0TGGpSCktRyA24k3A49qAhiL32mlYT9Mt5
	 MvjhQcGoccQLUkUEnxtyZHTy+XA5hK66+4w8Lc6NiVPpIDM3gj4zrbleVx8MQbFJ57
	 dKZI5TB6U1h2q/GmhVwdQf+4rbrOCD7SqkIe6y5bCwPN/HEmIqTn9zywFZQg2o6VT9
	 d7TzPUtNFhnyVG84SCeAKDgKrIxUjFErptquIX8jI/uBn5UC3l77XSJUOFjOBu5B0I
	 m572eY2mik9KQ==
Date: Mon, 20 Apr 2026 16:54:09 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Konrad Knitter <konrad.knitter@intel.com>
Subject: Re: [PATCH iwl-net 2/4] ice: fix autoneg disable when link partner
 doesn't support AN
Message-ID: <20260420155409.GT280379@horms.kernel.org>
References: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
 <20260417062954.1241900-3-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417062954.1241900-3-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279859-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,intel.com:email]
X-Rspamd-Queue-Id: 686EE431D29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 08:29:52AM +0200, Aleksandr Loktionov wrote:
> From: Konrad Knitter <konrad.knitter@intel.com>
> 
> Disabling autonegotiation was silently ignored when autoneg had not yet
> completed (ICE_AQ_AN_COMPLETED was not set), leaving the configuration
> unchanged with no error. This could prevent link from forming if the
> link partner requires non-autoneg mode.
> 
> Extend the condition to also allow disabling autoneg when the link
> partner reports no AN ability (ICE_AQ_LP_AN_ABILITY clear). Gate the
> ICE_AQ_LP_AN_ABILITY check on the link being up so that stale or
> zeroed an_info when link is down does not produce a false positive.
> Introduce the helper ice_autoneg_disable_allowed() to make the check
> explicit.
> 
> Fixes: f1a4a66d2310 ("ice: fix set pause param autoneg check")

AI generated code review [1] flags that this does not seem to be
the right Fixes tag and that the following seems more appropriate:

Fixes: 48cb27f2fd18 ("ice: Implement handlers for ethtool PHY/link operations")

[1] https://netdev-ai.bots.linux.dev/ai-local.html

> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

The above not withstanding, this looks looks to me:

Reviewed-by: Simon Horman <horms@kernel.org>


I somehow feel obliged to acknowledge that Sashiko has provided
review of this patch. However, I don't believe any of the
issues flagged there should block progress of this patch.

You may wish to look over that review for possible follow-up activity.

...

