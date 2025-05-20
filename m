Return-Path: <netdev+bounces-191728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4370ABCECB
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858D44A3934
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 05:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5699C25B1C4;
	Tue, 20 May 2025 05:52:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4582571A9
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747720372; cv=none; b=O4/4rouqgcXMUrbiqHkRwRi63pwIquNfny79l0kMMA7W9+7LiUQo88C505xI4eBWuQbGmhzDBht8Co0918dkfjh3PtX2iQcyylujOQPjfn34KMEnto8EDuejpWaDLyvJjY9hW8zMI0NYaj88D/lrjyyIGJp9HJDB4u9nbtNVXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747720372; c=relaxed/simple;
	bh=5XIkgHhF21vtLzxgjR3oL5SCXQnwhagit/ibtn3UXhU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA35s2qbbIs9ehWd+fkTUGZIXDT+n4+3IYbLzuTHB+KnHMNWh8emQi3zXNibiLLX/VgmEbHJiwzR1gcGKApxph0whL9tWEeKwNnDswXaSly8ac/PitRfSSYbObqkCPBajIFaa+Bpr/1ZsYC1MjRjCOC5QS++d6GoVz2HxWx/i60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id F0A5B207AC;
	Tue, 20 May 2025 07:52:47 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G9SWs4a3-xrw; Tue, 20 May 2025 07:52:47 +0200 (CEST)
Received: from EXCH-04.secunet.de (unknown [10.32.0.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6EA2520520;
	Tue, 20 May 2025 07:52:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6EA2520520
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-04.secunet.de
 (10.32.0.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 20 May
 2025 07:52:46 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 May
 2025 07:52:46 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2B0D23182DA0; Tue, 20 May 2025 07:52:46 +0200 (CEST)
Date: Tue, 20 May 2025 07:52:46 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Leon Romanovsky <leonro@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH ipsec-next] xfrm: prevent configuration of interface
 index when offload is used
Message-ID: <aCwYrv8vlqzdzLGo@gauss3.secunet.de>
References: <ba693167024546895f704663d699132cbeb68c27.1747133865.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ba693167024546895f704663d699132cbeb68c27.1747133865.git.leon@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Tue, May 13, 2025 at 01:59:19PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Both packet and crypto offloads perform decryption while packet is
> arriving to the HW from the wire. It means that there is no possible
> way to perform lookup on XFRM if_id as it can't be set to be "before' HW.
> 
> So instead of silently ignore this configuration, let's warn users about
> misconfiguration.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Also applied, thanks a lot!

