Return-Path: <netdev+bounces-179468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C625CA7CE71
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 16:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A25316CE6D
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 14:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB0420E6E4;
	Sun,  6 Apr 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Str6PcqF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E73B148FE6
	for <netdev@vger.kernel.org>; Sun,  6 Apr 2025 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743950135; cv=none; b=gCRIBn2GKk02j1kA9O32Lx6OvFxqP+vwivUhM5TAcmY/Uih7y8RMF8IztwSY5UvHT0NAsJw1/GAoezJZDc6nGR1byBpUKrpJg2v50BoY7JNCNHeKtGSIh9s6ww54UU4c2G4cplMCt/V50/7awOwbiOfFk5/G3JpfgnLR5ZA7rY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743950135; c=relaxed/simple;
	bh=YZRPRZzxre67DgJ8e5gyHyqB8Kavxwpt8vuQietdmZw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=K+uUUoPwpXwSw1gdYcf81EdHNaApvfcKpIboQeL6IdGW/6mHC9f5nxC7E49yQz7E66r4h/bGMIBavrSvZeV7aHmU9VeMFgLb9tK+G2Z8I+pkVpsesk9jAykK43lu4+COdCyAJ1Hbn0l0EJwKIi7EYxq55SRAf6AfGv3vVDjRZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Str6PcqF; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2a01bcd0143so4367722fac.2
        for <netdev@vger.kernel.org>; Sun, 06 Apr 2025 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743950132; x=1744554932; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mW56pR20aWKznqho+6Lt3iwbdeK2PmwncQdioEFxuhk=;
        b=Str6PcqFFQsuAATR5kWLy6qQVq9ap1MUSmSSC6Eb8M47t2g3COWU2lxCWhNYzkfrXg
         o6eNzJSQJ4kJZp5UP5iftcfGy7FCyC8OUkAkmxPMjzeCTWdCC5mgXAueVJ3598+8LGoF
         Wl9JToTHlklcMf9UspXqHZl1dWXI1yrC4g9gvoekFDQjhrhv1zlFtuZ0FvfWC/5HY+U4
         LaiLlx23SxMdvvyYGFt0Dif8ID4vMbu834oxPuF20NkhP9V3ujYj0J0kYYWwlvC3H0Vp
         PkZ+1vT/kksvbmMxpgjQapH5v1vz5ZpIcLMW+SVB6mOvJNaOw4BCgPm6vVn1Es2pGENu
         p7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743950132; x=1744554932;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mW56pR20aWKznqho+6Lt3iwbdeK2PmwncQdioEFxuhk=;
        b=BZ9m48bpv6xSD9Mt5yMhTXBa9GEPaAlnH92kJR9+Y7BHgFlfqqRx9/MuHFFAi4RkGk
         llyc84W5ad5f88b8jY8ilpeCbv5/4wyrXdhUFozmFCfE+zfu55jx/H+rrim1FTXUmgO+
         jIwaQmjMQMu8i5Ium3rTK1nFsxUJ7qOAJDjn1WVEQtwo38Vp4buPpVtajXC/Q7M3AtbT
         hDYpLsAy52vYize8ZkRpGoHBdxnEmFmQHeFARMV2oVdxKibqEq3ISaaQdl8XJ2+Ls6O/
         1J4Wh1VCb+Al0LGQ2zutxFcd8wwQRRCVbMGY+rBhuMUU/20FcrTZZ5x+uEV0rYhJ4+yo
         ElVw==
X-Gm-Message-State: AOJu0Yye9x2OJ+CShgjYc2NdTVwon1afIRYZ7EE5zR5mDyKWmFbpv5Iy
	sBmpaXZv7LEm1P6QE89UOZ0RPlJq4ARHC5gQwACb41UUSYd2ucc9EZhWFuOl
X-Gm-Gg: ASbGncsb9Po7q960fG/5HKnd+pTd0lXq9AxahvaivTZbsvjTlOVvJjpbDRbsPnhylmu
	jQ4vWcQb+SrdDFuVStTj/7NYJSm2WU/UD85G7zRhk/NYf1gREmOgDpNRe4GeUEb29YhvgsUFCJ4
	MAWD0T+oskGBJeTZvupzlO8KcJaOD1U4oMfX2HJ9Nhz1Gr/3r8Psk/5VvoO2sxuDxJLboOEyCaD
	vsIB90aTYLqFJwhZYujZNKag9KoTnH9TByWuf8oUjXTWnrp7zh9WItbOdDaA+x7u/h9SevzHAkB
	6WBqLVyaggY8t7HhOB5FN5/FWIZ+JG6BdECiSVRh
