Return-Path: <netdev+bounces-225619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 658FAB9613B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4822E653E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A014227B94;
	Tue, 23 Sep 2025 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJLTU0q7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D8321C19D
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635314; cv=none; b=s1KmF0WXNJH3pkc8FDb54LxMcgIIXVaqfBQBrTEElKKWNuTWomG6I52jE+tzSKGBxd4bwWTA4XfWQiBQQLx8VMGdqSoo5inSKlRbqeW3Lhgdq+lhEv/bmO/38pQxTnzuhLKAacjS9R7Z7iGtMaKtZTCuFNl/7U9dvdxHF+MvaRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635314; c=relaxed/simple;
	bh=zX12VzvqnTMVbIUiAwlB47bMaMoqjR9K8EJoQszbczU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFaS3YKY+k8TUjoCisioDzGmsViGTwIN8K7VjmEzNj/6BgHlBbwzqoC59dGHf2HB/ape8vJJ8daFR4b3W6saOWZuiMoWK/YeYaWlUEvNuAdOR7FhQBZl0GAX1t193yh+tyaWPuCt1J+APUvqOGh4549hTMQ4UA0aqUI+VWBJiHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJLTU0q7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso35631895e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635310; x=1759240110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxcgfWGFEUHPi0XJivDMB6KBGkSNx0Yo7Ko6HKPYLMU=;
        b=AJLTU0q7AeVTYfYxNVIvTuG03ZlzTFHmNT43obAbobhgZTBnHZb5a0dTDwEsWXtnbx
         I6m/I50dGUDHboQiLV+Qspc4eAYXXimYxi5MVlSrC593SPgDRhgZUAwyUNhkcwPoHnIp
         MlSb4/RtHLPhjFVXtGtHuCx+ZARhOjb0XIXUhlX6nvZCksptUJfkn5H/u9BO4UE2K/ri
         J/0fBXcThHrSoEgWjjWj3e6CKl5WWHLY89TZp7pj1mv9+vVhdJQ00FSvUWVvyYCKzgca
         8rv/7L0ovficUueIt8f7Y3IxzFGhRi1oe5DD2zY29wXEn0EzhGWH6vT5PNwkFrpqikKX
         TPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635310; x=1759240110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxcgfWGFEUHPi0XJivDMB6KBGkSNx0Yo7Ko6HKPYLMU=;
        b=d0wffpqAtiuw9fIoU7zH6jTwJDb/BC3kSdsgUtx1alN5xnd/oOOdYfL6noP4NhAWZu
         I7x6ExPbpPaF1sRFwhFpWPq9UWjRy0ketznxApGSMrPikcxJSY9xz/IEE04X1GfBIN4S
         U5mbUKJdWWR2B9Vgf/Ekih+bg7butCklqxDzLV28MCpzbIGhm90wccRBEyHktyiGmgXa
         /9/UUf3+NigLFhqavSR46QfnKRAlTNqeebeRUBU9rcPBjTDzITOjMUJK8g9fXK61lJTq
         Cw34GQeHCNynihw8/6tsAi64cpj7yz1xcOxB1yaTUjHa40nk4RcmsghHQuBrVK8Gay91
         jC/Q==
X-Gm-Message-State: AOJu0YyCtf3jJwbcjO+1mZVUEgdVSTnSNoayVex36Zp77zks5/dcheAL
	+0T2cBFHEd9rKP65DWn30bYt5TTSbwXBDi85yAvJgaVSJhbRBW5xRIsH
X-Gm-Gg: ASbGnctCMV3N5MJj05cKHUI8drKCXjrOfYWDJVXhz4NPmtRJuAzEb1JMBRPCAZxyZgK
	PZoV9a+9e4yUn8Rm/ii0gjID+aGLimeevO5Gha52HSr1/AeH4lanSo2y/ht1kp1IkEUOXqeiIDH
	0ZK5oESsD7KHyVOfaPBDdvSfpKnv0SaqZvE/ZGMN5p5ZirGSDfy8JA3quprrlC0m7ZTrYTif3na
	K5pwDNKKSCnMK3w0l5h6xeUZ3DqkDgDMdaPhI8iNAhsBu9MofL0QtngD87wHUnojYThzkW50wG+
	ucbHFhpQdmLlasYyShtzUM3D0fw/jX3OZuE+RZp8ld+puahqtmGYWST3My4GyJnvXqNKoNJ7fXq
	hS3/569kJPHbdiVrVGO8bdo3IR6xJ/5DkSs+Vr07c17IIC/RcBjfpZFBpF2w=
