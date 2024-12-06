Return-Path: <netdev+bounces-149677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F749E6CA8
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2FB18841F6
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768AD1FBC80;
	Fri,  6 Dec 2024 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="y6ybDvLS"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF061FA24D
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482677; cv=none; b=ANXcuNPBpwn2yRlqObd1gphKUrjF9ABaMAbOFteaBwHNsK0axY+NY7sbVuWpoy22cRQL4ZBBblimj98xwhJwJL+f1dgZTF31agt0OHlVWzHn/QpZuVnvcqQCl/atknG46QWkT0kP65N3XOdrMEFlwO+o6D3ueZrC1dgfLjmBagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482677; c=relaxed/simple;
	bh=e6UMfAX7p5s97+sqS2jsjkB2Y8JzHciJavixtE6/C6A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqC6kh8UuWMjC9mhZvp6QwvYCAqSSmBzZhZIB1uXyonYhA5IRZJMQ8iJ/UcypCdm9tq3DN+4L3ZsCFmb7PcrXS3L2PL0hbP4zrvA9JDuP06NdCCHCjtMaF2GQSVcA755Bht6ri3BuWa4Lmy5cEVgodtIney2yOjuA4iT2x+5mtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=y6ybDvLS; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D6475208B3;
	Fri,  6 Dec 2024 11:52:07 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7dlAfgyRBaIl; Fri,  6 Dec 2024 11:52:07 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EC9252058E;
	Fri,  6 Dec 2024 11:52:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com EC9252058E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1733482327;
	bh=zzr/utioMAaV6S1d+4WlFUwVOWhRFJ/iEygRnIkgpoc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=y6ybDvLSveOnMMGPShlhFErtSeYvoN646gPTgqDD6ohGGIG1DdMFcHoWLx2jr/CMb
	 EL7hRRH32hCHB/Z0tns1C5AsGQSlFlOOiEVdAZ492JOp5DoI/yLHGj2EX2Xo4yK/FC
	 tmB+nemAxf4YGEwpjzOALj0XSWk/TCIuPfIaX2cP61/hJc7bK1crcuTRtWg9JhAmch
	 KyMfwp/2k/YSdE9A5tO/cb04Q8w8pT0chd8S0dvzwEoYLfMRSS7hIPVU6caty3LlTL
	 xUCPFYEYfVnAQv/AAIdaFb6K+wMUEZJn4gZIwCO3qgArPqJM3de+CiliZXeW7skd6R
	 2QK39lp0myqPg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 11:52:06 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 11:52:06 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4ACAC3184178; Fri,  6 Dec 2024 11:52:06 +0100 (CET)
Date: Fri, 6 Dec 2024 11:52:06 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<dvyukov@google.com>, <syzbot+5f9f31cb7d985f584d8e@syzkaller.appspotmail.com>
Subject: Re: [PATCH ipsec] xfrm: state: fix out-of-bounds read during lookup
Message-ID: <Z1LXVmY/cya/wZXS@gauss3.secunet.de>
References: <6745e035.050a0220.1286eb.001b.GAE@google.com>
 <20241128142640.26848-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241128142640.26848-1-fw@strlen.de>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Nov 28, 2024 at 03:26:25PM +0100, Florian Westphal wrote:
> lookup and resize can run in parallel.
> 
> The xfrm_state_hash_generation seqlock ensures a retry, but the hash
> functions can observe a hmask value that is too large for the new hlist
> array.
> 
> rehash does:
>   rcu_assign_pointer(net->xfrm.state_bydst, ndst) [..]
>   net->xfrm.state_hmask = nhashmask;
> 
> While state lookup does:
>   h = xfrm_dst_hash(net, daddr, saddr, tmpl->reqid, encap_family);
>   hlist_for_each_entry_rcu(x, net->xfrm.state_bydst + h, bydst) {
> 
> This is only safe in case the update to state_bydst is larger than
> net->xfrm.xfrm_state_hmask (or if the lookup function gets
> serialized via state spinlock again).
> 
> Fix this by prefetching state_hmask and the associated pointers.
> The xfrm_state_hash_generation seqlock retry will ensure that the pointer
> and the hmask will be consistent.
> 
> The existing helpers, like xfrm_dst_hash(), are now unsafe for RCU side,
> add lockdep assertions to document that they are only safe for insert
> side.
> 
> xfrm_state_lookup_byaddr() uses the spinlock rather than RCU.
> AFAICS this is an oversight from back when state lookup was converted to
> RCU, this lock should be replaced with RCU in a future patch.
> 
> Reported-by: syzbot+5f9f31cb7d985f584d8e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/CACT4Y+azwfrE3uz6A5ZErov5YN2LYBN5KrsymBerT36VU8qzBA@mail.gmail.com/
> Diagnosed-by: Dmitry Vyukov <dvyukov@google.com>
> Fixes: c2f672fc9464 ("xfrm: state lookup can be lockless")
> Signed-off-by: Florian Westphal <fw@strlen.de>

Applied, thanks a lot Florian!

