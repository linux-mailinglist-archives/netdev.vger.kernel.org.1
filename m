Return-Path: <netdev+bounces-298311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e5X0FvQMK2qC1wMAu9opvQ
	(envelope-from <netdev+bounces-298311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:31:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0856674C02
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:30:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm1 header.b=mIDAGKae;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=K4syJ0jF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298311-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298311-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.im;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C253232F71CA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E53C303C87;
	Thu, 11 Jun 2026 19:30:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B5F1DE894
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:30:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206221; cv=none; b=E/aKVbZEz+2D2jAk1pq3dFuUOJ8cxsDoyCUHD4TnmBN4vGXVZ5abZ6ioQtScjh75Sq0/ATejxr5vpmrLhwxKUHkUigjb2nHOr3FTeYtiktYMGBELsY9kIz+eI69ib7TWyY9wfPmFWp+C1tpX1L8kM8Qsh9XjxYOuDdhdn8vPiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206221; c=relaxed/simple;
	bh=2o3ht6WClzkOEGwN2Kxdc+mcwoAG1IxA8Fs1TarxpsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TqLVVvToYNZM+TZ8LhXx5E8mjcVIm3T4Lp3Zy3HOqxmpiyV98EtaUcg/YR/zv2I8Znc0ivEVwfzpdhem5doPMonyC1SAICbvidaWbNS632KUCdfigZJDtY+xHXCrRJmm7PH8QchjRl7I75P9l+8Km/QFhhIAU0wAbizWyOTzla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=mIDAGKae; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K4syJ0jF; arc=none smtp.client-ip=202.12.124.157
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DEAB37A014A;
	Thu, 11 Jun 2026 15:30:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 15:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1781206217; x=1781292617; bh=QDCCtyjRhSyZoybuJtMEL
	mMRcYngRZOnznbofbBtQN0=; b=mIDAGKae4N3BClokciJ6t9VxRQ4ey3JvtOG2F
	SMVIwa7N6RmjxM0tDDA9MkQILJ/kP+SVglLD/8QMSGFcp2MuXPTvXO7NjkLthhr9
	2JrizU9Ry7/qjTRLFtYJf5t9qHqUYYK6isePxWX6q7uSbEpZf1hYEDKTS+tUkjTO
	Gbce2CfJFJcw/e48IprqqP9IOdhNSmHB2Llf1lIbz4MN8Ptp+d1EBf4Qv4gL2MOl
	rvJhd0KA3ZxBD2JkQWu+88r/iHLtJRk1PkQtAYvEhxV89B/8dYtqSdgdlPab6kGE
	cfvc+aQhoqxLR+8sUp6wqwXC7pw5V/M/f6cYd0k0GtcyBzg1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781206217; x=1781292617; bh=QDCCtyjRhSyZoybuJtMELmMRcYngRZOnznb
	ofbBtQN0=; b=K4syJ0jFd/ZZZpSZ6V8YFeFkqHOH+rd7/OIinwm8MQ6NkKUV2Kq
	P5bec2Agzkwjtn7A9quVfjJBjW+8wbsnRyB5GCmAiz3xKbRELpVeP5FWE4MVNV7z
	PLDvTkp76cuud1CAoA0uaSC67Egttc3H8d9kNPOn9srPJ4y/cniX9FHzF59ARfTp
	JqYY7fPGCH+ocdA1FGsu6rWWsQtHIvUHolTPCQHqu4z/bI7p6QhPjUPELJhRCnX/
	Ni2oiSlpKh+Vk0qznzacL52FraclXwep8kXI09UhEsUpH6+SdItAN/f00qvmOnHN
	iOSU3BfweuC4MYy/oN9++bOPIab8Vytwb6A==
X-ME-Sender: <xms:yAwranE_1EpGTns09pfvBYVvN8Bxv31arQ5GEl3_Bh25M6mu9psIgg>
    <xme:yAwravOkhn2j04HFonVQY9btEalHrqVQgHeyREZz7JQJqJ_cARlYYnTp9XYH55c9g
    7Piuglx3RD9vAKvdqt2Txo-REmZi9xYMjlpK41GL30x59F4d0grA9U>
X-ME-Received: <xmr:yAwrajXZ8AUbay7LonVLr-iAng-Dv4uVOeFxFCh69niBdbeLeYL1cZWqGXNePyaQs7PD5S8ICSUJVqeNQJEOz7o>
X-ME-Proxy-Cause: dmFkZTGVRHW5ZNTXtPqtZ9TMLAqyz3eYFuvXq5O6QhXxCHgc/9/XWPUKFlFkl0F6xrb7gk
    eRaZnzrFAydPDeLqLshPxVOvw5RYpay6eWnpygcqiCqFQQOlZ7a8Y6iDHyZ7K3GVRQGsKY
    FjE+HJRy/uq98e+qaBiO63meTRwtIjMG9h28c0ChWFzDvbhrDVPTAVc/sagh0u8gP9+0g2
    m0Rt4yE1y0TZltZjnKRTcrvyRnubrymw1U/tMJcSl85FSc6+ALgb42kIG6SPNnUsje/2/k
    7QDFq2uL9Amb2AlBvu21HAFJZW64MoNmISbinR+R0kL4467i5dvoqRElMY+QWNXtYIyfoo
    rsXoPbRrKwJTM0rJ0bUgQSbTh/ixbaNfgwhieU1HmQAmmsS2H+UmmpWoUsAhnWnOueOpAE
    x3tNKqj9WUYCQ2NViwxcINILk8EhDRc2XAOOK8bprgsPW6cPHeY11jzb1Y9vYCBH7a4C2J
    KNiwe4NNJPEeYpI2FucNKPMVapey9dfGnMt9uT75CDOKXdwAMlO+w6gJfz1X1ttpUi+D3o
    2eD5sSy2KEXU+zslR1iwsTv3rJky9Y/Nqc69nvdLldPL5DMVwMbl+1MKhLJDar1E/28Yu0
    Mi+yM/Ai96hB7C1KHJ1P+EtsLRfpR7Oplne9LWuU50Zznyme5UQ+NvJ1F9Qg
X-ME-Proxy: <xmx:yAwramxXje001OTcOfmYdD78NkHKbgcWJzvpqhkHmu8CGbNKcekxJw>
    <xmx:yAwrajO_gZ3GWlzUvRZc3D9XzC3bx0flH35KJpLmJl9UVGtBHPbVgg>
    <xmx:yAwraopAt_3uJR5mMHMuDyiwTp2VhnwLV9dPiRCep-6uMVqC4SwFCw>
    <xmx:yAwraq9AvION_-v-7ehRe1WMebVDkOM3J-syxIdBN_fu5lkrTctwZQ>
    <xmx:yQwrahdD1z0e12JWtx8RQ5g2uFi43EafiIvIT_SmQBT-Ie7XRDqd3-Gc>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 15:30:16 -0400 (EDT)
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
Subject: [PATCH net-next v7 00/11] BIG TCP for UDP tunnels
Date: Thu, 11 Jun 2026 21:29:44 +0200
Message-ID: <20260611192955.604661-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
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
	TAGGED_FROM(0.00)[bounces-298311-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,isovalent.com:email,sashiko.dev:url,fastmail.im:dkim,fastmail.im:mid,fastmail.im:from_mime,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0856674C02

From: Alice Mikityanska <alice@isovalent.com>

This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
IPv6 BIG TCP doesn't require stripping the HBH in all various
combinations in tunneled traffic, adding BIG TCP becomes feasible.

Patches 01-02 are small fixups to some related code that I'm changing in
the series.

Patch 03 adds accessors for the length field in the UDP header, as
suggested by Paolo in review. The usage of udp_set_len is then added in
the following patches that start using length=0 in BIG TCP UDP packets.

Patches 04-06 close the gaps that prevent BIG TCP packets from going
through UDP tunnel code.

Patch 07 validates packets in udp_gro_receive to exclude packets with
length=0 from GRO aggregation.

Patch 08 is for proper formatting in tcpdump (set UDP len to 0 rather
than a trimmed value on overflow).

Patches 09-10 bump up tso_max_size for VXLAN and GENEVE.

Patch 11 adds selftests.

Thanks all!

v7 changes: Addressed Paolo's comments to properly block malformed
packets with UDP length=0 at udp_rcv level.

v6: https://lore.kernel.org/netdev/20260602093931.516281-1-alice.kernel@fastmail.im/

v6 changes: Lowered the packets threshold in the selftest to pass
upstream CI on debug kernels, also made it configurable.

v5: https://lore.kernel.org/netdev/20260526161200.1135899-1-alice.kernel@fastmail.im/

v5 changes: Rebased, dropped one of the patches that came in via the net
tree, addressed an overflow in nsim_do_psp found by Sashiko.

v4: https://lore.kernel.org/netdev/20260512165648.386518-1-alice.kernel@fastmail.im/

v4 changes: Rebased, addressed Sashiko AI review [1] and Willem's
comment about netperf flags.

My comments on Sashiko AI review per patch:

01: I'd prefer to keep the cases that I haven't tested outside of the
scope of this series, which is for VXLAN/GENEVE tunnels, not for ESP.

02: The patch doesn't have behavioral changes other than fixing the
checksum. The final uh->len assignment assigns the actual length, not
64k.

03: The check can't be loosened, because total_len is also assigned to
UDP length. BIG TCP works in the mode without GRO hint option.

04: Fixed the fallback value for udplen. BIG TCP is fine, it's the
uh->len = 0 case, uh->len can't exceed 64k.

05: In the BIG TCP case, partial GSO splits the SKB in two. If full
segmentation is needed, the SKB is split in many MSS-sized SKBs without
fragments.

06: Invalid packets from the wire are addressed in 08.

07: __udp_gso_segment only handles UDP GSO packets, which can't be
bigger than 64k. Kept udp_set_len_short in nf_nat_mangle_udp_packet, as
the function doesn't support BIG TCP packets anyway (see
mangle_contents).

08: udp_gro_receive handles packets before aggregation, there are no BIG
TCP packets at this point. RFC 768 doesn't say that padded UDP packets
are valid. Real jumbograms don't seem to be supported in this path
anyway.

09: The packet goes to skb_udp_tunnel_segment, not __udp_gso_segment.
__skb_udp_tunnel_segment handles this case.

12: Improved process cleanup by killing everything inside netns before
deleting them, and by avoiding killing netserver outside of netns.
netperf with -r in TCP_STREAM mode works, and the option has the
intended effect, but I replaced it with -m. Added dependency check for
tcpdump.

[1]: https://sashiko.dev/#/patchset/20260410150943.993350-1-alice.kernel%40fastmail.im

v3: https://lore.kernel.org/netdev/20260410150943.993350-1-alice.kernel@fastmail.im/

v3 changes: Fixed the redirect in the selftest, rebased over my L2TP fix
[2] for the syzbot report [3].

[2]: https://lore.kernel.org/netdev/20260403174949.843941-1-alice.kernel@fastmail.im/
[3]: https://lore.kernel.org/netdev/69a1dfba.050a0220.3a55be.0026.GAE@google.com/

v2: https://lore.kernel.org/netdev/20260226201600.222044-1-alice.kernel@fastmail.im/

v2 changes: Addressed the review comments: added UDP len helpers,
consolidated UDP len sanity checks in patch 08 into one, added
selftests. Added fixups to related code (patch 01-03).

v1: https://lore.kernel.org/netdev/20250923134742.1399800-1-maxtram95@gmail.com/

Alice Mikityanska (10):
  net/sched: act_csum: don't mangle UDP tunnel GSO packets
  geneve: Fix off-by-one comparing with GRO_LEGACY_MAX_SIZE
  net: Use helpers to get/set UDP len tree-wide
  net: Enable BIG TCP with partial GSO
  udp: Support BIG TCP GSO packets where they can occur
  udp: Support gro_ipv4_max_size > 65536
  udp: Validate UDP length in udp_gro_receive
  udp: Set length in UDP header to 0 for big GSO packets
  vxlan: Enable BIG TCP packets
  selftests: net: Add a test for BIG TCP in UDP tunnels

Daniel Borkmann (1):
  geneve: Enable BIG TCP packets

 drivers/infiniband/core/lag.c                 |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.c           |   4 +-
 drivers/net/amt.c                             |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   2 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +-
 .../ethernet/mellanox/mlx5/core/en_selftest.c |   2 +-
 drivers/net/ethernet/sfc/falcon/selftest.c    |   4 +-
 drivers/net/ethernet/sfc/selftest.c           |   4 +-
 drivers/net/ethernet/sfc/siena/selftest.c     |   4 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c   |   2 +-
 .../stmicro/stmmac/stmmac_selftests.c         |   4 +-
 drivers/net/geneve.c                          |   6 +-
 drivers/net/netconsole.c                      |   2 +-
 drivers/net/netdevsim/dev.c                   |   2 +-
 drivers/net/netdevsim/psample.c               |   2 +-
 drivers/net/netdevsim/psp.c                   |   8 +-
 drivers/net/vxlan/vxlan_core.c                |   2 +
 drivers/net/wireguard/receive.c               |   2 +-
 include/linux/udp.h                           |  27 ++++
 include/trace/events/icmp.h                   |   2 +-
 lib/tests/blackhole_dev_kunit.c               |   2 +-
 net/6lowpan/nhc_udp.c                         |  10 +-
 net/core/pktgen.c                             |   4 +-
 net/core/selftests.c                          |   4 +-
 net/core/skbuff.c                             |  10 +-
 net/core/tso.c                                |   3 +-
 net/ipv4/esp4.c                               |   2 +-
 net/ipv4/fou_core.c                           |   2 +-
 net/ipv4/ipconfig.c                           |   6 +-
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c   |   4 +-
 net/ipv4/route.c                              |   2 +-
 net/ipv4/udp.c                                |   7 +-
 net/ipv4/udp_offload.c                        |  49 +++---
 net/ipv4/udp_tunnel_core.c                    |   2 +-
 net/ipv6/esp6.c                               |   5 +-
 net/ipv6/fou6.c                               |   2 +-
 net/ipv6/ip6_udp_tunnel.c                     |   2 +-
 net/ipv6/udp.c                                |   7 +-
 net/ipv6/udp_offload.c                        |   2 +-
 net/l2tp/l2tp_core.c                          |   2 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |   2 +-
 net/netfilter/nf_conntrack_proto_udp.c        |  15 +-
 net/netfilter/nf_log_syslog.c                 |   2 +-
 net/netfilter/nf_nat_helper.c                 |   2 +-
 net/psp/psp_main.c                            |   2 +-
 net/sched/act_csum.c                          |  12 +-
 net/xfrm/xfrm_nat_keepalive.c                 |   2 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/big_tcp_tunnels.sh  | 151 ++++++++++++++++++
 53 files changed, 310 insertions(+), 105 deletions(-)
 create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh

-- 
2.54.0


