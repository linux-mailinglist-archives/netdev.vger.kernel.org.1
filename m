Return-Path: <netdev+bounces-54386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9973C806DBE
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5358F281BB7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B9831728;
	Wed,  6 Dec 2023 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYkklvLL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545BCC3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701861530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJncplPRljOk1kpx+WzGu84RdAxKtfrBb2w62k3mS4o=;
	b=aYkklvLLJlFZ2i8RDJM2k3bfgx9jjxKqMkClEh6Lsj6fd/Q1OAzxjttNFdrxBZ/aKsc0oZ
	CPIteijzp0RFNBXVakpfwEJHgNyUTHWVGronzeWkQX+eyoK8JLP34jZV47x+I5w6q3bU6A
	a66WcMRAaDYwfIhiyWvco41bNXmy8Gc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-HAyF6kp8MqGpkW90cgiVfw-1; Wed, 06 Dec 2023 06:18:48 -0500
X-MC-Unique: HAyF6kp8MqGpkW90cgiVfw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1d27c45705so19745766b.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 03:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861527; x=1702466327;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJncplPRljOk1kpx+WzGu84RdAxKtfrBb2w62k3mS4o=;
        b=HuIlf/Ly3XCou9zDNBVq0XJa27BGNHf0f1O3mF7UePH8q25Q+TrmHye1Wz6j35qZ32
         td/mawW6Scfe5R9JyZs++731VpMTxHpSh1y7nhn7dA74tr9KlvfnvRG2I8P3ScQM0aD6
         v0DhCpvWQedmVmiWisiVUqhpAlQjb7r0Mii7ncGyESiN6i8vsAGqms7qjPyOVR+lkxhy
         tfhV9z7lesdFG3/cMb99UH/9gkLgmh55bOTHYhof6i++xFX1ayDSlf6964/sCRltQYSz
         tbDSIsIek+Xy1aHX1lURooJH5IPluap/+KgivmhB5z6wxhRSUZCxn0O/nB7bljsLnfb1
         pcCA==
X-Gm-Message-State: AOJu0YyixYl3UyK+1C9Hrfkt9k1sJwCRprRxRwxSEkRwpzZP0TzEblG7
	xqkrDxL2m08+2gqN1wlENVBQ8iKQJgikcqnjIhI0h06kxgN2V3CvsQFW0/Y+ihbiqt5ndYBIPEE
	PV16asHqZ5Uo56rl2
X-Received: by 2002:a17:907:d40d:b0:9e6:c282:5bd5 with SMTP id vi13-20020a170907d40d00b009e6c2825bd5mr1127056ejc.3.1701861527669;
        Wed, 06 Dec 2023 03:18:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0Um7Bufb1/ZT9/Kaw3C5YP9nLXIl+1wHqoIb4g2MvErWwV8whtClxgMm14gtL9LyWcUS7SQ==
X-Received: by 2002:a17:907:d40d:b0:9e6:c282:5bd5 with SMTP id vi13-20020a170907d40d00b009e6c2825bd5mr1127034ejc.3.1701861527285;
        Wed, 06 Dec 2023 03:18:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-243-102.dyn.eolo.it. [146.241.243.102])
        by smtp.gmail.com with ESMTPSA id hd18-20020a170907969200b00a1cbb289a7csm2037614ejc.183.2023.12.06.03.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:18:46 -0800 (PST)
Message-ID: <ffd7a4cbefa8c4f435db5bab0f5f7f2d4e2dad73.camel@redhat.com>
Subject: Re: [PATCH V3 net 1/2] net: hns: fix wrong head when modify the tx
 feature when sending packets
From: Paolo Abeni <pabeni@redhat.com>
To: Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com, 
 salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  wojciech.drewek@intel.com
Cc: shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Dec 2023 12:18:45 +0100
In-Reply-To: <20231204143232.3221542-2-shaojijie@huawei.com>
References: <20231204143232.3221542-1-shaojijie@huawei.com>
	 <20231204143232.3221542-2-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-04 at 22:32 +0800, Jijie Shao wrote:
> @@ -2159,16 +2175,9 @@ static void hns_nic_set_priv_ops(struct net_device=
 *netdev)
>  		priv->ops.maybe_stop_tx =3D hns_nic_maybe_stop_tx;
>  	} else {
>  		priv->ops.get_rxd_bnum =3D get_v2rx_desc_bnum;
> -		if ((netdev->features & NETIF_F_TSO) ||
> -		    (netdev->features & NETIF_F_TSO6)) {
> -			priv->ops.fill_desc =3D fill_tso_desc;
> -			priv->ops.maybe_stop_tx =3D hns_nic_maybe_stop_tso;
> -			/* This chip only support 7*4096 */
> -			netif_set_tso_max_size(netdev, 7 * 4096);
> -		} else {
> -			priv->ops.fill_desc =3D fill_v2_desc;
> -			priv->ops.maybe_stop_tx =3D hns_nic_maybe_stop_tx;
> -		}
> +		priv->ops.fill_desc =3D fill_desc_v2;
> +		priv->ops.maybe_stop_tx =3D hns_nic_maybe_stop_tx_v2;
> +		netif_set_tso_max_size(netdev, 7 * 4096);
>  		/* enable tso when init
>  		 * control tso on/off through TSE bit in bd
>  		 */

Side note: since both 'fill_desc' and 'maybe_stop_tx' have constant
values, for net-next you should really consider replacing the function
pointers with direct-calls.

You currently have at least 2 indirect calls per wire packet, which
hurt performances a lot in case security issues mitigations are in
place.

Cheers,

Paolo


