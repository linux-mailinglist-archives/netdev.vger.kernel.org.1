Return-Path: <netdev+bounces-138286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB44B9ACD3C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AEA6B21C71
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE221501A;
	Wed, 23 Oct 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Q+FGRWxZ"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B42144C4
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693973; cv=none; b=trtlK7AXfo/IBRu01+9feypaEg2ty7Z+0uFXchFQKRJFELlZWtBkJayA1i13rZOAelcK3JR9v/GzspEMZLjExlifouOgqqaZLVldAZZTgvPkcALsjkJgydcusppJnluoVOG4Nx148gZXq0ZJ81s/tD8jF6Hun6ekDBGj2WqaQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693973; c=relaxed/simple;
	bh=t4GnTV7+otrBNu5mgY5qMt1NJdQynMz2/YOu1uyy2H8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU46cRZy1gWL+kTKPSY7IZf3j6kUQYlqoEr2WGLEly1xU6JHspAFn+jM6r25P506/OJ6GhCqjks7BHOLyRtc9oUZ/94HTl/0XaOY1dnaydl4/xoceoegBFx6EVcLmCQ+DIrfLhi8Kccabxa51jMFMiJrja/iNPaCXmYf948WmOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Q+FGRWxZ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E3D7520839;
	Wed, 23 Oct 2024 16:32:48 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gwmT-1RkaPvl; Wed, 23 Oct 2024 16:32:48 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 51D4620764;
	Wed, 23 Oct 2024 16:32:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 51D4620764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729693968;
	bh=bYgny7EnLLG2fS4yC5gQnBtp7uFZypu3STLIBvmOuq4=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=Q+FGRWxZLEmOLoCY9qbL9+KP7Bnfl3t2U9IU1moK5X7IBDT7/C9SiRtnaTpv352dU
	 5PLwhxfFNpNv/aUlySblF4RYpknzBKLSuglOHZVC9dLNjyDEmNLAjRe3o7zJmPSYDx
	 bl9Ej0DDifOaJZI+tAfVkCrPS4QzpHqa9M4HGb9/x2xkZw90dHsMrd9P/uPcL9RDxe
	 HzQYrl4VZ5PexK2hR+CjeLX8tIrkEslqQdAGyqTk3Ss0SUNczSHCqWmfa+XtT13feu
	 RKACz9FemJo4hm1/tw2i5jMWnlR1RYzDMbNP89jWCbDZMeWFppvz4wXrgglXGnv6WB
	 Mob/qO0gwhpxg==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 16:32:48 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 16:32:47 +0200
Date: Wed, 23 Oct 2024 16:32:44 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: Tobias Brunner <tobias@strongswan.org>, Antony Antony
	<antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters
	<paul@nohats.ca>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>, <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: Re: [PATCH v3 ipsec-next 0/4] Add support for RFC 9611 per cpu xfrm
 states.
Message-ID: <ZxkJDPwZ/Wk+WJXx@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <20241023105345.1376856-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241023105345.1376856-1-steffen.klassert@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi Steffen,

On Wed, Oct 23, 2024 at 12:53:41 +0200, Steffen Klassert wrote:
> This patchset implements the xfrm part of per cpu SAs as specified in
> RFC 9611.
> 
> Patch 1 adds the cpu as a lookup key and config option to to generate
> acquire messages for each cpu.
> 
> Patch 2 caches outbound states at the policy.
> 
> Patch 3 caches inbound states on a new percpu state cache.
> 
> Patch 4 restricts percpu SA attributes to specific netlink message types.
> 
> Please review and test.

Tested-by: Antony Antony <antony.antony@secunet.com>
 
Thanks,
-antony

