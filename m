Return-Path: <netdev+bounces-44267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEDC7D76B0
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C385FB20A64
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D4341AA;
	Wed, 25 Oct 2023 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3CD1BDF9
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:26:07 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEB9912A;
	Wed, 25 Oct 2023 14:26:01 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 00/19] Netfilter updates for net-next
Date: Wed, 25 Oct 2023 23:25:36 +0200
Message-Id: <20231025212555.132775-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The following patchset contains Netfilter updates for net-next. Mostly
nf_tables updates with two patches for connlabel and br_netfilter.

1) Rename function name to perform on-demand GC for rbtree elements,
   and replace async GC in rbtree by sync GC. Patches from Florian Westphal.

2) Use commit_mutex for NFT_MSG_GETRULE_RESET to ensure that two
   concurrent threads invoking this command do not underrun stateful
   objects. Patches from Phil Sutter.

3) Use single hook to deal with IP and ARP packets in br_netfilter.
   Patch from Florian Westphal.

4) Use atomic_t in netns->connlabel use counter instead of using a
   spinlock, also patch from Florian.

5) Cleanups for stateful objects infrastructure in nf_tables.
   Patches from Phil Sutter.

6) Flush path uses opaque set element offered by the iterator, instead of
   calling pipapo_deactivate() which looks up for it again.

7) Set backend .flush interface always succeeds, make it return void
   instead.

8) Add struct nft_elem_priv placeholder structure and use it by replacing
   void * to pass opaque set element representation from backend to frontend
   which defeats compiler type checks.

9) Shrink memory consumption of set element transactions, by reducing
   struct nft_trans_elem object size and reducing stack memory usage.

10) Use struct nft_elem_priv also for set backend .insert operation too.

11) Carry reset flag in nft_set_dump_ctx structure, instead of passing it
    as a function argument, from Phil Sutter.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git nf-next-23-10-25

Thanks.

----------------------------------------------------------------

The following changes since commit 5e3704030b240ab6878c32abdc2e38b6bac9dfb8:

  Merge branch 'bnxt_en-next' (2023-10-22 11:41:46 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git nf-next-23-10-25

for you to fetch changes up to 9cdee063476988102bbc5e0e9551e10c5ed00d3e:

  netfilter: nf_tables: Carry reset boolean in nft_set_dump_ctx (2023-10-24 15:48:30 +0200)

----------------------------------------------------------------
netfilter pull request 23-10-25

----------------------------------------------------------------
Florian Westphal (4):
      netfilter: nft_set_rbtree: rename gc deactivate+erase function
      netfilter: nft_set_rbtree: prefer sync gc to async worker
      br_netfilter: use single forward hook for ip and arp
      netfilter: conntrack: switch connlabels to atomic_t

Pablo Neira Ayuso (5):
      netfilter: nft_set_pipapo: no need to call pipapo_deactivate() from flush
      netfilter: nf_tables: set backend .flush always succeeds
      netfilter: nf_tables: expose opaque set element as struct nft_elem_priv
      netfilter: nf_tables: shrink memory consumption of set elements
      netfilter: nf_tables: set->ops->insert returns opaque set element in case of EEXIST

Phil Sutter (10):
      netfilter: nf_tables: Open-code audit log call in nf_tables_getrule()
      netfilter: nf_tables: Introduce nf_tables_getrule_single()
      netfilter: nf_tables: Add locking for NFT_MSG_GETRULE_RESET requests
      netfilter: nf_tables: Drop pointless memset in nf_tables_dump_obj
      netfilter: nf_tables: Unconditionally allocate nft_obj_filter
      netfilter: nf_tables: A better name for nft_obj_filter
      netfilter: nf_tables: Carry s_idx in nft_obj_dump_ctx
      netfilter: nf_tables: nft_obj_filter fits into cb->ctx
      netfilter: nf_tables: Carry reset boolean in nft_obj_dump_ctx
      netfilter: nf_tables: Carry reset boolean in nft_set_dump_ctx

 include/net/netfilter/nf_conntrack_labels.h |   2 +-
 include/net/netfilter/nf_tables.h           |  60 ++--
 include/net/netns/conntrack.h               |   2 +-
 net/bridge/br_netfilter_hooks.c             |  72 +++--
 net/netfilter/nf_conntrack_labels.c         |  17 +-
 net/netfilter/nf_tables_api.c               | 445 +++++++++++++++-------------
 net/netfilter/nft_dynset.c                  |  23 +-
 net/netfilter/nft_set_bitmap.c              |  53 ++--
 net/netfilter/nft_set_hash.c                | 109 +++----
 net/netfilter/nft_set_pipapo.c              |  73 ++---
 net/netfilter/nft_set_pipapo.h              |   4 +-
 net/netfilter/nft_set_rbtree.c              | 200 ++++++-------
 12 files changed, 558 insertions(+), 502 deletions(-)

