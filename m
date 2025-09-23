Return-Path: <netdev+bounces-225620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A0EB96159
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C427A19C443F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C324522D7A5;
	Tue, 23 Sep 2025 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHc2YauY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC47D223DDA
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635316; cv=none; b=qk6ZfwK1RINVVxy/jKgO7tpnuJVe45VGqo5wRb+qNc6+08/r3z3UUphzSQGk7SJVHjhykMtVIuI/iCOoJnlLejuGgdGGoBwuVBamBRusDCw+NTlFkZ/1fHfUCebgMMljM1uc0ImU9X+/Pav4JWnXti1WJXEvcLVO5bwkld87Lwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635316; c=relaxed/simple;
	bh=5NQbbkrkWHhvgcY8jwt6GzTqzGnrse+/OklXw5rx1ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEuG0hst1okWDAWeKCqeoDPGbFQl5hnuRtvkDG12UsGCWgIzyG1nbwxcV9RMzQxeC5ksi6Vm740zfh6sVmCqjna+9VQAnL8oZTz4DVh1hsSGjPHhvBjsMXDbrEBfqeuEA8tqxELtoXQysSYN/H9f06SSKbd2Jzr5wW7GZCYPhnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHc2YauY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso42512775e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635313; x=1759240113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6fX8V4shxaRnXthZKMMCr4vjqMEip3A8oGVoBR4mb0=;
        b=eHc2YauYxwqfRFSYnpKPF+KccIK4TRONX0eyijzy6mjHfEehGHWONhD9ROXsV/G1R1
         tvsUrbqkYQTkinthKgVQ6dyV9yRAX/CVU9tQb5NS4HxEKgS549+EX6BtzTFvecYDN8SB
         imJgxXYZVZoR/CpUhXFV/i5DM8V+YS3azFiBxYpE/4gBZelMRko+gntgrrhI2kgap29T
         TTbJop5CbJHHINXHIapQBqV0MmQUfp3Mu3EDAKRqPrejtrPZWIAlalUQeOO0irFHDNvb
         IAqbtBkv0pxmNZdwlvcwwrTzlBCeIQc16H8HD5610RaZVEhRK5YIRafBHiGWcwLX5hAT
         SbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635313; x=1759240113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6fX8V4shxaRnXthZKMMCr4vjqMEip3A8oGVoBR4mb0=;
        b=ldbOcWyJpQVBMruR8mYFRsUobXoiyAOgsI7jbWQFSh01pmWpIulfqJhi6tXXjb0fqb
         UiXgeyJE1ZmuTzXFzYBFVVV92Q6/eiTTtQ1JGRvC4PylLA8gI20S7foUxHKFD8+I7puq
         THhMRRgEiF4vxlTYbuEa/dZLcJhavZnUwKKmlMxpd06IsUsemzsDD8Q1dCwAEkAeOAEA
         EfQ11MbwzDHOg9Yy50Bv2AsDKrOBHoLcQDRwDT/R2l29BHnLjJknvLlOjp7UpuSQKuO0
         x6wSxKJ//EJNDgduAKVS3fXz2O/tKNfYRGJ2EZjJ+WVA+MRcLctMRzIMY4i7Y/GYSCxM
         sepA==
X-Gm-Message-State: AOJu0Yz142MvDlKbUui5Z66F45ITq7BxET2Ut0deeqSoUT5XLN0EdbHW
	NOIBvwUd+aCIlmQYEZv6r14Y4sYy0bt8ADV4JYBOlewyD/GgeSP0fmDA
X-Gm-Gg: ASbGncuDHZ/BIC2ooP6Q0xrPEON/O4q7SEimnqsgoj2blz5BBaZT0ygSDOQW9tJe2QB
	3Mbh4yasrIEiZWELaXt58V/iSUcZtLYO1ccRHX4cvjsmx9YwprwnyfoFIs9cOpB3redcg3hwKxi
	ewiEaP6A8FxaonKJbL/MqZEkvPvQQwek/D0yRhNzEcfGBnQMGvB/94FU1Rj7HXuhwyUcpAtDW+P
	Ec0wDQeL0qPHNn7Um4adVhXHTyM0Y+jAHudfbQOkPblCQdCMsurxCNnz3KoSI/bvAMQ+hHfxFuO
	+I+yUiK0LsrPNuoxMymMw+FWa46FgKpnXd+c2fjhr76LMJ+9fpxzdx43pyu2ok5mmpboH7dnkJV
	1ZIOLCkyKue16nucwsh7Fycc8ZIn+Fxui2YvOoT5FVO0EkQulj6UftoQva6w=