X-Google-Smtp-Source: AGHT+IHeIYovDBzmtuETC4znt85mMT58XWcFD7fl/NfjifcZOLFL7l0UPXz8jx2yu6mFTNsRsM3hLA==
X-Received: by 2002:a05:6871:80c8:b0:2c2:5852:72e9 with SMTP id 586e51a60fabf-2cca188f180mr5027468fac.1.1743950132162;
        Sun, 06 Apr 2025 07:35:32 -0700 (PDT)
Received: from [10.0.0.185] ([144.24.8.7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2cc84b26eb2sm1630236fac.33.2025.04.06.07.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 07:35:31 -0700 (PDT)
Message-ID: <36566e86-57df-40f3-80ff-7833f930311d@gmail.com>
Date: Sun, 6 Apr 2025 22:35:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
From: Qiyu Yan <yanqiyu01@gmail.com>
Subject: [bug?] "hw csum failure" warning triggered on veth interface
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear linux network maintainers,

I'm encountering consistent |hw csum failure| warnings during system 
boot. Here's an example from a recent log (running stock kernel 
6.14.0-63.fc42.x86_64 from Fedora 42 pre-release):

[   74.128126] (NULL net_device): hw csum failure
[   74.128149] skb len=545 headroom=98 headlen=545 tailroom=61
                mac=(64,14) mac_len=14 net=(78,20) trans=98
                shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
                csum(0x9edfcad start=64685 offset=2541 ip_summed=2 
complete_sw=0 valid=0 level=0)
                hash(0x5c58e98 sw=0 l4=1) proto=0x0800 pkttype=0 iif=3
                priority=0x0 mark=0x0 alloc_cpu=26 vlan_all=0x0
                encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[   74.128178] skb headroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
[   74.128188] skb headroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
[   74.128197] skb headroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
[   74.128205] skb headroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
[   74.128214] skb headroom: 00000040: 72 30 8d ae 4f 32 e2 a4 be b5 59 
db 08 00 45 00
[   74.128222] skb headroom: 00000050: 02 35 d2 65 40 00 33 06 da 7e a3 
7d eb 05 0a 58
[   74.128230] skb headroom: 00000060: 00 04
[   74.128239] skb linear:   00000000: e5 80 72 46 8c 57 20 0f af 05 eb 
53 50 18 04 04
[   74.128247] skb linear:   00000010: c3 91 00 00 4b 75 31 58 8e c6 71 
48 84 68 65 07
[   74.128255] skb linear:   00000020: fe a6 6f e7 cd 8c 64 a0 4e f6 2b 
f3 eb 61 d7 68
[   74.128263] skb linear:   00000030: 8e a9 0f b6 67 66 be 92 c1 11 f9 
72 58 38 21 1e
[   74.128271] skb linear:   00000040: c3 93 b6 3d 73 ec 70 46 a6 cf 56 
e6 c2 eb 02 26
[   74.128280] skb linear:   00000050: 1e 61 9c 28 70 15 b3 d3 8f ba e4 
b0 7f b7 3a 43
[   74.128288] skb linear:   00000060: 5f 18 6e d2 1c 1a 6d 31 f1 02 70 
01 3e b8 b8 da
[   74.128296] skb linear:   00000070: ed 17 c8 be 1c ae 94 c0 90 54 e2 
5d 6b f0 c4 d1
[   74.128303] skb linear:   00000080: 02 96 d1 e8 3e 9a df b3 42 a3 c6 
36 4d 01 67 61
[   74.128311] skb linear:   00000090: e2 41 ed 42 27 fe 53 78 8c fa 27 
eb ac 6d 8d ba
[   74.128319] skb linear:   000000a0: 78 9c 86 75 92 ae 72 8d f7 bb d4 
08 e1 27 56 79
[   74.128327] skb linear:   000000b0: ec 2e 0d 30 77 bf fd ae 4d 8e e0 
5c 85 65 23 7c
[   74.128334] skb linear:   000000c0: a6 ba 32 5f 0f 87 f5 d8 96 56 9a 
f2 70 9b 96 de
[   74.128342] skb linear:   000000d0: 51 47 e6 2f d3 9a 9b 4a 1c 39 95 
17 bb 80 8f fd
[   74.128349] skb linear:   000000e0: d4 19 5c 0e 7d ce 6f 7e 67 9b a1 
5a c1 08 2f 76
[   74.128357] skb linear:   000000f0: 59 b6 02 a8 05 37 34 33 41 22 cf 
86 19 67 d8 27
[   74.128364] skb linear:   00000100: 4a e1 8c ea a4 2a e9 66 b2 b3 70 
a9 9d 14 2a 2b
[   74.128373] skb linear:   00000110: 4e a0 e9 01 d3 3d d0 53 04 73 15 
10 66 c2 06 e0
[   74.128380] skb linear:   00000120: 4f 39 4a 5b 4b 44 6a 78 bf c6 90 
48 cc 67 8e e4
[   74.128388] skb linear:   00000130: 76 30 21 a4 06 55 77 91 ac 51 f0 
1d 69 38 22 12
[   74.128396] skb linear:   00000140: 2c 49 1f c9 3c c3 fa 9c d5 fb 87 
9d 16 aa 63 89
[   74.128403] skb linear:   00000150: 1b 8b 34 f7 66 26 32 d5 83 e6 e7 
15 eb 72 32 a4
[   74.128411] skb linear:   00000160: 2a 3a 92 9c 3d 50 a1 ba 3e 7a df 
12 43 85 b1 01
[   74.128418] skb linear:   00000170: 83 dc aa 64 ba 59 08 07 cf 5a 82 
61 b4 18 41 7e
[   74.128426] skb linear:   00000180: 8f 34 2c 3c 17 93 68 ba 40 6c 1f 
0e 1a 9f 81 36
[   74.128434] skb linear:   00000190: f6 49 09 51 cc 95 02 10 d9 d5 49 
67 8c d1 54 88
[   74.128442] skb linear:   000001a0: a3 5e 73 11 92 33 56 84 24 f9 d0 
f9 64 a1 da 0f
[   74.128449] skb linear:   000001b0: be fa db 28 62 83 27 d6 e9 7e c5 
90 3b 45 75 aa
[   74.128457] skb linear:   000001c0: b0 e1 f1 84 75 d9 74 01 32 48 79 
3a e9 32 c5 74
[   74.128465] skb linear:   000001d0: 22 18 a7 50 45 ca 7f 42 47 7d 7d 
44 88 1d ab cc
[   74.128472] skb linear:   000001e0: fc e5 2e fb 8a 2c c9 17 b1 82 a2 
3b 71 fb 49 4d
[   74.128480] skb linear:   000001f0: 69 cb f6 31 3d 13 12 3c 3a fb f9 
ec 3d 01 ff d6
[   74.128488] skb linear:   00000200: d0 91 b1 df 97 d5 5d af eb ce d4 
63 c4 a4 6e 82
[   74.128496] skb linear:   00000210: dc 3a 4f 33 11 06 e9 ad 0b 20 c2 
ee 20 98 77 b0
[   74.128504] skb linear:   00000220: 74
[   74.128511] skb tailroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
[   74.128519] skb tailroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
[   74.128527] skb tailroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
[   74.128534] skb tailroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 
00 00
[   74.128545] CPU: 26 UID: 0 PID: 0 Comm: swapper/26 Tainted: G         
  OE     -------  ---  6.14.0-63.fc42.x86_64 #1
[   74.128554] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   74.128557] Hardware name: To Be Filled By O.E.M. To Be Filled By 
O.E.M./EPYCD8, BIOS L2.52 11/25/2020
[   74.128562] Call Trace:
[   74.128567]  <IRQ>
[   74.128579]  dump_stack_lvl+0x5d/0x80
[   74.128594]  __skb_checksum_complete+0xe8/0x100
[   74.128605]  ? __pfx_csum_partial_ext+0x10/0x10
[   74.128611]  ? __pfx_csum_block_add_ext+0x10/0x10
[   74.128620]  tcp_rcv_established+0x4da/0x770
[   74.128634]  tcp_v4_do_rcv+0x165/0x2b0
[   74.128643]  tcp_v4_rcv+0xc72/0xf40
[   74.128655]  ip_protocol_deliver_rcu+0x33/0x190
[   74.128664]  ip_local_deliver_finish+0x76/0xa0
[   74.128671]  ip_local_deliver+0xf6/0x100
[   74.128682]  __netif_receive_skb_one_core+0x87/0xa0
[   74.128693]  process_backlog+0x87/0x130
[   74.128703]  __napi_poll+0x2b/0x160
[   74.128713]  net_rx_action+0x333/0x420
[   74.128737]  handle_softirqs+0xf2/0x340
[   74.128747]  ? srso_return_thunk+0x5/0x5f
[   74.128760]  __irq_exit_rcu+0xc2/0xe0
[   74.128768]  common_interrupt+0x85/0xa0
[   74.128777]  </IRQ>
[   74.128779]  <TASK>
[   74.128783]  asm_common_interrupt+0x26/0x40
[   74.128792] RIP: 0010:cpuidle_enter_state+0xcc/0x660
[   74.128799] Code: 00 00 e8 d7 23 00 ff e8 62 ee ff ff 49 89 c4 0f 1f 
44 00 00 31 ff e8 03 6c fe fe 45 84 ff 0f 85 02 02 00 00 fb 0f 1f 44 00 
00 <85> ed 0f 88 d3 01 00 00 4c 63 f5 49 83 fe 0a 0f 83 9f 04 00 00 49
[   74.128803] RSP: 0018:ffffb8bd003dfe58 EFLAGS: 00000246
[   74.128809] RAX: ffff9ecb4cd00000 RBX: ffff9eac82e5a800 RCX: 
0000000000000000
[   74.128813] RDX: 00000011426107f1 RSI: 000000003152c088 RDI: 
0000000000000000
[   74.128817] RBP: 0000000000000002 R08: 00000000000d5a5c R09: 
0000000000000001
[   74.128820] R10: 0000000000000003 R11: ffff9ecb4cd217c0 R12: 
00000011426107f1
[   74.128823] R13: ffffffffb8b15140 R14: 0000000000000002 R15: 
0000000000000000
[   74.128841]  ? cpuidle_enter_state+0xbd/0x660
[   74.128853]  cpuidle_enter+0x2d/0x40
[   74.128864]  cpuidle_idle_call+0xf2/0x160
[   74.128875]  do_idle+0x78/0xd0
[   74.128883]  cpu_startup_entry+0x29/0x30
[   74.128890]  start_secondary+0x12d/0x160
[   74.128901]  common_startup_64+0x13e/0x141
[   74.128918]  </TASK>

