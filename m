Return-Path: <netdev+bounces-200992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E0FAE7ADD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA693BB928
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D741FBE9B;
	Wed, 25 Jun 2025 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="JNtKJEdC"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D2CF50F
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841527; cv=none; b=f9WY8GnTToPnlPj89jMWWAL3rZ8kiW+4zBlXdPpE/4sav6FqMcVJWR8ObRPqADrmbpp4iVkLLf6e7Nlz/vhYjIuATiy3SCo6gvaimikz6YQzzzb8W6Z5qQf93+Hd1qp9uBW2BmEk/OO9E+FNaDAO1B7q9NvJpdfODIT24k3Cksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841527; c=relaxed/simple;
	bh=MsETDloGVDttHp5uHGQyRS8HrnQSQC22f1zt5C/VKjE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeSCqi4Lj0A9eWTg1szaGW5fDDp2WhCtli9oP6bgMQRhS79TLjg+AD4bzQ6v5KGW3KWaZ52rMp+ZKxqW/52wwOJMN3YPWI+UbsyiJKrQLLb2PMt5QL5gg5G38oIvwlXQ7TZzMRbWBYF/MG9oV9erhJ0cUdBqK4Q+XlG10J6yIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=JNtKJEdC; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id BC00E20684;
	Wed, 25 Jun 2025 10:52:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3R2qJ22Mwqp8; Wed, 25 Jun 2025 10:52:02 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 36D7C2067A;
	Wed, 25 Jun 2025 10:52:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 36D7C2067A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1750841522;
	bh=Hr1A6uqz85fpEwaS9n1LbuLo4HQ71fLZ2uwOfPTw9fY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=JNtKJEdCVdAdvFS/P/1Eh8z0S/FUZ7luSglHRIGv2PRxPWk/6gXQ0uAcoqs4JWKI2
	 OJC5lQYjrtf0+/4WhnUm8jCdS1frsTg09aaPuKq0TvAMeFrzSWXkVplLaVSyPArq/V
	 aEaR4Aw8DSK4PsKlG7q+S77wMVjp3U3Nr+2DIyLZ584T4oxwAGDF7C2VPq1H9soQji
	 VDltisClKVmejCjwU9iOjo/2UhTxYcWdk68/a9yt+rSmxff383C6tVjHBQJGynllzH
	 /2V2lmSr7S20Z4K68OeJe1W5XSZ4KNsmkoAtnjO2q0NRv8uSNse1/HhKtQZN180vUJ
	 2X8t4sXeX6QCw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Jun 2025 10:52:02 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 10:52:01 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 3D97E3183D9D; Wed, 25 Jun 2025 10:52:01 +0200 (CEST)
Date: Wed, 25 Jun 2025 10:52:01 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	"Cosmin Ratiu" <cratiu@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V2] xfrm: hold device only for the asynchronous
 decryption
Message-ID: <aFu4sUO4+K/tyGxf@gauss3.secunet.de>
References: <20250619094852.6124-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619094852.6124-1-jianbol@nvidia.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Jun 19, 2025 at 12:48:51PM +0300, Jianbo Liu wrote:
> The dev_hold() on skb->dev during packet reception was originally
> added to prevent the device from being released prematurely during
> asynchronous decryption operations.
> 
> As current hardware can offload decryption, this asynchronous path is
> not always utilized. This often results in a pattern of dev_hold()
> immediately followed by dev_put() for each packet, creating
> unnecessary reference counting overhead detrimental to performance.
> 
> This patch optimizes this by skipping the dev_hold() and subsequent
> dev_put() when asynchronous decryption is not being performed.
> 
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Applied ,thanks a lot!

