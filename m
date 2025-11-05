Return-Path: <netdev+bounces-235973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A64C379D2
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DE604F0485
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64128272801;
	Wed,  5 Nov 2025 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FJUlcpcv"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CC126C02
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372967; cv=none; b=Kme5vNRokoHPsFhjG4Ai8TpHcdwYeqD+zH6OmAvZcZlXuVLEXy61edLnPNqnOV35q5HiDHyuQYbR08tkHlxoqy87SY+j1DE7DIlK15Vz+jmGvZIhakOE9Z6jQlkEuGiHeS0SbcK5r/tu3h9KPoreGwSjBP8lkF7F72Shm17vJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372967; c=relaxed/simple;
	bh=1UNkHAvIkZsKBsgCcM/AKzKDGjOH+HZN3yV5TRZ9kHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phH0+5ijqMRx5NFaJ9PlmRWd6sXd96EwrquG0erAOZHf8SpAlC/A8EkPtyv5EwwFGFFTc8AKxtn2y2XSW59gObRAA03fL793nfbZ3wXe951H3s+l6pZB3SpVNZNYnUZDgJkJUsnr0BDYcKDtRPuySLSDV5cyE2n4aSX0g38Fiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FJUlcpcv; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <de2f5da5-05db-4bd7-90c3-c51558e50545@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762372953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gVnZSE22cVcS4rxgpdM9tTcUt8tL4gwGdnHKKtUPSY=;
	b=FJUlcpcv9vjP5zo0RqEPDKGmnvz+b8Wcpn9xQgMLQwV7BE0ZnMyCSThhWWjkfs+lH2N12+
	jnQC+PLDw3kZalXL+gyLaQQBjjFrevAwcwJrq/7xtiRiIM/fhSK7I1rJzN0I4lE+WT7Gpa
	K9RBhAypCGBAemx5Gf3b1kXeUi4tYnw=
Date: Wed, 5 Nov 2025 20:02:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: txgbe: remove wx_ptp_init() in device reset flow
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>, stable@vger.kernel.org
References: <17A4943B0AAA971B+20251105020752.57931-1-jiawenwu@trustnetic.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <17A4943B0AAA971B+20251105020752.57931-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/11/2025 02:07, Jiawen Wu wrote:
> The functions txgbe_up() and txgbe_down() are called in pairs to reset
> hardware configurations. PTP stop function is not called in
> txgbe_down(), so there is no need to call PTP init function in
> txgbe_up().
> 

txgbe_reset() is called during txgbe_down(), and it calls
wx_ptp_reset(), which I believe is the reason for wx_ptp_init() call

> Fixes: 06e75161b9d4 ("net: wangxun: Add support for PTP clock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>   drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index daa761e48f9d..114d6f46139b 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -297,7 +297,6 @@ void txgbe_down(struct wx *wx)
>   void txgbe_up(struct wx *wx)
>   {
>   	wx_configure(wx);
> -	wx_ptp_init(wx);
>   	txgbe_up_complete(wx);
>   }
>   


