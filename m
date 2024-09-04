Return-Path: <netdev+bounces-125154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3526A96C17B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677C11C21612
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D751DCB01;
	Wed,  4 Sep 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gb2yYMba"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F82F1DC1AA
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461853; cv=none; b=plImD+43mEIs+XnRCezoMOJz28Dc/dteNPC07JHH3zTrepvrLXDPxiWjGwmINIUpyibX9t5RCDAUwS5Jv45+sCjMsaw58XExsb78ok4BcPb/zDQ/ICg6T4GWS2MufyZmxP5wf2p++H+b5rmVdzMw3u0a+ReI/bNNFzbskZu2uDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461853; c=relaxed/simple;
	bh=TmJeBV2A4RUwPbT/GT6ByP/f/Jm/ZWEHOrqd7evJ51o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlAFLQNLprUP4x+GtyIQXRgefQCyiG2QhsvwgORckRCaNdDttASDeH1byjKbRJOcctpz6voefCr4TwA43ck6dtq06O7qbFPVN5LhSPWikwAdf8VvVUKbbjSYxhpf5UZtEo5Mzv2922DW/ZiOl/R0R8xnp66toANhRyclGTtaxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gb2yYMba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA12DC4CEC2;
	Wed,  4 Sep 2024 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725461853;
	bh=TmJeBV2A4RUwPbT/GT6ByP/f/Jm/ZWEHOrqd7evJ51o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gb2yYMbaLOO4DSPLO3s2ed68AGBqf1+5rH+eIaibtsmuHaGOE4PfGVkRiwCK2lPPn
	 On9zhzOxssm+J7onTEkAWopuwySZC5l/fVOeYnA2zy3TDokccY3TN39hEmyfa9Neq9
	 PHJCBqiw3vHrk0aDP0nkg1Qm+Iz9fdzZbcP7bAk/kjddCEnY4Z/JxS2Qw9su/yEr+Y
	 200akMMeOUWthI55hZshJVQmIzNh1Wq4WbuA4qmUrNii3JHJQ04oH8TfjVEBV3uqjl
	 mtDHX7u++L1ARp4XZmI7ceK2/v8/UG3jvgn5UTvEo5Mjc4gpmNyCRvMeeA2FlzzYlf
	 vkO33D8097jTg==
Date: Wed, 4 Sep 2024 07:57:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Martin Varghese
 <martin.varghese@nokia.com>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] bareudp: Fix device stats updates.
Message-ID: <20240904075732.697226a0@kernel.org>
In-Reply-To: <ZthSuJWkCn+7na9k@debian>
References: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
	<20240903113402.41d19129@kernel.org>
	<ZthSuJWkCn+7na9k@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 14:29:44 +0200 Guillaume Nault wrote:
> > The driver already uses struct pcpu_sw_netstats, would it make sense to
> > bump it up to struct pcpu_dstats and have per CPU rx drops as well?  
> 
> Long term, I was considering moving bareudp to use dev->tstats for
> packets/bytes and dev->core_stats for drops. It looks like dev->dstats
> is only used for VRF, so I didn't consider it.

Right, d stands for dummy so I guess they also were used by dummy 
at some stage? Mostly I think it's a matter of the other stats being
less recent.

> Should we favour dev->dstats for tunnels instead of combining ->tstats
> and ->core_stats? (vxlan uses the later for example).

Seems reasonable to me. Not important enough to convert existing
drivers, maybe, unless someone sees contention. But in new code,
or if we're touching the relevant lines I reckon we should consider it?
No strong feelings tho, LMK if you want to send v2 or keep this patch
as is.

