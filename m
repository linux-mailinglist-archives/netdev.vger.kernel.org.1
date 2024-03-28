Return-Path: <netdev+bounces-82729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2361E88F76F
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 06:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2592291161
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 05:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E9B47F69;
	Thu, 28 Mar 2024 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BZsBjyz4"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F040878
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605102; cv=none; b=FT8upRj2VtN9NdKNo/ILGW05Vd44txHneZKn8awYV9LUMOTVX0b8WT47IHT/TyCeOLHxI2Lqzo6pJWM+QUjfUFI7SEZFaYHWvOgDOCVIP9dCuM0Hq8o2SL++19nB2gjd8T48ykaGaODP872bCuBhhPSbTVL36/I6YGrKwFWQkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605102; c=relaxed/simple;
	bh=e+ivK+sEKC6jHcpFhx7jkO+gQuawHV6zSHHitD3sr+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgVq8kBp68QP1ZyLVm7A4czNb/g+4IwVfEhCH6EBAsO9azmJMWJQYNK90fkKnwmxUzwkl1/egfuJrA4y2hu1G/YdRfvMbZJw56sn/3GK48GAIsIcD2X/6gqsKxDcUNO06/dXtf8MR7aVTZGyVhxv34qkOLCFlPyRun2Tv8n8g/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BZsBjyz4; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aca9f551-da56-4c50-b456-cb67f5ca79fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711605097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHnnb0+qZhD5eQZ6r1asbItmM6NKbnOUjHanXATII2o=;
	b=BZsBjyz4Udrd0YhrJRoxCpGiEi/daQHI+7HfxhEHQbFN7nP/7pofvXz9633HEz9qJtNfQW
	Q0TMR7ABJ+q4smOPMyJHu4a5VdaQIDr9hkd14i9Xz4lz9B4D8TXAzUG7EtcWTcAGzLJiWe
	US1Z098Qy8Q38ZhzQD/m9YMoFz7wc5c=
Date: Wed, 27 Mar 2024 22:51:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 01/12] bnxt_en: Add a timeout parameter to
 bnxt_hwrm_port_ts_query()
Content-Language: en-US
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 Richard Cochran <richardcochran@gmail.com>
References: <20240325222902.220712-1-michael.chan@broadcom.com>
 <20240325222902.220712-2-michael.chan@broadcom.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240325222902.220712-2-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/03/2024 22:28, Michael Chan wrote:
> The caller can pass this new timeout parameter to the function to
> specify the firmware timeout value when requesting the TX timestamp
> from the firmware.  This will allow the caller to precisely control
> the timeout and will be used in the next patch.  In this patch, the
> parameter is 0 which means to use the current default value.
> 
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 16 ++++++++++++----
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  1 +
>   2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> index cc07660330f5..dbfd1b36774c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -109,7 +109,8 @@ static void bnxt_ptp_get_current_time(struct bnxt *bp)
>   	spin_unlock_bh(&ptp->ptp_lock);
>   }
>   
> -static int bnxt_hwrm_port_ts_query(struct bnxt *bp, u32 flags, u64 *ts)
> +static int bnxt_hwrm_port_ts_query(struct bnxt *bp, u32 flags, u64 *ts,
> +				   u32 txts_tmo)
>   {
>   	struct hwrm_port_ts_query_output *resp;
>   	struct hwrm_port_ts_query_input *req;
> @@ -122,10 +123,15 @@ static int bnxt_hwrm_port_ts_query(struct bnxt *bp, u32 flags, u64 *ts)
>   	req->flags = cpu_to_le32(flags);
>   	if ((flags & PORT_TS_QUERY_REQ_FLAGS_PATH) ==
>   	    PORT_TS_QUERY_REQ_FLAGS_PATH_TX) {
> +		u32 tmo_us = txts_tmo * 1000;
> +
>   		req->enables = cpu_to_le16(BNXT_PTP_QTS_TX_ENABLES);
>   		req->ptp_seq_id = cpu_to_le32(bp->ptp_cfg->tx_seqid);
>   		req->ptp_hdr_offset = cpu_to_le16(bp->ptp_cfg->tx_hdr_off);
> -		req->ts_req_timeout = cpu_to_le16(BNXT_PTP_QTS_TIMEOUT);
> +		if (!tmo_us)
> +			tmo_us = BNXT_PTP_QTS_TIMEOUT;
> +		tmo_us = min(tmo_us, BNXT_PTP_QTS_MAX_TMO_US);
> +		req->ts_req_timeout = cpu_to_le16(txts_tmo);
>   	}
>   	resp = hwrm_req_hold(bp, req);
>   
> @@ -675,7 +681,8 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
>   	u64 ts = 0, ns = 0;
>   	int rc;
>   
> -	rc = bnxt_hwrm_port_ts_query(bp, PORT_TS_QUERY_REQ_FLAGS_PATH_TX, &ts);
> +	rc = bnxt_hwrm_port_ts_query(bp, PORT_TS_QUERY_REQ_FLAGS_PATH_TX, &ts,
> +				     0);
>   	if (!rc) {
>   		memset(&timestamp, 0, sizeof(timestamp));
>   		spin_lock_bh(&ptp->ptp_lock);
> @@ -891,7 +898,8 @@ int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg)
>   		if (rc)
>   			return rc;
>   	} else {
> -		rc = bnxt_hwrm_port_ts_query(bp, PORT_TS_QUERY_REQ_FLAGS_CURRENT_TIME, &ns);
> +		rc = bnxt_hwrm_port_ts_query(bp, PORT_TS_QUERY_REQ_FLAGS_CURRENT_TIME,
> +					     &ns, 0);
>   		if (rc)
>   			return rc;
>   	}
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> index fce8dc39a7d0..04886d5f22ad 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> @@ -23,6 +23,7 @@
>   #define BNXT_HI_TIMER_MASK	0xffff00000000UL
>   
>   #define BNXT_PTP_QTS_TIMEOUT	1000
> +#define BNXT_PTP_QTS_MAX_TMO_US	65535
>   #define BNXT_PTP_QTS_TX_ENABLES	(PORT_TS_QUERY_REQ_ENABLES_PTP_SEQ_ID |	\
>   				 PORT_TS_QUERY_REQ_ENABLES_TS_REQ_TIMEOUT | \
>   				 PORT_TS_QUERY_REQ_ENABLES_PTP_HDR_OFFSET)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

