Return-Path: <netdev+bounces-148309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF24D9E115E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E3D16533C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 02:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D065A7AA;
	Tue,  3 Dec 2024 02:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlkySCNM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2B4558BB;
	Tue,  3 Dec 2024 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193267; cv=none; b=o985jmfemPwyMB2fxZ2v9T9sBcocnZH2KCNAQfT+RUbwQG/S8pnu3wLy1yYCzlPfEcLeaWfcy2w6z6W5mM0d6BBarR7UmP2apLvgvRCzSODTMbmkwCuVOqw4LrDDUdz5yBS/P+izU/wKdHwb5d9XNadWKscziNXd4e2dg4ZQ/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193267; c=relaxed/simple;
	bh=9JE5ip2L5ouGt0z5lwAg62YYu/vSbq3Mo3C/T0xH0CM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMmEz0JjN01gMck7bcB4PJtGgnkYrXdxkvUpdC0DjZ0aczPZyhPbhgRZyRWimk71J1C8LROZSxUJJXCQnm1IupyVM68ZeDziMU+SBBmz7YZhH/dAGomn5UralRErdNC8oKs2kxLHmaljTmxPleB4komEuqusgetJeLEfeSMnZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlkySCNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAADC4CED1;
	Tue,  3 Dec 2024 02:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733193267;
	bh=9JE5ip2L5ouGt0z5lwAg62YYu/vSbq3Mo3C/T0xH0CM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KlkySCNMcwNPFqyfUgBGbehIGWTkdlEjXEdH5GQI09WE4a0bQfq0GD41itaMZGVjJ
	 UZ/ryNxkrEjDXr0vVRWjTAIhey4741FPATykr/HyrJqwf3F4oLvp7ZNiruwdqLrVCZ
	 BA3w6rZLNggrVwq6LNns8HWq9Xe1EGPG7B+iVDYRZvGqeGHedGd0U0vR5tmv3adHr8
	 AHY5UNqDLb177o7aDmwulNV4EXtcU6wNgbUGGsfzJtg5sT5GnnFCt/u0ZW7Va1dxC3
	 WUREEPyiWPxSmDHDMkuMbaNdtHlI1zThDQpVfJBUpRDC+SL25dOOHAFOEIxaNMmtGp
	 onoWaa1578JYA==
Date: Mon, 2 Dec 2024 18:34:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com, Suraj Jaiswal
 <quic_jsuraj@quicinc.com>, Thierry Reding <treding@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap
 for non-paged SKB data
Message-ID: <20241202183425.4021d14c@kernel.org>
In-Reply-To: <20241203100331.00007580@gmail.com>
References: <20241021061023.2162701-1-0x1207@gmail.com>
	<d8112193-0386-4e14-b516-37c2d838171a@nvidia.com>
	<20241128144501.0000619b@gmail.com>
	<20241202163309.05603e96@kernel.org>
	<20241203100331.00007580@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 10:03:31 +0800 Furong Xu wrote:
> I requested Jon to provide more info about "Tx DMA map failed" in previous
> reply, and he does not respond yet.

What does it mean to provide "more info" about a print statement from
the driver? Is there a Kconfig which he needs to set to get more info?
Perhaps you should provide a debug patch he can apply on his tree, that
will print info about (1) which buffer mapping failed (head or frags);
(2) what the physical address was of the buffer that couldn't be mapped.

