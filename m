Return-Path: <netdev+bounces-233434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CCAC1335D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9BD1A27F99
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 06:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE98123BD06;
	Tue, 28 Oct 2025 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="aKkauwwV"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCC25A338
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634201; cv=none; b=iQGP/A0AX2UJXSK2C1RPz4hDtncSGjnEsNiry40N9eUvbanogDZYK/LP5SYbnbtvVUpvnCEm8l43U7dAw7+CPJHwqTV+1akCeV3BTSn5Os9QbPo8Wpsz23KYJ7BI8J1/90N3c0hP0ReYK5lDG94/Le1bnLz84sLNu0zaVaRdiCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634201; c=relaxed/simple;
	bh=Z8JSE90sLOXsXd2jX7h+KEJcQX4isNsOMiPrcW6rBF8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/5r71ertWQGAmdttnSy2A1Ba1RFLd/mWrPDH6z7vHxs1k0BXSm0nmQMOkN8vXYhbA1/kync2uBFi4RsXOqxU69JU2rMNP3mUm7FClvkm4hr12+UfwLHjGQgdn4XIO56xoBQ3SfKWI62fmnhC5aZdxBwHCVJrS2nYdNoRk2Bt7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=aKkauwwV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A6F81207B2;
	Tue, 28 Oct 2025 07:49:57 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u3RrBwkiLgzY; Tue, 28 Oct 2025 07:49:57 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2AFE1205E5;
	Tue, 28 Oct 2025 07:49:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2AFE1205E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1761634197;
	bh=E4MYS6q5iVvdMMW6b+U4PVZxb2qMRuZrdrCn2r7XH3g=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=aKkauwwVUBwvBU1R469/ojaEP5NshN29xbYkbvpajoXw9hecEo8TEtCwcWf3sruTT
	 ywtqEkNa9SJ327wAgWvbXWWRfUPFcT2P9oomCFdWqjfAvco9+iq9wizO+KlbwtVVyo
	 Nu/11A700RORg4jGf12T1mXDdRu7acIb8YLHMyRxgdw4a2ZYD+dQPG0R/7b44sNMrD
	 jhut7e9d0EXCtLXza9ugvJKviIZchMhq77XCFSgm/FNFXgo1J+hTvS5DcSZKMIqE1W
	 6CcxA4xiMFjidgY6hs05GAJiED7ZOJy/3EbqPmfrIJsItsueqIEP3+kFDJj2IFLDEJ
	 cs99niiQxa72g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Oct
 2025 07:49:56 +0100
Received: (nullmailer pid 1364292 invoked by uid 1000);
	Tue, 28 Oct 2025 06:49:56 -0000
Date: Tue, 28 Oct 2025 07:49:56 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/2] xfrm: IPsec hardware offload performance
 improvements
Message-ID: <aQBnlOpPIGKyGjqU@secunet.com>
References: <20251021014016.4673-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251021014016.4673-1-jianbol@nvidia.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

On Tue, Oct 21, 2025 at 04:35:41AM +0300, Jianbo Liu wrote:
> This patch series optimizes IPsec crypto offload performance by
> addressing a lock contention bottleneck using RSS.
> 
> The first patch refactors the xfrm_input to avoid a costly
> unlock/relock cycle.
> 
> The second patch builds on this by removing a redundant replay check,
> which is unnecessary for the synchronous hardware path.
> 
> Jianbo Liu (2):
>   xfrm: Refactor xfrm_input lock to reduce contention with RSS
>   xfrm: Skip redundant replay recheck for the hardware offload path

Series applied to ipsec-next, thanks Jianbo!

