Return-Path: <netdev+bounces-195168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55999ACE93C
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 07:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165CB174028
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 05:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288571DB958;
	Thu,  5 Jun 2025 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="G8amYOV4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA71A76D4;
	Thu,  5 Jun 2025 05:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749101050; cv=none; b=KvdLMmqJKTZPj0YCoMxmx+OTZuJXYFlf4M5yWdRdnWdu+vIsJGu0+uK5qYIhQ5PBP4ZOe+M8qCXcJJTL6cy/f2iwuCCOxky0LoQBzMiP/KaPMsHM6Xl5QPRUtBcTbgVDlwCKbIV8eayx8Xdo2obgS49avWeaiSNmS1h95F/IfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749101050; c=relaxed/simple;
	bh=ya/koOj6cO+ct9Hs3+IinxxRmA9fxrsQslP4v/NxUgI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2KbsD08/La613a7p/QToWNv7nJ5EsswEruxszpYkJK6YuA9jdpGeAJe03GibSkK60cPZByiYyutTyJYT2e+MHzUUY1rrD1PPR0wOHgcpVIlnlth0084GqR+DkqAxi3BC8yO6pJDcyGcnYJ06CcPPGe3a9XpyXPSjuLU34yM488=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=G8amYOV4; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554NaLC9000416;
	Wed, 4 Jun 2025 22:23:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=PNM3IaA5jL17ak3UbjRpIWW8f
	0RDYWYEWHICKDUDx/0=; b=G8amYOV4+kkq2zFNNBmFV8AgTegLcIFSWQl0MbtwJ
	YBPKwTrnzAVxy+YLe4sInPhh+fmCYGVIcfmGAqIM24hFdI0YkPNTQ5+7NcbmblNJ
	jmNXD02z5+GiK/MtDE3V6L2nii2E0V96a7u6dGYGKi3jbkNUGQUfNbUgqMIdzDbl
	+ZmTL/IXWrZDGWzkFL4ulN1IASfSdDBgCLbwR39zX5jXvXKgTxCB87bCyX6WLFWn
	+tvYTieK6mWzZUiw+lrN86nwfkCj2/SpPL6gUqo4BLlL4rYKJ6IO/XF81kM8kRJ2
	ka8kPyHRjrN3CiMV7u5Ru/VVdDb0BLAvxuU8Kj3Ax7Ijw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 472yyb8gr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 22:23:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Jun 2025 22:23:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Jun 2025 22:23:38 -0700
Received: from 4c2d361be676 (unknown [10.193.66.94])
	by maili.marvell.com (Postfix) with SMTP id D01C33F7082;
	Wed,  4 Jun 2025 22:23:34 -0700 (PDT)
Date: Thu, 5 Jun 2025 05:23:32 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <carlos.fernandez@technica-engineering.de>
CC: <andreu.montiel@technica-enginnering.de>,
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
Subject: Re: [PATCH net v3] macsec: MACsec SCI assignment for ES = 0
Message-ID: <aEEp1IOlVY9BrXVY@4c2d361be676>
References: <20250604123407.2795263-1-carlos.fernandez@technica-engineering.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250604123407.2795263-1-carlos.fernandez@technica-engineering.de>
X-Proofpoint-GUID: hmR4WaaxTRJmk8aY3fW7-g_nB353chm2
X-Authority-Analysis: v=2.4 cv=F9hXdrhN c=1 sm=1 tr=0 ts=684129dc cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=OUTCSzjuWNMhYzDvx4IA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA0NSBTYWx0ZWRfXyHHawB9g+zds A54qWeMABPuZOs64Agcj2i6DBDHwFegP2KjNXaNRn8qy0hgeaNQ37Wz7fPleCIeatgX9L7IygWG akXOcDIPcj0aulOQ3mGoP/8y8GlqxCNI84obVXQIzr2vFIJisT1jERTRXYYCHxsz67WESaDchlV
 6SMSjDXJiG4a4QHazXf3ol7Lf9ZEUmSIChMC5uYJTnJDIGN69JMmmdL5R4i2yXitVLxHBeRF4B6 TP8YHMuToqbGFobYr2VK8gYoBIgbFJ11LE8mprtQggzUjJGIQKueWUnGt5PN66vcx/DynJlNsaq ZhEMfimB1FIrJ85nQ/8Octrb5zsDuC2XRjPQZlsouMRmfiyXJzWaF8tHg0QSE7Imo56Kizf4moH
 99KnFkBh0j9EZ+ELylK7vemjtld9ql8j2GHAb0w4fyzdIuJg3aWX6tbB7/yj5zRQiFmxLbJd
X-Proofpoint-ORIG-GUID: hmR4WaaxTRJmk8aY3fW7-g_nB353chm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_01,2025-06-03_02,2025-03-28_01

On 2025-06-04 at 12:33:55, carlos.fernandez@technica-engineering.de (carlos.fernandez@technica-engineering.de) wrote:
> From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
> 
> According to 802.1AE standard, when ES and SC flags in TCI are zero,
> used SCI should be the current active SC_RX. Current code uses the
> header MAC address. Without this patch, when ES flag is 0 (using a
> bridge or switch), header MAC will not fit the SCI and MACSec frames
> will be discarted.
> 
> Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
> Co-developed-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
> Signed-off-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
> Signed-off-by: Carlos Fernandez <carlos.fernandez@technica-engineering.de>

 Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Also please let me know how to test this single secy and single
RXSC for my understanding.

Thanks,
Sundeep

> ---
> v3:
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

