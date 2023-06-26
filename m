Return-Path: <netdev+bounces-13867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D83373D7F7
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 08:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE69F1C203B8
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 06:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E1F3FC2;
	Mon, 26 Jun 2023 06:48:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E2A20E2
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 06:47:59 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CC241B7;
	Sun, 25 Jun 2023 23:47:55 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net-next 0/8] Netfilter/IPVS updates for net-next
Date: Mon, 26 Jun 2023 08:47:41 +0200
Message-Id: <20230626064749.75525-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

The following patchset contains Netfilter/IPVS updates for net-next:

1) Allow slightly larger IPVS connection table size from Kconfig for
   64-bit arch, from Abhijeet Rastogi.

2) Since IPVS connection table might be larger than 2^20 after previous
   patch, allow to limit it depending on the available memory.
   Moreover, use kvmalloc. From Julian Anastasov.

3) Do not rebuild VLAN header in nft_payload when matching source and
   destination MAC address.

4) Remove nested rcu read lock side in ip_set_test(), from Florian Westphal.

5) Allow to update set size, also from Florian.

6) Improve NAT tuple selection when connection is closing,
   from Florian Westphal.

7) Support for resetting set element stateful expression, from Phil Sutter.

8) Use NLA_POLICY_MAX to narrow down maximum attribute value in nf_tables,
   from Florian Westphal.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git nf-next-23-06-26

Thanks.

----------------------------------------------------------------

The following changes since commit 4ff3dfc91c8458f65366f283167d1cd6f16be06f:

  Merge branch 'splice-net-handle-msg_splice_pages-in-chelsio-tls' (2023-06-01 13:41:40 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git nf-next-23-06-26

for you to fetch changes up to a412dbf40ff37515acca4bba666f5386aa37246e:

  netfilter: nf_tables: limit allowed range via nla_policy (2023-06-26 08:05:57 +0200)

----------------------------------------------------------------
netfilter pull request 23-06-26

----------------------------------------------------------------
Abhijeet Rastogi (1):
      ipvs: increase ip_vs_conn_tab_bits range for 64BIT

Florian Westphal (4):
      netfilter: ipset: remove rcu_read_lock_bh pair from ip_set_test
      netfilter: nf_tables: permit update of set size
      netfilter: snat: evict closing tcp entries on reply tuple collision
      netfilter: nf_tables: limit allowed range via nla_policy

Julian Anastasov (1):
      ipvs: dynamically limit the connection hash table

Pablo Neira Ayuso (1):
      netfilter: nft_payload: rebuild vlan header when needed

Phil Sutter (1):
      netfilter: nf_tables: Introduce NFT_MSG_GETSETELEM_RESET

 include/net/netfilter/nf_tables.h        |  3 ++
 include/uapi/linux/netfilter/nf_tables.h |  2 +
 net/netfilter/ipset/ip_set_core.c        |  2 -
 net/netfilter/ipvs/Kconfig               | 27 +++++-----
 net/netfilter/ipvs/ip_vs_conn.c          | 26 +++++----
 net/netfilter/nf_nat_core.c              | 92 ++++++++++++++++++++++++++++++--
 net/netfilter/nf_tables_api.c            | 72 ++++++++++++++++++-------
 net/netfilter/nft_bitwise.c              |  2 +-
 net/netfilter/nft_byteorder.c            |  6 +--
 net/netfilter/nft_ct.c                   |  2 +-
 net/netfilter/nft_dynset.c               |  2 +-
 net/netfilter/nft_exthdr.c               |  4 +-
 net/netfilter/nft_fwd_netdev.c           |  2 +-
 net/netfilter/nft_hash.c                 |  2 +-
 net/netfilter/nft_meta.c                 |  2 +-
 net/netfilter/nft_payload.c              |  3 +-
 net/netfilter/nft_range.c                |  2 +-
 net/netfilter/nft_reject.c               |  2 +-
 net/netfilter/nft_rt.c                   |  2 +-
 net/netfilter/nft_socket.c               |  4 +-
 net/netfilter/nft_tproxy.c               |  2 +-
 net/netfilter/nft_tunnel.c               |  4 +-
 net/netfilter/nft_xfrm.c                 |  4 +-
 23 files changed, 199 insertions(+), 70 deletions(-)

