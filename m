Return-Path: <netdev+bounces-164396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0AAA2DBAE
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 09:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABBD3A56EF
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75286331;
	Sun,  9 Feb 2025 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IK4fvz9s"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E08E57D;
	Sun,  9 Feb 2025 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739090234; cv=none; b=ibLUXVpDhuCB7rSWcCzniogNnTQz0nQa9FOtAO5kFzC3YfhfZgmoe8qqWKGbIo7UWiVIU3Wd1et3+Xmf+R2/hy6VuR1UPqCakCLNUii0EDFBJIGmKiyocM9b6LqEy7mE1rnBiyODNoTa8Uf917ExlAY25eBDKu3fU3NtDC0ACy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739090234; c=relaxed/simple;
	bh=PR6ksHgpbyrT0ZsFiZTNIUU6+rlzpFCfFx+9GafRar4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fl1BqVGJXhpo61bqFgo2HHLYaQP364Z9rQPD5mz5IlAduAfC9Im4kNmxXyyqXbp9XN907cMvKfOmBwgAuK4s1d/o/DNbW/e5tAUqPddHbIXVMF4YYO9PCjF2voiQqioCwnI/1JOPc2Z51t0a0E2kFRkbtCgsKmTYoaIpQoeQNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IK4fvz9s; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5198akxq3213675
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Feb 2025 02:36:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739090206;
	bh=Mn4lMnvvmy1BglkQz0uTKuPE+nzuikcohuPbAhGDdcw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=IK4fvz9sfhV+pee1ke+c5o4VMqMxQjaTGUcwKUQr5oOh3hl1B1SvIbF8aYWnHcTi2
	 6rhalYOmPe+1JqY+EDOySVmArJtx6urJJSMat/OZm/bPsEBNHSliZxAlVUwPV93s5Z
	 hlfCEb11F96Gj6Ukpex4MAA+pOUSHcX9IOzh+70w=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5198akLn092987
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 9 Feb 2025 02:36:46 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 9
 Feb 2025 02:36:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 9 Feb 2025 02:36:46 -0600
Received: from [10.249.135.49] ([10.249.135.49])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5198afGR112742;
	Sun, 9 Feb 2025 02:36:42 -0600
Message-ID: <09880b14-cef1-44cd-9fa4-8840fb673c0a@ti.com>
Date: Sun, 9 Feb 2025 14:06:40 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] irqchip: ti-tsir: Add support for Timesync
 Interrupt Router
To: Thomas Gleixner <tglx@linutronix.de>, Jason Reeder <jreeder@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <m-malladi@ti.com>
References: <20250205160119.136639-1-c-vankar@ti.com>
 <20250205160119.136639-2-c-vankar@ti.com> <87lduin4o5.ffs@tglx>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <87lduin4o5.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Thomas,

Thank you for the reply, I will address your comments to modify license
identifier, comments, helper function for offset calculation. I have
prioritized explaining Timesync interrupt router's functionality below.


On 2/7/2025 2:58 AM, Thomas Gleixner wrote:
> On Wed, Feb 05 2025 at 21:31, Chintan Vankar wrote:
>> +++ b/drivers/irqchip/ti-timesync-intr.c
>> @@ -0,0 +1,109 @@
>> +// SPDX-License-Identifier: GPL
> 
> That's not a valid license identifier
> 
>> +static struct irq_chip ts_intr_irq_chip = {
>> +	.name			= "TIMESYNC_INTRTR",
>> +};
> 
> How is this interrupt chip supposed to work? All it implements is a
> name.
> 

Timesync INTR can be used to map input sources with the corresponding
output, so that we can configure specific functionality for the device
that is using this output sources either as an interrupt source or to
synchronize the time.

To implement above Timesync INTR's functionality, I have implemented
ts_intr_irq_domain_alloc() and ts_intr_irq_domain_free() ops which are
sufficient. Let me know if they are fine.

