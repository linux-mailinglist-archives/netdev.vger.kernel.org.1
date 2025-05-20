Return-Path: <netdev+bounces-191727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C23ABCECA
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475DB4A391D
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 05:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6204B25A65C;
	Tue, 20 May 2025 05:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="FS4EAaiL"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC51F542A
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747720348; cv=none; b=GuivIlOvIRtnXZkv62BSw4KKruGjIefcfzhWD7PWdht3q2A61iK8InWJ4T13D4SyNor0JrtaS0CvIe/42NFNS3lHNek21+KO/oU0AVR+zDI0inczRl9apArkMnivaAmK9b3JTdEbnqip/mPUjukku/ZWX4FxvaIMtaEOsGigums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747720348; c=relaxed/simple;
	bh=hZcmbCQdAG3LyoMyvKqSgR43CNBI0IJoBcQpVyL+tTo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKTOGVN6h32/6TuExqgk75/dNaZXDMrGnT5Ax4ptfHiv0wwBCWkYxpCRjQ/Pnq2339GUxorCy7Mnz6/5949guMMVAu1/r5M+iMyLhM0CmYagbIQGLpY66Fsju74Kf2fL9BhzJjgPb0FgFgAk8nGS27k56iTsgRTxYf1YsgNoCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=FS4EAaiL; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1DF4A207AC;
	Tue, 20 May 2025 07:52:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id apCdgzIaYtTU; Tue, 20 May 2025 07:52:16 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8B85A20520;
	Tue, 20 May 2025 07:52:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8B85A20520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1747720336;
	bh=qrbAXQyyI3eZQGUks1s23K6u0PjDeiVDMq9MHHdBF1w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=FS4EAaiLhpkXP3qytB5IPadd0mJZQ88Pte6klj6YiijkgUu2npx/67L7AbJm2ll4e
	 z1/l4KE6zY8Tf7dWnFb1P5NNRXyxche/H+bPcEhGdjwSa8/cS6ulo/Z2252gilTfG2
	 Sz6lxmf44qXsf1nQjnj+VvdNMs8PyWOF6X8lD3VOtEPag3AsFQaW8uM3dF0Tt/LWPy
	 ok4DpiXw0fJtLtbKFvLMl8dLPz4oh42ds2N+rBd3D+l+MNsqrjoH4wQjI3qCa1HUYd
	 e5gT9yaTRURGd6rO5B3gfyrSBVdiNzFDI2t6JkswY7aYNCjSwxcJdTgzE86ma/ipgi
	 OLSuLSJDh9Mcg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 May 2025 07:52:16 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 May
 2025 07:52:16 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7147831829E4; Tue, 20 May 2025 07:52:15 +0200 (CEST)
Date: Tue, 20 May 2025 07:52:15 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Leon Romanovsky <leonro@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH ipsec-next] xfrm: validate assignment of maximal possible
 SEQ number
Message-ID: <aCwYj1F3LSUVZRg7@gauss3.secunet.de>
References: <956dde412bb3224a31bf89a3038b9d2c76890a42.1747133660.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <956dde412bb3224a31bf89a3038b9d2c76890a42.1747133660.git.leon@kernel.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, May 13, 2025 at 01:56:22PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Users can set any seq/seq_hi/oseq/oseq_hi values. The XFRM core code
> doesn't prevent from them to set even 0xFFFFFFFF, however this value
> will cause for traffic drop.
> 
> Is is happening because SEQ numbers here mean that packet with such
> number was processed and next number should be sent on the wire. In this
> case, the next number will be 0, and it means overflow which causes to
> (expected) packet drops.
> 
> While it can be considered as misconfiguration and handled by XFRM
> datapath in the same manner as any other SEQ number, let's add
> validation to easy for packet offloads implementations which need to
> configure HW with next SEQ to send and not with current SEQ like it is
> done in core code.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied, thanks Leon!

