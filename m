Return-Path: <netdev+bounces-176382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE4BA69FDA
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B30D16DB04
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 06:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5651A1D88A4;
	Thu, 20 Mar 2025 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QFzhULmp"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D779C0;
	Thu, 20 Mar 2025 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742452429; cv=none; b=tXOF4OvS6vYu40uh9hffB8p8xpLBxsLVhrpnnMfhJLO88cBxUoHjgVhPcrPF0tfc+KtlKcV8Ezp2zFjgGMJKLxCDE1N/ITSnQUQJrRvo7jYLBU0AoXfCUgq/v2qjejHKxgNoCs71EGdSkyY8+SvX83yydkfTjWuPcou6TKejzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742452429; c=relaxed/simple;
	bh=QAVBfWL/QQ+rfHFwIL/4sUAVNzP8ijfEWYr3lCs0Tsg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRfqQbJYJbSXEF6PwQclSndgKKTLzyeYnjXujqLO7GyvmHbFrzWsYvDaQJ2i16EQ5TwLynjztfkZ1pVqFMQ/qssu/SwCR7uFop3+ua+q9PtZc5RYDadG3StyDEwrOpxQ2bMCjjwEBpMBAbXr/B8/37j81xI6CzAvKgKA3h0Gwtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QFzhULmp; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 21A4A20842;
	Thu, 20 Mar 2025 07:33:44 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IYu-L1oO3jEt; Thu, 20 Mar 2025 07:33:43 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8B8FD2053D;
	Thu, 20 Mar 2025 07:33:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8B8FD2053D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742452423;
	bh=aUtjrSlGYzCQRqioCHQMti5eOAymsTMwRqiJFqyLSFU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=QFzhULmp0AaMIv937HICxO915+/CeOdn1MryJjOOnxsElC1NSNpCMwRJ7hfRY5nzE
	 zRQimot2ypGNpuktqIw1EqePMoMVkd9zwuE51qqYHsv2hsL0fid/TeTezL6U4cTR/F
	 UC09NZa2g4dNil3Uyc4HsgcQNOuSmnTdkLKImlqTl0HqYTgQN6PVoqbAxqwvxxfyiE
	 aBOzT8U2mDJi7PiqdB3jsybgUNt8P+kTxvOATAzOP1l6iyW0x2Qc2v5DScHBby3oyh
	 mPv7SIy7C3hTQpOcvk9eWJblnlyTLr+nRqMaZbrEDYmdcxRLHBfQ7xtj/DJqh/7w3r
	 uY24hdgfSfmYg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Mar 2025 07:33:42 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 07:33:42 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id E84B631806B3; Thu, 20 Mar 2025 07:33:41 +0100 (CET)
Date: Thu, 20 Mar 2025 07:33:41 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net-next] xfrm: Remove unnecessary NULL check in
 xfrm_lookup_with_ifid()
Message-ID: <Z9u2xZmNRyJiehVX@gauss3.secunet.de>
References: <2eebea1e-5258-4bcb-9127-ca4d7c59e0e2@stanley.mountain>
 <6365c171-5550-4640-92bc-0151a4de61a1@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6365c171-5550-4640-92bc-0151a4de61a1@redhat.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Mar 19, 2025 at 06:38:49PM +0100, Paolo Abeni wrote:
> On 3/12/25 6:21 PM, Dan Carpenter wrote:
> > This NULL check is unnecessary and can be removed.  It confuses
> > Smatch static analysis tool because it makes Smatch think that
> > xfrm_lookup_with_ifid() can return a mix of NULL pointers and errors so
> > it creates a lot of false positives.  Remove it.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > I have wanted to remove this NULL check for a long time.  Someone
> > said it could be done safely.  But please, please, review this
> > carefully.
> 
> I think it's better if this patch goes first into the ipsec/xfrm tree,
> so that hopefully it gets some serious testing before landing into net-next.
> 
> @Steffen, @Herber: could you please take this in your tree?

It is currently sitting in my testing branch and will be merged
to the ipsec tree by the end of the week if no issues were found.

