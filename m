Return-Path: <netdev+bounces-298321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f0MfG5wNK2qz1wMAu9opvQ
	(envelope-from <netdev+bounces-298321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:33:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EFF674C51
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:33:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm1 header.b="L 8/1G30";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=CR42EJ7m;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298321-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298321-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.im;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D98F53013A87
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3C530C62E;
	Thu, 11 Jun 2026 19:31:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FC52D73A6
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:31:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206281; cv=none; b=JKQAPLhgzSB7p7n3fDFZLy9pJK5i1D8vKug92cldBmIDLksmsJANDIHjcFi7azk9Qq12v3/EvjKDR6zGIFbfntBICfgVqKHHTWbhcWmVyvXj85KZn/ulZs2A0KM1x6hJp8QB0vrBSawESICdg7w5agEF750IiyuEBGGrxoc4ru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206281; c=relaxed/simple;
	bh=Fj0wqjxvISBJI/+0rHQQGpEOaIBzVgPEK9xfYYe0dsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtoVeofJ3gdO0K0xBVvb10Be2xD1ofUvUSPWhJQqlxY1slzVkaUVHKnsQNwIEhPDC33tBWU8mmtoG+FmRxG/SaGV8LlD+1s7lBxAUJ5xmX5Wog5hb6PbJKrO077iuL3h/xnSvXfdB2EQGY8L+f7KvEoL5QQ8VVLfjKWlsTYjSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=L8/1G30z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CR42EJ7m; arc=none smtp.client-ip=202.12.124.147
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F70C1D0001A;
	Thu, 11 Jun 2026 15:31:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 11 Jun 2026 15:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781206278; x=
	1781292678; bh=/6r3qP/pubRAVufVLiYRtmdI4D1kyhjbz9VJbrj4o/4=; b=L
	8/1G30zH3xmAG6xloYxCcw3oT97WnkLsfkUnsQqJNYAkao+NRNm8A/RgzAUpoQUG
	dReO0Qq0WXkTSf9jHP1dritCAKgx5P+zxu0P/rz5cva6EI+akMuJEEJ4mw3HUucx
	PKmPZBn6Y/pUPEA0YgGJ1/CVBUL65HdX+EUilEGYzBL/7TvADPIThaXSRlkAPgY2
	2q8W458GWxePc8vtfexiLWLL+ivRpUwpa4CVdwI/8/4juWovZlTQcL0YpKTZNcX0
	Hr0/iIO3+/zeuwiMJd9tFsogU+CklaIzZvEQvd60NUqnvo44yDDAAOWlS1cGODLJ
	90F5FlNFBQZp3czyX0GZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781206278; x=1781292678; bh=/
	6r3qP/pubRAVufVLiYRtmdI4D1kyhjbz9VJbrj4o/4=; b=CR42EJ7mqFS81LETK
	uVewewrzX+EQCVR7VJ4qH0KwO45cUOd/VfXO9WTX85wu+sBGyN28OAI1emQeBkCx
	5YP21kHAMJJqmlj1jxVdO6Wuf3Tq6679aOI5+i+F5UbJBPoQIjaPe8uvC7+wmIwO
	ckIlgPSXc3cFUC0YfFO2HDywlZG/AW8zac9/g3kv//x+OcEb1tBGEhwnMNkNGr+X
	TMS1dVh/5XfMYs963jejG2MApBT0ObVLJAaPGq8HjeqnNWM8qRvfCgl/r8FyF7hx
	Zn5DmMY27RcW+wjZGXMq6rNvHT//qWsyyEgpm8wKRStzjqN72C2GZZMcFrwZj/eD
	suxIA==
X-ME-Sender: <xms:Bg0ragPuY607IKbxBezrVpEgJAhMt1WJRwuPn-9oOt2T1ouB-UlGUg>
    <xme:Bg0raldHrX-SNtsHT_-h9hBT2D92ZHLuw2ld7AObdL5TnSP883RJ0ndBA7G91OoeG
    rLoPiNmqFifZ718GWTKPHUOHvsbVMjjAYdWQ98-YeTXSn87cpMifA>
X-ME-Received: <xmr:Bg0rauGlD7fwQqiwHQc9jeLHvlTmv8ErxhPtEThiBXm_ymLHhZK9dKXI5yS-bNCZDlgQ-GnC8psBFECmJQyxwa8>
X-ME-Proxy-Cause: dmFkZTEnTv/d6PMF6jx9p/Ef8EwoH4r30EKZEqQguW34CNskrEb5Yd36/EvvFkllSqlxuq
    Bw7vNJkNGq3pltK9NJ9Uu9jrLm3RbEhir6msLAsoRQv+Bfes6LJ0YhugVIaqha6TjHIrDS
    sTCJYGb98cmeVY686UXgiTsbVGKbnDt8wJpgzAEwLr9SrkGlj+oyEq7rmslCekgfuJCFYh
    dAEahZv9s2AD3u8Ab5BgJ7c2CTfiqOnELZ80+sS78srYiFdDNpnNO78KinEAkgI+Xag4AL
    RFNvcr+PFUKGP47d2rGOfF6kNZFGzz8ldz/iAu6uqJgVKhkqsrhYv4nSDDq6TkSBJhWTOC
    eN6vNMEwbuz0ZQkZPcUOKRFzIC4rY0mjMX9NDIF+TeLyMKQNqbo35J7paU+fZeCp/++s6h
    6THkSb1i6+62TRJcx6MV0Yqo8TSBIHpf2llcY5IvTccM/vVRq3D5TQFz7OOOItgREbr+RA
    YvcjQ1IgM9QfZ3klplwZdhCPJpdYK00ZB6ZFk2AhaA3y+fJydN6CWNIc6St/wpkloqDUO4
    iSa1Nsz8PvY+LSWeoX/G5AVS+N8hYmSTv/dGRPz96AX0WqxoTlluRWdmemcIWTQ8edcEIM
    UGoazRn1uo24kS3+NqRtdyO+/htix3lozP3o/JwWhXBq5ksNNM3U3mzI/Ldw
X-ME-Proxy: <xmx:Bg0raosShNsxGxC5TcY5SyG6cXzNvhJ6BzfPAbMxdzip3Eho1yly8g>
    <xmx:Bg0ragoFCJLG2xlv2nn6jJoeDrUgTXmMI9uOwL5rCq4CUQmPnah8dw>
    <xmx:Bg0ranmfYe-5LN4BJllPn5w64Q_HSbRdJls2vn2Z-72EEdPYmQkMkQ>
    <xmx:Bg0raliiEHKgFFSLoN3ZtkkDBacAxkimmj3U8z1pD65yYi-R2PoXSA>
    <xmx:Bg0rar5HKTZb2MvpQvsF4tPElzmNdpNRP0fkpMS1HfisZ3nmYGbp7iPD>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 15:31:17 -0400 (EDT)
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
Subject: [PATCH net-next v7 10/11] geneve: Enable BIG TCP packets
Date: Thu, 11 Jun 2026 21:29:54 +0200
Message-ID: <20260611192955.604661-11-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611192955.604661-1-alice.kernel@fastmail.im>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298321-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fastmail.im:dkim,fastmail.im:mid,fastmail.im:from_mime,messagingengine.com:dkim,blackwall.org:email,vger.kernel.org:from_smtp,iogearbox.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3EFF674C51

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
index f5ea426c7deb..52c5453ac7d8 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1731,6 +1731,8 @@ static void geneve_setup(struct net_device *dev)
 	dev->max_mtu = IP_MAX_MTU - GENEVE_BASE_HLEN - dev->hard_header_len;
 
 	netif_keep_dst(dev);
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
 	dev->lltx = true;
-- 
2.54.0


