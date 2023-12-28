Return-Path: <netdev+bounces-60520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF78E81FB6C
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 22:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FFE285ED0
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 21:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7253210947;
	Thu, 28 Dec 2023 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo1er2nJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E51095F
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b86f3cdca0so5361762b6e.3
        for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 13:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703800686; x=1704405486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2g97ybtcH7+9iFAGgdOUxg1Yv+613C1GWdb1CfxJqDw=;
        b=Zo1er2nJ/F7S0XFQPbIlWLKC+OTRrLaTPpp4hvcW80xNAwBRxm+VhAwXv/hB0sgZTL
         mB0OGp4gAIrDwZxWT5y3elOMRRaAlbYhPRNLtTp7dB2R9RzueZrV0QleslPBLCNA84fb
         hfplmIwp50KIjrsk6r67fKlPKp83/k8BSySDD1olAykPsuYOx9eXwPTVnHaUmlTupFk0
         lQeWUNFxtiKi9VTbhGAe5AOYGVxRUtNiyn5uuv7v3lK0T+uDrPoHj8X9vLtqb5Bfel2s
         1qi9yjusE8XiQt9zdY096c0OEuLpB0t32dhe1FLINhBplfI8M/pZ2HfU6AFS3pQpll+o
         rwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703800686; x=1704405486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2g97ybtcH7+9iFAGgdOUxg1Yv+613C1GWdb1CfxJqDw=;
        b=kqP+shN0Cy//zFvvmmrmk7DzA0IJOxNG1+gCeY++/M/yooaIrxkJ4eSpvSU4F3jlOM
         kHChu1QB+INWnl6RSJIA9laSuMSX2Js3po+px2sdZ96saPCJt6cH5VRrlMYmHU5fSaCq
         AVVBshtAp7BaHPfGgpxKhjNGnSuNUavIKA2GhaaM4+hPcCLmp7kQhVrwrhfzqhMCs4/U
         wz47CsFENYR49IdJddzpTGF5Ic0ZodCHnC3468V2t+mXRtf7+xIlGSjJ7KiA8u1RggRM
         4FBkGEVbAByKeW70LyDb1W47zPGEdk3Ub7F19v9QjtHh/HPWithKXNdtB6tbkPbDEI4D
         kUWg==
X-Gm-Message-State: AOJu0YzR+klUTa30OPwAL1T/9+B7Pd6ETEt5cXYUlqPnKmh7ClnqQyjq
	42dn65P1XS0asSRVy8m9GaE=
X-Google-Smtp-Source: AGHT+IH/joijPd1Ska1sRfDmzSI90vuIJJ5yk/3QbEk8FuzMNzYow0Rv4yeue8ClKsgrS1sfwOnUAg==
X-Received: by 2002:a05:6808:1595:b0:3ba:cc:6c51 with SMTP id t21-20020a056808159500b003ba00cc6c51mr12921726oiw.52.1703800686013;
        Thu, 28 Dec 2023 13:58:06 -0800 (PST)
Received: from [192.168.12.218] ([172.56.184.122])
        by smtp.gmail.com with ESMTPSA id d16-20020a05621416d000b0067f28a2f522sm6480853qvz.140.2023.12.28.13.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 13:58:05 -0800 (PST)
Message-ID: <13587133-2a94-4ba2-9ea0-6fc8f7aa3f51@gmail.com>
Date: Thu, 28 Dec 2023 13:58:02 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: bcmgenet: Fix FCS generation for fragmented
 skbuffs
To: Adrian Cinal <adriancinal1@gmail.com>, netdev@vger.kernel.org
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 Adrian Cinal <adriancinal@gmail.com>
References: <CAPxJ3Bdo9jO_UuA2V1p7sTTdcObGC8VtufDu_ce3ecSF47JpHw@mail.gmail.com>
 <20231228135638.1339245-1-adriancinal1@gmail.com>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <20231228135638.1339245-1-adriancinal1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/28/2023 5:56 AM, Adrian Cinal wrote:
> From: Adrian Cinal <adriancinal@gmail.com>
> 
> The flag DMA_TX_APPEND_CRC was only written to the first DMA descriptor
> in the TX path, where each descriptor corresponds to a single skbuff
> fragment (or the skbuff head). This led to packets with no FCS appearing
> on the wire if the kernel allocated the packet in fragments, which would
> always happen when using PACKET_MMAP/TPACKET (cf. tpacket_fill_skb() in
> net/af_packet.c).
> 
> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
> Signed-off-by: Adrian Cinal <adriancinal1@gmail.com>
> ---
> Differs from v2 in that now the flag DMA_TX_APPEND_CRC is set for all
> fragments (so as to be in line with the specification requiring the flag
> be set alongside DMA_SOP).
> 
>   drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 1174684a7f23..d86e5da6e157 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -2140,8 +2140,10 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
>   		/* Note: if we ever change from DMA_TX_APPEND_CRC below we
>   		 * will need to restore software padding of "runt" packets
>   		 */
> +		len_stat |= DMA_TX_APPEND_CRC;
> +
>   		if (!i) {
> -			len_stat |= DMA_TX_APPEND_CRC | DMA_SOP;
> +			len_stat |= DMA_SOP;
>   			if (skb->ip_summed == CHECKSUM_PARTIAL)
>   				len_stat |= DMA_TX_DO_CSUM;
>   		}

Acked-by: Doug Berger <opendmb@gmail.com>

Thanks for your help!
     Doug

