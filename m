Return-Path: <netdev+bounces-198036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6405ADAEF1
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB2016CB79
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AE92E92A1;
	Mon, 16 Jun 2025 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="HumLTvy1"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F82E3367
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750074305; cv=none; b=j3HDLD2Iv/MpBd9H+32Dkk40eMnvSw1GOASc50HYPpT278OHluj/hIgqEm6jQ+l0zYDNJYZbrcy1ZkKoSdmtJtPOuIT6D+bUeSJdIaxwM4YEzx48zW2aRRPb2tALIVJIe0JznQJfLkKawLP79PryXPvxG/IRSuBsFgn2ZEJAJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750074305; c=relaxed/simple;
	bh=Sshlv3G42dDhB35r9a7RpshJNAbwT+Li3MD2hsB/AYU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz+5/fBI+vNMM5pvcYuLjKd2I+kQLcNC/cH2cSQe/fuTEy7v5yKEW/AYTl/mX+RHROitXaf+h2mMdkpAVh81qoTDfpaTac96OR91xwAXT1iwpR0N66uRQudJlrkcDUtsdwGVyhwx4DsBBnLb1CIvBwXKmPZNj9GOk1gjhKHN9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=HumLTvy1; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8E76F206B1;
	Mon, 16 Jun 2025 13:44:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CvELbfG6Jw13; Mon, 16 Jun 2025 13:44:54 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C2113205ED;
	Mon, 16 Jun 2025 13:44:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C2113205ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1750074294;
	bh=b0L6oH1MwP79DStYmlbTBiSW83Vq0WSCzxebAGg9NkE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=HumLTvy1zYL3DYdy6wPp9/HEBemVclGuSK9wsJ/ZbhUxqSdSmK/Dhz39dNKWi+8bb
	 dJQSRI83s00VAVcuO/F9Qp2uiQ22GCpZ6WjUKVndCuDJ5GYypUWeW6FEfyFNcq9ed6
	 YjpFN+scVR8D19wVMLLPLtMaIVs1KkZTPhpC+obGyKqd77kZWLTyadKjZ6r+7cU/cE
	 GD8QXYrUxf3bu945jrtS9zkAT05tLixl4hRLCElXdUoqLSbKr9c6ztV+MJ6w1nHELX
	 pWUBMKjQRJ2xB4D9N1KjndKehYej0UY8jRspSL4eqgvwufjHr7uDbPlOnZ/uwbROJY
	 ccRatihmpuhkw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Jun 2025 13:44:54 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 13:44:54 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CAD333182AEC; Mon, 16 Jun 2025 13:44:53 +0200 (CEST)
Date: Mon, 16 Jun 2025 13:44:53 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Leon Romanovsky <leonro@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca
	<sd@queasysnail.net>
Subject: Re: [PATCH ipsec-rc] xfrm: always initialize offload path
Message-ID: <aFADtXIv7iDuhVO4@gauss3.secunet.de>
References: <1adfa8a9af9426b34b2fbeefc64fd41c4f4aa1ab.1749368489.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1adfa8a9af9426b34b2fbeefc64fd41c4f4aa1ab.1749368489.git.leonro@nvidia.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sun, Jun 08, 2025 at 10:42:53AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Offload path is used for GRO with SW IPsec, and not just for HW
> offload. So initialize it anyway.
> 
> Fixes: 585b64f5a620 ("xfrm: delay initialization of offload path till its actually requested")
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Closes: https://lore.kernel.org/all/aEGW_5HfPqU1rFjl@krikkit
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied, thanks a lot Leon!

