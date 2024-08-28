Return-Path: <netdev+bounces-122682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEC29622CD
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FADB1C2446E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 08:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41311607B6;
	Wed, 28 Aug 2024 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="kIDMUdAu"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E915B12A
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835067; cv=none; b=bk5/BV7F0+12YA38vZUIBKcshuWx28oZ6teb7CqM4jYV9YOM5YXZAtUKlnbTj1vV1BiWovo6dM5UhpBGEZsssoeDPO+jQcWFX6EhzmPgDCPRNG9q1mmCacq8lQoJKvivq3JXIOdwYpNXN1fSS8xs/ARa0AlAFr2l0ejUiBAu7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835067; c=relaxed/simple;
	bh=nj0Nm7m3dxEMMkzCHY6O7PKbMmoTUUusSXq0mjQd4Xc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IigKUXgO0Lfo1Kh0d+ggjQRLHgMOLXq1Ftk2s5VMCEF9+8IcmvGXIlBLvkI0fTed6GViQ0mSV3w83GBk5H2o7WLBFapOqli+TdJvJk5jbjjnQzdZ05Uyp4IyulfJq/ukMHhbN6AfponJh5tSRga9/1njsbFq3xR/dbU/NkxAfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=kIDMUdAu; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 25B5320518;
	Wed, 28 Aug 2024 10:51:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fMpdiTI3p8q8; Wed, 28 Aug 2024 10:51:01 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A1D49201E5;
	Wed, 28 Aug 2024 10:51:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A1D49201E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724835061;
	bh=17N45y0cu1WOcHhT1BofAoWktpSH5WzHR/LqUMya9KM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=kIDMUdAurRAp3lt85odiXouNUZ4bMvDsjVdvext7pa+t/p8ScwlD+GOhauQ8ta9BL
	 t1uQ5JaPC3pEO3SfVhjNGkFp8mMBETXXJdjSrhbcuqdcB9xKXVTQboQAfm24XnORwN
	 D9DXz3PcqfdH2c7darwrTIqr6nT1SOWqL1BsjPpzVRoVISkjjWuQartXaaoxZ0rR+6
	 5qReol8Sx07gGLh98ELW79fcAbl1742OBKEuMcyaMa29z6D0HDDSc2X2qZ/5+p7oB1
	 juFMtpjj9hU8ahJq+csNWCw8Ncuidp6GBYnIuipfERRYJyOkYcR7NXvprNAP5uHdxe
	 nCQnjXV6Iccjw==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 10:51:01 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 10:51:01 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CC3783181C6C; Wed, 28 Aug 2024 10:51:00 +0200 (CEST)
Date: Wed, 28 Aug 2024 10:51:00 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next] xfrm: policy: use recently added helper in
 more places
Message-ID: <Zs7k9Fv3j1jrnik0@gauss3.secunet.de>
References: <20240827133736.19187-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827133736.19187-1-fw@strlen.de>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Aug 27, 2024 at 03:37:32PM +0200, Florian Westphal wrote:
> No logical change intended.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Applied, thanks Florian!

