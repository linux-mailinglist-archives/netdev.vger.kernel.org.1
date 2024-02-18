Return-Path: <netdev+bounces-72745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6B58597C9
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 17:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B062815E6
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8674B6E2C8;
	Sun, 18 Feb 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LUNQEHws"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353456B82
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708274701; cv=none; b=vFDVWKNTAg87NY48Ak93ER1lOuuLp2C5cwWs9kNwnotPbRpzBHsbZEMK3O7/jfQHrizVi1beMAxbXcDQZS3uW7Uz+wohtwWfgpHFRhxqVM4YtHqcCl9ZKCjHU2xUA1xm/tYv+qjHQoFdsoceycrM6ZfZVOU37N2+F9EGtv4ZsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708274701; c=relaxed/simple;
	bh=gS33TqvG8CRdDp2vJ6TOWYItc/Fu3Q5MJs2/8z5Bu9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp3b9qFeVfHTMQshf/FKzAGoI6PKHZUO9h3OUqgv/YdqdJAZYhdUeYWaXwHHEBBqISUenkZQKyfNQI9IZ28XgbWXaac1lA3vMryzQXStcgcKVZA2t1DIGRybOeZr0mLcOE9l+IS8w72LQXLtNFP5ytnIiiMXpXhAWIauVqzCwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LUNQEHws; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zRMqQh4DR544URfb7qfNyoYJQZbPzkp0u1iTv0wvWTQ=; b=LUNQEHwsIJ998jYiVYO77AQSVK
	1oo2d0kWH0j+fclA/H5g23joMJmztEXr5HIPBz4I3QflwkNlASBKUbCcFCEUzDeBhvEUgoZYq38Jj
	hd6Krs37xLesV8QV0D4oNo1s1WRIKQnpMCiFp4zstd0YKRzRduLuxzkFbyXsogna+HDw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbkHf-0088EZ-3E; Sun, 18 Feb 2024 17:44:55 +0100
Date: Sun, 18 Feb 2024 17:44:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH] net: txgbe: fix GPIO interrupt blocking
Message-ID: <33eed490-7819-409e-8c79-b3c1e4c4fd66@lunn.ch>
References: <20240206070824.17460-1-jiawenwu@trustnetic.com>
 <9259e4eb-8744-45cf-bdea-63bc376983a4@lunn.ch>
 <003801da6249$888e4210$99aac630$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003801da6249$888e4210$99aac630$@trustnetic.com>

On Sun, Feb 18, 2024 at 05:04:52PM +0800, Jiawen Wu wrote:
> On Tue, Feb 6, 2024 11:29 PM, Andrew Lunn wrote:
> > On Tue, Feb 06, 2024 at 03:08:24PM +0800, Jiawen Wu wrote:
> > > GPIO interrupt is generated before MAC IRQ is enabled, it causes
> > > subsequent GPIO interrupts that can no longer be reported if it is
> > > not cleared in time. So clear GPIO interrupt status at the right
> > > time.
> > 
> > This does not sound correct. Since this is an interrupt controller, it
> > is a level interrupt. If its not cleared, as soon as the parent
> > interrupt is re-enabled, is should cause another interrupt at the
> > parent level. Servicing that interrupt, should case a descent to the
> > child, which will service the interrupt, and atomically clear the
> > interrupt status.
> > 
> > Is something wrong here, like you are using edge interrupts, not
> > level?
> 
> Yes, it is edge interrupt.

So fix this first, use level interrupts.

> > > And executing function txgbe_gpio_irq_ack() manually since
> > > handle_nested_irq() does not call .irq_ack for irq_chip.
> > 
> > I don't know the interrupt code too well, so could you explain this in
> > more detail. Your explanation sounds odd to me.
> 
> This is because I changed the interrupt controller in
> https://git.kernel.org/netdev/net-next/c/aefd013624a1.
> In the previous interrupt controller, .irq_ack in struct irq_chip is called
> to clear the interrupt after the GPIO interrupt is handled. But I found
> that in the current interrupt controller, this .irq_ack is not called. Maybe
> I don't know enough about this interrupt code, I have to manually add
> txgbe_gpio_irq_ack() to clear the interrupt in the handler.

You should dig deeper into interrupts.
[goes and digs]

https://elixir.bootlin.com/linux/latest/source/include/linux/irq.h#L461
 * @irq_ack:		start of a new interrupt

The comment makes it sound like irq_ack will be the first callback
used when handling an interrupt.

static inline void mask_ack_irq(struct irq_desc *desc)
{
        if (desc->irq_data.chip->irq_mask_ack) {
                desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
                irq_state_set_masked(desc);
        } else {
                mask_irq(desc);
                if (desc->irq_data.chip->irq_ack)
                        desc->irq_data.chip->irq_ack(&desc->irq_data);
        }
}

So the comment might be a little misleading. It will first mask the
interrupt, and then ack it.

/**
 *      handle_level_irq - Level type irq handler
 *      @desc:  the interrupt description structure for this irq
 *
 *      Level type interrupts are active as long as the hardware line has
 *      the active level. This may require to mask the interrupt and unmask
 *      it after the associated handler has acknowledged the device, so the
 *      interrupt line is back to inactive.
 */
void handle_level_irq(struct irq_desc *desc)
{
        raw_spin_lock(&desc->lock);
        mask_ack_irq(desc);

So when handling a level interrupt, mask and then ack is the first
thing done. And it is unconditional.

edge interrupts are different:

/**
 *      handle_edge_irq - edge type IRQ handler
 *      @desc:  the interrupt description structure for this irq
 *
 *      Interrupt occurs on the falling and/or rising edge of a hardware
 *      signal. The occurrence is latched into the irq controller hardware
 *      and must be acked in order to be reenabled. After the ack another
 *      interrupt can happen on the same source even before the first one
 *      is handled by the associated event handler. If this happens it
 *      might be necessary to disable (mask) the interrupt depending on the
 *      controller hardware. This requires to reenable the interrupt inside
 *      of the loop which handles the interrupts which have arrived while
 *      the handler was running. If all pending interrupts are handled, the
 *      loop is left.
 */
void handle_edge_irq(struct irq_desc *desc)
{
        raw_spin_lock(&desc->lock);

        desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);

        if (!irq_may_run(desc)) {
                desc->istate |= IRQS_PENDING;
                mask_ack_irq(desc);
                goto out_unlock;
        }

        /*
         * If its disabled or no action available then mask it and get
         * out of here.
         */
        if (irqd_irq_disabled(&desc->irq_data) || !desc->action) {
                desc->istate |= IRQS_PENDING;
                mask_ack_irq(desc);
                goto out_unlock;
        }

       /* Start handling the irq */
        desc->irq_data.chip->irq_ack(&desc->irq_data);

So if the interrupt handler is already running, it will mask and ack
it, but not handle it, since there is already a handler running.
Otherwise it will ack the interrupt and then handle it. And it loops
handling the interrupt while IRQS_PENDING is set, i.e. another
interrupt has arrived while the handler was running.

I would suggest you first get it using level interrupts, and then dig
into how level interrupts are used, which do appear to be simpler than
edge.

	Andrew

