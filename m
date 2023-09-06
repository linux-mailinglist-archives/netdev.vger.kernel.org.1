Return-Path: <netdev+bounces-32310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00581794163
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 18:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1303A1C209D6
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 16:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038661094E;
	Wed,  6 Sep 2023 16:25:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93D1613D
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 16:25:39 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD227199B;
	Wed,  6 Sep 2023 09:25:36 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qdvLN-0007uQ-4Y; Wed, 06 Sep 2023 18:25:29 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net 0/6] netfilter updates for net
Date: Wed,  6 Sep 2023 18:25:06 +0200
Message-ID: <20230906162525.11079-1-fw@strlen.de>
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

This PR contains nf_tables updates for your *net* tree.
This time almost all fixes are for old bugs:

First patch fixes a 4-byte stack OOB write, from myself.
This was broken ever since nftables was switches from 128 to 32bit
register addressing in v4.1.

2nd patch fixes an out-of-bounds read.
This has been broken ever since xt_osf got added in 2.6.31, the bug
was then just moved around during refactoring, from Wander Lairson Costa.

3rd patch adds a missing enum description, from Phil Sutter.

4th patch fixes a UaF inftables that occurs when userspace adds
elements with a timeout so small that expiration happens while the
transaction is still in progress.  Fix from Pablo Neira Ayuso.

Patch 5 fixes a memory out of bounds access, this was
broken since v4.20. Patch from Kyle Zeng and Jozsef Kadlecsik.

Patch 6 fixes another bogus memory access when building audit
record. Bug added in the previous pull request, fix from Pablo.

The following changes since commit 1a961e74d5abbea049588a3d74b759955b4ed9d5:

  net: phylink: fix sphinx complaint about invalid literal (2023-09-06 07:46:49 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-23-09-06

for you to fetch changes up to 9b5ba5c9c5109bf89dc64a3f4734bd125d1ce52e:

  netfilter: nf_tables: Unbreak audit log reset (2023-09-06 18:09:12 +0200)

----------------------------------------------------------------
netfilter pull request 2023-09-06

----------------------------------------------------------------
Florian Westphal (1):
      netfilter: nftables: exthdr: fix 4-byte stack OOB write

Kyle Zeng (1):
      netfilter: ipset: add the missing IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c

Pablo Neira Ayuso (2):
      netfilter: nft_set_rbtree: skip sync GC for new elements in this transaction
      netfilter: nf_tables: Unbreak audit log reset

Phil Sutter (1):
      netfilter: nf_tables: uapi: Describe NFTA_RULE_CHAIN_ID

Wander Lairson Costa (1):
      netfilter: nfnetlink_osf: avoid OOB read

 include/uapi/linux/netfilter/nf_tables.h     |  1 +
 net/netfilter/ipset/ip_set_hash_netportnet.c |  1 +
 net/netfilter/nf_tables_api.c                | 11 ++++++-----
 net/netfilter/nfnetlink_osf.c                |  8 ++++++++
 net/netfilter/nft_exthdr.c                   | 22 ++++++++++++++--------
 net/netfilter/nft_set_rbtree.c               |  8 ++++++--
 6 files changed, 36 insertions(+), 15 deletions(-)

