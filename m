Return-Path: <netdev+bounces-220488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D319B4657A
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 23:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E481684D9
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 21:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED882ECD26;
	Fri,  5 Sep 2025 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ItlWyhV7"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F402F067F
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107560; cv=none; b=qU1WHKW6nM0LvZU+Ti0ZnNUn9FwkK0tVRjPES0RESs+x0Gxj/I7sj5y6ZkphCGtMRTUZ0eAiQtK/uoyT6FnrMFrCfqf7K8y55bOIcf9CnckNlH9uzu+8CIgZk7pWlWQFqXWrORcvhgJ92aFfZxCRzs0FBiZduhgyHPMi+zYGNH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107560; c=relaxed/simple;
	bh=a0dtg9Rb5qvDZD7tUwmiQwzyP8BNFp5sd+c5DC/udPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnynIXM3CAkmUjCovSka5O8DnEjzxdDIEZWPoNPXElZySJKxeKnuPfijVAD/Nrf83gBPksfd6bP69R6vpuNSNBu059PRpPxycr0m/f0q+6FjB9JHJ1MwcNp7C9VWvZ1oGLr5saC2Wig/Ek4tLNK/0YCR7vUCXM888mquMTI4O8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ItlWyhV7; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 14:25:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757107546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPL9l1PfulHPyb4hKUXM6kxN6VVdt1f+BT1sVipVBIg=;
	b=ItlWyhV70s3CopeZ+x7PL85lciAy3Xb63lkzd0CVPnHbDRfRkeSIbsR0zoamqV0ILHN1yI
	+PJVYwVxXxRYarjUGCUnimm8weVGDoGkMuQalISA9DM3bUHMOTKZ0Jyb8xDNZNRyUpz546
	Tvc3B69H8mRISDxJHYefNRivQgn0gcQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 bpf-next/net 4/5] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
Message-ID: <sathtxzxvi5zz5gh37twfng7srn7nsdlrdlposompqkq646pp5@2r74fqgbalzq>
References: <20250903190238.2511885-1-kuniyu@google.com>
 <20250903190238.2511885-5-kuniyu@google.com>
 <20250904063456.GB2144@cmpxchg.org>
 <CAAVpQUA+rVJKMXQFATfxT=uX3QaLrCtCG_wtiGF_kt-_KrMRBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUA+rVJKMXQFATfxT=uX3QaLrCtCG_wtiGF_kt-_KrMRBQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 04, 2025 at 01:21:47PM -0700, Kuniyuki Iwashima wrote:
> On Wed, Sep 3, 2025 at 11:35 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Sep 03, 2025 at 07:02:03PM +0000, Kuniyuki Iwashima wrote:
> > > If all workloads were guaranteed to be controlled under memcg, the issue
> > > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> > >
> > > In reality, this assumption does not always hold, and processes not
> > > controlled by memcg lose the seatbelt and can consume memory up to
> > > the global limit, becoming noisy neighbour.
> >
> > It's been repeatedly pointed out to you that this container
> > configuration is not, and cannot be, supported. Processes not
> > controlled by memcg have many avenues to become noisy neighbors in a
> > multi-tenant system.
> >
> > So my NAK still applies. Please carry this forward in all future patch
> > submissions even if your implementation changes.
> 
> I see.
> 
> I'm waiting for Shakeel's response as he agreed on decoupling
> memcg and tcp_mem and suggested the bpf approach.

Yes I agreed on decoupling memcg and tcp_mem but not for a weird
configuration, so please stop using this motivatioan already. You can
motivate the decoupling simply on performance. Why pay the cost
of two orthogonal accounting mechanisms concurrently? Also you are not
disabling memcg accounting, so we should be good from memcg side. Make
this very clear in your commit message.

I don't care how you plan to use this feature to enable your weird
use-case but make sure this feature is beneficial to general Linux
users.

