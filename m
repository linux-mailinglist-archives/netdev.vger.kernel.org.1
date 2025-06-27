Return-Path: <netdev+bounces-201744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA828AEAE01
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B221BC1C31
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09911D63C2;
	Fri, 27 Jun 2025 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSWy8z7d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2F1D63D8
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750998810; cv=none; b=FAl8ZTyaLX67lNKQIr9ovG3F1IJIKdJB4KnMChMJKlvlxammV7SfrQHxO94N/ci+oxi+/LFWCx8Ba1zy6xLeQEu0wI8q6gqGRJgPEZdauLrP5xF3zeL8IzUUUmrryXCr70KqrAz8EMioge1uY1G9ApBvCB3pT7mCuVVZv9jf9A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750998810; c=relaxed/simple;
	bh=qV4QwRvCbuHUu9T9aEBFCHbNjdCcP5ilr7vTdinc7XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4mhw1C/SlewPxLgJ2VG6x9R0DaJzxuxoDmXf/B37YpBPtpPtE/YhpFzYBzxSogeNURWps5NIfHQiS6UF9Fx+8oKv8HbLNa2b/BOi3OeCFQekwvn4FcG7w2dbnQJ6G40Gu1fnOHVn9I5m8uhOmIrr7ybhEfyNMTRdCsXFp6e+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSWy8z7d; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23694cec0feso19263785ad.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 21:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750998808; x=1751603608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AmNVEpaXYQEM6QehnaeD8t83onL3ecOMJ+rHr8KehJg=;
        b=gSWy8z7d+cF6EZErTJv6BHqn4gorj7LSf2+bNxEaMNi0ovjDyoihx/R6KldUAzCvaK
         V9d44XLr7XZzI38Bxjog6HjNMk98QhE/9SZ4DoWWqFIIm8KdXSkqswkDRcM6kRLaBMOD
         ivNSFhr/7Gq8laBMfRNdBwOGHPD6cN89viV8xmnxHGz7lbQj0f58vF3QwaA19SeQHXyZ
         vmObz8dNxjjwVgMusWtKlJgI3TF6qgPHdggCaezRnEUoQKwrrp5PEakG7BN2lgwHIv9E
         2c3/Fz7yYzJnTtA29Ew5RK/THmodZ97Ib0WmwoW1sPS5y7RRM7g+DBUQlaDelot8GIPj
         ycmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750998808; x=1751603608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmNVEpaXYQEM6QehnaeD8t83onL3ecOMJ+rHr8KehJg=;
        b=RpA3RS/L1FbEempORVFIIXnx2szJ5Nj5odefSkW8FYHbCBoNKeWXlE2AXxt1Rb4gRv
         heHt7htUxXIHsyzDFViv15qle7weVP1lvMjq6eLx1fvxEWREHsbo+dRgNR83F7KZmrM7
         ZJiNYVxvDJp3nT+qPGvLdrOJ3A2lzdfQqulrREZkwyjzchstzBmxCiWDtjVka8V9Ytn9
         iHRpnox5J4e98mp5uCSbb0EzB334JnhNDDzwplEGYtelr/Zajj8lRXQwsQCaiZ1Ljkzy
         IOgb0/b+ScusZmTYDsWgwdi5QFKCaD69bfEhSNqdFRyksMgOBbNZkNIh2uSsdNNJPkaQ
         WK8g==
X-Forwarded-Encrypted: i=1; AJvYcCWKqSdRQLcXAVTBcjmGFEJk31boWdM/VwE5s4ZUhNOGP8LBWglKC2OoLuysXmDGnURJpqJ+XGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyODTVxoKvoOmxDgHJlowgIo43t6Gs6uvBkX+dduiru87orHc9x
	Ppyx2g6ELyuHwxpxAa5hwCGALlDlitGp6SGK4ne7YIKnsrIDtDco2cKU
X-Gm-Gg: ASbGnctgeTiKzObF8RPeAfPUnajCKNh7EEnzeSuwP/dcX25Ii0Mjc4ORhCklmQUSZWw
	LKkY9tjHu9Qdg7E/3v5odCpq0cMLCgKpvUj4GEKSJXjqoF7qqy9HyQ09wzK+AGhS8e+NNoz8xEz
	X1SlsbdNmnLrRqGsIc8CkTO5lFk4Hamtqqpl5yGc73LYb9DhDdUiTlNcPJ7QvAjv9pftW62HuLI
	VlNCueqw5gZwq8/c3apXV1SMWstmYR8RIfV/UOeg0gG2pqI7mvRe/1os0G4M1JzLf/R20spb6BI
	8xJ1c5LxoekTYIYlXAcdrN/NLDQ9ps16jwESd4DhzBcOQGcgy0G41FLdq0gLcycHsCM=
