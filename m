Return-Path: <netdev+bounces-122467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 206A19616FF
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A420D1F23B8F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80551D1757;
	Tue, 27 Aug 2024 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DArm1UWW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30211C57A5
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783376; cv=none; b=U27UuY0HaQleW2WjoycOzF64af5tcYnKsfom71huSJMnyhFNjrYbB5GgZ6H3E4h+nqvH8xs5DdsRXQG+iFCoGzHtl2d+xPTmLhHvqp3kUXelKBboxF5uV5zhs7TAXYMW0YtTCjb96gS4h1ymCttTuIoLvr6NQ9XJFqJbO5+mBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783376; c=relaxed/simple;
	bh=P3sDOaLA+BKPfV84MsxIdVubJOANjkEAf016dHH09vk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ufo+C4kxzZ3ZhUuZxDZ1Vbzxd8yK21kUzyvdGy746dQZHasn0RiSHdZS+VZo0A5d6fR2Nidb2M0EdOBeJBjk63bRHKphDppq7qReDDTiqZscUe6xxwDWCVQtl9sPQlvOB6/E+Q8hGJO5QIFxFvxufgGY99jcyu9ZiGhIpL8jiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DArm1UWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5749C32786;
	Tue, 27 Aug 2024 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724783375;
	bh=P3sDOaLA+BKPfV84MsxIdVubJOANjkEAf016dHH09vk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DArm1UWWmDOKkYaZKzC11n9tLzjv/9TdPaNvxDvtioUSLyn8VSEwy6mSHxfzg599B
	 1GwEo0RUe4ihrCMN/VcC96+nmrlgk5DR++Amb9AoZ7ReglYju60RtL4FAsRiQjKhOh
	 aMG+syqoLALFImK253wsWcVbdbjdAGAT7J+YpA1elJW/LEGPrnDQXW013+ElraZl82
	 FaVCysCzUEpkt4yO65dSSmNOHe2OkwVnJEkFI9jeFZ35WxoIvtgHDN8RO1GglwM99L
	 W5eOAlh7w8sPJorY9nuT0LsypwlSTnxF1vCn28jrmTjaZVIvUtOY60hD9mAp+HlIkj
	 F336R0OESyP6w==
Date: Tue, 27 Aug 2024 11:29:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
 <michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
Subject: Re: [PATCH net-next v2 2/9] libeth: add common queue stats
Message-ID: <20240827112933.44d783f9@kernel.org>
In-Reply-To: <ee5eca5f-d545-4836-8775-c5f425adf1ed@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
	<20240819223442.48013-3-anthony.l.nguyen@intel.com>
	<20240820181757.02d83f15@kernel.org>
	<613fb55f-b754-433a-9f27-7c66391116d9@intel.com>
	<20240822161718.22a1840e@kernel.org>
	<b5271512-f4bd-434c-858e-9f16fe707a5a@intel.com>
	<20240826180921.560e112d@kernel.org>
	<ee5eca5f-d545-4836-8775-c5f425adf1ed@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 17:31:55 +0200 Alexander Lobakin wrote:
> >> But it's up to the vendors right, I can't force them to use this code or
> >> just switch their driver to use it :D  
> > 
> > It shouldn't be up to interpretation whether the library makes code
> > better. If it doesn't -- what's the point of the library. If it does
> > -- the other vendors better have a solid reason to push back.  
> 
> Potential reasons to push back (by "we" I mean some vendor X):
> 
> * we want our names for Ethtool stats, not yours ("txq_X" instead of
>   "sqX" and so on), we have scripts which already parse our names blah

If the stat is standardized in a library why is it dumped via ethtool -S

> * we have our own infra and we just don't want / have time/resources to
>   refactor and then test since it's not something critical

Quite hypothetical.

> >> In some cases, not this one, iterating over an array means way less
> >> object code than open-coded per-field assignment. Just try do that for
> >> 50 fields and you'll see.  
> > 
> > Do you have numbers? How much binary code is 50 simple moves on x86?  
> 
> 	for (u32 i = 0; i < 50; i++)
> 		structX->field[i] = something * i;
> 
> open-coding this loop to assign 50 fields manually gives me +483 bytes
> of object code on -O2.

