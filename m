Return-Path: <netdev+bounces-206560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C51EAB03785
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1C818979D7
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 07:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FC222DA1F;
	Mon, 14 Jul 2025 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="htbpSLaV"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB222D7B5
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476759; cv=none; b=iyPXfjVT8R7PNis7tjvf56+ODX2o1k0OoyXLjAqzcW13GoWwe0eZKQPOKVfzeTMfoc/+0tdmRpb+ZAazAiZ9c+1pt8dMjBto8Tk+z8C2DvPOpu0xEyGwP4/s4gMB9KO4HAZ06jX83r/E0DBcH1is5o0PichFcyLA6PxfckKNjZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476759; c=relaxed/simple;
	bh=noh0Oc/jqAkwUGriJP9VJIA4fArqX4OcB3jSBAqv4lo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ymc+OTQkZ3M9kLDlOzPQea0/KDzxUoaZZadrC+zAAa9fBJJ6bklTiFD6UP/WNdhqUQ0X4nYuvrc/V7XarW7IrtRdy4NwSuYwzgkWKek/dXg8h0VG2qiXdIX+l9QM+RlXLsfHjW69Tf94C62q6OqRVHYpaOBEp1qVI81X5Xtskos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=htbpSLaV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7715E207B0;
	Mon, 14 Jul 2025 09:05:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 29cJbJtZvNpR; Mon, 14 Jul 2025 09:05:54 +0200 (CEST)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A7BB6207AC;
	Mon, 14 Jul 2025 09:05:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A7BB6207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1752476754;
	bh=noh0Oc/jqAkwUGriJP9VJIA4fArqX4OcB3jSBAqv4lo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=htbpSLaVqa+e8GqEYZg9vamYPXtXkbuEbDx8HFmx+cOnEUpPsWTLwiXUTYdNymEVH
	 q/FEqB6emLYtokSgxdNSfVcIRQ2TbbwmxnfglCG7ZLc8FeArMaI3qLrLjfA4qI00Bc
	 HC7mDK/Pbzh5cLTiUsdZXDc4QY11UKW3Gq92BnPMs05nbytf5vW+7N1rbV7/InD3yx
	 SS2QO3B8UrfWKXjO3bWyBgf2zSgYkMJFjrNTADt9TJSCDG1tzOyMuYlDGjtMUC0bvV
	 lFVN7rXOdusuSMF5EXbvpchVzxMSJ62xwDeFrFWoytBSSn+sPGdaQal2eRQ6CMKLtd
	 9wBQHaroJDf/A==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 14 Jul
 2025 09:05:54 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Jul
 2025 09:05:54 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 686593184234; Mon, 14 Jul 2025 09:05:53 +0200 (CEST)
Date: Mon, 14 Jul 2025 09:05:53 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Aakash Kumar Shankarappa <saakashkumar@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, Abed Mohammad Kamaluddin <akamaluddin@marvell.com>,
	"antony@phenome.org" <antony@phenome.org>
Subject: Re: [EXTERNAL] Re: [PATCH] xfrm: Duplicate SPI Handling
Message-ID: <aHSsUbP3JtdJtPfa@gauss3.secunet.de>
References: <20250630123856.1750366-1-saakashkumar@marvell.com>
 <aGeDsU-DjJG7Saj7@gauss3.secunet.de>
 <BL1PPF236BDCF3E6140C103E6AA14EE5FF0DA49A@BL1PPF236BDCF3E.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PPF236BDCF3E6140C103E6AA14EE5FF0DA49A@BL1PPF236BDCF3E.namprd18.prod.outlook.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Wed, Jul 09, 2025 at 10:20:42AM +0000, Aakash Kumar Shankarappa wrote:
> Hi Steffen,
> Thanks for applying the patch .
> Just to understand the flow better – will this go via your ipsec<https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git> tree for the next merge window or be queued for -net for stable ?

This was applied to the ipsec-next tree, it goes to
mainline during the next merge window. It will not
be backported to stable.


