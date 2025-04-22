Return-Path: <netdev+bounces-184635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3B2A9694D
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798C33BBEBE
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E2D27D773;
	Tue, 22 Apr 2025 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwGN9cOH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505A27D77E
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324834; cv=none; b=M/P6o9EZ3Mt0pbHqWhb13iGTCXZ89ZWFUHUXTWvOS3N4s5xr4RNqalzGQccQYAMubll8VBwBAOFAwTqD0u4xFE2bIM3qsTvFjRiJd1FPzEtBO7F84fwttKcVh9RMtSa9p/VyzrDrcPHMPdFxSiVyQ5+y2+kzUt2ffCslaFjosno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324834; c=relaxed/simple;
	bh=LXeGa/WI1F7kTOziXlM9CaLkFCqaM9QXpCE2Kz1GK8M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EvWYXnEol3kuWE69UsJFY3+SOyl7gKjtv2Qxy026dLL/6SWZF0JKMAqNI3i+XinlJuSiV+FwjtJyw7AqJwaKUa4KP8M1CCBEDNHBN+H2EPXKxkpDc9xQCqAjJm3mw5gOfvuzMAVRhZ2r/zr1h3BvMN2V9QDyQVbTlpcctsHEOMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwGN9cOH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476a304a8edso52603131cf.3
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745324831; x=1745929631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyrGerPo8zYvhdaWH7ZlcaRCmQF1Afq3zqQZGUKcrHQ=;
        b=ZwGN9cOH7LF8NFqp5BA+IRRDQ/qTLVEXlFRFtWTJmVMDDXybpWM4y+UgUsHBeCgVIL
         LuRFj+77UdTn/zJgnRblw4EJu8+gZxfZRznKc/S08NbVldiTddVRl0kycl3F1j7OIo8D
         BzxQ9DMoW41RiYnpqeu2ZKOHE/wmG7mspfvCEBBeueYnuzEYosHyZELyId25kS5E2Gwc
         fFREXKOoR54Vi3mxRDecN9mVyLWzf6M88gLAhWlf4CtaATaDxSbMQehxabXVHq9SM59V
         Smxvr64woCk/mw2/VfG2TcH+4SNasvl22Xdx5HBA6cOanVEVtPRLkGDBKB6qrdHEthrP
         OewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745324831; x=1745929631;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wyrGerPo8zYvhdaWH7ZlcaRCmQF1Afq3zqQZGUKcrHQ=;
        b=HqOaUD7ztBIJXjGE4UcEVJHnjtTYVTJMFRZ1yBG7/VtlMpF8VArdxUPaJytk63IL/y
         a+wib/vSxT8OUAUUgeYScrzTaGzzBoJbDmXbynW9FyaHNa60W0jlJPxB9B/9O5YQtu85
         Oy18IeV5sVkeb+AOzKhUwAfTBzoqmVEPLcqajH3EkRBJ/+LmR8Pg9erHzUUc4liO7Fkw
         c8moveYErRcotD1kplyZsfjFdWVspC95Syy6YR5TqBJ/KA3DbTkPbLYsbVqUi7ipzwbA
         BPrBT9pKIjimv6lHJ9s/lp9cxggRAN9pRKfSD1qxvdIiWhc6ywxd5OosBSn6Ciu1iyAY
         uqZw==
X-Gm-Message-State: AOJu0Yxzgz//sV4GCPL20zMchpStDJ1ElAlDJBFnUXgd1q9WiiH6R5iZ
	zf68upDRK/YqcD2wB3b4L27tLXJbORYMfBwfBbUfcoVXEyBDZ2l+
X-Gm-Gg: ASbGnctthUhgyPkInGVF4XbCkYAD8AoE2azFBVU3WDA1T+MP7LoxQyBCKP62LCvOnoj
	IgPRuZwacI99mlQDJCInbcndSOzribyCVfyb63dU/mFZBuWkf2/+ZyWmyy+t7/mmQkUMYnLZoFW
	HNhT88/u7khOWtUaIRXpKV0kUIzQwVnIX9ahZC6zjERDuvQL79aGEmQkIuKn7Ije7+UqZs9C4rL
	tcFaOSMAM6sglpTS42v0W/8dvfR4ZoAsRuTTnLoWfdNvB+j9XQ1zNuzXsMQ/QVdmhin1ZxeYkEx
	uOsM5eqW9OGUO7WC/CqPcnl7B+6OVOfia3brWHkWnHVUIETUN4A2/0PC5xPlVPT7tK+5dhSgcbo
	UWSdh/HNXyq9q6NpUmxud
