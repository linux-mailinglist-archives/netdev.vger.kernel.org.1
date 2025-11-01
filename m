Return-Path: <netdev+bounces-234836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A64C27E05
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 13:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52A4D4E1F3D
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 12:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5560B2F6193;
	Sat,  1 Nov 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="kyTvgBWP"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952662C3262
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000192; cv=none; b=isJh3v0+Q0/MGwALZ8e5rhWia1BNVjBwRnPOrTOPCa2IMgrJ2uL3d88znrxGUKM7ifoQAfKugSEpTlgW1gUtzXvyNU7ejJewUgGD4DSG2+YpTtcndJ9t4IZgyZcL/aALirgTPRhi+3BUiQ0+CfxKbggy58cOhBDaJCE22LAc9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000192; c=relaxed/simple;
	bh=dyma+DLcRbzqc9GBvZffy+rhvNDNdD8Yfveo9xMifos=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqE+L/LgR1NH1HClr5PnvjJTXlz1nhhl2uWtiQzXMQJcJGKRhnFwKWoMEA9cNlSuSAsL4DeZ3y4I8xSWvEPwN9k02SI8K/5WxJqtsMIApWF4fHQVoqXcp8FiztW1KVBsWeEgSinXHRIc8RfDR6cvpALXlLCUm0N3UGtgCoua8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=kyTvgBWP; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6ED0B20851;
	Sat,  1 Nov 2025 13:29:46 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BsF5rMDG9kM5; Sat,  1 Nov 2025 13:29:46 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E044720754;
	Sat,  1 Nov 2025 13:29:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E044720754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1762000185;
	bh=20zMGo1h+uvk1oy7JMl/P/KUT9EcVNUrmEGYY7w8rkU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=kyTvgBWPBb+ED2EndRO2JsxD3gJ9yiMt83iF7T/DTWvdNC7ovdYB7xrhhY72mH5Sf
	 TwKniO0jmiF9Lz2yKDVH/9Qki2Zxm8ABfKdv3IqaMNUlLZm9xBexQAa+FUgjFE46Th
	 xD2IZ66RSp+i46Fq+SrVPtUzrEAlip13Aef2tyiCGzrUd6hEs/4m0RtPE6sKKJF//G
	 q917bu7My9BELEWOwxJev5IHxkSckM655jYNslUVjfmYe66vbcve2w1OBybMIr092o
	 saVpYBadqHWzIetAFrGPFi8iuJdUmibMbqFiQqU7od1PuLcnyrN1/KjGhDUXC4eq0S
	 E0JisHKW04YEQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sat, 1 Nov
 2025 13:29:45 +0100
Received: (nullmailer pid 3046054 invoked by uid 1000);
	Sat, 01 Nov 2025 12:29:44 -0000
Date: Sat, 1 Nov 2025 13:29:44 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<acassen@corp.free.fr>, Leon Romanovsky <leonro@nvidia.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Leon Romanovsky
	<leon@kernel.org>
Subject: Re: [PATCH ipsec] xfrm: Prevent locally generated packets from
 direct output in tunnel mode
Message-ID: <aQX9OIz9FhL3wO4f@secunet.com>
References: <20251029095213.3108-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251029095213.3108-1-jianbol@nvidia.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

On Wed, Oct 29, 2025 at 11:50:25AM +0200, Jianbo Liu wrote:
> Add a check to ensure locally generated packets (skb->sk != NULL) do
> not use direct output in tunnel mode, as these packets require proper
> L2 header setup that is handled by the normal XFRM processing path.
> 
> Fixes: 5eddd76ec2fd ("xfrm: fix tunnel mode TX datapath in packet offload mode")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Also applied, thanks a  lot!

