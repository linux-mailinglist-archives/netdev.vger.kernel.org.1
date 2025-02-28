Return-Path: <netdev+bounces-170690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080D1A499CF
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA161714D3
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C11625E471;
	Fri, 28 Feb 2025 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="MiytRM0G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665B8468
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746955; cv=none; b=OBttQzYU15uKNWntAc0EMBWApqCsGC2tjF9VKf+w0ksmM0SDcYKtw44eIFIbwgeaah+WQ3EvzHu8TvCJ/CYO7Lyng352Q/jElPYDxz/q+PdQP8wIJcFvzsda3oncRnbjHM91NIp41R2aaeBWkyfVWRJ9MUJ4iy7ZUfB+mYUWkGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746955; c=relaxed/simple;
	bh=5RpGm56R6lP4zLUi9RPNV1I6/++bOY8kPpfU1JKwEfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8AzeNBxq1OtixD/d96OGNZDnKhmbLn0cDiL7UsWRVT+vHAszXNyskGl+97960It5esNMAJ1RXRlA0U4lHoFHTmNHCcZunOGcqtg4/Go2mNEHTZIBF47k1Ord+GLo/cWo+dshi/FynAQogQVoXmQwzr3x2+zCS5nJ5q1SFNfcZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=MiytRM0G; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390f5f48eafso40602f8f.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740746952; x=1741351752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pij7v4Zm+NozALn34TnSluTdWZ/fk/YEUQHrHLnzYyQ=;
        b=MiytRM0Gjb8xL8LOp0lHhNKyf5BaDQJqcuBOYlTJ9Y7k4wnERjtQuMMSWFtOaTgSnb
         cms2dfqIivpK3kxxfiuD1O8F+S8Vn3RnHHHTCt0h6UqkT7rxbEWduzQGJfJWhaCpqJq+
         johw1oSAGyMnyYPFKn7AxtiDADXV7jFFgau0WFjh/pqRl/ACLF7Um8It52YSplw6K6gm
         3iPUCOhodzWA3mHbdkm6Lx0FqmpSoXhdjq4eUpqBX2XVt5OpdJ7l63jeyIfdt8P9LF55
         VFxziJ7q3TZfGm8mgQpOmrowORrSMYQMkdKLuBJFhw0/Nh6cV6BGGc5THnzxOpax8yEZ
         M1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746952; x=1741351752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pij7v4Zm+NozALn34TnSluTdWZ/fk/YEUQHrHLnzYyQ=;
        b=WthquSXviZ1QzeGK/vsa4c8Lcatc3uciOmiS8hfuc6Dn+7MzS5pTxM3wIcHbcwaAXt
         V2B+lQTcucAxb9f4LVNJOfOUu6DV3RB7dYDljeHLh7+ZbBd4l2JUUNjZDYuXq2zPq+9U
         7bgL8XspkUSxVUAO8zm9ICIBimHlSjTb11YVaV13d6tVJHbFdZydhgjU4+rsD1KK62XC
         NFend7NoAaj5bajOamgoCfmS1J/oGL82Kv6N7PbH9vFdzjx2xHUyCDOVzv3T5Q6jL5qd
         qWx/yeMNx4T+lrz9acV0gELPtWwsFvm6SIOXdBxl6mYMeaO1oS24wPU0Ftr5FzZhIAet
         6O7g==
X-Gm-Message-State: AOJu0YxcphouZdUZaPle1/mT7aakikpFyXpQbd9cnyPtpy1/Hgw2lcLz
	DJ894yyGCfecpchq9PHZJt0jouwfk8eBLQ3aRDledLiGVfWG7qVUYbH992xB84A=
X-Gm-Gg: ASbGncuRNXNsfLsyYTvvqjm4aksAwWKZOOYYMJeGMTtCqX14oMDvAlvvD4AqjNiKjYu
	rEoSuu9CLpV63S/uSOKqfT0nzr7G2ywS7s8Afm3II9xvgdZvQhREqeW2+z26r84eFMemUxIPtJv
	y3s46bJ11xVj69bT16IzxO7ZG7nMzV3/kfW9/L4H3Bw9CWClr5K2Tgo8JqZB5UcXG6M2owV0ujx
	dZ9O1gqGQ8gmU9FVpp/DIIuY2YZkPuZqb1XkJ3m6U5pJFWR/hmMHV2BqMk/u1hvgSlHObjVj+My
	45JFAjh/wlvTOuHR1vzaShgIdzmXoxJFQdjT7zFjRRug4IWFDESFlkY0rg==
