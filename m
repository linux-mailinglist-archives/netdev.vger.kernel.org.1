Return-Path: <netdev+bounces-282534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGgDKLGL8mmDsQEAu9opvQ
	(envelope-from <netdev+bounces-282534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:52:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9597749B288
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78F6830091D8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B6733AD8C;
	Wed, 29 Apr 2026 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGwfNMK5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B51F4C8E;
	Wed, 29 Apr 2026 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777503147; cv=none; b=DtsMUvtMWGNVl4CogPUWW57XB7cPJqDcHY0XHrx7AHMkKzNMttrY9cF6IDB+bsSeodpVlnaoqOPNoTNjabeIoFzO+y8/vFRf9UclS2HcCoXUx32fBrfN84iSEh2fddG+lnp43Noi6rXwFzNFdWWr0umiTribnY4SHGvP7nep0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777503147; c=relaxed/simple;
	bh=Mrf2QC+DyTywfTehaQWU6+MS6erYPjyMHwwxoUwvm9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ip8b+NScdmMqaOw7JSdG2Lcfq0NKcLytoXNvD47+CgMhqeQYqJVlvaFDFvzfYo5u6fbr+WXeyzWd+tlFHQAK1vN+NJEUNIEIxqHJO+SHQIpjPcWCILPTH3Pyk7+q15FbQN6pny/ta7Ba3bZse0smXVQlSQPG5S2vyYWvhErtAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGwfNMK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C55C19425;
	Wed, 29 Apr 2026 22:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777503147;
	bh=Mrf2QC+DyTywfTehaQWU6+MS6erYPjyMHwwxoUwvm9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VGwfNMK5dBs8R15/leSxVSF4LWNRDPT1zqcr7ybWetxSBYOOz2C+dIQD0huvbhm8H
	 bJDQebUGFjCKsMVy6v1V/oJybXySYuiZbSH8Xrz43pRAmgK0+fMktTt4WSC1XsmJFU
	 sUK7sGGmsgp2ZB6ATzRrI55X2KaNkT8g+RTj6f5/EY9aVWl6ukszk7gH3EPSiTJ3MM
	 KTsMm5C6W8AgfvFrQALC/bcHV9i5EZWipvmj4PXavy9oL3M+mRNl2fkzh65o/Y7+xo
	 vJIJ3PHs07+fp8Bv49lM7dXbtjrf39pqUKKYuK3L806AvntWTMoNlMVlH5/pwRa75f
	 g+CKlicJCUT7g==
Date: Wed, 29 Apr 2026 15:52:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Gal Pressman <gal@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Joe Damato <joe@dama.to>, Frederik Deweerdt
 <fdeweerdt@fastly.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/2] net: napi: Fix interrupts permanently
 disabled during busy poll
Message-ID: <20260429155225.3c476055@kernel.org>
In-Reply-To: <plfaoeyx3xfujleux6gmmlku3ancnp73g4aca7ep53zijbhjka@3ylcijhron2m>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
	<20260428175134.1197036-3-dtatulea@nvidia.com>
	<20260428164004.1f6902ac@kernel.org>
	<4c45f423-ea41-4ae8-9cb0-7aca9157d8a4@uwaterloo.ca>
	<20260428173154.7b6864ef@kernel.org>
	<plfaoeyx3xfujleux6gmmlku3ancnp73g4aca7ep53zijbhjka@3ylcijhron2m>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9597749B288
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282534-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Wed, 29 Apr 2026 08:13:55 +0000 Dragos Tatulea wrote:
> On Tue, Apr 28, 2026 at 05:31:54PM -0700, Jakub Kicinski wrote:
> > On Tue, 28 Apr 2026 20:04:13 -0400 Martin Karsten wrote:  
> > > Labelling this with number 4. might be misleading, sorry! The concern is 
> > > that a short enough timer (compared to the duration of the driver poll) 
> > > can be triggered before the NAPI_STATE_SCHED bit is cleared at the end 
> > > of Step 3.3.  
> > 
> > Ah. Just say that :D Two pages of buggy text, y'all would have been
> > better off using this one paragraph as the commit message.
> > Please don't use AI for generating commit messages if that's the cause.
> > It really is spectacularly shit at it.  
> I take the blame for this. Funnily enough, the text was written mostly
> without AI... Just wanted to present the interactions in a more explanatory
> way.

Heh, I guess I blame everything on AI these days :)

> Do you prefer the short version from Martin or an improved version of
> the long explanation?

That's what I'd do. The explanation should focus on the fact that the
current code arms the timer before it releases the ownership (clearing
STATE_SCHED). The intention of the __busy_poll_stop() outro is to either
schedule NAPI, arm the IRQ or the timer.

