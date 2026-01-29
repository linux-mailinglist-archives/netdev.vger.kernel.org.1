Return-Path: <netdev+bounces-254792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIw2EwZce2nXEAIAu9opvQ
	(envelope-from <netdev+bounces-254792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:09:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A314BB0457
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C44E3011BEE
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8400338886F;
	Thu, 29 Jan 2026 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+H5wwup"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614AB205E02;
	Thu, 29 Jan 2026 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769692163; cv=none; b=oOng48/CVOZ2BWNXBgpyw22kDGSBdKammhB50UBRl+TEF9BQrO/K0FtWd9wmxVyfBnpun8xpTLnUKO6/o61XpbwwoxMr5pk6riim8nL7q0lV6sBeoTR8Aky16NtaW8KT/9z+QoAq/0gJw2M9BB02S9na/3/8b8mU7+2F3VuUjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769692163; c=relaxed/simple;
	bh=BaeMtjfX+Ltd6ppeAP0Sm7W/m0hrawqLM1qeYFR6AJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1bV+MQH0f62cZSchvBFQOxna6M1jsYp/0Uen83XyWPqxcdnJK/rqJWPKjXzO17hWdh5Q+HlwjORwadTwSbxB9di7AqUFaMY22Ga9KYgFgmapFH49xSbISFWZjiwDZsfHQCXwPCkO2OY6w+OW85ixXgpALAGhpVcA4nymv1AlJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+H5wwup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2D7C4CEF7;
	Thu, 29 Jan 2026 13:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769692163;
	bh=BaeMtjfX+Ltd6ppeAP0Sm7W/m0hrawqLM1qeYFR6AJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+H5wwupxiUdHghfaW4JlD68GPby5W4wON1SJkxO+C2kyvfe8R5470pxMaNIgGqAq
	 Wf/+UG0e0zGa88I0KlRP7l1xBT75LMgN/JqzKi6wfZeS/YT0eDwcbiCKJjwTDVemr3
	 xL+p48vl47r7h43bG1ZrN+4nM77UxSGlf4NgTcvLM/EFu+EXcOm5FaYXRrqImrCClE
	 mej3rfzkDXkd1eiOu7LCLYazpcSSVZcPRMXMDOi+ZAcviZdGHTQuWN4sGvCMRjTy0M
	 26vAnh+JKOxjw79/uHUy1X8dyPe3cC4ne8hC5ZDjMEWDT9HJM9tHa3ha0uRNQCxq2n
	 lYox8+FM/zzfg==
Date: Thu, 29 Jan 2026 13:09:18 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, sgoutham@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net-next PATCH] octeontx2-af: Workaround SQM/PSE stalls by
 disabling sticky
Message-ID: <aXtb_np52Ayf83E7@horms.kernel.org>
References: <20260127125147.1642-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127125147.1642-1-gakula@marvell.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254792-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A314BB0457
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 06:21:47PM +0530, Geetha sowjanya wrote:
> NIX SQ manager sticky mode is known to cause stalls when multiple SQs
> share an SMQ and transmit concurrently. Additionally, PSE may deadlock
> on transitions between sticky and non-sticky transmissions. There is
> also a credit drop issue observed when certain condition clocks are
> gated.
> 
> work around these hardware errata by:
> - Disabling SQM sticky operation:
>   - Clear TM6 (bit 15)
>   - Clear TM11 (bit 14)
> - Disabling sticky → non-sticky transition path that can deadlock PSE:
>   - Clear TM5 (bit 23)
> - Preventing credit drops by keeping the control-flow clock enabled:
>   - Set TM9 (bit 21)
> 
> These changes are applied via NIX_AF_SQM_DBG_CTL_STATUS. With this
> configuration the SQM/PSE maintain forward progress under load without
> credit loss, at the cost of disabling sticky optimizations.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

I didn't look over the rest of the driver, but it strikes me that the code
touched by this patch could benefit from some defines for the bits of cfg.

But I don't think that needs to block progress of this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

...

