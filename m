Return-Path: <netdev+bounces-219123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2A5B3FFED
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A911B27DE8
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6AB2C11DF;
	Tue,  2 Sep 2025 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ZR5dFx+i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5B2C1590
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815444; cv=none; b=i6VZHvMdSG9PF1y6USzqC0333T6opwe7i2mqxJmoncI3kHgsjVyaLQaprpYlJLTC55eWn4XKVm9MwSKyTkCTqh9wEqnVoz511nuuiJvmlTVrLj1ymb0JQW+lQyeq0S4gCaAZOpgZenBtOYVuG44d/mKiWwgZAAz6OwpLTZQTLO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815444; c=relaxed/simple;
	bh=N3vWDhCOBaZTBUtVme6+yPTAy05u/Y0hc3po6Ylu+DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvBRjJ6nSgfkEyRfGi0fLvIZ6dhmsfmK3P5Qd+uLuagaApyRBRmZrbfk9pim+ZyrpxSG2n1o2luXYqanISoBBntxL4ALowBJ1ZzmnpGjUfpcUFxYzUN7XV/r1R+4zF/twrk2CuJvNHkBFLlLEuuDcrbin7hAyu++2L6ZzQUEwRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ZR5dFx+i; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-560880bb751so34204e87.3
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1756815439; x=1757420239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YY5Fq04UKnDR1qGwzFCqLPFzo8fpSNIcl0+8o47nm7s=;
        b=ZR5dFx+iWvSbP0UBobvVfe8g5pqHVaJC4N7ochYmASAA/31UdgYOwAvQnveVjPHRWI
         XqBFRQb+3ufBR7AiciACNMDICy9AGFkUlqi0AQEz1EOwLxHAJbciG1sdVhW2wbk5uhCD
         /v0prjDHm6XPmJCLaJ7wg8B6jIcNsZ1V3vQFT8HtlTS40hDvmlOaLMZLCVv/BLHnm+gy
         D+ED5pXB131RVpWRNdGAGN/sybGBX0pKQEJz72bqp5L41N5YhTcXbd2CiNb3OaBHAsgU
         1OHITW59+Mjv/GYEIw9o+z5C1J6o2kFkboqwPLSMPQJ+sX4ZP7stNIyAhX+UreaJA7Ba
         S5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815439; x=1757420239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YY5Fq04UKnDR1qGwzFCqLPFzo8fpSNIcl0+8o47nm7s=;
        b=NX2oK0Xj+xJJXTN1KGU1whuN/M0tfaGdjGQzm3kuFLbXjTsFoAsEXD3gSa46iDmJ9q
         44g6eHfVCCuf0DsTlRyV2bf90FQ5OQLZelblwCybD21i6nmWXsHK0DOUU2P1nXDKhUd2
         1BawI0k1QLrbqmnJWaovdGZRcG9XVDZWCDZBwxRvbvEOHyuUUXnpJKBTvblt0Wjq+bm/
         R1XyJtkNvQ20nfk92kGcyuDaWa0I4XBKj3jcpX9g4pheTm7UsNZ1dI5jOXZw5CsxtfT6
         bQmEmXXktjhwlxxrWwDQ1bHh8NPaP5A0aj+RUrQo+afW+N4Ko3N3EgjOrOPJXriq7n0S
         CRzg==
X-Forwarded-Encrypted: i=1; AJvYcCXuf5iGlizzOEFyfB3LhwT4/bOa3wjQ3SA1wjilsppFNvN0rOPiANAZbQvjqRG8gw9AIC7Xl4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxTV8OLLgJeg4OFXu5epOJQS6Fgq/EL43K7CArU38GZYs6029A
	ocJtOGeEme/6no4rsGBCtWXttAykT9/NASGniJB6FUJ8/K2IKu9mJeWTqNsh7h7kI6E=
X-Gm-Gg: ASbGnctaQdo/YJj5kW5l3x3w1rwasTYSXMM3+X4SsugKJss4fkiTNqkrEmuwYkilhkv
	afvqE4isJ39tcrujSu5l+jQYtvaLY9tHz3j/PGcM0mRBp0j5T06ouhkgoNK8jRqOzP8ORKusSGh
	96Ag6UNgT/D+uBhNegZIH+qNIYcvrw+IxBDy81hvHDn8GyXCtO2X/GtT2n+43u8O5VPsMey7mag
	PrglbICDYot+TGE/eKMwSdTtdVMRfAiPTKoY6pe+r8gm3ZThZwOlalI+NRAbGJkWNP/IKqcQcKe
	dI39z6UPcJgC2oiZAfTs3g/2uwSxwkV6ogjhK3sYewUKmZNWgK69vBFiS1GiVzq4y9B6MwtsrIn
	KMakpNATP/ITlxZMoBPdEJ7m7yutcYI0ZXZ8ZinuQeSX8sbrDuMHZzn792Ca6NGnXFRTLImCK3z
	IcIw==
