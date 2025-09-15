Return-Path: <netdev+bounces-223150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76118B580CB
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22846174DBE
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF74833EB03;
	Mon, 15 Sep 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj0weWAT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16031D759;
	Mon, 15 Sep 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949771; cv=none; b=smV2k28Qx5zB7Db28OWmR0hHLzcNm84E7ZJMIkPFsmWvK48KeTDH6VPw50vwsv7Jj9lkanSR/ahqKcoohlpbPrjcMnORCSxL267CdWlhQe1IpIcBdxgm+radMtxVkSzzwIZ7+7FnzFGfy0Sg5I82w278D8dE1TZKTXGMCPbZhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949771; c=relaxed/simple;
	bh=JSzvbkXOJg9BXxEa0MHPpMeynEkhA7kZLk8rHsVGNDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lV4gdouRD6k44K8SjUq2SHBuH0eepo25EGKeZrubtF8xR/HrXKTokyEiDmYHgsUk0YlhdJ4c+fnT8gnQD/dqp1f2PBnmgD0pcmxKnPwR6FFEEHZ5agLwtJocNpPg2cpw8E8QbXJVFiqgLXDJsA+xrey0dGTAjQVmSYE0xoQN+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj0weWAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51443C4CEF1;
	Mon, 15 Sep 2025 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757949771;
	bh=JSzvbkXOJg9BXxEa0MHPpMeynEkhA7kZLk8rHsVGNDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lj0weWATIjX4O++pKQvjP2ceysxsCnKvnWwa08rWWNG/p8JEbWLHni0q+XMvMgqVK
	 muuSprQI22ffBzUOPITrArPHE5xliQqvM7rTlzYy47PIKpng1eKbCdvpnQQVj1+mjs
	 6YrND3evYMh3QuU8NU8ptNeGeBGPdLWmwtZqZiB41mrbnpnU9xGDrEUPNgZ9XjjHOB
	 cAyZkwYv+soEdz/R3kUzJoGEKsZrAh6MK52JNM6Mo9127hv2BXyvxdM3+qhX6MkxZ8
	 RHpM1kBrtex10Ycid973+gMrpPokzEmMLvhi87Y0slGRTn9tyeG3UFBsBxaOI1foOA
	 g5pBP7Q6TB0cQ==
Date: Mon, 15 Sep 2025 08:22:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lei Yang <leiyang@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Message-ID: <20250915082249.05be3259@kernel.org>
In-Reply-To: <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
	<CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 18:50:15 +0800 Lei Yang wrote:
> Hi Breno
> 
> This series of patches introduced a kernel panic bug. The tests are
> based on the linux-next commit [1]. I tried it a few times and found
> that if I didn't apply the current patch, the issue wouldn't be
> triggered. After applying the current patch, the probability of
> triggering the issue was 3/3.

I really doubt the warning you're reporting is related to this series.

