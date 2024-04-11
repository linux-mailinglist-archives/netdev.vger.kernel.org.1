Return-Path: <netdev+bounces-86951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B849C8A1277
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C1B282ED2
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4EE146D79;
	Thu, 11 Apr 2024 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="BZDZcX3R"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13921474B0
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833403; cv=none; b=IScUzU2UVMfsNf1rZE/Jab8twNCs7y9iJIeo/+KHiS0cv1cEynWu9kJBhDTbVLhFSAmBpQPVc9bkzVqgnbpgPuFM2p+mPyyxLYXM5YXbTiJdhWgWv2v/soxoWfNLBsRrgpjeEao0291XMcACjfLclU1ww4HBfKRqujI0AYEgGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833403; c=relaxed/simple;
	bh=12bbdiNFg0mCJOVSrZqYmc5qj+j0Jb87ecujTxfyFKQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1YBqTQlKmHr4Jve/BzyZ2GikujbrpziFhfyUuPyAyn+cITyTMMeRiO5A4Gehy/Cn9SkNjXK86dF5oawbr0XoDhp26spDvV8qieRHyW276eoHNfOGvjQi1sGX2iKDWI0n6X2UiRLzWYDSkMYk6uvzWGugZMAO+im6MxKaH2U9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BZDZcX3R; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 343FC2084A;
	Thu, 11 Apr 2024 13:03:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id siAP9S22Eoz6; Thu, 11 Apr 2024 13:03:18 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A4CA0206BC;
	Thu, 11 Apr 2024 13:03:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A4CA0206BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712833398;
	bh=iKWgWkMF36gjgc7LfQcwlZypZY+jaDdfDSvK8mk7snM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=BZDZcX3R6J9M07ZohEGXgp2IhyWOQgK7m4u6qDG9teQMjaT+EDrN37kwQFvgJ4yxq
	 eKpsC7tUwYfHnhKL0cF7H8GabxT1DS20jYMmKLHm7cH2qfw9sbph8UNp1dT0leFq5m
	 iFMuFvG9bNN3jo8Jz/RpMq2qH2j0bHdUjM668fkDeQARtVMUf/kyoIwF6+cNdLoMZE
	 kcf9G3WAQTqilKgRW5he96YYGXiVyUvg0hKUCrjR54vAvxwaFdYap6kmdFUQ7ehyMJ
	 NChl7ruitb7uU22laCsB+R7DoZeJC5uzCq7g+VmnopgfTAwg4urZo8+dbV+Sy21hAb
	 oZqQjD6Z/oahA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 97F8180004A;
	Thu, 11 Apr 2024 13:03:18 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 13:03:18 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 11 Apr
 2024 13:03:18 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id ED41731804CB; Thu, 11 Apr 2024 13:03:17 +0200 (CEST)
Date: Thu, 11 Apr 2024 13:03:17 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Paul Wouters <paul@nohats.ca>, Antony Antony <antony@phenome.org>,
	"Nicolas Dichtel" <nicolas.dichtel@6wind.com>, Antony Antony
	<antony.antony@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the
 SA in or out
Message-ID: <ZhfDdak3thiwSfPk@gauss3.secunet.de>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog>
 <ZhJX-Rn50RxteJam@Antony2201.local>
 <ZhPq542VY18zl6z3@hog>
 <ZhV5eG2pkrsX0uIV@Antony2201.local>
 <ZhZUQoOuvNz8RVg8@hog>
 <ZhbFVGc8p9u0xQcv@Antony2201.local>
 <81b4f75c-5c43-8357-55ad-0ec28291d399@nohats.ca>
 <ZhesGJtMXk-PPtzz@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZhesGJtMXk-PPtzz@hog>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

On Thu, Apr 11, 2024 at 11:23:36AM +0200, Sabrina Dubroca wrote:
> 2024-04-10, 20:58:33 -0400, Paul Wouters wrote:
> > On Wed, 10 Apr 2024, Antony Antony via Devel wrote:
> > 
> > > For instance, there isn't a validation for unused XFRMA_SA_EXTRA_FLAGS in
> > > DELSA; if set, it's simply ignored. Similarly, if XFRMA_SA_DIR were set in
> > > DELSA, it would also be disregarded. Attempting to introduce validations for
> > > DELSA and other methods seems like an extensive cleanup task. Do we consider
> > > this level of validation within the scope of our current patch? It feels
> > > like we are going too far.
> > 
> > Is there a way where rate limited logging can be introduced, so that
> > userlands will clean up their use and after a few years change the API
> > to not allow setting bogus values?
> 
> Yes, this is doable. Steffen, does that seem reasonable? (for example,
> when XFRMA_REPLAY_THRESH is passed to NEWSA, or XFRMA_ALG_AEAD to
> DELSA, etc)

Yes, a cleanup would be very wellcome. But that might be a bit of
work :-)

