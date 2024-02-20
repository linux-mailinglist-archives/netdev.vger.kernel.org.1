Return-Path: <netdev+bounces-73228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ADD85B74F
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325FC284642
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF3A5FDA7;
	Tue, 20 Feb 2024 09:27:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D045FB9E
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421230; cv=none; b=b4v7OYbFrnXK7agcXt9gFla1py2nmE3zvQy3MdCfaAyxL09JOS33auYOc9+06Okm0yuTqmgQ4pk7//5XIqSrcQ9bQWhNZ1luE2K5NeuTzIPdkjEUSUHn4YLF9tEwz6DxB2nLwqrGgEhppbTLcQRTmyb/38MidDD3Ry4dme1+t90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421230; c=relaxed/simple;
	bh=0vAZ754tu9q2lFBPcL5SE9WFsK9Exg1X8XUv1ggGoNw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=lQi1PgE9u9lYLx3ixN1HvEQoWHJhpFOYpZbprP3+YCh8GSg1oplJ6gijGrp/dn9cnN8ZTxJ+FV6mamH7PO8ZKaAoWVK0pHt8poRlOunWf3/5RVH2YRkEOqRwS3XGkO7YI/3DSPj0rR6z8MYEWLUxHjSUp9IPCqCU2vaHnJvrOXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas12t1708421127t877t41188
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.192.112.158])
X-QQ-SSF:00400000000000F0FTF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4819387268812499297
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<maciej.fijalkowski@intel.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20240206070824.17460-1-jiawenwu@trustnetic.com> <9259e4eb-8744-45cf-bdea-63bc376983a4@lunn.ch> <003801da6249$888e4210$99aac630$@trustnetic.com> <33eed490-7819-409e-8c79-b3c1e4c4fd66@lunn.ch>
In-Reply-To: <33eed490-7819-409e-8c79-b3c1e4c4fd66@lunn.ch>
Subject: RE: [PATCH] net: txgbe: fix GPIO interrupt blocking
Date: Tue, 20 Feb 2024 17:25:26 +0800
Message-ID: <00e301da63de$bd53db90$37fb92b0$@trustnetic.com>
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
Thread-Index: AQKQWSrySMPq8PWl707TeSOritAirQH7bedeAP/Pp5gCVYvqAa98F4fw
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Mon, Feb 19, 2024 12:45 AM, Andrew Lunn wrote:
> On Sun, Feb 18, 2024 at 05:04:52PM +0800, Jiawen Wu wrote:
> > On Tue, Feb 6, 2024 11:29 PM, Andrew Lunn wrote:
> > > On Tue, Feb 06, 2024 at 03:08:24PM +0800, Jiawen Wu wrote:
> > > > GPIO interrupt is generated before MAC IRQ is enabled, it causes
> > > > subsequent GPIO interrupts that can no longer be reported if it is
> > > > not cleared in time. So clear GPIO interrupt status at the right
> > > > time.
> > >
> > > This does not sound correct. Since this is an interrupt controller, it
> > > is a level interrupt. If its not cleared, as soon as the parent
> > > interrupt is re-enabled, is should cause another interrupt at the
> > > parent level. Servicing that interrupt, should case a descent to the
> > > child, which will service the interrupt, and atomically clear the
> > > interrupt status.
> > >
> > > Is something wrong here, like you are using edge interrupts, not
> > > level?
> >
> > Yes, it is edge interrupt.
> 
> So fix this first, use level interrupts.

I have a question here.

I've been setting the interrupt type in chip->irq_set_type. The 'type' is
passed as IRQ_TYPE_EDGE_BOTH. Then I config GPIO registers based on
this type, and use edge interrupts. Who decides this type? Can I change
it at will?

