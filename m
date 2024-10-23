Return-Path: <netdev+bounces-138192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272249AC8C7
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568971C21109
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ED41AA785;
	Wed, 23 Oct 2024 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbUWV9Cs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229AF1B813;
	Wed, 23 Oct 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729682411; cv=none; b=grUEj70Ph55ITN7oIhOSJ94AA5A87q9g83lWnt3STi7dPRsBmrPO6iVp63Ks5JsOd0nr+j7X8pa2cyfqXlIcdZtuRxOM7MkvDM5SHHSxvuZTiyGPtHtIo6MQlZTsdTgMTPOxj2iN/RBF+AUFNkttJ6T7Lsri/dVZW9QF4Am7bvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729682411; c=relaxed/simple;
	bh=tc4l2Y6qujgXL1mb4ojYmiIMvOzve59JJSCmIJ+XW+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCppZdfsLTr0uBIGjiMabmU4MEKhqL/htHN4UvYDcxfh5u0tYrk0NZRUMpBGUuzsoHtPxd7Vfr2sVdLpWpLcnT/D7Pya3wGTnZ48ZpSvkz2OMwsvffDp8ySVhsJNeVSzxFbAKMwZGp6G3AHJiyKDGeHzUqe3uFm/fgMWr7s7pe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbUWV9Cs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F02C4CEC6;
	Wed, 23 Oct 2024 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729682410;
	bh=tc4l2Y6qujgXL1mb4ojYmiIMvOzve59JJSCmIJ+XW+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbUWV9CsjLgcLVxkjj6MbHCxwwkjEhim+kIbovtrZEWf/RUGeALso976xhda5BPbo
	 9YxD+w5Fna8Y+/5of3YUc1eIASxnc+etA5geexLSOPIK5ITCDu0H0+oB+EMtal+vQ/
	 OB5D4b9Sh5CCjtvjTw3e3KnPLScTdIq3bJp29i0lEopFZ1Ex9ZzacapD0+jRc6ESBH
	 sx5wK3pIdOKTy6/QD6TTf/SHNWwlyWUHC/XMaDT0Oyg9qVmlDCcQKxMnuSM+ZlZY6v
	 JskejtRimt+PMwEaUACIpfRke6ImGPuddUW9CB7oEkzGbqOI5bmO9vr6b37UvKt/5p
	 atpLNMYG0qDQQ==
Date: Wed, 23 Oct 2024 12:20:05 +0100
From: Simon Horman <horms@kernel.org>
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lftan.linux@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next, v1 0/3] net: stmmac: dwmac4: Fixes bugs in
 dwmac4
Message-ID: <20241023112005.GN402847@kernel.org>
References: <20241021054849.1801838-1-leyfoon.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021054849.1801838-1-leyfoon.tan@starfivetech.com>

+ Andrew, Giuseppe, Maxime, linux-arm-kernel, linux-stm32

On Mon, Oct 21, 2024 at 01:48:45PM +0800, Ley Foon Tan wrote:
> This patch series fixes the bugs in the dwmac4 drivers.
> 
> Based on the feedback in [1], split the patch series into net and net-next,
> and resubmit these three patches to net-next.
> 
> [1] https://patchwork.kernel.org/project/netdevbpf/cover/20241016031832.3701260-1-leyfoon.tan@starfivetech.com/
> 
> Ley Foon Tan (3):
>   net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC mask and shift macros
>   net: stmmac: dwmac4: Fix the MTL_OP_MODE_*_MASK operation
>   net: stmmac: dwmac4: Receive Watchdog Timeout is not in abnormal
>     interrupt summary
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac4.h     | 4 ++--
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 4 ++--
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c | 6 ++++--
>  3 files changed, 8 insertions(+), 6 deletions(-)

Hi Ley Foon Tan,

Thanks for the updates.

A few more points on process. Sorry for not pointing these out earlier.

* Please base the CC list on the output of get_maintainers.pl FILE.patch.
  b4 can help with this.

* Please do not include Fixes tags in patches for net-next
  (while please do for patches for net).

  If you wish to cite a patch you can use the following form,
  which may be line-wrapped, in the commit message (above the
  Signed-off-and other tags).

    Some text describing things that relate to
    commit 48863ce5940f ("stmmac: add DMA support for GMAC 4.xx")

    Signed-off-by: ...

* Please include some informative text in the cover letter.
  It will form part of git history. E.g.:

  - [PATCH net-next 0/3] net: sysctl: allow dump_cpumask to handle higher numbers of CPUs
    https://lore.kernel.org/all/20241017152422.487406-1-atenart@kernel.org/

  Which became:

  - Merge branch 'net-sysctl-allow-dump_cpumask-to-handle-higher-numbers-of-cpus'
    https://git.kernel.org/netdev/net-next/c/94fa523e20c3

More information on process for Networking patches can be found here:
https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: changes-requested

