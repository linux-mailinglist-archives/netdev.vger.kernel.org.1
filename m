Return-Path: <netdev+bounces-270770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KkSNzy7wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:14:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9DF2FE235
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 774C4304DF18
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DAE381B14;
	Mon, 23 Mar 2026 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foxgY4sE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51F330650;
	Mon, 23 Mar 2026 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303903; cv=none; b=VQmyHo0SDI1nofoWjXUIBOg75ug7I/njzfBkgVCeckdQLrFz9LXPHBjr/eVsxYgEiOeXQNUHKW6CILnScoT1nmf7p53j4Xy5oJW1GXJUmiryuoHfsZl4HETyfYCZqs0MYDKf7HA88eOtA6DKUaNOkUoWzmKyDo3hWg41AhNJd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303903; c=relaxed/simple;
	bh=oi8pjN7S8In4Z2xn0fpwQqK47XTGPsQdn3qfqTF7dX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyKjwigx3bOgd5fpaT56HCse8Bdxff9vp/FGNCIpXz2T1GKHDETKjkPISeyk0ptGq8sSe8k4GhTO3EYYf+CZaJ6C/cgN5F6UUGqVxhMBarHdmRvg894mwboyHlalCmFSiD+bLtc6J4BnLDWZX+cD/57WZVQ9SYKqeL96ieGILG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foxgY4sE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A59CC4CEF7;
	Mon, 23 Mar 2026 22:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774303903;
	bh=oi8pjN7S8In4Z2xn0fpwQqK47XTGPsQdn3qfqTF7dX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=foxgY4sE9/S2TyMt81Nfyp4W+6MLwcTd2iIbfFxaZvwmPmULWriF72z1W3SWuHe+7
	 6f2/rOwXEwLxBPayD3IvxJKXqnnX862QMt4Z7WrubScr1fBlTsMp6W6ZRTgfE6IbnK
	 PD5B9D0jrVwnca51opvMgShf6RcTZRSGG2yEdB0988pD9lQ0BOsXsnztE4jpDF8azH
	 PsBhXo61VswqovpBChJ2e+9au780kdn7OooL11EBPomJxnC9TWnN3OMIZm7bEMhCBd
	 NxMs78pr7YCPfqnS/FsnF66EHfcHGEIhU/4XAilQnH7/F0/Ui+vfZazqjahzs3jbV8
	 Tm5kjxbgM1h/A==
Date: Mon, 23 Mar 2026 15:11:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org, horms@kernel.org,
 alok.a.tiwari@oracle.com, davem@davemloft.net, marc.dionne@auristor.com,
 linux-kernel@vger.kernel.org, security@1seal.org, stable@kernel.org,
 pabeni@redhat.com, anderson@allelesecurity.com, jaltman@auristor.com,
 edumazet@google.com
Subject: Re: [PATCH net 2/5] rxrpc: Fix use of wrong skb when comparing
 queued RESP challenge serial
Message-ID: <20260323151137.2fff6da3@kernel.org>
In-Reply-To: <3585122.1774302668@warthog.procyon.org.uk>
References: <20260323144541.3ef887b7@kernel.org>
	<20260321014543.3892478-2-kuba@kernel.org>
	<20260319150150.4189381-3-dhowells@redhat.com>
	<1433905.1774080919@warthog.procyon.org.uk>
	<3585122.1774302668@warthog.procyon.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270770-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E9DF2FE235
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 21:51:08 +0000 David Howells wrote:
> Btw, do you know how to credit the AI site with reporting something?  For
> instance for syzbot gives me a Reported-by: line that carries something that
> can be used as an email address.  There were other things in the AI report,
> some of which I added patches for.

I was also wondering about that. syzbot reports are for stuff that's
already committed. Most of the CI and AI reports are pre-commit.
IDK if we have a way to attribute issues caught before commits go in.
I guess AI reviews are an integral part of the process now. We don't
have a tag for when reviewers/maintainers catch bugs in patches either.

