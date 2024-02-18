Return-Path: <netdev+bounces-72728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633058595E3
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 10:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D2C281D74
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 09:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC46BF9D6;
	Sun, 18 Feb 2024 09:06:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75947538A
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708247192; cv=none; b=Ezrv7xqZOdlpdrkbIxHyjfk6x0IiHt5hjbWy3WDiWgQthjT44VJ1aO9UI/7oTky35oD6t4sJU28OCCO7BDYcwXLAQ5Cme1W1gy/dxmXBkvkFjpdES4OHpHz2aVN4DjSUZoqUOw22+BcskmHq3q4EeH1FVsqQ3fIk0EwN5Q4yUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708247192; c=relaxed/simple;
	bh=e94JmLflhLbx8fnZYNjhNMO2Y1z6sl3a6bW1WpUTMAs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=I7ZWvanJpr2+FagpsZM0DYknwbJolKLIIoJ+WYsHXuF4I6INnVcPIQAMsPTrwPRGO44d4bGSm4FDvant9OzxoBvpcY3UyawnRuxayyd0nXrh8Q1Jnq3URbA7dtuFzD8ymFEB7f0Ig6MNLXFe8b5TPHpfAFC73x8TvmCLrU4ExAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas49t1708247093t112t10638
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.246.158])
X-QQ-SSF:00400000000000F0FTF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2405816306851130360
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<maciej.fijalkowski@intel.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20240206070824.17460-1-jiawenwu@trustnetic.com> <9259e4eb-8744-45cf-bdea-63bc376983a4@lunn.ch>
In-Reply-To: <9259e4eb-8744-45cf-bdea-63bc376983a4@lunn.ch>
Subject: RE: [PATCH] net: txgbe: fix GPIO interrupt blocking
Date: Sun, 18 Feb 2024 17:04:52 +0800
Message-ID: <003801da6249$888e4210$99aac630$@trustnetic.com>
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
Content-Language: zh-cn
Thread-Index: AQKQWSrySMPq8PWl707TeSOritAirQH7beder5OPjaA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Tue, Feb 6, 2024 11:29 PM, Andrew Lunn wrote:
> On Tue, Feb 06, 2024 at 03:08:24PM +0800, Jiawen Wu wrote:
> > GPIO interrupt is generated before MAC IRQ is enabled, it causes
> > subsequent GPIO interrupts that can no longer be reported if it is
> > not cleared in time. So clear GPIO interrupt status at the right
> > time.
> 
> This does not sound correct. Since this is an interrupt controller, it
> is a level interrupt. If its not cleared, as soon as the parent
> interrupt is re-enabled, is should cause another interrupt at the
> parent level. Servicing that interrupt, should case a descent to the
> child, which will service the interrupt, and atomically clear the
> interrupt status.
> 
> Is something wrong here, like you are using edge interrupts, not
> level?

Yes, it is edge interrupt.

> 
> > And executing function txgbe_gpio_irq_ack() manually since
> > handle_nested_irq() does not call .irq_ack for irq_chip.
> 
> I don't know the interrupt code too well, so could you explain this in
> more detail. Your explanation sounds odd to me.

This is because I changed the interrupt controller in
https://git.kernel.org/netdev/net-next/c/aefd013624a1.
In the previous interrupt controller, .irq_ack in struct irq_chip is called
to clear the interrupt after the GPIO interrupt is handled. But I found
that in the current interrupt controller, this .irq_ack is not called. Maybe
I don't know enough about this interrupt code, I have to manually add
txgbe_gpio_irq_ack() to clear the interrupt in the handler.

> 
> What is the big picture problem here? Do you have the PHY interrupt
> connected to a GPIO and you are loosing PHY interrupts?

No, PHY interrupt is connected to the LINK UP/DOWN filed in the MAC
interrupt. The problem I encountered was that the GPIO interrupts were
not cleaned up in time and could not continue to generate the next GPIO
interrupt.



