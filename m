Return-Path: <netdev+bounces-104394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8711A90C650
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834D01C21C2E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EF713C90D;
	Tue, 18 Jun 2024 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="dYAjEBS6"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F8313AA48
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696834; cv=none; b=YrkTA9U1i/C/OLbnepVGgLgLm5Zigs+g8XN5PdaFJ+hY54FkPjxng7i/k2+cVSF0unJe+CGNT+GyIQzFWhtfGnbE3dCoX0CHkWjlZfqbwrszB9grX519ipH2z1tonWuhltHoP4y2zLrsTWZbusvJ5BqK7izIXozo4zoSM1lZGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696834; c=relaxed/simple;
	bh=GfPQsrzhGBXCCqxPtHTQ/XZdir/dxDvgfeRSyYVa7uE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQGSYP+uWTLI5QZEiJrAetCkeOdksoaU+/Oi7QN1s4T1Kd6t9I/AvpeWA+4YxicuumnGo/GcFUphnhOXOEzIW04x+1txzFTCjurhYkGXs2WH3iKQbfe+tMwBlTjcqHLBqiv8CtgPwKAPLhGEO5L3rqbKF7ziGEgWzF/3Je4upnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=dYAjEBS6; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 29D43201C7;
	Tue, 18 Jun 2024 09:47:10 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mSNOWXd3i4GH; Tue, 18 Jun 2024 09:47:09 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9EF84200BC;
	Tue, 18 Jun 2024 09:47:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9EF84200BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1718696829;
	bh=5ITvVJnYHm6536t0QuN4nBZB2a9C11m+Zg6KJ5YlC9A=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=dYAjEBS6lWfdHUVMj3EPquzen/lvgMCE30yo2ZSa6ryUDYAC/V7tmgnQWu+Noude5
	 d0gtya8RIDUZ6Bt7c7P63PTMXgsOm/mKSxZQ7rbo6uiuKt6lrTE0OJCq9fqQ+z/b5h
	 9TsvAr4Y6P6BSTjFdg5/YUpqf8Hm4irPxTgg8HW4u6Gca838cGozcOrf3oyoraFNQL
	 Q6X9oMfxO0W/KE3Q2RGY0Islq564aoKiSMo5Y16Vs1Ug+KrG+XRwYqnRLxuyUSf0rS
	 VzlC2f1XjSXH7xvFogfoxcEsVf7vvU9PYAd9auLLdxti8YNnfiONTZS1ms9thgMVK3
	 SPAo9LgVDHFmQ==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 9245C80004A;
	Tue, 18 Jun 2024 09:47:09 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 09:47:09 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 09:47:09 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id DD6253181A35; Tue, 18 Jun 2024 09:47:08 +0200 (CEST)
Date: Tue, 18 Jun 2024 09:47:08 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca
	<sd@queasysnail.net>
Subject: Re: [PATCH ipsec 2/2] xfrm: Log input direction mismatch error in
 one place
Message-ID: <ZnE7fHBHVknB7KH+@gauss3.secunet.de>
References: <f8b541f7b9d361b951ae007e2d769f25cc9a9cdd.1718087437.git.antony.antony@secunet.com>
 <50e4e7fd0b978aaa4721f022a3d5737c377c8375.1718087437.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <50e4e7fd0b978aaa4721f022a3d5737c377c8375.1718087437.git.antony.antony@secunet.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Jun 11, 2024 at 08:32:15AM +0200, Antony Antony wrote:
> Previously, the offload data path decrypted the packet before checking
> the direction, leading to error logging and packet dropping. However,
> dropped packets wouldn't be visible in tcpdump or audit log.
> 
> With this fix, the offload path, upon noticing SA direction mismatch,
> will pass the packet to the stack without decrypting it. The L3 layer
> will then log the error, audit, and drop ESP without decrypting or
> decapsulating it.
> 
> This also ensures that the slow path records the error and audit log,
> making dropped packets visible in tcpdump.
> 
> Fixes: 304b44f0d5a4 ("xfrm: Add dir validation to "in" data path lookup")
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

Also applied, thanks a lot!

