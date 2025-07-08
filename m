Return-Path: <netdev+bounces-204848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A90AFC3F5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D400C7A9F8A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8E298261;
	Tue,  8 Jul 2025 07:26:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx-b.polytechnique.fr (mx-b.polytechnique.fr [129.104.30.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE56621D3D4;
	Tue,  8 Jul 2025 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.104.30.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959573; cv=none; b=c3nSvqWwqkzvPxZhqBDbVLd+Qs3MrLuSWn9j5coVKk8P1YrLQGU7xDnXFlqMZIlygmQbKbXEycRSQM6GwUJU3XDfuiv/3UrKjY7VayHZhort/42Me5Qw65kMEa10QdqILl3cS05QkJxFWvkXWHs+pw1ZE/pwD09m+CDKd3IpRGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959573; c=relaxed/simple;
	bh=tHxi7kgTAtCsOXorU7xcD7RTd0CJWtbq1kW7cCL8oAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMUpmdGIvY6/pWwrsH+ZVp3l/DFB18BK174Q7ayJX5mCwpG+uWiPF1IKIwisW6sHXDemInE+Yy4OpXMhEkMfI/mMpN0gB2XXyVWRL9wjnZ5dIXpf/Eh0aTh0PUwp7rb1HgjmCcT+q0FJ2IdUsdsMIxMoYBL6ffKAXy2oqPEgIAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=129.104.30.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from zimbra.polytechnique.fr (zimbra.polytechnique.fr [129.104.69.30])
	by mx-b.polytechnique.fr (tbp 25.10.18/2.0.8) with ESMTP id 5687DxNk024482;
	Tue, 8 Jul 2025 09:14:00 +0200
Received: from localhost (localhost [127.0.0.1])
	by zimbra.polytechnique.fr (Postfix) with ESMTP id B189C762EA2;
	Tue,  8 Jul 2025 09:13:59 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.polytechnique.fr
Received: from zimbra.polytechnique.fr ([127.0.0.1])
 by localhost (zimbra.polytechnique.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id sLiiPZPqUxi1; Tue,  8 Jul 2025 09:13:59 +0200 (CEST)
Received: from [129.88.52.32] (webmail-69.polytechnique.fr [129.104.69.39])
	by zimbra.polytechnique.fr (Postfix) with ESMTPSA id 5A7347610E9;
	Tue,  8 Jul 2025 09:13:59 +0200 (CEST)
Message-ID: <5bc75927-398d-4b8c-98d9-7f321ed70ca4@gmail.com>
Date: Tue, 8 Jul 2025 09:13:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethernet: et131x: Add missing check after DMA map
To: Simon Horman <horms@kernel.org>
Cc: Mark Einon <mark.einon@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250707090955.69915-1-fourier.thomas@gmail.com>
 <20250707200143.GD452973@horms.kernel.org>
Content-Language: en-US, fr
From: Thomas Fourier <fourier.thomas@gmail.com>
In-Reply-To: <20250707200143.GD452973@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/07/2025 22:01, Simon Horman wrote:

> On Mon, Jul 07, 2025 at 11:09:49AM +0200, Thomas Fourier wrote:
>> The DMA map functions can fail and should be tested for errors.
>> If the mapping fails, unmap and return an error.
>>
>> Fixes: 38df6492eb51 ("et131x: Add PCIe gigabit ethernet driver et131x to drivers/net")
>> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> nits:
>
> 1) There are two spaces after "et131x:" in the subject.
>     One is enough.
>
> 2) I think you can drop "ethernet: " from the subject.
>     "et131x: " seems to be an appropriate prefix based on git history.
>
> ...
Ok, I'll make sure to fix that.
>
>> @@ -2578,6 +2593,28 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
>>   		       &adapter->regs->global.watchdog_timer);
>>   	}
>>   	return 0;
>> +
>> +unmap_out:
>> +	// Unmap everything from i-1 to 1
>> +	while (--i) {
>> +		frag--;
>> +		dma_addr = desc[frag].addr_lo;
>> +		dma_addr |= (u64)desc[frag].addr_hi << 32;
>> +		dma_unmap_page(&adapter->pdev->dev, dma_addr,
>> +			       desc[frag].len_vlan, DMA_TO_DEVICE);
>> +	}
> I'm probably missing something obvious. But it seems to me that frag is
> incremented iff a mapping is successful. So I think only the loop below is
> needed.
Yes, frag is incremented only after a successful mapping.

The first loop is to unmap the body of the packet (i >= 1) which is mapped

with skb_frag_dma_map() (and unmapped with dma_unmap_page).  The

second is to unmap the header which is either one or two mappings of

map_single.  Should I make the comments more explicit?

>
>> +
>> +unmap_first_out:
>> +	// unmap header
>> +	while (frag--) {
>> +		frag--;
> I don't think you want to decrement frag twice here.
>
>> +		dma_addr = desc[frag].addr_lo;
>> +		dma_addr |= (u64)desc[frag].addr_hi << 32;
>> +		dma_unmap_single(&adapter->pdev->dev, dma_addr,
>> +				 desc[frag].len_vlan, DMA_TO_DEVICE);
>> +	}
>> +
>> +	return -ENOMEM;
>>   }
>>   
>>   static int send_packet(struct sk_buff *skb, struct et131x_adapter *adapter)

