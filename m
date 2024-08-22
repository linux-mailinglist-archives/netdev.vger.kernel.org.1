Return-Path: <netdev+bounces-120827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E7195AE74
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19AA1F22BD1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 07:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3139A13A3FD;
	Thu, 22 Aug 2024 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="WrkAAWAK"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125523D0D5
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310727; cv=none; b=is5PwJX1uYHZviQZrkk60K+r1qrddrrBJOQnLipTd9wt1h/2gz/pBjpLlQzd6xTR1/psBkvNHFTtIf3qOfqb69LljIYwXQXtUnNFiS3PvJG47VC8Uffi1f2yncro1PVSEMNkAOeA7vLwlM+RJTVXrpIKRdzHOErjqYKRdiPmIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310727; c=relaxed/simple;
	bh=ZUT9n2tCrgnwDyaiRmRL6JxD5lDSzC5mes8MgC0rm28=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohzzsLgC5K2u1G5MWFiXv770oQPdtL9cbBwqPdh4EzIeuIsjJL6c+dx289zYFyfPn2AznnHn51uN19Rdj7adEu2eUgJO2f7rAMmWJ1Eo+L/YDgRzfxb9Vg4jUUFtJ1aD1wYckwZYM8pgmpN6lON8hKCuxZ8w5um4ax1CbZQypYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=WrkAAWAK; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3AAED208A4;
	Thu, 22 Aug 2024 09:12:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zV3JtRUdJUWd; Thu, 22 Aug 2024 09:12:02 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id ACAFC20839;
	Thu, 22 Aug 2024 09:12:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com ACAFC20839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724310722;
	bh=jS0gyMftp3E8tGiJofJI1jTi3jPfNXYyb05MOuU+S7M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=WrkAAWAKLLE7kFPRn0W6mLKlRiAhDJ0HLBMEyz67bLamQ89D/wf0IzPDS+FMb5Z0J
	 S7bPZsTM1LI6xSo6/iVCDP4S8s/Ue6pKQyBNyjp6HCgzU4/PLNHwpPVlJJSbASR/XN
	 S2IoPEevLFMOJlacLnLS9MPbC1TVsAvvggTm7Qlkg2Rqo1mxzbDutrereLmVO9xA0u
	 QjRy0UjPItv4OYBtu+yPeiRVQZZ6t/Du2712NJGsjxU4oZbl8zDKwDI8jBogAK9+Bh
	 wcM+hlm2zzBs8dMSj4OJPomOL3I0AXrnG6MX4geRsYR6C6inMXGz94pIm1TLgXg5m4
	 IjtsqfuIKqNRw==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 09:12:02 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 09:12:02 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 1E52F318194E; Thu, 22 Aug 2024 09:12:02 +0200 (CEST)
Date: Thu, 22 Aug 2024 09:12:02 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Hangbin Liu <liuhangbin@gmail.com>, <netdev@vger.kernel.org>, Jay Vosburgh
	<j.vosburgh@gmail.com>, "David S . Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Nikolay Aleksandrov <razor@blackwall.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Simon Horman
	<horms@kernel.org>
Subject: Re: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <ZsbkwnjEXOT+UbkS@gauss3.secunet.de>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
 <ZsXd8adxUtip773L@gauss3.secunet.de>
 <ZsXq6BAxdkVQmsID@Laptop-X1>
 <ZsXuJD4PEnakVA-W@hog>
 <ZsXzlQQjMNymDkhJ@gauss3.secunet.de>
 <ZsYh7mXwIRDFnI2m@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsYh7mXwIRDFnI2m@hog>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Aug 21, 2024 at 07:20:46PM +0200, Sabrina Dubroca wrote:
> 2024-08-21, 16:03:01 +0200, Steffen Klassert wrote:
> > 
> > Maybe I miss something, but how is the sequence number, replay window
> > etc. transfered from the old to the new active slave?
> 
> With crypto offload, the stack sees the headers so it manages to keep
> track and update its data, so it should have no problem feeding it
> back to the next driver?

Right, I was thinking about the packet offload case.


