Return-Path: <netdev+bounces-23316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEAF76B89C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34329281A60
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453A120EA;
	Tue,  1 Aug 2023 15:31:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285324DC8E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747A6C433C7;
	Tue,  1 Aug 2023 15:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690903895;
	bh=r5PsDp4On77OijBSy4XSqE+fneVpZ8oOUEVwG1Kl+9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0RGgnIbA43f0C/Gz6u+PEFaV0HmpD2KHxGJ/ctZfU4xX8Iwh/7s0NbTczNGAecDe
	 Ajiw/uAN6p9Ybak/3g4GkTJZEdEtM2sS1o9qq+KSwcPv9EMLSTplcxoTXcihyDpolz
	 HPWr7zF5DesQ4AVvRnLQRNHXaEBCNenTWaXx+yDEKA3VKD7S3Acqq+h8sAqECHHsY6
	 DMcT4kR9W2J4Hpu71Ut0dnkUaK+RzRtCYnb/SR8zdS1Wfe4p+hMGeOIumz86yC+nrs
	 kPyneppF67RAcP661vd1IgCDu3IGBfXSUzJr+GR+PA4YGMQW7mwpsr+37jv3O+aust
	 +BlVlIu8JLFCQ==
Date: Tue, 1 Aug 2023 17:31:29 +0200
From: Simon Horman <horms@kernel.org>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH V7 net] net: mana: Fix MANA VF unload when hardware is
Message-ID: <ZMklUch+vfZBqfAr@kernel.org>
References: <1690892953-25201-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690892953-25201-1-git-send-email-schakrabarti@linux.microsoft.com>

On Tue, Aug 01, 2023 at 05:29:13AM -0700, Souradeep Chakrabarti wrote:

...

Hi Souradeep,


> +	for (i = 0; i < apc->num_queues; i++) {
> +		txq = &apc->tx_qp[i].txq;
> +		while (skb = skb_dequeue(&txq->pending_skbs)) {

W=1 builds with both clang-16 and gcc-12 complain that
they would like an extra set of parentheses around
an assignment used as a truth value.

> +			mana_unmap_skb(skb, apc);
> +			dev_consume_skb_any(skb);
> +		}
> +		atomic_set(&txq->pending_sends, 0);
> +	}
>  	/* We're 100% sure the queues can no longer be woken up, because
>  	 * we're sure now mana_poll_tx_cq() can't be running.
>  	 */
> -- 
> 2.34.1
> 
> 

