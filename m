Return-Path: <netdev+bounces-27821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8324077D5F7
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 00:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A170A1C20DC9
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03591AA60;
	Tue, 15 Aug 2023 22:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33DD1AA6B
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 22:30:26 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAF71BFF;
	Tue, 15 Aug 2023 15:30:25 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qW2YL-0004ZK-K7; Wed, 16 Aug 2023 00:30:17 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net 0/9] netfilter fixes for net
Date: Wed, 16 Aug 2023 00:29:50 +0200
Message-ID: <20230815223011.7019-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

These are netfilter fixes for the *net* tree.

First patch resolves a false-positive lockdep splat:
rcu_dereference is used outside of rcu read lock.  Let lockdep
validate that the transaction mutex is locked.

Second patch fixes a kdoc warning added in previous PR.

Third patch fixes a memory leak:
The catchall element isn't disabled correctly, this allows
userspace to deactivate the element again. This results in refcount
underflow which in turn prevents memory release. This was always
broken since the feature was added in 5.13.

Patch 4 fixes an incorrect change in the previous pull request:
Adding a duplicate key to a set should work if the duplicate key
has expired, restore this behaviour. All from myself.

Patch #5 resolves an old historic artifact in sctp conntrack:
a 300ms timeout for shutdown_ack. Increase this to 3s.  From Xin Long.

Patch #6 fixes a sysctl data race in ipvs, two threads can clobber the
sysctl value, from Sishuai Gong. This is a day-0 bug that predates git
history.

Patches 7, 8 and 9, from Pablo Neira Ayuso, are also followups
for the previous GC rework in nf_tables: The netlink notifier and the
netns exit path must both increment the gc worker seqcount, else worker
may encounter stale (free'd) pointers.

The following changes since commit e4dd0d3a2f64b8bd8029ec70f52bdbebd0644408:

  net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled (2023-08-15 20:24:04 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-23-08-16

for you to fetch changes up to 23185c6aed1ffb8fc44087880ba2767aba493779:

  netfilter: nft_dynset: disallow object maps (2023-08-16 00:05:15 +0200)

----------------------------------------------------------------
nf pull request 2023-08-16

----------------------------------------------------------------
Florian Westphal (4):
      netfilter: nf_tables: fix false-positive lockdep splat
      netfilter: nf_tables: fix kdoc warnings after gc rework
      netfilter: nf_tables: deactivate catchall elements in next generation
      netfilter: nf_tables: don't fail inserts if duplicate has expired

Pablo Neira Ayuso (3):
      netfilter: nf_tables: fix GC transaction races with netns and netlink event exit path
      netfilter: nf_tables: GC transaction race with netns dismantle
      netfilter: nft_dynset: disallow object maps

Sishuai Gong (1):
      ipvs: fix racy memcpy in proc_do_sync_threshold

Xin Long (1):
      netfilter: set default timeout to 3 secs for sctp shutdown send and recv state

 Documentation/networking/nf_conntrack-sysctl.rst |  4 +--
 include/net/netfilter/nf_tables.h                |  1 +
 net/netfilter/ipvs/ip_vs_ctl.c                   |  4 +++
 net/netfilter/nf_conntrack_proto_sctp.c          |  6 ++--
 net/netfilter/nf_tables_api.c                    | 44 +++++++++++++++++++++---
 net/netfilter/nft_dynset.c                       |  3 ++
 net/netfilter/nft_set_pipapo.c                   | 38 +++++++++-----------
 7 files changed, 69 insertions(+), 31 deletions(-)

