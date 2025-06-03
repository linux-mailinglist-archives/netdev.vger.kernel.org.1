Return-Path: <netdev+bounces-194710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F994ACC0B5
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535D13A503D
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 07:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D21F78E0;
	Tue,  3 Jun 2025 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Mu2BfBf4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F809AD23;
	Tue,  3 Jun 2025 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748934274; cv=none; b=S3Qius/W1IXQ3iALG4jCr8YKeCtu0E4O7aF6ChOXvpavW2DeVYd1Qw/3yIj1eQiL4wlS+bHXJcJPSxNbGnrDJ0a0Jh93FktlHoueh8VFsaJZosKdr5mHNddUQo/eDRkXkLp/jdIOB1jSVZdb2HRh70fmex13NyN0o7/u5NdMOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748934274; c=relaxed/simple;
	bh=cTc8bZDBuXvDUGPUR+iUxBQOO/Wth1RIqhux1B12JFA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fky+ChlIHajqRNyxAxnrXf1vZBEAb2N6a2qoRLQiIYBuvMKoscp0Jouic0bqG45u9tzC09D4llDOpQ0bXOQ4rmLuFMln+NasNt3vtIO0ysjOOEXsXNxEcRYdJVyiogZFIjOFgDXOS8hahMF6HN/sOPJp9pytLjNZYaOlyRJ9BpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Mu2BfBf4; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5535Tf55016555;
	Tue, 3 Jun 2025 00:04:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=9u61GZfHLbM/okiKtAUNpwlGb
	qA06T27oDXbr/axoPI=; b=Mu2BfBf4RLf4dvAitRJHFFh5qwBgBIwho/Ah8Ol5G
	6s/lUVQTzn0gYs4COAnLjnxQ7xRjLs4pXY1TWEsnkjgaF4HOGDFJrpnwQwuKLPAT
	j1nrahrcb+iJqtMNHbOBcTRRmp8gQThwKzXIC3wwIgZfTdqaXqpL3Xwc4nOCf9hd
	PjDZry8halzKevcwpgoF0AJeFWQ2GV2Vfia9j0/jGuLAnZZCeXfea8wC2sVJlLlB
	6RzyPYTRz9KBIGVKlZShwfijOnCDJnC2sgwwTiExP9k5t0JlaX/4qlHMvYAfaxLe
	nrJLtJl68dc8RV1QB+sWUOfUE0DEPrMyU+bMklSonP9Lg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 471txwr5d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 00:04:11 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 00:04:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Jun 2025 00:04:11 -0700
Received: from 04b5e1325d51 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id EB1F23F705A;
	Tue,  3 Jun 2025 00:04:07 -0700 (PDT)
Date: Tue, 3 Jun 2025 07:04:05 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <carlos.fernandez@technica-engineering.de>
CC: <linux-kernel@vger.kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net] macsec: MACsec SCI assignment for ES = 0
Message-ID: <aD6eZSFTBzJuuVX_@04b5e1325d51>
References: <20250529124455.2761783-1-carlos.fernandez@technica-engineering.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250529124455.2761783-1-carlos.fernandez@technica-engineering.de>
X-Authority-Analysis: v=2.4 cv=N44pF39B c=1 sm=1 tr=0 ts=683e9e6b cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=ACc6NGWNc1wSfeR37qgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: X3l8PKdn-Mv38_It55f2_WNGjrlodCs0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA1OSBTYWx0ZWRfX7nN6n6t0BvVY rREZ8iAt2Y8GOw5R+OAMUrKl0T4K0WA2pa0dCNyH0RU42t8Zz3Ig7jLsF8UeLHuUVkx5vQE/ngd N/q0SnRCdXrBRtHHziCj+cxSb+A3BLYOW12VApnpBkSGErvEHl6JISmGKwbcFbWt7xayNvjjXja
 AyuJ0To3PUUr9aZQe5NeNmEkoqAP8zoflGVwRJon9Y/NATq34bWPqtO9S2xBrCw587w2lVbaZxZ oLP2J72dJBYBgazNT4V3z17lvGARZa46DLeEvr7aIsFqJ9Keeq6yVSFOB30Y0+fpJKBc/5YO5mn mbnymYP5f+89svjTYfDR7sc7KvYouMxuj02UmURENI8cz7koN9ewoEY5rv2qnChCKdC2evdxrGC
 f88x/q/ZnY0h/S73OX5++z5Uf/wZ9pNDlP0jgCbZxObMsIAAYYjON2jRAdsKsBgNenCFV5PI
X-Proofpoint-ORIG-GUID: X3l8PKdn-Mv38_It55f2_WNGjrlodCs0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01

Hi,

On 2025-05-29 at 12:44:42, carlos.fernandez@technica-engineering.de (carlos.fernandez@technica-engineering.de) wrote:
> From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
> 
> According to 802.1AE standard, when ES and SC flags in TCI are zero, used
> SCI should be the current active SC_RX but current code uses the header
> MAC address.
> 
> Without this patch, when ES flag is 0 (using a bridge or switch), header
> MAC will not be equal to the SCI and MACSec frames will be discarted.
> 
> Signed-off-by: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
> ---
>  drivers/net/macsec.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 3d315e30ee47..9a743aee2cea 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -247,15 +247,29 @@ static sci_t make_sci(const u8 *addr, __be16 port)
>  	return sci;
>  }
>  
> -static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present)
> +static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present,
> +			      struct macsec_rxh_data *rxd)
>  {
> -	sci_t sci;
> +	struct macsec_dev *macsec_device;
> +	sci_t sci = 0;
>  
> -	if (sci_present)
> +	if (sci_present) {
>  		memcpy(&sci, hdr->secure_channel_id,
>  		       sizeof(hdr->secure_channel_id));
> -	else
> +	} else if (!(hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC))) {
> +		list_for_each_entry_rcu(macsec_device, &rxd->secys, secys) {
> +			struct macsec_secy *secy = &macsec_device->secy;
> +			struct macsec_rx_sc *rx_sc;
> +
> +			for_each_rxsc(secy, rx_sc) {
> +				rx_sc = rx_sc ? macsec_rxsc_get(rx_sc) : NULL;
> +				if (rx_sc && rx_sc->active)
> +					sci = rx_sc->sci;
The intention of this logic is not clear to reader since you want
last sci in list or you forgot to return/break. Digging previous mail
chain you said loop iteration count will only be 1 but we are not
really sure about it. Please change as Sabrina suggested to check whether
RXSC is exactly one for lower device and if not drop the packet.
Write a comment on top of 'else if' so that we dont need to dig
into history of why this logic is like that.
Also this looks like net-next material, if you feel strongly this as
a fix which was missed from beginning then add Fixes tag.

Thanks,
Sundeep


> +			}
> +		}
> +	} else {
>  		sci = make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
> +	}
>  
>  	return sci;
>  }
> @@ -1156,11 +1170,12 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
>  
>  	macsec_skb_cb(skb)->has_sci = !!(hdr->tci_an & MACSEC_TCI_SC);
>  	macsec_skb_cb(skb)->assoc_num = hdr->tci_an & MACSEC_AN_MASK;
> -	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci);
>  
>  	rcu_read_lock();
>  	rxd = macsec_data_rcu(skb->dev);
>  
> +	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci, rxd);
> +
>  	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
>  		struct macsec_rx_sc *sc = find_rx_sc(&macsec->secy, sci);
>  
> -- 
> 2.43.0
> 

