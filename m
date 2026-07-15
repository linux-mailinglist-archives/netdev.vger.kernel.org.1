Return-Path: <netdev+bounces-307671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V/3GIBclV2qKFwEAu9opvQ
	(envelope-from <netdev+bounces-307671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:13:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E73CB75AE05
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:13:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=kbrqWHUF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307671-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307671-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F25E3040974
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 06:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854E437F73A;
	Wed, 15 Jul 2026 06:13:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202A39CCEC
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 06:13:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095992; cv=none; b=KfPtbyP3v+OE1bXm66oyWZa1hc6Aqc+xr2jBtmHbAo+IztxoqCCmNW4M2/vAvWkNujYVLxI4WRE4QDed+Y6zZ+d6U8Dfsf4tsYytXC1lhQSV5Bq8rH6Os5z9TvS2aasq0O+BXq0tLdIFld7Hedp6hu+a72pn24gWEkdQf3uxoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095992; c=relaxed/simple;
	bh=eZGMc2dAl/sbnSj44kL00I5PmRQGNVA+IeaOzI5OU5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=fYMEDUc1IOXT5mq46/twm+Bn0fFm+cNOoESZfx+mbKZe9euQOmGDyZqHr9VYm/BkWcAk9Uc48BZnHPJ1Ayan2UzzDOgYPhxjUdEaSgZS4RKl++8RHSsMWkmG9ylXwWUdnqvlLHFEpf+pUEKPdWnBbvyoJVos/XOSYieyfPRvG+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kbrqWHUF; arc=none smtp.client-ip=203.254.224.34
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260715061300epoutp0493ff8838ed6defa562275c2da95ef884~CYdd-ALT_1470514705epoutp04c
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 06:13:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260715061300epoutp0493ff8838ed6defa562275c2da95ef884~CYdd-ALT_1470514705epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784095980;
	bh=9tTmFap5dg+/Ppz3z6waujRNw8cK38G9+rg7ufpSx9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbrqWHUFlDHuB4M1OM7DTN+GO2QzZWGuDJ/Rjk+O4KZhZbFk8wo1Edpzxs5RVO8gQ
	 Yyib3JwYC4WYdRDF1Gtga9w/7+8dYTCUTaIDGOev2vZEdmXWFYxNupzdijiWYs8eDx
	 JIRAP9m4woERNCwBBKs1OMYc2ZZOjaTBKDccVGsA=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260715061259epcas5p3503c59cf9d7ab016c2570e69155362aa~CYddZXV6F2170521705epcas5p3U;
	Wed, 15 Jul 2026 06:12:59 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4h0Qp36RQmz2SSKd; Wed, 15 Jul
	2026 06:12:59 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260715061259epcas5p378f743489493da324fc9092ed2dfe147~CYdcyDHhk2170521705epcas5p3T;
	Wed, 15 Jul 2026 06:12:59 +0000 (GMT)
Received: from bsp (ppp-109-104-161-80.wildpark.net [109.104.161.80]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260715061257epsmtip136a0fedb6eb5f7437f0c3cf44dac358b~CYdbO8GyC3271532715epsmtip1I;
	Wed, 15 Jul 2026 06:12:57 +0000 (GMT)
From: "zebang.li" <zebang.li@samsung.com>
To: alice.kernel@fastmail.im
Cc: alice@isovalent.com, andrew+netdev@lunn.ch, daniel@iogearbox.net,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, fw@strlen.de,
	horms@kernel.org, kuba@kernel.org, lucien.xin@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org,
	shuah@kernel.org, stfomichev@gmail.com, willemb@google.com,
	willemdebruijn.kernel@gmail.com, nh78.kim@samsung.com,
	kwangho2.kim@samsung.com, h10.kim@samsung.com, hongfei.tang@samsung.com,
	yajie.yan@samsung.com
Subject: Re: [PATCH net-next v9 0/9] BIG TCP for UDP tunnels
Date: Wed, 15 Jul 2026 14:11:48 +0800
Message-ID: <a6f4c117-f58f-4cd7-910a-0fff3c3aeb27@blackwall.org> (raw)
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710134242.216538-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260715061259epcas5p378f743489493da324fc9092ed2dfe147
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260715061259epcas5p378f743489493da324fc9092ed2dfe147
References: <20260710134242.216538-1-alice.kernel@fastmail.im>
	<CGME20260715061259epcas5p378f743489493da324fc9092ed2dfe147@epcas5p3.samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307671-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alice.kernel@fastmail.im,m:alice@isovalent.com,m:andrew+netdev@lunn.ch,m:daniel@iogearbox.net,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:willemb@google.com,m:willemdebruijn.kernel@gmail.com,m:nh78.kim@samsung.com,m:kwangho2.kim@samsung.com,m:h10.kim@samsung.com,m:hongfei.tang@samsung.com,m:yajie.yan@samsung.com,m:andrew@lunn.ch,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zebang.li@samsung.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[fastmail.im];
	FREEMAIL_CC(0.00)[isovalent.com,lunn.ch,iogearbox.net,davemloft.net,kernel.org,google.com,strlen.de,gmail.com,vger.kernel.org,redhat.com,blackwall.org,samsung.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email,blackwall.org:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zebang.li@samsung.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E73CB75AE05

On 10/07/2026 16:42, Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
> support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
> IPv6 BIG TCP doesn't require stripping the HBH in all various
> combinations in tunneled traffic, adding BIG TCP becomes feasible.
> 
> Patch 01 adds accessors for the length field in the UDP header, as
> suggested by Paolo in review. The usage of udp_set_len is then added in
> the following patches that start using length=0 in BIG TCP UDP packets.
> 
> Patches 02-04 close the gaps that prevent BIG TCP packets from going
> through UDP tunnel code.
> 
> Patch 05 validates packets in udp_gro_receive to exclude packets with
> length=0 from GRO aggregation.
> 
> Patch 06 is for proper formatting in tcpdump (set UDP len to 0 rather
> than a trimmed value on overflow).
> 
> Patches 07-08 bump up tso_max_size for VXLAN and GENEVE.
> 
> Patch 09 adds selftests.
> 
> Thanks all!
> 
> v9 changes: Converted the selftest to iptables counters to avoid the
> issue with tcpdump pcaps taking all space in /tmp.
> 
> v8: https://lore.kernel.org/netdev/20260706181941.385672-1-alice.kernel@fastmail.im/
> 
> v8 changes: Addressed Paolo's and Jason's review comments. Made the
> selftest more robust, added checks for SACK and mode with disabled tx
> checksum offload on lower veth netdevs. Added details to commit
> messages. Kept skb_segment logic unchanged, because the frags overflow
> issue is not specific to BIG TCP.
> 
> v7: https://lore.kernel.org/netdev/20260611192955.604661-1-alice.kernel@fastmail.im/
> 
> v7 changes: Addressed Paolo's comments to properly block malformed
> packets with UDP length=0 at udp_rcv level.
> 
> v6: https://lore.kernel.org/netdev/20260602093931.516281-1-alice.kernel@fastmail.im/
> 
> v6 changes: Lowered the packets threshold in the selftest to pass
> upstream CI on debug kernels, also made it configurable.
> 
> v5: https://lore.kernel.org/netdev/20260526161200.1135899-1-alice.kernel@fastmail.im/
> 
> v5 changes: Rebased, dropped one of the patches that came in via the net
> tree, addressed an overflow in nsim_do_psp found by Sashiko.
> 
> v4: https://lore.kernel.org/netdev/20260512165648.386518-1-alice.kernel@fastmail.im/
> 
> v4 changes: Rebased, addressed Sashiko AI review [1] and Willem's
> comment about netperf flags.
> 
> My comments on Sashiko AI review per patch:
> 
> 01: I'd prefer to keep the cases that I haven't tested outside of the
> scope of this series, which is for VXLAN/GENEVE tunnels, not for ESP.
> 
> 02: The patch doesn't have behavioral changes other than fixing the
> checksum. The final uh->len assignment assigns the actual length, not
> 64k.
> 
> 03: The check can't be loosened, because total_len is also assigned to
> UDP length. BIG TCP works in the mode without GRO hint option.
> 
> 04: Fixed the fallback value for udplen. BIG TCP is fine, it's the
> uh->len = 0 case, uh->len can't exceed 64k.
> 
> 05: In the BIG TCP case, partial GSO splits the SKB in two. If full
> segmentation is needed, the SKB is split in many MSS-sized SKBs without
> fragments.
> 
> 06: Invalid packets from the wire are addressed in 08.
> 
> 07: __udp_gso_segment only handles UDP GSO packets, which can't be
> bigger than 64k. Kept udp_set_len_short in nf_nat_mangle_udp_packet, as
> the function doesn't support BIG TCP packets anyway (see
> mangle_contents).
> 
> 08: udp_gro_receive handles packets before aggregation, there are no BIG
> TCP packets at this point. RFC 768 doesn't say that padded UDP packets
> are valid. Real jumbograms don't seem to be supported in this path
> anyway.
> 
> 09: The packet goes to skb_udp_tunnel_segment, not __udp_gso_segment.
> __skb_udp_tunnel_segment handles this case.
> 
> 12: Improved process cleanup by killing everything inside netns before
> deleting them, and by avoiding killing netserver outside of netns.
> netperf with -r in TCP_STREAM mode works, and the option has the
> intended effect, but I replaced it with -m. Added dependency check for
> tcpdump.
> 
> [1]: https://sashiko.dev/#/patchset/20260410150943.993350-1-alice.kernel%40fastmail.im
> 
> v3: https://lore.kernel.org/netdev/20260410150943.993350-1-alice.kernel@fastmail.im/
> 
> v3 changes: Fixed the redirect in the selftest, rebased over my L2TP fix
> [2] for the syzbot report [3].
> 
> [2]: https://lore.kernel.org/netdev/20260403174949.843941-1-alice.kernel@fastmail.im/
> [3]: https://lore.kernel.org/netdev/69a1dfba.050a0220.3a55be.0026.GAE@google.com/
> 
> v2: https://lore.kernel.org/netdev/20260226201600.222044-1-alice.kernel@fastmail.im/
> 
> v2 changes: Addressed the review comments: added UDP len helpers,
> consolidated UDP len sanity checks in patch 08 into one, added
> selftests. Added fixups to related code (patch 01-03).
> 
> v1: https://lore.kernel.org/netdev/20250923134742.1399800-1-maxtram95@gmail.com/
> 
> Alice Mikityanska (8):
>    net: Use helpers to get/set UDP len tree-wide
>    net: Enable BIG TCP with partial GSO
>    udp: Support BIG TCP GSO packets where they can occur
>    udp: Support gro_ipv4_max_size > 65536
>    udp: Validate UDP length in udp_gro_receive
>    udp: Set length in UDP header to 0 for big GSO packets
>    vxlan: Enable BIG TCP packets
>    selftests: net: Add a test for BIG TCP in UDP tunnels
> 
> Daniel Borkmann (1):
>    geneve: Enable BIG TCP packets
> 
>   drivers/infiniband/core/lag.c                 |   2 +-
>   drivers/infiniband/sw/rxe/rxe_net.c           |   4 +-
>   drivers/net/amt.c                             |   6 +-
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   2 +-
>   drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   2 +-
>   drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   2 +-
>   .../marvell/octeontx2/nic/otx2_txrx.c         |   2 +-
>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +-
>   .../ethernet/mellanox/mlx5/core/en_selftest.c |   2 +-
>   drivers/net/ethernet/sfc/falcon/selftest.c    |   4 +-
>   drivers/net/ethernet/sfc/selftest.c           |   4 +-
>   drivers/net/ethernet/sfc/siena/selftest.c     |   4 +-
>   drivers/net/ethernet/sfc/tc_encap_actions.c   |   2 +-
>   .../stmicro/stmmac/stmmac_selftests.c         |   4 +-
>   drivers/net/geneve.c                          |   4 +-
>   drivers/net/netconsole.c                      |   2 +-
>   drivers/net/netdevsim/dev.c                   |   2 +-
>   drivers/net/netdevsim/psample.c               |   2 +-
>   drivers/net/netdevsim/psp.c                   |   8 +-
>   drivers/net/vxlan/vxlan_core.c                |   2 +
>   drivers/net/wireguard/receive.c               |   2 +-
>   include/linux/udp.h                           |  27 +++
>   include/trace/events/icmp.h                   |   2 +-
>   lib/tests/blackhole_dev_kunit.c               |   2 +-
>   net/6lowpan/nhc_udp.c                         |  10 +-
>   net/core/pktgen.c                             |   4 +-
>   net/core/selftests.c                          |   4 +-
>   net/core/skbuff.c                             |  10 +-
>   net/core/tso.c                                |   3 +-
>   net/ipv4/esp4.c                               |   2 +-
>   net/ipv4/fou_core.c                           |   2 +-
>   net/ipv4/ipconfig.c                           |   6 +-
>   net/ipv4/netfilter/nf_nat_snmp_basic_main.c   |   4 +-
>   net/ipv4/route.c                              |   2 +-
>   net/ipv4/udp.c                                |   7 +-
>   net/ipv4/udp_offload.c                        |  49 ++---
>   net/ipv4/udp_tunnel_core.c                    |   2 +-
>   net/ipv6/esp6.c                               |   5 +-
>   net/ipv6/fou6.c                               |   2 +-
>   net/ipv6/ip6_udp_tunnel.c                     |   2 +-
>   net/ipv6/udp.c                                |   7 +-
>   net/ipv6/udp_offload.c                        |   2 +-
>   net/l2tp/l2tp_core.c                          |   2 +-
>   net/netfilter/ipvs/ip_vs_xmit.c               |   2 +-
>   net/netfilter/nf_conntrack_proto_udp.c        |  15 +-
>   net/netfilter/nf_log_syslog.c                 |   2 +-
>   net/netfilter/nf_nat_helper.c                 |   2 +-
>   net/psp/psp_main.c                            |   2 +-
>   net/sched/act_csum.c                          |   4 +-
>   net/xfrm/xfrm_nat_keepalive.c                 |   2 +-
>   tools/testing/selftests/net/Makefile          |   1 +
>   .../testing/selftests/net/big_tcp_tunnels.sh  | 188 ++++++++++++++++++
>   53 files changed, 340 insertions(+), 102 deletions(-)
>   create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh
> 


Hi Alice,

This patch looks promising, but I noticed that it does not include a modification for `skb_gro_receive`.

Currently, for UDP data aggregated via GRO, if the resulting packet size exceeds 65536 (`GRO_LEGACY_MAX_SIZE`), this check will return `-E2BIG`.

To allow UDP GRO aggregation beyond this limit (similar to the existing TCP behavior), we should update the condition to include `IPPROTO_UDP`.

I suggest the following modification:

diff --git a/net/core/gro.c b/net/core/gro.c
index 35f2f708f010..01e56ad629c2 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -117,7 +117,7 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
                return -E2BIG;
        if (unlikely(p->len + len >= GRO_LEGACY_MAX_SIZE)) {
-               if (NAPI_GRO_CB(skb)->proto != IPPROTO_TCP ||
+               if ((NAPI_GRO_CB(skb)->proto != IPPROTO_TCP && NAPI_GRO_CB(skb)->proto != IPPROTO_UDP) ||
                    p->encapsulation)
                        return -E2BIG;
        }

Thanks,
zebang

