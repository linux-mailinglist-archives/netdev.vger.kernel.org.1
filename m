Return-Path: <netdev+bounces-288019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFfhBa3mBWp0dQIAu9opvQ
	(envelope-from <netdev+bounces-288019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:13:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CACF543CDD
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C0DB301E995
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF18426EC0;
	Thu, 14 May 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWGvkrEH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA614426D1D;
	Thu, 14 May 2026 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771359; cv=none; b=fu4aB/KwBRcSp4pKMBcKnymz6Yc7MaAQGGzGURPN/dUowKqoY3QHA/+D7cdBrKHZapOcyW00hGvIGiGxkGvA78VF5/7SfGR/OiscMGgA8EtC7AWmrzMaD+Fb5vPdO+HzOQAgI7KWNJDzn35edOWX8WgbMsjVZ23YMloRjHCqWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771359; c=relaxed/simple;
	bh=RC+hKj6gClWLJMMIFEIpRAg0/fF1WWAnr3TXhUXqe6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RV3Ww+jbfYp8p73too1XvfWCurJe3gF1kXz64sDieNGGDPhFUZW8xeVSY8KctgCwk7KS5g+uQrQMdyIhs2bmX+ziDPeX9/v5IGkkSL/grebnWdcPEHwl/EHAWUCXLEiDl3HCYPi0s7j+8mxFYJX1tLKsm5UveHxPHbYmtDk47Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWGvkrEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB87C2BCB8;
	Thu, 14 May 2026 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778771358;
	bh=RC+hKj6gClWLJMMIFEIpRAg0/fF1WWAnr3TXhUXqe6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gWGvkrEHIyjpcWAYXRETMEmevEygWWV3GR5YQnUQG4whdlTkEZwyIbiWbKJ/vV9RK
	 1/lKQAiehLvi9fsb1Al/mC6n2wxTP0ub2hYLeAMKEUZth/mFibIFtzMSEKTv14JBti
	 z5fXYgnLEB+TeoPvMoJ5vwWrGtYj8fxIldM3Bl7zOPfYqQgdSQK9C/0IImGA5xbVdu
	 fnI8OqD/ahDKUrFq/AH/mXEK/PYzTgrGX6Bl+6xEFpiLMxJx0Udc62f+8BEE4crlLF
	 68wiIHqhI5jJGEeJolFL7Pgdx6FuKlSYpQOw5LSUpaCpQz7MAdGlQV87u5gz4DVESe
	 fGvd7zr6ZKs8w==
Date: Thu, 14 May 2026 08:09:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org
Subject: Re: [PATCH net v2 4/4] net: tls: remove bad rollback and UAF on
 ENOSPC
Message-ID: <20260514080917.386505e7@kernel.org>
In-Reply-To: <agXks9BGNvcE3WPz@krikkit>
References: <20260511174920.433155-1-kuba@kernel.org>
	<20260511174920.433155-5-kuba@kernel.org>
	<a83d79d1-b932-458a-b5fa-1cb623fa03f1@redhat.com>
	<agXGJ2v-Gnf5trWX@krikkit>
	<20260514075504.1790a187@kernel.org>
	<agXks9BGNvcE3WPz@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7CACF543CDD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,vger.kernel.org,google.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-288019-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 14 May 2026 17:05:23 +0200 Sabrina Dubroca wrote:
> 2026-05-14, 07:55:04 -0700, Jakub Kicinski wrote:
> > On Thu, 14 May 2026 14:55:03 +0200 Sabrina Dubroca wrote: 
> > Or not, cause frankly TLS+sockmap feels a bit hopeless at this
> > stage.  
> 
> :/
> How long do you want to give Daniel/John (or others) to chime in on
> the cover letter? (it's been only 2 days, but it feels like much longer)

It does! Could you ping them off-list with the link to the question?
There's a solid chance they missed the question, hopefully the direct
email bypasses email filters..

