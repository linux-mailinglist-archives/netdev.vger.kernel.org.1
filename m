Return-Path: <netdev+bounces-93002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 657228B9998
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 13:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0419B22201
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DE95FBB7;
	Thu,  2 May 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GuUHJE+x"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E94E5EE78
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647743; cv=none; b=pjTVL/0F8lz4jz8pEFeGXYte4XKnmxkLbJegrVHyJ8aJifzRnbHV8/L+9/arIgpEBji7D+oVspxM5/P/w2ok0zS/AbFbdx2hqJjpdEBh0o2+wlE5Dk5/rJ0KrJbJAzmh3/026h8sJLopLRVfq0h6dOw+/nAPXzOSvaQdXWs4yU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647743; c=relaxed/simple;
	bh=WjKKxg91sicVt/c3J8YItgH8LNilkFiIzFDH4F1itOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa7qpzDSe+fpTSPIoUui2vlkFEwGKo3u5mxz073o+iA+YBuNKHhvo5EtGBQOxmdsR/YEbSXH3OQ2Z3jW9UVe66BF/cu70HVCqiSUQN+w/Bu0QHohYV3RD38jJHmwrGtISQUiGhAcmWal1RcerSCZ5dYHDYmrWiqerzSOM3Ae9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GuUHJE+x; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id AA1C1207CA;
	Thu,  2 May 2024 13:02:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zMVFOeEp731m; Thu,  2 May 2024 13:02:12 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id CFC5A206B0;
	Thu,  2 May 2024 13:02:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com CFC5A206B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714647732;
	bh=EQsQLHg5ZsPxcQdz0AiPwq4Y1l0DQUXvvPjZvx8k4MI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=GuUHJE+xQqCY27UsX+nHXot+fvsHoEJ5MxNG8wBrUbTDAAbqAm4Zak1f/cGptYxy7
	 M70NyyFzm+TsPDJ3LaNC0vAgftRZM5sEWKJQpff/ZkPnMwoBefxkINe4dMm8Skzmr3
	 iujaVtH8VDuMBhnJZYpO4yrMSvQqJj7juEcGxEI+gQj4uuzY4L79ER7lqwdPO7MRTY
	 CVOiyDodWGc0O2kPKze9LIkzZFkyHcQ42JvT1y/0RpsoxCfnX694hkc/ZY2lY2GBeh
	 sa2RYrRbH+/pznLyg85X8Mpuy3u4E7Zwwfdca5YJnVwwx/do6n6MrQN/td1BoN5Djl
	 DxUTLONXGu80w==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id C20A880004A;
	Thu,  2 May 2024 13:02:12 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 2 May 2024 13:02:12 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 May
 2024 13:02:12 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id E7470318406D; Thu,  2 May 2024 13:02:11 +0200 (CEST)
Date: Thu, 2 May 2024 13:02:11 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/3] pull request (net): ipsec 2024-05-02
Message-ID: <ZjNys2taG8NXTsJa@gauss3.secunet.de>
References: <20240502084838.2269355-1-steffen.klassert@secunet.com>
 <eb382c9e23b169250079ef96ec94de77918a6a0c.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eb382c9e23b169250079ef96ec94de77918a6a0c.camel@redhat.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, May 02, 2024 at 12:53:43PM +0200, Paolo Abeni wrote:
> On Thu, 2024-05-02 at 10:48 +0200, Steffen Klassert wrote:
> > 1) Fix an error pointer dereference in xfrm_in_fwd_icmp.
> >    From Antony Antony.
> > 
> > 2) Preserve vlan tags for ESP transport mode software GRO.
> >    From Paul Davey.
> > 
> > 3) Fix a spelling mistake in an uapi xfrm.h comment.
> >    From Anotny Antony.
> > 
> > Please pull or let me know if there are problems.
> 
> This landed in my inbox after I almost finalized today's net PR, so
> these fixes will not enter it, they will reach Liuns' tree next week.
> 
> I hope it's not a big deal.

I'm OK with that.

Thanks!