X-Google-Smtp-Source: AGHT+IHhInGd80h212ogfFtEXE+0Qm/6sWbZsWhaduwRp1wvstQ2jeXFVIxYmVjrNCluMrtJZ64qZA==
X-Received: by 2002:a5d:47a3:0:b0:38f:4493:e274 with SMTP id ffacd0b85a97d-390eca26c22mr2937081f8f.54.1740746951466;
        Fri, 28 Feb 2025 04:49:11 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a4asm5178620f8f.34.2025.02.28.04.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 04:49:10 -0800 (PST)
Message-ID: <8f1cba95-bedb-4f96-958d-c4f28982bdf2@blackwall.org>
Date: Fri, 28 Feb 2025 14:49:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] be2net: fix sleeping while atomic bugs in
 be_ndo_bridge_getlink
To: Ian Kumlien <ian.kumlien@gmail.com>
Cc: netdev@vger.kernel.org, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 edumazet@google.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20250227164129.1201164-1-razor@blackwall.org>
 <CAA85sZva1SbT_HDbAHgZEDeCgjcbTX_rBzj-RZQmsvST3Ky3LA@mail.gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAA85sZva1SbT_HDbAHgZEDeCgjcbTX_rBzj-RZQmsvST3Ky3LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/28/25 14:46, Ian Kumlien wrote:
> Actually, while you might already have realized this, I didn't quite
> understand how important this fix seems to be....
> 

You mean the be2net would send broken packets to this other machine with mlx5 card?
Or did I misunderstand you?

