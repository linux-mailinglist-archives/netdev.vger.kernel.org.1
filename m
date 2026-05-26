Return-Path: <netdev+bounces-291815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANI1G+bNFWoTcAcAu9opvQ
	(envelope-from <netdev+bounces-291815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:44:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F335D9ECB
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F6331993EB
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5204C3B1ECC;
	Tue, 26 May 2026 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="XMsUikiK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gg2UcjJZ"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD73B3B19D6
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812019; cv=none; b=IX/b1FlC8QQwEkHNVnCsRktG1LxlesTBB8wE6lnPCJ+/I86iMgRurrj57hzkdr7FiCt7pFv+bce3SuJFOSfalJeDIzMnax1+r4of9bRwrFkTuaH/tD6x436JwDLcwFzCzjUJbjQa5ccB6QBoAHamL9SzEjejLwNkTH6ab+fcllY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812019; c=relaxed/simple;
	bh=xaE+mx8ZQwVUPWD27UZ6SyHt7+0/2PTZbYgNXXNwOCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTl2Asgl62C3lzypvqqNBh2Zgwmd6qf7qHSl3ciq9y+Nrgqdj3J+Kcn8mo8OGJ+TUlaTJCoduFEFDuFc7yq6ZlF73kiOUW+qvW28HBxMnfjBV31q8/5muiLp9Dbg9rWDa2yAuaBwBVTSgfVJh8+QxC2kvKwTzZ31KC1IpRw5048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=XMsUikiK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gg2UcjJZ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E5F1D1D00075;
	Tue, 26 May 2026 12:13:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 26 May 2026 12:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779812016; x=
	1779898416; bh=En9k+xFCgFC0J7x4xx4I3H2Lobmd4JeNRp9Ay6vhrcg=; b=X
	MsUikiKUfACvqSHH6X/0U3U1GXfHVgz+vpiiB7zZDZ+vCmYELtcY6qZ+Z3syzLgA
	sTj5qqpgMMJLETDqCvZgWoy3GMoAazHeNGGPNbh+XWWqRAqKw7F45CBP+qFvIGlI
	mc20AyJgheqCVJrVVue3ayYlEyZfT8VhQM22BPAQQITcvnQvo6Eshhbv+uyHCeHr
	G9E5ODUQKLWQ78afpYmaZ0TZj8Myz4oKxJrYD5Nx0ucR3eMq+2xAFYXt5A9oLX8P
	HEFr4Y7D6HIzk9q5MXTykXOI+dcYFMMJtSfAWz5IwBW7a8Z7oy5alKnIeyfFN79E
	PWr4kfbnOcVhY0m6jBVHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779812016; x=1779898416; bh=E
	n9k+xFCgFC0J7x4xx4I3H2Lobmd4JeNRp9Ay6vhrcg=; b=Gg2UcjJZNq2TU7WxU
	WubzgFLwdtAG3WgDDJlIeO1IfZJ0+zG7iAO2Nl3pcDZeHCEcjadroJoIYeHcDFH5
	EbPVQ4J0EtGHUFMdKvg5f/nRP2LGYyL/tnZjOUoe48XN6rENpdwcSfK/8OF5FnMc
	FoiDZipsLSgIp6Yb3xUYSbsUPD44h1DrSUObZBuoxu6j4q/3kKUOjpdgof/E2/0E
	K4AdE3oQX3apBpYjhDff8jVLk8KKflXSFJxxEX0lyeiBoSL4ppYE7ziw6zpampBT
	6I/KsogqJDKd+TVNx80Ag4jlL4LUYxG9C+xVzaBtrfqjRnnYp+t4tjPU46CePJiT
	b//sQ==
X-ME-Sender: <xms:sMYVar8a8bC4IKWVSzR6uTJAb5KRgGjvAWHsCMXyzsnd5X_mXKqVXA>
    <xme:sMYVamM7Sh59Vl2_AdVw84IKWhj6EyS5JXZD1LGVaBz7bqPA-UunOPU2-hNhCF3li
    ItT4Zjj281frMBWjtF83Yd2F7Ae_3p9L0BPms6z_-44__mMujdGBc4>
X-ME-Received: <xmr:sMYVav1WNqZO6xtKgVFidati2B6_eYzPI2lh7SQowFgFNe1mJTPsejtvS4qS2xARwWbnGwbsZF0Wk6hJFMh61RmpWMMvOjC0wYlY9Q>
X-ME-Proxy-Cause: dmFkZTEg18DMLZAaEMwP5JeibyA8v4kSMbIfiFKsShGMeCC+mYq3Xj6D+aHHJRnfsMz3qO
    cuKd7ZotewIRqer1FcGDf8Nxg66ZDwyNdlSyy3fZSfMhELsXHQVakcA5JBFAQURXYlxzg8
    YRT4E2MdZK7OXNog9amFv8OWuKVoTJaGTpRl8CPU4Y3WiTyVTlnAVMZD6vH9ezm4AStojn
    hlvIFrNTGeh0xRdH3x+9x6t38vTiX3Q5nQ1u8nQS49ozcdEUYVRyPyHxHUcj7Oz8Lf10E5
    jgP6FMrvVig84YFcKNwhns2dMsP4LQUF5aC1tdX64QPu+ysHuc1h3JC+FKoqtdr7eG3zXK
    jqPihh/kNJkAWo++qys33sLmNlkco9f18zpzEfNoXE4I/rr9h+Ou/g9jO92zP8r6QwsrPo
    8QWoWJc8h+iUwj0HBEFHD1LF2aoWJZ/3xMMQTR0W51UF5m1jYkUJd3mtFIwXpyjyMqX0zF
    fulzl1Ofr7wawJIvq/q54uaHqzXslHbyZzqzPGRnlMZaeAdwc/nkxUjgDsR2KIvQvblT7n
    xRJ28ok4CRWexSguFGh74lnGEoZYHUTcuFCiUCH9LfqjGebZz4xHEDt3lKi0BTEtmOFZMJ
    EJfs+oTUtNx7q1L9V19WwMnEO41kDHvtyWEPVOJoFABB1N3Ywo1SpGekkg9g
X-ME-Proxy: <xmx:sMYVanej7P-uZsYAGcAWqy0oXFRwTWQvBbPRP8h2xMqmnhbuARobCQ>
    <xmx:sMYVaobBUUa00pLC4HhOVqqApmWIVgzEk4WfWZ0xlJpM6GYwqf2e0g>
    <xmx:sMYVakVIbjxfc47MOes2vPyCroyRQbqsGvzrtLI4Q_M6ZjNFRQOq4Q>
    <xmx:sMYVajTJKyRiIbuBK7UlVN2KBLd89rCeFFSF9-BigHNRlSQmuRPfzg>
    <xmx:sMYVavFpkw_Fa2WXflgRdUBsqryWR7YpYRu_yqpHyE7xqx6wF0NFT80o>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 12:13:36 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v5 10/11] geneve: Enable BIG TCP packets
Date: Tue, 26 May 2026 18:11:59 +0200
Message-ID: <20260526161200.1135899-11-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526161200.1135899-1-alice.kernel@fastmail.im>
References: <20260526161200.1135899-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-291815-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,blackwall.org:email,messagingengine.com:dkim,isovalent.com:email,iogearbox.net:email,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Queue-Id: C7F335D9ECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

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
Co-developed-by: Alice Mikityanska <alice@isovalent.com>
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/geneve.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 471419017f30..c92216e64860 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1698,6 +1698,8 @@ static void geneve_setup(struct net_device *dev)
 	dev->max_mtu = IP_MAX_MTU - GENEVE_BASE_HLEN - dev->hard_header_len;
 
 	netif_keep_dst(dev);
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
 	dev->lltx = true;
-- 
2.54.0


