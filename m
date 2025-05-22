Return-Path: <netdev+bounces-192642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237DEAC0A16
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A589A217EB
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E95286D65;
	Thu, 22 May 2025 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oO3C+Moh"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40F1A3A94
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747910891; cv=none; b=ghPX9Uf3fhVQXzIevIw5wBb8YYsM7qbet4g4/wPMWU9MQgnhEX7Wdc2kZ9zUvdrKo0mMQEsgu1G6MqCN7UzLsZl8/sEi7DEuSZdvKAGlP+mVv9sCw6rUxpe4fB47rv3n9KVxurd/dfHTrXrHwRbXsqhYY3wscCb3mSLTvjdu3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747910891; c=relaxed/simple;
	bh=anDXNe31KV2yrx2zqPc4nLb0ASeqvgkQOlbV+1ioiEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7uYbbwouktF7KxjdGhV6WK0LkQPEBh0oK6KiSc/Tqbk7FtgR8jw80uBwoPwxLOMaNoa61GW2c8XRUUoLNUTzXajy3sI+I3co0ajmAoQ9JqwcLTYiMyvLhTO4uYOCOWn++VaHBHWS5tKF/eg0rRyF0mJz0q2h8cCNph6ebMuW80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oO3C+Moh; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c770157f-4175-45b3-836e-ecf59f9ab8e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747910884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRaVoAsmpjZU46Lb6rdginXbd43xV+PDnPKwnu4HVHU=;
	b=oO3C+Moh4MMuBlkdjJwf6QNfDM5LRw3BBunUTyVVHPpgLfm/glBRuJUo1Ps4evyDvWgqnS
	vWjADRfPYctPjDG2doBqUT9kkfHMnIDEYrtWrSmWfT5mCJJwI4fnEnmwOwugmyk89Iov0x
	wfj9+g0h7nyOd1hkbndRqz40QcoX4Fs=
