Return-Path: <netdev+bounces-76096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A259A86C4E9
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5458F28BFF1
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776415916C;
	Thu, 29 Feb 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qkRXn6V0"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB98482E5
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198602; cv=none; b=Q/RIrCq99ZxRMkW7JXBafFgJY0GYZt+yutem2FAnJ/oUUwcRi6Wda0VdKY5XY0exPjtRUz+GGkqRV8x066nDCXpRPhL70DQ/QFrLWQ0u+QawKF1z305rhB9plq51U+FoaDMR9gzY/ZAgSnMVRITWwo0RYgUXJiZwLWaKPVVA0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198602; c=relaxed/simple;
	bh=rKIZI8mkCW/o72vSh/5vySFXUUd1ZSZLcFoNZOCXR8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzGQaTKl8g4MOxDi42ZrcWcDt36UoSol+RcWmZ10Mg6SuF7kwpWRhNiKvU5VNqJ/YRhIejT7V941QR0Nx0l/2+5OjBdfm/xK8FybEOIjoEfMAaFljk2eVRsEShZkeXXa1uHrRorWeOFAgFNTsO2vkk9ELnc0b1icx91ZSXXLUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qkRXn6V0; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c38627e-b9b6-43a3-ae66-628976c41247@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709198591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wa3DRGjhE8/44KmXxGKR0TYbciJqzHu8Mu92Y7itEC4=;
	b=qkRXn6V0Uzn+q0gu53nVJaPQ9vPvUGdQa4DZHGeM+DyrSXMWSJO3vrYCvC3rOwsvXoIMe1
	OOJuM9XihjytofxoxWlK56KFZBLl39SGa2l47dvukD8ArCRunRmU/egG/6E/zXGs2YYKgE
	uSB1ajAyT5+zGFNSIRg6nSRzAQPMFfE=
Date: Thu, 29 Feb 2024 09:23:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] bnxt_en: Retry for TX timestamp from FW
 until timeout specified
Content-Language: en-US
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew.gospodarek@broadcom.com, jiri@resnulli.us, richardcochran@gmail.com
References: <20240229070202.107488-1-michael.chan@broadcom.com>
 <20240229070202.107488-3-michael.chan@broadcom.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240229070202.107488-3-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/02/2024 07:02, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Use the ptp_tx_timeout devlink parameter introduced in the previous
