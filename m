Return-Path: <netdev+bounces-86883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 460898A0994
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7811B225AF
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 07:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FAC13DBB1;
	Thu, 11 Apr 2024 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="K7yNbFB0"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C212032C
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820136; cv=none; b=iN79sbWOMzZl1GkzqgK52uGHJHPXo9hxykCXNkQreRPBAa+BiljimRf4/uIbdwnbHPTHGmMoEsWfX8pq6lCSnHGkq/pIJ4tjleT6GE7HNWNAtBcPXGjpYQCLpj0UB5tMtxbsAp8zM7HPGIvSs16oroNEvSFXQNjE5CWINLHUzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820136; c=relaxed/simple;
	bh=wAy2mgRFGi7SO7hXDx/ZQ9k6jkBEF3hbQxeA0Fe7zSM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YidewlROZJyrSq9cvsFbFYDFY7f7bk6rnndvoYd8+d0s9gAsqcXQCwxU1KPez+7I+fzlIRbW38nCR07ohbxz6gXI/ZZjmhv3XeHjqsYyBQGJpEw+fHpNQu/mgtrUddNFGjcXbpzu4hsqu1PqjcfQriHH9SB2gUdeWIEaKLxgjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=K7yNbFB0; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id EAC9B205ED;
	Thu, 11 Apr 2024 09:22:11 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zkWuszkXaNwj; Thu, 11 Apr 2024 09:22:11 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6E42A2083F;
	Thu, 11 Apr 2024 09:22:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6E42A2083F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712820131;
	bh=bqv9WAE1TYY2u/UYCURTBW44xaOiUWCc3q/aUJzjJrI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=K7yNbFB0O5zg5EpfhRyl/wRdGOsJgHARLiyzVzZdRoHGn6m6qtqpArKURBwrD77zo
	 5ZgkCP8WrouJk8tc/QDH63eIvK4QeNKSg4SD2s0szx9Ab357vv8M3jm9jndJhNw/RA
	 q2k59H7X08ZoKktCIG4WKZwUJT9sGGl9Jj0rAq1cFnJdcksPwv13GeQBxJVHw7joBg
	 WkC1wqeFB3gd+B9IbjHiWosmQS4WrgcRREYaFqSYYB7e4UV0VWwD7JbHqaos1xV/2l
	 blwJxTBQC7t7Fx+UXnX0S05QoQGkQeyOvXmgo1/bM7JMOP5fPsCmgg4cskvfnuUo1C
	 2exld7xOAUIhA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 6273380004A;
	Thu, 11 Apr 2024 09:22:11 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 09:22:11 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 11 Apr
 2024 09:22:10 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id B1DB3318093A; Thu, 11 Apr 2024 09:22:10 +0200 (CEST)
Date: Thu, 11 Apr 2024 09:22:10 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
CC: Sabrina Dubroca <sd@queasysnail.net>, <antony.antony@secunet.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<devel@linux-ipsec.org>, Leon Romanovsky <leon@kernel.org>, Eyal Birger
	<eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v9] xfrm: Add Direction to the SA in or out
Message-ID: <ZhePoickEM34/ojP@gauss3.secunet.de>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
 <ZhY_EE8miFAgZkkC@hog>
 <f2c52a01-925c-4e3a-8a42-aeb809364cc9@6wind.com>
 <ZhZLHNS41G2AJpE_@hog>
 <1909116d-15e1-48ac-ab55-21bce409fe64@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1909116d-15e1-48ac-ab55-21bce409fe64@6wind.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

On Wed, Apr 10, 2024 at 10:37:27AM +0200, Nicolas Dichtel wrote:
> Le 10/04/2024 à 10:17, Sabrina Dubroca a écrit :
> [snip]
> >> Why isn't it possible to restrict the use of an input SA to the input path and
> >> output SA to xmit path?
> > 
> > Because nobody has written a patch for it yet :)
> > 
> For me, it should be done in this patch/series ;-)

I tend to disagree here. Adding the direction as a lookup key
is IMO beyond the scope of this patch. That's complicated and
would defer this series by months. Given that the upcomming IPTFS
implementation has a lot of direction specific config options,
it makes sense to take that this patch now. Otherwise we have the
direction specific options in input and output states forever.

