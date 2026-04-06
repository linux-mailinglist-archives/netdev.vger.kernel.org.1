Return-Path: <netdev+bounces-275672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FWSNH7Pv02kjoQcAu9opvQ
	(envelope-from <netdev+bounces-275672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:38:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C87AC3A5BE2
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29959300A754
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5853438F225;
	Mon,  6 Apr 2026 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TywodGea"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340F535B642;
	Mon,  6 Apr 2026 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497136; cv=none; b=kAAgKvMrO87+BUpEmuVYo6mJ1cDMM9ghKY5vmQfBlMue9kqidaBQy7frOE5BLpEVsiGE4sN+hwB7EhoTS7xlqg96KZqVzLOpAN9wIZhOmAoMiFJ4NusvSdaGq9ycRVDTtFHrsC896tDKva/lsvXxZd385g+FaA3hoA9voQ+h41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497136; c=relaxed/simple;
	bh=qp9nQEQMK1zCvpFTAczwQZrql6HAac7TAS6XL4uSgZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvuscSUh9PzTXZ2c83qFB8RH1TnD9ofwvpXlRKXl9WSOYE8mcazz9MFP6feewZ3P+/yNNpokm4mLOxaT5W5n5AFaxDSiOc18Kns6Q8NA84bahWP6EyXP9zh/PDhocVBGUWZWRp24MrYrDNuWePRds+4KO2W+HqUfXzML7VxYMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TywodGea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391B8C4CEF7;
	Mon,  6 Apr 2026 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775497136;
	bh=qp9nQEQMK1zCvpFTAczwQZrql6HAac7TAS6XL4uSgZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TywodGea+CLf92xpLCPHIDXIQLOLsE5vbztC1epzUzLi4M/Q/yAT+4dVjouy7xZoy
	 GAF6sSgdiaEys4ac8U/OUR7SlbYpk4nkQKvl0K3dFpMmdEh+fdOpySSgm9JqW9x0am
	 FQcpO2nxGTgyNi461YX23mnxnOq6fi9gj61Ci3VNy6qzpB02KOkdLJj068yO+KTRDh
	 PhsINVv4X6nTN07G3aFTMtwYV3ccxg3uEBDjJ1V3TtJDbDWnRxpC8apezmeOA7ZcoD
	 Gnj2pA9qkMGUcojfkJNSIhvFhDB9Hii+XlD7aA/DHeVSWjoM8PqM2ZO+9Ss1KqQ9zk
	 yoPeGLf0vWPZA==
Date: Mon, 6 Apr 2026 10:38:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net] xfrm_user: fix info leak in build_mapping()
Message-ID: <20260406103851.59a200fc@kernel.org>
In-Reply-To: <2026040634-deodorant-shakiness-a64e@gregkh>
References: <2026040602-shack-tamale-d8c3@gregkh>
	<20260406085449.266466ae@kernel.org>
	<20260406085859.2e9843ea@kernel.org>
	<2026040634-deodorant-shakiness-a64e@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275672-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C87AC3A5BE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 18:08:27 +0200 Greg Kroah-Hartman wrote:
> On Mon, Apr 06, 2026 at 08:58:59AM -0700, Jakub Kicinski wrote:
> > On Mon, 6 Apr 2026 08:54:49 -0700 Jakub Kicinski wrote:  
> > > You're right, skb owner is responsible for clearing after put.
> > > Tho, Netlink is not as perf critical as real networking, I wish
> > > we at least had a helper which reserves the space and clears it :/
> > > This is not the first or the second time we hit this sort of a bug.  
> > 
> > We could make nlmsg_append() do that. Mostly because I don't have 
> > a better idea for a name and nlmsg_append is only used once ;)  
> 
> As shown in my other patch:
> 	https://lore.kernel.org/r/2026040621-poison-gristle-aaa3@gregkh
> we need this in at least 2 places, don't know if it's worth doing it for
> all messages?

I was thinking -- add the helper so that we can use it in places we're
touching anyway. No need to mess with correct existing code.

> I guess nlmsg_append() would work?  It tries to do some zeroing out for
> alignment for some reason...
> 
> Want me to do that?  I don't have a way to test any of this, I just
> found it using some static code analysis tools that looked at holes in
> structures.

Do you have any more Netlink leaks in the queue? If you do let's do it,
if you don't we can wait until the next victi^w patch to arrive.

