Return-Path: <netdev+bounces-136531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 809309A205A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F611F2200F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3A01DA10B;
	Thu, 17 Oct 2024 10:52:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450E1CCB44
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162376; cv=none; b=HZbSOaW840Vpy0oSBSEHGfG7nTtj7nnscqnFHwKq0oYPi+hXl4MkIETI4vgmFtGs+BVbh8S7x+5OOGJ6/K47c5WI3HFp2SqCiIs9Nigh/e9j0XvMYuAGFEgrz5BhfECaWJVs+/HiBwDCejQEL++fBuHfAcYABETd+WfcxtlzM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162376; c=relaxed/simple;
	bh=17MQUER8QgGTyR06qrhxdiu3GAKRSs1Qf6LTI48a4Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5Yg6u8xZaVg/xpm3dyn2bQ2VcO2CoVFbeOfRrN/vySpyirZtIBInC3jDjfSqSbubq8K9pyoQY3awGvF32l9ueYJw+uY9f3bTG4VWIT8ddDBMv03PbGiNAiqaIv7V4pa49PtiO4CFI9enUyawBPj20Yza1//ddNzggRMCfnHodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1t1O7f-0003Cv-Qp; Thu, 17 Oct 2024 12:52:51 +0200
Date: Thu, 17 Oct 2024 12:52:51 +0200
From: Florian Westphal <fw@strlen.de>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	Nathan Harold <nharold@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Yan Yan <evitayan@google.com>
Subject: Re: [PATCH ipsec] xfrm: migrate: work around 0 if_id on migrate
Message-ID: <20241017105251.GA12005@breakpoint.cc>
References: <20241017094315.6948-1-fw@strlen.de>
 <CANP3RGeeR9vso0MyjRhFuTmx5K7ttt0bisHucce0ONeJotXOZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANP3RGeeR9vso0MyjRhFuTmx5K7ttt0bisHucce0ONeJotXOZw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Maciej Żenczykowski <maze@google.com> wrote:
> > +found:
> >         /* Stage 2 - find and update state(s) */
> >         for (i = 0, mp = m; i < num_migrate; i++, mp++) {
> >                 if ((x = xfrm_migrate_state_find(mp, net, if_id))) {
> > --
> > 2.45.2
> >
> 
> Q: Considering the performance impact... would it make sense to hide
> this behind a sysctl or a kconfig?

Kconfig?  I don't think so, all distros except Android would turn it on.

> Yan Yan: Also, while I know we found this issue in Android... do we
> actually need the fix?  Wasn't the adjustment to netd sufficient?
> Android <16 doesn't support >6.6 anyway, and Android 16 should already
> have the netd fix...

... seems you already fixed this, so I suspect this slowpath won't ever
run in your case.

Following relevant cases exist:
1. Userspace asks to migrate existing policy, provides if_id > 0.
   -> slowpath is elided.

2. Userspace asks to migrate existing policy, the policy is NOT for
   xfrm_interface, -> slowpath is also elided because first attempt
   finds the if_id 0 policy.

3. Like 1, but userspace does not set the if_id.
   -> slowpath runs, BUT without it migration would not work.

4. Like 2, but the policy doesn't exist.
   -> slowpath runs and slows things down for no reason.

For 1 and 2 even sysctl knob is irrelevant.

For 3, sysctl knob is *technically* irrelevant, either migrate is
broken (sysctl off) or its on and policy migrate will work.
This also hints we'd have to turn such sysctl on by default...

For 4, sysctl could be used to disable/avoid such slowdown.
But I'm not sure this is a relevant scenario in practice, aside
from fuzzers, AND it breaks 3) again if its off.

So I don't see a need to provide a config knob or a sysctl
that would have to be on by default...

If you think a Kconfig knob makes sense for Android sake I can respin
with such a knob, but I think I'd have to make it default-y.