X-Google-Smtp-Source: AGHT+IHdSptXehMe95/WqFHPGqdNlzhBzqLChjfnE/nTvwK8vtSZbVXgMlGDeYnhfsvTUvpFws5H2g==
X-Received: by 2002:a05:622a:3:b0:477:6ef6:12f with SMTP id d75a77b69052e-47aec369f45mr288187061cf.3.1745324831513;
        Tue, 22 Apr 2025 05:27:11 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ae9cf7357sm55373011cf.66.2025.04.22.05.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 05:27:10 -0700 (PDT)
Date: Tue, 22 Apr 2025 08:27:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qiyu Yan <yanqiyu17@mails.ucas.ac.cn>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Message-ID: <68078b1e6d1a5_396ca0294b4@willemb.c.googlers.com.notmuch>
In-Reply-To: <af01ddc5-82bc-4376-9874-e465bf5424f7@mails.ucas.ac.cn>
References: <af01ddc5-82bc-4376-9874-e465bf5424f7@mails.ucas.ac.cn>
Subject: Re: DNAT'ed traffic from ConnectX-4 card triggers "hw csum failure"
 on veth interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qiyu Yan wrote:
> Hi all,
> =

> Apologies for the broad CC=E2=80=94I'm unsure which component is relate=
d to the =

> issue, but I've gathered more details since my last report.
> =

> After boot or after resetting the WARN_ONCE flag, I consistently observ=
e =

> the following in `dmesg`:
> =

> eth0: hw csum failure
> skb len=3D52 headroom=3D98 headlen=3D52 tailroom=3D1578
> mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
> csum(0x98009d14 start=3D40212 offset=3D38912 ip_summed=3D2 complete_sw=3D=
0 =

> valid=3D0 level=3D0)
> hash(0x2135374 sw=3D0 l4=3D1) proto=3D0x0800 pkttype=3D0 iif=3D2
> priority=3D0x0 mark=3D0x0 alloc_cpu=3D20 vlan_all=3D0x0
> encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0, trans=3D0)
> dev name=3Deth0 feat=3D0x000061164fdd09e9
> skb headroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=

> skb headroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=

> skb headroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=

> skb headroom: 00000030: ba d7 32 44 dd 39 7e b7 bb bd 2e d5 88 e5 2d 00=

> skb headroom: 00000040: 9e 52 9b 58 46 89 aa 93 51 02 83 7e 08 00 45 00=

> skb headroom: 00000050: 00 48 d3 6d 00 00 3f 11 93 48 0a 00 00 7a 0a 58=

> skb headroom: 00000060: 00 1e
> skb linear:=C2=A0=C2=A0 00000000: e2 e4 00 35 00 34 92 e9 f4 39 01 00 0=
0 01 00 00
> skb linear:=C2=A0=C2=A0 00000010: 00 00 00 00 06 72 65 70 6f 72 74 07 6=
d 65 65 74
> skb linear:=C2=A0=C2=A0 00000020: 69 6e 67 07 74 65 6e 63 65 6e 74 03 6=
3 6f 6d 00
> skb linear:=C2=A0=C2=A0 00000030: 00 01 00 01
> ... large tailroom
> CPU: 20 UID: 0 PID: 0 Comm: swapper/20 Tainted: G OE=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =

> 6.14.2-300.fc42.x86_64 #1
> Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./EPYCD8, =

