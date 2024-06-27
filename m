Return-Path: <netdev+bounces-107491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CC991B2EA
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC2F283678
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E521A2FC3;
	Thu, 27 Jun 2024 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4JdBBlr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B3199E93
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531700; cv=none; b=rTA9waSiyGy506dtELoRg8bHKELv9C24r/+73avIISFn/HOQZhmZHDHk6LKLW5mTBCUz7RDBNWcAkF6QA+3XQbiAH/vaoY5HXd1NqhR0u8fGaQuY4YBbUbfM+TvsqYyhmacQFDu/NdwtQyCdXj5+CiOZju8ZiM5uZlc0ASUuU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531700; c=relaxed/simple;
	bh=4tRXmhyeszPGRAUfgxoKvpDa3pBb7x6V/7Zznn0Egn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryLKzWto1vmjgQuZW822YV2lLWtoPYmBiFfe/cXjCf9WqJ8Bypm8u+Iw1SOyvtPzkfNrvcv1Dn1J7bntIhB3qcPmn4fkIDyAALBT66fjz+Vmevuw2YoCF+Pdthc39Wds5JjYf/qrtMtb+r1mjkj4R/LAvVlCuepob7TRDgDaeTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4JdBBlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C49C2BBFC;
	Thu, 27 Jun 2024 23:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719531700;
	bh=4tRXmhyeszPGRAUfgxoKvpDa3pBb7x6V/7Zznn0Egn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N4JdBBlrD379qhiXWSRWgcPHvhIKEvwNbupbMebLkRcjMn/DKS9/ZpNWl/sMaQhUS
	 XfYnYaLbIjC0cqCNtcG3itnMmOPXLwIuVRlF9c4W0TpW4wTo/yb2DV44880bzoprdT
	 uySlzc0m9jZyLrCYdOQh0I3D3YNpH8qIiHKr4KwMvvINS21t6r/NnKF/aQpCXzUZZd
	 pxNAPS0jnAHymbUqPndA5um4RmXe/j5SJ8+ZYqed2dUC3eedPNh5Qn+S4BtEXOuq/6
	 iJqjz9rPNh/EEHL6HslJ24zsVVZz5UIMXN5A5Y9O/VzZfMiwTSa3xDslfql97ITY+w
	 7YF+kDYjw6DAQ==
Date: Thu, 27 Jun 2024 16:41:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, mengyuanlou@net-swift.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net v2 1/2] net: txgbe: remove separate irq request for
 MSI and INTx
Message-ID: <20240627164138.725aa957@kernel.org>
In-Reply-To: <20240626060703.31652-2-jiawenwu@trustnetic.com>
References: <20240626060703.31652-1-jiawenwu@trustnetic.com>
	<20240626060703.31652-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 14:07:02 +0800 Jiawen Wu wrote:
> When using MSI or INTx interrupts, request_irq() for pdev->irq will
> conflict with request_threaded_irq() for txgbe->misc.irq, to cause
> system crash. So remove txgbe_request_irq() for MSI/INTx case, and
> rename txgbe_request_msix_irqs() since it only request for queue irqs.

Do you have any users who need INTx support? Maybe you could drop
the support and simplify the code?

> Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  3 +-
>  .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 78 ++-----------------
>  .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |  2 +-
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  2 +-
>  4 files changed, 10 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 68bde91b67a0..99f55a3573c8 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1996,7 +1996,8 @@ void wx_free_irq(struct wx *wx)
>  	int vector;
>  
>  	if (!(pdev->msix_enabled)) {
> -		free_irq(pdev->irq, wx);
> +		if (wx->mac.type == wx_mac_em)
> +			free_irq(pdev->irq, wx);

It seems strange to match on type to decide whether to free an IRQ.
Isn't there or shouldn't there be some IRQ related flag informing
the library how to manage the IRQs?

