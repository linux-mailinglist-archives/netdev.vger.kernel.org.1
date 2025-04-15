Return-Path: <netdev+bounces-182555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A66A8913F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B953A9066
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EDC1F5616;
	Tue, 15 Apr 2025 01:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmH07lrM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BEE3C463;
	Tue, 15 Apr 2025 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680502; cv=none; b=QE7iEJV/h+vU4tTcl6TQO2smvIS1YV0wUNJLF6EbtWkyvsNy6xK/A8L3pA2fLH/mbPrdkZOTU5ewrHfXL+5pzOO/vRlkwfeFG6ibMh7zn5Wlpbe/kK/KwMWgy7uCqfscfKjM955JyqjLH3cFAyTCnELhtVCWWrZm4PybCqmmk3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680502; c=relaxed/simple;
	bh=qOiLzz5Ys8eSSLqOWk5VgHA3ONL6mmYMIxRWgNUdq0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQKKc0t6oNJeRBgOf9YRRakABxCcH48FfNa7e1hXSzyhVb85d1ECBDHuYdduQZApm1VOb4nPQtVj4UKWtEeZuUPCjMJo2eGKoJtJK7uF3voyBSP8GAmlnAk3mffs4kjoOqN+d3l5qPFlrElFLUUfiTt7sHntsmfh/Rtka3znNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmH07lrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD09C4CEE2;
	Tue, 15 Apr 2025 01:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744680501;
	bh=qOiLzz5Ys8eSSLqOWk5VgHA3ONL6mmYMIxRWgNUdq0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HmH07lrMHaqvYw2TUmzSVnmklXNNFlYxJPI6IJEXLClrjQEwLdeDGu7a5pKuVGjnT
	 UQHg4viqaE+XD/0YfBHNAzyqIf1q2dOTlRNz+ZS0M2CfEUrGbd+K3zW52t+caMHZzh
	 NxPV+fGt7E37dD8jmElvwG/HyQfY9Xg6tRn1K3o2Z65urYXd/CRCZUSbZRyHx7gHsp
	 329nHQ7eSvNZfIz/NcxCPOyzEhXj+dt1vdlUi2CIvaR3rxR0G++WR6FBChvwTMGFj9
	 u0BcCSav4jHIEN9JwTwAS3vCTEHuyh4DvE9C+4igenTlFtZvaxaG2T9pV7kSu0x+nk
	 ahGsmqeDHgO+A==
Date: Mon, 14 Apr 2025 18:28:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: Fan Gong <gongfan1@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Lee Trager
 <lee@trager.us>, <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>, Cai Huoqing
 <cai.huoqing@linux.dev>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Suman Ghosh
 <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Joe
 Damato <jdamato@fastly.com>
Subject: Re: [PATCH net-next v10 1/1] hinic3: module initialization and
 tx/rx logic
Message-ID: <20250414182820.370e9feb@kernel.org>
In-Reply-To: <f74da5b6deceacf4e21cd6fa126e88acd3e8b824.1744286279.git.gur.stavi@huawei.com>
References: <cover.1744286279.git.gur.stavi@huawei.com>
	<f74da5b6deceacf4e21cd6fa126e88acd3e8b824.1744286279.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 15:15:51 +0300 Gur Stavi wrote:
> +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		dev_warn(&pdev->dev, "Couldn't set 64-bit DMA mask\n");
> +		/* try 32 bit DMA mask if 64 bit fails */
> +		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +		if (err) {
> +			dev_err(&pdev->dev, "Failed to set DMA mask\n");
> +			goto err_release_regions;
> +		}

Please take a look at commit 004464835bfc ("hinic: Remove useless
DMA-32 fallback configuration"). This construct was removed in your
other driver now you're bringing it back.

