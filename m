Return-Path: <netdev+bounces-294112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMReIqimHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:47:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C162BD5D
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDD4D3029893
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF273CAE66;
	Tue,  2 Jun 2026 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="FuKl1dlf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KoaplqlS"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53D3D16E7
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393238; cv=none; b=VoLnnGhgO8OAAWItZ/HjJA0wMWSswuqTGtex4EH02KolGQ83FzMmUW5aJEFpJJVZxfCgFKplOn+pFPnkFTdk8Kg3o1/uAiFEKsU4KVrrA2sn1csjlOBuMQuKocU6xxJAnvJLguwHIPqZy3WeetwCOA6x7ztSI2z3h83V1dVRpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393238; c=relaxed/simple;
	bh=sEHS4cTYQSuOB5jscK+vdidhhFlbRtpvs3LfvfXgV48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BF8EFUt1KIhzy0ojBWRyijbDfFfkNODT5Ao/NiDR9Utw2GYeXE3ntLrFKTh3mYmNMZ4ck1bZ46enS8ymWu+wech+Hvj4l+2REYy2YjZtW0CozkoB2UsRbo1XMi6t2SugyH1rZ8ZGFcAg9tJ27/z3StbvgdOA/S8edDhcVS4TT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=FuKl1dlf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KoaplqlS; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B26817A00FE;
	Tue,  2 Jun 2026 05:40:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 02 Jun 2026 05:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1780393234; x=1780479634; bh=41d/q0Az2VWsz7rb7cyeu
	Kq3ZO9LBMPoVsh+phguEKw=; b=FuKl1dlfslu/RqrDp6+fKTL2Dq2VbopKAdrO9
	pKGH616LqE7K3UtiYjBua5qOzm7VYpOlSQeu1DrFhXiskNGRcvk7MLfHre2HdeLM
	ohxbOTKt1TIDwcXjbRjVwqB0/nqs60t2fQCHn35KSbAzdwRbL1/r2UpltUx7gB5Z
	YLmXA3Jj9xhAslOI5eJ1jLqEUU4gy/5HkroqNYBQpDCR/Jaj5PWXZoUl/m4hzPZ6
	zHYKR742qRIVswu6uFEcYZQnrMaVvTdIo0EqsLo5sjpI8KltaoJkKMIkPfgDtXmT
	n5ehJcnNvsPfaEey6e6F91l+I2UDsspY9SZZBhC0x1UBf8+tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780393234; x=1780479634; bh=41d/q0Az2VWsz7rb7cyeuKq3ZO9LBMPoVsh
	+phguEKw=; b=KoaplqlSnhNNgMs/AVuopmuKHQQUoGUVryhdhfTOxrtnI0MWQne
	65RsMav/74Fwt/PAG6/cjtSC8Oa85uWI2hlP+TosVfrFgaZAxoEe9xd2WTc5ZD4V
	4XGQkdj5PeRWyj7z1nzOttgSKCUzMIyuWzFzHyl9Z1AGZjbMsLo0JIt59zzXF6+5
	eJAEcRh52bvX7N6C1VvGfBdZRxvC7iKF6sCAz9vRMn/F+Qfp987mKvWSCh4G9z48
	9798i6zY/jtaocfqSthCnJT/RPbk3wJYlSTmDk+IVrfqPMV921cBJZIoC/TLBC6a
	0XwQCfle8pDBqCzbVLG+XTzOKQNHhiWGJnw==
X-ME-Sender: <xms:EaUeahAXnCsD1GZXJypsjT_WLjFxMJaKP2eg7Nqequ1pTc7Nz0N9TA>
    <xme:EaUeauBvdNCoP526gftqxbhoSnc4lLDL2CEd5a4ls3e5hcOjIby9EVMoqKwMzYdqF
    9HKm51CvF98K4TQdCohRgICHrV-FEMl4B1YGOCSMrtJRRyZ2V2I>
