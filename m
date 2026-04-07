Return-Path: <netdev+bounces-275868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +2j+J3Ob1GlHvwcAu9opvQ
	(envelope-from <netdev+bounces-275868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 07:51:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3503AA17F
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 07:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D9D300D871
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 05:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D493372B5A;
	Tue,  7 Apr 2026 05:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iGLm6ysB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A09C198A17;
	Tue,  7 Apr 2026 05:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775541104; cv=none; b=HtMCVf9oP9GB1NXi2pRzThsJdyX3UkJrXCfojKiAGnAbSh5ABpjaEgm+Qy3cjvWfHbUW2sCRNMS2tXKtQ7ik+NIXnsvq0kQ/ThcB8HCEFzaG+ZacPyg4G9KbvfxPSrZ0h6zwP0gFQ7expGp1X9NkDd2hs6Z5aXE5lJZEvsO3T0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775541104; c=relaxed/simple;
	bh=EdvLfQNQ4w2engwlknmyHJJh4zgexMwxSyaww4y2GpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeoSBZeTQ90n1Ht/APdGvUGtlIAgcoTINVZ85u7cHH7m42p8NY7HYoNmlOP0u53j8AbY+Vaa9oNgrp2nByWRe9ost6jFO/JN/QktkcOe/ZxMpx/ugbw+J8HfFmNgwwpbfv3tUt1erZGMESFeVrRjUvu3M2SH+sH4sqnH1Y0b4cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iGLm6ysB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEFAC116C6;
	Tue,  7 Apr 2026 05:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775541103;
	bh=EdvLfQNQ4w2engwlknmyHJJh4zgexMwxSyaww4y2GpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGLm6ysBjG1sqr7/X3Wg8XLOWPMUOdERfnT+2Y2N6ysvEUR2s/2mavTdO3/fsl6V5
	 qWr0IdboEVWxtaYnaLnYrtyCByDJBrzrVdwi5yETbltDmAVD4pkK7t0CkZ+xtFKiWR
	 5P3+t2YthhY8pKJgcy05OCo/sjFpL9rfSEVEHy5U=
Date: Tue, 7 Apr 2026 07:51:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] xfrm_user: fix info leak in build_mapping()
Message-ID: <2026040745-crafter-awkward-8901@gregkh>
References: <2026040602-shack-tamale-d8c3@gregkh>
 <20260406085449.266466ae@kernel.org>
 <20260406085859.2e9843ea@kernel.org>
 <2026040634-deodorant-shakiness-a64e@gregkh>
 <20260406103851.59a200fc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406103851.59a200fc@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275868-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: DF3503AA17F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 10:38:51AM -0700, Jakub Kicinski wrote:
> On Mon, 6 Apr 2026 18:08:27 +0200 Greg Kroah-Hartman wrote:
> > On Mon, Apr 06, 2026 at 08:58:59AM -0700, Jakub Kicinski wrote:
> > > On Mon, 6 Apr 2026 08:54:49 -0700 Jakub Kicinski wrote:  
> > > > You're right, skb owner is responsible for clearing after put.
> > > > Tho, Netlink is not as perf critical as real networking, I wish
> > > > we at least had a helper which reserves the space and clears it :/
> > > > This is not the first or the second time we hit this sort of a bug.  
> > > 
> > > We could make nlmsg_append() do that. Mostly because I don't have 
> > > a better idea for a name and nlmsg_append is only used once ;)  
> > 
> > As shown in my other patch:
> > 	https://lore.kernel.org/r/2026040621-poison-gristle-aaa3@gregkh
> > we need this in at least 2 places, don't know if it's worth doing it for
> > all messages?
> 
> I was thinking -- add the helper so that we can use it in places we're
> touching anyway. No need to mess with correct existing code.
> 
> > I guess nlmsg_append() would work?  It tries to do some zeroing out for
> > alignment for some reason...
> > 
> > Want me to do that?  I don't have a way to test any of this, I just
> > found it using some static code analysis tools that looked at holes in
> > structures.
> 
> Do you have any more Netlink leaks in the queue? If you do let's do it,
> if you don't we can wait until the next victi^w patch to arrive.

I do not have any more, sorry.  So is it worth it for just these 2?
Your call :)

