Return-Path: <netdev+bounces-281199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I+vUGwym7mmSwQAAu9opvQ
	(envelope-from <netdev+bounces-281199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 01:55:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED18D46B954
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 01:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BAD13001472
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 23:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94205318EE1;
	Sun, 26 Apr 2026 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUs93t+Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED4238178;
	Sun, 26 Apr 2026 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777247753; cv=none; b=LofvNe/U9OCga1i6FKu/tr/RumkTpGvXtIsBTkdmRECw/3Bo64hugyMSOiS7J7H+U5fgxyC5GV3MWVEqNpA8PYYCUxaOsdX8E/iGRrtKZyJyx5rvSzM5GpDyJynoP0am4tO9EAJ2Fw2IpOMmpQXTvc8e8xCIK0zVXyylEzWBiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777247753; c=relaxed/simple;
	bh=RPutQaw9Y/OHVbMRGNuM4pf5Ci3sZmF19ikIZmWwupk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4ii1X3AQOHV0jDMh/kbZamas1MfZvgtyGYDXcJ2OnZWuH/qHPzhZzW7IH+qWOzqQzuvw5idBfxfnZYfFAeTGHABVCwDkHI3Y1cYzn0rM0tS3J3+CrVx8obmzdw4jq74I/K0bAZr8CkUF+vEJxKncVF/MD3/8ZCr9jTxx/95XIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUs93t+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27D4C2BCAF;
	Sun, 26 Apr 2026 23:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777247753;
	bh=RPutQaw9Y/OHVbMRGNuM4pf5Ci3sZmF19ikIZmWwupk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iUs93t+Qy2V5tzUcc4/NTaqXWNRGnd2DyEzIzv5HX5zPz2hrHk6F5votwGtFlYpe4
	 Yej+4o0kPPY0DVxyhiMmQf+gMHZh2HF+WiDGukiKsgyOxJ1eGTffAYKDEM1SUN8XMg
	 DFPuGxUwLPPLAKiWA2xZvclNGVnwyFiOZzJKrOzx5KjCDTd+Pi982JQdFsuLW1vv0c
	 U1vk01rZFTlpM/TzHq72VEc0X3Jh3pmg2ieD7VghkH/xMsjS3KYlFizaw9ovDYzIao
	 AcRu8eSn7rlKd4lswDMbjGEmOLQ7+ukIEQeZvpWUr0x+ki+Iw2zuZtPTGbJumhDEjF
	 Cdd/ESi4asocw==
Date: Sun, 26 Apr 2026 16:55:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chuck Lever" <cel@kernel.org>
Cc: john.fastabend@gmail.com, "Sabrina Dubroca" <sd@queasysnail.net>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, "Chuck Lever"
 <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>, "Alistair
 Francis" <alistair.francis@wdc.com>
Subject: Re: [PATCH net-next v7 0/5] TLS read_sock performance scalability
Message-ID: <20260426165551.43321865@kernel.org>
In-Reply-To: <4a802e09-d1af-4af3-8f02-3e2c8d25e734@app.fastmail.com>
References: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
	<3fc31ab1-23de-4381-b85c-5faa39169ad9@app.fastmail.com>
	<20260422190815.7f678ad6@kernel.org>
	<4a802e09-d1af-4af3-8f02-3e2c8d25e734@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ED18D46B954
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,vger.kernel.org,lists.linux.dev,oracle.com,suse.de,wdc.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-281199-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Sat, 25 Apr 2026 16:15:41 -0400 Chuck Lever wrote:
> On Wed, Apr 22, 2026, at 10:08 PM, Jakub Kicinski wrote:
> > On Wed, 22 Apr 2026 12:41:43 -0400 Chuck Lever wrote:  
> >> I see that this series is currently not in v7.1. What is left to do?  
> >
> > It's marked as Changes requested in patchwork, possibly due to
> > mis-reading of the discussion on patch 4. We process patches within 
> > few days (well, we used to before the AI swarm) so if in doubt you
> > should ask sooner :S  
> 
> Thanks for the pointer to the netdevbpf patchworks instance. Anything
> I can do to move this series to "Awaiting upsteam" ?

Repost after net-next reopens
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

