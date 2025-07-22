Return-Path: <netdev+bounces-209077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88822B0E2FF
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 19:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D6B5654D6
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16E227EFE1;
	Tue, 22 Jul 2025 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LbKw8UtG"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D3880034
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206626; cv=none; b=uE9xEveOZRAam7Mf3bMXt16GXEs38EaQULTi2AEhmyGQ8d8/CDQ2gAYzkojfZZOtIlXYsqqH+/hWV8a2LP6BJn0CY0SoDfBLhWQTLCyM/cwqioztQq+eqq3VdSfvFRRt/RfcLNg82qfVMYDubXkD36KN6aClzFZrwG1J8RCCcaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206626; c=relaxed/simple;
	bh=QXqKnI/N2HZItgQQiPQwrmhkocVGW89byRVZWhnU9AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBL7iWZMZw4AQegIHyAsgNZItAmQcxcuthkQ4Pw+mBhInH5NgLxv25n2EzHcE0AuF9sJR1GFKkMQ5F/Bxaj3Q0UCRp3EMI64iS0MRjEy2QqYIbB5FfD7vahXY4LqBeD28PnUzBijHNJwXJdGlW6F5Goi5ajY5dHEsjHz90k/Ce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LbKw8UtG; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 10:50:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753206621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BejSsJQ8x+zI2KklFDPj8jeqTPKOlVUKviuQVXmFaIA=;
	b=LbKw8UtGVkpfSVbu1HPJ2OV1yGOUz8uu6GThUzkY1s4fZuHyrzyqzDVejTk/L2eL8lLo9J
	Kw3UEo9hhRLyCb2kX/yf4T87yOJ1E6zwNzWlvb9VXJAooYPF4BAFgSzonbSHcauD3wpT1H
	KndbinfCJlxz3NNr9gStI+AERG+bddM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
Message-ID: <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
 <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 22, 2025 at 10:57:31AM +0200, Michal Koutný wrote:
> Hello Daniel.
> 
> On Tue, Jul 22, 2025 at 09:11:46AM +0200, Daniel Sedlak <daniel.sedlak@cdn77.com> wrote:
> >   /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
> > 
> > The output value is an integer matching the internal semantics of the
> > struct mem_cgroup for socket_pressure. It is a periodic re-arm clock,
> > representing the end of the said socket memory pressure, and once the
> > clock is re-armed it is set to jiffies + HZ.
> 
> I don't find it ideal to expose this value in its raw form that is
> rather an implementation detail.
> 
> IIUC, the information is possibly valid only during one jiffy interval.
> How would be the userspace consuming this?
> 
> I'd consider exposing this as a cummulative counter in memory.stat for
> simplicity (or possibly cummulative time spent in the pressure
> condition).
> 
> Shakeel, how useful is this vmpressure per-cgroup tracking nowadays? I
> thought it's kind of legacy.


Yes vmpressure is legacy and we should not expose raw underlying number
to the userspace. How about just 0 or 1 and use
mem_cgroup_under_socket_pressure() underlying? In future if we change
the underlying implementation, the output of this interface should be
consistent.

