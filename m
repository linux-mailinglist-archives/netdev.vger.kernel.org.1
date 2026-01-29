Return-Path: <netdev+bounces-254943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPrEMtfoe2mcJQIAu9opvQ
	(envelope-from <netdev+bounces-254943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:10:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33483B5986
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFAA3300A8E6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B636BCED;
	Thu, 29 Jan 2026 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwPGJ551"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1921CA0D
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728213; cv=none; b=dIN2gCIb8ZWY5zvxaPBk4kjuUUlMcbXFkN8cBrFYDxdgowfPAPc79U2rlFpcFUJppCTe2D5UrNyljIkAAmfYx/16HdPYvH0gipUyF/JIt2KB9ziDsMHGD0qiOJmsvOYWOzsEoBlB3d5zJOwit0AnJ7m/vXK2bvgocdCVz3diaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728213; c=relaxed/simple;
	bh=5O3CHJrhYFBuSKu3a7RiwqnPcD0RYQnjTBbEv5V+tgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NT1rVSmne+ZNKsIbuZqbUorc0pRrqD0L1LLqmCHomAu5V2rssx6r4F8ES2tdn/ANmQqCF7CeXGJlHtMDQhB0ubFu8Oe3zWXNtM3hhsyTPGLIjmp4pYqSpBumJIigIePaiE4m8MYbBsYY4zAniO/hrfZ9uRTBZPvii4WPXpNeb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwPGJ551; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0693AC4CEF7;
	Thu, 29 Jan 2026 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769728212;
	bh=5O3CHJrhYFBuSKu3a7RiwqnPcD0RYQnjTBbEv5V+tgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bwPGJ551GwqeQAw2Lk88/FdCs2o4nBfjll6EQ8NdgSW+N5f0ul2agNIQ9pykfOPtY
	 SyGsZXqQsXJgGcGCaH0UkkYWQ5aRsnbWO3LtmwWCcIfcJTvhiXQw6FvdT55suMwYr2
	 vJ1yBqIOR9LbPo4gl+mFz1jGpczH3uRdOwgHXBNNNblhMdTVVOHo4SaErW3YprDIZp
	 Gnzc9j0xVwnAvzReRM4Dk12yXIWrCMCvq+narmuobLmmtEIhvI/bJLJs/akU+fjiqn
	 HMUDzHzEVsG4TkjszBGXvxeOdvDW13o+eOeKeuP9MpOhm+lncbfSi9BGpi8XLmYnBm
	 j6MnhgvihJzJg==
Date: Thu, 29 Jan 2026 15:10:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
Message-ID: <20260129151011.0c0e4f61@kernel.org>
In-Reply-To: <20260129150459.29419003@kernel.org>
References: <20260117164255.785751-1-kuba@kernel.org>
	<CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
	<20260117150346.72265ac3@kernel.org>
	<CANn89iJ8+5OaWS2VzJqo4QVN6VY9zJvrJfP0TGRGv85mj09kjA@mail.gmail.com>
	<20260119090435.44b1da2d@kernel.org>
	<20260129150459.29419003@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254943-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33483B5986
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 15:04:59 -0800 Jakub Kicinski wrote:
> > > I was mostly concerned about latency spikes, I did some tests here and
> > > this seems fine.    
> > 
> > Looks like selftests run into the zerocopy Tx latency issue.
> > I'll drop this version from patchwork..  
> 
> Delaying zero copy forever is a bit of an annoyance.
> I believe the same thing can happen in net-next with UDP 
> but I haven't tested to confirm.
> 
> I assume the attached patch is out of question since it came up before?
> 
> [0001-net-periodically-flush-the-defer-queues.patch  text/x-patch (9441 bytes)] 

Ugh, too many patches in my /tmp. I attached an old buggy version, 
but you get the point.

