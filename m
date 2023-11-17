Return-Path: <netdev+bounces-48527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B726E7EEAB7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 02:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2E8B20A24
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 01:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3701375;
	Fri, 17 Nov 2023 01:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJH7Ixmt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CC1129
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 17:34:53 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5be24d41bb8so1101000a12.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 17:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700184893; x=1700789693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fu1MfOOQ0QmPKbRiBlMZVcOZDRZgiPGzQljwLltlcro=;
        b=CJH7IxmtX89GcaEiTzQ80DFsQdmsxEic2aG//+l0vVpIXgnr01BK6jyD3PLJs+3oJc
         oGNXB9AefPn/V8oxm+RgKXrsHs211tJxOw2Thi2fxtEq5+0AMPR9MjUsFphNb8rit8mW
         ddiUbg5UVUoypYg2/7strydfr7+hfkEXrnTi01ZDK9oKQYHPPpeWA8Ls0fqSTxdxrwVu
         4iSvzzwo9WkbU4RTTdT19hihtWGxC5VJEWuCIgaX/KEKNl3+5FAxujK4dgidHnpuL4Y1
         Dw478wozOMNFZ7TLkfu3Q0m9BJd8+Jkl83ldrvDf8wWBcG0TWbsEs91VoKDAn7DcBXVQ
         byoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700184893; x=1700789693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fu1MfOOQ0QmPKbRiBlMZVcOZDRZgiPGzQljwLltlcro=;
        b=bwmRxgZPsJG//wZrxdm1y6VtUoD0cuDN1MxQm0Yalw4jLad4kFH5xuK7rVwgPgnDDB
         uhllFQFed1ynjRf8sFeDJt+uzlDD9npCbgA1leWnjXPDra2XWQG2Q5BTmpghj1JixRKA
         lBgyJ5T68W8cMncTB+L/7YAJtUYrSR+eW66fvKLhBOjdNz9lOkubpAfF/kbDuHD6fJUZ
         LCMoQLuc1dqf1OPkvTmaU1/20YGjsmNnoAcGTGl13jJGWQjTd3wnK6dG+a3LzktYl72V
         uRtC7cpKJ0Kdfla0d5iHe1k8VLBzJyX1Wbh4I6wo9DZGE4rdgAqQEWwemTWJ8LQ+odC/
         FvcA==
X-Gm-Message-State: AOJu0YwLRmfhdn2fxAI+ApYixUiaB+CrTb4GV6sos+/wTjbHZnVaUnLd
	NoIx/cUptFkXFzsspx+cikw=
X-Google-Smtp-Source: AGHT+IHQ9Mbxhp0ZeczUcI2QnSjpX4PvuU8sTlg6D0+XbSrA3YxaL5sbwWEkU5UabSxar9SvkzTtow==
X-Received: by 2002:a17:90b:44:b0:280:6cde:ecc2 with SMTP id d4-20020a17090b004400b002806cdeecc2mr4908850pjt.11.1700184892729;
        Thu, 16 Nov 2023 17:34:52 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x10-20020a17090aa38a00b0028328057c67sm293796pjp.45.2023.11.16.17.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 17:34:52 -0800 (PST)
Date: Fri, 17 Nov 2023 09:34:47 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH net] wireguard: use DEV_STATS_INC()
Message-ID: <ZVbDN0RPnb/5n/Ka@Laptop-X1>
References: <20231116100217.2654521-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116100217.2654521-1-edumazet@google.com>

On Thu, Nov 16, 2023 at 10:02:17AM +0000, Eric Dumazet wrote:
> wg_xmit() can be called concurrently, KCSAN reported [1]
> some device stats updates can be lost.
> 
> Use DEV_STATS_INC() for this unlikely case.
> 
> [1]
> BUG: KCSAN: data-race in wg_xmit / wg_xmit
> 
> read-write to 0xffff888104239160 of 8 bytes by task 1375 on cpu 0:
> wg_xmit+0x60f/0x680 drivers/net/wireguard/device.c:231
> __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
> netdev_start_xmit include/linux/netdevice.h:4932 [inline]
> xmit_one net/core/dev.c:3543 [inline]
> dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3559
> ...
> 
> read-write to 0xffff888104239160 of 8 bytes by task 1378 on cpu 1:
> wg_xmit+0x60f/0x680 drivers/net/wireguard/device.c:231
> __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
> netdev_start_xmit include/linux/netdevice.h:4932 [inline]
> xmit_one net/core/dev.c:3543 [inline]
> dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3559
> ...
> 
> Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/net/wireguard/device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
> index 258dcc1039216f311a223fd348295d4b5e03a3ed..deb9636b0ecf8f47e832a0b07e9e049ba19bdf16 100644
> --- a/drivers/net/wireguard/device.c
> +++ b/drivers/net/wireguard/device.c
> @@ -210,7 +210,7 @@ static netdev_tx_t wg_xmit(struct sk_buff *skb, struct net_device *dev)
>  	 */
>  	while (skb_queue_len(&peer->staged_packet_queue) > MAX_STAGED_PACKETS) {
>  		dev_kfree_skb(__skb_dequeue(&peer->staged_packet_queue));
> -		++dev->stats.tx_dropped;
> +		DEV_STATS_INC(dev, tx_dropped);
>  	}
>  	skb_queue_splice_tail(&packets, &peer->staged_packet_queue);
>  	spin_unlock_bh(&peer->staged_packet_queue.lock);
> @@ -228,7 +228,7 @@ static netdev_tx_t wg_xmit(struct sk_buff *skb, struct net_device *dev)
>  	else if (skb->protocol == htons(ETH_P_IPV6))
>  		icmpv6_ndo_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_ADDR_UNREACH, 0);
>  err:
> -	++dev->stats.tx_errors;
> +	DEV_STATS_INC(dev, tx_errors);
>  	kfree_skb(skb);
>  	return ret;
>  }
> -- 
> 2.43.0.rc0.421.g78406f8d94-goog
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

BTW, what about the receive part function wg_packet_consume_data_done(), do
we need to use DEV_STATS_INC()?

Thanks
Hangbin

