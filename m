Return-Path: <netdev+bounces-110543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1FF92CFB0
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 12:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6021E1C238B8
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 10:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F81E18FDB6;
	Wed, 10 Jul 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Na+MXXl0"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B117FD
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608057; cv=none; b=m+K6gH6Azyqalwg9w7jQgSFQEpzhozwH3T/0wzVY9oPm2WgELAglpFHdXKMUnHhjdeW7jyPU40nbkDw0pUTDR1aPn+KQP4UhNd045xFIeknmcntVc8DweGSbCvXvO29FFvCJknCt8Bvo6AquyaYBYbRUGjgNfMQ9PbH+4fy2Xmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608057; c=relaxed/simple;
	bh=kDBSvy2TmLoRCCNYwSok6VqFkP5+wEXmp4P1lIq2TYM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQFp3clFG2S42SYEzcA5s05BiXPhSHc+I5G5ItxxcYi/w4+m7wqWOFSv+vlBJ7MZqegj9sR7p89JkKoayX/9Y6C/ttPnIdsmmytrQ8Di1NAJkEzXclUk6glSuKcR/hlERxMD6hTW4fkTnf9i/znxzChocBfuFhYzuUAd8P3TMAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Na+MXXl0; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E5196207BB;
	Wed, 10 Jul 2024 12:40:45 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rsXX8Uz-OVFR; Wed, 10 Jul 2024 12:40:45 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6AEF6205CD;
	Wed, 10 Jul 2024 12:40:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6AEF6205CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720608045;
	bh=6B3y3C3ADOpMO+RuMdcHs09Xqql7en/uk0R99ptq5WI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Na+MXXl0MwGcdhJc28LDVE7FVVwZ3HQD9m9psuHP1JzKcAgcaKXV+w2bVkcFw+Oho
	 yi9rLNwwmmbjLj2Xa6uK1ilWvHNmB0DgB2Li5wJYMvbqXUY0bE36Sx3IFACk2tvt+t
	 Zq1sqMTzxU8yqHxShRfBMuTqmbAj1gZtVbUvxuDiWyLslKc73KsTKIpBE4iDeeA6tz
	 d3F3hYZE2yta3yq87a8TaNSGkb3O4R4HauVDJBCFKRIA1lOjhUDGt93oypQzuXWG4q
	 4pHrBHBDJ82QqCl6aHEItm3kdKC9GcZ23PpBagw7/sjp42ANErmIUSSGRLQJ9wmnR3
	 cA6UFaCrS9p/w==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 5DF2980004A;
	Wed, 10 Jul 2024 12:40:45 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 12:40:45 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 12:40:44 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8A5083182B4F; Wed, 10 Jul 2024 12:40:44 +0200 (CEST)
Date: Wed, 10 Jul 2024 12:40:44 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Jianbo Liu <jianbol@nvidia.com>,
	<netdev@vger.kernel.org>, Raed Salem <raeds@nvidia.com>
Subject: Re: [PATCH ipsec 0/2] Two small fixes to XFRM offload
Message-ID: <Zo5lLAdKmmYxDcoB@gauss3.secunet.de>
References: <cover.1720421559.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1720421559.git.leon@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Jul 08, 2024 at 09:58:10AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This series contains two small fixes for XFRM offload.
> 
> Thanks
> 
> Jianbo Liu (2):
>   xfrm: fix netdev reference count imbalance
>   xfrm: call xfrm_dev_policy_delete when kill policy

Applied, tanks a lot!