10 bytes per stat then. The stat itself is 8 times number of queues.

> But these two lines scale better than adding a new assignment for each
> new field (and then forget to do that for some field and debug why the
> stats are incorrect).

Scale? This is control path code, first prio is for it to be correct,
second to be readable.

> >> But I have...  
> > 
> > Read, or saw it?  
> 
> Something in between these two, but I'll reread since you're insisting.

Please do. Docs for *any* the stats I've added in the last 3 years 
will do.

> >> But why should it propagate?   
> > 
> > I'm saying it shouldn't. The next NIC driver Intel (inevitably :))  
> 
> FYI I already nack inside Intel any new drivers since I was promised
> that each next generation will be based on top of idpf.

I don't mind new drivers, how they get written is a bigger problem,
but that's a different discussion.

> >> I'll be happy to remove that for basic Rx/Tx queues (and leave only
> >> those which don't exist yet in the NL stats) and when you introduce
> >> more fields to NL stats, removing more from ethtool -S in this
> >> library will be easy.  
> > 
> > I don't scale to remembering 1 easy thing for each driver we have.  
> 
> Introducing a new field is adding 1 line with its name to the macro
> since everything else gets expanded from these macros anyway.

Are you saying that people on your team struggle to add a statistic?
#1 correctness, #2 readability. LoC only matters indirectly under #2.

> >> But let's say what should we do with XDP Tx
> >> queues? They're invisible to rtnl as they are past real_num_tx_queues.  
> > 
> > They go to ethtool -S today. It should be relatively easy to start
> > reporting them. I didn't add them because I don't have a clear use 
> > case at the moment.  
> 
> The same as for regular Tx: debugging, imbalance etc.

I'm not trying to imply they are useless. I just that I, subjectively,
don't have a clear use case in Meta's production env.

> > save space on all the stats I'm not implementing.  
> 
> The stats I introduced here are supported by most, if not every, modern
> NIC drivers. Not supporting header split or HW GRO will save you 16
> bytes on the queue struct which I don't think is a game changer.

You don't understand. I built some infra over the last 3 years.
You didn't bother reading it. Now you pop our own thing to the side,
extending ethtool -S which is _unusable_ in a multi-vendor, production
environment.

> >> * implementing NL stats in drivers, not here; not exporting NL stats
> >> to ethtool -S
> >>
> >> A driver wants to export a field which is missing in the lib? It's a
> >> couple lines to add it. Another driver doesn't support this field and
> >> you want it to still be 0xff there? Already noted and I'm already
> >> implementing a different model.  
> > 
> > I think it will be very useful if you could step back and put on paper
> > what your goals are with this work, exactly.  
> 
> My goals:
> 
> * reduce boilerplate code in drivers: declaring stats structures,
> Ethtool stats names, all these collecting, aggregating etc etc, you see
> in the last commit of the series how many LoCs get deleted from idpf,
> +/- the same amount would be removed from any other driver

 21 files changed, 1634 insertions(+), 1002 deletions(-)

> * reduce the time people debug and fix bugs in stats since it will be
> just in one place, not in each driver

Examples ?

> * have more consistent names in ethtool -S

Forget it, better infra exists. Your hack to make stat count
"consistent" doesn't work either. Unless you assume only one process
can call ethtool -S at a time.

> * have more consistent stats sets in drivers since even within Intel
> drivers it's a bit of a mess which stats are exported etc.

Consistently undocumented :( qstats exist and are documented.

> Most of your pushback here sounds like if I would try to introduce this
> in the core code, but I don't do that here. This infra saves a lot of
> locs

s/saves/may save/ ?

> and time when used in the Intel drivers and it would be totally
> fine for me if some pieces of the lib goes into the core, but these
> stats don't.
> I didn't declare anywhere that everyone must use it or that it's core
> code, do you want me to change this MODULE_DESCRIPTION()?

I deeply dislike the macro templating. Complex local systems of this
sort make it really painful to do cross-driver changes. It's fine for
you because you wrote this, but speaking from experience (mlx5) it makes
modifying the driver for an outside much harder.

If you think the core infra is lacking, please improve it instead of
inventing your own, buggy one.

