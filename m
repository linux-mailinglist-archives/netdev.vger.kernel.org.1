Return-Path: <netdev+bounces-270124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q1dXMbrnvWlfDgMAu9opvQ
	(envelope-from <netdev+bounces-270124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:35:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2087D2E2976
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EA4D303B4CA
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BDC2C0323;
	Sat, 21 Mar 2026 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etcwypqI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D79276058
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774053303; cv=none; b=GT7AbgGEgOyJmhlEsbv89etqyLlaI3I+oEmxQLZ3pGLVkVPDLmI79ilmuMMY7uZT+TcN/xDq8/TD8GieUvHbCtmQ0FXKBNA6cuHq6TRalYHtTuU+psg5EtR/9OuFU5H8ol2/FotfQd4KWP3Hd8ljFdkrjCz/QZALZSPEd87aAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774053303; c=relaxed/simple;
	bh=04xS8UG35du1aMjwH3VDhtSpIuCIR5x02bBi3UuvsUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOgzvJG8fsEtJ3K2xx0Sx/wpybvJfw8rxga76q/mmVhH0eul4GyRlACxuKYP6UzpwFJ1Lleh+IKJbN0x/xazRkM/PNZGz8kVRYMxPXQRlh6wSfdEDOlduPAbTVq4e/Z+6lmKxUhKAJfJtQopqPsMleqhiVP5AJEU7WNVcEyomcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etcwypqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7FAC4CEF7;
	Sat, 21 Mar 2026 00:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774053302;
	bh=04xS8UG35du1aMjwH3VDhtSpIuCIR5x02bBi3UuvsUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=etcwypqITwNF7a1iFi06B733cXap3jgKr03guA8zZfyuBMKuJWPd9t/IT/QGqkPIl
	 QtUJSRs+yy+wo1g9EqB9zZyFrtZlfGqfHEt1yVHPQZUJirxgc2EX8D0z/3D/TcEnEc
	 J7bTWn7Uol2goVTaRvHF6+NN8r22LyDaj2ZwS50Shq3Q2Yk7x7VmXHJLzg+jKTkPRx
	 JgKRYXQ12D3kb9thWdy6g6fKGniEoYFfjLlOUbMU8LwKO0erxy+5a/SavlUY/R80O2
	 c0IdT5oZr8rrggcR28hKzntxxS7xWyfA0AwOfs2nib1aZ15YHR5AV4jS/bG1CeHvyz
	 9QB0V9YOgnDkw==
Date: Fri, 20 Mar 2026 17:35:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net] rtnetlink: fix leak of SRCU struct in
 rtnl_link_register
Message-ID: <20260320173501.5f9adee0@kernel.org>
In-Reply-To: <abz1_nbd2ep-RL6Q@krikkit>
References: <5ed5489ecdd05c43bd551804f3bd020ae349f3ca.1773849195.git.sd@queasysnail.net>
	<20260319170541.27c75eac@kernel.org>
	<abz1_nbd2ep-RL6Q@krikkit>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270124-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2087D2E2976
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 08:23:42 +0100 Sabrina Dubroca wrote:
> 2026-03-19, 17:05:41 -0700, Jakub Kicinski wrote:
> > On Wed, 18 Mar 2026 17:15:15 +0100 Sabrina Dubroca wrote:  
> > >  	list_add_tail_rcu(&ops->list, &link_ops);
> > >  unlock:
> > > +	if (err)
> > > +		cleanup_srcu_struct(&ops->srcu);
> > > +
> > >  	mutex_unlock(&link_ops_mutex);  
> > 
> > Does the cleanup have to be under the lock?  
> 
> Right. I'll send a v2.

SG, I'll mark this as Changes Requested then.

> (OTOH I don't think we'll ever have to worry about contention on this
> lock, but we've probably said that about many locks in the past)

Right. I'm not sure why I feel this way but the way the condition is
placed makes it read to me as if being under the lock was important :S

