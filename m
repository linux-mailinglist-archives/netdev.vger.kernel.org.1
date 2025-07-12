Return-Path: <netdev+bounces-206325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C26B02A81
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 12:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235524A31D9
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 10:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27D9274FE9;
	Sat, 12 Jul 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=novek.ru header.i=@novek.ru header.b="SB37CIQR"
X-Original-To: netdev@vger.kernel.org
Received: from novek.ru (unknown [31.204.180.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80F1F4188;
	Sat, 12 Jul 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.204.180.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752317677; cv=none; b=IKveOHfemtubxa0Zq3kkz2xeckvnyIkvR80D2kGXqRCJIsns6jO1mOb6b4URRRnI4YJ665c7OKEdUOCLyYMKAOWEHNi4y6hn9nCWAyQ24JNNrNdtRZNIoNx6JjcHoNZ74tC/GTfSo39xzMo068/qxPfmdkh9uMfdWAn74OY0y5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752317677; c=relaxed/simple;
	bh=wA6JjN1+MB1zRiN8KR6bgIeJHc2E1A4NjfjVIrp4+tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVlKTFl68KtJofGE7x2/eWamXfIRHiBmyjpnDH+NbF/HeKaIDIzR8EHjPIVowXTXledX1bxf9WW294AToe2ZcFhavsDnMk6dogX78XW+jU5g0mRzz2kl72mB7Gdt6MEsm0mNkpKRsHn/Q5oBWx0qZz+lSrMr8M47yC2YVSTHCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=novek.ru; spf=pass smtp.mailfrom=novek.ru; dkim=permerror (0-bit key) header.d=novek.ru header.i=@novek.ru header.b=SB37CIQR; arc=none smtp.client-ip=31.204.180.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=novek.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novek.ru
Received: from [10.57.205.117] (unknown [161.12.70.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by novek.ru (Postfix) with ESMTPSA id 06498508CDF;
	Sat, 12 Jul 2025 14:04:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 novek.ru 06498508CDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novek.ru; s=mail;
	t=1752318269; bh=wA6JjN1+MB1zRiN8KR6bgIeJHc2E1A4NjfjVIrp4+tQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SB37CIQR/YQ3JfqIelDwFVDaQSD2GpUkB/DEhnpTHHx+Kidw3YaXj4AyzHdPQwHUh
	 uGqNsWp3qxJ21nbSJhx0c77ogoBtMfFAzZl9a0hv68vIhrppjxI6/Er9DYL+LltzRw
	 1Rm4NXuQEhcv0njvdliyatND06H1WDFFN7Y7Ec8I=
Message-ID: <40a32a8b-11d4-48fb-b626-66239a4797a5@novek.ru>
Date: Sat, 12 Jul 2025 11:54:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] net: enetc: save the parsed information of
 PTP packet to skb->cb
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: fushi.peng@nxp.com, devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-9-wei.fang@nxp.com>
From: Vadim Fedorenko <vfedorenko@novek.ru>
In-Reply-To: <20250711065748.250159-9-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: **

On 11.07.2025 07:57, Wei Fang wrote:
> Currently, the Tx PTP packets are parsed twice in the enetc driver, once
> in enetc_xmit() and once in enetc_map_tx_buffs(). The latter is duplicate
> and is unnecessary, since the parsed information can be saved to skb->cb
> so that enetc_map_tx_buffs() can get the previously parsed data from
> skb->cb. Therefore, we add struct enetc_skb_cb as the format of the data
> in the skb->cb buffer to save the parsed information of PTP packet.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>   drivers/net/ethernet/freescale/enetc/enetc.c | 65 ++++++++++----------
>   drivers/net/ethernet/freescale/enetc/enetc.h |  9 +++
>   2 files changed, 43 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index e4287725832e..c1373163a096 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -225,13 +225,12 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>   {
>   	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
>   	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
> +	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
>   	struct enetc_hw *hw = &priv->si->hw;
>   	struct enetc_tx_swbd *tx_swbd;
>   	int len = skb_headlen(skb);
>   	union enetc_tx_bd temp_bd;
> -	u8 msgtype, twostep, udp;
>   	union enetc_tx_bd *txbd;
> -	u16 offset1, offset2;
>   	int i, count = 0;
>   	skb_frag_t *frag;
>   	unsigned int f;
> @@ -280,16 +279,10 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>   	count++;
>   
>   	do_vlan = skb_vlan_tag_present(skb);
> -	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> -		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep, &offset1,
> -				    &offset2) ||
> -		    msgtype != PTP_MSGTYPE_SYNC || twostep)
> -			WARN_ONCE(1, "Bad packet for one-step timestamping\n");
> -		else
> -			do_onestep_tstamp = true;
> -	} else if (skb->cb[0] & ENETC_F_TX_TSTAMP) {
> +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> +		do_onestep_tstamp = true;
> +	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
>   		do_twostep_tstamp = true;
> -	}
>   
>   	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
>   	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
> @@ -333,6 +326,8 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>   		}
>   
>   		if (do_onestep_tstamp) {
> +			u16 tstamp_off = enetc_cb->origin_tstamp_off;
> +			u16 corr_off = enetc_cb->correction_off;
>   			__be32 new_sec_l, new_nsec;
>   			u32 lo, hi, nsec, val;
>   			__be16 new_sec_h;
> @@ -362,32 +357,32 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>   			new_sec_h = htons((sec >> 32) & 0xffff);
>   			new_sec_l = htonl(sec & 0xffffffff);
>   			new_nsec = htonl(nsec);
> -			if (udp) {
> +			if (enetc_cb->udp) {
>   				struct udphdr *uh = udp_hdr(skb);
>   				__be32 old_sec_l, old_nsec;
>   				__be16 old_sec_h;
>   
> -				old_sec_h = *(__be16 *)(data + offset2);
> +				old_sec_h = *(__be16 *)(data + tstamp_off);
>   				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
>   							 new_sec_h, false);
>   
> -				old_sec_l = *(__be32 *)(data + offset2 + 2);
> +				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
>   				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
>   							 new_sec_l, false);
>   
> -				old_nsec = *(__be32 *)(data + offset2 + 6);
> +				old_nsec = *(__be32 *)(data + tstamp_off + 6);
>   				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
>   							 new_nsec, false);
>   			}
>   
> -			*(__be16 *)(data + offset2) = new_sec_h;
> -			*(__be32 *)(data + offset2 + 2) = new_sec_l;
> -			*(__be32 *)(data + offset2 + 6) = new_nsec;
> +			*(__be16 *)(data + tstamp_off) = new_sec_h;
> ++			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
> ++			*(__be32 *)(data + tstamp_off + 6) = new_nsec;

