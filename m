Return-Path: <netdev+bounces-305185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5T85Fyr0S2qedgEAu9opvQ
	(envelope-from <netdev+bounces-305185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:30:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E97E714871
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:30:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b=CTLed4KJ;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="C9C4Z9c/";
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305185-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305185-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B21A302FDAB
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F917436BF4;
	Mon,  6 Jul 2026 18:20:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E329436BCE
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 18:20:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362039; cv=none; b=Swwkh94IpN+kNnH7A9q9996MCEBlYlm+BnF1OUiKecPidWnQ4DGdWZsodbqb5CTTpjY3zXk5NK2X4asHjOlnsZ0+8YAkRreWjbROCoOSglNzm4USNCrOyQFDDXrtBDLWOFkIy2AWuVdejZbdxr9kmesIj/Xnj5xZq+15iBFV7TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362039; c=relaxed/simple;
	bh=H35183HW7vA7mQc3hmYy8ZNFfX5tNujI6rsWMv4Tj9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pn7kf6RU/mpdarXTwFl966fuYipaMQn9KajL5ZUi7UASNFhZ0/9iGEBedDzjL2wS1pHaZ9TZ0UdIe0L/NfbYPoKi3Yo4hPSDzI7RjcBUl/mRn52qHgZkBVUeU9GikpEzOLF1FmGkOiB+ZpexzlP1Huh8v8YAtXQUsC8XgwC/iZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=CTLed4KJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C9C4Z9c/; arc=none smtp.client-ip=103.168.172.144
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id D1757EC00C9;
	Mon,  6 Jul 2026 14:20:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 06 Jul 2026 14:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1783362035; x=1783448435; bh=kPL1RA5c2oAG+pEjwbkyu
	1r3npoxrJrYZitB34pmiP0=; b=CTLed4KJ7sduNM22VL0hYk/GxglJaSY4r50N8
	nrF3dO2HAL7tu+4CvFKnw5PGWAT53aonTtnyBC643QBU3Wwny2ZnZ3fQQtjBZ0Ln
	D8r4NXad5PLas+zuLZvzKQlJmSfxk71cy/GL/JJsEM1ToXcf8YHByk9rnelY+Ui6
	HjlJw1SYpBc6bKa4/Wc/QqKdmwR8/zIX1nNGmmharRKcRzEJ1cU/8vm0mB0QHQiP
	lWGxCtu1CL1kD5OfMjng+OvpHx2QUNr5zkkj6+qM2MXSBwa1KgWLS3fBc4hLzOY4
	qQkEWka3v61oHp7LZBA7N8zTGnfZECAmwxzV6mmoVfNmOOfKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783362035; x=1783448435; bh=kPL1RA5c2oAG+pEjwbkyu1r3npoxrJrYZit
	B34pmiP0=; b=C9C4Z9c/fxGzc+2hLP6OCrP2+N3W+U0D9o3C1jZQX3L45to+6ST
	/liuRQdTdQUj+dIjFrEeJxhtTn4HTN+LZtZU/lFTb/seEHKbubebvdb6aIK0FML/
	A7fvIyN+bfYVZiDsmuVLCopqwLG1yu45pOm+5Kzy9Rx48GbS36fM0Ouewukrc/Xo
	ArwKsvwJwzSIlylE+oYbnH3c2A6AwIRnkGWMhDke6yHTg7rzbFJkcWL+ktl5ifTc
	8clcp9tFusLX/4qfJE+zm8nZCRNDhnae4QNSJZYnLvMJzMX/6m19MzDJwB0LKQeM
	Zuhrpjeqw1q9KLrmbAdkulN07IZK1Der58A==
X-ME-Sender: <xms:8_FLakJrJOWd2z5Opt47pQ1Pe99qnZDM90w4kOOQxlttDIKzyUv44w>
    <xme:8_FLaio1PUWlSop0wURIrhB9c4Z7u60yW0IuuKW5WV_zk10gTsx-Nbmie7i33LEsd
    yI8PiWj-nTv783aK4640-S7L-7lkaEQGDCWdpllOx0n-X1ESYtTX_w>
X-ME-Received: <xmr:8_FLarh6h13OjXatjhbJomqMlQ5k3oRYV2z64iFyaDogniARW3-kTFs5Mm8>
X-ME-Proxy-Cause: dmFkZTFDNV4TCSYTGDDwqxrTt2wUmq5SXJTExHI+ftg3CIXmiEXT9Cdxpa8wnXYLgO9l8x
    2f2KypsXYbqERuZ51r6jNsCS7okBAUnKVgTPWCcPCyeaHZ5FOgOXwsNX094GgSiX4vfCVp
    jJixMaeEIbF5j/lrcWrO68n1pBQNkUBW0wu9lmHTwlClUJC4+FuH2lLzZkxuunM3OIOwCc
    bmalj1eVV2we5H5lKzX3vZg2b6UQPHlguXkXAPT6FaoOGMam3z3czhPlRms4rdi+TyuzVx
    7RR3fLzvPd0Ap0UtaCek9BHrAGedgaS2FgABCcK1ksw1tJwnoIFquEBh7dWaYSCHhymlPG
    sC/1L/vCW7rVzWi7j8gr5yy/NeqkDV9jtFDvhONMamjR7BrmkNknabgjM+RsIdeOH8Chp+
    aBCz3PkWOQQeBmW+olNZ/po1/HQ2bMaiV0sG45ScSzY/CKU+PqaYoYnNvW+dw4bvKek0YJ
    jH8IRx9zxDtSy+xz84GQ31B7HD1BLK4Je0P1GMvhIKTLBxxC2OmIpN6dN/EiXCPaWSdRjP
    0dbnvwSmVFHuEeFLJE4CFI9pgTAH9pqPOeJHjJaOobiFeLYxWDLgrYvGaCq2eVN5uIZ5ba
    lO9SW+tdjg6sRWuQnKEWEPGkifPuoBnNgVyWyeXCwPI9K7GcH9eWCcKHd/hQ
X-ME-Proxy: <xmx:8_FLahbc9g14sc34Ub2U-K06GHIFX3F7wxr8Z0bYo7RMDDtJxnL0gg>
    <xmx:8_FLajm3HoSZhAldulm5Mxr6Ys-9It0O9-g-8TBu_8q-DLH1nqQRTw>
    <xmx:8_FLany3dWy33Wx91Ldqrn9TKUjErBCJmeSTxpxo4mz7CLeaQZYkrg>
    <xmx:8_FLap-N9X0KpbdZfWPGUETghRYYXn3jrYQrJ6yDfxATvKUIrVfVRw>
    <xmx:8_FLaulf7JJN9PwLQE6MDJWAADCXCT-9o6cObAOI0O_es5JxEKtgF5r5>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 14:20:34 -0400 (EDT)
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
Subject: [PATCH net-next v8 0/9] BIG TCP for UDP tunnels
Date: Mon,  6 Jul 2026 21:19:32 +0300
Message-ID: <20260706181941.385672-1-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305185-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,isovalent.com:email,vger.kernel.org:from_smtp,fastmail.im:from_mime,fastmail.im:dkim,fastmail.im:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E97E714871

From: Alice Mikityanska <alice@isovalent.com>

This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
IPv6 BIG TCP doesn't require stripping the HBH in all various
combinations in tunneled traffic, adding BIG TCP becomes feasible.

Patch 01 adds accessors for the length field in the UDP header, as
suggested by Paolo in review. The usage of udp_set_len is then added in
the following patches that start using length=0 in BIG TCP UDP packets.

Patches 02-04 close the gaps that prevent BIG TCP packets from going
through UDP tunnel code.

Patch 05 validates packets in udp_gro_receive to exclude packets with
length=0 from GRO aggregation.

Patch 06 is for proper formatting in tcpdump (set UDP len to 0 rather
than a trimmed value on overflow).

Patches 07-08 bump up tso_max_size for VXLAN and GENEVE.

Patch 09 adds selftests.

Thanks all!

v8 changes: Addressed Paolo's and Jason's review comments. Made the
selftest more robust, added checks for SACK and mode with disabled tx
checksum offload on lower veth netdevs. Added details to commit
messages. Kept skb_segment logic unchanged, because the frags overflow
issue is not specific to BIG TCP.

v7: https://lore.kernel.org/netdev/20260611192955.604661-1-alice.kernel@fastmail.im/

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

Alice Mikityanska (8):
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
 drivers/net/geneve.c                          |   4 +-
 drivers/net/netconsole.c                      |   2 +-
 drivers/net/netdevsim/dev.c                   |   2 +-
 drivers/net/netdevsim/psample.c               |   2 +-
 drivers/net/netdevsim/psp.c                   |   8 +-
 drivers/net/vxlan/vxlan_core.c                |   2 +
 drivers/net/wireguard/receive.c               |   2 +-
 include/linux/udp.h                           |  27 +++
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
 net/ipv4/udp_offload.c                        |  49 ++---
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
 net/sched/act_csum.c                          |   4 +-
 net/xfrm/xfrm_nat_keepalive.c                 |   2 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/big_tcp_tunnels.sh  | 183 ++++++++++++++++++
 53 files changed, 335 insertions(+), 102 deletions(-)
 create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh

-- 
2.54.0


