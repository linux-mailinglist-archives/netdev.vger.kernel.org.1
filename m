Return-Path: <netdev+bounces-245285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E953CCAA8A
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 08:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8017300E460
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 07:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD433A1E6E;
	Thu, 18 Dec 2025 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="EAtMlr9P"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FA2E6CA5
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043115; cv=none; b=Kn7/X+7XKsZVJ3jyNEMU0G/A35AB/Lz6yQf7mTnxOKBo5XTKn86hWzQHEzvFt4wXswDw5r7ymgnDRyMWbvgJwQitLNUNOAa3aklWGaosHksBYX7tpasv8ApVEicaPTRA+qt80bimKcM74tWluKqI0ImrGfTBeIOFPa4mZeIt5ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043115; c=relaxed/simple;
	bh=P3xOZztjVf8ZXw8YaJt/V+pdbnbPrA4fmwUXsXWt0ps=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOjIYiINUyvoPvqc6ONSSsUVIiAdVNI+wIzaeCbmit0eDHpxTSsy3pcve0W6kaZr56oHYnH5dZNnxApKLpjdvU+UtG74TpNgaNzJYhpovi+DnBJeLKH0QaN9OK3OXW4qx5zUvQ14RK1Dl4d7lSCpU0ULBam6U5gMI2mWXMJfnHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=EAtMlr9P; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 11346208F4;
	Thu, 18 Dec 2025 08:26:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dTQOemcCUgJR; Thu, 18 Dec 2025 08:26:17 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4FCDF208D2;
	Thu, 18 Dec 2025 08:26:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4FCDF208D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1766042777;
	bh=mdl9XqVZ+SXg6bxScI11Uz1xj/Kyscbx5wo8Ayqu3h8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=EAtMlr9PqySzeNVCPq+CCZ5YeyxsBoUJfVWZvwfPAbJAzjqyjWAeW0a/HLpXi2QuH
	 pRxk+Ac2mnVC7PCLWmK4fHKkWSn+JTF7ULun97ULWAg/nSh3nHZ6gScshDNHl2ZPm7
	 /7Rqs+BVblIl0WsUfKBBBCyrhk14ui6RFa4JH/iJpZnDjN/GIOASCp90tsnFWcTbgB
	 J+S/S7LxIeGHmnjHCWngpctMteNF8orPxrUyINFHAeLgREdaS8Feu+Xt0c3rZr8RHW
	 9pCE15bADy2oRH7vAyUdGVD0kMybnDFeC4cQ+ZLu8/f/wcHjb9oj6EfbWGNXW/K2IZ
	 tCuBAUmut+OuA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 08:26:16 +0100
Received: (nullmailer pid 2580784 invoked by uid 1000);
	Thu, 18 Dec 2025 07:26:15 -0000
Date: Thu, 18 Dec 2025 08:26:15 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH ipsec v2] xfrm: set ipv4 no_pmtu_disc flag only on output
 sa when direction is set
Message-ID: <aUOsl03qEgu8Wf8n@secunet.com>
References: <8524e1c3229c868eb3313d238aff43992aaa41a5.1765448730.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8524e1c3229c868eb3313d238aff43992aaa41a5.1765448730.git.antony.antony@secunet.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Dec 11, 2025 at 11:30:27AM +0100, Antony Antony wrote:
> The XFRM_STATE_NOPMTUDISC flag is only meaningful for output SAs, but
> it was being applied regardless of the SA direction when the sysctl
> ip_no_pmtu_disc is enabled. This can unintentionally affect input SAs.
> 
> Limit setting XFRM_STATE_NOPMTUDISC to output SAs when the SA direction
> is configured.
> 
> Closes: https://github.com/strongswan/strongswan/issues/2946
> Fixes: a4a87fa4e96c ("xfrm: Add Direction to the SA in or out")
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

Applied, thanks a lot Antony!