This looks like merge conflict artifact...

>   
>   			/* Configure single-step register */
>   			val = ENETC_PM0_SINGLE_STEP_EN;
> -			val |= ENETC_SET_SINGLE_STEP_OFFSET(offset1);
> -			if (udp)
> +			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> +			if (enetc_cb->udp)
>   				val |= ENETC_PM0_SINGLE_STEP_CH;
>   
>   			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
> @@ -938,12 +933,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>   static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>   				    struct net_device *ndev)
>   {
> +	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
>   	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>   	struct enetc_bdr *tx_ring;
>   	int count;
>   
>   	/* Queue one-step Sync packet if already locked */
> -	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
>   		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
>   					  &priv->flags)) {
>   			skb_queue_tail(&priv->tx_skbs, skb);
> @@ -1005,24 +1001,29 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>   
>   netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
>   {
> +	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
>   	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>   	u8 udp, msgtype, twostep;
>   	u16 offset1, offset2;
>   
> -	/* Mark tx timestamp type on skb->cb[0] if requires */
> +	/* Mark tx timestamp type on enetc_cb->flag if requires */
>   	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
> -	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK)) {
> -		skb->cb[0] = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
> -	} else {
> -		skb->cb[0] = 0;
> -	}
> +	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
> +		enetc_cb->flag = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
> +	else
> +		enetc_cb->flag = 0;
>   
>   	/* Fall back to two-step timestamp if not one-step Sync packet */
> -	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
>   		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
>   				    &offset1, &offset2) ||
> -		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0)
> -			skb->cb[0] = ENETC_F_TX_TSTAMP;
> +		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0) {
> +			enetc_cb->flag = ENETC_F_TX_TSTAMP;
> +		} else {
> +			enetc_cb->udp = !!udp;
> +			enetc_cb->correction_off = offset1;
> +			enetc_cb->origin_tstamp_off = offset2;
> +		}
>   	}
>   
>   	return enetc_start_xmit(skb, ndev);
> @@ -1214,7 +1215,9 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
>   		if (xdp_frame) {
>   			xdp_return_frame(xdp_frame);
>   		} else if (skb) {
> -			if (unlikely(skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
> +			struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
> +
> +			if (unlikely(enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
>   				/* Start work to release lock for next one-step
>   				 * timestamping packet. And send one skb in
>   				 * tx_skbs queue if has.
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 62e8ee4d2f04..ce3fed95091b 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -54,6 +54,15 @@ struct enetc_tx_swbd {
>   	u8 qbv_en:1;
>   };
>   
> +struct enetc_skb_cb {
> +	u8 flag;
> +	bool udp;
> +	u16 correction_off;
> +	u16 origin_tstamp_off;
> +};
> +
> +#define ENETC_SKB_CB(skb) ((struct enetc_skb_cb *)((skb)->cb))
> +
>   struct enetc_lso_t {
>   	bool	ipv6;
>   	bool	tcp;


