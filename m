Return-Path: <netdev+bounces-79641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6490687A590
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 11:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7548283564
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF91383B9;
	Wed, 13 Mar 2024 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="HNCHr693"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A2539AF1
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324544; cv=none; b=tULS7Y1XF/SFSg0Q0ieQfXKp/aJzgThOM2X7urjWQNWDuoRfOjeUnIl4n+U789pkrX0RgBI6tXu3f68ZjM/riSuIRtkzEUYBWfa9fpopake/ZzS5Lk3QWdESw01KBiNh22Zbta+O0k3AIdN7b8iG4HHMHbk56yV+TsJcKK7TaJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324544; c=relaxed/simple;
	bh=Af8Hbj/ByCwgLgpmME8jfV4IaCzYKbDD2gPJQEtunEk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emYolhTTtIjzhTzUW1AivPTdOkUnfQE1J8M3WvFO9JfNaQJzDK8OyU0oJn6uwJKCZLS+mbI3BF+E51dyzBiPWmlm/qpneT1jRA/LZg2B+mY9tcc8q5h1Rr7aiokSbG1/koA3XnfRTdtOW/5yW+gMOc0ZZ2SP+DZ+E1MAVKMLN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=HNCHr693; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 76FC520870;
	Wed, 13 Mar 2024 11:08:53 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IUkdDTb3xxtX; Wed, 13 Mar 2024 11:08:52 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 365B6208CB;
	Wed, 13 Mar 2024 11:08:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 365B6208CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1710324532;
	bh=eihK3JZsm1hVNlPzKtsXLeURo6sUQRjOYI+fIWqkDuw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=HNCHr693OwLMsBTbgsRpuAdW/K0ygCulFuGsTBZ9nDEIox3WLImUFKrbq6s5WexaP
	 lCbJkJkoaTplAc39F41rukdls6hz1hj50vp+NfUxt/BwxtdGQvGN+wq5xBNSRAQYSY
	 2cqh4GS4XAxIwzfChYq3mgklLtrR+aUAfh+TYdXZ8QDW/oWCQ1Doi1HqblV+wMmmIG
	 EK2KX18WG3ynSkjL3gVOpxWPjrnyqROqX15bCGEKcv7PJ0JNklVLz39ysH4apFntZ3
	 U/qELLY8v5H36sED0b4D/GMvPzR8RDUI7moCkpgAy6qziYdtujfjoVTMuOqQUamtaK
	 I+DR3vUMMt9Lw==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 2967380004A;
	Wed, 13 Mar 2024 11:08:52 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 11:08:52 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 11:08:51 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 39934318484D; Wed, 13 Mar 2024 11:08:51 +0100 (CET)
Date: Wed, 13 Mar 2024 11:08:51 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH xfrm] xfrm: Allow UDP encapsulation only in offload modes
Message-ID: <ZfF7M7C/EAu8Umb0@gauss3.secunet.de>
References: <3d3a34ffce4f66b8242791d1e6b3091aec8a2c25.1710244420.git.leonro@nvidia.com>
 <37a7a9fb76f295cf8babb8251dea0033add4c40b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <37a7a9fb76f295cf8babb8251dea0033add4c40b.camel@redhat.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Mar 12, 2024 at 01:24:31PM +0100, Paolo Abeni wrote:
> On Tue, 2024-03-12 at 13:55 +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The missing check of x->encap caused to the situation where GSO packets
> > were created with UDP encapsulation.
> > 
> > As a solution return the encap check for non-offloaded SA.
> > 
> > Fixes: 9f2b55961a80 ("xfrm: Pass UDP encapsulation in TX packet offload")
> 
> Should be:
> 
> Fixes: 983a73da1f99 ("xfrm: Pass UDP encapsulation in TX packet offload")
> 
> @Steffen: I guess you want to apply it first in your tree and send it later as PR?
> In such case, could you please adjust the fixes hash while at it?

Yes, I'll adjust the fixes tag.

Thanks!

