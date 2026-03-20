Return-Path: <netdev+bounces-269726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id m9yEGACPvGlU0gIAu9opvQ
	(envelope-from <netdev+bounces-269726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:04:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C76BB2D4579
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9728A301AA8E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7CB632;
	Fri, 20 Mar 2026 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7NCmb2w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F164
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773965051; cv=none; b=JtarmHRipBM2xZJbI2EZaV+ap0Yucz+vN8b4SQSERLsvKYK04kE8WKnnBJ6KVzMS2WYeDmizdNcvw3iWU/Vf/nkmmbUMMtn6cfp2bKfusW3V7lKsFHz2uVtcrZ5JVgTEcXa+0E7kajtIvs5W+ObZAgksFFqLCZE8J4r9a3wRG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773965051; c=relaxed/simple;
	bh=Jdp2j7MB0SSMpazP9i5RC4XfnOXBueGrcY9VyOGsH8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/ER0wHukGLOeA9n9racDY6D0a3SS4GadKyOIRDPUrgvrm9AGLrob1hxWev2k+v6m6zgWgJi9f07eEu8W+/sKaTFikTrb794PXyKPAY39E6W4KJSqd1DR0+iqa8g1KbHuRE8zailZ+Wx/ooquNKBhQJwhi5nALHsauURimmjytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7NCmb2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3E7C19424;
	Fri, 20 Mar 2026 00:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773965050;
	bh=Jdp2j7MB0SSMpazP9i5RC4XfnOXBueGrcY9VyOGsH8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u7NCmb2waPmFEegmhJod0pO+jNp3c1Kaq/Pfs4SqXHpIc+mqAL17mktKwO5Ey8H4p
	 J+AR55xufDTliruKfu1s6gPDjKwwEHLDa49ExUgL4i0jLWuijnJlhf9cCnMCrlxvyP
	 MtJcfnLd2nIM7nD4Rc0ZjPV1wBvaD0tMcQ0THmQq2gGi0FfxBfDGbW1oz2AOeC0euo
	 h72mNbvlns5b+/RytJfDRulGOIduOeB613WbAcxP6oN9EXfEbg6iii9NTOSFGZ6IWR
	 0nMJvPj+KihTrfn32TY5qyM43JirQXu+m2aj31wo8mMqDBUTAL9YAC9kXrMruIu4fg
	 lzIWj0rnunRsg==
Date: Thu, 19 Mar 2026 17:04:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net] rtnetlink: fix leak of SRCU struct in
 rtnl_link_register
Message-ID: <20260319170409.3b8176d2@kernel.org>
In-Reply-To: <5ed5489ecdd05c43bd551804f3bd020ae349f3ca.1773849195.git.sd@queasysnail.net>
References: <5ed5489ecdd05c43bd551804f3bd020ae349f3ca.1773849195.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269726-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C76BB2D4579
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 17:15:15 +0100 Sabrina Dubroca wrote:
> Commit 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.") swapped
> the EEXIST check with the init_srcu_struct, but didn't add cleanup of
> the SRCU struct we just allocated in case of error.

FWIW AI has spotted a different bug while reviewing this:

As a related question about the srcu lifecycle for these ops structures,
is there a missing synchronize_rcu() in rtnl_link_unregister() that could
cause a use-after-free?
If rtnl_link_ops_get() traverses the link_ops list under rcu_read_lock(),
and rtnl_link_unregister() removes the ops via list_del_rcu() followed
immediately by synchronize_srcu(&ops->srcu) and cleanup_srcu_struct(),
what happens if an rcu reader finds the ops pointer but is preempted
before calling srcu_read_lock()?
Since no srcu readers are technically active yet, synchronize_srcu()
would return immediately, and cleanup_srcu_struct() would free the
per-CPU data. When the preempted reader resumes, wouldn't it execute
srcu_read_lock() on freed data?
Does rtnl_link_unregister() need a synchronize_rcu() after list_del_rcu()
and before destroying the srcu struct to ensure all rcu-side list
traversals have completed?

