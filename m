Return-Path: <netdev+bounces-107176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FDD91A356
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6A2B22C1D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0813A400;
	Thu, 27 Jun 2024 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="WInV4144"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85B73451
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482526; cv=none; b=SZN4BsKYL/2zD6Oy/Jm0sFFSIM5TS9cZWtn8J9dvOzw28awSotvoih4YZwX9h97KhmWuMDWRwj2Gelzs4yA7O+yNe6PHYXQ14T8OdEuKgkpjTeGHtDDK+BSeVHbYhPmQI9rfF8sbEHUGHG5KKLmVVNJaYc3abf4TSmOjsKrieMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482526; c=relaxed/simple;
	bh=0+FD3x3PSX2o6aEk9iocb7v2Z/Fy88YPHVFv/U6vP88=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9FiNVou3kl4E2VNQOaZF73qOaQIg7873iUQ3945CC3cgHDVmhKj59gso88RUPILeHDabECWpFtei7NFOF0lp9fWMiGLBbxsnLbdOVRHESmap1FZevl0DWVso08S6RmPjb39qmdqzDdKIOVdn0cZ8KPTR89M0O/yEjnGp2gSphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=WInV4144; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2E7102074B;
	Thu, 27 Jun 2024 12:02:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6TTxfVAE0rm7; Thu, 27 Jun 2024 12:01:57 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 530D020185;
	Thu, 27 Jun 2024 12:01:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 530D020185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1719482517;
	bh=TQBXdUhLbnoAx6uQGCoE3DveiTAvPLkHcDrenQws1Qg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=WInV4144n+IlM8KueV0g+vcO6a0CBjViA0Hl/jksiorcrAijAQA7LXZI7X1eYSoyn
	 tJnXmNuMWiQkr4Mq4wRmLkEfe93DRTfHUtEC2bg1cqbWP9VMSTg2dGkNlsW22y+fJZ
	 maLbs1d7gwq/v1zoUlQK8RrpFpOsol95LA+VmcEc+25dsTJRewN/cphBhvVaInHBPk
	 KE4rbyqE3yuOZqLAuW23LLssCJNY8CTFKAI3dp5ntQJbYk/HXlLZ4M5cvZOJs1YYT2
	 slaXRXTv3Rvq3QGAg30lyMJ3hQjjpu0Tc4XMmd/1L39tm9NhbRcsdEaGMpWgSME9BU
	 inerUP5/7qgoA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 446DD80004A;
	Thu, 27 Jun 2024 12:01:57 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 12:01:57 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 12:01:56 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 41ED731824EA; Thu, 27 Jun 2024 12:01:56 +0200 (CEST)
Date: Thu, 27 Jun 2024 12:01:56 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Eyal Birger <eyal.birger@gmail.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <herbert@gondor.apana.org.au>, <pablo@netfilter.org>,
	<paul.wouters@aiven.io>, <nharold@google.com>, <mcr@sandelman.ca>,
	<devel@linux-ipsec.org>, <netdev@vger.kernel.org>
Subject: Re: [devel-ipsec] [PATCH ipsec-next, v4] xfrm: support sending NAT
 keepalives in ESP in UDP states
Message-ID: <Zn04lL533UFXpvYZ@gauss3.secunet.de>
References: <20240528032914.2551267-1-eyal.birger@gmail.com>
 <ZnqaKO2Mz/ZR6sNT@moon.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZnqaKO2Mz/ZR6sNT@moon.secunet.de>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Jun 25, 2024 at 12:21:28PM +0200, Antony Antony wrote:
> On Mon, May 27, 2024 at 20:29:14 -0700, Eyal Birger via Devel wrote:
> > Add the ability to send out RFC-3948 NAT keepalives from the xfrm stack.
> > 
> > To use, Userspace sets an XFRM_NAT_KEEPALIVE_INTERVAL integer property when
> > creating XFRM outbound states which denotes the number of seconds between
> > keepalive messages.
> > 
> > Keepalive messages are sent from a per net delayed work which iterates over
> > the xfrm states. The logic is guarded by the xfrm state spinlock due to the
> > xfrm state walk iterator.
> > 
> > Possible future enhancements:
> > 
> > - Adding counters to keep track of sent keepalives.
> > - deduplicate NAT keepalives between states sharing the same nat keepalive
> >   parameters.
> > - provisioning hardware offloads for devices capable of implementing this.
> > - revise xfrm state list to use an rcu list in order to avoid running this
> >   under spinlock.
> > 
> > Suggested-by: Paul Wouters <paul.wouters@aiven.io>
> > Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> 
> Tested-by: Antony Antony <antony.antony@secunet.com>

Now applied to ipsec-next, thanks everyone!

