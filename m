Return-Path: <netdev+bounces-186468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2826AA9F438
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A853BB3EB
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EC42798F0;
	Mon, 28 Apr 2025 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C53OhkPF"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249192798EE
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853393; cv=none; b=qlkCXSchjq7E1Jp48/+ps+jjkah1Di7t7rWiaDKFo8yYrKe0fwu1ybjJD+HfeiT5A8R6O/xF03oJb9fTXu4FZDc571t+poT7sTyHGN/Yz+UjAUiP3YSav9slyHlG8U+y4n47PUAJJKZ5E/ig4E8BqSFqy1WQOpQQ8F8Ve1bK8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853393; c=relaxed/simple;
	bh=mJHb2B8JmLWbI+v6S0ndbPV/q48T15N8Qo8z0FRO0Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOToP/RiQ3eb4OfJf5iO+gZaqC62bGyiYYF981F74r7C+HvU0G2bdSTl9P24riXmZELEIruxr+SAXDjB1KitEtdYCQ2i5vtZ0vOW2WvrQqrXIM2jjMjddDJEjK/brtnVHKEm3EWXFLjmIUtzYr0SxZX4AXvdiWoLtM6LlPKVPUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C53OhkPF; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <58c1d1d4-d054-4aab-990b-e2083ceece4c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745853379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9wpo9xvkP876h5QfHzQZysTEzh9aT9zuZWJnciINRY=;
	b=C53OhkPFE9s3QgKRuVtrzo9/wpsFiEris3PN14+qkXAkJDeuzkm3/PMAb5JjSS7BEUOqgy
	LvsGLzog/lSc9pQCXifqPoATGsjopx6omdvkBJuqqaieY5wPGSlC+Bs5vpv5z21dpCi4aU
	ocpA47gz1TZoyJDG0HhvpY2vZcJYOms=
Date: Mon, 28 Apr 2025 16:16:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] ptp: ocp: Fix NULL dereference in Adva board SMA sysfs
 operations
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Sagi Maimon <sagi.maimon@adtran.com>
References: <20250428143748.23729-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250428143748.23729-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/04/2025 15:37, Sagi Maimon wrote:
> From: Sagi Maimon <sagi.maimon@adtran.com>
> 
> On Adva boards, SMA sysfs store/get operations can call
> __handle_signal_outputs() or __handle_signal_inputs() while the `irig`
> and `dcf` pointers are uninitialized, leading to a NULL pointer
> dereference in __handle_signal() and causing a kernel crash. Add
> Adva-specific callbacks ptp_ocp_sma_adva_set_outputs() and
> ptp_ocp_sma_adva_set_inputs() to the ptp_ocp driver, and include NULL
> checks for `irig` and `dcf` to prevent crashes.
> 
> Fixes: ef61f5528fca ("ptp: ocp: add Adva timecard support")
> Signed-off-by: Sagi Maimon <sagi.maimon@adtran.com>
> ---
>   drivers/ptp/ptp_ocp.c | 62 +++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index faf6e027f89a..3eaa2005b3b2 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -2578,12 +2578,70 @@ static const struct ocp_sma_op ocp_fb_sma_op = {
>   	.set_output	= ptp_ocp_sma_fb_set_output,
>   };
>   
> +static int
> +ptp_ocp_sma_adva_set_output(struct ptp_ocp *bp, int sma_nr, u32 val)
> +{
> +	u32 reg, mask, shift;
> +	unsigned long flags;
> +	u32 __iomem *gpio;
> +
> +	gpio = sma_nr > 2 ? &bp->sma_map1->gpio2 : &bp->sma_map2->gpio2;
> +	shift = sma_nr & 1 ? 0 : 16;
> +
> +	mask = 0xffff << (16 - shift);
> +
> +	spin_lock_irqsave(&bp->lock, flags);
> +
> +	reg = ioread32(gpio);
> +	reg = (reg & mask) | (val << shift);
> +
> +	if (bp->irig_out)
> +		ptp_ocp_irig_out(bp, reg & 0x00100010);
> +	if (bp->dcf_out)
> +		ptp_ocp_dcf_out(bp, reg & 0x00200020);

You never initialize neither irig_out nor dcf_out, both checks will
always fail. Looks like a dead code - please, remove it.

> +
> +	iowrite32(reg, gpio);
> +
> +	spin_unlock_irqrestore(&bp->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int
> +ptp_ocp_sma_adva_set_inputs(struct ptp_ocp *bp, int sma_nr, u32 val)
> +{
> +	u32 reg, mask, shift;
> +	unsigned long flags;
> +	u32 __iomem *gpio;
> +
> +	gpio = sma_nr > 2 ? &bp->sma_map2->gpio1 : &bp->sma_map1->gpio1;
> +	shift = sma_nr & 1 ? 0 : 16;
> +
> +	mask = 0xffff << (16 - shift);
> +
> +	spin_lock_irqsave(&bp->lock, flags);
> +
> +	reg = ioread32(gpio);
> +	reg = (reg & mask) | (val << shift);
> +
> +	if (bp->irig_in)
> +		ptp_ocp_irig_in(bp, reg & 0x00100010);
> +	if (bp->dcf_in)
> +		ptp_ocp_dcf_in(bp, reg & 0x00200020);

The same goes here - neither irig_in, nor dcf_in will have real values
for your hardware, please remove this checks.

> +
> +	iowrite32(reg, gpio);
> +
> +	spin_unlock_irqrestore(&bp->lock, flags);
> +
> +	return 0;
> +}
> +
>   static const struct ocp_sma_op ocp_adva_sma_op = {
>   	.tbl		= { ptp_ocp_adva_sma_in, ptp_ocp_adva_sma_out },
>   	.init		= ptp_ocp_sma_fb_init,
>   	.get		= ptp_ocp_sma_fb_get,
> -	.set_inputs	= ptp_ocp_sma_fb_set_inputs,
> -	.set_output	= ptp_ocp_sma_fb_set_output,
> +	.set_inputs	= ptp_ocp_sma_adva_set_inputs,
> +	.set_output	= ptp_ocp_sma_adva_set_output,
>   };
>   
>   static int

pw-bot: cr

