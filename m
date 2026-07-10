Return-Path: <netdev+bounces-306574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g4STOzP4UGri9AIAu9opvQ
	(envelope-from <netdev+bounces-306574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:48:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACC073B67A
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:48:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b="B FqJB6E";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=q7olPTif;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306574-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306574-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A2BF3015714
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7004F420E7D;
	Fri, 10 Jul 2026 13:43:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05942316C
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:43:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691026; cv=none; b=r/qS1apc+fgygN94See7Bv84ma937luoh+mcelcCICDAeyRmX3NQ3c5aD2QLPeqWOGoRSlU5u4MfDfbKxO9MqhKP3F45m4UXSVhU20KkFo3SmY66ZP6Zxh51A88yl6jjnIK/YyNLwzvoAo6yYyjzGP9svJusY1y40+cQrsaj1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691026; c=relaxed/simple;
	bh=J8GAQ3ksdhfDOtSTF4raghXgcq8tWhAozZcOrx6IhL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEdWI6vE13GFjwqAf7OB7uuHFNtsTSpNUOEOgY1QqOd0rAL5EtyaPQ0XpeGkqHhDcDJPD8uXJZgb1SfPdCYP/7qm7Kqy8eK7Gq04TvjhcsQBlRl7M+EAv5/Mde9ehuif2gqwK8q0oqqXVAP52LpIU6PtES5QXLjNh9kxpkMhW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=BFqJB6E+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q7olPTif; arc=none smtp.client-ip=103.168.172.148
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 14FFFEC01CA;
	Fri, 10 Jul 2026 09:43:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 10 Jul 2026 09:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1783691024; x=
	1783777424; bh=aEIzOlE0EdGmRL1iApZBfu9EDjm3tK99roLdK3tD7tQ=; b=B
	FqJB6E+vSVk6iOQKNQsnrWrls4XokvI22ZvlUnSd3TqTHGrGapV93q1jDR2jHd9N
	NvWHM6HttfI2uWt528LVr6HqjgACbPgnfuk6RUyDsssPaAsPl5RIs5jDqNJILT5t
	4vwKTsfVehyROSuwkELZYUwIOHHPLoMB8MvCfu08LVnGMcFMLhUS7TJt2RmxDTW5
	IJmPAMxD+tV9jq5viYJCYVzdxvc6QMTSXDEe0lVRm1CHk0gDlEZTmOv3o67/R0u+
	3O9RG3g+eX2xoFoLpGTWuZJ8osLBS8Ya+q5UYix3gc7/fxe9ttRB+xgt6J97RUiu
	+gDTDceFRA919Nq1wKxRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783691024; x=1783777424; bh=a
	EIzOlE0EdGmRL1iApZBfu9EDjm3tK99roLdK3tD7tQ=; b=q7olPTif/tn0VKDTZ
	a8qEM8i+L6jGBuswMzhg/eJkDZDmACZkSACD1zehLi/yhkaKgRaTXi6pdo7Pb+G4
	mJ2+eeE52OjeyoRk9IZmjkrzZlKJnVR5fDTNJlg6G7yKoNc2qwUINPWNQYs5oN25
	GFtQkF5fTeMfFh/DHon2D30RtPt9Lo6KncT2GpNRplWXIoRcFv7ISTzHUTnKNhzW
	QPEFy0s8DzJSJlaTY4weLo/alsPv75jGG35i6LZR7p0q+Xf16S1B3jCpvq3KMMlR
	yd+6LNEJEduwraXi0TqF1Aanl4CGdghttRGAh1EqGseIfZhAkxv/GFW9ZiFgAo/X
	C69Fg==
X-ME-Sender: <xms:D_dQaimgPgHM8wjz3iQAsMGMNkXMA5O6p-vrrg9zroCr5fgXFazbWg>
    <xme:D_dQaoVF4d5gDLr8gwYPEcdLalonnXzht76AT-fnEMSPxo_98k1NHeG140HoaQq3l
    1VMrB6y5Q1yDYuPTx8wZwBeMfER5edjWeymDCtWecQ1CCgECp2beP8>
X-ME-Received: <xmr:D_dQancz-Czn1ZluruiqvTG1pvgOIMlAvPIXEBnc7IZOt0uIaGhNUGjCAkYJ5pz2Q-K1kpDYFC25r1gTdv5nRiFUby7zWKz0B3nBxQ>
X-ME-Proxy-Cause: dmFkZTEFIDtJybMkhSz+aoCbMXzoIhducNEuhAb0UsdKW5vcb9RmME7tTBBbX+IAN6HHwY
    jY7/HMSMdSWiW5jJB1rcMXZzIQ4BMvX7Tr0yaCVUph3WHVV4fbiicPZHUJdcrlrp7295Cp
    LreCLwrcwqFxVNkzCtLJGVDhvn6zUcFiNQ5fMd+1s1CO9ZZzUPogPBJybRzncs3ZWPs6wa
    TxqPh3N4CWqJSN34wr2B+PIx8mJmH3CcYKvVADIrsqMwDX3woDS9gF3a3eIm4aesJrm7/T
    31W50qtne2kH9Ab0cGetb1iVvNTWqi9GzFymzVT0XTWgFFtDCNjAcOKQnyb1MyGsC8dSRk
    nYbbGf7HKhRUWaB2nnwLvkN5h+H6nxvTCNhtMSD+/gvm9PTP7X01LgAzoFqHIt9riRe4H1
    ZN/JcasklPU3i1PATeWCE5vUaw6aDwlbAxM7Wvwy0mS62VKLnt2Vy2+T+bZxms8yynME97
    1+MYTTvFm0wl+m8Iwys30XqKXas/0Bz/lxxuBSaZL+qHy3TGeLrQ1dxAx5eg1vZLFsveOK
    cJhtOV7hsf4yZ70R/AAWsfviylnEIh7or5kU2jXQeqJFCGe0ZwNn+6ZlIXi4tzxYXdCWHx
    jzJUCpd0tIIHOP4xBt1XktmLqOYqC7g27+TQ2G1PPT6KgP52cU8p2GM16/pA
X-ME-Proxy: <xmx:D_dQamkfBZkfifBhuWUUkrQ6LNFALcySze_9qKvONCN32oP2JIwM_w>
    <xmx:D_dQapDzMZQaywGHVhiej4gORtJzOcyiBUXs4GaWpKb81Hgq3IO5lg>
    <xmx:D_dQaoeSEJ-9RPHd9aldtMiQtmXc88KZGH1FUjHWIutH3OE9krdPJg>
    <xmx:D_dQak6z1KL2qZp2zLMakvyR6CNwJTXtXHyPetrrVoJ-7vwsppYCYQ>
    <xmx:EPdQartaKnQOmYd2g9vAoCTWKh94G53-yEp4YU-bepJKbHXNTHpm_Mc2>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 09:43:43 -0400 (EDT)
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
Subject: [PATCH net-next v9 7/9] vxlan: Enable BIG TCP packets
Date: Fri, 10 Jul 2026 16:42:40 +0300
Message-ID: <20260710134242.216538-8-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710134242.216538-1-alice.kernel@fastmail.im>
References: <20260710134242.216538-1-alice.kernel@fastmail.im>
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
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306574-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email,vger.kernel.org:from_smtp,messagingengine.com:dkim,fastmail.im:from_mime,fastmail.im:dkim,fastmail.im:mid,iogearbox.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3ACC073B67A

From: Alice Mikityanska <alice@isovalent.com>

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

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 67c367cc5662..3a32f067e701 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3370,6 +3370,8 @@ static void vxlan_setup(struct net_device *dev)
 	dev->mangleid_features = NETIF_F_GSO_PARTIAL;
 
 	netif_keep_dst(dev);
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->change_proto_down = true;
 	dev->lltx = true;
-- 
2.54.0


