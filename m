Return-Path: <netdev+bounces-89924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F848AC37D
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 06:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8671B2118B
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 04:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7842113AD8;
	Mon, 22 Apr 2024 04:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="IzAr3exJ"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6BF134B2
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 04:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713761154; cv=none; b=D6EBBTICHS0vbYc4ugmG4hmi4c3/n6K6Lmvx7IE/qmYUUS94KggPdO+kei9ZVpFhf6UnFy1W4rXDmgbR6FhWEJIUSZjnD1lPvN7yYPtjWIpnWr6CJfYjKoleiLru+poPfZy8ILnBDAtn5Bza317srlTNazQi4hlhyOG8fNGNaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713761154; c=relaxed/simple;
	bh=S7Jnk4Vjh3FT04tj0ZiKgG6/XY6VGDfe46MjxAbt3L0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeWonB1fJqFz8Vg2y3I1TeL8E4MpRmR7oyGDdNgKpdA5Zp2+SKOuKBv4RngH43kLgXvOV7hm6K9dM/6tNtysnORq87Azyd8d5AZL+nuhROhqjORy/QB5VpyZcxa9hHwSdZWNB/8wRHTfT/I1IYYfnXbiKgqHEcnS2hcgl6JbcZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=IzAr3exJ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 36DF020799;
	Mon, 22 Apr 2024 06:45:49 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kRtEYPijm5Ox; Mon, 22 Apr 2024 06:45:48 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6BDDA205CF;
	Mon, 22 Apr 2024 06:45:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6BDDA205CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713761148;
	bh=vT7KZDeRlW2/BXF543fyZnBM1hFn/6pNYFHXGNjDKyw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=IzAr3exJddBW4EMjvaSgdmQsPVgcFLuUgSKMkTmYbMhNgbwkfuZUtAKf/SntXAGsa
	 OSz3GYPWZotDIp/Fs0FwOBrR/Mdyvq4KtfDZdloxSrEvOwjZPgrAVumuhSk6ls8JSO
	 sb8uGj9G6v6PcVqNsIpmarxM4OzCK2cVVKfYkolquy3Xukiw885/rvn96yuJ6snLP6
	 RejoSjQwAn8QMVgS3bt7ZqN4p9PZRd21W07amJMoVcOsYzD2nAG4xbjsHjzD3iRflk
	 qN/60EWnk69b5xwx9FQxY1fdbFii4He6FY7BpwViDOp8I4OReSOTf4PlfT7ZCDBYT7
	 BPw+FjwzXLg3Q==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 5D25180004A;
	Mon, 22 Apr 2024 06:45:48 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 06:45:48 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 22 Apr
 2024 06:45:47 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 966CA3183F3E; Mon, 22 Apr 2024 06:45:47 +0200 (CEST)
Date: Mon, 22 Apr 2024 06:45:47 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: Re: [PATCH ipsec] xfrm: fix possible derferencing in error path
Message-ID: <ZiXre/dNlJCpNtXP@gauss3.secunet.de>
References: <2a5c46f3ae893a13a9da7176b3d67f3439d9ce1c.1712769898.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2a5c46f3ae893a13a9da7176b3d67f3439d9ce1c.1712769898.git.antony.antony@secunet.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Wed, Apr 10, 2024 at 07:27:12PM +0200, Antony Antony wrote:
> Fix derferencing pointer when xfrm_policy_lookup_bytype returns an
>  error.
> 
> Fixes: 63b21caba17e ("xfrm: introduce forwarding of ICMP Error messages")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/kernel-janitors/f6ef0d0d-96de-4e01-9dc3-c1b3a6338653@moroto.mountain/
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

Applied, thanks a lot!

