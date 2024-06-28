Return-Path: <netdev+bounces-107518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A809891B4BD
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 03:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8721C2139E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C69C12E75;
	Fri, 28 Jun 2024 01:48:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83795125DB
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 01:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719539315; cv=none; b=XqtyPY4mPtdymiuGBtlbnArzABt3P+r4xQkjmdPB+jQnRVJRvN8ggt4sdkzBFH2O1+mq0pRqFjQC2Oy6ZPCqb/kH3npxRT09FCXrfcjYSaZ6BlXEytqHO0UQxzFttpDvcxxauZSmPSrgv9WS8bLx9PCXrdKGs6326TxVRRWCClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719539315; c=relaxed/simple;
	bh=ISjL98FEIloYsXjQhu4f1sm4Kl44MELZ+AVP1UVg/lY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ewoSZl7p3x1SqVi4ulyGBSqnLBHhh8cm8xZyDckXBjCzc7ouQBHhBfurELwbwOTQfK8CKC8LfvVRxzMDdvgZL8JjmcZ2WXT4ZeEtHI87YVsOP8b1eBuSzoYqvW9K/S2jiE1Rb5uH8cEY3ewExkkqx4hOqcK7/vlF4KIZm6h5NhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas11t1719539225t331t18327
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [220.184.148.68])
X-QQ-SSF:00400000000000F0FVF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8361001490794205103
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
References: <20240626060703.31652-1-jiawenwu@trustnetic.com>	<20240626060703.31652-2-jiawenwu@trustnetic.com> <20240627164138.725aa957@kernel.org>
In-Reply-To: <20240627164138.725aa957@kernel.org>
Subject: RE: [PATCH net v2 1/2] net: txgbe: remove separate irq request for MSI and INTx
Date: Fri, 28 Jun 2024 09:47:04 +0800
Message-ID: <052e01dac8fd$13cb1b90$3b6152b0$@trustnetic.com>
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
Thread-Index: AQDN2RpiCVsU8jFSIe4yesMp7FnMeAIA914DAgBszhGz1jqSsA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Fri, Jun 28, 2024 7:42 AM, Jakub Kicinski wrote:
> On Wed, 26 Jun 2024 14:07:02 +0800 Jiawen Wu wrote:
> > When using MSI or INTx interrupts, request_irq() for pdev->irq will
> > conflict with request_threaded_irq() for txgbe->misc.irq, to cause
> > system crash. So remove txgbe_request_irq() for MSI/INTx case, and
> > rename txgbe_request_msix_irqs() since it only request for queue irqs.
> 
> Do you have any users who need INTx support? Maybe you could drop
> the support and simplify the code?

Yes, some domestic platforms use it.

> 
> > Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  3 +-
> >  .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 78 ++-----------------
> >  .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |  2 +-
> >  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  2 +-
> >  4 files changed, 10 insertions(+), 75 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > index 68bde91b67a0..99f55a3573c8 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > @@ -1996,7 +1996,8 @@ void wx_free_irq(struct wx *wx)
> >  	int vector;
> >
> >  	if (!(pdev->msix_enabled)) {
> > -		free_irq(pdev->irq, wx);
> > +		if (wx->mac.type == wx_mac_em)
> > +			free_irq(pdev->irq, wx);
> 
> It seems strange to match on type to decide whether to free an IRQ.
> Isn't there or shouldn't there be some IRQ related flag informing
> the library how to manage the IRQs?

My intention is not to change the IRQ structure of ngbe driver. So it
simply match the mac type. I would consider use a flag.



