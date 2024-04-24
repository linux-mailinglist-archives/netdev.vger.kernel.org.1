Return-Path: <netdev+bounces-90795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E56C8B0389
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 09:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA73B2742F
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 07:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D11158210;
	Wed, 24 Apr 2024 07:55:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4E5158204
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945334; cv=none; b=D4dZsg9pKJbVD3w2Bw295BptzjjSaUGI8nArfu0d5w7u4orVRh549Cyi0RZFAE0paTKk1Q7jl9+1/l9lf3Wj4UTqZ4hp1+T7/U2BpDo5KC0N06g+AzX7JQuuYVE57IbyUYmHb1+vlCFFZHvRtvOltKJXUszgDjmtGu+2NxkjA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945334; c=relaxed/simple;
	bh=Lqe/X+i3I0nshARv4DTkcZBAaOro2292vWvRjQOveRA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=rJHrBMKOkBqayouhh8wpTIEyrst5zRh9EjBpHr1jkdfmN4EfXFgMATX7labsNgIUnGtrH4tCh5VnDMmhxq/6KcYrG3Hd28L1BQ+4gGjbq1Dt+06ACBqbKJSZIRrw7GkBO2RRlzfRfofMQMjuiVWHLhwfwZXtpQXL/9Ww0jqCm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1713945198t467t18212
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.195.151.153])
X-QQ-SSF:00400000000000F0FUF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 18304150619850852544
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<rmk+kernel@armlinux.org.uk>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>
References: <20240416062952.14196-1-jiawenwu@trustnetic.com> <20240416062952.14196-3-jiawenwu@trustnetic.com> <ff606ace-1128-4d16-8192-7ff1a40301af@lunn.ch>
In-Reply-To: <ff606ace-1128-4d16-8192-7ff1a40301af@lunn.ch>
Subject: RE: [PATCH net 2/5] net: wangxun: fix error statistics when the device is reset
Date: Wed, 24 Apr 2024 15:53:17 +0800
Message-ID: <046501da961c$77f3fba0$67dbf2e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMFotcmuiiFX27azvFEImaFqcAi9wJDtu9ZAWg8bGWvA5AtAA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Tue, April 16, 2024 10:56 PM, Andrew Lunn wrote:
> On Tue, Apr 16, 2024 at 02:29:49PM +0800, Jiawen Wu wrote:
> > Add flag for reset state to avoid reading statistics when hardware
> > is reset.
> 
> This explains the what, which you can also get by reading the code
> change. The commit message should also explain the why? What goes
> wrong if you read the statistics when the hardware is in reset? Do you
> get 42 for every statistic? Does the hardware lockup and the reset
> never completes?

I think I should discard this patch, and add the resetting flag to the patch 5/5 to avoid
device reset collision. Since wx_update_stats() is called in txgbe_disable_device() while
device is resetting. And I haven't found a situation that causes statistics confusion.



