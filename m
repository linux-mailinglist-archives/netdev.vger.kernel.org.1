Return-Path: <netdev+bounces-107520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC6791B4FD
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 04:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9995F1F220F5
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C657417F8;
	Fri, 28 Jun 2024 02:17:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956EC1103
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541066; cv=none; b=P027DsVZU/1UuFG+y47A3UX5u3kavu1CVyd8nC/HhHj3bSavCMs8W1/SYztKyozMBJpS9X4C3qRP3uca2yTjOi4hVTbiiG2CBnJpR1AAk95o2s549la5LrTjjeA0QEr6yUqSvgVqY0jAUdcZcJGwDoNkctTUgI1RxJseb69Dkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541066; c=relaxed/simple;
	bh=gJ1Aa+M/I04JOCmuwTNSX8B8jzNLRxzEUmNTkZc7xJo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NOpuRsV+kwv3eZQChUj6AehdTJuoqY7ylFd0Byzecxg+zc4zSpA3em/c+U9d6f97subdjiM6Rt8bmyCpnSHL1nzlBNSTRjgDpEXCV9VMaLYQqModHi/q2Xj408jTtkUrWm5Xz93YdlNTPyL4kK881GrfJsH1m4dwOMd49Rc29+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas11t1719540987t316t52336
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [220.184.148.68])
X-QQ-SSF:00400000000000F0FVF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 12320897217329021607
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<andrew@lunn.ch>,
	<netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>,
	<mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>
References: <20240626060703.31652-1-jiawenwu@trustnetic.com>	<20240626060703.31652-3-jiawenwu@trustnetic.com> <20240627164345.3273b3c2@kernel.org>
In-Reply-To: <20240627164345.3273b3c2@kernel.org>
Subject: RE: [PATCH net v2 2/2] net/txgbe: add extra handle for MSI/INTx into thread irq handle
Date: Fri, 28 Jun 2024 10:16:26 +0800
Message-ID: <053701dac901$2e068360$8a138a20$@trustnetic.com>
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
Thread-Index: AQDN2RpiCVsU8jFSIe4yesMp7FnMeAG9eeYoAcEJWYOz2lPcgA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Fri, Jun 28, 2024 7:44 AM, Jakub Kicinski wrote:
> On Wed, 26 Jun 2024 14:07:03 +0800 Jiawen Wu wrote:
> > Moreover, do not free isb resources in .ndo_stop, to avoid reading
> > memory by a null pointer.
> 
> Please provide more detail on the sequence of events leading to the
> null-defer.
> 
> >  	pdev->irq = pci_irq_vector(pdev, 0);
> > +	wx->num_q_vectors = 1;
> 
> this doesn't seem obviously related

Umm, this is related another fix for MSI/INTx. I'll split it into a separate
commit.

> 
> >
> >  	return 0;
> >  }
> > @@ -2027,6 +2028,9 @@ int wx_setup_isb_resources(struct wx *wx)
> >  {
> >  	struct pci_dev *pdev = wx->pdev;
> >
> > +	if (wx->isb_mem)
> > +		return 0;
> > +
> >  	wx->isb_mem = dma_alloc_coherent(&pdev->dev,
> >  					 sizeof(u32) * 4,
> >  					 &wx->isb_dma,
> > @@ -2050,6 +2054,9 @@ void wx_free_isb_resources(struct wx *wx)
> >  {
> >  	struct pci_dev *pdev = wx->pdev;
> >
> > +	if (!wx->isb_mem)
> > +		return;
> > +
> 
> And neither does this. Why do you need to make these function
> idempotent?

This is also to implement txgbe changes without changing the flow of ngbe.



