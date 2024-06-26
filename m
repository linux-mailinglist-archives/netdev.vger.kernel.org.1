Return-Path: <netdev+bounces-106745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 814899176AB
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 05:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14636B2183D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D199F433B3;
	Wed, 26 Jun 2024 03:12:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71405175BE
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371543; cv=none; b=Vojyuc4+ofWylfqkaXj75zWiIQoetrVJYQGxaBLqN5cGzz4NqccZZEAB62kmQP/4abXMGoK+EV8ISik8K5BuaokLtmk/g9uY6WTAidGZbweuPjqeJZwrb8qk27UHMeSX5Smf0XncmM6wyqYvSmlNFHNB8hJvgJFoXNYSQ7Wd13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371543; c=relaxed/simple;
	bh=cpPnnI+catnFAfNV8DhO6MfPwyZP1Z5LpUqVbE4Muo8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=rRpeSqH+fzFX/6UQe6TdTXxVWEP5FLFxX0ElmFQrOusryxKRAAZp8K3s3Rr4ng6gdgT78GA7lLZuLZa8hZIgJfjI/oDO2dnfyDuQ4XgOBFOKTvEKcnjqUbRASOgU21IutKlorvmAL391cihX0WF6GPQz72X/K1yOcjvKkXcpyoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1719371465t586t32737
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [220.184.148.68])
X-QQ-SSF:00400000000000F0FVF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 9742978470815302854
To: "'Przemek Kitszel'" <przemyslaw.kitszel@intel.com>
Cc: <mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<andrew@lunn.ch>,
	<netdev@vger.kernel.org>
References: <20240621080951.14368-1-jiawenwu@trustnetic.com> <08f3db6b-6781-435c-bddb-04a594a2e617@intel.com>
In-Reply-To: <08f3db6b-6781-435c-bddb-04a594a2e617@intel.com>
Subject: RE: [PATCH net] net: txgbe: fix MSI and INTx interrupts
Date: Wed, 26 Jun 2024 11:11:04 +0800
Message-ID: <03db01dac776$7b317c80$71947580$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQFQOtvRrCK+3Si7PSZ2z0gdwySpSQIT8U0yst3AeqA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Tue, June 25, 2024 7:41 PM, Przemek Kitszel wrote:
> On 6/21/24 10:09, Jiawen Wu wrote:
> > When using MSI or INTx interrupts, request_irq() for pdev->irq will
> > conflict with request_threaded_irq() for txgbe->misc.irq, to cause
> > system crash.
> >
> > Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >   drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  13 +-
> >   .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 122 +++++++-----------
> >   .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |   2 +-
> >   .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   3 +-
> >   4 files changed, 59 insertions(+), 81 deletions(-)
> >
> 
> Please split into two commits (by prepending one commit that will just
> move/rename function/s) to avoid inflating the diff of the actual fix.
> This will ease the review process.

I will split it into two commits to make it easier to review, but it may not
be just renaming the function in one commit.
 


