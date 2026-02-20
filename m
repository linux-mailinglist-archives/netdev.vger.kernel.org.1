Return-Path: <netdev+bounces-259784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFAuGwfamGkSNgMAu9opvQ
	(envelope-from <netdev+bounces-259784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 23:02:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF416B195
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 23:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6B73300C802
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58D23033F2;
	Fri, 20 Feb 2026 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeCWLe1g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924382FE066
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771624963; cv=none; b=MHno7tDZ65y5YBraFUw5meUPdx/R7KMKMoju/jZfzE7ywsKYmlS6ym/f7TOMjwmylecLF/i9Sdfe9r/T9DRZNnMgsMaX9+o/Xq7mgmeMOWrDRuvNaasBtQwJ5bPzP9g7ZkS02LQygAOgv1mwTYR5C/vSYMC2YT+vPtQh4kTpQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771624963; c=relaxed/simple;
	bh=zT34QgshDzW7AakbWyyPFY3annK/h+oPJT+RP/PBLBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7qRZ0p6qP4XQg45ulXFWM4T7EsMolFlFFFc3lwIFShG1qOLHf6eUdAVN3K6njm63udJCv0Uc3ZWRfOJUZIOLUOtJXDxIStwq9/l5uwXvCwrwfer2HmzXMI85g/YhwDra4lP55aj7jZJGr3LmGj98Ppw7SPXcJnfRCuD+BtZiSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeCWLe1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BE3C116C6;
	Fri, 20 Feb 2026 22:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771624963;
	bh=zT34QgshDzW7AakbWyyPFY3annK/h+oPJT+RP/PBLBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZeCWLe1gTkH1phxAscFJrHOswqLqI+B1fISLM/CcbwQQjNcLGToJNszWYGEwkkG0P
	 A0OHTN5bPEN3wNyduDG+kxs55/DCR+l1CA6LO0H2kiM1ICKLjP1lBDoiTGEQ5h7ISl
	 JWlw+IIVkyXUDpnKO+caN8EESz9WgqiiS4BbNMvGKYVy/0gYROpCDYIikTv+Sm12Do
	 CYvbbZ2mu10n7pBgdjLHl+4kPxjdOCHmjb92JZaRwQWwsHJkmknsBre25CKLquI/AB
	 5Moga8YzLBgXR+TKeZUD/tLzolggHy6/qofgYZuzZzR9VqGoufWqgmPgqEgtpu+53i
	 HMi3GU9JCvJqQ==
Date: Fri, 20 Feb 2026 14:02:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Kurt Kanzenbach <kurt@linutronix.de>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de
 Bruijn <willemb@google.com>
Subject: Re: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
Message-ID: <20260220140241.51be1e30@kernel.org>
In-Reply-To: <willemdebruijn.kernel.85c1623c5d65@gmail.com>
References: <20260220183858.N4ERjFW6@linutronix.de>
	<20260220132932.1ed45656@kernel.org>
	<willemdebruijn.kernel.85c1623c5d65@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259784-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14EF416B195
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 16:49:24 -0500 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Fri, 20 Feb 2026 19:38:58 +0100 Sebastian Andrzej Siewior wrote:  
> > > skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> > > not be taken in IRQ context, only softirq is okay. A few drivers receive
> > > the timestamp via a dedicated interrupt and complete the TX timestamp
> > > from that handler. This will lead to a deadlock if the lock is already
> > > write-locked on the same CPU.  
> > 
> > Fine by me, the fix is fairly simple. But FWIW I can't stop myself from
> > restating that networking core is not supposed to be called by drivers
> > in hard IRQ context in general. Especially when it comes to anything
> > that may involve user sockets. So my intuition is that fixing the driver
> > to use a tasklet^w work_bh would make the expectations clearer.
> > 
> > Willem, you don't find that argument convincing?  
> 
> This narrow case seems fine to me too.
> 
> But I can understand if that would be a global rule. As it simplifies
> reasoning about correctness of core code quite a bit. In which case
> that would trump this. No preference from me. Clearly other drivers
> are quite capable of making this work without requiring updates from
> hard IRQ.

Well put. I guess we're in the same boat then. No strong preference
here either, but I like the clearly drawn expectations to simplify
reasoning.

> > BTW IIUC the driver in question was igc, and it did not exist for
> > another 3 years after the commit under Fixes, which is another bad
> > smell here.  
> 
> I was wondering about that too. But Sebastian shared quite a few more
> drivers: https://lore.kernel.org/netdev/20260217132838.kgRAQ87W@linutronix.de/
> I did not bother to check whether all were newer than the introduction
> of the blamed commit.

IIRC CAN did not have timestamping until relatively recently so none 
of those count. hclge is even newer than igc.

