Return-Path: <netdev+bounces-30933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8A5789FC0
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 16:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3BD1C20915
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BE910956;
	Sun, 27 Aug 2023 14:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9475DF4A
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 14:20:25 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD33FC
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 07:20:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bed101b70so288462266b.3
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693146022; x=1693750822;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=thxWx4GyjVPUCi7IxUEw4/o2DV5Prs3WwEY1Nf6wcW0=;
        b=QCPJM7AWyz0IJzbPxpF0AVYU7NjLCiB2EznIhRw9/HknJy+EIUchpZAYNfY4BxITYQ
         nXSBKcu/l4R4DFIJsOqkCeeoXQu4ilmMjxRFDJYfW770CJ2LuebdNh9k5h95dcxCfurn
         QkP0nFAEAGQ1WCJxFuF42DzQXZFYla9lYI6weHZSgblUEn57Qyw17SVbNSBhVmIDhvwt
         /WK5u3t0UOsyioV4Zfkrf82gFhM+I7mYTasd3HZf/rxixyTIZASkqBWgQGeVAylwAHbI
         jz0C9S2wzP/CEwjCN//9ECIBqwphbQLORxiPszFxCxDz7O48TZPnrH+LrdqEVkAsAN3k
         JQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693146022; x=1693750822;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thxWx4GyjVPUCi7IxUEw4/o2DV5Prs3WwEY1Nf6wcW0=;
        b=Yna9SSv+hvRamboHXN0VFrKsk/AOgQOFY/7RqEHxuhb2WUruKo34KtYUyaxE/Cm7V6
         bLMElzYvPjvPm9I+C/cDXAmUniBd4lGFp4/i9N1DSbHL7+raE6Li1Q2fDwIA7wn0q7l9
         aQARX6Q2t3SWLvIPHRqbSJzkTZVWkZVgt0x+hLoDQoqPeZSiDPfdkwRyo5VH2mvJ/Odp
         io7rS77jlRQqHO8lwKhm/jMnvh/63zlsZ/SkpJep+Rvsd7Mt5+Ecierb0Xl5Jfe7ABKU
         +oo8mQQxbGT+DADPmZCXbsidEbumU1t19jgyIcLIHmMiIhpoPBtbktLMqB4V2v/MkVpD
         b2NA==
X-Gm-Message-State: AOJu0YwiIDTV+JAY2GQ3irJ+7U+KNS52FA+Nmc4kiQNUpNnA3qYMqinY
	YEgkI/0grB0c7pjhuEmq5mJ7uPS9lpM=
X-Google-Smtp-Source: AGHT+IEK+dbqkwy7u4Ea4WIoUM9DZnEK6WiMGzjy+25pkYmXPhrA8bn4ccDLDoRkVzp7oHTug4jt4Q==
X-Received: by 2002:a17:907:2718:b0:9a1:cdf1:ba3 with SMTP id w24-20020a170907271800b009a1cdf10ba3mr9687805ejk.27.1693146021969;
        Sun, 27 Aug 2023 07:20:21 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id w10-20020a170906480a00b00992b510089asm3480229ejq.84.2023.08.27.07.20.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Aug 2023 07:20:21 -0700 (PDT)
From: Martin Zaharinov <micron10@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: High Cpu load when run smartdns : __ipv6_dev_get_saddr 
Message-Id: <164ECEA1-0779-4EB8-8B2B-387F7CEC7A89@gmail.com>
Date: Sun, 27 Aug 2023 17:20:10 +0300
To: netdev <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric=20


i need you help to find is this bug or no.

I talk with smartdns team and try to research in his code but for the =
moment not found ..

test system have 5k ppp users on pppoe device

after run smartdns =20

service got to 100% load=20

in normal case when run other 2 type of dns server (isc bind or knot ) =
all is fine .

but when run smartdns  see perf :=20


 PerfTop:    4223 irqs/sec  kernel:96.9%  exact: 100.0% lost: 0/0 drop: =
