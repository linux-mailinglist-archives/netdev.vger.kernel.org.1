Return-Path: <netdev+bounces-117350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFE994DAAD
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 06:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD822B21405
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 04:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB1613B7A6;
	Sat, 10 Aug 2024 04:22:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3D1311A7;
	Sat, 10 Aug 2024 04:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723263749; cv=none; b=J5gR17cQZ2x1Z3xeqycpUskEnxpRQovm52ZI9TJDI4F9ire530ljNowdV9UHen5khJMM/L5vyKFQzGHsXwtiRBItOW5spOjIbykLoQQ5AHPALel2wgctNdR8+UGK6yV3Jg+PbTOs/RVK4h1i/F2mysQqSpiL2+6JXolEnZvFrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723263749; c=relaxed/simple;
	bh=J1ERLZ5Ep/u8vGLI7GqYlRKh9GNoDHm9yqpby3UpK/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5x4mLX7M2Yi3uST0y7sB/RYgnEhOirJcylPyyC3NDorXLId79H4E1mcJUdHja9m7LP+2F3KW3WmhjS4vf8UyL6xWvSU1gjAlidaCuFP6pn7ohwyuBU+zD3V+cy2wsB32MXCg3iSH3UpAPqEwrSqfCVB4EPv5ERe3YGADL3lrE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af7d5.dynamic.kabel-deutschland.de [95.90.247.213])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B600A61E5FE05;
	Sat, 10 Aug 2024 06:21:18 +0200 (CEST)
Message-ID: <c0782e49-dc5b-4c04-8122-46e81ab98c23@molgen.mpg.de>
Date: Sat, 10 Aug 2024 06:21:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] igb: Fix not clearing
 TimeSync interrupts for 82580
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, sasha.neftin@intel.com,
 netdev@vger.kernel.org, richardcochran@gmail.com, kurt@linutronix.de,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 daiweili@gmail.com, anthony.l.nguyen@intel.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20240810002302.2054816-1-vinicius.gomes@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240810002302.2054816-1-vinicius.gomes@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Vinicius,


Thank you for the patch.


Am 10.08.24 um 02:23 schrieb Vinicius Costa Gomes:
> It was reported that 82580 NICs have a hardware bug that makes it
> necessary to write into the TSICR (TimeSync Interrupt Cause) register
> to clear it.

Were you able to verify that report by checking against some errata? Is 
Intel aware of the problem?

> Add a conditional so only for 82580 we write into the TSICR register,
> so we don't risk losing events for other models.
> 
> This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sync events").
> 
> Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
> Reported-by: Daiwei Li <daiweili@gmail.com>
> Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com/
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
> 
> @Daiwei Li, I don't have a 82580 handy, please confirm that the patch
> fixes the issue you are having.

Please also add a description of the test case, and maybe the PCI vendor 
and device code of your network device.

>   drivers/net/ethernet/intel/igb/igb_main.c | 27 ++++++++++++++++++-----
>   1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 11be39f435f3..edb34f67ae03 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -6960,31 +6960,48 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
>   static void igb_tsync_interrupt(struct igb_adapter *adapter)
>   {
>   	struct e1000_hw *hw = &adapter->hw;
> -	u32 tsicr = rd32(E1000_TSICR);
> +	u32 ack = 0, tsicr = rd32(E1000_TSICR);
>   	struct ptp_clock_event event;
>   
>   	if (tsicr & TSINTR_SYS_WRAP) {
>   		event.type = PTP_CLOCK_PPS;
>   		if (adapter->ptp_caps.pps)
>   			ptp_clock_event(adapter->ptp_clock, &event);
> +		ack |= TSINTR_SYS_WRAP;
>   	}
>   
>   	if (tsicr & E1000_TSICR_TXTS) {
>   		/* retrieve hardware timestamp */
>   		schedule_work(&adapter->ptp_tx_work);
> +		ack |= E1000_TSICR_TXTS;
>   	}
>   
> -	if (tsicr & TSINTR_TT0)
> +	if (tsicr & TSINTR_TT0) {
>   		igb_perout(adapter, 0);
> +		ack |= TSINTR_TT0;
> +	}
>   
> -	if (tsicr & TSINTR_TT1)
> +	if (tsicr & TSINTR_TT1) {
>   		igb_perout(adapter, 1);
> +		ack |= TSINTR_TT1;
> +	}
>   
> -	if (tsicr & TSINTR_AUTT0)
> +	if (tsicr & TSINTR_AUTT0) {
>   		igb_extts(adapter, 0);
> +		ack |= TSINTR_AUTT0;
> +	}
>   
> -	if (tsicr & TSINTR_AUTT1)
> +	if (tsicr & TSINTR_AUTT1) {
>   		igb_extts(adapter, 1);
> +		ack |= TSINTR_AUTT1;
> +	}
> +
> +	if (hw->mac.type == e1000_82580) {
> +		/* 82580 has a hardware bug that requires a explicit

a*n*

> +		 * write to clear the TimeSync interrupt cause.
> +		 */
> +		wr32(E1000_TSICR, ack);
> +	}

Is there a nicer way to write this, so `ack` is only assigned in case 
for the 82580?

>   }
>   
>   static irqreturn_t igb_msix_other(int irq, void *data)


Kind regards,

Paul

