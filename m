Return-Path: <netdev+bounces-201954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEE1AEB908
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A557A254A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7337293C5B;
	Fri, 27 Jun 2025 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xsuym1xS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8F2F1FDF
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751031223; cv=none; b=uqX09Z/Kii38aoNTKaxkiTmhi3XBv8GmAFOi8U9HnZgOVwP5KfRnL3vpa3bOTFc8fMzeBijUYAZlL5gRXFAYvKcDmUDvBa1lV/mnclWAuoJlOJ+1vMIIlxvbDSsbsA6epSZeA0tJgDfWgq6BEHVhWpc6zysUHAoCIPVVMjfrSNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751031223; c=relaxed/simple;
	bh=w+yzto0F9H/FN7XuWmwmpyIFyvrjGjwE9RYWqiIwZpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afjYjktVYuDS0xavKTHa36fe1tpwF3EWfpqbC+5wg5dc9MD/vfjdz7plAZh7MS6NkxQEYXv/bbQxB1AkHaN/XYznl0mLU0S/p/UPorVfiT9Bb7v8rLLVA7UNL9md2WUoYarnBzK5i9805dYZ/X7nu7ZFJGn5z9oZIacCqI0jaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=xsuym1xS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso453799766b.2
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1751031219; x=1751636019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5x4iaYDFJrppb+ZWfgW5X62BF0tQwdQ5wOtDPb3V6U=;
        b=xsuym1xSIelr4hyVauvifFuOtMWmdTOxef+TrknrY+WB28xtN9tj02z4PW5Gfak+1J
         FKbh85cKkQuUxbXlcI7s2nNAQjzOKUGALHcfXW/3rTL7SxYmDvj3BiwMKT8pUjy1x7nL
         nQW+09Avl//PaBvdRmbFz8MvEkGGv8waPw3nOwSzzbzlU9RT9oHqwAxQ9Te/CSS2YqZv
         NrbzhvR3WNLMNYU3s1wbdzrHEr5CHLtgEGwoxFlHZUD9/G3pPU8A/hB9wECYHtgv7iLE
         LqWOkYa7pDFqOJljBv6IZb7jb+ewkfooFk+3/58/6QfnBStc6cNCYkIY8UIY3ztQJy5s
         0aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751031219; x=1751636019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5x4iaYDFJrppb+ZWfgW5X62BF0tQwdQ5wOtDPb3V6U=;
        b=LHaAsKmnv/mmRV2VV9eSwdp3nDepTRYPuTWmZLYnj7NIffHlk36H7pkLf00AAxFn+O
         XTvBSEjZ4XvhO8PtRAleR7JMngCOxx8//EQELsRRZ5UAUzPtBwkkg21jcI/zMY7TAvuS
         Vg3SYjzm9czrfjieKRuAcGvSbLSCu/ugsOkI64noB7SgjU8mzh1p4A7ODwc3oaKVc44Y
         44ybkmsZFQaDyX2pE1NFmTYMVqvApycvEPDOn71fKzan3KwgRGmzI/o8AnDad72B2d7/
         L2WFYSamLJqERNn7LTBMgCARIB5Ib51V9gv1dpqkyayLzQLYDf3AFU6KU0IzWsIOIzXK
         qc6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV96e7ta6TRbZN6D+p3dBj5jh0yVq+pm3zosc4aGc//5lQvUPmSTtN3QtzBFqmfYtaBvNKQYXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBSgvAbQxRBXd4DB5o4xecHak254iKbzjzAQxgvyWGWPh1O59l
	tfOsbzgMUm9AALasvXJ+XePU+KuqxfJWWC+Xgolpv5HOKRCDwhwCI0uwhOFV9yaLtEw=
X-Gm-Gg: ASbGnct2bBwvX5x1R0hRBu5XL6rK67J2iyVEPza2oBPmWnW0nCQ4sZgkNwM6uhTu7Qu
	IpdhgFNXD4ztAGDVBLK616uENmw/Mv3dNyCp+7VHm1XMSgU1l+WOSEiARJ/aDyvEydH3oBlcKgL
	R7+WE79JYfpuw9CmM0/nXHMWRp2HPgSdObAQYTo/jsNpQohD4h2kSlVZA32cjOCrWbeuMwikEZn
	vNoNKMCZB20iunvin2bxi0QiU7d87/PikidrqlIQRoas6igaDMh0QFOx9Kw6S42/hsSEfWFO0e+
	Q3wAXMVFwhIY+4PW/TsgZFwfEHy9E702CnIJ+FsWFepCCNk8xkw0GjBVJXGm91YxedhSNAzAJt1
	46JRGMyOgRA888hxkd8Tvc03NdK9V
X-Google-Smtp-Source: AGHT+IFaeZqD2/DDGCamfLi2aqw8VYMKJEfNT8xWZ2ZdHPwcgMx/OFl0AlyE3hPKEPLwReNOL5UBug==
X-Received: by 2002:a17:907:94ca:b0:ae0:cf01:a9ad with SMTP id a640c23a62f3a-ae35010473bmr339661866b.40.1751031219081;
        Fri, 27 Jun 2025 06:33:39 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01996sm125415566b.76.2025.06.27.06.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 06:33:36 -0700 (PDT)
Message-ID: <740387fb-ed72-4a6f-9625-c4fccb1f09ab@blackwall.org>
Date: Fri, 27 Jun 2025 16:33:35 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: guard ip6_mr_output() with rcu
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+0141c834e47059395621@syzkaller.appspotmail.com,
 Petr Machata <petrm@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>,
 Benjamin Poirier <bpoirier@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
References: <20250627115822.3741390-1-edumazet@google.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250627115822.3741390-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 14:58, Eric Dumazet wrote:
> syzbot found at least one path leads to an ip_mr_output()
> without RCU being held.
> 
> Add guard(rcu)() to fix this in a concise way.
> 
> WARNING: net/ipv6/ip6mr.c:2376 at ip6_mr_output+0xe0b/0x1040 net/ipv6/ip6mr.c:2376, CPU#1: kworker/1:2/121
> Call Trace:
>  <TASK>
>   ip6tunnel_xmit include/net/ip6_tunnel.h:162 [inline]
>   udp_tunnel6_xmit_skb+0x640/0xad0 net/ipv6/ip6_udp_tunnel.c:112
>   send6+0x5ac/0x8d0 drivers/net/wireguard/socket.c:152
>   wg_socket_send_skb_to_peer+0x111/0x1d0 drivers/net/wireguard/socket.c:178
>   wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
>   wg_packet_tx_worker+0x1c8/0x7c0 drivers/net/wireguard/send.c:276
>   process_one_work kernel/workqueue.c:3239 [inline]
>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3322
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3403
>   kthread+0x70e/0x8a0 kernel/kthread.c:464
>   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> Fixes: 96e8f5a9fe2d ("net: ipv6: Add ip6_mr_output()")
> Reported-by: syzbot+0141c834e47059395621@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/685e86b3.a00a0220.129264.0003.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Benjamin Poirier <bpoirier@nvidia.com>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/ip6mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index a35f4f1c658960e4b087848461f3ea7af653d070..eb6a00262510f1cd6a9d48fab80bdd0d496bb7ee 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -2373,7 +2373,7 @@ int ip6_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	int err;
>  	int vif;
>  
> -	WARN_ON_ONCE(!rcu_read_lock_held());
> +	guard(rcu)();
>  
>  	if (IP6CB(skb)->flags & IP6SKB_FORWARDED)
>  		goto ip6_output;

Thanks,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