0/0 [4000Hz cycles],  (target_pid: 1208268)
=
--------------------------------------------------------------------------=
--------------------------------------------------------------------------=
-----------------------------------------------------------

    28.48%  [kernel]        [k] __ipv6_dev_get_saddr
    12.31%  [kernel]        [k] l3mdev_master_ifindex_rcu
     6.63%  [pppoe]         [k] pppoe_rcv
     3.82%  [kernel]        [k] ipv6_dev_get_saddr
     2.07%  [kernel]        [k] __dev_queue_xmit
     1.46%  [ixgbe]         [k] ixgbe_clean_rx_irq
     1.42%  [kernel]        [k] memcmp
     1.37%  [nf_tables]     [k] nft_do_chain
     1.35%  [nf_tables]     [k] __nft_rbtree_lookup
     1.29%  [kernel]        [k] __netif_receive_skb_core.constprop.0
     1.01%  [kernel]        [k] strncpy
     0.93%  [kernel]        [k] fib_table_lookup
     0.91%  [kernel]        [k] dev_queue_xmit_nit
     0.89%  [kernel]        [k] csum_partial_copy_generic
     0.89%  [kernel]        [k] skb_clone
     0.86%  [kernel]        [k] __skb_flow_dissect
     0.83%  [kernel]        [k] __copy_skb_header
     0.80%  [kernel]        [k] kmem_cache_free
     0.73%  [nf_tables]     [k] nft_rhash_lookup
     0.70%  [nf_conntrack]  [k] __nf_conntrack_find_get.isra.0
     0.70%  [kernel]        [k] skb_release_data
     0.64%  [ixgbe]         [k] ixgbe_tx_map
     0.53%  [kernel]        [k] kmem_cache_alloc
     0.51%  [kernel]        [k] kfree_skb_reason
     0.48%  [kernel]        [k] ip_route_input_slow
     0.48%  [kernel]        [k] dev_hard_start_xmit
     0.48%  [kernel]        [k] ip_finish_output2
     0.47%  [vlan_mon]      [k] vlan_pt_recv
     0.42%  [kernel]        [k] nf_hook_slow
     0.40%  [kernel]        [k] __siphash_unaligned
     0.39%  [kernel]        [k] ___slab_alloc.isra.0
     0.38%  [nf_tables]     [k] nft_lookup_eval
     0.38%  [ixgbe]         [k] ixgbe_xmit_frame_ring
     0.36%  [kernel]        [k] netif_skb_features
     0.33%  [kernel]        [k] dev_gro_receive
     0.33%  [kernel]        [k] ip_rcv_core.constprop.0
     0.32%  [kernel]        [k] vlan_do_receive
     0.30%  [kernel]        [k] ip_forward
     0.30%  [kernel]        [k] get_rps_cpu
     0.30%  [kernel]        [k] process_backlog
     0.30%  [kernel]        [k] ktime_get_with_offset
     0.30%  [kernel]        [k] _raw_spin_lock_irqsave
     0.30%  [kernel]        [k] validate_xmit_skb.isra.0
     0.30%  [kernel]        [k] __rcu_read_unlock
     0.30%  [kernel]        [k] sch_direct_xmit
     0.29%  [kernel]        [k] page_frag_free
     0.29%  [nf_conntrack]  [k] nf_conntrack_in
     0.28%  [kernel]        [k] netdev_core_pick_tx
     0.28%  [nf_tables]     [k] nft_meta_get_eval
     0.27%  [kernel]        [k] kmem_cache_free_bulk.part.0
     0.26%  [kernel]        [k] ip_output
     0.26%  [kernel]        [k] _raw_spin_lock_bh
     0.26%  [kernel]        [k] __local_bh_enable_ip
     0.25%  [kernel]        [k] netdev_pick_tx
     0.23%  [ppp_generic]   [k] __ppp_xmit_process
     0.23%  [nf_nat]        [k] l4proto_manip_pkt
     0.23%  [ixgbe]         [k] ixgbe_process_skb_fields
     0.23%  [pppoe]         [k] pppoe_xmit
     0.23%  [kernel]        [k] skb_network_protocol
     0.22%  [kernel]        [k] inet_gro_receive
     0.22%  [ppp_generic]   [k] ppp_start_xmit
     0.22%  [kernel]        [k] __list_del_entry_valid
     0.20%  [kernel]        [k] __slab_free.isra.0
     0.20%  [kernel]        [k] _raw_spin_lock
     0.20%  [kernel]        [k] __rcu_read_lock
     0.20%  [kernel]        [k] csum_partial
     0.20%  [kernel]        [k] read_tsc
     0.19%  [nf_nat]        [k] nf_nat_ipv4_manip_pkt
     0.18%  [kernel]        [k] napi_build_skb
     0.18%  [ixgbe]         [k] ixgbe_clean_tx_irq
     0.18%  [kernel]        [k] dma_map_page_attrs
     0.17%  [ppp_generic]   [k] ppp_push
     0.16%  [kernel]        [k] vlan_dev_hard_start_xmit
     0.15%  [kernel]        [k] skb_segment
     0.14%  [kernel]        [k] napi_consume_skb
     0.14%  [kernel]        [k] enqueue_to_backlog
     0.13%  [kernel]        [k] kmem_cache_alloc_bulk=

