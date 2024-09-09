Return-Path: <netdev+bounces-126431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4AC971247
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F755B230E5
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DD81B14F3;
	Mon,  9 Sep 2024 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roZP1FcD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDAA1B1437;
	Mon,  9 Sep 2024 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871222; cv=none; b=OtWRIifHbsQzRBpQenfyF+ixIrp7HrygkPtTdVelD2myocGTVcvz8G6LJ5PaoRGq+nKMCxCg4tBVVB94Bsncc+6hp5nh5GlBAVN7ty3tFMMdY9Pvmrde5tBo6jCj3DsrCYbRgBiQotjELhn4ug5SJjiIo0vwDkrLeqi4ufLK8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871222; c=relaxed/simple;
	bh=n3GwlonfAbteXbBV3wk6IPhdrAOgEYlA6RHFVXdGesw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETo3KugQghN+hKgJhTzjAL/8SchZGKUxbuIeBA4xJdoidyZA3lb2WofY9elDSstAUYLIN1t+Svgz39eG8NniQNC+sL6Wj9qFiM1nTQskCCR939g8FyZX5MtLzXcWfT9scGP4PvFSk3ToHs+Hx8iI7gA5GAQrwfGxEINg3iQp9rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roZP1FcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F481C4CEC5;
	Mon,  9 Sep 2024 08:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725871222;
	bh=n3GwlonfAbteXbBV3wk6IPhdrAOgEYlA6RHFVXdGesw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roZP1FcDJkAqmc9Ir0WUp4+rgqe84AsoeouVvMTdTnkUHLwRoyDcHv9Y+l157kYby
	 alm6tXU6iYhAENHLFpSKFGq7aADZUwt/mxcX5zaZpeic5Beeo8tty2VpF3anlETEhq
	 uLiF7C2cbBxsx8PAdn9FMLAdLhH7NqWOGUXmA54c8P/g2mTOepnvE+66gOFzKqHmEG
	 KqCeb2g3l7NQdZZobWpg3Im2QAR6hhAG/rb8XNjIH4tOE1kdzS3OD9BvzRXjzlAR/e
	 sAS6EwfI4d2mIX3v10MmvIybtETG4zVyVvexqMSn/EKFTan9TolX2Aqa3QnMNmrxa2
	 5j7Nzi6sN2tvQ==
Date: Mon, 9 Sep 2024 09:40:17 +0100
From: Simon Horman <horms@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lukma@denx.de, ricardo@marliere.net,
	m-karicheri2@ti.com, n.zhandarovich@fintech.ru,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+02a42d9b1bd395cbcab4@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: hsr: prevent NULL pointer dereference in
 hsr_proxy_announce()
Message-ID: <20240909084017.GT2097826@kernel.org>
References: <20240907190341.162289-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907190341.162289-1-aha310510@gmail.com>

On Sun, Sep 08, 2024 at 04:03:41AM +0900, Jeongjun Park wrote:
> In the function hsr_proxy_annouance() added in the previous commit 
> 5f703ce5c981 ("net: hsr: Send supervisory frames to HSR network 
> with ProxyNodeTable data"), the return value of the hsr_port_get_hsr() 
> function is not checked to be a NULL pointer, which causes a NULL 
> pointer dereference.
> 
> To solve this, we need to add code to check whether the return value 
> of hsr_port_get_hsr() is NULL.
> 
> Reported-by: syzbot+02a42d9b1bd395cbcab4@syzkaller.appspotmail.com
> Fixes: 5f703ce5c981 ("net: hsr: Send supervisory frames to HSR network with ProxyNodeTable data")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Thanks,

I agree with your analysis; that the cited commit introduced this problem;
and that this is an appropriate solution.

Reviewed-by: Simon Horman <horms@kernel.org>

