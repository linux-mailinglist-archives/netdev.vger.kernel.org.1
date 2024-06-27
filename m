Return-Path: <netdev+bounces-107492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FD891B2ED
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2FD31F21AD6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7E1A2FC6;
	Thu, 27 Jun 2024 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhTql+D5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B87E13E032
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531827; cv=none; b=LxheFGdLv58C/fe6Obe/CdTSPBWE5qqFutrqe16UoLorQu+GeQw5SLajj3JSpKyOtGrgrEMUYsC2965aOOrOJWKxuPZYiIWFlKnRjAENfSOowPkYF2iTJvbcgVYRXWvV+ERW08MvCb66f5MevifXn2x5rqre5jrcjWMyKxbh+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531827; c=relaxed/simple;
	bh=ZOeVedvpIKtGEPTW0tZlnVPRkJfdxwvQV2fyMPnfdEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGda5oFz+/gBkIZf3vTi4XjbVyzfSFoUUsK/dWR6SpQDj1ercnMpEYSm0SDXfAA+s2WRzhCWgr8X9vFVrHIrdsq+Aa0ZHQgaex7R7FDHqxPM4vnZnnmDctDx+RGJbM8m4q+oz2evmgbvTG1SveINBER4xwx7Sp7G82jE0jM+QTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhTql+D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BB6C2BBFC;
	Thu, 27 Jun 2024 23:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719531827;
	bh=ZOeVedvpIKtGEPTW0tZlnVPRkJfdxwvQV2fyMPnfdEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WhTql+D5X7BJ2UZcWtNSBwuyWSIwyTEI6mI6I+tvypK5pCpwKh+yNYwalYsELpSpq
	 6uX1zCzaLFoU2l80kJWomVp8VsEWohWHE4ZibMjP84Cuz+IZ1ZKCjSuJcwDe3fTBq+
	 ldlFlS+1EWzdnSEaOMMNy5bq56EtKU0RzTlvv+owM7UnzRQrWlXvvF006ItUW2aCdY
	 Oo5Y0kqFxA7C22YMOrZzhzpLmR9/OS6AtmL1KpGiNHjf7ejAPGCLG0IeKnEFJNohIV
	 RmM3srIZV2A5v5VGVFi6GXP98cjZkRz3D6kr6EDMuTIBMVldHmq18b5AgyhHhmLuY+
	 hoSYjPT+bHIDA==
Date: Thu, 27 Jun 2024 16:43:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, mengyuanlou@net-swift.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net v2 2/2] net/txgbe: add extra handle for MSI/INTx
 into thread irq handle
Message-ID: <20240627164345.3273b3c2@kernel.org>
In-Reply-To: <20240626060703.31652-3-jiawenwu@trustnetic.com>
References: <20240626060703.31652-1-jiawenwu@trustnetic.com>
	<20240626060703.31652-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 14:07:03 +0800 Jiawen Wu wrote:
> Moreover, do not free isb resources in .ndo_stop, to avoid reading
> memory by a null pointer.

Please provide more detail on the sequence of events leading to the
null-defer.

>  	pdev->irq = pci_irq_vector(pdev, 0);
> +	wx->num_q_vectors = 1;

this doesn't seem obviously related

>  
>  	return 0;
>  }
> @@ -2027,6 +2028,9 @@ int wx_setup_isb_resources(struct wx *wx)
>  {
>  	struct pci_dev *pdev = wx->pdev;
>  
> +	if (wx->isb_mem)
> +		return 0;
> +
>  	wx->isb_mem = dma_alloc_coherent(&pdev->dev,
>  					 sizeof(u32) * 4,
>  					 &wx->isb_dma,
> @@ -2050,6 +2054,9 @@ void wx_free_isb_resources(struct wx *wx)
>  {
>  	struct pci_dev *pdev = wx->pdev;
>  
> +	if (!wx->isb_mem)
> +		return;
> +

And neither does this. Why do you need to make these function
idempotent?
-- 
pw-bot: cr

