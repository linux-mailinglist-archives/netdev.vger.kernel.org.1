Return-Path: <netdev+bounces-127167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D5D974724
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE302877EA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921CE10F1;
	Wed, 11 Sep 2024 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFXBisme"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62328161;
	Wed, 11 Sep 2024 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726013451; cv=none; b=bMYZN7uGseTnMfd44X6dvXI3zBTNUTGyFkYgGe1kMlP5ySJ4ibSxAUqNHjNCDYCnLqHeBAFTzNdVVhXWSC3xiHhX0dqvmjDGGDZ0Tne65+evL/pivxKm0m8ZlhU0FAPzfqeJ9qigwcQSioPlUEMF5yhoEm2FJjg/ChIOXxhiPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726013451; c=relaxed/simple;
	bh=dHIdRcR5mTgJHf2WyepD+aXCWnQw4zMiEb95qQFo4WM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJY5BCCZeW2Wp3UGcT5GBmzYHvUsLpWxhNyJAg9BBR4q/vgORGFfNVdvelQ1cq1Q05Jmlfur97rYPxFfV9q/esRfRYq/L0KO6lW+4S52WmnUwiCDYS4ftJ7txGS37OhAkqYv8WtxwdhfogSlmPcHVi+I1b6tcCEHSzQCG6kkYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFXBisme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB50C4CEC3;
	Wed, 11 Sep 2024 00:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726013450;
	bh=dHIdRcR5mTgJHf2WyepD+aXCWnQw4zMiEb95qQFo4WM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eFXBismetIxuW8kAtXFmYRkZcZF3t+EsfiMQLTAyT/Qw+Vei8rQMQuGeobJfa3sU8
	 3cPQWiXup1KV7XisZItr+2jTThuIKUHO6ULP2ozODLV+puuS6sHOOtHtBu3w6vJjR7
	 p5DhIKgLX1a2pg7TmFfKKJmDkw0fRY2GRSr4dgu/P7eIpgUfwgwN/oFokiK9vgePub
	 OK2UYkcEgsF/tKowrZEfA5z7i8w6CzcIGb6mVWfGjwr9MxdewwN+UzWl2hQ4tY8Uut
	 5l/crkMoV7srMvPmYqiO/gruQBCEvsrsIVytpnakjvO2sbpIV2nEDF4K8A7mR0VaQy
	 AUQ3vmKuClQPA==
Date: Tue, 10 Sep 2024 17:10:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
 sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 1/9] net: napi: Add napi_storage
Message-ID: <20240910171048.768a62b0@kernel.org>
In-Reply-To: <ZuBvgpW_iRDjICTH@LQ3V64L9R2.homenet.telecomitalia.it>
References: <20240908160702.56618-1-jdamato@fastly.com>
	<20240908160702.56618-2-jdamato@fastly.com>
	<20240909164039.501dd626@kernel.org>
	<Zt_jn5RQAndpKjoE@LQ3V64L9R2.homenet.telecomitalia.it>
	<20240910075217.45f66523@kernel.org>
	<ZuBvgpW_iRDjICTH@LQ3V64L9R2.homenet.telecomitalia.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 18:10:42 +0200 Joe Damato wrote:
> On Tue, Sep 10, 2024 at 07:52:17AM -0700, Jakub Kicinski wrote:
> > Hm, fair point. In my mind I expected we still add the fast path fields
> > to NAPI instances. And the storage would only be there to stash that
> > information for the period of time when real NAPI instances are not
> > present (napi_disable() -> napi_enable() cycles).  
> 
> I see, I hadn't understood that part. It sounds like you were
> thinking we'd stash the values in between whereas I thought we were
> reading from the struct directly (hence the implementation of the
> static inline wrappers).
> 
> I don't really have a preference one way or the other.

Me neither. I suspect having the fields in napi_struct to be slightly
more optimal. No need for indirect accesses via napi->storage->$field,
and conditions to check if napi->storage is set. We can make sure we
populate the fields in NAPIs when they are created and when sysfs writes
happen. So slightly better fastpath locality at the expense of more
code on the control path keeping it in sync.

FWIW the more we discuss this the less I like the word "storage" :)
If you could sed -i 's/storage/config/' on the patches that'd great :)

> > > I don't think I realized we settled on the NAPI ID being persistent.
> > > I'm not opposed to that, I just think I missed that part in the
> > > previous conversation.
> > > 
> > > I'll give it a shot and see what the next RFC looks like.  
> > 
> > The main reason to try to make NAPI ID persistent from the start is that
> > if it works we don't have to add index to the uAPI. I don't feel
> > strongly about it, if you or anyone else has arguments against / why
> > it won't work.  
> 
> Yea, I think not exposing the index in the uAPI is probably a good
> idea? Making the NAPI IDs persistent let's us avoid that so I can
> give that a shot because it's easier from the user app perspective,
> IMO.

Right, basically we can always add it later. Removing it later won't
be possible :S

> > > Only one way to find out ;)
> > > 
> > > Separately: your comment about documenting rings to NAPIs... I am
> > > not following that bit.
> > > 
> > > Is that a thing you meant should be documented for driver writers to
> > > follow to reduce churn ?  
> > 
> > Which comment?  
> 
> In this message:
> 
> https://lore.kernel.org/netdev/20240903124008.4793c087@kernel.org/
> 
> You mentioned this, which I interpreted as a thing that core needs
> to solve for, but perhaps this intended as advice for drivers?
> 
>   Maybe it's enough to document how rings are distributed to NAPIs?
>   
>   First set of NAPIs should get allocated to the combined channels,
>   then for remaining rx- and tx-only NAPIs they should be interleaved
>   starting with rx?
>   
>   Example, asymmetric config: combined + some extra tx:
>   
>       combined        tx
>    [0..#combined-1] [#combined..#combined+#tx-1]
>   
>   Split rx / tx - interleave:
>   
>    [0 rx0] [1 tx0] [2 rx1] [3 tx1] [4 rx2] [5 tx2] ...
>   
>   This would limit the churn when changing channel counts.

Oh, yes. I'm not sure _where_ to document it. But if the driver supports
asymmetric ring count or dedicated Rx and Tx NAPIs - this is the
recommended way to distributing the rings to NAPIs, to, as you say,
limit the config churn / mismatch after ring count changes.

