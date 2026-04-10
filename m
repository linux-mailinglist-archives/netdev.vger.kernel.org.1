Return-Path: <netdev+bounces-277356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKerNZTh2GnHjAgAu9opvQ
	(envelope-from <netdev+bounces-277356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:40:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4F73D6486
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98E933020774
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F67639F172;
	Fri, 10 Apr 2026 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVb8i2ll"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDDC37EFE3;
	Fri, 10 Apr 2026 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775821202; cv=none; b=ctsbqARjuA7ArtU7SuSz+3fVDvbw0nYxJ1ItkbmZgGHeN5CE8oxBijc0PJAh4kW2GWKc1IDg3++IGz20T3WpK+j/bF5dPCu/yrXqs4RrJXIUmnZgLbTYiwNzimXqG/VNByKjDKL9z/8S3gLXxK9suzfEz6qjTnPKvmyV4bi71y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775821202; c=relaxed/simple;
	bh=SH551Wjva/R27IpLZMFIIb7R0fTqglG5CniuwMHqU/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd1XEjCPy0nobZmhqo5w3646qkaTBIS87X7pq24hGuy0ve4moHTwXu4tesq/5+5tRfp552lqag5JpLPNzSRZI6kjBubrNj2iwwnAtPTK6vew7Zfsb53mjnZo2/95hy/kNuHkyyupTch/Uei3osavrzBtgHtWvlzz0FpL7cmlB9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVb8i2ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C49CC19421;
	Fri, 10 Apr 2026 11:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775821201;
	bh=SH551Wjva/R27IpLZMFIIb7R0fTqglG5CniuwMHqU/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVb8i2lle/LvVlU4ii3wbKeY1nT6Jzrp5rnb9fslJQqq7veJPxTOBIo2QPiXVY4fw
	 m5vFdKMR7jmiCOcAOcRRzmF6G5M/ejQEptOHQ6x3Ez+68Eja6wIGWUddSGJnaQsMGd
	 3ywOcL4xXlxIrTEUyfuEaOhrKFqJqr5Ca5+pA42CoUfePOVvIliUig5rIZZaxzhBxc
	 9pV7tSNUEwfecbytc3Zeo8uGAY0b+ON01lkyyQUFX7fbfyrqQsn8tlU41PbspDlh10
	 FrcTOB7qB80DkzvlQ0PTh59dT+bmQgUSKIaj1QFybKvYU5rhPY28c+GAJAKrToaqi4
	 LUJBEMY6a/OCg==
Date: Fri, 10 Apr 2026 12:39:57 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4 4/8] net/sched: netem: refactor dequeue into
 helper functions
Message-ID: <20260410113957.GV469338@kernel.org>
References: <20260406172627.210894-1-stephen@networkplumber.org>
 <20260406172627.210894-5-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406172627.210894-5-stephen@networkplumber.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277356-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D4F73D6486
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 10:25:12AM -0700, Stephen Hemminger wrote:
> Extract the tfifo removal, slot accounting, and child/direct dequeue
> paths from the monolithic netem_dequeue() into separate helpers:
> 
>   netem_pull_tfifo()    - remove head packet from tfifo
>   netem_slot_account()  - update slot pacing counters
>   netem_dequeue_child() - enqueue to child, then dequeue from child
>   netem_dequeue_direct()- dequeue from tfifo when no child
> 
> This replaces the goto-based control flow with straightforward function
> calls, making the code easier to follow and modify.
> 
> No functional change intended.

Manually verified (as best I could :)

> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Thanks for splitting this out.
It was very helpful.

Reviewed-by: Simon Horman <horms@kernel.org>