X-ME-Received: <xmr:EaUeajb-kjZt2OYZk9HeY5rBRdn6cuIoEGt3hfzpUOYSOCL54uoe8CeHUbbKnuJCh9hgdlLjCarY2l6lGXk>
X-ME-Proxy-Cause: dmFkZTFa0AxOd0RQccAmrOol981CtrypNoXUgvayPyLho/TvvuY1mIcuYkky78j3pzn9vk
    5igYTuh6chp5A0BKA0dZ5ZYfdn2B1nEOEMNeh1U7HoVff1kJrio1CzYx3OtJ+wJul/2Umf
    45KQnWbecKIXSOR8FSKUqNgGa3gYj2siMZ0+HIu3WyBan1a3QjnhT0larxONDDGlQCcUmu
    LtF7l4hAeWc9E8vnPkBquNYW2rzoMxBm2GA9jNtgxc0xFsB+ntd1ITy+5BKDotQUrCrh7z
    gkRiWegtFwptPQsRHi/QJcuALo7PfG8azsbHbi1shyw69tih9LuMg+TultDlt1Pj3/RifK
    x92Q/ItznJNMNCZTQTzLRWkZn8Vskvx17vFLeD0ahrMp2wwx3ez+ZIZr/RORXsGoEz1+E6
    4ndPnc4Kk/fo18uWCSlia+cBEAfliObu8zqMVf2zt42BjgL1nL0LHCfxOo7UsxJsNNI5+D
    H5ovkQQQ3m28kKrJjri1mUjAf/I+bhvG+DfQeEUjB5hmTjQA7M3ujcmn9wEobTsuasrSQ3
    OJ3xfaFF+T/TYEIA3Jzu/Tj747FVNgJ2YBpJXHHq0xnLiAUM7vOHysIxyHnmV3Rq+kfoX3
    Fg8czAMs406H+L8hlY2fP1O9fBAwwohmXuGGIwGfhc7e7uV04iW2TWKDpVJg
X-ME-Proxy: <xmx:EaUearwMKUydfoMjLs-3oENdcKsxWpitRZAMfFnSi6mDb3uHa2vZwQ>
    <xmx:EaUeaueROuS2TnMyPR20Ej9dk7JIBHb9lSJrK33Vq7YP2JG2TUOfdA>
    <xmx:EaUeapInMtsmFR2x3E6dszxTocQbXw0ihEnXx6F557P_ZdPzus8lHg>
    <xmx:EaUeav0KLVngWBKsNw0m3mjF0jfARG210ggPJTUWJU6xMegcECB9Zw>
    <xmx:EqUeas97s19Gv2fTryuGlVu1F_Grio2BIA4yWCGYgODEnK8_LWpaY6Ye>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:40:32 -0400 (EDT)
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
Subject: [PATCH net-next v6 00/11] BIG TCP for UDP tunnels
Date: Tue,  2 Jun 2026 11:39:20 +0200
Message-ID: <20260602093931.516281-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE8C162BD5D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294112-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,isovalent.com:email,messagingengine.com:dkim,fastmail.im:dkim,fastmail.im:mid]
X-Rspamd-Action: no action

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

Patch 07 re-adds proper validation of malformed packets that arrive with
length=0 from the wire.

Patch 08 is for proper formatting in tcpdump (set UDP len to 0 rather
than a trimmed value on overflow).

Patches 09-10 bump up tso_max_size for VXLAN and GENEVE.

Patch 11 adds selftests.

Thanks all!

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
  udp: Support gro_ipv4_max_size > 65536
  udp: Support BIG TCP GSO packets where they can occur
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
 include/linux/udp.h                           |  16 ++
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
 net/ipv4/udp.c                                |   8 +-
 net/ipv4/udp_offload.c                        |  49 +++---
 net/ipv4/udp_tunnel_core.c                    |   2 +-
 net/ipv6/esp6.c                               |   5 +-
 net/ipv6/fou6.c                               |   2 +-
 net/ipv6/ip6_udp_tunnel.c                     |   2 +-
 net/ipv6/udp.c                                |   3 +-
 net/ipv6/udp_offload.c                        |   2 +-
 net/l2tp/l2tp_core.c                          |   2 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |   2 +-
 net/netfilter/nf_conntrack_proto_udp.c        |  17 +-
 net/netfilter/nf_log_syslog.c                 |   2 +-
 net/netfilter/nf_nat_helper.c                 |   2 +-
 net/psp/psp_main.c                            |   2 +-
 net/sched/act_csum.c                          |  12 +-
 net/xfrm/xfrm_nat_keepalive.c                 |   2 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/big_tcp_tunnels.sh  | 151 ++++++++++++++++++
 53 files changed, 301 insertions(+), 102 deletions(-)
 create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh

-- 
2.54.0


