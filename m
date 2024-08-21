Return-Path: <netdev+bounces-120528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006AD959B62
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD231C227E9
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B79118C91C;
	Wed, 21 Aug 2024 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Q4WKeo3Y"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE163194132;
	Wed, 21 Aug 2024 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242316; cv=none; b=i0kC7CsvAIJBkmVoWcs/EqzhMlJZtOB8tJvnmMA8WQeFOLsutTUOVgh7Ueg2Cny4yBaldbsh6S5TdC2+MqDCgJ5HQ7hNYNkxrk5udhOVKOy4XDeaNgBJAMFzKIlocvPYNTc2u/UeMVc/m+M4vyUp35pQO5kgbDXT2ad0+u67t+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242316; c=relaxed/simple;
	bh=VGrdUEkad8qO+vx0xM73GBD6TAPmKXUCSF9UNO6ARvA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apoyfhtm0jaAhyQ/OdySQWfKuScYof7LmZgAl49m0zO10ExucvW8WsWbzFoDuf6LhfG6i9brcB9uxeeyaRuObLZwj/hvjQH2ebysHsrCZzbUAYpl5bx6uIUemqrEe5tQ0UuWAVWxLgbcuc+dBix/slvny2hqk+3d1pm79JkiRT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Q4WKeo3Y; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E46FB20885;
	Wed, 21 Aug 2024 14:11:51 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Z_kmXl1CduB; Wed, 21 Aug 2024 14:11:51 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6171D20882;
	Wed, 21 Aug 2024 14:11:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6171D20882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724242311;
	bh=Y2E53z5d6OXDLx7GF8DxMND5HSZ0ffWoicxxBA/1P6A=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Q4WKeo3YSt/5bzgh8woLvdToMyAVZiBxnXaejNUaf3+E7FPcCm6fhZfxm268m3Rco
	 rQMcg5hzYJkRApMdwb8dwClxGS6DiSSsLrptSPCM4rF+vRC3Kv5i5Q7zUa7rBe0WTL
	 iRMntx1x02QvWbqRvcrivjxp4rVX8mfHe1gCZZv05Au6K1TaZeOebuanRNbgL0EQAj
	 bOrxovsu6Zq4DEbkWsbg+Sx+sLZLk3B5mqwDh+tn7C30aJq6ALARj08nBbM2Aj8zi3
	 KpHJ8kJLIC9pHB5Pi5SA6rpyGosXSEwdA1fZvfn92L+jbjJrbSZQCOXEO2uuouCf3V
	 X8ulB8CJhqITA==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 14:11:51 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 14:11:50 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 74B1F3183CDE; Wed, 21 Aug 2024 14:11:50 +0200 (CEST)
Date: Wed, 21 Aug 2024 14:11:50 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Yang Ruibin <11162571@vivo.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] net:xfrm:use IS_ERR() with
 __xfrm_policy_eval_candidates()
Message-ID: <ZsXZhmSZ1ioCtgoY@gauss3.secunet.de>
References: <20240821113808.6744-1-11162571@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240821113808.6744-1-11162571@vivo.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Aug 21, 2024 at 07:38:06AM -0400, Yang Ruibin wrote:
> __xfrm_policy_eval_candidates() function maybe returns
> error pointers,So use IS_ERR() to check it.
> 
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>  net/xfrm/xfrm_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index c56c61b0c12e..2e412a48b981 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -2156,7 +2156,7 @@ xfrm_policy_eval_candidates(struct xfrm_pol_inexact_candidates *cand,
>  		tmp = __xfrm_policy_eval_candidates(cand->res[i],
>  						    prefer,
>  						    fl, type, family, if_id);
> -		if (!tmp)
> +		if (IS_ERR(tmp))
>  			continue;

This looks wrong. The error case is already handled below.

>  		if (IS_ERR(tmp))
> -- 
> 2.34.1