Date: Thu, 22 May 2025 11:47:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: lan966x: Fix 1-step timestamping over ipv4 or
 ipv6
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250521124159.2713525-1-horatiu.vultur@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250521124159.2713525-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21/05/2025 13:41, Horatiu Vultur wrote:
> When enabling 1-step timestamping for ptp frames that are over udpv4 or
> udpv6 then the inserted timestamp is added at the wrong offset in the
> frame, meaning that will modify the frame at the wrong place, so the
> frame will be malformed.
> To fix this, the HW needs to know which kind of frame it is to know
> where to insert the timestamp. For that there is a field in the IFH that
> says the PDU_TYPE, which can be NONE  which is the default value,
> IPV4 or IPV6. Therefore make sure to set the PDU_TYPE so the HW knows
> where to insert the timestamp.
> Like I mention before the issue is not seen with L2 frames because by
> default the PDU_TYPE has a value of 0, which represents the L2 frames.
> 
> Fixes: 77eecf25bd9d2f ("net: lan966x: Update extraction/injection for timestamping")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>   .../ethernet/microchip/lan966x/lan966x_main.c |  6 +++
>   .../ethernet/microchip/lan966x/lan966x_main.h |  5 ++
>   .../ethernet/microchip/lan966x/lan966x_ptp.c  | 49 ++++++++++++++-----
>   3 files changed, 47 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 0af143ec0f869..427bdc0e4908c 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -353,6 +353,11 @@ static void lan966x_ifh_set_rew_op(void *ifh, u64 rew_op)
>   	lan966x_ifh_set(ifh, rew_op, IFH_POS_REW_CMD, IFH_WID_REW_CMD);
>   }
>   
> +static void lan966x_ifh_set_oam_type(void *ifh, u64 oam_type)
> +{
> +	lan966x_ifh_set(ifh, oam_type, IFH_POS_PDU_TYPE, IFH_WID_PDU_TYPE);
> +}
> +
>   static void lan966x_ifh_set_timestamp(void *ifh, u64 timestamp)
>   {
>   	lan966x_ifh_set(ifh, timestamp, IFH_POS_TIMESTAMP, IFH_WID_TIMESTAMP);
> @@ -380,6 +385,7 @@ static netdev_tx_t lan966x_port_xmit(struct sk_buff *skb,
>   			return err;
>   
>   		lan966x_ifh_set_rew_op(ifh, LAN966X_SKB_CB(skb)->rew_op);
> +		lan966x_ifh_set_oam_type(ifh, LAN966X_SKB_CB(skb)->pdu_type);
>   		lan966x_ifh_set_timestamp(ifh, LAN966X_SKB_CB(skb)->ts_id);
>   	}
>   
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> index 1efa584e71077..1f9df67f05044 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> @@ -75,6 +75,10 @@
>   #define IFH_REW_OP_ONE_STEP_PTP		0x3
>   #define IFH_REW_OP_TWO_STEP_PTP		0x4
>   
> +#define IFH_PDU_TYPE_NONE		0
> +#define IFH_PDU_TYPE_IPV4		7
> +#define IFH_PDU_TYPE_IPV6		8
> +
>   #define FDMA_RX_DCB_MAX_DBS		1
>   #define FDMA_TX_DCB_MAX_DBS		1
>   
> @@ -254,6 +258,7 @@ struct lan966x_phc {
>   
>   struct lan966x_skb_cb {
>   	u8 rew_op;
> +	u8 pdu_type;
>   	u16 ts_id;
>   	unsigned long jiffies;
>   };
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> index 63905bb5a63a8..87e5e81d40dc6 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> @@ -322,34 +322,55 @@ void lan966x_ptp_hwtstamp_get(struct lan966x_port *port,
>   	*cfg = phc->hwtstamp_config;
>   }
>   
> -static int lan966x_ptp_classify(struct lan966x_port *port, struct sk_buff *skb)
> +static void lan966x_ptp_classify(struct lan966x_port *port, struct sk_buff *skb,
> +				 u8 *rew_op, u8 *pdu_type)
>   {
>   	struct ptp_header *header;
>   	u8 msgtype;
>   	int type;
>   
> -	if (port->ptp_tx_cmd == IFH_REW_OP_NOOP)
> -		return IFH_REW_OP_NOOP;
> +	if (port->ptp_tx_cmd == IFH_REW_OP_NOOP) {
> +		*rew_op = IFH_REW_OP_NOOP;
> +		*pdu_type = IFH_PDU_TYPE_NONE;
> +		return;
> +	}
>   
>   	type = ptp_classify_raw(skb);
> -	if (type == PTP_CLASS_NONE)
> -		return IFH_REW_OP_NOOP;
> +	if (type == PTP_CLASS_NONE) {
> +		*rew_op = IFH_REW_OP_NOOP;
> +		*pdu_type = IFH_PDU_TYPE_NONE;
> +		return;
> +	}
>   
>   	header = ptp_parse_header(skb, type);
> -	if (!header)
> -		return IFH_REW_OP_NOOP;
> +	if (!header) {
> +		*rew_op = IFH_REW_OP_NOOP;
> +		*pdu_type = IFH_PDU_TYPE_NONE;
> +		return;
> +	}
>   
> -	if (port->ptp_tx_cmd == IFH_REW_OP_TWO_STEP_PTP)
> -		return IFH_REW_OP_TWO_STEP_PTP;
> +	if (type & PTP_CLASS_L2)
> +		*pdu_type = IFH_PDU_TYPE_NONE;
> +	if (type & PTP_CLASS_IPV4)
> +		*pdu_type = IFH_PDU_TYPE_IPV4;
> +	if (type & PTP_CLASS_IPV6)
> +		*pdu_type = IFH_PDU_TYPE_IPV6;

ptp_classify_raw() will also return PTP_CLASS_IPV4 or PTP_CLASS_IPV6
flags set for (PTP_CLASS_VLAN|PTP_CLASS_IPV4) and
(PTP_CLASS_VLAN|PTP_CLASS_IPV6) cases. Will the hardware support proper
timestamp placing in these cases?

> +
> +	if (port->ptp_tx_cmd == IFH_REW_OP_TWO_STEP_PTP) {
> +		*rew_op = IFH_REW_OP_TWO_STEP_PTP;
> +		return;
> +	}
>   
>   	/* If it is sync and run 1 step then set the correct operation,
>   	 * otherwise run as 2 step
>   	 */
>   	msgtype = ptp_get_msgtype(header, type);
> -	if ((msgtype & 0xf) == 0)
> -		return IFH_REW_OP_ONE_STEP_PTP;
> +	if ((msgtype & 0xf) == 0) {
> +		*rew_op = IFH_REW_OP_ONE_STEP_PTP;
> +		return;
> +	}
>   
> -	return IFH_REW_OP_TWO_STEP_PTP;
> +	*rew_op = IFH_REW_OP_TWO_STEP_PTP;
>   }
>   
>   static void lan966x_ptp_txtstamp_old_release(struct lan966x_port *port)
> @@ -374,10 +395,12 @@ int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
>   {
>   	struct lan966x *lan966x = port->lan966x;
>   	unsigned long flags;
> +	u8 pdu_type;
>   	u8 rew_op;
>   
> -	rew_op = lan966x_ptp_classify(port, skb);
> +	lan966x_ptp_classify(port, skb, &rew_op, &pdu_type);
>   	LAN966X_SKB_CB(skb)->rew_op = rew_op;
> +	LAN966X_SKB_CB(skb)->pdu_type = pdu_type;
>   
>   	if (rew_op != IFH_REW_OP_TWO_STEP_PTP)
>   		return 0;


