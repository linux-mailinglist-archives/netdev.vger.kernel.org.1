Return-Path: <netdev+bounces-156907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF6CA08430
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 01:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB2C168468
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9B12942A;
	Fri, 10 Jan 2025 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCbRiwgs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7AEEB5;
	Fri, 10 Jan 2025 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736470490; cv=none; b=jqtme9odF9FXM2OwkdsYwpZlnVG5EgIWTvBo/1b0fbHeD2i+FL4/MO1el2nxyCv44iyR+hwZK88CzizwscXz48xZMUANZ8QAEOcyPgqmt8ojYJFEzd2uG2y1Twvj1rEkzT/E3kpbUB0D+pxbm0hcgkRB+YHtjdMyz9afpp03VaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736470490; c=relaxed/simple;
	bh=An7XqfSUMLwrY40eKxuhc/R7ct4U+ZFUuaL7mUE2bBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nl6i/IoK36U6BLVMRmcnSFfITnWrYMfCQPqLj7naORAKrf1b165pUoPhwQB5GS3nzse7XVUek6AEcSOpFQ7m5ZJoAmFtTe0cj8wGTwVDlqwvrv93laZsnxiaBluNd3ZM9y/Nq02vSImbCEbr7Q5rhMnXAZ0YtSdfkQsyygd+cnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCbRiwgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A477C4CED2;
	Fri, 10 Jan 2025 00:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736470489;
	bh=An7XqfSUMLwrY40eKxuhc/R7ct4U+ZFUuaL7mUE2bBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aCbRiwgsgoH9GYITCVeOe1M59ZZvJNVbVpgb6KdwJaADf31LmsNnBIvPZ8i+x6dza
	 yLRbCYYMWJTjDxQJVhBbbz9j38SVdse0DgQB5Z8fMYtXZcdtHvh0AWRRF1RCH0JHnJ
	 X4HE/IoddNq5d3tFw8uGZVC6LAPMyZoNz52Uvyh0bdJZ4ZMJ+6g5px7EmajI8CyrYI
	 QlEasfKwtF9LDjoo0M+F/4mqhV0tABhGoZc8KogfpSVdiZv6lf9GaApZniVxTp1NOy
	 EF6EjPGSjZYSz6XoFNMg6UyZmC9vRWp91rv7kw5TNlSfu2+DCRxPDshcNbQDshQfvZ
	 f9ymmynN6L2IA==
Date: Thu, 9 Jan 2025 16:54:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Parker Newman <parker@finest.io>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Parker
 Newman <pnewman@connecttech.com>
Subject: Re: [PATCH net v2 1/1] net: stmmac: dwmac-tegra: Read iommu stream
 id from device tree
Message-ID: <20250109165448.53cb3e48@kernel.org>
In-Reply-To: <6fb97f32cf4accb4f7cf92846f6b60064ba0a3bd.1736284360.git.pnewman@connecttech.com>
References: <6fb97f32cf4accb4f7cf92846f6b60064ba0a3bd.1736284360.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jan 2025 16:24:59 -0500 Parker Newman wrote:
> Nvidia's Tegra MGBE controllers require the IOMMU "Stream ID" (SID) to be
> written to the MGBE_WRAP_AXI_ASID0_CTRL register.
> 
> The current driver is hard coded to use MGBE0's SID for all controllers.
> This causes softirq time outs and kernel panics when using controllers
> other than MGBE0.

Applied, thanks!