X-Google-Smtp-Source: AGHT+IFQJhNbaxZxWKm4iUzEbs1AJRaxzVHLWSTot3Y47efXhraywUOKZMVrnpAfYs2lrKqwY/QvKw==
X-Received: by 2002:a05:6512:3e15:b0:55f:6db5:748d with SMTP id 2adb3069b0e04-55f7089c530mr3720256e87.4.1756815438713;
        Tue, 02 Sep 2025 05:17:18 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560826d13edsm674760e87.14.2025.09.02.05.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:17:17 -0700 (PDT)
Message-ID: <2e341de1-ec26-4e1f-afdf-4b4854daf38f@blackwall.org>
Date: Tue, 2 Sep 2025 15:17:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] vxlan: Fix NPD in {arp,neigh}_reduce() when using
 nexthop objects
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com, mcremers@cloudbear.nl
References: <20250901065035.159644-1-idosch@nvidia.com>
 <20250901065035.159644-3-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250901065035.159644-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/25 09:50, Ido Schimmel wrote:
> When the "proxy" option is enabled on a VXLAN device, the device will
> suppress ARP requests and IPv6 Neighbor Solicitation messages if it is
> able to reply on behalf of the remote host. That is, if a matching and
> valid neighbor entry is configured on the VXLAN device whose MAC address
> is not behind the "any" remote (0.0.0.0 / ::).
> 
> The code currently assumes that the FDB entry for the neighbor's MAC
> address points to a valid remote destination, but this is incorrect if
> the entry is associated with an FDB nexthop group. This can result in a
> NPD [1][3] which can be reproduced using [2][4].
> 
> Fix by checking that the remote destination exists before dereferencing
> it.
> 
> [1]
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> [...]
> CPU: 4 UID: 0 PID: 365 Comm: arping Not tainted 6.17.0-rc2-virtme-g2a89cb21162c #2 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
> RIP: 0010:vxlan_xmit+0xb58/0x15f0
> [...]
> Call Trace:
>   <TASK>
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
> 
>   ip nexthop add id 1 via 192.0.2.2 fdb
>   ip nexthop add id 10 group 1 fdb
> 
>   ip link add name vx0 up type vxlan id 10010 local 192.0.2.1 dstport 4789 proxy
> 
>   ip neigh add 192.0.2.3 lladdr 00:11:22:33:44:55 nud perm dev vx0
> 
>   bridge fdb add 00:11:22:33:44:55 dev vx0 self static nhid 10
> 
>   arping -b -c 1 -s 192.0.2.1 -I vx0 192.0.2.3
> 
> [3]
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> [...]
> CPU: 13 UID: 0 PID: 372 Comm: ndisc6 Not tainted 6.17.0-rc2-virtmne-g6ee90cb26014 #3 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1v996), BIOS 1.17.0-4.fc41 04/01/2x014
> RIP: 0010:vxlan_xmit+0x803/0x1600
> [...]
> Call Trace:
>   <TASK>
>   dev_hard_start_xmit+0x5d/0x1c0
>   __dev_queue_xmit+0x246/0xfd0
>   ip6_finish_output2+0x210/0x6c0
>   ip6_finish_output+0x1af/0x2b0
>   ip6_mr_output+0x92/0x3e0
>   ip6_send_skb+0x30/0x90
>   rawv6_sendmsg+0xe6e/0x12e0
>   __sock_sendmsg+0x38/0x70
>   __sys_sendto+0x126/0x180
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0xa4/0x260
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f383422ec77
> 
> [4]
>   #!/bin/bash
> 
>   ip address add 2001:db8:1::1/128 dev lo
> 
>   ip nexthop add id 1 via 2001:db8:1::1 fdb
>   ip nexthop add id 10 group 1 fdb
> 
>   ip link add name vx0 up type vxlan id 10010 local 2001:db8:1::1 dstport 4789 proxy
> 
>   ip neigh add 2001:db8:1::3 lladdr 00:11:22:33:44:55 nud perm dev vx0
> 
>   bridge fdb add 00:11:22:33:44:55 dev vx0 self static nhid 10
> 
>   ndisc6 -r 1 -s 2001:db8:1::1 -w 1 2001:db8:1::3 vx0
> 
> Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_core.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 0f6a7c89a669..dab864bc733c 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1877,6 +1877,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
>   	n = neigh_lookup(&arp_tbl, &tip, dev);
>   
>   	if (n) {
> +		struct vxlan_rdst *rdst = NULL;
>   		struct vxlan_fdb *f;
>   		struct sk_buff	*reply;
>   
> @@ -1887,7 +1888,9 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
>   
>   		rcu_read_lock();
>   		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
> -		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
> +		if (f)
> +			rdst = first_remote_rcu(f);
> +		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
>   			/* bridge-local neighbor */
>   			neigh_release(n);
>   			rcu_read_unlock();
> @@ -2044,6 +2047,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
>   	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, dev);
>   
>   	if (n) {
> +		struct vxlan_rdst *rdst = NULL;
>   		struct vxlan_fdb *f;
>   		struct sk_buff *reply;
>   
> @@ -2053,7 +2057,9 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
>   		}
>   
>   		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
> -		if (f && vxlan_addr_any(&(first_remote_rcu(f)->remote_ip))) {
> +		if (f)
> +			rdst = first_remote_rcu(f);
> +		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
>   			/* bridge-local neighbor */
>   			neigh_release(n);
>   			goto out;

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


