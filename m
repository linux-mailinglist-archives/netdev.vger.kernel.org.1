Return-Path: <netdev+bounces-38219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2BB7B9CC8
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 68ECD281AB9
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 11:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1F6134A8;
	Thu,  5 Oct 2023 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lrd+4GNY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29F125B9
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 11:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1559C3278F;
	Thu,  5 Oct 2023 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696506241;
	bh=9S3XPaei5Hs4cBIZ21emTSZSs610PV4eDaKI5Q00L8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lrd+4GNYq6JYWhNiUPWJFO2CMFBR3kkJkrV24vDshQ2pi2sCFehGj90t00bX2kgOl
	 duguPsgCc1M7yC/UFYzpoXpc8voUQi0/GqCr2Eo2MatQ84CpUH2QhKTAlQhcLdilry
	 wejIeQCmTy5zXzs90zAEKXRw6ljLr4DvsvSifKBbsdddDOIkTFM/wMmkzlWBJsh3of
	 Kx6wu6OF4FIT3i9PiFdRFHznTLCLbSq9jq4PZM3dDq2Vro2TRyKVuiVs0ijiIaQcVz
	 WOKxRT1OIKo4OJIOWEamVVhDHiHTz4DzHFhMnCUq9yzY4jVXXaBbO1VFssgci6hy7Y
	 JKEbE7J7kkIDw==
Date: Thu, 5 Oct 2023 13:43:56 +0200
From: Simon Horman <horms@kernel.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: stmmac: remove unneeded
 stmmac_poll_controller
Message-ID: <ZR6hfMSSbMvHozaM@kernel.org>
References: <1c156a6d8c9170bd6a17825f2277115525b4d50f.1696429960.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c156a6d8c9170bd6a17825f2277115525b4d50f.1696429960.git.repk@triplefau.lt>

On Wed, Oct 04, 2023 at 04:33:56PM +0200, Remi Pommarel wrote:
> Using netconsole netpoll_poll_dev could be called from interrupt
> context, thus using disable_irq() would cause the following kernel
> warning with CONFIG_DEBUG_ATOMIC_SLEEP enabled:
> 
>   BUG: sleeping function called from invalid context at kernel/irq/manage.c:137
>   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 10, name: ksoftirqd/0
>   CPU: 0 PID: 10 Comm: ksoftirqd/0 Tainted: G        W         5.15.42-00075-g816b502b2298-dirty #117
>   Hardware name: aml (r1) (DT)
>   Call trace:
>    dump_backtrace+0x0/0x270
>    show_stack+0x14/0x20
>    dump_stack_lvl+0x8c/0xac
>    dump_stack+0x18/0x30
>    ___might_sleep+0x150/0x194
>    __might_sleep+0x64/0xbc
>    synchronize_irq+0x8c/0x150
>    disable_irq+0x2c/0x40
>    stmmac_poll_controller+0x140/0x1a0
>    netpoll_poll_dev+0x6c/0x220
>    netpoll_send_skb+0x308/0x390
>    netpoll_send_udp+0x418/0x760
>    write_msg+0x118/0x140 [netconsole]
>    console_unlock+0x404/0x500
>    vprintk_emit+0x118/0x250
>    dev_vprintk_emit+0x19c/0x1cc
>    dev_printk_emit+0x90/0xa8
>    __dev_printk+0x78/0x9c
>    _dev_warn+0xa4/0xbc
>    ath10k_warn+0xe8/0xf0 [ath10k_core]
>    ath10k_htt_txrx_compl_task+0x790/0x7fc [ath10k_core]
>    ath10k_pci_napi_poll+0x98/0x1f4 [ath10k_pci]
>    __napi_poll+0x58/0x1f4
>    net_rx_action+0x504/0x590
>    _stext+0x1b8/0x418
>    run_ksoftirqd+0x74/0xa4
>    smpboot_thread_fn+0x210/0x3c0
>    kthread+0x1fc/0x210
>    ret_from_fork+0x10/0x20
> 
> Since [0] .ndo_poll_controller is only needed if driver doesn't or
> partially use NAPI. Because stmmac does so, stmmac_poll_controller
> can be removed fixing the above warning.
> 
> [0] commit ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
> 
> Cc: <stable@vger.kernel.org> # 5.15.x
> Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Reviewed-by: Simon Horman <horms@kernel.org>


