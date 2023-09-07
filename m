Return-Path: <netdev+bounces-32369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDEB797218
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 13:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FB91C20AB2
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6888E5695;
	Thu,  7 Sep 2023 11:57:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C972568E
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 11:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351C4C32787;
	Thu,  7 Sep 2023 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694087863;
	bh=IiWKDkQriSJY7uNq9McX4e02b9boWJP1Kz2RdBgaXa4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O9PP/bh9M/JWo10UUvn8eP30TEUjUIABtRFF//RuliAfxgPoXeSgTnLHow8+GdFFy
	 hClXwlQ//6Ki54JL/wwZPyZ+EdwC3A2n5Lrff9S5OEAonHKGfkN9OoNYGz1KhQLM/H
	 d7qOwqZjBmaAjeVEHgz/GWC9FOFSKAGQyiuHzBT/6S1AwFNMxgKUdB7COuX3UA0qwe
	 K680o8OryArSCtd+mZSIm/BBTifzp1Ky0/KZeWqXx2w27wBlHbUdCOisjDmumcDNZ1
	 TGj1Uh9XL8RLP4hnh77ljQJ6cmT0sZ/FFQDE6dvy2GlGzdJCcjpR0TEFQePQc9X0cw
	 9788ts2juoSbA==
Message-ID: <07bda9b4-cd82-70b1-34af-7f4bb393e7c2@kernel.org>
Date: Thu, 7 Sep 2023 14:57:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 1/4] net: ti: icssg-prueth: Add helper
 functions to configure FDB
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
References: <20230830110847.1219515-1-danishanwar@ti.com>
 <20230830110847.1219515-2-danishanwar@ti.com>
 <edfbaf8e-16df-4a25-8647-79b8730dca08@lunn.ch>
 <0d71caf1-6fc2-9b77-1a72-54a354e89f03@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <0d71caf1-6fc2-9b77-1a72-54a354e89f03@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/09/2023 11:36, MD Danish Anwar wrote:
> Hi Andrew
> 
> On 04/09/23 19:32, Andrew Lunn wrote:
>>> +int icssg_send_fdb_msg(struct prueth_emac *emac, struct mgmt_cmd *cmd,
>>> +		       struct mgmt_cmd_rsp *rsp)
>>> +{
>>> +	struct prueth *prueth = emac->prueth;
>>> +	int slice = prueth_emac_slice(emac);
>>> +	int i = 10000;
>>> +	int addr;
>>> +
>>> +	addr = icssg_queue_pop(prueth, slice == 0 ?
>>> +			       ICSSG_CMD_POP_SLICE0 : ICSSG_CMD_POP_SLICE1);
>>> +	if (addr < 0)
>>> +		return addr;
>>> +
>>> +	/* First 4 bytes have FW owned buffer linking info which should
>>> +	 * not be touched
>>> +	 */
>>> +	memcpy_toio(prueth->shram.va + addr + 4, cmd, sizeof(*cmd));
>>> +	icssg_queue_push(prueth, slice == 0 ?
>>> +			 ICSSG_CMD_PUSH_SLICE0 : ICSSG_CMD_PUSH_SLICE1, addr);
>>> +	while (i--) {
>>> +		addr = icssg_queue_pop(prueth, slice == 0 ?
>>> +				       ICSSG_RSP_POP_SLICE0 : ICSSG_RSP_POP_SLICE1);
>>> +		if (addr < 0) {
>>> +			usleep_range(1000, 2000);
>>> +			continue;
>>> +		}
>>
>> Please try to make use of include/linux/iopoll.h.
>>
> 
> I don't think APIs from iopoll.h will be useful here.
> readl_poll_timeout() periodically polls an address until a condition is
> met or a timeout occurs. It takes address, condition as argument and
> store the value read from the address in val.

You need to use read_poll_timeout() and provide the read function as
first argument 'op'. The arguments to the read function can be passed as is
at the end. Please read description of read_poll_timeout()

> 
> Here in our use case we need to continuously read the value returned
> from icssg_queue_pop() and check if that is valid or not. If it's not
> valid, we keep polling until timeout happens.
> 
> icssg_queue_pop() does two read operations. It checks if the queue
> number is valid or not. Then it reads the ICSSG_QUEUE_CNT_OFFSET for
> that queue, if the value read is zero it returns inval. After that it
> reads the value from ICSSG_QUEUE_OFFSET of that queue and store it in
> 'val'. The returned value from icssg_queue_pop() is checked
> continuously, if it's an error code, we keep polling. If it's a good
> value then we call icssg_queue_push() with that value. As you can see
> from the below definition of icssg_queue_pop() we are doing two reads
> and two checks for error. I don't think this can be achieved by using
> APIs in iopoll.h. readl_poll_timeout() reads from a single address
> directly but we don't ave a single address that we can pass to
> readl_poll_timeout() as an argument as we have to do two reads from two
> different addresses during each poll.
> 
> So I don't think we can use iopoll.h here. Please let me know if this
> looks ok to you or if there is any other way we can use iopoll.h here
> 
> int icssg_queue_pop(struct prueth *prueth, u8 queue)
> {
>     u32 val, cnt;
> 
>     if (queue >= ICSSG_QUEUES_MAX)
> 	return -EINVAL;
> 
>     regmap_read(prueth->miig_rt, ICSSG_QUEUE_CNT_OFFSET + 4*queue,&cnt);
>     if (!cnt)
> 	return -EINVAL;
> 
>     regmap_read(prueth->miig_rt, ICSSG_QUEUE_OFFSET + 4 * queue, &val);
> 
>     return val;
> }
> 
>>> +	if (i <= 0) {
>>> +		netdev_err(emac->ndev, "Timedout sending HWQ message\n");
>>> +		return -EINVAL;
>>
>> Using iopoll.h will fix this, but -ETIMEDOUT, not -EINVAL.
>>
> 
> -ETIMEDOUT is actually a better suited error code here, I will change
> -EINVAL to -ETIMEDOUT in this if check.
> 
>>       Andrew
>>
> 

-- 
cheers,
-roger

