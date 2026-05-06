Return-Path: <netdev+bounces-285061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLyjGRrC+2mxEQAAu9opvQ
	(envelope-from <netdev+bounces-285061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:35:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C11F24E1418
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 529B23007355
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB879364059;
	Wed,  6 May 2026 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpdjeXb6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BCF358D3D;
	Wed,  6 May 2026 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106903; cv=none; b=FDuyfPQHE6TzhVNSbPoi3JCTGrH4vCYfmB4lHPq3kxdhTu0cWeLQupLdYFWWq/r+3B6geNCvWVQdLmV87bh2nsypd8YRIqjRjcrCobsxuaVIEibFGI7J3wPd1SIATMwZO1okUG5XLVqd5ybeRA2iQZ2tK7Fj/7hCQVG8HNS7eGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106903; c=relaxed/simple;
	bh=WfZgw+TSYwuuWZco9UUiaSzl0XhRcbOTgHLl0PrSIY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDExhdrJvRtOSe7+QhDEFikqcjZH6HF4yyif03KFK1vCly3JWqgaKzjFl05Y8arpA0ATjpMn8MzEjghDdyURyDGOyYW57GbaZyy1WNzHiae4R9gjE0qh5jhJ/1W14LTypPrO9Or83GRxxI1RngBnqvRBHXVOHR/xPxFzuyzaG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpdjeXb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2606AC2BCB0;
	Wed,  6 May 2026 22:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778106903;
	bh=WfZgw+TSYwuuWZco9UUiaSzl0XhRcbOTgHLl0PrSIY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CpdjeXb6LhJnBfNGKPsNIwjICNhJmzQnnM8OOUFoISRbz87mMXevUCJKXaq6HiWE+
	 OmttBba0Yk/68exmOTloibYTblSSCl5EFCbxG5gY37AkPwPS9J4QTnmmvrALduwsqp
	 ivZOwkUQcsZW89GcQtOT3tunEPunc7elJxHqmI0Ff/cvXMcEufWWfL6bAtTt8fhPfh
	 BA/a4z/Oxi62zK9uK4KwgFcXWEIFaByo5n2FzjJXcxuwBlHF3YzRd4cWEqkvjUh6yS
	 YHpVaKSfsJi0IAvCT4wh6F94bh0X8hJkNBkw09bfWTYZUTx/A5N9ulFskI7nl/OzxC
	 8FZZvzTxS7AAw==
Date: Wed, 6 May 2026 15:35:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net
Subject: Re: [PATCH net 04/12] net: shaper: try to avoid violating RCU
Message-ID: <20260506153502.57ffd9aa@kernel.org>
In-Reply-To: <af591664-bb26-4b1b-93cf-cbcc68763d5e@redhat.com>
References: <20260506000628.1501691-1-kuba@kernel.org>
	<20260506000628.1501691-5-kuba@kernel.org>
	<59b26f1e-efd5-488e-8738-15e96b9c79e4@redhat.com>
	<af591664-bb26-4b1b-93cf-cbcc68763d5e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C11F24E1418
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
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285061-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 6 May 2026 17:32:10 +0200 Paolo Abeni wrote:
> On 5/6/26 5:22 PM, Paolo Abeni wrote:
> > On 5/6/26 2:06 AM, Jakub Kicinski wrote:  
> >> net_shaper_commit() overrides nodes which may be concurrently read
> >> under RCU. This is not a huge deal since the entries only contain
> >> config, worst case user will see inconsistent config params. But
> >> we should try to avoid this obvious RCU violation. Try to allocate
> >> a new node. Since commit() can't fail fall back to overriding.
> >>
> >> Full fix is probably not worth the complexity, struct net_shaper
> >> is around 80B, and the allocation is with GFP_KERNEL.  
> > 
> > I'm not sure if even this variant is worthy?!? The scheduler tree dump
> > could be still inconsistent, as the dump is not atomic. IMHO e.g.
> > inconsistent weights in the same WRR group would be as bad as
> > inconsistent values inside the single shaper.  
> 
> I mean: I would simply avoid addressing this RCU violation.

Alright. I'll add a comment instead (fix just the ordering WRT 
to the VALID flag)

