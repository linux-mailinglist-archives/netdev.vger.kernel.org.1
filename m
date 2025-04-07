Return-Path: <netdev+bounces-179999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8024A7F0E3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6E43AD661
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0F7224252;
	Mon,  7 Apr 2025 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jb33F6aW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445C1C5F06
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744067931; cv=none; b=nUGoo1oDFjqbVzWnIu58WxUv0lrmfE8pHNc1GuVyveTWmDKqITWE9WKz6+Gn5XJ3KPHqNbWJlOC83OIKHsJt9N1eAPphLZnuI4b1nqDsv2SftdBHsDuRRs0DcALOXzxnOluO4jZV7J7p3K4oe0kSIdoyK3cZ9uMb2yzbLm/Tnmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744067931; c=relaxed/simple;
	bh=jM8SpBmMn4FvUUIji8cI/K34Wj/khhLysmwNLptzuXw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WFFyt+YgrzsWdwLYo0ik5zq8b21zdaKPAxMWttH1UY0ID6dSAdwiU6ZER7FzSbPiUVuTktk4LE3J01uyN/mQp5YQal+k5pr6HKbBt04RWuSDTA5jdMUy2TAUNCFCDB46z6fXBJ4IIPGadSl23ThqhQrlMhDC/6pYdQVjZhv5xXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jb33F6aW; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744067929; x=1775603929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h4oMPUeZhzUTRaCTklolKsR3a827UJUhHNX+wtl+hxw=;
  b=jb33F6aWFDTEzNE2oCzz96CD/p7Bp0iqLBGlRVCdgDryEoN9keME/GDF
   LzYsCp3Lf36NH5vCefVlnyet3ljYKvVqHtR7gNTt44w/rf02Bc8cMWNPs
   ovOyPIEPrJy9N/vK0n3rv2dg1SDu5juKMsuHY/iuevVNOrIX/y5HeQotY
   k=;
X-IronPort-AV: E=Sophos;i="6.15,196,1739836800"; 
   d="scan'208";a="711887747"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 23:18:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:45138]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.226:2525] with esmtp (Farcaster)
 id bb517e19-357c-4c17-882f-e6eb5568c2fb; Mon, 7 Apr 2025 23:18:44 +0000 (UTC)
X-Farcaster-Flow-ID: bb517e19-357c-4c17-882f-e6eb5568c2fb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 23:18:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 23:18:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, "Neal
 Cardwell" <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
	"Pablo Neira Ayuso" <pablo@netfilter.org>, Jozsef Kadlecsik
	<kadlec@netfilter.org>, Paul Moore <paul@paul-moore.com>, James Morris
	<jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/4] net: Retire DCCP.
Date: Mon, 7 Apr 2025 16:17:47 -0700
Message-ID: <20250407231823.95927-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

