Return-Path: <netdev+bounces-219121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 050A8B40047
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72A554678B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F19B2BFC7B;
	Tue,  2 Sep 2025 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="TB6BjwEV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5D52C0265
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815388; cv=none; b=Kr7NQVJWgCpzWwbuRYgZ3HMehvef0k1WMSoQTuC6U6OZJsB2dzodvL0VTcXD6izYjFMbHDk5mgsFWgEymVNvSOqnFsinPLmmZhEtObuHXSdKm1yN/qpjN5KIRfqoMd8iFPS0xpBaR11OIePfMEGqnt5ElDss47Dyp4enMIXo4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815388; c=relaxed/simple;
	bh=8Fc2OmN9hAtWJLpja47JkAsKYMd28LumrCY/z3BmeX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxuI7x2DHnmk2sqRJpgt+P2ooOlrZmisQtzS4E+5ViooM9g1f46syYbFjNT0RofNVgaQnJjetBdc60udqYxhVM5vNmHWAFawDtFsKs6rd3f9w4XC6NGy3o0EeHllH3wmtcIRswrMtO03n1TgoKGJkNxgDOPSFHBLuCDxOlpmTtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=TB6BjwEV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5607a240c75so1830408e87.2
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1756815384; x=1757420184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4GNz2VLg4Co+eEK70HbEpQhW1Y77DNVd5rnkRM4NFKo=;
        b=TB6BjwEVw7og8lYm0xt0rBycVqhE1KbhpZ5QNSXWTdGO3GYPrpZJXRO07ToA6G+F1Z
         08jTOVK85a0fv1BqkTWrLNan9P1HH/umrd+zD6a+9/SDN5Dn8nPOyEpf3QX1W54xp02l
         HWFFdknZ/gFCepXy/C3/70TYWT1vo7myGzt2nvIi+VyOpUkmH2ng5p1WKTYixkp+ZWpC
         YcGSH2oxOvAWoM/s4cE1+PJNNvrS4GqEUol6mXs6vcu2GfUEYe/1a94ZCEvVys0iOZj3
         Y1K1kyqKPKl1kPZQnIySPd/KjuZhBiPVE0SbvFVpwYexDebtrsrxEBPkXINIqG87/L95
         EvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815384; x=1757420184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GNz2VLg4Co+eEK70HbEpQhW1Y77DNVd5rnkRM4NFKo=;
        b=Vf1oS87i/3Yl4nvIF32+pS1ADm2Bj1VLOSDLKxUSFxGPDrdtD02DtKa9vPkFogk8YJ
         4firZ2DsklRxIJyFFGeC9blzjlmagLt94AH7DWrvMxhORbU3NZ0860Y320Ph3ayroDr7
         5Lb2Jj56FBN9lF2UP2Dk9mz/Zl0S9pzCF5mT3QSA6nPdQ1yBMfXtoSOVwDd2NCFiEscN
         rCI7Wx4nMajpTBLafO6EYCJMhLdIUAg976EcRXPgTovOZKaKH1MKMeGoe7IqRGMX1vAE
         BwYWc/ANVwrQlM3cGG77hgmyrfxdoxy9ujsYv9YOaHWaXOT/juY3ecKI82PQ6tjOVxbS
         eieQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/uhKpYxzRMCO+sSuJ0qb0TKV38qqKNEBpq1sA5x6Ez1QKeQPROAtkc7lBJgTElF21QZ4MghA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMp/xisna1FenkvFtaX+LezUWpw1LAZ03pRPy1M+zc8MlxOqGe
	CKNleLFUithLyD3Wed/QiY3PL3eK9DQN/Py5srAQbrpnAmSIkWPib2PgB+w4QBusKC+WFItHsqQ
	4BdcVAzE=
X-Gm-Gg: ASbGnctmDSsX/nFaZXdQ2nC8ItQ6y06d+CJtMvUs4oBrXqv6G3Oywnd+FjrnGxariNv
	ljD6sECwh98uqS1DPg3EYxsLzj4sXORfvRoL289dsnWEdFw6tKnnHae76JptYI1sdDCydGSKixz
	hgZGJZ7XaQtbKMeg9x/QOMVQtLHFZsJ+pPNmVLd9hCQstLcHK3/NRw9MKv6NbNAsvhR5z0ZEJp4
	yiy4tsEPXlLiM4P9ya6Y7kCip5dtaRx51rEYs3KXNPkDtICBNRtas/PXGHuBCM+aPYYipbTzAMw
	fjoQq0Q4Og88fpOPtnub+zIEI9DnUu+0dVsdQEgOk3YVQWBHCO4RQT82QfGDISBL+6x8IKIzY7y
	UDI9iqsYV9DYaZgMoMY2lweycyeRnJV6qL6231NkIaLQgphc34Zzu+YGdeHVillRw6k+IFpV377
	z3Cg==
