Return-Path: <netdev+bounces-276286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFGiGcvq1Wkd/QcAu9opvQ
	(envelope-from <netdev+bounces-276286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 07:42:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E4E3B7538
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 07:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FFEB3015E10
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 05:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A006635AC1C;
	Wed,  8 Apr 2026 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i1A8d1RC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773801D88D7;
	Wed,  8 Apr 2026 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775626947; cv=none; b=GvjMSU0WJdNYZOQ4v7k92SLCGEjdYu9kf30hqxTWwpRWQqKQTQ382+hr2sOs2KGl3gL2ZCG+Da/1EJjqeiffjnyqek7wXM1Tm4MxhathzXr1nmCH79FLx6kBgjp0Hp7mEP40ca28eahTjHItCdGG0ywPhnFHzbR4b3HymzHF5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775626947; c=relaxed/simple;
	bh=kbBS9nNbKiYGr+M1etIZ/S4Zl2BY88Gcjq5XxRfRZsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePQEZK7lgVrbl1vrgPMzIlB+KLXz9qofUUuLsKsALRpNa86cbmAiVqDB98D/DseRneyafaT6sx0wcxfUmA/pfjfV0oVdQAafoSMPl04vn5snooJDboAWRpyMIQiqJo6t2xBbVS78FZOTCxzgKtP2DhRmlbBqd/I04UHvM2jQ5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i1A8d1RC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C458C19424;
	Wed,  8 Apr 2026 05:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775626947;
	bh=kbBS9nNbKiYGr+M1etIZ/S4Zl2BY88Gcjq5XxRfRZsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1A8d1RCy8ut1Oy6asCYyA/kzHLZvWjUp1zt/3s2nCl3+NB8e4lcaRF4nfIeCpFp6
	 b4p0yifTcuV0Oil1WgHv2FXdgkEgINowKXwbCiDrh6CLZ0hYOSogMb3UntnV9GzVjw
	 fwrTTKF8zmNHNZ/JjueV44/+m/HtR4xajD2KNd+o=
Date: Wed, 8 Apr 2026 07:42:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] xfrm_user: fix info leak in build_mapping()
Message-ID: <2026040820-afflicted-slander-878d@gregkh>
References: <2026040602-shack-tamale-d8c3@gregkh>
 <20260406085449.266466ae@kernel.org>
 <20260406085859.2e9843ea@kernel.org>
 <2026040634-deodorant-shakiness-a64e@gregkh>
 <20260406103851.59a200fc@kernel.org>
 <2026040745-crafter-awkward-8901@gregkh>
 <20260407181211.5419f2cc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407181211.5419f2cc@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-276286-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: D6E4E3B7538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 06:12:11PM -0700, Jakub Kicinski wrote:
> On Tue, 7 Apr 2026 07:51:15 +0200 Greg Kroah-Hartman wrote:
> > > > I guess nlmsg_append() would work?  It tries to do some zeroing out for
> > > > alignment for some reason...
> > > > 
> > > > Want me to do that?  I don't have a way to test any of this, I just
> > > > found it using some static code analysis tools that looked at holes in
> > > > structures.  
> > > 
> > > Do you have any more Netlink leaks in the queue? If you do let's do it,
> > > if you don't we can wait until the next victi^w patch to arrive.  
> > 
> > I do not have any more, sorry.  So is it worth it for just these 2?
> > Your call :)
> 
> These are fine. I would have applied but I think Steffen will take them
> via the ipsec tree first (LMK if that's not the plan, Steffen)

Thanks!

