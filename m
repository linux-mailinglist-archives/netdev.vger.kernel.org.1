Return-Path: <netdev+bounces-291804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJYpAijJFWqMbAcAu9opvQ
	(envelope-from <netdev+bounces-291804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:24:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 186915D99C1
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25E43300469E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B183AE703;
	Tue, 26 May 2026 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="RoxC3m3W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lJC8Cs4M"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357C3AEF5A
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811989; cv=none; b=CGBA9RVnSdNwQY2Ndg/2vOlT65qPH0NK9mMZ3PpSGU/NwNkRmXseSWxOxTKMWRT1/5tWkU/fH3/iV7h8aJYKwABrbpwn0EBYj8lvSP5k8mSNtmd9rjqCGte1EFHTOG3ZsCaKKhw1EqP2eH/2DW5p7nkPsyLTZFW+rSp0HulsaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811989; c=relaxed/simple;
	bh=YU6B2dVM8NpRJ+RWjCAnTsxEFKGDj97kSwvVpUVAOFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cClnfeQ/PjdNx1VF4p+xrHljEjIB8YREC/b05JK9V6aG7jkgt5A5lbzHaTv9+4px1KgXspnX9bopjV546gxZIqH2XMMAOeZQymly4VLqk2HWMLGw8s+yit8S97c2E0Nz9Q8Mq3P4fFryrAd51tRkJ+80FjFrFfcRMBkSTiLhhaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=RoxC3m3W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lJC8Cs4M; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 144CA1D00075;
	Tue, 26 May 2026 12:13:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 26 May 2026 12:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1779811985; x=1779898385; bh=dtzcfr44K93dm8SpyK0CD
	wa8tKGE5MGjOMIMGm5w30A=; b=RoxC3m3W/4lZD5HvemXyprfudTLuRVZy0XBgD
	J8JmCRwT0oGZYCyyn8uasvvZ0b+n80mJ6ysLMifRjUa/Bnv81fxUN2IWc4gO9o7S
	KL8f5ww6tNs+UwJgTYB7LxIrNGYYZMzSU4H5qGbkfCcF1ADafY69SaDuyyVieLL/
	HFpmTGdnxEXdyicxh6T0R8jdN7U7rMYEX2MzceNtzCdFXUuCREDIyymF4qKeCOSs
	9NBbkNPQ+aFQuDjYvO1hPf9TYnzYkpkY0H/a+Q1ATBftXm5b++sp+5uxkuPESId/
	fMcvXcKvzjfqLZyh08lQ19cnyl/Wr1MwkRmGiKNS/Mn51cqqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779811985; x=1779898385; bh=dtzcfr44K93dm8SpyK0CDwa8tKGE5MGjOMI
	MGm5w30A=; b=lJC8Cs4Ma20anwizGm0ZuWwHE8aLuwhtFV3Vw3NmcqQkhxAmk8+
	uJi+RychA0wIHBckOfSfFSmW/2FpmFf+F1JBvFftSiHplreqmcadfR4zT9gqaEQV
	iJTAjSjOgLraRZ63/+5jzbxbaofGUvsRXEolxxB4UQMU7msoFr5UIAZU5tfKMlHC
	f/aC+K/6+kyrUXl1VBy5FdipP2wXivTsSmgJqrrVAafVhYThWc7kUEHiQ3rpunLB
	WKzMYAZw/ZwAJo7YMrZOlVmZvEzvyak1uOQUeyU+qClxb29tOhVxfpoeV5/GlPM+
	Hi+66qE0vwdsCG8WsBhGoF5nxuqWS4PD7tA==
X-ME-Sender: <xms:kcYVamMhQJIJtSv6xQXGGFtxrXoIG_m5fKN12e0L5FdwSuTGTCyv_A>
    <xme:kcYVajdnF2RCLgogmEwtwlzVd-Sjof8_IrQRkqUiN_0N2lYZ-4oyuBk2Tnom3XeRH
    TfkcWDwfsJf3QtJG2nkLn2UF7dC4pZevPJF7gR2ogLf5_QiYyRsQd8>
X-ME-Received: <xmr:kcYVakF4YvNbJMwKyoBepgwLn0KpipJ5JaTFyTJTzNz1fp-F0EdcabfSw5kzN9DId3LouGDUU5bnqQ9wW2uQcJXM2r9MVXHaQYjmTg>
X-ME-Proxy-Cause: dmFkZTGkT3juHp34rRARUq1rRpjoZCUHtaBoe1zPNYqPOIK18mm1/1FAikRRVBnBLSs+s3
    qGAowg3daltAKH93rLL+CRH5yQXXvrPMKQdomlR/1UEd/BVI8solDU/ZmOYa77yU5K3VXU
    BXwJi+uBaT3IQZGuSke1DxtesuoQnJfF74bl8bP5GgrXjZiUQ6OiJpeGPC/BEU2s06lTar
    2btbZ14v3vadMn4DfNU5/8FQK+vbYtLz+Baq68EneayPuBh6lKTRCA/7qNKhVH/XVtokpz
    oyhULS80mew85HYbyhqz1OK1fUG9jAkQd06Y+ybLdZnz56MbqKqkC83VXiCxfUCDXCYyAq
    CyWPzrcs20wgxPEehyIx6PFXVNsaNXoWuY5ILGLGiWRDCd6CqFXZT9elyNRUSmT0XmFl99
    mkRdjoUs8lZLnGgYEAWQvV0QoW+tCWYwcRktnpx+e1cLxnvuMg3AoCR4vn3vqNcJdSy4vb
    b/+AmGB5WTvSY570G9jZ/BLBXPvpj3Z7Nl4bPjBnYmhhPXyF6N2aJtwOO6tE7bU43T5nq9
    E3pv/Uv0xYpAW+/Ka6yyzRVu9EpEdOdFbnAYIe6YSsdkgSkEgu7kLUb7pjs9vj2muFLtsB
    t+1lRz6wVGPBNQ4aad+Bjt9HwfBcM8S4TPPmwj+qz7D0FfLFrfibu28T9iQA
X-ME-Proxy: <xmx:kcYVamvlSSRfswISwq0LfhslFpuYdz1tp-uOlQ7qgZ5lFgJU7DBX_A>
    <xmx:kcYVamoOOPC0R7UMuVNPcuKgRlzDOI0kMsi7gxzyFS5kA51Zz2q8Gg>
    <xmx:kcYValndwRajUYlQv4ml6vLc8ogsHVsb4dYkb8XnNFfUe-bT0eT-JA>
    <xmx:kcYVarg6Ivj_j3TMIRmahB0eP7i17XRJBJFNCDE-enCbYFw7_K6T5g>
    <xmx:kcYVap6-JI7eN6cQNX0H7IaEcY7APFe-A26g0CK08TDtbiH6dZoJ8NIi>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 12:13:04 -0400 (EDT)
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
Subject: [PATCH net-next v5 00/11] BIG TCP for UDP tunnels
Date: Tue, 26 May 2026 18:11:49 +0200
Message-ID: <20260526161200.1135899-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-291804-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,fastmail.im:mid,fastmail.im:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,isovalent.com:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 186915D99C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


