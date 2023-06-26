Return-Path: <netdev+bounces-14058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C076173EB81
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 22:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01910280D90
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 20:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B96F1426C;
	Mon, 26 Jun 2023 20:10:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4761814263
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 20:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851EBC433C8;
	Mon, 26 Jun 2023 20:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687810235;
	bh=yuBK0Q1abdvZ/58g4fK2gtVQqivGoLYyU4dEpgWA//M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZQPpfN14Ey9K9lAlUCyKWYkuy+qQDrw7qQtefBRs+qMrmY8+b4xBKyzPUzJjjukjQ
	 7oXsxWowQYk2Nse4kGxFrWbLPGUWQamYFCTk9nWHPCDUEu8VGJRYMK8bka2t1oMZ24
	 MqHbNrWtDrN0TzQg48JkS8YsWGl3sA9CrmQH9k5/+FpkP3rJjolaqjv7CgXH3mg5m/
	 uuJwTZyXKw6CRkbyvHOHPIBum8q2Dy5PA11tUnnL4nYrvvDlY3Zu+Mf8+XeN9TA4VL
	 KWdUCOelpq/6jVe8Dwa17cZHDXTLd6f0+vpQU+WTXHIPMPXUp3I3O7GoI1QIN/68xm
	 Jdqd6NWKJZRqA==
Date: Mon, 26 Jun 2023 13:10:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moritz Fischer <moritzf@google.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, mdf@kernel.org
Subject: Re: [PATCH net-next v2] net: lan743x: Don't sleep in atomic context
Message-ID: <20230626131034.1766bdbf@kernel.org>
In-Reply-To: <20230625182327.984115-1-moritzf@google.com>
References: <20230625182327.984115-1-moritzf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Jun 2023 18:23:27 +0000 Moritz Fischer wrote:
> dev_set_rx_mode() grabs a spin_lock, and the lan743x implementation
> proceeds subsequently to go to sleep using readx_poll_timeout().
> 
> Introduce a helper wrapping the readx_poll_timeout_atomic() function
> and use it to replace the calls to readx_polL_timeout().
> 
> Signed-off-by: Moritz Fischer <moritzf@google.com>
> ---
> 
> Changes from v1:
> - Added line-breaks
> - Changed subject to target net-next
> - Removed Tested-by: tag

Sleeping in atomic context is a bug, this is a bug fix.
You should add a Fixes tag (probably 23f0703c125be AFAICT)
and target the patch at net rather than net-next.
Make sure you CC the authors of the patch under fixes (get_maintainer
will point them out if run on a patch file with a Fixes tag)
One more nit below...

>  drivers/net/ethernet/microchip/lan743x_main.c | 22 +++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index f1bded993edc..4f277ffff1dc 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -144,6 +144,19 @@ static int lan743x_csr_light_reset(struct lan743x_adapter *adapter)
>  				  !(data & HW_CFG_LRST_), 100000, 10000000);
>  }
>  
> +static int lan743x_csr_wait_for_bit_atomic(struct lan743x_adapter *adapter,
> +					   int offset, u32 bit_mask,
> +					   int target_value, int udelay_min,
> +					   int udelay_max, int count)
> +{
> +	u32 data;
> +
> +	return readx_poll_timeout_atomic(LAN743X_CSR_READ_OP, offset, data,
> +					 target_value == ((data & bit_mask) ?
> +					 1 : 0), udelay_max,

You can save the awkward wrapping by using a double negation:

					target_value == !!(data & bit_mask)

this is a fairly common form in the kernel.
-- 
pw-bot: cr

