Return-Path: <netdev+bounces-290505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEvNLaMwD2pSHgYAu9opvQ
	(envelope-from <netdev+bounces-290505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:19:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3056D5A91E0
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13D02348E4DE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69253630B2;
	Thu, 21 May 2026 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHaAbRSG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E5B361667;
	Thu, 21 May 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374785; cv=none; b=opnPGyFTmN5Mje/RsWpS+ndqaiJz4t6lkOvqIyg+w/1oVcRNbIr+rZCAIS9MtlH40i5Q/TPQUrED9lceqAI1YBwtQCjR6SjLzj1Pw+rGnwwbh/PxP1ZQAg9vraFfsYLgZ7WgoPwxfjbi+ctIAXmfBxrGRZI0x9WSdlaXxAKEmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374785; c=relaxed/simple;
	bh=UqFj0OYKQ5SbVZfqgMgTcu5W8GyqDOp2mxfnKSHGWgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcoRteliuDmFB6nLUmqoyxNpNwWq6LcJfkJrkK5obA+hqdyKC96e+h7zhkPaQ4sov1jpbV16sMqj0XZMD7lgzrAn+zQWhXCznVwfYAhPErPZ7IFZn/WLRQzTojGDmzsiSKpTnH/2ti5+cAypW6cZ/LUQoKZk0XZo2OJFAFK/TAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHaAbRSG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA36A1F000E9;
	Thu, 21 May 2026 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374784;
	bh=FVS3s24HfC6S8k1o5yBNySDjxv7RhbXECfZaP0o73Og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hHaAbRSGT4lJxnb/rMTAEv3iCDCYsYlqbWL1XUO8L+zWLx34tKR15bNzLU1S9HNUU
	 RBx8UH6BNhocgOrHCCOcEcY0IUZnlWnskSog/rC76hU0PKUMXSw31Hng48CuacSFSf
	 VtJCOhGjwlAqzXbjmhMP76LBYjHvbqX4bNGTB8Y2TNbTDbnoXTWg9Uoajxm6ky5eYB
	 jPg4Zkv7iWRXUpdu6/T/+Fv0cQL8cmCwy/uYE3qulOeLzIOvVWzRsAxwU0D7hbMI03
	 GSKYeBC8DkYJg82n2/3rCDa5+czPNAjmbefxd3fTR13TuMxjhp007eFTBKd+LbPBbm
	 ZDBU5cSUWaRng==
Date: Thu, 21 May 2026 07:46:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: michael.bommarito@gmail.com
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jchapman@katalix.com,
 tparkin@katalix.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] l2tp: use list_del_rcu in l2tp_session_unhash
Message-ID: <20260521074623.15efef0f@kernel.org>
In-Reply-To: <20260521143654.1980290-1-horms@kernel.org>
References: <20260518183447.64078-1-michael.bommarito@gmail.com>
	<20260521143654.1980290-1-horms@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290505-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3056D5A91E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 15:36:53 +0100 Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> l2tp: use list_del_rcu in l2tp_session_unhash
> 
> An unprivileged local user can pin a host CPU indefinitely in
> l2tp_session_get_by_ifname() when l2tp_session_unhash() uses list_del_init()
> while the list is being walked under RCU. This commit changes
> l2tp_session_unhash() to use list_del_rcu() to match the existing
> list_add_rcu(), preventing the infinite loop.
> 
> > diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> > index 157fc23ce4e14..1455f67e01ddb 100644
> > --- a/net/l2tp/l2tp_core.c
> > +++ b/net/l2tp/l2tp_core.c
> > @@ -1360,7 +1360,7 @@ static void l2tp_session_unhash(struct l2tp_session *session)
> >  		spin_lock_bh(&pn->l2tp_session_idr_lock);
> >  
> >  		/* Remove from the per-tunnel list */
> > -		list_del_init(&session->list);
> > +		list_del_rcu(&session->list);  
> 
> Can this change lead to a use-after-free in l2tp_session_get_by_ifname()?
> 
> By switching to list_del_rcu(), the deleted session remains visible to
> in-flight RCU readers. If l2tp_session_del_work() drops the session's
> reference count to 0 concurrently, the session will be queued for
> destruction via kfree_rcu().

Saw this, but I don't get how list_del_init() -> list_del_rcu()
can change visibility to the readers :| Without digging into the code
this reads like Gemini reporting a different pre-existing issue.

Michael, could you investigate?

> If an in-flight RCU reader in l2tp_session_get_by_ifname() encounters
> this session before the grace period ends, it will execute:
> 
> 	list_for_each_entry_rcu(session, &tunnel->session_list, list) {
> 		if (!strcmp(session->ifname, ifname)) {
> 			refcount_inc(&session->ref_count);
> 			rcu_read_unlock_bh();
> 			return session;
> 		}
> 	}
> 
> Since refcount_inc() does not protect against zero-reference transitions,
> the reader will obtain a pointer to a session that is already pending
> destruction.
> 
> Once the RCU grace period expires, kfree_rcu() will free the session
> memory, causing a use-after-free for the caller.
> 
> Should l2tp_session_get_by_ifname() use refcount_inc_not_zero() and skip
> the session if it returns false, similar to other getters like
> l2tp_v3_session_get()?



