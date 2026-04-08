Return-Path: <netdev+bounces-276611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OydGKSA1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:21:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB403BEC63
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4614B3006D62
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F71348465;
	Wed,  8 Apr 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpgavbh9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00946293C42;
	Wed,  8 Apr 2026 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665309; cv=none; b=DqpHDowsMJbVIDveY9P2Ea3HIHa4EzvZds019gubXJ6hjesdJ+CqGzCVRqvtvDHu8LITn9oN7/tNXxdWGsDjfTLtNkjbit7hnYWwrlxtcmcbnTjdkgg+ou26QYgkEoXeMnGv9KGWyZX1h58KxVjgyu4uPGizCdu4EfGWBGN1wOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665309; c=relaxed/simple;
	bh=eFlWwu1HzRynFDL0it95KiUCLHusEYw3hTsKQLMjjhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+CPPGxyOuYQy/VjyJ8GEhabm7vMGG+9whCjH4NgdvO9bXs4kwkL2kA8voYIRlcSJgf4OajFBXz3xUgAOeBNnrDrZdy3whw99HxYRZ9VQvipLgQRTiNsUma3NT8nj1NHHQ6nNgmDFeZWk6We23Bp5Buyr4P9/Kiqn8pipZaLHE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpgavbh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E920FC19421;
	Wed,  8 Apr 2026 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775665308;
	bh=eFlWwu1HzRynFDL0it95KiUCLHusEYw3hTsKQLMjjhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tpgavbh9VWZGQGZRMl/2boFWGe3t3cOY1KQPTk7ab3b6D2CryBOv8b3DMpDbGlL4z
	 afmQ+1bfkd6guhsnFGtJgtxOW7dxqEXyvRHpFMfp+RNxpkuIeYPIrFKJM/6OBpM0Mk
	 f+r6AiIlADucuhAF18Np4tbYwSJgPRgsdG+bp2Zs4TlQKu1npeseAhORxjfKhWhCSv
	 Yr0fIRdBl6ua0jOgE+/uS0JTtQlp4s/pUQMAWSaL0u/JBSEngpJg0C5J6N3EelEqN4
	 CXXMQf4EmxidXdhqzQS0vc3LhEfKI0+0QFkaly/PwGbFKLWLDXHLE627rpqA2yxaiT
	 INqoU5w+RECYQ==
Date: Wed, 8 Apr 2026 17:21:44 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 4/7] net/sched: netem: restructure dequeue to
 avoid re-entrancy with child qdisc
Message-ID: <20260408162144.GC469338@kernel.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
 <20260402202037.176299-5-stephen@networkplumber.org>
 <20260404094946.GU113102@horms.kernel.org>
 <20260406084133.47bcfc8f@kernel.org>
 <20260406101238.2d106bfd@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406101238.2d106bfd@phoenix.local>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-276611-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BB403BEC63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 10:12:38AM -0700, Stephen Hemminger wrote:
> On Mon, 6 Apr 2026 08:41:33 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Sat, 4 Apr 2026 10:49:46 +0100 Simon Horman wrote:
> > > On Thu, Apr 02, 2026 at 01:19:32PM -0700, Stephen Hemminger wrote:  
> > > > netem_dequeue() enqueues packets into its child qdisc while being
> > > > called from the parent's dequeue path. This causes two problems:
> > > > 
> > > > - HFSC tracks class active/inactive state on qlen transitions.
> > > >   A child enqueue during dequeue causes double-insertion into
> > > >   the eltree (CVE-2025-37890, CVE-2025-38001).
> > > > 
> > > > - Non-work-conserving children like TBF may refuse to dequeue
> > > >   packets just enqueued, causing netem to return NULL despite
> > > >   having backlog. Parents like DRR then incorrectly deactivate
> > > >   the class.
> > > > 
> > > > Split the dequeue into helpers:
> > > > 
> > > >   netem_pull_tfifo()    - remove head packet from tfifo
> > > >   netem_slot_account()  - update slot pacing counters
> > > >   netem_dequeue_child() - batch-transfer ready packets to the
> > > >                           child, then dequeue from the child
> > > >   netem_dequeue_direct()- dequeue from tfifo when no child
> > > > 
> > > > When a child qdisc is present, all time-ready packets are moved
> > > > into the child before calling its dequeue. This separates the
> > > > enqueue and dequeue phases so the parent sees consistent qlen
> > > > transitions.
> > > > 
> > > > Fixes: 50612537e9ab ("netem: fix classful handling")
> > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > > ---
> > > >  net/sched/sch_netem.c | 201 +++++++++++++++++++++++++++---------------
> > > >  1 file changed, 128 insertions(+), 73 deletions(-)    
> > > 
> > > Hi Stephen,
> > > 
> > > As a fix this is a large and complex patch.
> > > Could it be split up somehow to aid review?  
> > 
> > +1, FWIW it's perfectly fine to have refactoring patch in a net series
> > (without a Fixes tag) if it makes the fix a lot easier to review.
> 
> I split it into refactoring followed by fix for next version
> 
> The fix alone just gets really confusing to look at;
> I got more confused the pre-existing spaghetti code here..

Thanks Stephen,

Just to clarify, in case others come back to this thread for some reason,
that the aim here is to aid review. So whatever works in that direction is
appreciated.

