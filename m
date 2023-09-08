Return-Path: <netdev+bounces-32673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A779917B
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 23:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB341C20CBE
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 21:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8F730FB7;
	Fri,  8 Sep 2023 21:26:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AF30FB5
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 21:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D119C433C8;
	Fri,  8 Sep 2023 21:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694208363;
	bh=UmACI1NMkQ0t6DUTaK+14CkyfrPm5dltAaNutvRbQho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O61YYzfi3zjxObPSXE1UqhgWt/F8hgSF97WhMm0e9/L/YSsHmzYp19NKEigBznRGX
	 O5ZSwjz9i0g/pQCG1nkV2Mz2sNPjy/5dQnUnSIjQmD9jnD2nuYoJiKUbIA9zAcVkH4
	 Yp7+mhlnDQxYIyiFunJ2T4lCIXBzNizMp0LIz8lJuTXSSEy8EZcDDojVw0Emb6PIe9
	 ngQhtFZPfaGW1y3Usdwrkt8kR3AKC+vmE5GYt8/7E9ognUePkW9suR/F1AYwDPnADW
	 7Zi+RS/z55iwm9MNcTrkb8qu24n1kUW0TDOVtCyXPRjgItaHbIph0iNiDn8N5xkirT
	 UBu2K8ODSjYrQ==
Date: Fri, 8 Sep 2023 14:26:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 vakul.garg@nxp.com, borisp@nvidia.com, john.fastabend@gmail.com
Subject: Re: [PATCH net 1/5] net: tls: handle -EBUSY on async
 encrypt/decrypt requests
Message-ID: <20230908142602.2ced0631@kernel.org>
In-Reply-To: <ZPtED-ZlSEQmPSlr@hog>
References: <9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net>
	<ZPq6vSOSkDuzBBDb@gondor.apana.org.au>
	<ZPtED-ZlSEQmPSlr@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Sep 2023 17:55:59 +0200 Sabrina Dubroca wrote:
> Jakub, I guess we should drop the CRYPTO_TFM_REQ_MAY_BACKLOG for net,
> and maybe consider adding it back (with the back off) in
> net-next. Probably not urgent considering that nobody seems to have
> run into this bug so far.

Someone did mention it long time ago, but I don't recall the context :S
I think it was something about the device queue filling up..

> But then we have to handle ENOSPC a bit more gracefully, because right
> now it looks like
>  - on TX, we break the socket (tls_err_abort when tls_do_encryption returns
>    an error)
>  - on RX, we also break the socket, and we don't decrement
>    decrypt_pending so the recv() call gets stuck
> 
> Not sure how complex the changes would be, the sendmsg and recvmsg
> code is already a bit hard to follow.

To keep it simple we can wait for all in-flight requests to drain if we
hit EBUSY? Basically factor this bit out:

		spin_lock_bh(&ctx->decrypt_compl_lock);
		reinit_completion(&ctx->async_wait.completion);
		pending = atomic_read(&ctx->decrypt_pending);
		spin_unlock_bh(&ctx->decrypt_compl_lock);
		ret = 0;
		if (pending)
			ret = crypto_wait_req(-EINPROGRESS, &ctx->async_wait);

and call it after we get EBUSY? We'll drain the pending queue all the
way to empty, which may not be too great for throughput, but who cares
- right now we don't handle EBUSY at all, so it must be extremely rare.