What caught my attention is that iif=3 points to an interface that is 
not connected to the outside and, as far as I can tell, should not be a 
source of any errors.

Through testing, I've observed the following:

 1. Disabling all Podman containers eliminates the warning.
 2. Disabling only containers using macvlan/ipvlan (while leaving others
    running) still triggers the warning.
 3. Booting with a limited number of containers also reproduces the
    warning — the example above was captured in such a scenario.

The skb dump includes this line:

skb headroom: 00000040: 72 30 8d ae 4f 32 e2 a4 be b5 59 db 08 00 45 00

This appears to show the MAC address of the skb, which I was able to 
trace to:
$ sudo podman exec -it systemd-qbittorrentEH ip a
[... unrelated ...]
3: eth0@if12: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc 
noqueue state UP qlen 1000
     link/ether 72:30:8d:ae:4f:32 brd ff:ff:ff:ff:ff:ff
     inet 10.88.0.4/16 brd 10.88.255.255 scope global eth0
        valid_lft forever preferred_lft forever
     inet6 fccc::4/64 scope global
        valid_lft forever preferred_lft forever
     inet6 fe80::7030:8dff:feae:4f32/64 scope link
        valid_lft forever preferred_lft forever
And the other MAC:
$ ip link show podman0
9: podman0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue 
state UP mode DEFAULT group default qlen 1000
     link/ether e2:a4:be:b5:59:db brd ff:ff:ff:ff:ff:ff

This seems to suggest the warning involves traffic between a veth pair 
used by containers, raising the possibility of a bug in the kernel.

For completeness, here is NIC information from the system (2x ConnectX-4 
MCX4121A-ACAT):
$ ethtool -i mlx-p0
driver: mlx5_core
version: 6.14.0-63.fc42.x86_64
firmware-version: 14.32.1900 (MT_2420110034)
expansion-rom-version:
bus-info: 0000:c1:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: yes

(and 2 unplugged i350 ports)
$ ethtool -i board-p0
driver: igb
version: 6.14.0-63.fc42.x86_64
firmware-version: 1.69, 0x80000df4
expansion-rom-version:
bus-info: 0000:45:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

Please let me know if further debugging or logs would be helpful. I'd be 
happy to provide more detail or try any suggested patches.

Best,
Qiyu

