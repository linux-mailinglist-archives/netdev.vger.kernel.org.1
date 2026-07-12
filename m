Return-Path: <netdev+bounces-306903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vulpFn7wUmpWVgMAu9opvQ
	(envelope-from <netdev+bounces-306903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:40:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC0F74366A
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:40:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uGnMVV3b;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aqiwBgZV;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d1wfL8Hg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="WV++Oze/";
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306903-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306903-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4336B30151E4
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 01:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD9B1FECBA;
	Sun, 12 Jul 2026 01:40:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477425776
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 01:40:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820406; cv=none; b=bJ3ggFaUNj52eAx64NkAs6ItzgYXtqINYt0Y1hjhUJGP3RLZg2R1NBJVxertDTZJdPmmGcU4p6JFn3zrOEP/17Zw1q7XMzyX+FznbxOa/A4uO5OpdAu55bgAq8vhsNVRhU3oWaLE/T6fcgEmUSCeQDMGCKRe6F11nzDXNod1YCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820406; c=relaxed/simple;
	bh=KoQ7ABIUUuuiO/DUNlLAG7fsabmd34/PcaJRLePfT0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dw1LObngZc2KqU5kvN7m6POAimzsNzTWZ0b4VLyQwkzbOgWCEm3bC1IRU7RCZ3DVt4YiZ5lAoeWW8yMUoWM+lVBVf7ok2hZH6+ENOGH90+jNpTMLuHgCqy0VjJJ/ZC0Zbhxq9KgM7rGK00bfbMbMdllOLqk+bGmdhMEi31KRBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uGnMVV3b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aqiwBgZV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d1wfL8Hg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WV++Oze/; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B23B77031;
	Sun, 12 Jul 2026 01:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OJzCmx8XEcQNpkOuyZyHXPc0l2YBNnU2CcxoaE4ghAs=;
	b=uGnMVV3bNvPhsgpU5WJlxA2wqWZbbBdARTKASr3ZHLeuo1bzbp2PNGBWQDO3DE+CdOTSuG
	ezWZlnovySZrcumVyuv2V+HlpwlVe2QUsqUSId/AXXGv7g6o/gOUaAYY1TWhF26bX2Tazk
	AJHQ4oNNJtd+TDulFkQ6GVgAjp3g/mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OJzCmx8XEcQNpkOuyZyHXPc0l2YBNnU2CcxoaE4ghAs=;
	b=aqiwBgZVnXan6dBYZ1mm81xMKkndbuWQ+P2PFKMoQEA4wn1A781LCnEjiJwVj/NE3PyvDD
	diY3K9QxWqan93Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OJzCmx8XEcQNpkOuyZyHXPc0l2YBNnU2CcxoaE4ghAs=;
	b=d1wfL8HgPqA9L4Bl/nNESuHNxi8nOIodmvksR6gSU3ZAmOhdaX2hVvlcUiYNR+fOWgnX+U
	FIIGCAD8uzTQDHnkfx8t+w923pn10k9W1LvAxg3TchS+o9xqJrk7mDJPmwhw24WZlUEVXv
	9AG57GFNOQV7vtD4hiOfa0gWcAm28K0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OJzCmx8XEcQNpkOuyZyHXPc0l2YBNnU2CcxoaE4ghAs=;
	b=WV++Oze/Rzkdd6dLnMv6Rx9dzvLJS+RGr0NyvW0jV7PgwqokHU4Q9r6k1SAQ3mbgocvVdX
	YuvlUe+G2U+4i1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E70AC779B5;
	Sun, 12 Jul 2026 01:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id il/SNGvwUmqRegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 12 Jul 2026 01:39:55 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 00/13 RFC net-next] Allow compiling an IPv6-only kernel network stack
Date: Sun, 12 Jul 2026 03:38:58 +0200
Message-ID: <20260712013941.4570-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306903-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CC0F74366A

The primary goal of this patch series is to enable the compilation of an
IPv6-only kernel by decoupling the core networking infrastructure from the IPv4
protocol.

Historically, IPv4 has been intertwined with the generic socket and transport
layers. By untangling these dependencies, this series allows systems to be
built with CONFIG_IPV4 disabled. This configuration targets strict IPv6-only
deployments, constrained environments, and specialized appliances where
removing the IPv4 subsystem reduces the network attack surface.

To achieve this, subsystems with hard dependencies on IPv4 were modified to use
conditional compilation guards. When CONFIG_IPV4 is disabled, the affected
packet manipulation routines and routing hooks evaluate to stubs returning
standard error codes. The INDIRECT_CALL_INET macros within the transport layer
were adapted to safely bypass IPv4 function pointers without penalizing the
dual-stack fast paths. In addition, there has been several code splits for UDP,
RAW, ICMP or Ping isolating the IPv4 specific code.

Finally, CONFIG_IPV4 is exposed in Kconfig as an explicit boolean, defaulting
to 'y' to preserve existing configurations.

