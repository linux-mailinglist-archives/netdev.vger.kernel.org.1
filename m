Return-Path: <netdev+bounces-80517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E488187F829
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 08:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215F31C21620
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 07:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0363050A97;
	Tue, 19 Mar 2024 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="OAbakMZp"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42A50A67
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832134; cv=none; b=HWyEqqwABpNmiruQDYqmQiEFcFvkVE+C4kmiLHm+ngg271y8+pGSbc51DW2Qr8D1/Xq75n7aQuDcAsDXxtsoGL3e+P3JoVOt3mHCAbHqpLnBkllOeZ+K8lf7egLQb55XJMRdNfoNi51NubxPYuNQcTdJQh5/FNxG72R4xZ2PEMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832134; c=relaxed/simple;
	bh=fthjRPSqTEWBwPv7kDg5JrBIyH5g+VbT/s4BhWGikas=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJeNgKEWsY2fPkm0F6hYUriB/kzJPldqMPnCMY3IQtSv2CSbVcBaq+uAir8MhqlNz/K3W+uBbWfCFUgpmjUmNJIqkb/GYYAj8zNB0z5wT2y9gtXxi5bKSHYpGUJ+Aml7HImFYfv78ww0W1PKKwNOn38+qBOfqgPzvTdLU6PJ6bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OAbakMZp; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 24976205ED;
	Tue, 19 Mar 2024 08:08:51 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HXmCws4hcuTF; Tue, 19 Mar 2024 08:08:50 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5E0DB2058E;
	Tue, 19 Mar 2024 08:08:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5E0DB2058E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1710832130;
	bh=Mpq/gVrFRNjZk6Yfuc2U3PYiCIayy5FdEeXQoWJgMDo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=OAbakMZpFnw7HcrpOB2oWJ5Q0zy2+oipFoTjy5WfFeQRD2lWsoB032JODX1s4dRr4
	 vIhCav3DR8SXNxDRFJDEI8qR0BPZgWg9Phhmmbq/yRt6slZo29iodZ0jnbIBIlbriT
	 xmihnvv5aNi1dg9pDVUyJ039VURPksKA31bdl5R5OiA3EUrSlp949w3txsjzGNlPEz
	 6cCt2Bb33ASPMAjJuB6tuRSEZxhkLuSydvN6kA2oZNtx6qiTXpINeOr3VlwpQR8T3Q
	 lEF/Lh8ELiDcAPAdJCsZ1DFS1ZhBAuitIguIonYpv/EChi18BOy5i9oE5bsHk528Vv
	 YU8homfoV/m3w==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 5135080004A;
	Tue, 19 Mar 2024 08:08:50 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 08:08:50 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 08:08:49 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8A14F31844CD; Tue, 19 Mar 2024 08:08:49 +0100 (CET)
Date: Tue, 19 Mar 2024 08:08:49 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Leon Romanovsky <leonro@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH xfrm] xfrm: Allow UDP encapsulation only in offload modes
Message-ID: <Zfk6AcOGMDxOJCd+@gauss3.secunet.de>
References: <3d3a34ffce4f66b8242791d1e6b3091aec8a2c25.1710244420.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3d3a34ffce4f66b8242791d1e6b3091aec8a2c25.1710244420.git.leonro@nvidia.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Mar 12, 2024 at 01:55:22PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The missing check of x->encap caused to the situation where GSO packets
> were created with UDP encapsulation.
> 
> As a solution return the encap check for non-offloaded SA.
> 
> Fixes: 9f2b55961a80 ("xfrm: Pass UDP encapsulation in TX packet offload")
> Closes: https://lore.kernel.org/all/a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied, thanks Leon!

