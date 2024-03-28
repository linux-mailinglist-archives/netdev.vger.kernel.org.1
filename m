Return-Path: <netdev+bounces-82733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33ED88F798
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3D4B21AB9
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 06:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E0F4E1BC;
	Thu, 28 Mar 2024 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LYLTNjCc"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05B241E1
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605755; cv=none; b=Ya8kIk7i+1KlLzfrVSMwnHrueFUd7umramNC1NALqJtK76YbMHbRW/vmraLV+qpJFawtgTxL33+3cmcKQrXbMcg1gMI58vv8lsjC75GyWxBk6c/CH9++ZP5/fOh/ECnweW73dc37EWC10JWPo1HQXCy4yTeilpXrpdeY7BZBiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605755; c=relaxed/simple;
	bh=SSg/6LeOq6Wjr4nnvlfuPVy2ZR18YLmIn1OPcrktg4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPq18bQ5aeeKhOb66lt8eaiMRrOQkr0KTjALZVvwBiDn13yj1Rp4+Y2msPJ6bf3XybHHtvPXvG0MQee9MG9xAT9cagzny8117R1EgunKZjleQU33r3qJZq3B48TjzTkK54r0rwlEjuGSsU1iW44uDgMdAjZ41KdbUMMKzW6XO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LYLTNjCc; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <00936e03-e4a0-4d93-a576-58a7cd61fd78@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711605751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0lPvbxXSzuDLjfFugorlD3IGCK2hvLcLqcq21+5wnE4=;
	b=LYLTNjCcgJ/ZAMcGl/iUy/7pPNOU/+qIWHm7xEqUMigkC62L/NMudPm17rlhLapzY6wCYs
	S7rHzRDRwcUv7yQCQQUlN9+pbrSrFvhNze7Pj6LRBTonOCQrRMdIzT8wdw3XXndghoWWIC
	IX2QGM+aZzcGxmZrLOnB4G75S34KnJM=
Date: Wed, 27 Mar 2024 23:02:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 02/12] bnxt_en: Retry PTP TX timestamp from FW
 for 1 second
Content-Language: en-US
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 Richard Cochran <richardcochran@gmail.com>
References: <20240325222902.220712-1-michael.chan@broadcom.com>
 <20240325222902.220712-3-michael.chan@broadcom.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240325222902.220712-3-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/03/2024 22:28, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Use a new default 1 second timeout value instead of the existing
> 1 msec value.  The driver will keep track of the remaining time
> before timeout and will pass this value to bnxt_hwrm_port_ts_query().
> The firmware supports timeout values up to 65535 usecs.  If the
> timeout value passed to bnxt_hwrm_port_ts_query() is less than the
> FW max value, we will use that value to precisely control the
> specified timeout.  If it is larger than the FW max value, we will
> use the FW max value and any additional retry to reach the desired
> timeout will be done in the context of bnxt_ptp_ts_aux_eork().
> 
> Link: https://lore.kernel.org/netdev/20240229070202.107488-2-michael.chan@broadcom.com/
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> v2: Don't use the devlink parameter.
>      Pass the timeout parameter to bnxt_hwrm_port_ts_query() to precisely
>      control the timeout.
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 16 +++++++++++++++-
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  4 ++++
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> index dbfd1b36774c..345aac4484ee 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -678,11 +678,17 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
>   {
>   	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
>   	struct skb_shared_hwtstamps timestamp;
> +	unsigned long now = jiffies;
>   	u64 ts = 0, ns = 0;
> +	u32 tmo = 0;
>   	int rc;
>   
> +	if (!ptp->txts_pending)
> +		ptp->abs_txts_tmo = now + msecs_to_jiffies(ptp->txts_tmo);
> +	if (!time_after_eq(now, ptp->abs_txts_tmo))
> +		tmo = jiffies_to_msecs(ptp->abs_txts_tmo - now);
>   	rc = bnxt_hwrm_port_ts_query(bp, PORT_TS_QUERY_REQ_FLAGS_PATH_TX, &ts,
> -				     0);
> +				     tmo);
>   	if (!rc) {
>   		memset(&timestamp, 0, sizeof(timestamp));
>   		spin_lock_bh(&ptp->ptp_lock);
> @@ -691,6 +697,10 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
>   		timestamp.hwtstamp = ns_to_ktime(ns);
>   		skb_tstamp_tx(ptp->tx_skb, &timestamp);
>   	} else {
> +		if (!time_after_eq(jiffies, ptp->abs_txts_tmo)) {
> +			ptp->txts_pending = true;
> +			return;
> +		}
>   		netdev_warn_once(bp->dev,
>   				 "TS query for TX timer failed rc = %x\n", rc);
>   	}
> @@ -698,6 +708,7 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
>   	dev_kfree_skb_any(ptp->tx_skb);
>   	ptp->tx_skb = NULL;
>   	atomic_inc(&ptp->tx_avail);
> +	ptp->txts_pending = false;
>   }
>   
>   static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
> @@ -721,6 +732,8 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
>   		spin_unlock_bh(&ptp->ptp_lock);
>   		ptp->next_overflow_check = now + BNXT_PHC_OVERFLOW_PERIOD;
>   	}
> +	if (ptp->txts_pending)
> +		return 0;
>   	return HZ;
>   }
>   
> @@ -973,6 +986,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
>   		spin_unlock_bh(&ptp->ptp_lock);
>   		ptp_schedule_worker(ptp->ptp_clock, 0);
>   	}
> +	ptp->txts_tmo = BNXT_PTP_DFLT_TX_TMO;
>   	return 0;
>   
>   out:
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> index 04886d5f22ad..6a2bba3f9e2d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> @@ -22,6 +22,7 @@
>   #define BNXT_LO_TIMER_MASK	0x0000ffffffffUL
>   #define BNXT_HI_TIMER_MASK	0xffff00000000UL
>   
> +#define BNXT_PTP_DFLT_TX_TMO	1000 /* ms */
>   #define BNXT_PTP_QTS_TIMEOUT	1000
>   #define BNXT_PTP_QTS_MAX_TMO_US	65535
>   #define BNXT_PTP_QTS_TX_ENABLES	(PORT_TS_QUERY_REQ_ENABLES_PTP_SEQ_ID |	\
> @@ -116,11 +117,14 @@ struct bnxt_ptp_cfg {
>   					 BNXT_PTP_MSG_PDELAY_REQ |	\
>   					 BNXT_PTP_MSG_PDELAY_RESP)
>   	u8			tx_tstamp_en:1;
> +	u8			txts_pending:1;
>   	int			rx_filter;
>   	u32			tstamp_filters;
>   
>   	u32			refclk_regs[2];
>   	u32			refclk_mapped_regs[2];
> +	u32			txts_tmo;
> +	unsigned long		abs_txts_tmo;
>   };
>   
>   #if BITS_PER_LONG == 32

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

