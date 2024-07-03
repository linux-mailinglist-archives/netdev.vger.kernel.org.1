Return-Path: <netdev+bounces-108654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7E6924D40
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 03:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAD21C21C5C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E7139B;
	Wed,  3 Jul 2024 01:46:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7F1FAA
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 01:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719971201; cv=none; b=IC0gjZRWya3G+4UDSe3WGNVz8Ao7AhiJy6ysSSw3ZaSWZY0iEl4FpWfTOZE5VSkwj66mi2qdxUdNd1TWJwMaiJiEfcTzkuOfMFDqeazpPLT3+PZRtheGrbM305WrzxMDiQmGYtuBXoeE0TF8QDKIh8P5JEWACB0UZhn2oQcmrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719971201; c=relaxed/simple;
	bh=nZR/nwriXxmFBdZTbRVIZGTV6PLQX9LHYziILlgeWOM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=WljWJHDlx/J0+BNxLkwzlafZnpUZAxck2xnMtukKUsPK4ndrA77MnEWl6WzF+RIfVlNkshODhn5Fn6J8UMez/QMYmvcaXkfSwT0lZtVBSxTTq65AftZSG1jJMwCz8a0kqXe1hBrq+vVCqPVH0GSBdFJ8mVKFIFV0Ab5cG6xpe1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas44t1719971110t225t21408
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [220.184.148.68])
X-QQ-SSF:00400000000000F0FVF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 9266568737501632671
To: "'Michal Kubiak'" <michal.kubiak@intel.com>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<andrew@lunn.ch>,
	<netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>,
	<mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>
References: <20240701071416.8468-1-jiawenwu@trustnetic.com> <20240701071416.8468-2-jiawenwu@trustnetic.com> <ZoQbChC5gTNxBNtI@localhost.localdomain>
In-Reply-To: <ZoQbChC5gTNxBNtI@localhost.localdomain>
Subject: RE: [PATCH net v3 1/4] net: txgbe: initialize num_q_vectors for MSI/INTx interrupts
Date: Wed, 3 Jul 2024 09:45:09 +0800
Message-ID: <075201daccea$a33739d0$e9a5ad70$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQHNeNq9wbvsQCyRpZlyZkgAelvbZQEW+4xhAfvboCex5kw1QA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Tue, Jul 2, 2024 11:22 PM, Michal Kubiak wrote:
> On Mon, Jul 01, 2024 at 03:14:13PM +0800, Jiawen Wu wrote:
> > When using MSI/INTx interrupts, wx->num_q_vectors is uninitialized.
> > Thus there will be kernel panic in wx_alloc_q_vectors() to allocate
> > queue vectors.
> >
> > Fixes: 3f703186113f ("net: libwx: Add irq flow functions")
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > index 68bde91b67a0..f53776877f71 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > @@ -1686,6 +1686,7 @@ static int wx_set_interrupt_capability(struct wx *wx)
> >  	}
> >
> >  	pdev->irq = pci_irq_vector(pdev, 0);
> > +	wx->num_q_vectors = 1;
> 
> I would suggest improving readability of that logic. TBH, initially it wasn't
> obvious to me why you assign 1 to num_q_vectors (instead of nvecs variable).
> Maybe you just want to exit with an error when nvecs != 1 and avoid some nesting.
> I think that should make that logic easier to read. For example:
> 
>         /* minmum one for queue, one for misc*/
>         nvecs = 1;
>         nvecs = pci_alloc_irq_vectors(pdev, nvecs,
>                                       nvecs, PCI_IRQ_MSI | PCI_IRQ_INTX);
>         if (nvecs != 1) {
>                 wx_err(wx, "Failed to allocate MSI/INTx interrupts. Error: %d\n", nvecs);
>                 return nvecs;
>         }
> 
>         if (pdev->msi_enabled)
>                 wx_err(wx, "Fallback to MSI.\n");
>         else
>                 wx_err(wx, "Fallback to INTx.\n");
> 
>         pdev->irq = pci_irq_vector(pdev, 0);
> 	wx->num_q_vectors = 1;
> 
> (Please consider it as a suggestion only).

Thanks for the suggestion, it can be considered as a commit for code optimization.
 


