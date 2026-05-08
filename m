Return-Path: <netdev+bounces-286029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Jk8AMs5m/mlaqQAAu9opvQ
	(envelope-from <netdev+bounces-286029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:42:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE824FC6FD
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EA8E301CC79
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1855039E185;
	Fri,  8 May 2026 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="toRQxW+D"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B3388395;
	Fri,  8 May 2026 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280138; cv=none; b=uc7j2WABU99oFKuhDKPiapBKmVk1kMlZ9zF4+mJQCkFgv7W8ZdhLGifdJmfWM9ndC+Z0gI/8Vuy9sRp4HrI/r5LGECziJZGXYwVTIB16OIuaMJhnET9BHheLvsAq8CHCSQjcHBG4XUXyHA3tmf2Zqk+dBmJPm6GBBe10pBRO+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280138; c=relaxed/simple;
	bh=2PasbWe3chOshQzznWYFbE0V5iCeQDKrhJd7gEOiLHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L51rOYBWkEFkLuM3wlm0thR4fAKAIcbeN0gGEzXMui552DrWN6yRaoCm8ov+I0hjfsdpSp12oUE0O3F/mt6KBxEVSagBV/+J9WxiDDVvjINwYrK/Q7Ju2FAJKzre75J/uDdxGRlkS//Oy4VwB4RYiK41gOvAJ+SOnVhv6/6iPQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=toRQxW+D; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2d+btvIUAz8NnrJlvXGD2gsxPIw5HclLnbw66tpZ7ok=; b=toRQxW+DQCL7hteB8tzITi2u6I
	4fAc1d8h3ZtXYln64m9SR4hXNN+hS6uzM9yGB4MfubhJ0sExiDLuDb+ZuBu6TevjXPvf4rn7hO5/e
	NOa7Lb2yYeJlAhMvl6t5nICMuhlSvAedIGDysJLGav7ffqotoKcqcweivC5YA6vjOfbg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wLTtG-002294-UC; Sat, 09 May 2026 00:41:50 +0200
Date: Sat, 9 May 2026 00:41:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Adrien Reynard <reynard.adrien.08@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"open list:KASAN" <kasan-dev@googlegroups.com>,
	"open list:DOCUMENTATION PROCESS" <workflows@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>
Subject: Re: [PATCH 4/5] docs: fix repeated prepositions across documentation
Message-ID: <3c6cde1a-9ce0-4d63-ba89-820c596cff3e@lunn.ch>
References: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
 <2b771350-0562-4cb1-b9b3-cc3ce59b1a63@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b771350-0562-4cb1-b9b3-cc3ce59b1a63@linuxfoundation.org>
X-Rspamd-Queue-Id: DDE824FC6FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-286029-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,arm.com,lwn.net,davemloft.net,kernel.org,redhat.com,nod.at,cambridgegreys.com,sipsolutions.net,googlegroups.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 11:23:43AM -0600, Shuah Khan wrote:
> On 5/8/26 10:38, Adrien Reynard wrote:
> 
> Missing commit log
> 
> > Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> > ---
> >   Documentation/dev-tools/kasan.rst                   | 2 +-
> >   Documentation/networking/switchdev.rst              | 2 +-
> >   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
> >   3 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> > index 4968b2aa60c8..3a8bd40ad905 100644
> > --- a/Documentation/dev-tools/kasan.rst
> > +++ b/Documentation/dev-tools/kasan.rst
> > @@ -392,7 +392,7 @@ reserved to tag freed memory regions.
> >   If the hardware does not support MTE (pre ARMv8.5), Hardware Tag-Based KASAN
> >   will not be enabled. In this case, all KASAN boot parameters are ignored.
> > -Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
> > +Note that enabling CONFIG_KASAN_HW_TAGS always results in-kernel TBI being
> 
> This is correct the way it is - no need to change this. "results in in-kernel"
> 
> >   enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
> >   support MTE (but supports TBI).
> > diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
> > index 2966b7122f05..948bce44ca9b 100644
> > --- a/Documentation/networking/switchdev.rst
> > +++ b/Documentation/networking/switchdev.rst
> > @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
> >   monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
> >   bond will see its upper master change.  If that bond is moved into a bridge,
> >   the bond's upper master will change.  And so on.  The driver will track such
> > -movements to know what position a port is in in the overall topology by
> > +movements to know what position a port is in the overall topology by
> 
> This looks fine.

Fine as in the change is correct, or fine in that the original is
correct and the change is wrong?

Because the change is wrong, there should be two in's here. Please
search the archive for an explanation why.

This is the second time in a week i've had to deal with "improvements"
like this actually breaking stuff. Which also shows that the submitter
did not search to see if somebody has tried to fix this once already,
and failed.

Can we get the tool changed to add a warning, something like:

  WARNING: This tool uses very simple pattern matching to look for
  repeated words. It does not understand the complexity of English,
  and will often result in false positive reports. Please assume it is
  wrong until proven otherwise.

       Andrew

