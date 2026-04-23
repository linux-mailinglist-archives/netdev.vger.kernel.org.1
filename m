Return-Path: <netdev+bounces-280822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG1xOrlZ6mmgyQIAu9opvQ
	(envelope-from <netdev+bounces-280822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:41:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60650455A5B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70CA230628D1
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AB83A9014;
	Thu, 23 Apr 2026 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTfClv1L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769EB3A75B3
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965905; cv=none; b=sVpXJTKb84EQnEMajJcPEiLIMiPDPwoN1rBgJPz6NxNz7bU6tI1J4MgXA5fnZQKW4k/lPGogjOZ6RVaWIvXed3DDqT3WTSucX3wqH9vi9PzObl+4B3eJdYYgm0pG8y1He0nsebjzArdjsf59uzOaFLH2yoRgw5GDIyHwPVnC8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965905; c=relaxed/simple;
	bh=u0BWCATOBoCz2tMSDG3Lm3CNPPqdPs4DFB5/hyjE/eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBdeAZNSUbMWKV65WNJiWcEnilvR1R87FlNltqiFfAtRVeNik2ffLWuB3CGt/KsOiGx1z5QhbYweb+ESF5N7b8dJU8SzDtiv2Ufw4w147Hh7iuFYikVmyiuyLZ2HR+6pMqIZbypPSHmB+lBAx/2Y6KdaYDd1W84K/Kd4BYdTL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTfClv1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23D3C2BCB2;
	Thu, 23 Apr 2026 17:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965905;
	bh=u0BWCATOBoCz2tMSDG3Lm3CNPPqdPs4DFB5/hyjE/eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WTfClv1LPgFZXruQm6ml4ZWarv1Ljb8LreurYz/pVNPcSZunTi7WCmrB+vgMBV06a
	 W9L9LnfA6UJ2ihh5wMpeDi4mA8cWGITIDxQZJPuOKSgU7+RpkooDkTr1MH3q2IA+9H
	 oIRkXvrChRYre3FdZ9cGbsbWEK9Ls8qVlA6dJGdHGjqW+Lq6+aEwBTZVoknxH7Snff
	 ynLgYTc54kTbWeLJQcjDnXoHL402yWHnazEI7WN1kHdg1eI1vwx8mS6zp3W+64FR3Y
	 o+itn8tTAvwZTFzH7rHbk5l9FV92qYZ7fy33OymPm9gCp0oo91uMu1DLsADYt6KOka
	 9agF7foo87zGQ==
Date: Thu, 23 Apr 2026 10:38:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Ralf Lici
 <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
Message-ID: <20260423103823.20a68dab@kernel.org>
In-Reply-To: <7481bc31-44f6-43ae-b3aa-07002644d9e6@openvpn.net>
References: <20260422123242.530882-1-antonio@openvpn.net>
	<20260422123242.530882-2-antonio@openvpn.net>
	<20260422192050.7c4ca760@kernel.org>
	<7481bc31-44f6-43ae-b3aa-07002644d9e6@openvpn.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,queasysnail.net,mandelbit.com,redhat.com,lunn.ch,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-280822-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60650455A5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 23 Apr 2026 14:16:52 +0200 Antonio Quartulli wrote:
> > If you agree make sure Sashiko doesn't complain about anything else
> > once it's public:
> > https://sashiko.dev/#/patchset/20260422123242.530882-2-antonio@openvpn.net  
> 
> Is there any way to get earlier access to these reviews? (at least for 
> patches somehow related to me/ovpn)

netdev ones are blocked because noobs spam the list for a test.
Which you also appear to be trying to do :D So I shall count
that as a win, I guess? :)

The LLM is mostly just using the review prompts -
https://github.com/masoncl/review-prompts
point you favorite coding agent at that and ask it questions...

