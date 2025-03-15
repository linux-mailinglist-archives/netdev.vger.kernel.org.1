Return-Path: <netdev+bounces-175008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1261EA6258D
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 04:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C00219C2A1A
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 03:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7A136124;
	Sat, 15 Mar 2025 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="sGgnymAt"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51E63D
	for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 03:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742010356; cv=none; b=L81OGjtJb6c8gmW02XpoSkwn5pZD/au4k5MHQc7nie3B+nNg8cstdbr8qeOOLGTHYuoWiq21OzXaaalFC8Ijxf/t9JEhgG77sgNiFzKmstDFRVGlK4gmnmKmWP+1pM0bC2bTtvVKK/utBvHudoF/G8TN70H0xtgrlRE9RGvm2Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742010356; c=relaxed/simple;
	bh=xR9DLthUbUtQ6n9wACOPaljewJcPTlfCXOzmbX5jMow=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8wovNzxwPm3iRNqdrfLhgKj1gCW5a5TRlqhyMgMCGLOvHIrCc2HQPHtuhCXMNyfLtwYQRy92H8uGbSo+L8943GhPDu83gJYvdgA3OL2poP+oMnH2FLL4Hs/9VSoh+u/40AEDj67MdhXk7AvCFOfm+EhbAcbGqaCiTuSF/A4ros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=sGgnymAt; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2B49D20748;
	Sat, 15 Mar 2025 04:45:51 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mwQg8bhnZZEC; Sat, 15 Mar 2025 04:45:50 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9D13920189;
	Sat, 15 Mar 2025 04:45:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9D13920189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742010350;
	bh=UaxR87bpnh4hLKAKlMeR3+1dFbLuWJM5XgbiRrePEiw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=sGgnymAtqHVtW2qo4QlJrvo17Pj6A5V2z/414WLaxYxYKPtcyUY/0FTAkKVKTyDmr
	 o1iy1ai0HC9w1fscPPIqef2fDAaY4IsvM4sLSytXiWczHn5KY8JlmCcYnLc8+R6nMI
	 c6W/CXAcowsbl2bgnKLp6HOde6Q4+SZrdxu1aTkuFphDgx6n5wY7gdF3dR2y2ybZaG
	 cDlzfRRgQxPMY98khhCq7CUkgkJ06G8+qLJilb9RHhLN6GoxUtUD86z5+qjPv18jcI
	 4yF+ILbFaQx8eKEjyanemHIwu3tIGKa9Il1k/bqTnk/GDdt8X0Z6ad47mepsb81xmU
	 XsYrDKd97oxXQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 15 Mar 2025 04:45:50 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 15 Mar
 2025 04:45:50 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id DFB433183D47; Sat, 15 Mar 2025 04:45:49 +0100 (CET)
Date: Sat, 15 Mar 2025 04:45:49 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>
Subject: Re: [PATCH ipsec-next] xfrm: state: make xfrm_state_lookup_byaddr
 lockless
Message-ID: <Z9T37SEkcgN/3U9L@gauss3.secunet.de>
References: <20250307114802.9045-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250307114802.9045-1-fw@strlen.de>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 07, 2025 at 12:47:54PM +0100, Florian Westphal wrote:
> This appears to be an oversight back when the state lookup
> was converted to RCU, I see no reason why we need to hold the
> state lock here.
> 
> __xfrm_state_lookup_byaddr already uses xfrm_state_hold_rcu
> helper to obtain a reference, so just replace the state
> lock with rcu.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Applied, thanks Florian!