As announced by commit b144fcaf46d4 ("dccp: Print deprecation
notice."), it's time to remove DCCP.

The patch 2 removes net/dccp, netfilter/LSM code, doc, and etc,
leaving the uAPI headers alone.

The patch 3 unexports shared functions for DCCP, and the patch 4
renames tcp_or_dccp_get_hashinfo() to tcp_get_hashinfo().

We can do more cleanup; for example, remove IPPROTO_TCP checks in
__inet6?_check_established(), remove __module_get() for twsk,
remove timewait_sock_ops.twsk_destructor(), etc, but it will be
more of TCP stuff, so I'll defer to a later series.


Kuniyuki Iwashima (4):
  selftest: net: Remove DCCP bits.
  net: Retire DCCP.
  net: Unexport shared functions for DCCP.
  tcp: Rename tcp_or_dccp_get_hashinfo().

 Documentation/admin-guide/bug-hunting.rst     |    2 +-
 Documentation/netlink/specs/conntrack.yaml    |   22 -
 Documentation/networking/dccp.rst             |  219 ---
 Documentation/networking/index.rst            |    1 -
 Documentation/networking/ip-sysctl.rst        |    4 +-
 .../networking/nf_conntrack-sysctl.rst        |    1 -
 .../zh_CN/admin-guide/bug-hunting.rst         |    2 +-
 .../zh_TW/admin-guide/bug-hunting.rst         |    2 +-
 MAINTAINERS                                   |    9 -
 arch/arm/configs/omap2plus_defconfig          |    1 -
 arch/loongarch/configs/loongson3_defconfig    |    1 -
 arch/m68k/configs/amiga_defconfig             |    3 -
 arch/m68k/configs/apollo_defconfig            |    3 -
 arch/m68k/configs/atari_defconfig             |    3 -
 arch/m68k/configs/bvme6000_defconfig          |    3 -
 arch/m68k/configs/hp300_defconfig             |    3 -
 arch/m68k/configs/mac_defconfig               |    3 -
 arch/m68k/configs/multi_defconfig             |    3 -
 arch/m68k/configs/mvme147_defconfig           |    3 -
 arch/m68k/configs/mvme16x_defconfig           |    3 -
 arch/m68k/configs/q40_defconfig               |    3 -
 arch/m68k/configs/sun3_defconfig              |    3 -
 arch/m68k/configs/sun3x_defconfig             |    3 -
 arch/mips/configs/bigsur_defconfig            |    1 -
 arch/mips/configs/fuloong2e_defconfig         |    1 -
 arch/mips/configs/gpr_defconfig               |    1 -
 arch/mips/configs/ip22_defconfig              |    1 -
 arch/mips/configs/loongson2k_defconfig        |    1 -
 arch/mips/configs/loongson3_defconfig         |    1 -
 arch/mips/configs/malta_defconfig             |    1 -
 arch/mips/configs/malta_kvm_defconfig         |    1 -
 arch/mips/configs/maltaup_xpa_defconfig       |    1 -
 arch/mips/configs/mtx1_defconfig              |    1 -
 arch/mips/configs/rb532_defconfig             |    1 -
 arch/mips/configs/rm200_defconfig             |    1 -
 arch/powerpc/configs/cell_defconfig           |    1 -
 arch/powerpc/configs/pmac32_defconfig         |    1 -
 arch/powerpc/configs/ppc6xx_defconfig         |    1 -
 arch/s390/configs/debug_defconfig             |    1 -
 arch/s390/configs/defconfig                   |    1 -
 arch/sh/configs/titan_defconfig               |    1 -
 include/linux/dccp.h                          |  324 ----
 include/linux/in.h                            |    1 -
 include/linux/netfilter/nf_conntrack_dccp.h   |   38 -
 include/linux/tfrc.h                          |   51 -
 include/net/inet_hashtables.h                 |    7 +-
 .../net/netfilter/ipv4/nf_conntrack_ipv4.h    |    3 -
 include/net/netfilter/nf_conntrack.h          |    2 -
 include/net/netfilter/nf_conntrack_l4proto.h  |   13 -
 include/net/netfilter/nf_conntrack_tuple.h    |    3 -
 include/net/netfilter/nf_reject.h             |    1 -
 include/net/netns/conntrack.h                 |   13 -
 include/net/rstreason.h                       |    2 +-
 include/net/secure_seq.h                      |    4 -
 include/net/sock.h                            |    1 -
 include/trace/events/sock.h                   |    1 -
 include/trace/events/sunrpc.h                 |    2 -
 net/Kconfig                                   |    1 -
 net/Makefile                                  |    1 -
 net/bridge/netfilter/ebt_ip.c                 |    3 +-
 net/bridge/netfilter/ebt_ip6.c                |    3 +-
 net/bridge/netfilter/ebt_log.c                |    3 +-
 net/core/flow_dissector.c                     |    4 -
 net/core/secure_seq.c                         |   42 -
 net/core/sock.c                               |   24 +-
 net/core/sock_diag.c                          |    2 -
 net/dccp/Kconfig                              |   46 -
 net/dccp/Makefile                             |   30 -
 net/dccp/ackvec.c                             |  403 -----
 net/dccp/ackvec.h                             |  136 --
 net/dccp/ccid.c                               |  219 ---
 net/dccp/ccid.h                               |  262 ---
 net/dccp/ccids/Kconfig                        |   55 -
 net/dccp/ccids/ccid2.c                        |  794 ---------
 net/dccp/ccids/ccid2.h                        |  121 --
 net/dccp/ccids/ccid3.c                        |  866 ---------
 net/dccp/ccids/ccid3.h                        |  148 --
 net/dccp/ccids/lib/loss_interval.c            |  184 --
 net/dccp/ccids/lib/loss_interval.h            |   69 -
 net/dccp/ccids/lib/packet_history.c           |  439 -----
 net/dccp/ccids/lib/packet_history.h           |  142 --
 net/dccp/ccids/lib/tfrc.c                     |   46 -
 net/dccp/ccids/lib/tfrc.h                     |   73 -
 net/dccp/ccids/lib/tfrc_equation.c            |  702 --------
 net/dccp/dccp.h                               |  483 -----
 net/dccp/diag.c                               |   85 -
 net/dccp/feat.c                               | 1581 -----------------
 net/dccp/feat.h                               |  133 --
 net/dccp/input.c                              |  739 --------
 net/dccp/ipv4.c                               | 1101 ------------
 net/dccp/ipv6.c                               | 1174 ------------
 net/dccp/ipv6.h                               |   27 -
 net/dccp/minisocks.c                          |  266 ---
 net/dccp/options.c                            |  609 -------
 net/dccp/output.c                             |  708 --------
 net/dccp/proto.c                              | 1293 --------------
 net/dccp/qpolicy.c                            |  136 --
 net/dccp/sysctl.c                             |  107 --
 net/dccp/timer.c                              |  272 ---
 net/dccp/trace.h                              |   82 -
 net/ipv4/Kconfig                              |    2 +-
 net/ipv4/af_inet.c                            |    5 +-
 net/ipv4/inet_connection_sock.c               |   23 +-
 net/ipv4/inet_diag.c                          |    2 -
 net/ipv4/inet_hashtables.c                    |   30 +-
 net/ipv4/inet_timewait_sock.c                 |    6 +-
 net/ipv6/af_inet6.c                           |    1 -
 net/ipv6/inet6_connection_sock.c              |    2 -
 net/ipv6/ip6_output.c                         |    2 +-
 net/netfilter/Kconfig                         |   22 -
 net/netfilter/Makefile                        |    2 -
 net/netfilter/nf_conntrack_core.c             |   10 +-
 net/netfilter/nf_conntrack_netlink.c          |    1 -
 net/netfilter/nf_conntrack_proto.c            |    6 -
 net/netfilter/nf_conntrack_proto_dccp.c       |  826 ---------
 net/netfilter/nf_conntrack_standalone.c       |   92 -
 net/netfilter/nf_nat_core.c                   |    6 -
 net/netfilter/nf_nat_proto.c                  |   44 -
 net/netfilter/nfnetlink_cttimeout.c           |    5 -
 net/netfilter/nft_ct.c                        |    1 -
 net/netfilter/nft_exthdr.c                    |  106 --
 net/netfilter/xt_dccp.c                       |  185 --
 net/netfilter/xt_multiport.c                  |    6 +-
 samples/bpf/sockex2_kern.c                    |    1 -
 scripts/checkpatch.pl                         |    2 +-
 security/lsm_audit.c                          |   19 -
 security/selinux/hooks.c                      |   41 +-
 security/selinux/include/classmap.h           |    2 -
 security/selinux/nlmsgtab.c                   |    1 -
 security/smack/smack_lsm.c                    |    9 +-
 tools/testing/selftests/net/config            |    1 -
 .../selftests/net/reuseport_addr_any.c        |   36 +-
 132 files changed, 49 insertions(+), 15846 deletions(-)
 delete mode 100644 Documentation/networking/dccp.rst
 delete mode 100644 include/linux/dccp.h
 delete mode 100644 include/linux/netfilter/nf_conntrack_dccp.h
 delete mode 100644 include/linux/tfrc.h
 delete mode 100644 net/dccp/Kconfig
 delete mode 100644 net/dccp/Makefile
 delete mode 100644 net/dccp/ackvec.c
 delete mode 100644 net/dccp/ackvec.h
 delete mode 100644 net/dccp/ccid.c
 delete mode 100644 net/dccp/ccid.h
 delete mode 100644 net/dccp/ccids/Kconfig
 delete mode 100644 net/dccp/ccids/ccid2.c
 delete mode 100644 net/dccp/ccids/ccid2.h
 delete mode 100644 net/dccp/ccids/ccid3.c
 delete mode 100644 net/dccp/ccids/ccid3.h
 delete mode 100644 net/dccp/ccids/lib/loss_interval.c
 delete mode 100644 net/dccp/ccids/lib/loss_interval.h
 delete mode 100644 net/dccp/ccids/lib/packet_history.c
 delete mode 100644 net/dccp/ccids/lib/packet_history.h
 delete mode 100644 net/dccp/ccids/lib/tfrc.c
 delete mode 100644 net/dccp/ccids/lib/tfrc.h
 delete mode 100644 net/dccp/ccids/lib/tfrc_equation.c
 delete mode 100644 net/dccp/dccp.h
 delete mode 100644 net/dccp/diag.c
 delete mode 100644 net/dccp/feat.c
 delete mode 100644 net/dccp/feat.h
 delete mode 100644 net/dccp/input.c
 delete mode 100644 net/dccp/ipv4.c
 delete mode 100644 net/dccp/ipv6.c
 delete mode 100644 net/dccp/ipv6.h
 delete mode 100644 net/dccp/minisocks.c
 delete mode 100644 net/dccp/options.c
 delete mode 100644 net/dccp/output.c
 delete mode 100644 net/dccp/proto.c
 delete mode 100644 net/dccp/qpolicy.c
 delete mode 100644 net/dccp/sysctl.c
 delete mode 100644 net/dccp/timer.c
 delete mode 100644 net/dccp/trace.h
 delete mode 100644 net/netfilter/nf_conntrack_proto_dccp.c
 delete mode 100644 net/netfilter/xt_dccp.c

-- 
2.48.1


