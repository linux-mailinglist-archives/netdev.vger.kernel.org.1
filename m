Return-Path: <netdev+bounces-195638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF44AD18DA
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 09:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C19716A3C5
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 07:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC93280A52;
	Mon,  9 Jun 2025 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="F5Uc8Jf3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18C2F3E;
	Mon,  9 Jun 2025 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452929; cv=none; b=Wwrk/0S7s0zhuompnYBP3pSRq7FI0Fv6Q6DnVU5ghKJoc28xzxw9O0Ra1V1afw20mAZobSuOK2Fa1t97gryPBs818fFCITiWsTLOEyl+sydasml3u9W+iFLS3+ZXFqx0iE0u1ZbVkyLH6IX4+R0MGgkv8cSvkbAV4o5sMpT+fus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452929; c=relaxed/simple;
	bh=JZtxyo1n3N1KrOrn3X14M5FVlS2HxZZ2L3LzJ09g1XM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCN/0irOP68H1CmpjDDwwasFvrJBWZRqfmQqcUg9kuVpisJtdi41RnZpYE6MpvZ4N2KZObhnwno5vbioqba6WsTdEvmLks7YBStAvUgAfK+UypxRrJEerPVnqsVIA/sWK4EI76aC3X9G1tdmM/kBDbRtspF+D8OtBzfGQVKa6Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=F5Uc8Jf3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55941ADf006625;
	Mon, 9 Jun 2025 00:08:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Bwy5AqT1Riai8H1MnSUj+tFx6
	ayyWFItxbVX7bAn5Xg=; b=F5Uc8Jf3xflyNis8REGeGVtq1vzxxrqTuSEXEqOa/
	LJjX4XTeT27HBeV2BytNFcFCNYjf3AN+lYweIFnO9eWlslhNpsoSixg3D8Yfnkqw
	gfkliWdjK734WqZbopmojMJtLQ8raW0wPe+JnpUcOf+sN97V4GvjvO8Wa+FNhSOM
	NTI/IPNltUoneC7ELy4NROdOtA9p9/o1Sw2W0AMoXk2Of/5JAKKNOuIW7Vas0WAc
	4FTeqtehnrrJgwUNl7vTJ5xWxsGMWoZkpiaQbN2IPyMd/8fWi21sLipsxv7PTLL6
	3eHUpDRLIGJClj7gTSR2Mc3+QpC5bnDKBZtetyQmcNgLg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4759pbh77q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 00:08:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Jun 2025 00:08:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Jun 2025 00:08:30 -0700
Received: from 82bae11342dd (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 8F8313F707C;
	Mon,  9 Jun 2025 00:08:26 -0700 (PDT)
Date: Mon, 9 Jun 2025 07:08:24 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
CC: <horms@kernel.org>,
        Andreu Montiel
	<Andreu.Montiel@technica-engineering.de>,
        Sabrina Dubroca
	<sd@queasysnail.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hannes Frederic Sowa
	<hannes@stressinduktion.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4] macsec: MACsec SCI assignment for ES = 0
Message-ID: <aEaIaB1zLEQlc77s@82bae11342dd>
References: <20250609064707.773982-1-carlos.fernandez@technica-engineering.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250609064707.773982-1-carlos.fernandez@technica-engineering.de>
X-Authority-Analysis: v=2.4 cv=f+pIBPyM c=1 sm=1 tr=0 ts=68468870 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=dtjKx1S9dE8yFvv4bDgA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 5HHtWuTEDVUEMRGXdeeI85R5VZcLb026
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA1NCBTYWx0ZWRfXw4/vNziNRcqq S1UV+huwZ9vhl3uEqUT9huJjKur/LP1cgMQXnX5vNL+z9wQmeNBTaOZ4QGsuEejPIzu+cjZCo5S +I4cgfSOd22fmjyRt8Qn+G7vUWraSFoMDmqkYQfdO497i8xinhwBREC6b9CRrVvvpPcIm9ugLAz
 G9InqPvwnvGH49WHWqkdecNKcecTu+9aNwLQamuzY0a/3QXWX4CSsRtbhvak4np4DG4lE2NM1YA MfOTseuqY4T6HObXGwAasJ79Dm7JuYjjwW9cs9dqY52UJxxjbUXhPCHtu40VVMoJh1RiIslfU12 P2cM0nXUUeAgtIwtDBgmkA/Oi6uZfBZSi7Jl5dcmB3mKunsBuzWKi9QvfzXzsLK2O3x1vveCIBm
 AKoQ6lb0m9y1RxTQr+NrQsru2dUG8GBiHEkRhzCAsUUVB7hY2HTnWdEutmxVufHG98Cr47gN
X-Proofpoint-GUID: 5HHtWuTEDVUEMRGXdeeI85R5VZcLb026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_02,2025-06-05_01,2025-03-28_01

