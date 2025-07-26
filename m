Return-Path: <netdev+bounces-210257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43088B12800
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 02:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB2C1CC3E35
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E562381BA;
	Sat, 26 Jul 2025 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yexe2ilW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C3E28FD;
	Sat, 26 Jul 2025 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489549; cv=none; b=iCYOBBkSEcoM/FJJU71Q3nz7+Ntp3axMzHbi3t1j3M1RdK4HEceBtgHcTI3x7VrPgAEcuAn95Zq89u2LOPPDWRfIzEenvsqhLK5Ot2cqxItg3Y0E6sqv3PYZLkPMBNFz4fXXvnPmabs/0iZ0peqlakyry/mNBACy1LoqnHuH+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489549; c=relaxed/simple;
	bh=Dko3kWgCT0Ys++R7H9KuFtq5eskVkBM8MOSnrUZdmSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fX0SR+Dqed6f69P91wjFPHFuIP6WCScMZcDvGRtFLeIqD032O4lLGERnKVaIBU7UXA4L3H+OkqY2/NkkWJa4AXCnDAXw2XOww9t4Gm40EYOJL04hTwOUVhflWD4aMQRFW77INMWWyE6G9nmF9Q306+/GDGNN6YSAtIf2WDO0Tc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yexe2ilW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4FDC4CEE7;
	Sat, 26 Jul 2025 00:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753489548;
	bh=Dko3kWgCT0Ys++R7H9KuFtq5eskVkBM8MOSnrUZdmSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yexe2ilWaZpg4EONL/tBPagglcnpt1t2mC9YTEcUOirFA4Vjm4ooF6XzXKBMUZQy9
	 e2gZLxn6Co3PeNaQ0UipNCoc2PI93Jj8A/gkcq7IQ6DMgssqfM6JIThKV52QPiU/Vd
	 FgVV5nQVPFRRXoZEJw6rQFPy104fmqwxEdk+NKJcbAH6JbAC8gdpGrhzJCsaY08bUr
	 l5njw75dvCUEP8KWSrqLiS60IJ2TxwiFhme/Zn+9uqm2mZ3q4sWr/InoxUxsXEdpzo
	 geQAjruPoUDFOv+QCfwiC641tZFmFBgG9vj3uiRAWFna8d6J5vEedJkNhIRhsa6SJn
	 ROuZXyfueL8Zg==
Date: Fri, 25 Jul 2025 17:25:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Richard Cochran
 <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/2] net: stmmac: allow generation of flexible
 PPS relative to MAC time
Message-ID: <20250725172547.13d550a4@kernel.org>
In-Reply-To: <20250724-relative_flex_pps-v1-0-37ca65773369@foss.st.com>
References: <20250724-relative_flex_pps-v1-0-37ca65773369@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 14:31:17 +0200 Gatien Chevallier wrote:
> When doing some testing on stm32mp2x platforms(MACv5), I noticed that
> the command previously used with a MACv4 for genering a PPS signal:
> echo "0 0 0 1 1" > /sys/class/ptp/ptp0/period
> did not work.
> 
> This is because the arguments passed through this command must contain
> the start time at which the PPS should be generated, relative to the
> MAC system time. For some reason, a time set in the past seems to work
> with a MACv4.
> 
> Because passing such an argument is tedious, introduce
> STMMAC_RELATIVE_FLEX_PPS config switch so that the MAC system time
> is added to the args to the stmmac_ptp driver.
> 
> Example to generate a flexible PPS signal that has a 1s period 3s
> relative to when the command was entered before and after setting
> STMMAC_RELATIVE_FLEX_PPS:
> 
> Before: echo "0 175xxxxxxx 0 1 1" > /sys/class/ptp/ptp0/period
> 
> After: echo "0 3 0 1 1" > /sys/class/ptp/ptp0/period

Kconfig doesn't seem like a great way of achieving the outcome.
Some per-platform knob would be better.
But ideally we wouldn't do either. Could we possibly guess which
format user has chosen based on the values, at runtime?

