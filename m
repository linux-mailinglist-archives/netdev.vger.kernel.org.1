Return-Path: <netdev+bounces-21697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C67C764509
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E50B1C2132F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 04:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685E11C3F;
	Thu, 27 Jul 2023 04:46:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE54ED5
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 04:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43147C433C7;
	Thu, 27 Jul 2023 04:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690433174;
	bh=jJ20dTz0Ym/WtEBrhoTt2d94CftbA+6S89ow3P/mlHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pgQpzzB/RMyil955eazEmMtK4Qjjx8AUa3A+ajzsNcmsUSIl6UmVeFzQTxIK8UrvB
	 0/2epuF3Cv08aLngfCQg/af9vhAKkvPvpy8yPiNNQqLOR3I7eUBNuR4VxCG3H0Ec+4
	 QTs/uco97fYzWvdAIaZ7PCu173jYhqOKbXXcjICdjwLnAuOmQYEn3MsprOlrLpfjLr
	 45k0ZmYGDLCb3/5hjK8MffP9nBU4fA8Q+QvZt+4Gt6JkCcJmPb5UxcmFzC8TZA0nzS
	 tbtqbw00ZDvtxJLDuM23NFE5Jj3OrLIj4znIckTSPIpnLdAhhd95TiVZYqyxoE5Wfx
	 9uVYqjmg+XI6w==
Date: Wed, 26 Jul 2023 21:46:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: isdn@linux-pingi.de, alexanderduyck@fb.com, duoming@zju.edu.cn,
 yangyingliang@huawei.com, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mISDN: hfcpci: Fix potential deadlock on &hc->lock
Message-ID: <20230726214613.7fee0d7b@kernel.org>
In-Reply-To: <20230725173728.13816-1-dg573847474@gmail.com>
References: <20230725173728.13816-1-dg573847474@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 17:37:28 +0000 Chengfeng Ye wrote:
> As &hc->lock is acquired by both timer _hfcpci_softirq() and hardirq
> hfcpci_int(), the timer should disable irq before lock acquisition
> otherwise deadlock could happen if the timmer is preemtped by the hadr irq.
> 
> Possible deadlock scenario:
> hfcpci_softirq() (timer)
>     -> _hfcpci_softirq()
>     -> spin_lock(&hc->lock);  
>         <irq interruption>
>         -> hfcpci_int()
>         -> spin_lock(&hc->lock); (deadlock here)  
> 
> This flaw was found by an experimental static analysis tool I am developing
> for irq-related deadlock.
> 
> The tentative patch fixes the potential deadlock by spin_lock_irq()
> in timer.
> 
> But the patch could be not enough since between the lock critical section
> inside the timer, tx_birq() is called in which a lot of stuff is executed
> such as dev_kfree_skb(). I am not sure what's the best way to solve this
> potential deadlock problem.

Yeah, the dev_kfree_skb() should be dev_kfree_skb_any() or _irq()

> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

LGTM, but please repost with a Fixes tag added.
-- 
pw-bot: cr