> BIOS L2.52 11/25/2020
> Call Trace:
>  =C2=A0<IRQ>
>  =C2=A0dump_stack_lvl+0x5d/0x80
>  =C2=A0__skb_checksum_complete+0xeb/0x110
>  =C2=A0? __pfx_csum_partial_ext+0x10/0x10
>  =C2=A0? __pfx_csum_block_add_ext+0x10/0x10
>  =C2=A0udp4_csum_init+0x1dc/0x2f0
>  =C2=A0__udp4_lib_rcv+0xc8/0x750
>  =C2=A0? srso_return_thunk+0x5/0x5f
>  =C2=A0? raw_v4_input+0x14a/0x270
>  =C2=A0ip_protocol_deliver_rcu+0xcb/0x1a0
>  =C2=A0ip_local_deliver_finish+0x76/0xa0
>  =C2=A0ip_local_deliver+0xfa/0x110
>  =C2=A0__netif_receive_skb_one_core+0x87/0xa0
>  =C2=A0process_backlog+0x87/0x130
>  =C2=A0__napi_poll+0x31/0x1b0
>  =C2=A0? srso_return_thunk+0x5/0x5f
>  =C2=A0net_rx_action+0x333/0x420
>  =C2=A0handle_softirqs+0xf2/0x340
>  =C2=A0? srso_return_thunk+0x5/0x5f
>  =C2=A0? srso_return_thunk+0x5/0x5f
>  =C2=A0__irq_exit_rcu+0xcb/0xf0
>  =C2=A0common_interrupt+0x85/0xa0
>  =C2=A0</IRQ>
>  =C2=A0<TASK>
>  =C2=A0asm_common_interrupt+0x26/0x40
> RIP: 0010:cpuidle_enter_state+0xcc/0x660
> Code: 00 00 e8 67 28 fb fe e8 d2 ed ff ff 49 89 c4 0f 1f 44 00 00 31 ff=
 =

> e8 73 61 f9 fe 45 84 ff 0f 85 02 02 00 00 fb 0f 1f 44 00 00 <85> ed 0f =

> 88 d3 01 00 00 4c 63 f5 49 83 fe 0a 0f 83 9f 04 00 00 49
> RSP: 0018:ffffa79d003afe50 EFLAGS: 00000246
> RAX: ffff96440ca00000 RBX: ffff962542b89800 RCX: 0000000000000000
> RDX: 000051a9557f7bf1 RSI: 000000003152c088 RDI: 0000000000000000
> RBP: 0000000000000002 R08: ffffffee4d207359 R09: ffff96440ca315e0
> R10: 000051bb10ea059b R11: 0000000000000000 R12: 000051a9557f7bf1
> R13: ffffffffa7b15160 R14: 0000000000000002 R15: 0000000000000000
> =

>  From inspecting the SKB, the packet comes from a host (10.0.0.122) =

> connected via a ConnectX-4 Lx NIC to our server. It is DNAT'ed via =

> iptables from 10.0.0.1:53 to a container at 10.88.0.30:53.
> =

> Traffic path:
> =

>  =C2=A0=C2=A0=C2=A0 10.0.0.122 --> [CX4 NIC 10.0.0.1/16]
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 iptables DNAT (10.0.0.1:53 -> 10.88.0.30:53)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [linux bridge (podman0 10.88.0.1/16)]
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [veth pair]
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [eth0 inside container]
> =

> The warning is triggered when the packet arrives at eth0 inside the =

> container.
> =

> What's suspicious is the reported checksum info:
> =

>  =C2=A0=C2=A0=C2=A0 csum(0x9800a314 start=3D41748 offset=3D38912 ip_sum=
med=3D2 ...)
> =

> Here, start and offset are far beyond the size of the skb. This seems =

> like an invalid buffer?

No, these fields are a union. With CHECKSUM_COMPLETE, you can ignore
those values

        union { =

                __wsum          csum;
                struct {
                        __u16   csum_start;
                        __u16   csum_offset;
                };
        };

> And I suspect that during DNAT and/or forwarding =

> through the bridge and veth, the checksum status is not properly cleare=
d =

> or recalculated.

That sounds most likely. Something in the path pushing or pulling or
modifying a header without updating skb->csum correctly.

You can try capturing the packet earlier in the receive path in the init
namespace. Or capture and log it along more points using bpftrace
instead of tcpdump.

> The NIC is:
> $ ethtool -i mlx-p1
> driver: mlx5_core
> version: 6.14.2-300.fc42.x86_64
> firmware-version: 14.32.1900 (MT_2420110034)
> expansion-rom-version:
> bus-info: 0000:c1:00.1
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: no
> supports-register-dump: no
> supports-priv-flags: yes
> =

> =

> Best,
> Qiyu
> =