The bloat-o-meter diff for x86_64 with dualstack and IPv6 disabled:
   
   text    data     bss     dec     hex filename 
31211950        8946390 1121076 41279416        275dfb8 vmlinux.dual 
27464679        8008670 1069040 36542389        22d97b5 vmlinux.ipv6

add/remove: 52/25057 grow/shrink: 58/565 up/down: 937258/-4632671 (-3695413)

Performance testing:

Basic TCP performance validation was conducted using iperf3 on an AMD Ryzen 9
9950X between two bridged virtual machines. These benchmarks verify that there
are no obvious performance regressions.

Kernel / Configuration            Traffic Type    Offloads ON     Offloads OFF
-------------------------------------------------------------------------------
net-next (Dual-Stack Baseline)     IPv4            20.8 Gbps       7.22 Gbps
net-next (Dual-Stack Baseline)     IPv6            20.4 Gbps       7.55 Gbps
net-next (IPv4-Only Baseline)      IPv4            20.9 Gbps       7.86 Gbps

Patched (Dual-Stack)               IPv4            21.8 Gbps       7.77 Gbps
Patched (Dual-Stack)               IPv6            21.7 Gbps       7.35 Gbps
Patched (IPv4-Only)                IPv4            20.9 Gbps       7.91 Gbps
Patched (IPv6-Only)                IPv6            21.1 Gbps       8.06 Gbps

Follow-up on this series:

If this architectural direction is accepted, immediate follow-up work within
this series will focus on cleaning up header inclusions in files where code was
split, and resolving formatting warnings inherited from the moved code.
Additionally, work will be done to minimize function guarding churn and ensure
that IPv4-specific sysctls like IGMP are completely removed when CONFIG_IPV4=n.
Network drivers carrying hard IPv4 assumptions will also be adapted.

Follow-up out of the series:

Future work decoupled from this initial series includes expanding Kconfig
adaptations across remaining kernel subsystems to support an IPv6-only
environment. This includes patches for network bonding modes that assume
dual-stack availability and analyze Netfilter nftables expressions and
connection tracking to ensure pure IPv6 operations are fully independent.

Open questions:

1. Would it be preferable to introduce a dedicated NIPA build job with an
   IPv6-only configuration to prevent future compilation regressions?
2. Where is the preferred architectural location for ip_generic_getfrag(),
   as it currently resides out-of-place in net/ipv4/af_inet.c?
3. To eliminate noise in this series, files like udp.c, tcp.c, and raw.c remain
   in net/ipv4/. Would you prefer to relocate these shared transport files to
   net/core/?

Conclusions:

Looking at the numbers we have so far, the overall change is positive in my
opinion. Having said so, the main burden it introduces is the noise in git
which will be cumbersome when trying to identify breaking commits or blames.

