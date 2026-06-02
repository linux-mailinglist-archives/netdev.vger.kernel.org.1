Return-Path: <netdev+bounces-294121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOdpJwynHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:49:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF9862BDCA
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C505C3001BE7
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746383D171E;
	Tue,  2 Jun 2026 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Fnmyzy5t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fu5W+klU"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04F3D1AB7
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393271; cv=none; b=e4oRhRrMPOEVL2GEJSwnAO9emkgQvGknW19sOMiXqnwJ6EXbBUi7Mta2G4QOdF5SsM98TyRzVNjl15dk88Q20Eh2MNvX/i/GcqxFJkdVH3cjBPww1fDWjzsrXYuvn/ZPOB6q6FEQbZSXeAjRvaMsd/Mq7FICelXdtbScKl/IS6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393271; c=relaxed/simple;
	bh=J8GAQ3ksdhfDOtSTF4raghXgcq8tWhAozZcOrx6IhL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liSChI3EQHVLJyCn/Mi1qoroiJogC+MigNj58+6Uh7SZNKXebIXiXYmIMth7mnnAKsDsYv7iiURYFoBuuo3QS4wCds/JjUT4UnZD1wswN0IAGnH2ZUtCOuqVzWjgkPJl6gUsi+bAo7IUOo4bs0RXftez3qpxXGTwBiktwF1wbWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Fnmyzy5t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fu5W+klU; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A6897A0124;
	Tue,  2 Jun 2026 05:41:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 02 Jun 2026 05:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780393268; x=
	1780479668; bh=aEIzOlE0EdGmRL1iApZBfu9EDjm3tK99roLdK3tD7tQ=; b=F
	nmyzy5tuq5KrS9GVhDJBUZh6pXDRl8VkTF+ZOPVGFP08gtBAEcYv/BhOOOEGoE55
	4dc40SuUgrm8s6lARgCjG3NxWyXFOlRZ28V1YF8ZbJuC0WdUeM6M+NL/Ufal4NI7
	G9w4eYiboQRas4Fz9DHOwqSShgV4aT7ASymZ7m+FjwRIoaT9sbKfpX2xfWjqA26B
	FTEyYVQew8RErfg0gSCvmlLCFKZpm6O3j+pgH1kmpAEzeOLyuj3QPN+BGAgSRQxG
	D8MK07kkYIo3Hf1LkMCpdsFMh+HyK5HguslSDtsizurQ9uKxiQuIghHiArm0Z3JL
	Gv2rF9z9/HSgdkqSZV83A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780393268; x=1780479668; bh=a
	EIzOlE0EdGmRL1iApZBfu9EDjm3tK99roLdK3tD7tQ=; b=fu5W+klU5rvgzhPck
	ScU9JQGMeBvDtGdPqOfF6pgBXSzjpBKycr0g1UrNHMjRiN8mNXf/BL0NgxwjVEVo
	2/qpQlOHszwVfbxt6MRihHnDeV1PxtjVdmrXj3pz8UuQVdeENBU9ywVuKH4HMVdK
	AMNUsH4uXy9/KJCj8h52eGj9F1m4XlmL+UnV9p56wgnE4OUhyneGfs6PWwFg+bgR
	M2e9UZtHugFBTv/YcekdITQe+BV8yAFRFvnVjSIuUPmjQ9CWPC9OXpvh5ndoKZey
	ayoESMKanGa5qQRD9eaHPkaiU0Sak09PnlKzGp/22HWP8F+PXP5khYocZqk+OhsL
	8JS9g==
X-ME-Sender: <xms:NKUeavaXXbS3vxHLrdFzaP0czOa5oHHjOqNROAUXjsCz7L2vn4ePAA>
    <xme:NKUeas71riyLWOlQxTg6LSqXQvaiow0yngnuDLGiw1oZ5xrJmUIjcfHJ_pL7oiho-
    YJ8PeSALJCTKhO6X-WKZMfE8y4CZH2e2a9v0HN4Wq3YyD164E5jKUQ>
X-ME-Received: <xmr:NKUeaozYOesF_Y7l_Zuk0G5BOfoGfrekm6Uyt8UGGOKIjM5VBjmmB9nnv3qQS2XsLLuXMMqSOljaTeKmh2o>
X-ME-Proxy-Cause: dmFkZTE9tBEANdqxv95NqhdHHdXhj1o4AkdIVzwb8jjM1HqleHqSgAphWGPVWdofWa5NaJ
    ER1+bdTKu4iuMySGow/dR0s0eFoVOC/6dTzun6tkdzaeOOWbtEG06zBndcZtwjRhyaEqpS
    LIdhK0NEaayYQ6YzxQmC4sX50yKzwArmaEuiPOivokZV1AkyAlAc9SSPgZ1GnEgo3o6dDk
    bEn0w3Mqi9k2vnkZorhnXwd9uFf0d2PQPwaZiDxl+oi2Y7rHQyMVhjEWYHKl6/Ux+ouroe
    m5aDk5b3HiFHY/885fmPi0ztz+42JdSIp35bNIg/uJarg5ZvUClTXutfFP+vZJrYnhYFVI
    Y1Q7I4JvLCU4/qEaTK28n5JjuUKAjZBV/InOOMHER9jbCN0UnW9GL3qxTDcfLe+BqRNNbK
    L73CAz39AQOlLCYD5aKSVut+CvpeAGt6BLTPVOAjbdr96Qwylz8grVzIFdRrDj57KcU0QI
    9rf+Q+RmTYl5Ic195OAK52i1OZJTGjTHI+PuSefcmlu8wuP2QEXaGHKESkfcC7kR2UZVm7
    Y/0yn9J1W4xHwcPC9yW+UVkznJ+5cwOnQK5QOFXoetNf8sbC+eukBMScBXjbJaffW0+esn
    YMvvIXLGBJturpdov9kQ/xFKnDuG37dx4RgPJvxaT74HUAwT0c9xF3LOV6+Q
X-ME-Proxy: <xmx:NKUealpHpfp6kvxfb9goLDgDfQ1X-AWTd0bSICFwBtMwwKzmN7lS4w>
    <xmx:NKUeai17cdnIZIuaO4AZHpjKmh9QlIT_BJrdVfWRm3Omd2sGlbIfpg>
    <xmx:NKUeamBesFk4HC9pD-uRScw6zdv-lbqqUkIhYfbtRv7IY0FY0k0rlA>
    <xmx:NKUearN0D8TORaDb2GtgEysSxhMMq7udUC26z5gJTwzSCDYfh9RiNA>
    <xmx:NKUearhuQzSmXWjMKklurWWBVcRfGXXkLhR6chVgTfCpIQ81Kk5QnMs->
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:41:07 -0400 (EDT)
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
Subject: [PATCH net-next v6 09/11] vxlan: Enable BIG TCP packets
Date: Tue,  2 Jun 2026 11:39:29 +0200
Message-ID: <20260602093931.516281-10-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602093931.516281-1-alice.kernel@fastmail.im>
References: <20260602093931.516281-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2DF9862BDCA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294121-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:dkim,fastmail.im:mid,isovalent.com:email,blackwall.org:email,iogearbox.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

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


