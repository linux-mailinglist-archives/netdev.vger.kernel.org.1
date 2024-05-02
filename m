Return-Path: <netdev+bounces-93023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199078B9AFB
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 14:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6181C21667
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A0541C60;
	Thu,  2 May 2024 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="oMDQsSqw"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B921CAB8
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653495; cv=none; b=kn2VKIitkhGw3bZoBmpgmiwbJlmTnyNKZMPstb7o2Tpd81Iu4abSKVLgQbZQU3SyjQbYmhk9MZ9FgYgF8voGxcqIeEwJPMEosFah+KIeBHluY7EHwGUUb2+3QIu24duWwXSJ4w/25HnU3tIGizOC0wgO4LK0erwpi8BICR4wuD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653495; c=relaxed/simple;
	bh=b03xhHlf8eHUI4kFfwDlk9U9pqh+wseed2O16UJzMXw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFyCjNoyQq6+Bvtg+LbcJjTJRy65pIn3yhIPfHE65Tx9jngEPAn0gbkQgdjjiSIlVV+/mZSdTiIn9QwtasvP4OSddlzBQPV28uo3R6eYFmR1mFuhzyowy+f3eq9i3l69T3bEmB+8jZ+4QNelO7a60wHi3/QAdf5GTXgdNQ6//tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=oMDQsSqw; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9FBA9207FD;
	Thu,  2 May 2024 14:38:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cx08afG5CH6d; Thu,  2 May 2024 14:38:08 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 686382082B;
	Thu,  2 May 2024 14:38:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 686382082B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714653486;
	bh=E4uCCdG+V1vUKFQMQDconOLLaYAtGSVstIArGnXLlN8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=oMDQsSqwdEVQqwOqkhu+T2mDRS2a7e7E0mbQGP4F5ZjXGo1um1YCUqL6Cbwu7a6Pq
	 JLd8tZ6vl8DfiHOrsZB9gVtsYPl5PjRFy9HewL8xVM0u+1ALlBFnp0DFV1M06KpdKp
	 gBSlNa1B3LLklmrMfkP2ASrV6aElg45Tx+O6PJr648MpOjTDNhYd5bCk+JhHYbugVL
	 Vdmf5+v3NrrxhD1zZZuiERkXjmbaCvwb+bWasSMODMT+4Ylw2t2l64MmEtFeyFLclN
	 JofilnoMnR0APVKvBVOR9YDwyZpyVAPOdfqRfi2nqqxEENq4mEbv9A3e6mKn+sQkMV
	 TmocfQhq8jhCw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 58A5D80004A;
	Thu,  2 May 2024 14:38:06 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 2 May 2024 14:38:06 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 May
 2024 14:38:05 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8D5E131820A5; Thu,  2 May 2024 14:38:05 +0200 (CEST)
Date: Thu, 2 May 2024 14:38:05 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony@phenome.org>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Paul Wouters
	<paul@nohats.ca>, Antony Antony <antony.antony@secunet.com>, Tobias Brunner
	<tobias@strongswan.org>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH ipsec-next 0/3] Add support for per cpu xfrm states.
Message-ID: <ZjOJLXIQS23nkaW8@gauss3.secunet.de>
References: <20240412060553.3483630-1-steffen.klassert@secunet.com>
 <ZjOFCQLjufp5ua0M@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZjOFCQLjufp5ua0M@Antony2201.local>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, May 02, 2024 at 02:20:25PM +0200, Antony Antony wrote:
> 
> On Fri, Apr 12, 2024 at 08:05:50AM +0200, Steffen Klassert via Devel wrote:
> > Add support for per cpu xfrm states.
> > 
> > This patchset implements the xfrm part of per cpu SAs as specified in:
> > 
> > https://datatracker.ietf.org/doc/draft-ietf-ipsecme-multi-sa-performance/
> > 
> > Patch 1 adds the cpu as a lookup key and config option to to generate
> > acquire messages for each cpu.
> > 
> > Patch 2 caches outbound states at the policy.
> > 
> > Patch 3 caches inbound states on a new percpu state cache.
> > 
> > Please review and test.
> 
> Hi Steffen,
> 
> I tried xfrm-pcpu-v8 branch, and get these kernel splats. I think it happens 
> of the pervious version too. This kernel build has  KASAN enabled.

I've introduced this in v8 when I replaced get_cpu by smp_processor_id.
I'll fix this when I rebase next time.