> patch to retry querying TX timestamp, up to the timeout specified.
> Firmware supports timeout values up to 65535 microseconds.  The
> driver will set this firmware timeout value according to the
> ptp_tx_timeout parameter.  If the ptp_tx_timeout value exceeds
> the maximum firmware value, the driver will retry in the context
> of bnxt_ptp_ts_aux_work().
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>   Documentation/networking/devlink/bnxt.rst     |  7 +++++++
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 19 ++++++++++++++++---
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  4 +++-
>   3 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/networking/devlink/bnxt.rst b/Documentation/networking/devlink/bnxt.rst
> index a4fb27663cd6..48833c190c5b 100644
> --- a/Documentation/networking/devlink/bnxt.rst
> +++ b/Documentation/networking/devlink/bnxt.rst
> @@ -41,6 +41,13 @@ parameters.
>        - Generic Routing Encapsulation (GRE) version check will be enabled in
>          the device. If disabled, the device will skip the version check for
>          incoming packets.
> +   * - ``ptp_tx_timeout``
> +     - u32
> +     - Runtime
> +     - PTP Transmit timestamp timeout value in milliseconds. The default
> +       value is 1000 and the maximum value is 5000. Use a higher value
> +       on a busy network to prevent timeout retrieving the PTP Transmit
> +       timestamp.
>   
>   Info versions
>   =============
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> index 4b50b07b9771..a05b50162e9e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -122,10 +122,14 @@ static int bnxt_hwrm_port_ts_query(struct bnxt *bp, u32 flags, u64 *ts)
>   	req->flags = cpu_to_le32(flags);
>   	if ((flags & PORT_TS_QUERY_REQ_FLAGS_PATH) ==
>   	    PORT_TS_QUERY_REQ_FLAGS_PATH_TX) {
> +		struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
> +		u32 tmo_us = ptp->txts_tmo * 1000;
> +
>   		req->enables = cpu_to_le16(BNXT_PTP_QTS_TX_ENABLES);
> -		req->ptp_seq_id = cpu_to_le32(bp->ptp_cfg->tx_seqid);
> -		req->ptp_hdr_offset = cpu_to_le16(bp->ptp_cfg->tx_hdr_off);
> -		req->ts_req_timeout = cpu_to_le16(BNXT_PTP_QTS_TIMEOUT);
> +		req->ptp_seq_id = cpu_to_le32(ptp->tx_seqid);
> +		req->ptp_hdr_offset = cpu_to_le16(ptp->tx_hdr_off);
> +		tmo_us = min(tmo_us, BNXT_PTP_QTS_MAX_TMO_US);

With this logic the request will stay longer than expected. With
BNXT_PTP_QTS_MAX_TMO_US hardcoded to 65ms (it's later in the patch),
and TXT timestamp timeout set for 270ms, the request will wait for 325ms
in total. It doesn't look like a blocker, but it's definitely area to
improve given that only one TX timestamp request can be in-flight.

> +		req->ts_req_timeout = cpu_to_le16(tmo_us);
>   	}
>   	resp = hwrm_req_hold(bp, req);
>   
> @@ -675,6 +679,8 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
>   	u64 ts = 0, ns = 0;
>   	int rc;
>   
> +	if (!ptp->txts_pending)
> +		ptp->abs_txts_tmo = jiffies + msecs_to_jiffies(ptp->txts_tmo);
>   	rc = bnxt_hwrm_port_ts_query(bp, PORT_TS_QUERY_REQ_FLAGS_PATH_TX, &ts);
>   	if (!rc) {
>   		memset(&timestamp, 0, sizeof(timestamp));
> @@ -684,6 +690,10 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
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
> @@ -691,6 +701,7 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
>   	dev_kfree_skb_any(ptp->tx_skb);
>   	ptp->tx_skb = NULL;
>   	atomic_inc(&ptp->tx_avail);
> +	ptp->txts_pending = false;
>   }
>   
>   static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
> @@ -714,6 +725,8 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
>   		spin_unlock_bh(&ptp->ptp_lock);
>   		ptp->next_overflow_check = now + BNXT_PHC_OVERFLOW_PERIOD;
>   	}
> +	if (ptp->txts_pending)
> +		return 0;
>   	return HZ;
>   }
>   
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> index ee977620d33e..bfb165d2b365 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> @@ -24,7 +24,7 @@
>   
>   #define BNXT_PTP_DFLT_TX_TMO	1000 /* ms */
>   #define BNXT_PTP_MAX_TX_TMO	5000 /* ms */
> -#define BNXT_PTP_QTS_TIMEOUT	1000
> +#define BNXT_PTP_QTS_MAX_TMO_US	65535
             ^^^^
This is the request timeout definition

>   #define BNXT_PTP_QTS_TX_ENABLES	(PORT_TS_QUERY_REQ_ENABLES_PTP_SEQ_ID |	\
>   				 PORT_TS_QUERY_REQ_ENABLES_TS_REQ_TIMEOUT | \
>   				 PORT_TS_QUERY_REQ_ENABLES_PTP_HDR_OFFSET)
> @@ -117,12 +117,14 @@ struct bnxt_ptp_cfg {
>   					 BNXT_PTP_MSG_PDELAY_REQ |	\
>   					 BNXT_PTP_MSG_PDELAY_RESP)
>   	u8			tx_tstamp_en:1;
> +	u8			txts_pending:1;
>   	int			rx_filter;
>   	u32			tstamp_filters;
>   
>   	u32			refclk_regs[2];
>   	u32			refclk_mapped_regs[2];
>   	u32			txts_tmo;
> +	unsigned long		abs_txts_tmo;
>   };
>   
>   #if BITS_PER_LONG == 32

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


