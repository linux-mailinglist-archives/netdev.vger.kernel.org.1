Return-Path: <netdev+bounces-46668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D2E7E5AAF
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 16:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD2BB20FBC
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6393330667;
	Wed,  8 Nov 2023 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690830CE4
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 15:58:10 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E2031BC3;
	Wed,  8 Nov 2023 07:58:09 -0800 (PST)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	kadlec@netfilter.org
Subject: [PATCH net 0/5] Netfilter fixes for net
Date: Wed,  8 Nov 2023 16:57:57 +0100
Message-Id: <20231108155802.84617-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

The following patchset contains Netfilter fixes for net:

1) Add missing netfilter modules description to fix W=1, from Florian Westphal.

2) Fix catch-all element GC with timeout when use with the pipapo set
   backend, this remained broken since I tried to fix it this summer,
   then another attempt to fix it recently.

3) Add missing IPVS modules descriptions to fix W=1, also from Florian.

4) xt_recent allocated a too small buffer to store an IPv4-mapped IPv6
   address which can be parsed by in6_pton(), from Maciej Zenczykowski.
   Broken for many releases.

5) Skip IPv4-mapped IPv6, IPv4-compat IPv6, site/link local scoped IPv6
   addressses to set up IPv6 NAT redirect, also from Florian. This is
   broken since 2012.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-23-11-08

Thanks.

----------------------------------------------------------------

The following changes since commit d93f9528573e1d419b69ca5ff4130201d05f6b90:

  nfsd: regenerate user space parsers after ynl-gen changes (2023-11-06 09:03:46 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-23-11-08

for you to fetch changes up to 80abbe8a8263106fe45a4f293b92b5c74cc9cc8a:

  netfilter: nat: fix ipv6 nat redirect with mapped and scoped addresses (2023-11-08 16:40:30 +0100)

----------------------------------------------------------------
netfilter pull request 23-11-08

----------------------------------------------------------------
Florian Westphal (3):
      netfilter: add missing module descriptions
      ipvs: add missing module descriptions
      netfilter: nat: fix ipv6 nat redirect with mapped and scoped addresses

Maciej Żenczykowski (1):
      netfilter: xt_recent: fix (increase) ipv6 literal buffer length

Pablo Neira Ayuso (1):
      netfilter: nf_tables: remove catchall element in GC sync path

 net/bridge/netfilter/ebtable_broute.c      |  1 +
 net/bridge/netfilter/ebtable_filter.c      |  1 +
 net/bridge/netfilter/ebtable_nat.c         |  1 +
 net/bridge/netfilter/ebtables.c            |  1 +
 net/bridge/netfilter/nf_conntrack_bridge.c |  1 +
 net/ipv4/netfilter/iptable_nat.c           |  1 +
 net/ipv4/netfilter/iptable_raw.c           |  1 +
 net/ipv4/netfilter/nf_defrag_ipv4.c        |  1 +
 net/ipv4/netfilter/nf_reject_ipv4.c        |  1 +
 net/ipv6/netfilter/ip6table_nat.c          |  1 +
 net/ipv6/netfilter/ip6table_raw.c          |  1 +
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c  |  1 +
 net/ipv6/netfilter/nf_reject_ipv6.c        |  1 +
 net/netfilter/ipvs/ip_vs_core.c            |  1 +
 net/netfilter/ipvs/ip_vs_dh.c              |  1 +
 net/netfilter/ipvs/ip_vs_fo.c              |  1 +
 net/netfilter/ipvs/ip_vs_ftp.c             |  1 +
 net/netfilter/ipvs/ip_vs_lblc.c            |  1 +
 net/netfilter/ipvs/ip_vs_lblcr.c           |  1 +
 net/netfilter/ipvs/ip_vs_lc.c              |  1 +
 net/netfilter/ipvs/ip_vs_nq.c              |  1 +
 net/netfilter/ipvs/ip_vs_ovf.c             |  1 +
 net/netfilter/ipvs/ip_vs_pe_sip.c          |  1 +
 net/netfilter/ipvs/ip_vs_rr.c              |  1 +
 net/netfilter/ipvs/ip_vs_sed.c             |  1 +
 net/netfilter/ipvs/ip_vs_sh.c              |  1 +
 net/netfilter/ipvs/ip_vs_twos.c            |  1 +
 net/netfilter/ipvs/ip_vs_wlc.c             |  1 +
 net/netfilter/ipvs/ip_vs_wrr.c             |  1 +
 net/netfilter/nf_conntrack_broadcast.c     |  1 +
 net/netfilter/nf_conntrack_netlink.c       |  1 +
 net/netfilter/nf_conntrack_proto.c         |  1 +
 net/netfilter/nf_nat_core.c                |  1 +
 net/netfilter/nf_nat_redirect.c            | 27 ++++++++++++++++++++++++++-
 net/netfilter/nf_tables_api.c              | 23 ++++++++++++++++++-----
 net/netfilter/nfnetlink_osf.c              |  1 +
 net/netfilter/nft_chain_nat.c              |  1 +
 net/netfilter/nft_fib.c                    |  1 +
 net/netfilter/nft_fwd_netdev.c             |  1 +
 net/netfilter/xt_recent.c                  |  2 +-
 40 files changed, 82 insertions(+), 7 deletions(-)

