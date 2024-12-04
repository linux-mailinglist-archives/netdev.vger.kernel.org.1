Return-Path: <netdev+bounces-149124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677BA9E4520
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 20:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AF2167F8E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 19:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720E61E2306;
	Wed,  4 Dec 2024 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QMMJPqDy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21592391AA
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733342112; cv=none; b=gDcZrlPcTXSvOkD4fRXXDX7Pmd/KH3FkDrdYu/KPTAjSXqWUI7uGaDFqoO9TuhqEkxqxzd8GLhn/FozjgJVzPUAnU2OWC8WgZw7ULlG7yyElRGzyCvuMMiR5h7DoVL1VcKdy3I18Pvcp7LFGnylQ8l+DgsHs0B1l8tu6D40vgyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733342112; c=relaxed/simple;
	bh=vHAuC/R6TNyBolNqE628QMEx33T1ss5vZFp90xfN50U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITwf0nLY4HHdoP8/CX3w4teT3EBHMthIHa4Rd/0SobX/MpsfgEc508LaHKA72Imba0KCrtcDENU8p7uEqLc4vNyKrvs+RmF9EZdyA5E56Dj36fiV1Ru8ZhqEHS/+mnvKewYgRaZdHMYGbtyjzf2Ri3V6RJlG3cGhvJLpMcsmda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QMMJPqDy; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y3SRm4ZgbzM9k;
	Wed,  4 Dec 2024 20:35:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1733340948;
	bh=Ppph290bQK9LzZr8lqrr80UMjEXIdb3L4z4q0DP5jD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QMMJPqDypdegal0TfnoNs8csaLih6bSKfunCWNtctpuo8a9e3QUU038XqFMwWTytq
	 rjjObzDC1+LdQAWwsBCWxfPTWTK91DrxYgEQI7OeRtWeooVVgNtWmM5WFgDmX0DUYc
	 zwANt2rhZSbeJDbyu7oMwYpCDgaXON56Fg4S44Ns=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y3SRm1CbTzrlN;
	Wed,  4 Dec 2024 20:35:48 +0100 (CET)
Date: Wed, 4 Dec 2024 20:35:47 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	gnoack@google.com, willemdebruijn.kernel@gmail.com, matthieu@buffet.re, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com, 
	MPTCP Linux <mptcp@lists.linux.dev>, David Laight <David.Laight@aculab.com>
Subject: Re: [RFC PATCH v2 1/8] landlock: Fix non-TCP sockets restriction
Message-ID: <20241204.acho8AiGh6ai@digikod.net>
References: <20241017110454.265818-1-ivanov.mikhail1@huawei-partners.com>
 <20241017110454.265818-2-ivanov.mikhail1@huawei-partners.com>
 <49bc2227-d8e1-4233-8bc4-4c2f0a191b7c@kernel.org>
 <20241018.Kahdeik0aaCh@digikod.net>
 <20241204.fahVio7eicim@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204.fahVio7eicim@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Dec 04, 2024 at 08:27:58PM +0100, Mickaël Salaün wrote:
> On Fri, Oct 18, 2024 at 08:08:12PM +0200, Mickaël Salaün wrote:
> > On Thu, Oct 17, 2024 at 02:59:48PM +0200, Matthieu Baerts wrote:
> > > Hi Mikhail and Landlock maintainers,
> > > 
> > > +cc MPTCP list.
> > 
> > Thanks, we should include this list in the next series.
> > 
> > > 
> > > On 17/10/2024 13:04, Mikhail Ivanov wrote:
> > > > Do not check TCP access right if socket protocol is not IPPROTO_TCP.
> > > > LANDLOCK_ACCESS_NET_BIND_TCP and LANDLOCK_ACCESS_NET_CONNECT_TCP
> > > > should not restrict bind(2) and connect(2) for non-TCP protocols
> > > > (SCTP, MPTCP, SMC).
> > > 
> > > Thank you for the patch!
> > > 
> > > I'm part of the MPTCP team, and I'm wondering if MPTCP should not be
> > > treated like TCP here. MPTCP is an extension to TCP: on the wire, we can
> > > see TCP packets with extra TCP options. On Linux, there is indeed a
> > > dedicated MPTCP socket (IPPROTO_MPTCP), but that's just internal,
> > > because we needed such dedicated socket to talk to the userspace.
> > > 
> > > I don't know Landlock well, but I think it is important to know that an
> > > MPTCP socket can be used to discuss with "plain" TCP packets: the kernel
> > > will do a fallback to "plain" TCP if MPTCP is not supported by the other
> > > peer or by a middlebox. It means that with this patch, if TCP is blocked
> > > by Landlock, someone can simply force an application to create an MPTCP
> > > socket -- e.g. via LD_PRELOAD -- and bypass the restrictions. It will
> > > certainly work, even when connecting to a peer not supporting MPTCP.
> > > 
> > > Please note that I'm not against this modification -- especially here
> > > when we remove restrictions around MPTCP sockets :) -- I'm just saying
> > > it might be less confusing for users if MPTCP is considered as being
> > > part of TCP. A bit similar to what someone would do with a firewall: if
> > > TCP is blocked, MPTCP is blocked as well.
> > 
> > Good point!  I don't know well MPTCP but I think you're right.  Given
> > it's close relationship with TCP and the fallback mechanism, it would
> > make sense for users to not make a difference and it would avoid bypass
> > of misleading restrictions.  Moreover the Landlock rules are simple and
> > only control TCP ports, not peer addresses, which seems to be the main
> > evolution of MPTCP.
> 
> Thinking more about this, this makes sense from the point of view of the
> network stack, but looking at external (potentially bogus) firewalls or
> malware detection systems, it is something different.  If we don't
> provide a way for users to differenciate the control of SCTP from TCP,
> malicious use of SCTP could still bypass this kind of bogus security
> appliances.  It would then be safer to stick to the protocol semantic by
> clearly differenciating TCP from MPTCP (or any other protocol).
> 
> Mikhail, could you please send a new patch series containing one patch
> to fix the kernel and another to extend tests?

No need to squash them in one, please keep the current split of the test
patches.  However, it would be good to be able to easily backport them,
or at least the most relevant for this fix, which means to avoid
extended refactoring.

