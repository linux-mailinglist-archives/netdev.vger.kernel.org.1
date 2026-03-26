Return-Path: <netdev+bounces-272229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGJ/CAGVxWmq/gQAu9opvQ
	(envelope-from <netdev+bounces-272229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:20:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A51B233B5D5
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 697893018BF4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0B839B972;
	Thu, 26 Mar 2026 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hw+lXb42"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85239EF12
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556097; cv=none; b=N+SnxXccADPVT9uhgT4axDuA2YQqX7eHd8OJEwLc7eAJhz/gM7HiI+oMFvq1XSTJ+hGSmWhIthCvX/cU0hoQvRrfJCuZ1SPRMIrV4MdIbEguglUFFuSHN9EWyhs3Msav+AWHflUlenRpeHKZLUxEb43rMD1eL4hC8IBk1Vv9CjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556097; c=relaxed/simple;
	bh=RZCIwvSiyhoUbbcQednuHM4/M3HqSbXQa4afHK+Q2Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7bk+oebh97JY0lNGCYRljN7eED71TTOXdVZX9mtuw5iJe2jv6tTp/wCysQH1H9iil0w/jg7MeCNaAC13riVDu0MagU0ITH5c9mJTjUojGW5xB8lAdjx5lVFPh2GNsJZjrTBwOKt9Dxdmqh3ZFxSrxrTIbk/PtsTz5VMQhXLvMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hw+lXb42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D2CC116C6;
	Thu, 26 Mar 2026 20:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774556096;
	bh=RZCIwvSiyhoUbbcQednuHM4/M3HqSbXQa4afHK+Q2Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hw+lXb42OB7LmrXiW2uh/yjHNKQJimEp+CdARZJADJdy566d0WlNQRYhca+6NHTFk
	 sNA8ILuMZBdEBZ6Qy/7sxekkPuo/+Y6S0HANwTQOJtBvt/fQMdj7FPsAC6dFVWbaYP
	 r1SV7qEAMjft8LQklNqywXMUFqQj6LQhlJuXcUXAnY/60NxaqX96Ti1XAwVi1Wl+W9
	 3o5viteq+3HYlERJf7RGXmPBXpj8Bh9x6oM+kNqx3cKkB9dV6TSN9dBBfncvbr1ZOY
	 OaYuTRsI5RnLzHMx9iPtjSq2H4p65I4kok7r4zTrgGBsGqNYGXIqOZPDCOUE5zWJH7
	 1BeKG0VIcTLNQ==
Date: Thu, 26 Mar 2026 20:14:52 +0000
From: Simon Horman <horms@kernel.org>
To: Yochai Eisenrich <echelonh@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, security@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: ipv6: ndisc: fix ndisc_ra_useropt to initialize
 nduseropt_padX fields to zero to prevent an info-leak
Message-ID: <20260326201452.GZ111839@horms.kernel.org>
References: <20260324224925.2437775-1-echelonh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324224925.2437775-1-echelonh@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272229-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: A51B233B5D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 12:49:25AM +0200, Yochai Eisenrich wrote:
> When processing Router Advertisements with user options the kernel
> builds an RTM_NEWNDUSEROPT netlink message. The nduseroptmsg struct
> has three padding fields that are never zeroed and can leak kernel data
> 
> The fix is simple, just zeroes the padding fields.
> 
> Fixes: 31910575a9de ("[IPv6]: Export userland ND options through netlink
>     (RDNSS support)")

Fixes tags should be all on one line; no line wrapping.

> Signed-off-by: Yochai Eisenrich <echelonh@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

