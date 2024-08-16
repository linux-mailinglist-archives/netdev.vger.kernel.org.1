Return-Path: <netdev+bounces-119144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C110954554
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4B92848C7
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4649F13F45F;
	Fri, 16 Aug 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="nXYkXUnr"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011313DDDF
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800189; cv=none; b=pLF/d7W4PpT2E1jkSePYm1ZTkp18HX3gzkr/yb476zmrA2IaNEu59sPIZW6CAhW/9Zw4zufnAWSwHBTzRR+iFBTy5KAHAHCOyWiACysfIaxn5WF+LZXzOJpPkQoFQ78EkI9wlcB5LluXdR7VARUkaMEecaN3D+Xrzmc7ENrNi7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800189; c=relaxed/simple;
	bh=/QtbL5p10N3atTDugjuDqnasjNYPPCX0+IyGaZVfUFM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/mfXfWOHbFVpEMndxRPx+RbbczSIZ4i+A31ZHbUrktf3kE/pUy0mItiWa8BJhJ13N7xw6+k5ajoSuOx0Z5l6uCF7gEhfWVxKMBLGHEGGol8+NC8YE7rnRsWw0Lr5zsKAfZLiuZel2vytDkZDsfIoe6nujRhH3DrJQDAgvG28Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=nXYkXUnr; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6714C208BF;
	Fri, 16 Aug 2024 11:22:58 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j2hORlM_Frye; Fri, 16 Aug 2024 11:22:58 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id DF8FE208BE;
	Fri, 16 Aug 2024 11:22:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com DF8FE208BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1723800177;
	bh=BZCFX3mcsyni/+AvAIgVlREuXTTD5ZEFly4IWwYiydU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=nXYkXUnr6WFMA3LSi7uFrPvFYUIY2NikO88AX9pQYs0ICuKhAfDRKKRZpShEXeAEf
	 O+eEgyfkl8c5C2OKw4fb6MD6D1YLlbCACoq5bbDb20JZdfwD/MaaE5GA5Hos4yWMUR
	 NUtYrlqswPhzfBm4sveIK5bDJbjLEyp6hOnJtKeey1gz1ONlcUDC52kyOoXt42i4UD
	 MOoAUdNJwieb9TTlT+mcHqXYHTTa285y8jaFvQy9+TIswQ7Yrog6OLWw3dWD1HRQQQ
	 WJzvBePfJ/FuUVXIxxP9zeb0g0wKu3DJSm2Ymgv1YIvN+ozMmmbAL3MhFOk3QznCm9
	 T3FoM4sQirQRw==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 11:22:57 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 11:22:57 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4432031830C1; Fri, 16 Aug 2024 11:22:57 +0200 (CEST)
Date: Fri, 16 Aug 2024 11:22:57 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH xfrm-next] xfrm: Remove documentation WARN_ON to limit
 return values for offloaded SA
Message-ID: <Zr8accEhmBXmaJ87@gauss3.secunet.de>
References: <e81448c34721aaf49faa904a5ffc2a18b598b3d0.1723366546.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e81448c34721aaf49faa904a5ffc2a18b598b3d0.1723366546.git.leon@kernel.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sun, Aug 11, 2024 at 11:56:42AM +0300, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> The original idea to put WARN_ON() on return value from driver code was
> to make sure that packet offload doesn't have silent fallback to
> SW implementation, like crypto offload has.
> 
> In reality, this is not needed as all *swan implementations followed
> this request and used explicit configuration style to make sure that
> "users will get what they ask".
> So instead of forcing drivers to make sure that even their internal flows
> don't return -EOPNOTSUPP, let's remove this WARN_ON.
> 
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied, thanks a lot!

