Return-Path: <netdev+bounces-89095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C26B8A96E7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFFF1C204F5
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2959D15AAD7;
	Thu, 18 Apr 2024 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="s/XVSXyn"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF815B559
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434513; cv=none; b=ufuWgj38bcQjBV+9p4jmvEwpKvx51Q/60x8Bk37b02he3HYqv1erNYapjjcn/BIgGDKPVrPQOPyxlO42pdt4cOPd0wQveOu0SrSoJSNb/Z5n0m8c+B3yKBac7L9+ZSaNhxaS4XCBh6B3eRmazErUb8wM51QFoQ6HrEuASk8QDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434513; c=relaxed/simple;
	bh=NQUcvAdrotZgGAzzcZpQzkkCLcBAK6TDZRe+h+gfSfc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSfI9v4Y6S5j2sd+lKDl4XvBbrheVen6zKcRn9XCpakTFBWMvv6Is9sBac9JVSUvWjZvSx0Lm+Xnkv3YwrYsIW81FC75PZIt5SpiIIpRxm4bMGO3fc4vEg/0tBfZBiB7wub11nQm+rMUK7JC0ZBqynzbnip5F2A8r/a6OPVZWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=s/XVSXyn; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D74BE2090D;
	Thu, 18 Apr 2024 12:01:48 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o3yIR_6Y-_2f; Thu, 18 Apr 2024 12:01:42 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6646120900;
	Thu, 18 Apr 2024 12:01:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6646120900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713434502;
	bh=CmPhBbE86j5ewzq9D0aKFn/2rxr0lA+RfiVMfBrXjGE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=s/XVSXynrCXcElFJ8nS17n6gszsYkOEl60JTAHebz5XfGQtxmI7aewK9LRNJhB0BK
	 LTmTG45DocCj4JWdVuamXi920SMAW7QYuFdZnkb+3w9/UfRH0QHUpzI7tZZAvOV5le
	 /tuOD5pu5iJiKavfhmFM2hXql9xfctvZyA5+6m/xMRYA0mJdnIGPiGGut9iMeKe8Eq
	 UTgS61vy4evfTZ6MGnWvguBrZBy1g19C3mokNCFmFvRm4meMIgT7TNx/8DlNA68+0D
	 qFcnJls73ip1qU5uh2AR7b8SqzQdyXN6HJpDdvn0sFfoWz1zQJzqT7YqkZlg21zqma
	 IAzEB71m8tEGw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 596BE80004A;
	Thu, 18 Apr 2024 12:01:42 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 12:01:42 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 18 Apr
 2024 12:01:41 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A69FF31809C7; Thu, 18 Apr 2024 12:01:41 +0200 (CEST)
Date: Thu, 18 Apr 2024 12:01:41 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Daniel Xu <dxu@dxuuu.xyz>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Paul Wouters
	<paul@nohats.ca>, Antony Antony <antony.antony@secunet.com>, Tobias Brunner
	<tobias@strongswan.org>
Subject: Re: [PATCH ipsec-next 2/3] xfrm: Cache used outbound xfrm states at
 the policy.
Message-ID: <ZiDvhTVdn+8fvxtv@gauss3.secunet.de>
References: <20240412060553.3483630-1-steffen.klassert@secunet.com>
 <20240412060553.3483630-3-steffen.klassert@secunet.com>
 <3qa7guzmpne5sc6etdeoh7juinmio5w57qr37v7if4t63jdqdv@r2vmpdzcpst4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3qa7guzmpne5sc6etdeoh7juinmio5w57qr37v7if4t63jdqdv@r2vmpdzcpst4>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Tue, Apr 16, 2024 at 03:51:55PM -0600, Daniel Xu wrote:
> > +
> > +	hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
> > +		if (x->props.family == encap_family &&
> > +		    x->props.reqid == tmpl->reqid &&
> > +		    (mark & x->mark.m) == x->mark.v &&
> > +		    x->if_id == if_id &&
> > +		    !(x->props.flags & XFRM_STATE_WILDRECV) &&
> > +		    xfrm_addr_equal(&x->id.daddr, daddr, encap_family) &&
> > +		    tmpl->mode == x->props.mode &&
> > +		    tmpl->id.proto == x->id.proto &&
> > +		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
> > +			xfrm_state_look_at(pol, x, fl, family,
> > +					   &best, &acquire_in_progress, &error);
> > +	}
> > +
> > +cached:
> > +	if (best)
> 
> Need to set `cached = true` here otherwise slowpath will always be
> taken.

Fixed, thanks Daniel!

