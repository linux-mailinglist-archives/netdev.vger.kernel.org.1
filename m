Return-Path: <netdev+bounces-116517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAE894AA1A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42BA1C20FE3
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1E26F30E;
	Wed,  7 Aug 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn7oGw9u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6BC74055
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040950; cv=none; b=rSii3ItUo62RldyqTIoZk5veADxJwLn8NUoZTx3Jl5eihyh9e6863dnUw+z2FP7Jb1UKpP/BNOQuqsyDRyvJSEuX5cC2CYlcHMZB/Fc/d3YX+1dMeiT3kHhn1gHPqqh31fD7QyO62Osckj/ZTooJAzx8eTxJkjMJXEpcfatMF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040950; c=relaxed/simple;
	bh=S5ejvTiRP/VuATmkOuj4eleNGp5PW7FM9C3XpETJazc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RspV1pE5UjIOL2ap2iVugMBm9geblqpgFxZMoYvNZ5XM1eKec+nwfynkfWV4b9fZFBwDA3rnM54tSzVKg77Gt+lkQAEaU0R6xFHuEUDAgx00aBltDu5n5dboHuK62D0sfbhR40f052Sa3Bk1hdlq72PrBZ+wG92RDX5mV5pWWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn7oGw9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76141C32781;
	Wed,  7 Aug 2024 14:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723040949;
	bh=S5ejvTiRP/VuATmkOuj4eleNGp5PW7FM9C3XpETJazc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wn7oGw9uOzVZjDeeQWMIcUB87q/5fzjqiyTMaUeCAmw38rAJS6NnBrEdQl3f8CSrB
	 OvH+Aks33egaKi65TBmRTbhYZUGT5eKX2N63OSrUI3sEFd05Bmlhxzrt+jDZXHhOTL
	 /2+eAjJQel0TJlj9NNnhB6Kqai82KX4DX2k0X6BNnZuYEveZRSi4shJ341nxRdjE6K
	 XRjgIbatO8IlSOs5axmv28dNPFhp2eKAhqzQqJU1nhJ/xLY4J+DhCvkG809dtbRWX/
	 1Ssj1C1FjD7mnr6v+HEsTTtEDlt44m+uRDt4+yBKakHbGXaZQr4DUxmsyFlA3QeGzw
	 X88zBGJiXPvXA==
Date: Wed, 7 Aug 2024 07:29:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Yonglong
 Liu <liuyonglong@huawei.com>
Subject: Re: [RFC net] net: make page pool stall netdev unregistration to
 avoid IOMMU crashes
Message-ID: <20240807072908.1da91994@kernel.org>
In-Reply-To: <523894ab-2d38-415f-8306-c0d1abd911ec@huawei.com>
References: <20240806151618.1373008-1-kuba@kernel.org>
	<523894ab-2d38-415f-8306-c0d1abd911ec@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 19:00:35 +0800 Yunsheng Lin wrote:
> > Note that page pool pages may last forever, we have seen it happen
> > e.g. when application leaks a socket and page is stuck in its rcv queue.  
> 
> We saw some page_pool pages might last forever too, but were not sure
> if it was the same reason as above? Are there some cmds/ways to debug
> if a application leaks a socket and page is stuck in its rcv queue?

I used drgn to scan all sockets to find the page.

> > Hopefully this is fine in this particular case, as we will only stall
> > unregistering of devices which want the page pool to manage the DMA
> > mapping for them, i.e. HW backed netdevs. And obviously keeping
> > the netdev around is preferable to a crash.

