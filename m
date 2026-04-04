Return-Path: <netdev+bounces-275340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKczIMLe0GklBgcAu9opvQ
	(envelope-from <netdev+bounces-275340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE74139A956
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 754F5300DDCB
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10B339A076;
	Sat,  4 Apr 2026 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skANa0Dk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66A2DCF62;
	Sat,  4 Apr 2026 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775296191; cv=none; b=u02GKL+LawVSxlPvd1RIxys0OwjC9ZJchJPZbxPSWgTjKnaDvYBUcgaEONftMSULibsvU6h8MADdmURIqnct8Sc+GgUklpHpKcYiZUx6YS0NCQE4mamHt2mrfA3tuydd493dH0/P8Elp1Gsb/sw/GwUWrr6qUVXSp6N9K+AZffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775296191; c=relaxed/simple;
	bh=qqEe1wRK66y0HpzT+1DMDi4lCJdN06J5JOFMVS/div8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxlBgp3Yo6bQew8s4CilNT3YHjoBon3tNCI/4CY6KIo3Siu3xjczi6N5qw1cj9w94YO54BjiFLun5V+g8VgIzFeK1efeFSjM9A5jMHm6AXnN0lB0EINHVnDR4NZcGqyclChIr6LWVz6kMn6ZyiCxGoNN+vp0iQBO/ADyGUS0Qdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skANa0Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D692C19421;
	Sat,  4 Apr 2026 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775296191;
	bh=qqEe1wRK66y0HpzT+1DMDi4lCJdN06J5JOFMVS/div8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skANa0DkKQzLdmSkgy0wVyLy9vQsLKCj3yB/RoCgmGBoySyg0IlqriDEe3PO0dyJx
	 FuFRux8VYeXAvtzkmpZTJNoS+Ot3YpctFRNWiDCa43GAqOuRA2xt9bWzysSzM3I91c
	 jrkU40V7J2d0gitihiGiM8nF+1jXZ57rs/O8aMIwCjcObff3qfnpIklGW0l4mV46oD
	 3BXQKici8solTLb7IsGjy0zZqGknNa9zY89dYA3tv0KTu0OJek8XKb3afXRJIBHFWN
	 6vlYgOfwoeUHV1xv0nmjE5UvyO3cMUucpFtXb5fslq7SqeFjYlSiQDLRxUE1LQtWP+
	 wRFOL5uQ5u9pQ==
Date: Sat, 4 Apr 2026 10:49:46 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 4/7] net/sched: netem: restructure dequeue to
 avoid re-entrancy with child qdisc
Message-ID: <20260404094946.GU113102@horms.kernel.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
 <20260402202037.176299-5-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402202037.176299-5-stephen@networkplumber.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275340-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE74139A956
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:19:32PM -0700, Stephen Hemminger wrote:
> netem_dequeue() enqueues packets into its child qdisc while being
> called from the parent's dequeue path. This causes two problems:
> 
> - HFSC tracks class active/inactive state on qlen transitions.
>   A child enqueue during dequeue causes double-insertion into
>   the eltree (CVE-2025-37890, CVE-2025-38001).
> 
> - Non-work-conserving children like TBF may refuse to dequeue
>   packets just enqueued, causing netem to return NULL despite
>   having backlog. Parents like DRR then incorrectly deactivate
>   the class.
> 
> Split the dequeue into helpers:
> 
>   netem_pull_tfifo()    - remove head packet from tfifo
>   netem_slot_account()  - update slot pacing counters
>   netem_dequeue_child() - batch-transfer ready packets to the
>                           child, then dequeue from the child
>   netem_dequeue_direct()- dequeue from tfifo when no child
> 
> When a child qdisc is present, all time-ready packets are moved
> into the child before calling its dequeue. This separates the
> enqueue and dequeue phases so the parent sees consistent qlen
> transitions.
> 
> Fixes: 50612537e9ab ("netem: fix classful handling")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  net/sched/sch_netem.c | 201 +++++++++++++++++++++++++++---------------
>  1 file changed, 128 insertions(+), 73 deletions(-)

Hi Stephen,

As a fix this is a large and complex patch.
Could it be split up somehow to aid review?

...

