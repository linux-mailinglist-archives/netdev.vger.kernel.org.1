Return-Path: <netdev+bounces-108281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B815891EA25
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 23:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED191C2120E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696F583CA1;
	Mon,  1 Jul 2024 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QTKOMzqF"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26CA2BB05
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868898; cv=none; b=rVs8Q8kgFz9JqxY9GTcaApHu00DTw9wqZ23/iOOozcZc8ijnji+k+GNHNEIvQPPPpn8LjqdQaYhf4jNT/lzfsWiHvX6GCRVzA6Clyap+hi6u1MUwBLvJkMHQG5eXWcDaSNvm45hzne1sQnIyvq/piJNDgyyumQ4TrkTXPtQT/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868898; c=relaxed/simple;
	bh=eueKYNlc80y8s1X2BSWQY4ysJZB3OedTGs7iQx8Grmo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWyXmp42M7RkthxYG+ubPApepw0sC2qh/vX/04mCbyhDW9QnkJoTdCawmZuNOrIH34ymlzDCE2EYEtgcAMZXq+TSzUeoB1/5l49+mX/uSL+MWivZhysFqc0IbYzc4DaCYj6BTUGnWq9ytiCzYdNFdscAebn7BJ41JoZobL1PfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QTKOMzqF; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4FAC6206BC;
	Mon,  1 Jul 2024 23:21:27 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q4awkn_Jxq23; Mon,  1 Jul 2024 23:21:26 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E4EEC206B0;
	Mon,  1 Jul 2024 23:21:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E4EEC206B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1719868885;
	bh=P+M2ddk4BdoE6HDay9x6RaMBPC+33uwbkc94y+hkpIE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=QTKOMzqFhRah44Qos28Ua1qcwp0MSZUZaaX4ikRJvdcpmoDY2ybttuNp+dN277Dhl
	 lsbRenvI/0o350y+I2XV8ylWnETLIHWJsVMVYDwxRtPbD1sk1hTJNQ3c+b33kK909p
	 VK34cJPsJeSMPq1t74/4VjARMuNFkEq3A/dfMCmtmfbsEtFbdLLhCRPSyeKd9Emf5p
	 7L4Ject+X0WzDE5IrZJ3tVGbysvGbwz586CUnLNzF1ZJ/sH9N4Kx/JthJwKlHzsMsM
	 1xHlrdhxa3jW/yCBKZaVfp6C1n+AnffENNvAq4/JIWU1NnfxNNYf3aOWwcIrlGg9zz
	 SuJp/Brj+nEtQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id D3D9A80004A;
	Mon,  1 Jul 2024 23:21:25 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 23:21:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 23:21:25 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 07FBB31829C2; Mon,  1 Jul 2024 23:21:25 +0200 (CEST)
Date: Mon, 1 Jul 2024 23:21:24 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <netdev@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH ipsec] xfrm: Export symbol xfrm_dev_state_delete.
Message-ID: <ZoMd1K7r7UICHXWE@gauss3.secunet.de>
References: <Zn54YVkoA+OOoz+C@gauss3.secunet.de>
 <20240630104311.GA176465@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240630104311.GA176465@unreal>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sun, Jun 30, 2024 at 01:43:11PM +0300, Leon Romanovsky wrote:
> On Fri, Jun 28, 2024 at 10:46:25AM +0200, Steffen Klassert wrote:
> > This fixes a build failure if xfrm_user is build as a module.
> > 
> > Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
> > Reported-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> > ---
> >  net/xfrm/xfrm_state.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Thanks,
> Tested-by: Leon Romanovsky <leonro@nvidia.com>

Now applied to the ipsec tree.

