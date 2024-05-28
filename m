Return-Path: <netdev+bounces-98431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 439748D1695
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37822839BB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C1A13C8F2;
	Tue, 28 May 2024 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VcAf8MWY"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFE13C8E9
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885868; cv=none; b=D4+uYWI/xorErL7BiUs2jd6CULkIovRvYaKPSbIq8GPk/ZunzEDS/8O7psKVCBhyB84LEQPbfD8R+arrIXglEnyyw5NVwxxhk+77tiu5yIuvd+JGOrDZ6XC7bB34fdCUH9I8b6zg5Rv0GyaZ4JKtOkIqHdwXLrxMRG/7+XN91xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885868; c=relaxed/simple;
	bh=i/dEfm/igPUCp2kUFbpHe53agKhYemz1X9BbwQek/Iw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWC8KyrHKYVk7hERFhwwTYIUe9VQmBP/EAAz6OLB7Q9uEmB26sfhq1Avs4zeV86gSi9Bo1d1rcIb1cZZY9KLAtTicRHNmPocOUI2grLpQUBVSfYIHqnBV50ZbX08+EgoOYmBdeyfgHavFmAgxHUz5PH3Cc2dZDNwRWJlJFdPbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VcAf8MWY; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B896C2058E;
	Tue, 28 May 2024 10:44:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x3A5s8mUnZCD; Tue, 28 May 2024 10:44:17 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 37C2B20519;
	Tue, 28 May 2024 10:44:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 37C2B20519
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1716885857;
	bh=/eP0zNWMEEWKtvtqud308aa927I975/oBXoLmHdC5Sw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=VcAf8MWYS9su5T+mquMwpYSXNWLmUBjcF8PUOrzMva1nfENrcfZW/zyCpfk9SLvaA
	 XD0HJ1j/vA2wiwQ0YdpZTwqL9S4VhvQuLgtKVjkXxjZPTS9HJDD6/luIfg1c1GtgiG
	 IchbteNJlAI2DSU6Ra0sST5VCjWl9CdC6/aJo8lfB0ASRa5SnlPGZ0mTC/X/7eMikP
	 VB7gb3n/XCUzAck0mHiWLEcLIIlwGuNwKBFxfSWm6tGQvtxc+y4iSqSwv+mGukYjCY
	 oDQcXDGuc3AGq1+OgAbi7p8IVUPNOU/N7AOpUmrSaYsB/JDk+kCXw6qV7pHhMivx/T
	 9yaNSqF/SYV+Q==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 324BE80004A;
	Tue, 28 May 2024 10:44:17 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 10:44:16 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 May
 2024 10:44:16 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7C26D3182B3B; Tue, 28 May 2024 10:44:16 +0200 (CEST)
Date: Tue, 28 May 2024 10:44:16 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Message-ID: <ZlWZYOMaiAUE8a3+@gauss3.secunet.de>
References: <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
 <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
 <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
 <4d6e7b9c11c24eb4d9df593a9cab825549dd02c2.camel@nvidia.com>
 <Zk7l6MChwKkjbTJx@gauss3.secunet.de>
 <d81de210f0f4a37f07cc5b990c41c11eb5281780.camel@nvidia.com>
 <Zk8TqcngSL8aqNGI@gauss3.secunet.de>
 <405dc0bc3c4217575f89142df2dabc6749795149.camel@nvidia.com>
 <ZlQ455Vg0HfGbkzT@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZlQ455Vg0HfGbkzT@gauss3.secunet.de>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, May 27, 2024 at 09:40:23AM +0200, Steffen Klassert wrote:
> On Thu, May 23, 2024 at 03:26:22PM +0000, Jianbo Liu wrote:
> > On Thu, 2024-05-23 at 12:00 +0200, Steffen Klassert wrote:
> > > 
> > > Hm, interesting.
> > > 
> > > Can you check if xfrm_dev_state_free() is triggered in that codepath
> > > and if it actually removes the device from the states?
> > > 
> > 
> > xfrm_dev_state_free is not triggered. I think it's because I did "ip x
> > s delall" before unregister netdev.
> 
> Yes, likely. So we can't defer the device removal to the state free
> functions, we always need to do that on state delete.

The only (not too complicated) solution I see so far is to
free the device early, along with the state delete function:

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 649bb739df0d..bfc71d2daa6a 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -721,6 +721,7 @@ int __xfrm_state_delete(struct xfrm_state *x)
 			sock_put(rcu_dereference_raw(x->encap_sk));
 
 		xfrm_dev_state_delete(x);
+		xfrm_dev_state_free(x);
 
 		/* All xfrm_state objects are created by xfrm_state_alloc.
 		 * The xfrm_state_alloc call gives a reference, and that