X-Google-Smtp-Source: AGHT+IF6ZzpIZSHssUb7U6fY9gKtDSSKdov02KdU1118JIoqTRA3szBTdQKq+26vF6Dbfrhh3y284A==
X-Received: by 2002:a05:600c:5252:b0:46d:8cb7:33a3 with SMTP id 5b1f17b1804b1-46e1d981c65mr32420965e9.10.1758635312776;
        Tue, 23 Sep 2025 06:48:32 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f0aac3fdsm237256215e9.1.2025.09.23.06.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:48:32 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 17/17] geneve: Enable BIG TCP packets
Date: Tue, 23 Sep 2025 16:47:42 +0300
Message-ID: <20250923134742.1399800-18-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

From: Daniel Borkmann <daniel@iogearbox.net>

In Cilium we do support BIG TCP, but so far the latter has only been
enabled for direct routing use-cases. A lot of users rely on Cilium
with vxlan/geneve tunneling though. The underlying kernel infra for
tunneling has not been supporting BIG TCP up to this point.

Given we do now, bump tso_max_size for geneve netdevs up to GSO_MAX_SIZE
to allow the admin to use BIG TCP with geneve tunnels.

BIG TCP on geneve disabled:

  Standard MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    30.00    37391.34

  8k MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    262144  32768  32768    60.00    58030.19

BIG TCP on geneve enabled:

  Standard MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    30.00    40891.57

  8k MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    262144  32768  32768    60.00    61458.39

Example receive side:

  swapper       0 [008]  3682.509996: net:netif_receive_skb: dev=geneve0 skbaddr=0xffff8f3b0a781800 len=129492
        ffffffff8cfe3aaa __netif_receive_skb_core.constprop.0+0x6ca ([kernel.kallsyms])
        ffffffff8cfe3aaa __netif_receive_skb_core.constprop.0+0x6ca ([kernel.kallsyms])
        ffffffff8cfe47dd __netif_receive_skb_list_core+0xed ([kernel.kallsyms])
        ffffffff8cfe4e52 netif_receive_skb_list_internal+0x1d2 ([kernel.kallsyms])
        ffffffff8cfe573c napi_complete_done+0x7c ([kernel.kallsyms])
        ffffffff8d046c23 gro_cell_poll+0x83 ([kernel.kallsyms])
        ffffffff8cfe586d __napi_poll+0x2d ([kernel.kallsyms])
        ffffffff8cfe5f8d net_rx_action+0x20d ([kernel.kallsyms])
        ffffffff8c35d252 handle_softirqs+0xe2 ([kernel.kallsyms])
        ffffffff8c35d556 __irq_exit_rcu+0xd6 ([kernel.kallsyms])
        ffffffff8c35d81e irq_exit_rcu+0xe ([kernel.kallsyms])
        ffffffff8d2602b8 common_interrupt+0x98 ([kernel.kallsyms])
        ffffffff8c000da7 asm_common_interrupt+0x27 ([kernel.kallsyms])
        ffffffff8d2645c5 cpuidle_enter_state+0xd5 ([kernel.kallsyms])
        ffffffff8cf6358e cpuidle_enter+0x2e ([kernel.kallsyms])
        ffffffff8c3ba932 call_cpuidle+0x22 ([kernel.kallsyms])
        ffffffff8c3bfb5e do_idle+0x1ce ([kernel.kallsyms])
        ffffffff8c3bfd79 cpu_startup_entry+0x29 ([kernel.kallsyms])
        ffffffff8c30a6c2 start_secondary+0x112 ([kernel.kallsyms])
        ffffffff8c2c142d common_startup_64+0x13e ([kernel.kallsyms])

