Return-Path: <netdev+bounces-181149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1864A83E01
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22B416A471
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C76F20E319;
	Thu, 10 Apr 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="2EOeTjnx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D796920D4F0
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276082; cv=none; b=i759t0FaoczWXuZXE/qdHyST+Xid37O3l3T6iMyhlS1gxfFHMS8W1fPviLYObCUZOJbiwou5TTvCyK9mE4rUD5tawv+aJrlTDQQH/lRc4387tcnr0MgqAXF6WG0fM5R/++yUsNn/JprqQDJyE7cugmiUzXGPI802wOipJM4J7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276082; c=relaxed/simple;
	bh=0RgusPB9AKc3mbewpy1W6dgaHNtYhLI78XSYEhgInfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0Lc8nGlms46rmw2dE0Cbtwarm/wq1zXcoaUykU3aGt9yCeohkZ9mAJulHiVKQSzCdU6ZESDto4tWTG00y7kZ33BtJMcBXzy4anWjzI0+CFYT3tRw+SXR5Kg/04iv/HWTzTw0G2k+CAemFQ33RsIx9iUjrTH2j6dVqG+0FaILTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=2EOeTjnx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3995ff6b066so239047f8f.3
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744276079; x=1744880879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4V7YiDo0RpakRaep9oYeLL1BFBeL3gdOQ+ojJwaFZ4=;
        b=2EOeTjnx54papxYgbuQ0F+OjJYvC9Y1nFFKI55CzTm4fXzPM7HewO+QesxKo6g/9V0
         GuhtneWYySVaBX/KPohMKchG5sbjfN+JTpXAp5xS27JB4w+dF0LBClecdSfdOf2Rya+e
         sVZZF2uV8HTfZdx/DNmR39pu1PFAcaa5HksvE6p8MusTurbA6Zt+j4H8+5JOQ9lqDfXN
         IRkLj3hKYB7FdPOuvkbIHHm7ppKrMcCkapUpu0Io/yl5/VemNC66hn+stJS3SAn/X+NK
         8SvSXgjHkSnpTb6YYqJPc5ileOQCq5UkFiYgacUFTO08xy8VcMlA0Q9xdnN6T4XI5y62
         0uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744276079; x=1744880879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4V7YiDo0RpakRaep9oYeLL1BFBeL3gdOQ+ojJwaFZ4=;
        b=jYMidOmGsrCfRyrxXg68NgKm+/678nN7ZT1ni4oTKsTf0xxb9g3zS2lgLz9oaKMCpu
         uuAc2NDwSAqrALIrhx8Wmrlw2kGvO48eradJhd1T/2Ooo1wjElaNOgz7XHML+OZzfonT
         FRvTRfpwyXAdZ3PvdCdvKj7LUkWs/YzzP+7wdyQ5nkh0IXe6sCPUKGcGRMLsILoA41a9
         sSVF1TJoAtY7OgJ+Dj5Z52lMhbHPv0Bpog9NR9Sm+vSkVJOv8a4G69yVMy4Og4cyIgaL
         uLOmUBW+OY88Iklnb/hb0wiHRT966rtPffHF4LvQXqK3VUItByEe2U+HpvvZC4O+NQBQ
         MTag==
X-Forwarded-Encrypted: i=1; AJvYcCW7SIJv30BK1qkYZEhoak41YYOlZG8atfiWlGGubZ1mvYRPX9/+IGiX6AnRc9kCYOyfJCHDqTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoGR2Nlje7w3TNHBKcbmtLSLLcphkH4Bq8zCCSCmQyp0DLO3Nd
	MV5R6YsMS+fMHb6bRw/yOFTqDGoupaZwLk3D6sJjMZ6b+PZS6Zm5eNhprFlFVyM=
X-Gm-Gg: ASbGncuRX/CkDYO1y1bqFf3/0qd9ukxCl8sl4z17PXffrLdiwdjx4TMqIMONohld/UZ
	V7042Xx/5xNjRPmghXkB62lMCqh2lpJiADyLs9YQdaXNV8w3U/rlIugt3IrEVzbz7dp6L3LOKWe
	tNnvYGYIM7V3+TiDGuBaF1pUWrVXqkNQWJNxVMDSNUgitIT/pKrrpvhFlT9ZSM8d1iJvms95UaK
	FxbFAA6/r1R+P2yHnQkGKbDQ039PqXaz1JSfEm6EM6ZHUYCclIrqCUcLDwdB6UBSRJCbCvGJgLP
	Mz9NQSkz/gvmaHFBmIzfU7L86OYYAH5LcLQVQy9VOdOKUhCTZvaJ87V70hoHblz0FsycoB0Y
X-Google-Smtp-Source: AGHT+IFOxesnmPZ8utK87AiR+cpFm4eLgAN8T6k7Cs5i3QXsE5HYdFCq/ll0Kr+H45b/+KtE/A7A9Q==
X-Received: by 2002:a5d:59ab:0:b0:391:2f15:c1f4 with SMTP id ffacd0b85a97d-39d8f4f7e2emr1527108f8f.55.1744276079096;
        Thu, 10 Apr 2025 02:07:59 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89400345sm4188859f8f.99.2025.04.10.02.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 02:07:58 -0700 (PDT)
Message-ID: <f87b7ca9-103a-423b-a9e6-6cb886a48cf4@blackwall.org>
Date: Thu, 10 Apr 2025 12:07:57 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 05/14] vxlan: Convert vxlan_exit_batch_rtnl()
 to ->exit_rtnl().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250410022004.8668-1-kuniyu@amazon.com>
 <20250410022004.8668-6-kuniyu@amazon.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250410022004.8668-6-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/25 05:19, Kuniyuki Iwashima wrote:
> vxlan_exit_batch_rtnl() iterates the dying netns list and
> performs the same operations for each.
> 
> Let's use ->exit_rtnl().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> ---
>  drivers/net/vxlan/vxlan_core.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 8c49e903cb3a..6ee61334719b 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -4966,19 +4966,15 @@ static void __net_exit vxlan_destroy_tunnels(struct vxlan_net *vn,
>  		vxlan_dellink(vxlan->dev, dev_to_kill);
>  }
>  
> -static void __net_exit vxlan_exit_batch_rtnl(struct list_head *net_list,
> -					     struct list_head *dev_to_kill)
> +static void __net_exit vxlan_exit_rtnl(struct net *net,
> +				       struct list_head *dev_to_kill)
>  {
> -	struct net *net;
> -
> -	ASSERT_RTNL();
> -	list_for_each_entry(net, net_list, exit_list) {
> -		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
> +	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
>  
> -		__unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
> +	ASSERT_RTNL_NET(net);
>  
> -		vxlan_destroy_tunnels(vn, dev_to_kill);
> -	}
> +	__unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
> +	vxlan_destroy_tunnels(vn, dev_to_kill);
>  }
>  
>  static void __net_exit vxlan_exit_net(struct net *net)
> @@ -4992,7 +4988,7 @@ static void __net_exit vxlan_exit_net(struct net *net)
>  
>  static struct pernet_operations vxlan_net_ops = {
>  	.init = vxlan_init_net,
> -	.exit_batch_rtnl = vxlan_exit_batch_rtnl,
> +	.exit_rtnl = vxlan_exit_rtnl,
>  	.exit = vxlan_exit_net,
>  	.id   = &vxlan_net_id,
>  	.size = sizeof(struct vxlan_net),

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


