Return-Path: <netdev+bounces-12873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B0E7393CE
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 02:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61321C21007
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDAD65D;
	Thu, 22 Jun 2023 00:34:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620C63E
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF99C433C8;
	Thu, 22 Jun 2023 00:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687394070;
	bh=AiZo/yWVr6AaszhH++L2NsU42IKDuEpbVQ7bGj7ECf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vAorBcPFmLvJTgk2RkidGZUjcsqiRPLMtFSoPBlyahiZDWeOO6gojp2QwLG8RMcW1
	 fSdHDXu+oCcr3PMFKXtBDl2gDTDJVZXjJeKxUEqYuXipK1Pc7xlEXWyX5B3OOKSljV
	 t2iZEiz1qV0qI8FWEeIFvnC6GJpHu4jeqa44M7URp72oXtP92tP3x1K1XU2vERtEpb
	 INrVQx7HTI7Kme9INelS5Bvbb79anLy3CoZUNiqhBIOMbLzH4FBUTPw3dxHZbSfTnl
	 J6aC7wab7Z3jhSUBFGG6FtyEntEX+kBgn/eYcHHYUmd6IZZ6vCje5bheOVJOFZtoyM
	 yb9Td4DcPhCtQ==
Date: Wed, 21 Jun 2023 17:34:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: carlos.fernandez@technica-engineering.de
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sabrina Dubroca
 <sd@queasysnail.net>
Subject: Re: [PATCH v3] net: macsec SCI assignment for ES = 0
Message-ID: <20230621173429.18348fc8@kernel.org>
In-Reply-To: <20230620091301.21981-1-carlos.fernandez@technica-engineering.de>
References: <20230620091301.21981-1-carlos.fernandez@technica-engineering.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

A few nit picks and questions, when you repost please make sure to CC 
Sabrina Dubroca <sd@queasysnail.net>

On Tue, 20 Jun 2023 11:13:01 +0200
carlos.fernandez@technica-engineering.de wrote:
> -static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present)
> +static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present,
> +			      struct macsec_rxh_data *rxd)
>  {
> +	struct macsec_dev *macsec_device;
>  	sci_t sci;
>  
> -	if (sci_present)
> +	if (sci_present) {
>  		memcpy(&sci, hdr->secure_channel_id,
> -		       sizeof(hdr->secure_channel_id));
> -	else
> +			sizeof(hdr->secure_channel_id));

the alignment of sizeof() was correct, don't change it

> +	} else if (0 == (hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC))) {

Just
	} else if (hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC)) {

> +		list_for_each_entry_rcu(macsec_device, &rxd->secys, secys) {
> +			struct macsec_rx_sc *rx_sc;
> +			struct macsec_secy *secy = &macsec_device->secy;

You should reorder these two declaration, networking likes local
variable declaration lines longest to shortest.

> +			for_each_rxsc(secy, rx_sc) {
> +				rx_sc = rx_sc ? macsec_rxsc_get(rx_sc) : NULL;
> +				if (rx_sc && rx_sc->active)
> +					return rx_sc->sci;
> +			}

I haven't looked in detail but are you possibly returning rx_sc->sci
here just to ...

> +		}
> +		/* If not found, use MAC in hdr as default*/
>  		sci = make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
> -
> +	} else {
> +		sci = make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
> +	}
>  	return sci;
>  }
>  
> @@ -1150,11 +1165,12 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
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

... look up the rx_sc based on the sci? 
-- 
pw-bot: cr