> From another machine i found this:
> [lör feb 22 23:46:32 2025] mlx5_core 0000:02:00.1 enp2s0f1np1: hw csum failure
> [lör feb 22 23:46:32 2025] skb len=2488 headroom=78 headlen=1480 tailroom=0
>                             mac=(64,14) mac_len=14 net=(78,20) trans=98
>                             shinfo(txflags=0 nr_frags=0 gso(size=1452
> type=393216 segs=2))
>                             csum(0x2baef95d start=63837 offset=11182
> ip_summed=2 complete_sw=0 valid=0 level=0)
>                             hash(0xb9a84019 sw=0 l4=1) proto=0x0800
> pkttype=0 iif=8
>                             priority=0x0 mark=0x0 alloc_cpu=1 vlan_all=0x0
>                             encapsulation=0 inner(proto=0x0000, mac=0,
> net=0, trans=0)
> [lör feb 22 23:46:32 2025] dev name=enp2s0f1np1 feat=0x0e12a1c21cd14ba9
> 
> And:
> [lör feb 22 23:46:33 2025] skb fraglist:
> [lör feb 22 23:46:33 2025] skb len=1008 headroom=106 headlen=1008 tailroom=38
>                             mac=(64,14) mac_len=14 net=(78,20) trans=98
>                             shinfo(txflags=0 nr_frags=0 gso(size=0
> type=0 segs=0))
>                             csum(0x86f9 start=34553 offset=0
> ip_summed=2 complete_sw=0 valid=0 level=0)
>                             hash(0xb9a84019 sw=0 l4=1) proto=0x0800
> pkttype=0 iif=0
>                             priority=0x0 mark=0x0 alloc_cpu=1 vlan_all=0x0
>                             encapsulation=0 inner(proto=0x0000, mac=0,
> net=0, trans=0)
> [lör feb 22 23:46:33 2025] dev name=enp2s0f1np1 feat=0x0e12a1c21cd14ba9
> 
> Including:
> [lör feb 22 23:46:34 2025] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not
> tainted 6.13.4 #449
> [lör feb 22 23:46:34 2025] Hardware name: Supermicro Super
> Server/A2SDi-12C-HLN4F, BIOS 1.9a 12/25/2023
> [lör feb 22 23:46:34 2025] Call Trace:
> [lör feb 22 23:46:34 2025]  <IRQ>
> [lör feb 22 23:46:34 2025]  dump_stack_lvl+0x47/0x70
> [lör feb 22 23:46:34 2025]  __skb_checksum_complete+0xda/0xf0
> [lör feb 22 23:46:34 2025]  ? __pfx_csum_partial_ext+0x10/0x10
> [lör feb 22 23:46:34 2025]  ? __pfx_csum_block_add_ext+0x10/0x10
> [lör feb 22 23:46:34 2025]  nf_conntrack_udp_packet+0x171/0x260
> [lör feb 22 23:46:34 2025]  nf_conntrack_in+0x391/0x590
> [lör feb 22 23:46:34 2025]  nf_hook_slow+0x3c/0xf0
> [lör feb 22 23:46:34 2025]  nf_hook_slow_list+0x70/0xf0
> [lör feb 22 23:46:34 2025]  ip_sublist_rcv+0x1ee/0x200
> [lör feb 22 23:46:34 2025]  ? __pfx_ip_rcv_finish+0x10/0x10
> [lör feb 22 23:46:34 2025]  ip_list_rcv+0xf8/0x130
> [lör feb 22 23:46:34 2025]  __netif_receive_skb_list_core+0x24c/0x270
> [lör feb 22 23:46:34 2025]  netif_receive_skb_list_internal+0x18f/0x2b0
> [lör feb 22 23:46:34 2025]  ? mlx5e_handle_rx_cqe_mpwrq+0x116/0x210
> [lör feb 22 23:46:34 2025]  napi_complete_done+0x65/0x260
> [lör feb 22 23:46:34 2025]  mlx5e_napi_poll+0x172/0x760
> [lör feb 22 23:46:34 2025]  __napi_poll+0x26/0x160
> [lör feb 22 23:46:34 2025]  net_rx_action+0x173/0x300
> [lör feb 22 23:46:34 2025]  ? notifier_call_chain+0x54/0xc0
> [lör feb 22 23:46:34 2025]  ? atomic_notifier_call_chain+0x30/0x40
> [lör feb 22 23:46:34 2025]  handle_softirqs+0xcd/0x270
> [lör feb 22 23:46:34 2025]  irq_exit_rcu+0x85/0xa0
> [lör feb 22 23:46:34 2025]  common_interrupt+0x81/0xa0
> [lör feb 22 23:46:34 2025]  </IRQ>
> [lör feb 22 23:46:34 2025]  <TASK>
> [lör feb 22 23:46:34 2025]  asm_common_interrupt+0x22/0x40
> [lör feb 22 23:46:34 2025] RIP: 0010:cpuidle_enter_state+0xbc/0x430
> [lör feb 22 23:46:34 2025] Code: 77 02 00 00 e8 65 31 ec fe e8 60 f8
> ff ff 49 89 c5 0f 1f 44 00 00 31 ff e8 a1 68 eb fe 45 84 ff 0f 85 49
> 02 00 00 fb 45 85 f6 <0f> 88 8d 01 00 00 49 63 ce 4c 8b 14 24 48 8d 04
> 49 48 8d 14 81 48
> [lör feb 22 23:46:34 2025] RSP: 0018:ffffb504000b7e88 EFLAGS: 00000202
> [lör feb 22 23:46:34 2025] RAX: ffff9c0a2fa40000 RBX: ffff9c0a2fa76e60
> RCX: 0000000000000000
> [lör feb 22 23:46:34 2025] RDX: 0000252e1dcfee30 RSI: fffffff3c1a65ecc
> RDI: 0000000000000000
> [lör feb 22 23:46:34 2025] RBP: 0000000000000002 R08: 0000000000000000
> R09: 00000000000001f6
> [lör feb 22 23:46:34 2025] R10: 0000000000000018 R11: ffff9c0a2fa6c3ac
> R12: ffffffffaac2de60
> [lör feb 22 23:46:34 2025] R13: 0000252e1dcfee30 R14: 0000000000000002
> R15: 0000000000000000
> [lör feb 22 23:46:34 2025]  ? cpuidle_enter_state+0xaf/0x430
> [lör feb 22 23:46:34 2025]  cpuidle_enter+0x24/0x40
> [lör feb 22 23:46:34 2025]  do_idle+0x16e/0x1b0
> [lör feb 22 23:46:34 2025]  cpu_startup_entry+0x20/0x30
> [lör feb 22 23:46:34 2025]  start_secondary+0xf3/0x100
> [lör feb 22 23:46:34 2025]  common_startup_64+0x13e/0x148
> [lör feb 22 23:46:34 2025]  </TASK>
> ---
> 
> Asking gemini for help identified the machine in the basement as the
> culprit - so it seems like it could send corrupt data - i haven't had
> a closer look though
> 

Interesting. :)

> On Thu, Feb 27, 2025 at 5:41 PM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>

