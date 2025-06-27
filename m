Return-Path: <netdev+bounces-201953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF0FAEB907
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB434A0BE4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B96D269CF0;
	Fri, 27 Jun 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="gjs5h5J9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DD58460
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751031204; cv=none; b=ZBXtH4EiJ5Ys36FPSN7E2GpF3lwDCQgDeeXUQOU4au8ZVaGUg8gZX8z97UidwrJs5Nv54BWhE13C5kCak6ecMJZi7mKs5mP0UD2lQ1Do+DNKHez5doZPIrlIppIHvOgVHC+FkYdj2ngY/DZns9LXHl7ONDe0t8LOStTV0Z3gNh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751031204; c=relaxed/simple;
	bh=nuDL8uOXmOwnr1R9VZk1TlZ9XHESg2IYOkSnc4XoY7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/FVScSMxZfQO40rjaB3JbPReirmwofh7vuU7gMvnuRAZwtek8Q6w4J0rGt7Pouaamr4VpAg6qvnTl6OR3H1SbbGPAh3jit/ucNsmCdIHGM19Q+Xml5mE2eoFikg2gHhHEiXlLNkw5G/t9WXkX9aK85lW/hUc5onfA5KEOsuCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=gjs5h5J9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so3680220a12.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 06:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1751031201; x=1751636001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fC8ctkh8Z5OzSSyR1DkWnfj9Z3KeLFKI5XeDIF5nb3c=;
        b=gjs5h5J9lnLWq6vaKmzi2iBE1izco9TeXjptVvBMlWdx7pIv5/lfxTnRk37dDjyp8M
         VkD07VOZXmmVn9ge0r9XhGHXJYBxxCj/xdDcAx0do846ZKM/XqcFXlpbLP7NoKhYy7BA
         /S9xp0QxH7IUXiw5XCb7ZJNPEKALhqCGEF+GC1rXyF37E1ZdL74t3VQM3qHoL3rGnjo/
         EGEjM8LwTr2KXPKIaTi6AMdt6dRbMHSOBYudlcv7bocJNlZ8qDKvLHTaGgXhpasetc8V
         uUzNZ1vLxsRnvc0E/eSU37+Del+8Fq6X3ZmRBObe+W+nagSyVkKZ+h3Kn9tpUTVjkuy2
         /+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751031201; x=1751636001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fC8ctkh8Z5OzSSyR1DkWnfj9Z3KeLFKI5XeDIF5nb3c=;
        b=cfGYJUOsksWuA1io1QB01tF4mgTuc9c4R6wnITktS8ZP+BgZpRSqmdbkwDLSsc2uUQ
         5kAok7zlq7/7hKkDy1K4Ye2IPt7uImsOY4cvpK8tsd3xx9Knrj20QrMFMPGgWCHk1Gah
         wL8cenSbBGHW/H92deFFqioVKakBuRqzVIkugNQTiWWSryIBfJfpldGuiTHzvSrQxqRd
         kaJGxSnE2xtwP+NoAoltL2v3lFIGnsDYCH/EwgqH9DWM4WFyIaWtor6sJfcAZCxhu6bX
         segGaMjhZ07yrWK4oUGCmQhKZknUJj8QIvLRkP110xUe96oW58e77oJIpRS8Y/r1vdA/
         qzBA==
X-Forwarded-Encrypted: i=1; AJvYcCVlaJYmqITiZnV88JwrwRVgtYr3caEWZUR++TyHMS44FpLCrtRK3Tt27PKcSXIv4j7KVkyDXYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrbSwdtGA33fR6UmSx6+x9fLmuylhez867m/SSNPpV7gefhdY
	2ldFGtgmBhPDHwGbGqiCoRJgNb2njRKH1RxAFdmkIJqwrC8Fxf8N8+qEbaNNPve8NHYh7knthIT
	La2BO
