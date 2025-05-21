Return-Path: <netdev+bounces-192136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA74ABE9FB
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 04:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3614A570B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 02:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E3A1C5F09;
	Wed, 21 May 2025 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MplO6qD9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D54430;
	Wed, 21 May 2025 02:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747795295; cv=none; b=Oun3F6S1PqrYkGCGIt08nH8tMzHVip86BPWhGG1lgtGowgL65Sccyaoq4GELhXwCTaq1I/Vjw9lg2X5iv/wVpYIHm7BqWg9xa6dHCgeTcyDtU0clLHfc/zoewtKONbkBqrUrmNKjLbkT8jqBq62OTE/T93SW4ufrNY8fxIyVyUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747795295; c=relaxed/simple;
	bh=+/sRfFIsqUcfo9dusVUZk/wm5YQcmXYfkjbZgIdtTgc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Jd37kYbfRA4hbf6lc57442o0hmuh5phncBBQCaj52BgJboK31UsRFGN0Ll7DZrviCSHesiUJnVqDspNnqQSP8kAtU5ymEphCIhj4adpj4ChvJGSwDjlhnoB5GL/mQRHvC0LrH3p1RIjDPYtiORpu2L9ZrLXsJ+lKw3F3RhEc6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MplO6qD9; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f8aabbffaeso58365396d6.0;
        Tue, 20 May 2025 19:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747795291; x=1748400091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWGHJsw/qanQe5H1eio/FueQXZVPYyAwMXBqZf2HXGA=;
        b=MplO6qD9ifxxwfumr8uPX/aqIz5barW34VxDwO8rFvG/gq+JSs6YgxxqrrmBK7lPYo
         TXJjDjdeMZWffxR5sjZLA/vkM0X73hUhP1w1rlJJ7Zr/nyd1MvJksxClIy/tvakHbAGs
         g7pb1p33rQYMMAlUgvS17i9xwbtGMaM6ByrVCwrjy1HuMbzUzF2mf7GmmyUnkDT+pueh
         jkrJVPKbrCn7wz/Dd+8FB9BHf4MHjVAf/0TPg950gu+y9BN2a+wY0xFGgul13IzTJGWH
         htakvnxH/j1kq5Yw/mz+P5yED3tEiJRbM2I031MPwpAeCgqm1TMjocEdbLVtnFGXvcrd
         0FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747795291; x=1748400091;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aWGHJsw/qanQe5H1eio/FueQXZVPYyAwMXBqZf2HXGA=;
        b=IiSHE8S+CYPKLJX/ivjrSo140bAD9KHion4+KlU/EWzBo5mNkOufokLy75QLncUtBy
         Jnvqh6ke6fxs49mBhM2wabL4YVVgtehaBuoYJTMWS5MpsBXjba/zWdC8CYWuRJl/b93a
         gm4ObSkohDu9+sbji8/TXsb8pWwwXDL4jUGYS9lB3SL9bFHw+QebB8rSJf8rgvGaBwGs
         PtFxTxDlllE3KInUAiBH3Xl6oG662CY3hd52fvOIEGYBowiQLFRYtHsb4eqNb18TYf8U
         btI6WZL/+GPZHoz+rY6Ep6L8lc6Ev+uKh63IDlOkKKfLP40rFqYp5d+SmaLXj6ljBvN8
         7vTA==
X-Forwarded-Encrypted: i=1; AJvYcCWa/3ZsthczSzE+s563DB0mwNcK3fXuzASBjXpdwt3f3QjY4S527kawP1aaXLtX0ewFweldOnA9ds4d+rI=@vger.kernel.org, AJvYcCXqG8LSXf0mjjB5WI2iUyyOZ9BAOB02ea4E2JIgB/TJ+FuDhXMqkQyiNQUaa6f321NaoqVKYXyQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw+Da9Pl77uETSOBqGyXj+DreSSG82Nq+7kcPN0HRStQ+QY61F
	VVEgk+cfS/tWTr+CiMeVOmyXEHKyGNDIW/DVJG1BOhO44uRdRbItCcYa
X-Gm-Gg: ASbGncuJ7R8s55oNKQyHYqKVhxU4eN+nHU6I6K4n8jO+sfTXDJb4Vf3sw0Nu2J03KeN
	9suB9JeGbyW1A7abfr4YUWAsOwT1fS5zsyXEdVSwlchdYljdmghl0Kqy5dChDgDCMaEgkk8p6Fq
	clHWVL02dfawQp29tXklA8byKpHeUiPGTxKtzXeghqBoy8B0GMOLwLQgTKXQXLx4dE3J8Tp2hkf
	mCAQWxU8TrL+BPZye64/3PrC3FOiFtAt3P4upeyXS5arPsju9p1s2NZwq5cpD6GcdOz0PH+6YZq
	dy0M2jFlNCpz22ttCVpxuUMd05nzYqnjQBjBEV9NCxbZiqMC6I/P7OS539MvafJ+GAkIu2tEpX/
	uk+JrPWq3/Pdgw9yImZYhOAc=