Example transmit side:

  swapper       0 [002]  3403.688687: net:net_dev_xmit: dev=enp10s0f0np0 skbaddr=0xffff8af31d104ae8 len=129556 rc=0
        ffffffffa75e19c3 dev_hard_start_xmit+0x173 ([kernel.kallsyms])
        ffffffffa75e19c3 dev_hard_start_xmit+0x173 ([kernel.kallsyms])
        ffffffffa7653823 sch_direct_xmit+0x143 ([kernel.kallsyms])
        ffffffffa75e2780 __dev_queue_xmit+0xc70 ([kernel.kallsyms])
        ffffffffa76a1205 ip_finish_output2+0x265 ([kernel.kallsyms])
        ffffffffa76a1577 __ip_finish_output+0x87 ([kernel.kallsyms])
        ffffffffa76a165b ip_finish_output+0x2b ([kernel.kallsyms])
        ffffffffa76a179e ip_output+0x5e ([kernel.kallsyms])
        ffffffffa76a19d5 ip_local_out+0x35 ([kernel.kallsyms])
        ffffffffa770d0e5 iptunnel_xmit+0x185 ([kernel.kallsyms])
        ffffffffc179634e nf_nat_used_tuple_new.cold+0x1129 ([kernel.kallsyms])
        ffffffffc179d3e0 geneve_xmit+0x920 ([kernel.kallsyms])
        ffffffffa75e18af dev_hard_start_xmit+0x5f ([kernel.kallsyms])
        ffffffffa75e1d3f __dev_queue_xmit+0x22f ([kernel.kallsyms])
        ffffffffa76a1205 ip_finish_output2+0x265 ([kernel.kallsyms])
        ffffffffa76a1577 __ip_finish_output+0x87 ([kernel.kallsyms])
        ffffffffa76a165b ip_finish_output+0x2b ([kernel.kallsyms])
        ffffffffa76a179e ip_output+0x5e ([kernel.kallsyms])
        ffffffffa76a1de2 __ip_queue_xmit+0x1b2 ([kernel.kallsyms])
        ffffffffa76a2135 ip_queue_xmit+0x15 ([kernel.kallsyms])
        ffffffffa76c70a2 __tcp_transmit_skb+0x522 ([kernel.kallsyms])
        ffffffffa76c931a tcp_write_xmit+0x65a ([kernel.kallsyms])
        ffffffffa76ca3b9 __tcp_push_pending_frames+0x39 ([kernel.kallsyms])
        ffffffffa76c1fb6 tcp_rcv_established+0x276 ([kernel.kallsyms])
        ffffffffa76d3957 tcp_v4_do_rcv+0x157 ([kernel.kallsyms])
        ffffffffa76d6053 tcp_v4_rcv+0x1243 ([kernel.kallsyms])
        ffffffffa769b8ea ip_protocol_deliver_rcu+0x2a ([kernel.kallsyms])
        ffffffffa769bab7 ip_local_deliver_finish+0x77 ([kernel.kallsyms])
        ffffffffa769bb4d ip_local_deliver+0x6d ([kernel.kallsyms])
        ffffffffa769abe7 ip_sublist_rcv_finish+0x37 ([kernel.kallsyms])
        ffffffffa769b713 ip_sublist_rcv+0x173 ([kernel.kallsyms])
        ffffffffa769bde2 ip_list_rcv+0x102 ([kernel.kallsyms])
        ffffffffa75e4868 __netif_receive_skb_list_core+0x178 ([kernel.kallsyms])
        ffffffffa75e4e52 netif_receive_skb_list_internal+0x1d2 ([kernel.kallsyms])
        ffffffffa75e573c napi_complete_done+0x7c ([kernel.kallsyms])
        ffffffffa7646c23 gro_cell_poll+0x83 ([kernel.kallsyms])
        ffffffffa75e586d __napi_poll+0x2d ([kernel.kallsyms])
        ffffffffa75e5f8d net_rx_action+0x20d ([kernel.kallsyms])
        ffffffffa695d252 handle_softirqs+0xe2 ([kernel.kallsyms])
        ffffffffa695d556 __irq_exit_rcu+0xd6 ([kernel.kallsyms])
        ffffffffa695d81e irq_exit_rcu+0xe ([kernel.kallsyms])
        ffffffffa78602b8 common_interrupt+0x98 ([kernel.kallsyms])
        ffffffffa6600da7 asm_common_interrupt+0x27 ([kernel.kallsyms])
        ffffffffa78645c5 cpuidle_enter_state+0xd5 ([kernel.kallsyms])
        ffffffffa756358e cpuidle_enter+0x2e ([kernel.kallsyms])
        ffffffffa69ba932 call_cpuidle+0x22 ([kernel.kallsyms])
        ffffffffa69bfb5e do_idle+0x1ce ([kernel.kallsyms])
        ffffffffa69bfd79 cpu_startup_entry+0x29 ([kernel.kallsyms])
        ffffffffa690a6c2 start_secondary+0x112 ([kernel.kallsyms])
        ffffffffa68c142d common_startup_64+0x13e ([kernel.kallsyms])

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: Maxim Mikityanskiy <maxim@isovalent.com>
Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/geneve.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 77b0c3d52041..374798abed7c 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1225,6 +1225,8 @@ static void geneve_setup(struct net_device *dev)
 	dev->max_mtu = IP_MAX_MTU - GENEVE_BASE_HLEN - dev->hard_header_len;
 
 	netif_keep_dst(dev);
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
 	dev->lltx = true;
-- 
2.50.1


