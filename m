Return-Path: <netdev+bounces-288991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJyFO4rsCmo89gQAu9opvQ
	(envelope-from <netdev+bounces-288991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:40:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 351EF56AD45
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1B6D301625E
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5A53F20E5;
	Mon, 18 May 2026 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="px1tNRIX"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35BF3F5BF0
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100568; cv=none; b=HwV450qe4Gz9lVd1a18cjcZf5Btqqv3oohjZs0JSZ2ccDe9gyeM9YAvwLmujaweJ0ugtKVR1cD57FDjj1OQH5OfkhWebxY/UBGDKcgmcBPYVg0kE/I0EK80fzxOFZi5p0a6Ulhqpot1+EPc8mFBeVKms52xQChXp62Yxs1vt5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100568; c=relaxed/simple;
	bh=Fm3zA/DMxlruL4EOWMqRV/YcpdkTIjLqS3ePMEWOgw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFgt915giyHM0fBcG0m2HZP9lwLm3wlid4LO2gHHOk9MR2jzfANJ9HJlK2gLTk+EUrsAlUpH9opo2/6gILrGqTfyVwR+UM4hfYeYINLg+M1fxd3ec3W436gAey+wpdJXoMgy5mBG66HAlsmzuj4pbmQQ3SWOr1gfNWajWkCWli8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=px1tNRIX; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a181d845-5738-4f6c-87f1-cfa7a3429e65@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779100541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xJHEWZLDl5XB4+Od4nk2K3Ey+PuFR9OX3ThlmbfGB0=;
	b=px1tNRIXwLXBr9FMob6zkoGbySLXmZxiY3l7pdZ7tOwvY1iuSyD/h4L0iHZD5O6c/lD9CW
	4yVkdw2UP0t43169yFRdyZl92BpqVKrgrTuHfX55GbD1rz20vKatpkhd2irBi6MNef/M2E
	ugLVTR7Yj7+bC3PUv3BoDZ8s8XYEKzI=
Date: Mon, 18 May 2026 11:35:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] ptp: ocp: fix resource freeing order
To: Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
References: <20260514100055.2014501-1-vadim.fedorenko@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260514100055.2014501-1-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 351EF56AD45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288991-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,redhat.com,nxp.com,armlinux.org.uk,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 14/05/2026 11:00, Vadim Fedorenko wrote:
> Commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable
> events") added a call to ptp_disable_all_events() which changes the
> configuration of pins if they support EXTTS events. In ptp_ocp_detach()
> pins resources are freed before ptp_clock_unregister() and it leads to
> use-after-free during driver removal. Fix it by changing the order of
> free/unregister calls.
> 
> Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable events")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
> v2 -> v3:
> * fix code issue in v2
> v1 -> v2:
> * on v1 sashiko mentioned that some IRQs may fire after bp->ptp freed.
>    it looks like a false positive, because ptp_clock_unregister() will
>    explicitly disable all EXTTS channels before destroying ptp_clock
>    structure. But there is a possibility of timestampers being active
>    without PTP_PF_EXTTS function set. It can be done through sysfs files
>    and it will change pins configuration directly, but can only be done
>    for TS1..TS4. Disable them explicitly after detaching sysfs files.
> ---
> 
>   drivers/ptp/ptp_ocp.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index beacc2ffb166..b3a9480b9bcb 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -4867,6 +4867,18 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>   	ptp_ocp_detach_sysfs(bp);
>   	ptp_ocp_attr_group_del(bp);
>   	timer_delete_sync(&bp->watchdog);
> +	/* Disable interrupts on all timestampers */
> +	if (bp->ts1)
> +		ptp_ocp_ts_enable(bp->ts1, 0, false);
> +	if (bp->ts2)
> +		ptp_ocp_ts_enable(bp->ts2, 0, false);
> +	if (bp->ts3)
> +		ptp_ocp_ts_enable(bp->ts3, 0, false);
> +	if (bp->ts4)
> +		ptp_ocp_ts_enable(bp->ts4, 0, false);
> +	if (bp->ptp)
> +		ptp_clock_unregister(bp->ptp);
> +	kfree(bp->ptp_info.pin_config);
>   	ptp_ocp_unregister_ext(bp->ts0);
>   	ptp_ocp_unregister_ext(bp->ts1);
>   	ptp_ocp_unregister_ext(bp->ts2);
> @@ -4884,9 +4896,6 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>   		clk_hw_unregister_fixed_rate(bp->i2c_clk);
>   	if (bp->n_irqs)
>   		pci_free_irq_vectors(bp->pdev);
> -	if (bp->ptp)
> -		ptp_clock_unregister(bp->ptp);
> -	kfree(bp->ptp_info.pin_config);
>   	device_unregister(&bp->dev);
>   }
>   

Looks like Sashiko still has a point of in-flight irq handler.
Going to send v4 with synchronize_irq() added to the disable path
of ptp_ocp_ts_enable()

---
pw-bot: cr


