Return-Path: <netdev+bounces-163668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8153A2B428
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE4018837E0
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 21:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3397E1F4191;
	Thu,  6 Feb 2025 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UJ13jo8B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="77pYTPSo"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46D1F4179;
	Thu,  6 Feb 2025 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738877344; cv=none; b=uB5kZksNlVyqN08oJ8qDB4BgRD9jrAHQz2aJ2EjZk6EWqmFCjUl13V53phXuOO1xeAt2NYLQP44nTbTZVrpO91ta8B+Ko48j1FdeGslu1CBiRCDWPCsjEqCJIDQL11vgzz0C71F5IVKfA2c6o86Z6elP2v/hwQskwEZ3N3OUYQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738877344; c=relaxed/simple;
	bh=NNLc9sYYM1xBfpokXu/kvh5M5qCiFpLmAd08ymL5+Pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lCKOcDhEF7yrwWiOMRzbnGXMB8OUkeBlrod/jt/WD+Ben6Z1Mbi7zdJQScgip47QNDzzjKefT8q680TQjvuVZH5Ma5aIesZLLKvp138jPLomsaY7GHGId9/zxyjGfH5uth8wG3KtvbT7SdqF+bx6yGM3uTYc77LQuFtb8KMt4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UJ13jo8B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=77pYTPSo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738877340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XwtTKiTRLh2dJDu6X8M8DZSQzJ03tIcOdYOJcxTLuvs=;
	b=UJ13jo8BGpxPbQUDaCZ/zFFku4V9dUaq7fgeJJOtHgRmxy3uihujzN0/V+ksjJhplqJhcf
	ZIwomLtVo9KwZzNy8ZFcEO5BONSmziinWf4Af4H7ZlwhDO3R7z69LaRSNCtq9A+DITL26+
	A8MIOPzh8CwO8SuKhLkf5ic9D38MuVUNNyIEhRiSg35jmtOkz++5G5NAtKb4qnvY3EhHlB
	sp7KBmg6ZSbwxNKldSWlfjcqlefLRPwABIaCizw1osxlj/nlPXORUH1/QUTKUuZIZeuYCo
	yE1I/vzeWGn0NZz08CNg0bZ2CMqjdA5/5dUoZ3VbTGK4rDBKTs+4btCqzCFjBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738877340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XwtTKiTRLh2dJDu6X8M8DZSQzJ03tIcOdYOJcxTLuvs=;
	b=77pYTPSoBgfyBqKpQUS+RAjpC1/n6MfHZpl/jtlAapmV1+8ZwWOr2fJPIrn1zABdjZkioh
	RPTjmllGXm+0FOBw==
To: Chintan Vankar <c-vankar@ti.com>, Jason Reeder <jreeder@ti.com>,
 vigneshr@ti.com, nm@ti.com, Chintan
 Vankar <c-vankar@ti.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
 s-vadapalli@ti.com, danishanwar@ti.com, m-malladi@ti.com
Subject: Re: [RFC PATCH 1/2] irqchip: ti-tsir: Add support for Timesync
 Interrupt Router
In-Reply-To: <20250205160119.136639-2-c-vankar@ti.com>
References: <20250205160119.136639-1-c-vankar@ti.com>
 <20250205160119.136639-2-c-vankar@ti.com>
Date: Thu, 06 Feb 2025 22:28:58 +0100
Message-ID: <87lduin4o5.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 05 2025 at 21:31, Chintan Vankar wrote:
> +++ b/drivers/irqchip/ti-timesync-intr.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL

That's not a valid license identifier

> +static struct irq_chip ts_intr_irq_chip = {
> +	.name			= "TIMESYNC_INTRTR",
> +};

How is this interrupt chip supposed to work? All it implements is a
name.

> +static int ts_intr_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				    unsigned int nr_irqs, void *arg)
> +{
> +	unsigned int output_line, input_line, output_line_offset;
> +	struct irq_fwspec *fwspec = (struct irq_fwspec *)arg;
> +	int ret;
> +
> +	irq_domain_set_hwirq_and_chip(domain, virq, output_line,
> +				      &ts_intr_irq_chip,
> +				      NULL);

You set the interrupt chip and data before validating that the input
argument is valid. That does not make any sense.

> +	/* Check for two input parameters: output line and corresponding input line */
> +	if (fwspec->param_count != 2)
> +		return -EINVAL;
> +
> +	output_line = fwspec->param[0];
> +
> +	/* Timesync Interrupt Router's mux-controller register starts at offset 4 from base
> +	 * address and each output line are at offset in multiple of 4s in Timesync INTR's
> +	 * register space, calculate the register offset from provided output line.
> +	 */

Please use proper kernel comment style as documented:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#comment-style

This is not networking code.

> +	output_line_offset = 4 * output_line + 0x4;

Magic hardcoded numbers '4' and '0x4' without any explanation of the logic.

> +	output_line_to_virq[output_line] = virq;
> +	input_line = fwspec->param[1] & TIMESYNC_INTRTR_ENABLE;
> +
> +	/* Map output line corresponding to input line */
> +	writel(input_line, tsr_data.tsr_base + output_line_offset);
> +
> +	/* When interrupt enable bit is set for Timesync Interrupt Router it maps the output
> +	 * line with the existing input line, hence enable interrupt line after we set bits for
> +	 * output line.

I have no idea what this comment is trying to tell me.

> +	 */
> +	input_line |= TIMESYNC_INTRTR_INT_ENABLE;
> +	writel(input_line, tsr_data.tsr_base + output_line_offset);
> +
> +	return 0;
> +}
> +
> +static void ts_intr_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> +				    unsigned int nr_irqs)
> +{
> +	struct output_line_to_virq *node, *n;
> +	unsigned int output_line_offset;
> +	int i;
> +
> +	for (i = 0; i < TIMESYNC_INTRTR_MAX_OUTPUT_LINES; i++) {
> +		if (output_line_to_virq[i] == virq) {
> +			/* Calculate the register offset value from provided output line */

Can you please implement a properly commented helper function which
explains how this offset calculation is supposed to work?

> +			output_line_offset = 4 * i + 0x4;
> +			writel(~TIMESYNC_INTRTR_INT_ENABLE, tsr_data.tsr_base + output_line_offset);
> +		}
> +	}
> +}
> +
> +static const struct irq_domain_ops ts_intr_irq_domain_ops = {
> +	.alloc		= ts_intr_irq_domain_alloc,
> +	.free		= ts_intr_irq_domain_free,
> +};
> +
> +static int tsr_init(struct device_node *node)
> +{
> +	tsr_data.tsr_base = of_iomap(node, 0);
> +	if (IS_ERR(tsr_data.tsr_base)) {
> +		pr_err("Unable to get reg\n");
> +		return PTR_ERR(tsr_data.tsr_base);
> +	}
> +
> +	tsr_data.domain = irq_domain_create_tree(&node->fwnode, &ts_intr_irq_domain_ops, &tsr_data);

So this instantiates a interrupt domain which is completely disconnected
from the rest of the world.

How is the output side of this supposed to handle an interrupt which is
routed to it?

Thanks,

        tglx