X-Google-Smtp-Source: AGHT+IEZSlFaMo17x14PeqF2RQNjFVy9xN+Un/9G3lhgHkF9wsZJXaCxfQGEDR+28ELHscoZyhWjfg==
X-Received: by 2002:a05:600c:4743:b0:45b:88d6:8db5 with SMTP id 5b1f17b1804b1-46e1d98a1ffmr31428475e9.12.1758635310385;
        Tue, 23 Sep 2025 06:48:30 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e25f37fcesm5647995e9.1.2025.09.23.06.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:48:29 -0700 (PDT)
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
Subject: [PATCH net-next 16/17] vxlan: Enable BIG TCP packets
Date: Tue, 23 Sep 2025 16:47:41 +0300
Message-ID: <20250923134742.1399800-17-maxtram95@gmail.com>
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

From: Maxim Mikityanskiy <maxim@isovalent.com>

In Cilium we do support BIG TCP, but so far the latter has only been
enabled for direct routing use-cases. A lot of users rely on Cilium
with vxlan/geneve tunneling though. The underlying kernel infra for
tunneling has not been supporting BIG TCP up to this point.

Given we do now, bump tso_max_size for vxlan netdevs up to GSO_MAX_SIZE
to allow the admin to use BIG TCP with vxlan tunnels.

BIG TCP on vxlan disabled:

  Standard MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    30.00    34440.00

  8k MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    262144  32768  32768    30.00    55684.26

BIG TCP on vxlan enabled:

  Standard MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    30.00    39564.78

  8k MTU:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    262144  32768  32768    30.00    61466.47

When tunnel offloads are not enabled/exposed and we fully need to rely on
SW-based segmentation on transmit (e.g. in case of Azure) then the more
aggressive batching also has a visible effect. Below example was on the
same setup as with above benchmarks but with HW support disabled:

  # ethtool -k enp10s0f0np0 | grep udp
  tx-udp_tnl-segmentation: off
  tx-udp_tnl-csum-segmentation: off
  tx-udp-segmentation: off
  rx-udp_tunnel-port-offload: off
  rx-udp-gro-forwarding: off

  Before:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    60.00    21820.82

  After:

    # netperf -H 10.1.0.2 -t TCP_STREAM -l60
    MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.0.2 () port 0 AF_INET : demo
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    60.00    29390.78

Example receive side:

  swapper       0 [002]  4712.645070: net:netif_receive_skb: dev=enp10s0f0np0 skbaddr=0xffff8f3b086e0200 len=129542
        ffffffff8cfe3aaa __netif_receive_skb_core.constprop.0+0x6ca ([kernel.kallsyms])
        ffffffff8cfe3aaa __netif_receive_skb_core.constprop.0+0x6ca ([kernel.kallsyms])
        ffffffff8cfe47dd __netif_receive_skb_list_core+0xed ([kernel.kallsyms])
        ffffffff8cfe4e52 netif_receive_skb_list_internal+0x1d2 ([kernel.kallsyms])
        ffffffff8d0210d8 gro_complete.constprop.0+0x108 ([kernel.kallsyms])
        ffffffff8d021724 dev_gro_receive+0x4e4 ([kernel.kallsyms])
        ffffffff8d021a99 gro_receive_skb+0x89 ([kernel.kallsyms])
        ffffffffc06edb71 mlx5e_handle_rx_cqe_mpwrq+0x131 ([kernel.kallsyms])
        ffffffffc06ee38a mlx5e_poll_rx_cq+0x9a ([kernel.kallsyms])
        ffffffffc06ef2c7 mlx5e_napi_poll+0x107 ([kernel.kallsyms])
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

  swapper       0 [005]  4768.021375: net:net_dev_xmit: dev=enp10s0f0np0 skbaddr=0xffff8af32ebe1200 len=129556 rc=0
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
        ffffffffc17a7301 vxlan_xmit_one+0xc21 ([kernel.kallsyms])
        ffffffffc17a80a2 vxlan_xmit+0x4a2 ([kernel.kallsyms])
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
        ffffffffa76cb42e tcp_tsq_write+0x5e ([kernel.kallsyms])
        ffffffffa76cb7ef tcp_tasklet_func+0x10f ([kernel.kallsyms])
        ffffffffa695d9f7 tasklet_action_common+0x107 ([kernel.kallsyms])
        ffffffffa695db99 tasklet_action+0x29 ([kernel.kallsyms])
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

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/vxlan/vxlan_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a5c55e7e4d79..a443adde8848 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3341,6 +3341,8 @@ static void vxlan_setup(struct net_device *dev)
 	dev->hw_features |= NETIF_F_RXCSUM;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
 	netif_keep_dst(dev);
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->change_proto_down = true;
 	dev->lltx = true;
-- 
2.50.1