On 2025-06-09 at 06:47:02, Carlos Fernandez (carlos.fernandez@technica-engineering.de) wrote:
> According to 802.1AE standard, when ES and SC flags in TCI are zero,
> used SCI should be the current active SC_RX. Current code uses the
> header MAC address. Without this patch, when ES flag is 0 (using a
> bridge or switch), header MAC will not fit the SCI and MACSec frames
> will be discarted.
> 
> In order to test this issue, MACsec link should be stablished between
> two interfaces, setting SC and ES flags to zero and a port identifier
> different than one. For example, using ip macsec tools:
> 
> ip link add link $ETH0 macsec0 type macsec port 11 send_sci off I
Looks like 'I' above is typo.
> end_station off
> ip macsec add macsec0 tx sa 0 pn 2 on key 01 $ETH1_KEY
> ip macsec add macsec0 rx port 11 address $ETH1_MAC
> ip macsec add macsec0 rx port 11 address $ETH1_MAC sa 0 pn 2 on key 02
> ip link set dev macsec0 up
> 
> ip link add link $ETH1 macsec1 type macsec port 11 send_sci off I
Ditto. Please fix these and resubmit.
With that you can add Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep
> end_station off
> ip macsec add macsec1 tx sa 0 pn 2 on key 01 $ETH0_KEY
> ip macsec add macsec1 rx port 11 address $ETH0_MAC
> ip macsec add macsec1 rx port 11 address $ETH0_MAC sa 0 pn 2 on key 02
> ip link set dev macsec1 up
> 
> 
> Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
> Co-developed-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
> Signed-off-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
> Signed-off-by: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
> ---
> v4: 
> * Added testing info in commit as suggested. 
> 
> v3: https://patchwork.kernel.org/project/netdevbpf/patch/20250604123407.2795263-1-carlos.fernandez@technica-engineering.de/
> * Wrong drop frame afer macsec_frame_sci
> * Wrong Fixes tag in message 
> 
> v2: https://patchwork.kernel.org/project/netdevbpf/patch/20250604113213.2595524-1-carlos.fernandez@technica-engineering.de/
> * Active sci lookup logic in a separate helper.
> * Unnecessary loops avoided. 
> * Check RXSC is exactly one for lower device.
> * Drops frame in case of error.
> 
> 
> v1: https://patchwork.kernel.org/project/netdevbpf/patch/20250529124455.2761783-1-carlos.fernandez@technica-engineering.de/
> 
> 
>  drivers/net/macsec.c | 40 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 3d315e30ee47..7edbe76b5455 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -247,15 +247,39 @@ static sci_t make_sci(const u8 *addr, __be16 port)
>  	return sci;
>  }
>  
> -static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present)
> +static sci_t macsec_active_sci(struct macsec_secy *secy)
>  {
> -	sci_t sci;
> +	struct macsec_rx_sc *rx_sc = rcu_dereference_bh(secy->rx_sc);
> +
> +	/* Case single RX SC */
> +	if (rx_sc && !rcu_dereference_bh(rx_sc->next))
> +		return (rx_sc->active) ? rx_sc->sci : 0;
> +	/* Case no RX SC or multiple */
> +	else
> +		return 0;
> +}
> +
> +static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present,
> +			      struct macsec_rxh_data *rxd)
> +{
> +	struct macsec_dev *macsec;
> +	sci_t sci = 0;
>  
> -	if (sci_present)
> +	/* SC = 1 */
> +	if (sci_present) {
>  		memcpy(&sci, hdr->secure_channel_id,
>  		       sizeof(hdr->secure_channel_id));
> -	else
> +	/* SC = 0; ES = 0 */
> +	} else if ((!(hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC))) &&
> +		   (list_is_singular(&rxd->secys))) {
> +		/* Only one SECY should exist on this scenario */
> +		macsec = list_first_or_null_rcu(&rxd->secys, struct macsec_dev,
> +						secys);
> +		if (macsec)
> +			return macsec_active_sci(&macsec->secy);
> +	} else {
>  		sci = make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
> +	}
>  
>  	return sci;
>  }
> @@ -1109,7 +1133,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
>  	struct macsec_rxh_data *rxd;
>  	struct macsec_dev *macsec;
>  	unsigned int len;
> -	sci_t sci;
> +	sci_t sci = 0;
>  	u32 hdr_pn;
>  	bool cbit;
>  	struct pcpu_rx_sc_stats *rxsc_stats;
> @@ -1156,11 +1180,14 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
>  
>  	macsec_skb_cb(skb)->has_sci = !!(hdr->tci_an & MACSEC_TCI_SC);
>  	macsec_skb_cb(skb)->assoc_num = hdr->tci_an & MACSEC_AN_MASK;
> -	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci);
>  
>  	rcu_read_lock();
>  	rxd = macsec_data_rcu(skb->dev);
>  
> +	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci, rxd);
> +	if (!sci)
> +		goto drop_nosc;
> +
>  	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
>  		struct macsec_rx_sc *sc = find_rx_sc(&macsec->secy, sci);
>  
> @@ -1283,6 +1310,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
>  	macsec_rxsa_put(rx_sa);
>  drop_nosa:
>  	macsec_rxsc_put(rx_sc);
> +drop_nosc:
>  	rcu_read_unlock();
>  drop_direct:
>  	kfree_skb(skb);
> -- 
> 2.43.0
> 

