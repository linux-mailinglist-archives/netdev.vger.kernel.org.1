Return-Path: <netdev+bounces-128765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF74097B930
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 10:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EECB295E9
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669A6185B66;
	Wed, 18 Sep 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ7wgWuC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C279185939;
	Wed, 18 Sep 2024 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647398; cv=none; b=L246vHPT4Do8sO2lL+iVo1s4QReySwvKC8c8Et1d7EVgbeY+4t6Im7y/8z2OK2a5liFhIOxylCc5ujcFZFDPuhlOucW5Gt1LiH+ejnAHC8alW5vKJ/J63tb7aiwWt1Yg5uow89YGfQoe+paZ8T1XxpMnspm6f8UaxPgoUEUrztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647398; c=relaxed/simple;
	bh=HdC/s+4IDjIyq0DJlaC1jI1NNqleZp92TjfIk8thLgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7qryiFjU2NuKPoq2wMQ1pG6cd+iLplVT7FYp53scnXrW2uLAaV2yksgRj/Hr0oB9LhcXYZv8Kov02/MAy6t0l/Hu5doJI/P5SQGtucXLTlakc7OClT6Oir4hmASdPvtE3a89bIUXjEczmFnQ0uwenxcCEThsdHRt7QvBaXm0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ7wgWuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A98DC4CECD;
	Wed, 18 Sep 2024 08:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647397;
	bh=HdC/s+4IDjIyq0DJlaC1jI1NNqleZp92TjfIk8thLgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJ7wgWuCdli6NO899TLGIii0tOyLCbzPyhf88B/gff0HapjU4Crv3882V7Bhg73ps
	 ZEVB0kwsZxfp8MihZoZQqI9FcPPgAJy09zkQb0z4SjXltwtwtqflzL9S5ugKCCAlyH
	 w0CTMUE+X6R+eRKbBG40h1aFkkWU07CoR3XW6v/xnuz9HwxJMtQ3G7gY1ihJIt8gf3
	 RTTkUH3gQOS3tV/1/M2cfb/6lT+F2Dqqbt2nLCMjkiCArVTc5m1tJBgoiKn07WarBK
	 D4Bvkak/vMtytGbRw1MctObRW02jUoGOeHtOUs2udG1C/CU4TL+Fl2zr1fAVxSQpxY
	 gFvNILaJCcVYg==
Date: Wed, 18 Sep 2024 09:16:32 +0100
From: Simon Horman <horms@kernel.org>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Wong Vee Khee <vee.khee.wong@intel.com>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Chuah Kim Tatt <kim.tatt.chuah@intel.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-imx@nxp.com
Subject: Re: [PATCH net] net: stmmac: dwmac4: extend timeout for VLAN Tag
 register busy bit check
Message-ID: <20240918081632.GU167971@kernel.org>
References: <20240917164206.414714-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240917164206.414714-1-shenwei.wang@nxp.com>

On Tue, Sep 17, 2024 at 11:42:06AM -0500, Shenwei Wang wrote:
> Increase the timeout for checking the busy bit of the VLAN Tag register
> from 10µs to 500ms. This change is necessary to accommodate scenarios
> where Energy Efficient Ethernet (EEE) is enabled.
> 
> Overnight testing revealed that when EEE is active, the busy bit can
> remain set for up to approximately 300ms. The new 500ms timeout provides
> a safety margin.
> 
> This modification does not impact normal success path, as the function
> typically returns within 1µs in non-EEE scenarios. The extended timeout
> only affects the failure path.
> 
> Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

Hi Shenwei Wang,

It looks like this function now uses udelay() to busy-wait for up to 500ms.
But 500ms, or indeed 300ms, seems like a long time to tie down a core.  I
wonder if some other sort of mechanism, f.e. involving msleep or delayed
work, should be considered.

...

