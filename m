Return-Path: <netdev+bounces-290121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCvcNx1FDmoM9gUAu9opvQ
	(envelope-from <netdev+bounces-290121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:34:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 322B159CCE5
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1101A34820DE
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A643B6368;
	Wed, 20 May 2026 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+IBJMrN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466373B892D
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314722; cv=none; b=Q3b3qig70DuIyRufC+5NnMVeNfBoYQoPLWou3NH76dC5Rc9wu+agvoabEIZ7UgFjb1yRnFFRmYEq8Pzbtz0sBDfm3Enngj3a9HteP2KRyjJ7cGaoS4/ombvPXjf5HwkPydH/bTcxW7g3jqN9Afex69RaVCsCKWZJWwH07mQwCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314722; c=relaxed/simple;
	bh=EAHj+kn6zB+s9R9kYRpAYo5FWjV8HrADCmvZWmSfGnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frvi3huXGr5zyC34/OhqLgYw2EWPLoyDouovQyZpMUJdwLo7dEwEOMTtgkGAdrIQtB/l0TBgwPMRYzjgEV75N6oFpS7YJl2RZ+hCWbvomsVlBvF54l7tcnZJ/S7cJCNmXrWdhSaHiIpOqdsBhPj4ZH+Gk3s1m/02Ez1B8y0AM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+IBJMrN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355C71F000E9;
	Wed, 20 May 2026 22:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779314719;
	bh=G1PwypRSKkHU7CNvvo+j/kzpCpTnWOTagmLtKbZfVNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K+IBJMrNxPlSbXrOGEQjMcu3pgfL385kGkvyiO9VffK78DnuQPiDQ5+Q+5VyaAS6+
	 TybYAz2TS4QDvl9XQn6vdyYVYLig8/STJnJjOyyOfcdKMZbjkhzhz1alYEa08Vi7EN
	 bGvd3cij1+eiTsluN1c3/yBBGw1++w4dvLFyHm+OK9hAFSFpWnV++QGI9V3ZwmzEFi
	 Ww4nTlcU6iSxhPChDLvwBges7+4rRM7/ucWAncsJJVXq5UHaORu/TnacSwxZeXT0U4
	 7pp02nb7ep1yQ70GkYmCM/p3kHlFMRNm7PWMTLPc7RKtG8E+ukrCrEF6Kkwl/Hzr2W
	 82JBh5j3saO/w==
Date: Wed, 20 May 2026 15:05:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Dragos Tatulea
 <dtatulea@nvidia.com>, Alice Mikityanska <alice@isovalent.com>, Matthew
 Schwartz <matthew.schwartz@linux.dev>
Subject: Re: [PATCH net v2 2/2] udp: Fix UDP length on last GSO_PARTIAL
 segment
Message-ID: <20260520150518.2e65eb26@kernel.org>
In-Reply-To: <f829d309-a4b8-4474-85ab-da5ffffc801a@nvidia.com>
References: <20260518062250.3019914-1-gal@nvidia.com>
	<20260518062250.3019914-3-gal@nvidia.com>
	<20260519181200.323fbaef@kernel.org>
	<f829d309-a4b8-4474-85ab-da5ffffc801a@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290121-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 322B159CCE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 19:34:17 +0300 Gal Pressman wrote:
> On 20/05/2026 4:12, Jakub Kicinski wrote:
> > On Mon, 18 May 2026 09:22:50 +0300 Gal Pressman wrote:  
> >> +	if (!skb_is_gso(seg))
> >> +		/* last packet can be partial gso_size, account for that in
> >> +		 * checksum.
> >> +		 */  
> > 
> > No need to repost but I think we should tweak this comment.
> > Saying "partial gso_size" when it such segment is in fact
> > not part of GSO_PARTIAL is a bit confusing. How about:
> > 
> > 	/* Unless skb fits perfectly as GSO_PARTIAL, the trailing
> > 	 * segment may not be full MSS, account for that in the checksum
> > 	 */
> > 
> > ?  
> 
> Sounds good, should I submit a patch?

I'll edit, don't want it to miss the PR

