Return-Path: <netdev+bounces-243700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB180CA637A
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 07:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 934D83030399
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 06:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BF7296BC9;
	Fri,  5 Dec 2025 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="PgCxpvLX"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA91F78E6
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 06:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764915551; cv=none; b=YPLjXxIus2a7yUuc/J7IX04UvDhC1UogI3Yzpg3HhXxZfw7Adx/BATRbnUozj1lL/hbwMYUyRmdJoooRodCSFlHgDh0+axZjFLOjhljymyQednzRTuLYBa4RAGntFO7MXuvz6QCP/97kDlliRP/zbkfYRPU/TWKzSnaelxpU+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764915551; c=relaxed/simple;
	bh=KTK0RlPXSasoSa/nN0nuLr1awIsKUayEm1STFPTrg0U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIEMDvWdgEunLmotz+2Pdx+tVITtEAAa6tsEZHfLsu6Hf2S25MD4oob3k9EdDt2YDqvdOtTN+7veicvyOvBNunKfbOnV3t7Ofnvnxg/B1sC/U5YGfPibJKKRRUuyntBKfgB6izUoIRyUZIDNNS4Tv24CYTEeJG9WyQZRo7x9eZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=PgCxpvLX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id BC6A920842;
	Fri,  5 Dec 2025 07:19:00 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8GIjTnr3u6mk; Fri,  5 Dec 2025 07:19:00 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 061A520839;
	Fri,  5 Dec 2025 07:19:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 061A520839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1764915540;
	bh=TpIl10NHPzwEqE7ZO2S01Tq+IahBNURxoHVLrdL4i4E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=PgCxpvLXHdZmEuovtAAXQeJEDnAaLSi4F+Sa+jP0Gv6cJPhy03yLB8chKu3E7bZnZ
	 78V2PwQBWeP+naDj8t8JVFAgqdHR4L94mXshfI3Wi1Nfs9HMDjzww+7VDmIhtXwO78
	 PGBdySWMtlBtDFDbQllvf7mNnvgVlipxp/34IGhQlN+YLtbUWC/RHKnaxNet05dK86
	 Zkga49022S08hZtv7XOPVM1z0MCOfZE9qOtl6eWNUkAB+t79axn07Yiu6jtEePSIEz
	 2RLYyfGCnHK2mRas3//6/9HeCauwc5+kKDOE3dPFizUhb3QoLyKJNYS/WQKwCGQkL8
	 WhfYvXYGD3I8w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 07:18:59 +0100
Received: (nullmailer pid 3420591 invoked by uid 1000);
	Fri, 05 Dec 2025 06:18:58 -0000
Date: Fri, 5 Dec 2025 07:18:58 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: Re: [PATCH ipsec] xfrm: set ipv4 no_pmtu_disc flag only on output sa
 when direction is set
Message-ID: <aTJ5UrS_3xPrbtSm@secunet.com>
References: <17a716f13124491528d5ee4ff15019f785755d50.1764249526.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <17a716f13124491528d5ee4ff15019f785755d50.1764249526.git.antony.antony@secunet.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Nov 27, 2025 at 03:05:55PM +0100, Antony Antony wrote:
> The XFRM_STATE_NOPMTUDISC flag is only meaningful for output SAs, but
> it was being applied regardless of the SA direction when the sysctl
> ip_no_pmtu_disc is enabled. This can unintentionally affect input SAs.
> 
> Limit setting XFRM_STATE_NOPMTUDISC to output SAs when the SA direction
> is configured.
> 
> Reported-by: https://github.com/roth-m

This tag does not make much sense IMO. We neither have a
real name nor an email address to contact.


