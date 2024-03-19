Return-Path: <netdev+bounces-80665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077CD8803C1
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 18:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FEE1C21C38
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ECB2943C;
	Tue, 19 Mar 2024 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifEjnRyh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961EE28DDF
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870048; cv=none; b=q5rNSYPhq3sztCYfFct0HrucOS6nb3Vt4osW5mtVz0XH9qogFwV8XVlefN5qu8SBhZ9Pk6Bb6c1iR5K+NAlNUfLVfEJKPNIj/A6mgGc8F2oRCWSObmoR5R3C7S9lHwTrTHPosTNvoDedI0CcVy2nvEXYJQ7FoVFSALSweBjinoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870048; c=relaxed/simple;
	bh=1KIGc50CRo2UOE6kHOlDJqfxBJCFu+2DWv7i+/tkRg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNzLKkCxmU90Bq2UgskHbGEGLIzgA0HAYg4FNhNHYJWQvqfzYrUdZbkzh7oSQuLN8vf4cHyou/4oZUpb2KA7wnnLyf9zsxZlUi05HTlAcIlfeBlYU/5M+BlKFS7ZzTrhv1aKP35ClcZViSZYIHqhgZLcc4cIbdaLtwhBkeaMRis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifEjnRyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F68C433C7;
	Tue, 19 Mar 2024 17:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710870048;
	bh=1KIGc50CRo2UOE6kHOlDJqfxBJCFu+2DWv7i+/tkRg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ifEjnRyhhuDUlLgWpMBCWkFeP1ZnWNBabzyOxVaQMij4HXbwvOuSYKbCmkzRRSnsH
	 BJbZyJSUZaXLpdeAqWkoCNMF+Kh4MFf8wf+E/oqNSner7clPv5BmOwDDMk3xKt6aky
	 73QudJwN/1Zw908IzpnCX0v5QX0BSZUmxo+43jcsfejQw5ff0KriZSDYqGTSN8jlQz
	 cjmKcnHOttWWeaPQ5G4t8Z7qXz6SAEJ/zWE59Xjrx2YokdOJyhb3h21dwD7NUZv4w2
	 /TldMAtEiji52n6TlWwllB64YR0oOCQnwqWEBX7RWHZaeOdntBsczAHKnvlkq3txj6
	 5k19CE8rzSCiA==
Date: Tue, 19 Mar 2024 10:40:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Stefano Brivio <sbrivio@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 idosch@idosch.org, johannes@sipsolutions.net, fw@strlen.de,
 pablo@netfilter.org, Martin Pitt <mpitt@redhat.com>, Paul Holzinger
 <pholzing@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
Message-ID: <20240319104046.203df045@kernel.org>
In-Reply-To: <CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
References: <20240303052408.310064-1-kuba@kernel.org>
	<20240303052408.310064-4-kuba@kernel.org>
	<20240315124808.033ff58d@elisabeth>
	<20240319085545.76445a1e@kernel.org>
	<CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 18:17:47 +0100 Eric Dumazet wrote:
> > Hi Stefano! I was worried this may happen :( I think we should revert
> > offending commits, but I'd like to take it on case by case basis.
> > I'd imagine majority of netlink is only exercised by iproute2 and
> > libmnl-based tools. Does passt hang specifically on genetlink family
> > dump? Your commit also mentions RTM_GETROUTE. This is not the only
> > commit which removed DONE:
> >
> > $ git log --since='1 month ago' --grep=NLMSG_DONE --no-merges  --oneline
> >
> > 9cc4cc329d30 ipv6: use xa_array iterator to implement inet6_dump_addr()
> > 87d381973e49 genetlink: fit NLMSG_DONE into same read() as families
> > 4ce5dc9316de inet: switch inet_dump_fib() to RCU protection
> > 6647b338fc5c netlink: fix netlink_diag_dump() return value  
> 
> Lets not bring back more RTNL locking please for the handlers that
> still require it.

Definitely. My git log copy/paste is pretty inaccurate, these two are
better examples:

5d9b7cb383bb nexthop: Simplify dump error handling
02e24903e5a4 netlink: let core handle error cases in dump operations

I was trying to point out that we merged a handful of DONE "coalescing"
patches, and if we need to revert - let's only do that for the exact
commands needed. The comment was raised on my genetlink patch while
the discussion in the link points to RTM_GETROUTE.

> The core can generate an NLMSG_DONE by itself, if we decide this needs
> to be done.

Exactly.