X-Gm-Gg: ASbGnctlVEnEN+FLW6CcrBSe/wEs16ebH/D601CPzYsM529DJ9a056XG6qlBBNwDPJj
	/LBl2b1qC+1gIZtZzizPEqk4QPMpGJrEJkwJNHKG3b9L/nrmkm9WYmNJbEU1loGy1H4aGeuyU/X
	7jqq3pHxj1ESyesIzFrAiWLFF0uvyKAI5zkjLEWfHXe5XASPGnwDG45SOiuXIJCtqkAgLncSwYF
	ulHwYOMR8yKDTJo3TJbqGlPhNMh3XEmPSMsSbLAMU1KZqrjBQLbWcmkOo1NwpnGQw8h2XbOfxy8
	b6sVeJJHHy0bM8AZ2Jn1+BM1qLzrhcGJhA6ZR2TXYZoAVX5+sIvCSYUHnTrBQ6HO7fmj30/3Sh8
	qmnSkqlclcgvE6upkgQ==
X-Google-Smtp-Source: AGHT+IHhNvsh0K8t7ydoLwP5KSQZNEkGW6f76iDXty3Yt2D2To+eO9K0YaFt5h+3tQBJu/PSngzRhg==
X-Received: by 2002:a05:6402:5110:b0:607:f082:583a with SMTP id 4fb4d7f45d1cf-60c88e65b77mr2962419a12.27.1751031200483;
        Fri, 27 Jun 2025 06:33:20 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c831d5fecsm1485517a12.63.2025.06.27.06.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 06:33:19 -0700 (PDT)
Message-ID: <ac869b58-4534-464d-a661-3d70b0ae2d1d@blackwall.org>
Date: Fri, 27 Jun 2025 16:33:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ipv4: guard ip_mr_output() with rcu
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+f02fb9e43bd85c6c66ae@syzkaller.appspotmail.com,
 Petr Machata <petrm@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>,
 Benjamin Poirier <bpoirier@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
References: <20250627114641.3734397-1-edumazet@google.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250627114641.3734397-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 14:46, Eric Dumazet wrote:
> syzbot found at least one path leads to an ip_mr_output()
> without RCU being held.
> 
> Add guard(rcu)() to fix this in a concise way.
> 
> WARNING: CPU: 0 PID: 0 at net/ipv4/ipmr.c:2302 ip_mr_output+0xbb1/0xe70 net/ipv4/ipmr.c:2302
> Call Trace:
>  <IRQ>
>   igmp_send_report+0x89e/0xdb0 net/ipv4/igmp.c:799
>  igmp_timer_expire+0x204/0x510 net/ipv4/igmp.c:-1
>   call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
>   expire_timers kernel/time/timer.c:1798 [inline]
>   __run_timers kernel/time/timer.c:2372 [inline]
>   __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
>   run_timer_base kernel/time/timer.c:2393 [inline]
>   run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
>   handle_softirqs+0x286/0x870 kernel/softirq.c:579
>   __do_softirq kernel/softirq.c:613 [inline]
>   invoke_softirq kernel/softirq.c:453 [inline]
>   __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
>   irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
>   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
>   sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
> 
> Fixes: 35bec72a24ac ("net: ipv4: Add ip_mr_output()")
> Reported-by: syzbot+f02fb9e43bd85c6c66ae@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/685e841a.a00a0220.129264.0002.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Benjamin Poirier <bpoirier@nvidia.com>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/ipmr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index f78c4e53dc8c161e334781970bbff6069c084ebb..3a2044e6033d5683bda678489f6eaf72ea0b8890 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -2299,7 +2299,8 @@ int ip_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	struct mr_table *mrt;
>  	int vif;
>  
> -	WARN_ON_ONCE(!rcu_read_lock_held());
> +	guard(rcu)();

Interesting construct. :)

> +
>  	dev = rt->dst.dev;
>  
>  	if (IPCB(skb)->flags & IPSKB_FORWARDED)
> @@ -2313,7 +2314,6 @@ int ip_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	if (IS_ERR(mrt))
>  		goto mc_output;
>  
> -	/* already under rcu_read_lock() */
>  	cache = ipmr_cache_find(mrt, ip_hdr(skb)->saddr, ip_hdr(skb)->daddr);
>  	if (!cache) {
>  		vif = ipmr_find_vif(mrt, dev);

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


