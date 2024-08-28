Return-Path: <netdev+bounces-122606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788F8961E3C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 07:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336AE285841
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 05:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781D714265F;
	Wed, 28 Aug 2024 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="LsIOR8RT"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BDA145A11
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724823174; cv=none; b=fMzZBcP+uZEC+ctaZkPlo4w+glW4QQk2HECXl5ThCOS43Avri70N/N2IzFsmxYBms/nk7UYyEn0SW/nOPASV4GwjuAb292TIVU0f09din1iATFlXbGGedAu2lEXmY6SlCIAMHtfzbHyxeer6Y1iWVt9LjlABBK1XFOsW1S4kuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724823174; c=relaxed/simple;
	bh=Nu7NezANGDRbBc8NOcSSXxU8EpanJ9iT0P8tD4+4Uyk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlFSu0hmO4onhFHblx8Ec+RTvsRp+38V1u2t1Rz2Ku5mxYq333sn0Tgxd9v22wcgTA7hCY1hczXKbG9/VXZMzGa1Mx074estmh1177oy863nMCzDA6EAtkaPD88woF0a4WktD4T5ycvpt+upqWKZ3vPRhQ8DDOw+DopYu6v71cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=LsIOR8RT; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id ACDE3207D8;
	Wed, 28 Aug 2024 07:32:48 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3TJm8gT20p-4; Wed, 28 Aug 2024 07:32:48 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 314CB207D1;
	Wed, 28 Aug 2024 07:32:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 314CB207D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724823168;
	bh=K7hxHqFNbhJZvyiFVLAlJ/z2SwlRa+qHrrpglYRXCHY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=LsIOR8RTXK4VNi3KhW0EotM38AOlciqLHUJ2GPbxPMAb3W4YQ8NjpHEoeBGVoswvR
	 buOWfTsWVX14gJldl1xng+O/FALG2NiIf8aa7xzYGEx5wKyB8IlCGcgstkOHQrKMeM
	 +ymktTMt1kth2fgkpZz+1CTfepe2gGRTbf9bqw/q0Bk2YKm7WtSVu2AT5+4UN3SYGr
	 tNaeX0Ve79DCgpDcGzt93+ZughOCK71ylEnDxigiknrFqASr/RH32/qWVyzcdvfUy6
	 lDHV+aiSmQsScMixvXI/uYNUlgZUSLcRyfQdg2YoboIPE+jwnv47Z0mHpwC31xAK++
	 TKTgU+TPlZCuA==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 07:32:48 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 07:32:47 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8D0083182EE8; Wed, 28 Aug 2024 07:32:47 +0200 (CEST)
Date: Wed, 28 Aug 2024 07:32:47 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Feng Wang <wangfe@google.com>
CC: <netdev@vger.kernel.org>, <antony.antony@secunet.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
References: <20240822200252.472298-1-wangfe@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240822200252.472298-1-wangfe@google.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Aug 22, 2024 at 01:02:52PM -0700, Feng Wang wrote:
> From: wangfe <wangfe@google.com>
> 
> In packet offload mode, append Security Association (SA) information
> to each packet, replicating the crypto offload implementation.
> The XFRM_XMIT flag is set to enable packet to be returned immediately
> from the validate_xmit_xfrm function, thus aligning with the existing
> code path for packet offload mode.
> 
> This SA info helps HW offload match packets to their correct security
> policies. The XFRM interface ID is included, which is crucial in setups
> with multiple XFRM interfaces where source/destination addresses alone
> can't pinpoint the right policy.
> 
> Signed-off-by: wangfe <wangfe@google.com>

Applied to ipsec-next, thanks Feng!

