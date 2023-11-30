Return-Path: <netdev+bounces-52640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6147FF8F6
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 19:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DC228163D
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2390584DF;
	Thu, 30 Nov 2023 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx52rl6G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0394106
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 10:01:00 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-423e7836b75so7375311cf.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 10:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701367260; x=1701972060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQdbWPUKMiHHKMDJD/eBsNrN+f5BqopxTQeXTvLxViI=;
        b=Tx52rl6Gmkz/qIois0zQcfCGdakTrBqLI2vt6HcxxAjFoL39GzG5SO8K40wUr79G44
         6loWFcLj2ADjDt/0AlPJsT4WyPom6oZUSAH9jGmFelHDI1BQU2CQC3F72E1eF2KQXbeW
         FKghFzEaqA5XJZ8dkIQmdeP5GC9nrY9oT7KOFz5csmFrlIOIEzy2Js9YDOb24UcSSIXF
         A8nsycGEN/1E97OoCJTErRHajybMqpGt23o25L3DdVrB8SETzicRo+pPedyeZt4h+r11
         Zl6JPV/ZpmbM75Wq54EW+WPJmeWHRFwx9SOQ/Yv9CEdbnSRfqmBGFtl7bFcqO/d2NpW2
         skfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701367260; x=1701972060;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MQdbWPUKMiHHKMDJD/eBsNrN+f5BqopxTQeXTvLxViI=;
        b=lZHRbKF2dzVUhNA9aFMpaP+6JzmGuC6NtpM73QUcpyIx21/2bW/bgNVDiYYMQDumA/
         dTgZmrUSCYKuNktSvVT4i2zZHOLA/smYfbQIrXIuj06jhgXC3HnxJKfj6jqtIoOVYRee
         jRIuAtllc+nhaFl6LA70eM1JA3wG/XVgYLxwkLInb3AqX0dhDJTTeTjI7Rk3vwD1Q1Hl
         HbNYlfUgPPZTE9Up/ItxUdhIn4ZGJfGMTdAzK2On+mc/MRYBN0dCQJCdrEhxxssVBNkP
         fX+VO7DnwRqacTBZLlNpi661qQIOPdkDL7dRYzE80MSlGz7iCBDKK5aRyNi7TwLA9FV/
         I/KQ==
X-Gm-Message-State: AOJu0YzXQCqum317q13M97wA2y0JLbE9+ekFOvIsuDe6pD2koMo06hTY
	tMolbMqIHHfSMEk275tqj0Q=
X-Google-Smtp-Source: AGHT+IGnADNUrxTf88cJF7o6URDjKzHRYNRHkS+megjtvmgl/IkqF7xQ8P6z+YEXMG4nI8s2fNGCHw==
X-Received: by 2002:a05:622a:514:b0:421:9f8c:e42 with SMTP id l20-20020a05622a051400b004219f8c0e42mr25265127qtx.63.1701367259899;
        Thu, 30 Nov 2023 10:00:59 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id j25-20020ac874d9000000b00423f2acc614sm689778qtr.87.2023.11.30.10.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 10:00:59 -0800 (PST)
Date: Thu, 30 Nov 2023 13:00:59 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: fw@strlen.de, 
 luwei32@huawei.com, 
 shaozhengchao@huawei.com, 
 weiyongjun1@huawei.com, 
 yuehaibing@huawei.com, 
 maheshb@google.com
Message-ID: <6568cddb64f2c_f7062294da@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231130030225.3571231-1-shaozhengchao@huawei.com>
References: <20231130030225.3571231-1-shaozhengchao@huawei.com>
Subject: Re: [PATCH net-next] ipvlan: implemente .parse_protocol hook function
 in ipvlan_header_ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Zhengchao Shao wrote:
> The .parse_protocol hook function in the ipvlan_header_ops structure is
> not implemented. As a result, when the AF_PACKET family is used to send
> packets, skb->protocol will be set to 0.
> The IPVLAN device must be of the Ethernet type. Therefore, use
> eth_header_parse_protocol function to obtain the protocol.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Small typo in the subject line: implemente.

Ipvlan is a device of type ARPHRD_ETHER (ether_setup).

Tangential to this patch:

I checked that ipvlan_start_xmit indeed only expects packets with
skb->data at Ethernet header. ipvlan_queue_xmit checks

        if (unlikely(!pskb_may_pull(skb, sizeof(struct ethhdr))))
                goto out;

It may later call ipvlan_xmit_mode_l3 and ipvlan_get_L3_hdr, which
has such cases:

        case htons(ETH_P_IP): {
                u32 pktlen;
                struct iphdr *ip4h;
            
                if (unlikely(!pskb_may_pull(skb, sizeof(*ip4h))))
                        return NULL;

That pskb_may_pull should include the ethernet header. It gets
pulled for L3 mode in ipvlan_process_outbound, *after* the above.

> ---
>  drivers/net/ipvlan/ipvlan_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
> index 57c79f5f2991..f28fd7b6b708 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -387,6 +387,7 @@ static const struct header_ops ipvlan_header_ops = {
>  	.parse		= eth_header_parse,
>  	.cache		= eth_header_cache,
>  	.cache_update	= eth_header_cache_update,
> +	.parse_protocol	= eth_header_parse_protocol,
>  };
>  
>  static void ipvlan_adjust_mtu(struct ipvl_dev *ipvlan, struct net_device *dev)
> -- 
> 2.34.1
> 



