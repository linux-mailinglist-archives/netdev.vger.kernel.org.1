Return-Path: <netdev+bounces-129591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839DF984AB5
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 20:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4580D2842C8
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270571ABECA;
	Tue, 24 Sep 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Udwk5IsO"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C51E49B
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201448; cv=none; b=OgA6peNB5Ep/zH8ac/kg0P/KIg8wXPzgxMctu30ZU8om6vHbVMLr2JOseSsh1BwT67dzTLfVIUtwQuBGmOiAUpcvNxq0pNoqA+kNWV5Cng/B15sjzHJHIHkDjE8COUDv5bLfXE5b8fSINeCnAZgWWEXegFZdjrTKTB9ZZ9TrDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201448; c=relaxed/simple;
	bh=grgEj4pMbxb3FB3EF7feAPwZoN8K1QWiO4SVLJwyW/A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXtsXjJb6xMpbHxDeIJbTRT/QuRtPjlaUsoHRaR4UMvX1Lnr3kD4F7ta7nvx/s1bCzxHH07GxPBJfY5PhrLL0TCycunyxqfZIBII+/M5Fl1ujrq98TCxFQdhMRG3+deykdhdtEAvbvfgu8jPadtTmjA3Hsr8K9SHdrpotUuKDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Udwk5IsO; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 27D7B207CA;
	Tue, 24 Sep 2024 20:10:43 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3xyTZmeLqH9s; Tue, 24 Sep 2024 20:10:42 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A9813205CD;
	Tue, 24 Sep 2024 20:10:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A9813205CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1727201442;
	bh=DueBgiaJI0AHIBRqHZuaYZJ/uzr66v7uJmNDorNcK9E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Udwk5IsOLLOf1mjJX2oI0wEMZS3yJ2l4tsAhF+FrPLU3ll5MVo2f4wtwF73Xt6S4A
	 cnMrcWCBcRhw+QaqkMjeo14Q6IM39K7583DglHNp20OTe7Q5HsD25HKBTlWgxYZM/y
	 GQYh0SZDZvxW7i3Xr9MFJNe6Kp9kcAKn62WUA8QhYt5u1Ai3Uk+GNzh8uYiPzuQr/5
	 32nfT3VpZNo++nPxEDQoCEQR6DxlqpdA9aQkpB3BJd0gxt/I3IyI9cYHZ+XoKm4dGd
	 1YYgOgpWq78avIRFdsHhLnU34qgv9oDB/jgs7zOIp9FpoGyrjJboslL1cqbncjIn07
	 FUgTeyU5tN8iA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 20:10:42 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 20:10:41 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 677543182E51; Tue, 24 Sep 2024 20:10:41 +0200 (CEST)
Date: Tue, 24 Sep 2024 20:10:41 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Feng Wang <wangfe@google.com>
CC: Leon Romanovsky <leon@kernel.org>, <netdev@vger.kernel.org>,
	<antony.antony@secunet.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <ZvMAof2+5JET6JRA@gauss3.secunet.de>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal>
 <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal>
 <Zt67MfyiRQrYTLHC@gauss3.secunet.de>
 <20240911104040.GG4026@unreal>
 <ZvKVuBTkh2dts8Qy@gauss3.secunet.de>
 <CADsK2K9aHkouKK4btdEMmPGkwOEZTNmd7OPHvYQErd+3NViDnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CADsK2K9aHkouKK4btdEMmPGkwOEZTNmd7OPHvYQErd+3NViDnQ@mail.gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Please don't top post!

On Tue, Sep 24, 2024 at 10:57:12AM -0700, Feng Wang wrote:
> Hi Steffen,
> 
> The easiest thing would be to upstream your driver, that is the
> prefered way and would just end this discussion.
> 
> I will try to upstream the xfrm interface id handling code to
> netdevsim, thus it will have an in-driver implementation.

Netdevsim is just the second best option and still might
lead to discussion.

Upstream the google driver that actually uses it, this _is_
the prefered way.