Fernando Fernandez Mancera (13):
  net: ipv4: introduce CONFIG_IPV4 to decouple the IPv4 stack
  net: core: add IPv4 fallback stubs and guards for CONFIG_IPV4=n
  net: inet: relocate ip_generic_getfrag and guard IPv4 socket logic
  net: tcp: move protocol agnostic TCP functions out of tcp_ipv4.c
  net: raw: split IPv4 specific logic into raw_ipv4.c
  net: udp: split IPv4 specific logic into udp_ipv4.c
  net: icmp: split IPv4 specific logic into icmp_ipv4.c
  net: ping: split IPv4 specific logic into ping_ipv4.c
  net: fib: split common nexthop logic to fib_core.c
  net: tunnel: guard IPv4 tunnel functions with CONFIG_IPV4
  net: cipso: guard IPv4 packet manipulation functions
  netfilter: ipv4: guard ip_route_me_harder() with CONFIG_IPV4
  net: ipv4: make CONFIG_IPV4 boolean

 drivers/infiniband/Kconfig                    |    2 +-
 drivers/net/Kconfig                           |   24 +-
 drivers/net/ethernet/broadcom/Kconfig         |    2 +
 drivers/net/ethernet/chelsio/Kconfig          |    2 +-
 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/marvell/prestera/Kconfig |    1 +
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |    3 +-
 drivers/net/ethernet/mellanox/mlxsw/Kconfig   |    1 +
 drivers/net/ethernet/netronome/Kconfig        |    1 +
 drivers/net/ethernet/qlogic/Kconfig           |    2 +
 drivers/net/ethernet/sfc/Kconfig              |    1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |    1 +
 drivers/net/ethernet/via/Kconfig              |    1 +
 drivers/net/ppp/Kconfig                       |    1 +
 .../broadcom/brcm80211/brcmfmac/Kconfig       |    1 +
 drivers/net/wireless/intel/iwlwifi/Kconfig    |    1 +
 drivers/nvme/host/Kconfig                     |    2 +-
 drivers/nvme/target/Kconfig                   |    2 +-
 drivers/scsi/bnx2fc/Kconfig                   |    1 +
 drivers/scsi/bnx2i/Kconfig                    |    1 +
 drivers/scsi/cxgbi/cxgb3i/Kconfig             |    2 +-
 drivers/scsi/cxgbi/cxgb4i/Kconfig             |    2 +-
 drivers/target/iscsi/Kconfig                  |    2 +-
 fs/Kconfig                                    |    1 +
 fs/afs/Kconfig                                |    2 +-
 fs/nfs/Kconfig                                |    2 +-
 fs/nfsd/Kconfig                               |    2 +-
 include/linux/indirect_call_wrapper.h         |    8 +-
 include/net/icmp.h                            |    1 +
 include/net/ip.h                              |  104 +-
 include/net/ip_fib.h                          |   43 +
 include/net/route.h                           |   14 +
 include/net/tcp.h                             |   16 +-
 net/Kconfig                                   |    6 +-
 net/batman-adv/Kconfig                        |    1 +
 net/bridge/Kconfig                            |    3 +-
 net/bridge/netfilter/Kconfig                  |    6 +-
 net/core/Makefile                             |    2 +-
 net/core/dev_ioctl.c                          |    4 +
 net/core/fib_core.c                           |  146 ++
 net/core/filter.c                             |   22 +-
 net/core/neighbour.c                          |    4 +
 net/ipv4/Kconfig                              |   29 +-
 net/ipv4/Makefile                             |   24 +-
 net/ipv4/af_inet.c                            |  114 +-
 net/ipv4/cipso_ipv4.c                         |   10 +
 net/ipv4/fib_semantics.c                      |  142 --
 net/ipv4/icmp.c                               | 1407 +------------
 net/ipv4/icmp_ipv4.c                          | 1425 +++++++++++++
 net/ipv4/inet_connection_sock.c               |    2 +-
 net/ipv4/inet_hashtables.c                    |    4 +
 net/ipv4/ip_output.c                          |   18 -
 net/ipv4/ip_tunnel_core.c                     |   11 +
 net/ipv4/netfilter.c                          |    4 +
 net/ipv4/netfilter/Kconfig                    |    2 +-
 net/ipv4/netlink.c                            |    2 +
 net/ipv4/nexthop.c                            |    2 +-
 net/ipv4/ping.c                               |  215 +-
 net/ipv4/ping_ipv4.c                          |  225 +++
 net/ipv4/proc.c                               |    2 +
 net/ipv4/raw.c                                |  844 --------
 net/ipv4/raw_diag.c                           |    4 +
 net/ipv4/raw_ipv4.c                           |  875 ++++++++
 net/ipv4/sysctl_net_ipv4.c                    |    2 +
 net/ipv4/tcp.c                                | 1291 ++++++++++++
 net/ipv4/tcp_bpf.c                            |    2 +
 net/ipv4/tcp_ipv4.c                           | 1299 +-----------
 net/ipv4/udp.c                                | 1733 ----------------
 net/ipv4/udp_bpf.c                            |    6 +
 net/ipv4/udp_diag.c                           |   12 +
 net/ipv4/udp_ipv4.c                           | 1773 +++++++++++++++++
 net/ipv4/udp_offload.c                        |   10 +
 net/ipv6/Kconfig                              |   17 +-
 net/ipv6/af_inet6.c                           |    5 +
 net/ipv6/datagram.c                           |   14 +
 net/ipv6/ip6_fib.c                            |    2 +
 net/ipv6/ipv6_sockglue.c                      |    5 +
 net/ipv6/netfilter/Kconfig                    |    2 +-
 net/ipv6/tcp_ipv6.c                           |   25 +-
 net/ipv6/udp.c                                |   18 +
 net/l2tp/Kconfig                              |    2 +-
 net/mac80211/Kconfig                          |    2 +-
 net/mpls/Kconfig                              |    1 +
 net/mptcp/Kconfig                             |    2 +-
 net/netfilter/Kconfig                         |    2 +-
 net/netfilter/ipset/Kconfig                   |    2 +-
 net/netfilter/ipvs/Kconfig                    |    2 +-
 net/openvswitch/Kconfig                       |    2 +-
 net/packet/Kconfig                            |    1 +
 net/rds/Kconfig                               |    2 +-
 net/rxrpc/Kconfig                             |    2 +-
 net/sched/Kconfig                             |    2 +-
 net/sctp/Kconfig                              |    2 +-
 net/smc/Kconfig                               |    2 +-
 net/sunrpc/Kconfig                            |    2 +-
 net/tipc/Kconfig                              |    2 +-
 net/xfrm/Kconfig                              |   12 +-
 97 files changed, 6314 insertions(+), 5750 deletions(-)
 create mode 100644 net/core/fib_core.c
 create mode 100644 net/ipv4/icmp_ipv4.c
 create mode 100644 net/ipv4/ping_ipv4.c
 create mode 100644 net/ipv4/raw_ipv4.c
 create mode 100644 net/ipv4/udp_ipv4.c

-- 
2.54.0