> 
> > > > And executing function txgbe_gpio_irq_ack() manually since
> > > > handle_nested_irq() does not call .irq_ack for irq_chip.
> > >
> > > I don't know the interrupt code too well, so could you explain this in
> > > more detail. Your explanation sounds odd to me.
> >
> > This is because I changed the interrupt controller in
> > https://git.kernel.org/netdev/net-next/c/aefd013624a1.
> > In the previous interrupt controller, .irq_ack in struct irq_chip is called
> > to clear the interrupt after the GPIO interrupt is handled. But I found
> > that in the current interrupt controller, this .irq_ack is not called. Maybe
> > I don't know enough about this interrupt code, I have to manually add
> > txgbe_gpio_irq_ack() to clear the interrupt in the handler.
> 
> You should dig deeper into interrupts.
> [goes and digs]
> 
> https://elixir.bootlin.com/linux/latest/source/include/linux/irq.h#L461
>  * @irq_ack:		start of a new interrupt
> 
> The comment makes it sound like irq_ack will be the first callback
> used when handling an interrupt.
> 
> static inline void mask_ack_irq(struct irq_desc *desc)
> {
>         if (desc->irq_data.chip->irq_mask_ack) {
>                 desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
>                 irq_state_set_masked(desc);
>         } else {
>                 mask_irq(desc);
>                 if (desc->irq_data.chip->irq_ack)
>                         desc->irq_data.chip->irq_ack(&desc->irq_data);
>         }
> }
> 
> So the comment might be a little misleading. It will first mask the
> interrupt, and then ack it.
> 
> /**
>  *      handle_level_irq - Level type irq handler
>  *      @desc:  the interrupt description structure for this irq
>  *
>  *      Level type interrupts are active as long as the hardware line has
>  *      the active level. This may require to mask the interrupt and unmask
>  *      it after the associated handler has acknowledged the device, so the
>  *      interrupt line is back to inactive.
>  */
> void handle_level_irq(struct irq_desc *desc)
> {
>         raw_spin_lock(&desc->lock);
>         mask_ack_irq(desc);
> 
> So when handling a level interrupt, mask and then ack is the first
> thing done. And it is unconditional.
> 
> edge interrupts are different:
> 
> /**
>  *      handle_edge_irq - edge type IRQ handler
>  *      @desc:  the interrupt description structure for this irq
>  *
>  *      Interrupt occurs on the falling and/or rising edge of a hardware
>  *      signal. The occurrence is latched into the irq controller hardware
>  *      and must be acked in order to be reenabled. After the ack another
>  *      interrupt can happen on the same source even before the first one
>  *      is handled by the associated event handler. If this happens it
>  *      might be necessary to disable (mask) the interrupt depending on the
>  *      controller hardware. This requires to reenable the interrupt inside
>  *      of the loop which handles the interrupts which have arrived while
>  *      the handler was running. If all pending interrupts are handled, the
>  *      loop is left.
>  */
> void handle_edge_irq(struct irq_desc *desc)
> {
>         raw_spin_lock(&desc->lock);
> 
>         desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
> 
>         if (!irq_may_run(desc)) {
>                 desc->istate |= IRQS_PENDING;
>                 mask_ack_irq(desc);
>                 goto out_unlock;
>         }
> 
>         /*
>          * If its disabled or no action available then mask it and get
>          * out of here.
>          */
>         if (irqd_irq_disabled(&desc->irq_data) || !desc->action) {
>                 desc->istate |= IRQS_PENDING;
>                 mask_ack_irq(desc);
>                 goto out_unlock;
>         }
> 
>        /* Start handling the irq */
>         desc->irq_data.chip->irq_ack(&desc->irq_data);
> 
> So if the interrupt handler is already running, it will mask and ack
> it, but not handle it, since there is already a handler running.
> Otherwise it will ack the interrupt and then handle it. And it loops
> handling the interrupt while IRQS_PENDING is set, i.e. another
> interrupt has arrived while the handler was running.
> 
> I would suggest you first get it using level interrupts, and then dig
> into how level interrupts are used, which do appear to be simpler than
> edge.
> 
> 	Andrew
> 


