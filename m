Return-Path: <netdev+bounces-122917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FDB9631AF
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEF62820A4
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3041ABEC5;
	Wed, 28 Aug 2024 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2lq+LK9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF21AAE19
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 20:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876557; cv=none; b=e3nlkebUieb+K/4naBYw393sopnbfQJIF/SDivTvXZT4xmriEVUc2h7tqgdonFZ3fa8FjNec4ufVr2Lp71m3fArPHo2UQr4spzwN5iOX5l7+AQ6vxeK7Zc6tqvALgde2noU2smNohdRttoKiMm/lORyYO3qMYNo8jHe0Zz/dw+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876557; c=relaxed/simple;
	bh=uR/ikCsgKvaxQ3rwsB1hFlDtpgSDe8JNz3jPLof3JL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7TVGz+a5YImJSAsLU+mGUU4HUSKCTdCmrQDT8SRpTzpQvTGIB8F+zYpPuirkjMRYNgwop6gbO4Af2WS3Ahgs/YFxY4eGnf0Fx8n22t0oFF9tMTbw+dmnSKQWhWT7Lrbi3r4WyDApnKd5GnAg3uKmcDpYeVPVZJrQ9pkoBu2LfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2lq+LK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B870C4CEC0;
	Wed, 28 Aug 2024 20:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724876556;
	bh=uR/ikCsgKvaxQ3rwsB1hFlDtpgSDe8JNz3jPLof3JL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r2lq+LK91njV33yXxQJOeT6qPkPNamZ6m6Oq9nhnz7ZHNhsYrf4gOFzFSlGj+vpZZ
	 NBor0BsNuo5SIIrUZPICXNlDACqgjR+UAskT1B+IS0Zfy4QcSTx9xfVpRVhNPHvs5R
	 aDpa2U90Xh1F52j+vjVmB92mQaqq4irC/8SiVG9ZP8zLpEg0pKO0D4wHu99sGp45E2
	 HehoTxdsgFm8egnx0Ui9CCuJx8n890pfnJ/NdxVCY5eiXtNZz0Ld9OMGupBQMG5Ird
	 GyzewV4UxetWgq6Tv0zoJUCJUlC2SpdnAWi618L4jDKzTXqlNOz8znRr3ySOSFp01F
	 2KC0fpZrgpjDQ==
Date: Wed, 28 Aug 2024 13:22:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
 <michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
Subject: Re: [PATCH net-next v2 2/9] libeth: add common queue stats
Message-ID: <20240828132235.0e701e53@kernel.org>
In-Reply-To: <ea4b0892-a087-4931-bc3a-319255d85038@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
	<20240819223442.48013-3-anthony.l.nguyen@intel.com>
	<20240820181757.02d83f15@kernel.org>
	<613fb55f-b754-433a-9f27-7c66391116d9@intel.com>
	<20240822161718.22a1840e@kernel.org>
	<b5271512-f4bd-434c-858e-9f16fe707a5a@intel.com>
	<20240826180921.560e112d@kernel.org>
	<ee5eca5f-d545-4836-8775-c5f425adf1ed@intel.com>
	<20240827112933.44d783f9@kernel.org>
	<ea4b0892-a087-4931-bc3a-319255d85038@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 17:06:17 +0200 Alexander Lobakin wrote:
> >> The stats I introduced here are supported by most, if not every, modern
> >> NIC drivers. Not supporting header split or HW GRO will save you 16
> >> bytes on the queue struct which I don't think is a game changer.  
> > 
> > You don't understand. I built some infra over the last 3 years.
> > You didn't bother reading it. Now you pop our own thing to the side,
> > extending ethtool -S which is _unusable_ in a multi-vendor, production
> > environment.  
> 
> I read everything at the time you introduced it. I remember Ethernet
> standard stats, rmon, per-queue generic stats etc. I respect it and I
> like it.
> So just let me repeat my question so that all misunderstandings are
> gone: did I get it correctly that instead of adding Ethtool stats, I
> need to add new fields to the per-queue Netlink stats? I clearly don't
> have any issues with that and I'll be happy to drop Ethtool stats from
> the lib at all.

That's half of it, the other half is excess of macro magic.

> (except XDP stats, they still go to ethtool -S for now? Or should I try
> making them generic as well?)

Either way is fine by me. You may want to float the XDP stats first as
a smaller series, just extending the spec and exposing from some driver
already implementing qstat. In case someone else does object.

> >> * reduce boilerplate code in drivers: declaring stats structures,
> >> Ethtool stats names, all these collecting, aggregating etc etc, you see
> >> in the last commit of the series how many LoCs get deleted from idpf,
> >> +/- the same amount would be removed from any other driver  
> > 
> >  21 files changed, 1634 insertions(+), 1002 deletions(-)  
> 
> Did you notice my "in the last commit"?

I may not have. But as you said, most drivers end up with some level of
boilerplate around stats. So unless the stuff is used by more than one
driver, and the savings are realized, the argument about saving LoC has
to be heavily discounted. Queue xkcd 927. I should reiterate that 
I don't think LoC saving is a strong argument in the first place.

