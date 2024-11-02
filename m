Return-Path: <netdev+bounces-141227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A39E9BA160
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 17:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AEF61C20895
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B2119E99B;
	Sat,  2 Nov 2024 16:12:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4014B97E
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730563951; cv=none; b=hgE1hmBCC8jaB+vYORYdG2HPbVIm7dm6SyU8JwP44ThS1dyb9NI8Zduz4eFkpa4xaW2TMFuIeJgx3clCKghPHvEve+PN2xH509NNtxjOYmAIELDITZFySjeLGvv5AD8bdOmkxIh50RbmtNbTMtnBzOhWRJ4mp3QS36ru+iN9/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730563951; c=relaxed/simple;
	bh=3j7OOsolpvo+9eLT8gzUgoikCeP/PSsTFEgFfSqLBaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWFmi2sfF7KSvdpfFv0C0H4gxinFrMnDW5axDuqRcla9A87EpMl9ly/xB5AOpJkQDToOZhsup7QCQsuU3lKxf9h7LtHpGM29pq5JCqsY8MCv+nwPjw//LI1LFDG3PWUYD1ptJ/FzxXVRLJMGETUc5OF0IcdNsU/IO8YgAiRdNOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1t7GjZ-0003QG-Ra; Sat, 02 Nov 2024 17:12:17 +0100
Date: Sat, 2 Nov 2024 17:12:17 +0100
From: Florian Westphal <fw@strlen.de>
To: namniart@gmail.com
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Subject: Re: Duplicate invocation of NF_INET_POST_ROUTING rule for outbound
 multicast?
Message-ID: <20241102161217.GA13003@breakpoint.cc>
References: <20241031215243.GA4460@breakpoint.cc>
 <0A676E07-BD16-492A-8C10-4FC541525F73@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0A676E07-BD16-492A-8C10-4FC541525F73@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

namniart@gmail.com <namniart@gmail.com> wrote:
> Thanks for the quick reply; I will work through our build process and try=
 to get that tested in the next few days.
>=20
> I was thinking the fix for this might be more substantial; call NF_HOOK w=
ithout a callback at the top of ip_mc_output to determine the fate of the p=
acket,

The NF_QUEUE verdict can delegate this decision to a userspace process,
if this happened its too late to do the clone.

So this would work only if we had a way to remove support for NF_QUEUE
for multicast packets.  I don't think this can be done after two
decades.

