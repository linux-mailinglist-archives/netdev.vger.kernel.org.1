Return-Path: <netdev+bounces-258812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QByoLUpXkmmjtAEAu9opvQ
	(envelope-from <netdev+bounces-258812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 00:31:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBACE140155
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 00:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBF9B300E725
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 23:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0BC1D8E01;
	Sun, 15 Feb 2026 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuchow.ski header.i=@osuchow.ski header.b="Bx+05q8A"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF02BB13
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198278; cv=none; b=CstaPi0xMARp2noU7JPttG1YznVreYKsNitZ9jVDDsIB2vM1koPMyVrS7HM71pGou2IAH/dpXnaQNg3UEpYLJPH9amjHOJIFWGNocZklR7U+TVSQ2+7PIGWujC4ES0Uolw1N/CWEhTZrhrTpzfH2fBgY2OxZYOQ9TXzfsY9ff78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198278; c=relaxed/simple;
	bh=iivCrwTDj2e0lDHcqehqUw25vpus3xOewUA9Y848Dp8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iXlr0yBeXS0C4IA+ZV8zMLZWBrrzKEY/Vpl9+W7qEYNOhdpEhWaJbWv3n0GUHjjkcjRU3K6Jm4PjbInQ7MUHtQe/HXaCGX/i1Rfcfo3UI4DCqUGiqYQReXLrqLuCDt2vqT3hsJCMOeIARxgZWsEVnfp1FqYFWJOwywyq27AIGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=osuchow.ski; spf=pass smtp.mailfrom=osuchow.ski; dkim=pass (2048-bit key) header.d=osuchow.ski header.i=@osuchow.ski header.b=Bx+05q8A; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=osuchow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=osuchow.ski
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fDhxB1sr8z9t7G;
	Mon, 16 Feb 2026 00:31:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuchow.ski; s=MBO0001;
	t=1771198270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0K8eqE2iYjh6T9LLAq+lk1JsTdCZpb+JpruUem7Wtig=;
	b=Bx+05q8AaOisxwkloMG2Zl6zQdJubaxhwiFDn9QmEaS/sYvH4wz/7zMFQrBZ4atUu16LT5
	bfxKvTrY+LfxKK+sK0xSA1kavWAjzSS2XJjdoCIbYYrZi5/RsO+47vY7PZTxzOTMMlQz5+
	k9+x+onOXiKUwGjbaP5NhcCDnHjVPsYewhDExLFQZlYW/QvnpmekNa87Jenc7yjLtcCp59
	pLBYlrLggSxdPuEHBoiWcrgutM9IYVTTbyu61tDwCbOgZpSvshvP/Trw9QudQ6rRQs6rz5
	ajGP5xOQQa+MWKp1193rEiy6g726OYiQ2UmtHt+VdOBvZn7APRz19ZUXhLNSFg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of linux@osuchow.ski designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=linux@osuchow.ski
Message-ID: <d3e7fa70-4035-47e0-89cc-92d636497198@osuchow.ski>
Date: Mon, 16 Feb 2026 00:31:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dawid Osuchowski <linux@osuchow.ski>
Subject: Re: [ANN] netdev development stats for 7.0 (and some AI review
 thoughts)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
References: <20260212124208.187e53ae@kernel.org>
Content-Language: en-US
In-Reply-To: <20260212124208.187e53ae@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[osuchow.ski,none];
	R_DKIM_ALLOW(-0.20)[osuchow.ski:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-258812-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@osuchow.ski,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[osuchow.ski:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: BBACE140155
X-Rspamd-Action: no action

On 12/02/2026 21:42, Jakub Kicinski wrote:
> Hi!
> 

<snip>

> 
> Testing
> -------
> 

<snip>

> One more note on testing, we have completed the migration of NIPA
> to netdev foundation machines. Due to DRAM shortage, however,
> the shipment of additional machines is delayed.

Just something I noticed that might be connected to this is that the 
links to "Raw output" in these announcements broke for each previous 
message you posted.

It is possible to use the new link convention/format:

	Raw output: https://netdev.bots.linux.dev/ml-stats/stats-7.0

to go back as far as 6.18 stats e.g.:

	https://netdev.bots.linux.dev/ml-stats/stats-6.18

but beyond that (6.17 and older) it doesn't work. The "old" nipa links:

	Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.19/stdout

are completely broken.

P.S. I am using a freshly setup email client on a new machine so 
apologies if the formatting is wrong on my end. I did send this message 
to myself for testing and I think it's okay, but I might be missing 
something :)

Kind regards,
Dawid

