Return-Path: <netdev+bounces-204957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD86AFCB51
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145053B5CF6
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799532DAFB4;
	Tue,  8 Jul 2025 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWuJ9qsq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508CC269CE1;
	Tue,  8 Jul 2025 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979863; cv=none; b=TcGuzLLAOz0VnL8gG1f+YbdVIlAOVxMrgtp+dbKvvh1NEQrdbpq8ZkPbhZxXn+QusbWVpzgUAwhDcTScRlA0Sy/wRxhuP50tzT9GDlTfjK6hOa3clmiRWRG+mPb0+yILDbZCV8UugU7SeIsn69BNU+oCmzh8BCbGQ0br8jtOp1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979863; c=relaxed/simple;
	bh=DtezwLTXiFgp57t7fhy5HMszcRxu9C3aPysmGZpjAak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Poq1vEVa/x5G8eE3GUe1qh5oFdBh+F0x3MvGO0UxPUqUaJ5GFHr3lbxFnEdRnSQv7ccHa8B3s80bj+rXpz7duJghW7cp/BGun0G8CALzOkbbX31z2plvkNav7m9R7etHpnmcYvyZ5oIk5SWfxcjNRd+V1mKqhA36YyfFPYXuTJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWuJ9qsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E77C4CEED;
	Tue,  8 Jul 2025 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751979862;
	bh=DtezwLTXiFgp57t7fhy5HMszcRxu9C3aPysmGZpjAak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pWuJ9qsqMzGCiUAAzrOtN1fqP+naFqDuIPadLtGr2GG3Zjq2T33oIxnwjAq18jn++
	 nFMmqToQ1OGbIrKGLFGj6Ft+7SzpWfu2pF/9jDMkfN2VwYIPTFfNAR/cEPhIFEzmRx
	 C5wIIAKh0XYzRDg+/viWg2VQuSmzcuCy4vNBgODzluJmcvPBPsfcgT5gyS7L0apZTx
	 0wspBrznhxaB9ajwG3p5I3dHfYDuPEcOh5IhjVIEBzHep4xu6FhcfM6yu+SzYgvmwC
	 XBQm5qrtc19+qCcfLudptekvSugXgIDGNIL+X8bi7pTUg8L9EVIKJgu+EqLTkWemwI
	 3LphDa6xo6ujA==
Date: Tue, 8 Jul 2025 06:04:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: veritas501 <hxzene@gmail.com>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Herbert Xu
 <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: appletalk: Fix device refcount leak in
 atrtr_create()
Message-ID: <20250708060421.2b388dc6@kernel.org>
In-Reply-To: <20250708090431.472195-1-hxzene@gmail.com>
References: <20250708090431.472195-1-hxzene@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Jul 2025 09:04:30 +0000 veritas501 wrote:
> When updating an existing route entry in atrtr_create(), the old device
> reference was not being released before assigning the new device,
> leading to a device refcount leak. Fix this by calling dev_put() to
> release the old device reference before holding the new one.
> 
> Fixes: c7f905f0f6d4 ("[ATALK]: Add missing dev_hold() to atrtr_create().")
> Signed-off-by: veritas501 <hxzene@gmail.com>

we need your real name

> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 73ea7e67f05a..e5708870a249 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -576,6 +576,8 @@ static int atrtr_create(struct rtentry *r, struct net_device *devhint)
>  
>  	/* Fill in the routing entry */
>  	rt->target  = ta->sat_addr;
> +	if (rt->dev)
> +		dev_put(rt->dev); /* Release old device */

null check is not necessary before dev_put()
-- 
pw-bot: cr

