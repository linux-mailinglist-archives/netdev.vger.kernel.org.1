Return-Path: <netdev+bounces-149649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F07A9E69E7
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE14165C05
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626C1E1C2B;
	Fri,  6 Dec 2024 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc2l+gXD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8471C3F2C
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476543; cv=none; b=OC6lRrLz6aNQEjEWFd2tMbCECa1AHYQSY8mrDfMwR3xF2Yy52Aw1QhLNOtySJzevU3XZDWjoRpX2agWMvWDN9CyK/BUR5tWkdh6S5PvMxB3+G/PaX3/OvNNBEr8lBXBD8B1sTjyrdd5ECzYLI2GPZmPbnpMG/MrK3QFHgfSLVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476543; c=relaxed/simple;
	bh=VrsxXtOGdhGBGvrlopwUqgH7QOvgpLcSjVd1qzNSHdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpC8Vuhq8HoRfJraMdL8n/meYe5jmSDtfANBxyUVxZOQHO+mVx178U97vDRezYy0WyT49OTOKTnuQwYC7zGYY3FEks+J2qoDltG/DqvsAQhOMwuJFKLBjr0EEVLyGMPLWruuRDjMkeKVTqxp9g4Lucbs9WhHWpre9Iiezp8AotY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc2l+gXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D94AC4CEDE;
	Fri,  6 Dec 2024 09:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733476543;
	bh=VrsxXtOGdhGBGvrlopwUqgH7QOvgpLcSjVd1qzNSHdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lc2l+gXDD/VxmF0XxiR41zyYjMVarBB9bpWTnWzx3c+FgKTKcOpsNCEihKmx+Avla
	 giK5s91rjAnGjI7MWcnapnNtZ4c8u1Mi5x2jDZDrF+XPK/hPpYqMJyI+TrZNcwV1Ns
	 8LD76XR+Xuo1XA35ZNUvC16ozSiG5WGs9bDbI1UtuWMcHAYgFcMzexKPgQzdHGjLMS
	 LW5LaARG3SXsoB48eF3vv1PmV0olDYIcgg9r+giUWNYi9H+DtrImEOpXm7+Zz4GUz6
	 oGEIrPQNEP4ALolwkupQWMcwGpnMC+bgXLwYSsujDwwVzJ95wY3BsEtm38BW6y71EN
	 vmNmz7Qsr8csQ==
Date: Fri, 6 Dec 2024 09:15:39 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net] net: hibmcge: Release irq resources on error and
 device tear-down
Message-ID: <20241206091539.GG2581@kernel.org>
References: <20241205-hibmcge-free-irq-v1-1-f5103d8d9858@kernel.org>
 <20241205205511.GF2581@kernel.org>
 <b9db6fe7-6d0c-4f05-96c5-242112e4fc2a@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9db6fe7-6d0c-4f05-96c5-242112e4fc2a@huawei.com>

On Fri, Dec 06, 2024 at 10:24:49AM +0800, Jijie Shao wrote:
> 
> on 2024/12/6 4:55, Simon Horman wrote:
> > On Thu, Dec 05, 2024 at 05:05:23PM +0000, Simon Horman wrote:
> > > This patch addresses two problems related to leaked resources allocated
> > > by hbg_irq_init().
> > > 
> > > 1. On error release allocated resources
> > > 2. Otherwise, release the allocated irq vector on device tear-down
> > >     by setting-up a devres to do so.
> > > 
> > > Found by inspection.
> > > Compile tested only.
> > > 
> > > Fixes: 4d089035fa19 ("net: hibmcge: Add interrupt supported in this module")
> > > Signed-off-by: Simon Horman <horms@kernel.org>
> > Sorry for the noise, but on reflection I realise that the devm_free_irq()
> > portion of my patch, which is most of it, is not necessary as the
> > allocations are made using devm_request_irq().  And the driver seems to
> > rely on failure during init resulting in device tear-down, at which point
> > devres will take care of freeing the IRQs.
> > 
> > But I don't see where the IRQ vectors are freed, either on error in
> > hbg_irq_init or device tear-down. I think the following, somewhat smaller
> > patch, would be sufficient to address that.
> 
> Thank you for reviewing the code.
> 
> But sorry, it's actually not needed.
> 
> I discussed this with Jakub and Jonathan:
> https://lore.kernel.org/all/383f26a1-aa8f-4fd2-a00a-86abce5942ad@huawei.com/
> 
> I also add a comment in code, But I'm sorry, maybe it's a little subtle.
>  /* used pcim_enable_device(),  so the vectors become device managed */
>  ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
>  			     PCI_IRQ_MSI | PCI_IRQ_MSIX);

Thanks, I missed that.
In that case I agree that this isn't needed.

-- 
pw-bot: rejected

