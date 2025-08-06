Return-Path: <netdev+bounces-211992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412F9B1CF6B
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 01:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008213AE456
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 23:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E1627702C;
	Wed,  6 Aug 2025 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j/hWS0wr"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4F921FF57
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754523283; cv=none; b=isvsFaVwm7IgiZXO/YA1iY1xWqZ7YdOQp7j36RUZLwcfPsaNTLRPDJV5WH4CANVkH5f2gEN2yAdjdBfcVkUbG0kwUtEtgYXNNGxoBK+biOtKnuXjnHXSKLFqnOeQppnMNkxrG8OOasMwD3kezE7M2yDxPL1A0cWpW8Bm7YN5PUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754523283; c=relaxed/simple;
	bh=mSzBOFYv+d9ibFnJtqEu+Yj1VaAxgWsR1t7LOI0p4tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjHUiznlVcXHWb+xJKV9naaoB2NsjrE6sllPd6bNKEThEeuzcszGs15hAPg+ND/ljSRtwNwkQKkklQ1WHUwPnWCd+MNt9Aq5K8hMQ4VrWHPDJulxIv4SVcl7I+Mg1kD7DvlkzSQlJcXp6HAqQThR7Py7xNcGY3r2emOzQjlw/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j/hWS0wr; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Aug 2025 16:34:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754523270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvRGbUoxHQXYC8T8tbdVGdWHSxSOXMjp8BJoimfjlLU=;
	b=j/hWS0wrDoTsiYRXQLmUw2nBIRG9ovVttyd4dmFzAA401tGH2U/YCnIHLc25FLDAxcDloT
	bkyLMiL/xuyI3prrBVHRVdoSs1GQj1pqURUmBqusj4pNpZ5dfWcb39NvA5dGlrFIecP9pd
	tBbUPmoREKxIaMnSE8Z2niGmZ6jXeSY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Message-ID: <chb7znbpkbsf7pftnzdzkum63gt7cajft2lqiqqfx7zol3ftre@7cdg4czr5k4j>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
 <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com>
 <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
 <CAAVpQUCCg-7kvzMeSSsKp3+Fu8pvvE5U-H5wkt=xMryNmnF5CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUCCg-7kvzMeSSsKp3+Fu8pvvE5U-H5wkt=xMryNmnF5CA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 06, 2025 at 03:01:44PM -0700, Kuniyuki Iwashima wrote:
> On Wed, Aug 6, 2025 at 2:54 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Wed, Aug 06, 2025 at 12:20:25PM -0700, Kuniyuki Iwashima wrote:
> > > > > -                     WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
> > > > > +                     socket_pressure = jiffies + HZ;
> > > > > +
> > > > > +                     jiffies_diff = min(socket_pressure - READ_ONCE(memcg->socket_pressure), HZ);
> > > > > +                     memcg->socket_pressure_duration += jiffies_to_usecs(jiffies_diff);
> > > >
> > > > KCSAN will complain about this. I think we can use atomic_long_add() and
> > > > don't need the one with strict ordering.
> > >
> > > Assuming from atomic_ that vmpressure() could be called concurrently
> > > for the same memcg, should we protect socket_pressure and duration
> > > within the same lock instead of mixing WRITE/READ_ONCE() and
> > > atomic?  Otherwise jiffies_diff could be incorrect (the error is smaller
> > > than HZ though).
> > >
> >
> > Yeah good point. Also this field needs to be hierarchical. So, with lock
> > something like following is needed:
> >
> >         if (!spin_trylock(memcg->net_pressure_lock))
> >                 return;
> >
> >         socket_pressure = jiffies + HZ;
> >         diff = min(socket_pressure - READ_ONCE(memcg->socket_pressure), HZ);
> 
> READ_ONCE() should be unnecessary here.
> 
> >
> >         if (diff) {
> >                 WRITE_ONCE(memcg->socket_pressure, socket_pressure);
> >                 // mod_memcg_state(memcg, MEMCG_NET_PRESSURE, diff);
> >                 // OR
> >                 // while (memcg) {
> >                 //      memcg->sk_pressure_duration += diff;
> >                 //      memcg = parent_mem_cgroup(memcg);
> 
> The parents' sk_pressure_duration is not protected by the lock
> taken by trylock.  Maybe we need another global mutex if we want
> the hierarchy ?

We don't really need lock protection for sk_pressure_duration. The lock
is only giving us consistent value of diff. Once we have computed the
diff, we can add it to sk_pressure_duration of a memcg and all of its
ancestor without lock.