X-Google-Smtp-Source: AGHT+IGuUk5HyXD4v4fpOdvPDzH/Stu8MtCYrnt+OxH/WV/s+WbzTfDqDlPsoTsoxGyNG9HlXCZZfw==
X-Received: by 2002:a17:903:3c65:b0:224:c46:d167 with SMTP id d9443c01a7336-23ac40f0ccemr32264825ad.16.1750998808297;
        Thu, 26 Jun 2025 21:33:28 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39be6fsm6446655ad.106.2025.06.26.21.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 21:33:26 -0700 (PDT)
Date: Fri, 27 Jun 2025 04:33:20 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Subject: Re: [Bonding Draft Proposal] Add lacp_prio Support for ad_select?
Message-ID: <aF4fEGySN8Pwpnab@fedora>
References: <aFpLXdT4_zbqvUTd@fedora>
 <2627546.1750980515@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2627546.1750980515@famine>

On Thu, Jun 26, 2025 at 04:28:35PM -0700, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >Hi Jay,
> >
> >We have a customer setup involving two separate switches with identical
> >L2/VLAN configurations. Each switch forms an independent aggregator
> >(port-channel), and the end host connects to both with the same number of
> >links and equivalent bandwidth.
> >
> >As a result, the host ends up with two aggregators under a single bond
> >interface. Since the user cannot arbitrarily override port count or
> >bandwidth, they are asking for a new mechanism, lacp_prio, to influence
> >aggregator selection via ad_select.
> >
> >Do you think this is a reasonable addition?
> 
> 	In principle, I don't see a reason not to use the system
> priority, et al, to influence the aggregator selection when bonding ends
> up with multiple aggregators.  I'm undecided as to whether it should be
> a separate ad_select policy or a "tiebreaker," but a separate policy is
> probably simpler to deal with.

There is only one system priority in the bond, which means all aggregators
share the same system priority — right?

Or do you mean we should also take the partner's system priority into account?

> 
> >If yes, what would be the best way to compare priorities?
> >
> >1. Port Priority Only. Currently initialized to 0xff. We could add a parameter
> >   allowing users to configure it.
> >   a) Use the highest port priority within each aggregator for comparison
> >   b) Sum all port priorities in each aggregator and compare the totals
> 
> 	I'm not a fan of this, as explained below.
> 
> 	Also, note that in LACP-land, when comparing priorities, the
> higher priority is numerically smaller, which makes "add them up and
> compare" a little counter intuitive to me.

Yeah..

> 
> >2. Full LACP Info Comparison. Compare fields such as system_priority, system,
> >   port_priority, port_id, etc.
> 
> 	I think it makes more sense to use the System ID (system
> priority and aggregator MAC address) from the LAG ID of the local
> aggregator.  In the bonding implementation, an aggregator is assigned a
> MAC when an interface is added, so the only aggregators lacking a MAC
> are ones that have no ports (which can't be active).

Same question, the system priority and aggregator MAC address are all same
in the same bonding interface. So how can we prioritize between two
aggregators within the same bond?

Unless we take the partner's System ID into account. Which looks like, if
we want to choose a better aggregator in bond, we need to config the switch side...

> 
> 	If we want to use the partner System ID, that's a little more
> complicated.  If aggregators in question both have LACP partners, then
> the System IDs will be unique, since the MAC addresses will differ.  If
> the aggregators don't have LACP partners, then they'll be individual
> ports, and the partner information won't be available.

Can we active a aggregator that don't have LACP partner? If not, then
we don't need to compare that aggregator.

> 
> 	Modulo the fact that bonding assigns a MAC to an aggregator
> before the standard does (for the System ID), this is approximately
> what's described in 802.1AX-2014 6.7.1, although the context there is
> criteria for prioritizing between ports during selection for aggregation
> when limited capabilities exist (i.e., 6 ports but only the ability to
> accomodate 4 in an aggregrator).
> 
> 	FWIW, the 802.1AX standard is pretty quiet on this whole
> situation.  It recognises that "A System may contain multiple
> Aggregators, serving multiple Aggregator Clients" (802.1AX-2014 6.2.1)
> but doesn't have any verbiage that I can find on requirements for
> choosing between multiple such Aggregators if only one can be active.  I
> think the presumption in the standard is that the multiple aggregators
> would or could be active simultaneously as independent entities.
> 
> 	Anyway, the upshot is that we can pretty much choose as we see
> fit for this particular case.

Yes

Thanks
Hangbin

