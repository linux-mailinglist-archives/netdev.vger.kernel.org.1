Return-Path: <netdev+bounces-121639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F6895DCC0
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 09:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D881C21796
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 07:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC851547F3;
	Sat, 24 Aug 2024 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="qSSxB34U"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6859257D
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724486075; cv=none; b=t3fkQQY0XX3SKKbs8yDsm+83xWPOmv1q1TyZH2LQ598v7BIi1AuzhMYdeU74fQAZ0GtuDgBdl0qZpjsg0haDQ/xmlV9JiTs3CcL5TU+KSkLXX9XCij9mSsC8EQknyZ/m+l2fPw6O79u+HDflW7R2CZWOCfm4te+utqZ6JcSmCyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724486075; c=relaxed/simple;
	bh=C3tSvrtxAKGxA+nryF/nRBCnD3WeWbEro7/gwQiYeoI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odThe51UwXvkuBUW7A+Vf78B6jxWWlI0GRqTnpnkvSXPiQ7Ej6wDv0aBWNGwTCg2Wu4nrWqZJ1FLGWYxw5c4u+YEHMpsH+zyWO2L9+2EZjsCVLumClyh5AC1fL0uwSS6txAYVhGAC19RObULg7ZxXy+i5N8/UvSN+goczun/bJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=qSSxB34U; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A071A207F4;
	Sat, 24 Aug 2024 09:54:30 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f45vs5dhCzey; Sat, 24 Aug 2024 09:54:30 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 2EA1B2074F;
	Sat, 24 Aug 2024 09:54:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2EA1B2074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724486070;
	bh=P2og+YU9Wvg1ro3qMAawafPqDioZpuX2eAjW2rAisOo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=qSSxB34UilVo9K2Q0Rs0r91KTbbvICHO2KHPdK4l0q7Xk1150GuIM3TywZVzwQ4Tm
	 Z6MvkYLGGBqXMp88oWwL7DtrPoKpyTYbujbVVkqCUs3GmDTEjdBptCeT8Q/gRoI+IR
	 Ogmz9KxddMggzqYsLE9i61qn4iAeai7voauCshL1kYxTasqcJiOGumEfKPzPYlaKRJ
	 q5YHC+BG1glqhzeRnex8gmrk+wtNbGbZAckAzuostOcILf7YowgJd4vNCPO8ryMpw2
	 IgAswzSUakU+vcR8FgcjC7NbwD9LQYB2QPP8/bk4O7Ts7hbVcfZv43rZYJEExiVeOD
	 bSxUjbeXq6cWg==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 24 Aug 2024 09:54:29 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 24 Aug
 2024 09:54:29 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2F85D3182A7D; Sat, 24 Aug 2024 09:54:29 +0200 (CEST)
Date: Sat, 24 Aug 2024 09:54:29 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Simon Horman <horms@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec-next] xfrm: Correct spelling in xfrm.h
Message-ID: <ZsmRtRLE+WxKM7N2@gauss3.secunet.de>
References: <20240821-xfrm-spell-v1-1-b97e181f419d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240821-xfrm-spell-v1-1-b97e181f419d@kernel.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Aug 21, 2024 at 04:30:13PM +0100, Simon Horman wrote:
> Correct spelling in xfrm.h.
> As reported by codespell.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Applied, thanks Simon!