X-Google-Smtp-Source: AGHT+IF7Y4gTrg3WIMTBFet7GetU7N+rYSRJy+X6b2dvv0ufu7dTmNyzwUHPodMoH31XjTrQ5Rs6wg==
X-Received: by 2002:a05:6214:2608:b0:6e8:f672:ace9 with SMTP id 6a1803df08f44-6f8b2d82abfmr329361456d6.29.1747795291568;
        Tue, 20 May 2025 19:41:31 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b096571esm79418316d6.73.2025.05.20.19.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 19:41:30 -0700 (PDT)
Date: Tue, 20 May 2025 22:41:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 horms@kernel.org, 
 stfomichev@gmail.com, 
 linux-kernel@vger.kernel.org, 
 syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
Message-ID: <682d3d5a77189_97c02294a3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250520202046.2620300-1-stfomichev@gmail.com>
References: <20250520202046.2620300-1-stfomichev@gmail.com>
Subject: Re: [PATCH net] af_packet: move notifier's packet_dev_mc out of rcu
 critical section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stanislav Fomichev wrote:
> Calling `PACKET_ADD_MEMBERSHIP` on an ops-locked device can trigger
> the `NETDEV_UNREGISTER` notifier,

This made it sound to me as if the notifier is called as a result of
the setsockopt.

If respinning, please rewrite to make clear that the two are
independent events. The stack trace in the bug also makes clear
that the notifier trigger is a device going away.

> which may require disabling promiscuous
> and/or allmulti mode. Both of these operations require acquiring the netdev
> instance lock. Move the call to `packet_dev_mc` outside of the RCU critical
> section.
> 
> Closes: https://syzkaller.appspot.com/bug?extid=b191b5ccad8d7a986286
> Reported-by: syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
> Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
>  net/packet/af_packet.c | 20 +++++++++++++++-----
>  net/packet/internal.h  |  1 +
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index d4dba06297c3..5a6132816b2e 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -3713,15 +3713,15 @@ static int packet_dev_mc(struct net_device *dev, struct packet_mclist *i,
>  }
>  
>  static void packet_dev_mclist_delete(struct net_device *dev,
> -				     struct packet_mclist **mlp)
> +				     struct packet_mclist **mlp,
> +				     struct list_head *list)
>  {
>  	struct packet_mclist *ml;
>  
>  	while ((ml = *mlp) != NULL) {
>  		if (ml->ifindex == dev->ifindex) {
> -			packet_dev_mc(dev, ml, -1);
> +			list_add(&ml->remove_list, list);
>  			*mlp = ml->next;
> -			kfree(ml);
>  		} else
>  			mlp = &ml->next;
>  	}
> @@ -4233,9 +4233,11 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
>  static int packet_notifier(struct notifier_block *this,
>  			   unsigned long msg, void *ptr)
>  {
> -	struct sock *sk;
>  	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
>  	struct net *net = dev_net(dev);
> +	struct packet_mclist *ml, *tmp;
> +	LIST_HEAD(mclist);
> +	struct sock *sk;
>  
>  	rcu_read_lock();
>  	sk_for_each_rcu(sk, &net->packet.sklist) {
> @@ -4244,7 +4246,8 @@ static int packet_notifier(struct notifier_block *this,
>  		switch (msg) {
>  		case NETDEV_UNREGISTER:
>  			if (po->mclist)
> -				packet_dev_mclist_delete(dev, &po->mclist);
> +				packet_dev_mclist_delete(dev, &po->mclist,
> +							 &mclist);
>  			fallthrough;
>  
>  		case NETDEV_DOWN:
> @@ -4277,6 +4280,13 @@ static int packet_notifier(struct notifier_block *this,
>  		}
>  	}
>  	rcu_read_unlock();
> +
> +	/* packet_dev_mc might grab instance locks so can't run under rcu */
> +	list_for_each_entry_safe(ml, tmp, &mclist, remove_list) {
> +		packet_dev_mc(dev, ml, -1);
> +		kfree(ml);
> +	}
> +

Just verifying my understanding of the not entirely obvious locking:

po->mclist modifications (add, del, flush, unregister) are all
protected by the RTNL, not the RCU. The RCU only protects the sklist
and by extension the sks on it. So moving the mclist operations out of
the RCU is fine.

The delayed operation on the mclist entry is still within the RTNL
from unregister_netdevice_notifier. Which matter as it protects not
only the list, but also the actual operations in packet_dev_mc, such
as inc/dec on dev->promiscuity and associated dev_change_rx_flags.
And new packet_mclist.remove_list too.

>  	return NOTIFY_DONE;
>  }
>  
> diff --git a/net/packet/internal.h b/net/packet/internal.h
> index d5d70712007a..1e743d0316fd 100644
> --- a/net/packet/internal.h
> +++ b/net/packet/internal.h
> @@ -11,6 +11,7 @@ struct packet_mclist {
>  	unsigned short		type;
>  	unsigned short		alen;
>  	unsigned char		addr[MAX_ADDR_LEN];
> +	struct list_head	remove_list;

INIT_LIST_HEAD on alloc in packet_mc_add?

>  };
>  
>  /* kbdq - kernel block descriptor queue */
> -- 
> 2.49.0
> 



