Return-Path: <netdev+bounces-298320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tB58K1gNK2qW1wMAu9opvQ
	(envelope-from <netdev+bounces-298320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:32:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B310674C47
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:32:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm1 header.b="h Z8kext";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=HMcF6BZN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298320-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298320-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.im;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E3931356DC
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8912E7386;
	Thu, 11 Jun 2026 19:31:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53129DB9A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:31:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206275; cv=none; b=nxApFBAPjpw9P/tSN2fTVWS9UXk1qPQtZgga+FKROUWk8aC3Mo9R2BmirK4y0MYUdxu84jvuLqRCImvSO/TVYDHteHZHwD9kKNoMFltm+WRB2ogCFlYIvzj4blP15IVympRsBuafAegEHxdHFAZyrMbILIhkduWO/woEiSzeM6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206275; c=relaxed/simple;
	bh=J8GAQ3ksdhfDOtSTF4raghXgcq8tWhAozZcOrx6IhL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRL4B2L00gR+xvv8ExYMjXtC/vTOEZbgXQ5L+ZZaE3kjgqKoE36xUGdNhOUHjv3GcYx/cjVtlBLQSs30hWAeqr87NLe+WOZCM6Kgf2Kv989/w/Iv+rVtiGiyPhaC0JbuwS8KFHrA9TDZdW3cfvvXRzpnno9QMVJ3Dd/01bKphh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=hZ8kextC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HMcF6BZN; arc=none smtp.client-ip=202.12.124.147
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C994D1D00105;
	Thu, 11 Jun 2026 15:31:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 11 Jun 2026 15:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781206272; x=
	1781292672; bh=aEIzOlE0EdGmRL1iApZBfu9EDjm3tK99roLdK3tD7tQ=; b=h
	Z8kextCkmXrgD6RNz8iC+54mvqo+GMpFF5KsA7Fg9W/MibRIDvPfYQOm+nlgWWBf
	wo517yfQhbt6WsRDCcIleocSdXcLcMtzr4sMjHdwW3t+gG4akF9ZenD4DNw5aHiS
	FddaL1Xk0CjWA+gYhKcoCB2qoqMt9CvUO9sP4efadYNNh3YpXiAmxCd1tL7Roiyl
	eRIYkMjtKG6VWIIczUGR6mNMiISnUps1Z71uqJpkVd2UK4Gu+0WokFfQV3KNFXF3
	1ALyIi1BM3yaC3gPnTXYPK13knwOYlxAmvMWvax67aJZY/zkIBMnPzkHLF+ytjUs
	JKtjZjkbhKAfYJmlUwHDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781206272; x=1781292672; bh=a
	EIzOlE0EdGmRL1iApZBfu9EDjm3tK99roLdK3tD7tQ=; b=HMcF6BZNBnpB6n/I6
	ZUwaQvyc/J6eEemvxeIxL9/Xdj89sAeIhcWim0Heq97lR21OAiFEHzh/PHMuJ0xs
	pVE7CePnkbSMPQgZmUhVhD5Qp+86yDi2acj3+bN2BMzg8HEU3Rtk/YFOV4Q7E14q
	RuhF40FSJWK1oirntaacQNiiZ2qQNZUkI/8JghViFNg4IDu7G4klGY/VdAnp1be8
	BODUtAHDaJ2UNXD3TbGIUPp1CiHyTVpdNZ/BlJ04z5xBoBdChLFfpvv+gTwqxKAI
	ssGdXl3Dx8udGjsm8714UdRSTX4RZ2Zu9LtweCwX9X6IyF78afIvmW+SbtxdB3Ud
	5dvmA==
X-ME-Sender: <xms:AA0rah5xVt90Sq9aNoc48j2zbCy-K0GUSxMpKX5qTHZMzaoWBAGoSg>
    <xme:AA0ratZbnewnAHzIgvU4SpO0p7GP0qC-vMQTh25eKq1677XhtcqBD6hm2RB37-QT1
    dML6NWCeQxL28WAWTMCCOgrB6ed5ReB3T7FBpGSUnyimrub3dXHbw>
X-ME-Received: <xmr:AA0ravR5xtKs7Q7TmoCw-cEF8RHas_SrxRIRfpaiX9Z8z4pDTgxRrk0aoNncorZyV-sGNu_ci_YTuh8H3jo-bZE>
X-ME-Proxy-Cause: dmFkZTEiC3WdhRi6lmpvrurG1zsBSCtiqP0WNrqAbghd5WJJ5VA7rTMHapznV9StKJaapp
    RCFRaoACDzmV+WD4oXwzhVyqAYewgJwskY7+pzj89kGgG6Z5gh5qwjqnnl1xPZ9xw9XTL3
    6h0yQhC9JWLW9+mdqRsn8FaDYVGkm04cbHUvo+O2iHxAKiVWkwOc7fmUFydM3Q3w8Zl56u
    v+GK2GCObb3b4V4RDlvLsMODXfS6N+5oUdni3ao7DuI/y5kjlxXKXH9JMIpsen+KUYBZ/y
    QM6GhQcs+90PA2n4UkkP5wtLFs/TKnXuu0mgwtrACzJAoOCVpXiPf0MWRzXp2RALkPmoBa
    MjggsC3rfC6GiSNdDdc79OUOWX++bWnX4w88cS+5tt2quYbUxEkfiTklEvEjemgq2CftlH
    VS4kQvVMwTeSdrCJY5DjL0oYsnH5E2jc8hIaGFmqb0CK/viMRQdeT/75B90AWFdj2IzCDH
    DsUhrvxH7UGdTrjPUG862o1klCsJnxPjmZVwKHDw+AXDObysXuJb1a7dpJb4HvmO7ZHQKC
    jkwm0kb2EjjKk8SXJyvGjkDDeXtKuiL0oxDRxLMAwTPI9OdGVwUZy5WkarF2hDHLI6xj6L
    VlQ2xN3r3DxSYe77QgWk/C6TUDHah183KcaiUeDFlSz4/AQBUb3Ykwptw/fQ
X-ME-Proxy: <xmx:AA0raqJwaeYYCmOytf68Zoh96YKixV2PpZ4qJ4zATonlyKTGQAYomQ>
    <xmx:AA0ratW-bfdLK_YNqeLzu6hUCCxQYTse9C3lYJn8uu_tRukgULUESg>
    <xmx:AA0raugcwtE9_GrSaNWo3DMtDBPyw2RkijFF7zenCS8geVAyNwt83g>
    <xmx:AA0rapvEK2pDAia7XOMYVVveuWy20foU3amWinx-MscQRPgk1_DkHA>
    <xmx:AA0ravViYu-FfEz-YP5yjgwRPQ9w2tLEdv_PZsn2Z_cQP0-lZWtRf1qX>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 15:31:11 -0400 (EDT)
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
Subject: [PATCH net-next v7 09/11] vxlan: Enable BIG TCP packets
Date: Thu, 11 Jun 2026 21:29:53 +0200
Message-ID: <20260611192955.604661-10-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298320-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fastmail.im:dkim,fastmail.im:mid,fastmail.im:from_mime,messagingengine.com:dkim,vger.kernel.org:from_smtp,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B310674C47

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