X-Google-Smtp-Source: AGHT+IFfB+9hWzZ52yIZNxv3HefMMf2a+OoYPoJw3/9oTnpp1ck51GwmBsdS2nZ187Vd6bWSXFjUbA==
X-Received: by 2002:a05:6512:689:b0:55f:3aab:878f with SMTP id 2adb3069b0e04-55f709dd5e3mr3518337e87.55.1756815383452;
        Tue, 02 Sep 2025 05:16:23 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560826d1086sm669477e87.4.2025.09.02.05.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:16:22 -0700 (PDT)
Message-ID: <be4297e7-e280-4dab-983e-1253e09524c5@blackwall.org>
Date: Tue, 2 Sep 2025 15:16:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] vxlan: Fix NPD when refreshing an FDB entry with
 a nexthop object
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com, mcremers@cloudbear.nl
References: <20250901065035.159644-1-idosch@nvidia.com>
 <20250901065035.159644-2-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250901065035.159644-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/25 09:50, Ido Schimmel wrote:
> VXLAN FDB entries can point to either a remote destination or an FDB
> nexthop group. The latter is usually used in EVPN deployments where
> learning is disabled.
> 
> However, when learning is enabled, an incoming packet might try to
> refresh an FDB entry that points to an FDB nexthop group and therefore
> does not have a remote. Such packets should be dropped, but they are
> only dropped after dereferencing the non-existent remote, resulting in a
> NPD [1] which can be reproduced using [2].
> 
> Fix by dropping such packets earlier. Remove the misleading comment from
> first_remote_rcu().
> 
> [1]
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> [...]
> CPU: 13 UID: 0 PID: 361 Comm: mausezahn Not tainted 6.17.0-rc1-virtme-g9f6b606b6b37 #1 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
> RIP: 0010:vxlan_snoop+0x98/0x1e0
> [...]
> Call Trace:
>   <TASK>
>   vxlan_encap_bypass+0x209/0x240
>   encap_bypass_if_local+0xb1/0x100
>   vxlan_xmit_one+0x1375/0x17e0
>   vxlan_xmit+0x6b4/0x15f0
>   dev_hard_start_xmit+0x5d/0x1c0
>   __dev_queue_xmit+0x246/0xfd0
>   packet_sendmsg+0x113a/0x1850
>   __sock_sendmsg+0x38/0x70
>   __sys_sendto+0x126/0x180
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0xa4/0x260
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> [2]
>   #!/bin/bash
> 
>   ip address add 192.0.2.1/32 dev lo
>   ip address add 192.0.2.2/32 dev lo
> 
>   ip nexthop add id 1 via 192.0.2.3 fdb
>   ip nexthop add id 10 group 1 fdb
> 
>   ip link add name vx0 up type vxlan id 10010 local 192.0.2.1 dstport 12345 localbypass
>   ip link add name vx1 up type vxlan id 10020 local 192.0.2.2 dstport 54321 learning
> 
>   bridge fdb add 00:11:22:33:44:55 dev vx0 self static dst 192.0.2.2 port 54321 vni 10020
>   bridge fdb add 00:aa:bb:cc:dd:ee dev vx1 self static nhid 10
> 
>   mausezahn vx0 -a 00:aa:bb:cc:dd:ee -b 00:11:22:33:44:55 -c 1 -q
> 
> Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
> Reported-by: Marlin Cremers <mcremers@cloudbear.nl>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_core.c    | 8 ++++----
>   drivers/net/vxlan/vxlan_private.h | 4 +---
>   2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index f32be2e301f2..0f6a7c89a669 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1445,6 +1445,10 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
>   		if (READ_ONCE(f->updated) != now)
>   			WRITE_ONCE(f->updated, now);
>   
> +		/* Don't override an fdb with nexthop with a learnt entry */
> +		if (rcu_access_pointer(f->nh))
> +			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
> +
>   		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
>   			   rdst->remote_ifindex == ifindex))
>   			return SKB_NOT_DROPPED_YET;
> @@ -1453,10 +1457,6 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
>   		if (f->state & (NUD_PERMANENT | NUD_NOARP))
>   			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
>   
> -		/* Don't override an fdb with nexthop with a learnt entry */
> -		if (rcu_access_pointer(f->nh))
> -			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
> -
>   		if (net_ratelimit())
>   			netdev_info(dev,
>   				    "%pM migrated from %pIS to %pIS\n",
> diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
> index 6c625fb29c6c..99fe772ad679 100644
> --- a/drivers/net/vxlan/vxlan_private.h
> +++ b/drivers/net/vxlan/vxlan_private.h
> @@ -61,9 +61,7 @@ static inline struct hlist_head *vs_head(struct net *net, __be16 port)
>   	return &vn->sock_list[hash_32(ntohs(port), PORT_HASH_BITS)];
>   }
>   
> -/* First remote destination for a forwarding entry.
> - * Guaranteed to be non-NULL because remotes are never deleted.
> - */
> +/* First remote destination for a forwarding entry. */
>   static inline struct vxlan_rdst *first_remote_rcu(struct vxlan_fdb *fdb)
>   {
>   	if (rcu_access_pointer(fdb->nh))

Nice catch,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


