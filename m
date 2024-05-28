Return-Path: <netdev+bounces-98451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AED18D176A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90661F22EF2
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B2D169AC9;
	Tue, 28 May 2024 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="khd+Z87Y"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1971743
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889349; cv=none; b=c9CJG8AWIUhxVYwt0Fa44nGIT/SmHOb2n3Gpmxgb9C6mBEGDP9DbNy0GGix2IVAIqu6ULp97Goo1pCJEpO2QD9mqy88sy9aFkrZ+aVZqCnbKb5tDnU+IU11cNLURg5WTTt50Ox0w5kC6hR0SXAzqMrMoYkQkOQyRFCiIJXzKgHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889349; c=relaxed/simple;
	bh=rklg0VpYGXa5hilOm5ay54u8TILlyaofG6/kGsXWZRU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ht+zKSnX5TGQxebGuv3OHTxjtoaMCDa+eb5Z9XprNVqR29zn887JuBu4kPjUDI+0EYJ8txtK8OFrBcH3Ff792f7glpPukAVAXnaTGB0zYiXBMfUXpe1qBunzujMXf0YV7hJZLHHrKvdAARsn3V4W5lKdwSN9sVzsIPzQHj6bD3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=khd+Z87Y; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id EF891204EF;
	Tue, 28 May 2024 11:42:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l6z2LOMpRxkk; Tue, 28 May 2024 11:42:24 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 22E59201D5;
	Tue, 28 May 2024 11:42:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 22E59201D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1716889344;
	bh=9SgkN5CwOEOC1cd5f2ghQj5AGQmGsAeNanb+JYbVegI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=khd+Z87YuJ8pQSAv+9vtqXZPBccAiqFKWCw3KShZkBTksXfh1IgNyBz3U4u0VAA7c
	 DYtAO2NQ+lxpUqXpeTVKpaJi6okvW6NEehRm29T4yd2BpPA13ADPPF+68aUexhj3Q3
	 7XBqCK861BBT/URSEzQj1MSv3Se1c/pCDAFty+6bKBgEXvsNHvEHdqpYtzHVimDRwG
	 Ryq5m3LDdIHJzxWpEwcCAbRHwwF/5iHhCj022Zzrhp6TAetLjch8VzeHoIVH5ox5c7
	 VdIHeG25O9cjFsS2JHGadn90U06BtBB0SOWNOk+bOQtwmBJtj4igI8mGj916up+pk2
	 MiNXLOgE9vUgw==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 15EE280004A;
	Tue, 28 May 2024 11:42:24 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 11:42:23 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 May
 2024 11:42:23 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id D1502318020D; Tue, 28 May 2024 11:42:22 +0200 (CEST)
Date: Tue, 28 May 2024 11:42:22 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paul Wouters <paul@nohats.ca>
CC: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>, <borisp@nvidia.com>,
	<gal@nvidia.com>, <cratiu@nvidia.com>, <rrameshbabu@nvidia.com>,
	<tariqt@nvidia.com>
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP connections
Message-ID: <ZlWm/rt2OGfOCiZR@gauss3.secunet.de>
References: <1da873f4-7d9b-1bb3-0c44-0c04923bf3ab@nohats.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1da873f4-7d9b-1bb3-0c44-0c04923bf3ab@nohats.ca>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, May 22, 2024 at 08:56:02AM -0400, Paul Wouters wrote:
> Jakub Kicinski wrote:
> 
> > Add support for PSP encryption of TCP connections.
> > 
> > PSP is a protocol out of Google:
> > https://github.com/google/psp/blob/main/doc/PSP_Arch_Spec.pdf
> > which shares some similarities with IPsec. I added some more info
> > in the first patch so I'll keep it short here.
> 
> Speaking as an IETF contributor, I am little surprised here. I know
> the google people reached out at IETF and were told their stuff is
> so similar to IPsec, maybe they should talk to the IPsecME Working
> Group. There, I believe Steffen Klassert started working on supporting
> the PSP features requested using updates to the ESP/WESP IPsec protocol,
> such as support for encryption offset to reveal protocol/ports for
> routing encrypted traffic.

This was somewhat semipublic information, so I did not talk about
it on the lists yet. Today we published the draft, it can be found here:

https://datatracker.ietf.org/doc/draft-klassert-ipsecme-wespv2/

Please note that the packet format specification is portable to other
protocol use cases, such as PSP. It uses IKEv2 as a negotiation
protocol and does not define any key derivation etc. as PSP does.
But it can be also used with other protocols for key negotiation
and key derivation.


