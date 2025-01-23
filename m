Return-Path: <netdev+bounces-160676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C167A1ACD8
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 23:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993A416BC1E
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 22:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534A51CCED2;
	Thu, 23 Jan 2025 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="NMeSD0mJ"
X-Original-To: netdev@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200A14A4E1
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737672676; cv=none; b=XHyTYveHY4b93eZqRCT7SYLQ/4wvPv9fVht78FCYhDPm9ITFyyzZJLgPK1/kutFPvKq1IrEawKd2R4r1q75bYdwJ30Koua5HcEJ+ASP+l7QyMtpMOMHzLPvraklFO/5RfIW+odccvrb4rvqI+iUYp1Kxf1nY4KlbrzV7UADOSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737672676; c=relaxed/simple;
	bh=qgFHtDLubgczIuL0ZYBHjoNre/n1EVJvuZASN6L5QZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7BlNcciwqBOsYm0iIqz509WTAXS9eWJMHiXs41OiP8s6YTMMwKKI1duuEpSFOUBZdawhPJxVV+l9ES/gNRxDb60zVsLi/tMEdDoiR+WZ+5Ls4b0OWCj1vB36PbwCbue/z80eqt37MHMPnC3MBV0gcD9gxlFwYSXlOSmsBv/ySo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=NMeSD0mJ; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 50NMmaef2035355;
	Thu, 23 Jan 2025 23:48:36 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 50NMmaef2035355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1737672516;
	bh=vD5tV6KFOJoi4vMlQ5Yc1S8T7BXYAcEXpxunyk1ccqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMeSD0mJbMT9UvwxWu1pnFYQwgLXsSVrl+q/7TSBoDkcdHZlFUKCdTgRctVnRWFtb
	 k5tK1VsoDXPFRU8OqoYJG/PY0B9TZBu91Aav8nicNNOyR6/Ux3B6VFgvIpYaX3kKf2
	 E9AjK6K5lW1nV15nIgLUrv7kdkPzmoVM10IqUO4o=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 50NMmaAt2035354;
	Thu, 23 Jan 2025 23:48:36 +0100
Date: Thu, 23 Jan 2025 23:48:35 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
        dan.carpenter@linaro.org, kuniyu@amazon.com
Subject: Re: [PATCH net v2 4/7] eth: 8139too: fix calling napi_enable() in
 atomic context
Message-ID: <20250123224835.GA2034432@electric-eye.fr.zoreil.com>
References: <20250123004520.806855-1-kuba@kernel.org>
 <20250123004520.806855-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123004520.806855-5-kuba@kernel.org>
X-Organisation: Land of Sunshine Inc.

Jakub Kicinski <kuba@kernel.org> :
> napi_enable() may sleep now, take netdev_lock() before tp->lock and
> tp->rx_lock.
[...]
> diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
> index 9ce0e8a64ba8..a73dcaffa8c5 100644
> --- a/drivers/net/ethernet/realtek/8139too.c
> +++ b/drivers/net/ethernet/realtek/8139too.c
> @@ -1684,6 +1684,7 @@ static void rtl8139_tx_timeout_task (struct work_struct *work)
>  	if (tmp8 & CmdTxEnb)
>  		RTL_W8 (ChipCmd, CmdRxEnb);
>  
> +	netdev_lock(dev);
>  	spin_lock_bh(&tp->rx_lock);
>  	/* Disable interrupts by clearing the interrupt mask. */
>  	RTL_W16 (IntrMask, 0x0000);
> @@ -1694,11 +1695,12 @@ static void rtl8139_tx_timeout_task (struct work_struct *work)
>  	spin_unlock_irq(&tp->lock);
>  
>  	/* ...and finally, reset everything */
> -	napi_enable(&tp->napi);
> +	napi_enable_locked(&tp->napi);
>  	rtl8139_hw_start(dev);
>  	netif_wake_queue(dev);
>  
>  	spin_unlock_bh(&tp->rx_lock);
> +	netdev_unlock(dev);
>  }

I wonder why the old-style napi_enable could not be moved right before
spin_lock_bh(&tp->rx_lock) above.

/me checks...

The napi poll handler of the driver only does Rx processing. Tx completion
is performed in the IRQ handler [*]. rtl8139_tx_timeout_task is only triggered
after Tx timeout. The bh locked section above provides exclusion against the
whole content of the napi poll handler 

If a request for the napi poll handler is instantly racing with the timeout
task right before spin_lock_bh(&tp->rx_lock) ... CmdTxEnb may be enabled early
in rtl8139_rx_err. :o(

RTL_W8(ChipCmd, CmdRxEnb) above is PCI posted and thus already racy wrt
CmdTxEnb but simply moving napi_enable can't be formally claimed to be
safe. Too bad.

Acked-by: Francois Romieu <romieu@fr.zoreil.com>

[*] Not that uncommon pre subprime crisis napi design style btw.

-- 
Ueimor