>> +static int ts_intr_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> +				    unsigned int nr_irqs, void *arg)
>> +{
>> +	unsigned int output_line, input_line, output_line_offset;
>> +	struct irq_fwspec *fwspec = (struct irq_fwspec *)arg;
>> +	int ret;
>> +
>> +	irq_domain_set_hwirq_and_chip(domain, virq, output_line,
>> +				      &ts_intr_irq_chip,
>> +				      NULL);
> 
> You set the interrupt chip and data before validating that the input
> argument is valid. That does not make any sense.
> 
>> +	/* Check for two input parameters: output line and corresponding input line */
>> +	if (fwspec->param_count != 2)
>> +		return -EINVAL;
>> +
>> +	output_line = fwspec->param[0];
>> +
>> +	/* Timesync Interrupt Router's mux-controller register starts at offset 4 from base
>> +	 * address and each output line are at offset in multiple of 4s in Timesync INTR's
>> +	 * register space, calculate the register offset from provided output line.
>> +	 */
> 
> Please use proper kernel comment style as documented:
> 
>    https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#comment-style
> 
> This is not networking code.
> 
>> +	output_line_offset = 4 * output_line + 0x4;
> 
> Magic hardcoded numbers '4' and '0x4' without any explanation of the logic.
> 
>> +	output_line_to_virq[output_line] = virq;
>> +	input_line = fwspec->param[1] & TIMESYNC_INTRTR_ENABLE;
>> +
>> +	/* Map output line corresponding to input line */
>> +	writel(input_line, tsr_data.tsr_base + output_line_offset);
>> +
>> +	/* When interrupt enable bit is set for Timesync Interrupt Router it maps the output
>> +	 * line with the existing input line, hence enable interrupt line after we set bits for
>> +	 * output line.
> 
> I have no idea what this comment is trying to tell me.
> 
>> +	 */
>> +	input_line |= TIMESYNC_INTRTR_INT_ENABLE;
>> +	writel(input_line, tsr_data.tsr_base + output_line_offset);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ts_intr_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>> +				    unsigned int nr_irqs)
>> +{
>> +	struct output_line_to_virq *node, *n;
>> +	unsigned int output_line_offset;
>> +	int i;
>> +
>> +	for (i = 0; i < TIMESYNC_INTRTR_MAX_OUTPUT_LINES; i++) {
>> +		if (output_line_to_virq[i] == virq) {
>> +			/* Calculate the register offset value from provided output line */
> 
> Can you please implement a properly commented helper function which
> explains how this offset calculation is supposed to work?
> 
>> +			output_line_offset = 4 * i + 0x4;
>> +			writel(~TIMESYNC_INTRTR_INT_ENABLE, tsr_data.tsr_base + output_line_offset);
>> +		}
>> +	}
>> +}
>> +
>> +static const struct irq_domain_ops ts_intr_irq_domain_ops = {
>> +	.alloc		= ts_intr_irq_domain_alloc,
>> +	.free		= ts_intr_irq_domain_free,
>> +};
>> +
>> +static int tsr_init(struct device_node *node)
>> +{
>> +	tsr_data.tsr_base = of_iomap(node, 0);
>> +	if (IS_ERR(tsr_data.tsr_base)) {
>> +		pr_err("Unable to get reg\n");
>> +		return PTR_ERR(tsr_data.tsr_base);
>> +	}
>> +
>> +	tsr_data.domain = irq_domain_create_tree(&node->fwnode, &ts_intr_irq_domain_ops, &tsr_data);
> 
> So this instantiates a interrupt domain which is completely disconnected
> from the rest of the world.
>  > How is the output side of this supposed to handle an interrupt which is
> routed to it?
> 

                         ________________________
                        |    Timesync INTR       +---->dma_local_events
                        |                        |
Device sync events----->                        +---->pcie_cpts_hw_push
                        |                        |
          cpts_genf----->                        +---->cpts_hw_push
                        |________________________|


No it is connected, it is being used to configure the output for
Timesync INTR as mentioned above.

As seen in the diagram, Timesync INTR has multiple output interfaces and
we can configure those to map them with the corresponding input as
required by peripherals which receives the signal. In context of this
series, CPTS module is utilizing the output signal of cpts_genf as
Hardware timestamp push event to generate timestamps at 1 seconds.

Let me know if you need more details regarding any of the above points
that I have mentioned.


Regards,
Chintan.

> Thanks,
> 
>          tglx
> 
> 

