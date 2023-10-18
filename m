Return-Path: <netdev+bounces-42157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B7B7CD6F9
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 10:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6062BB20AED
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2A8156E1;
	Wed, 18 Oct 2023 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA7125CB
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:51:31 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA39AB6;
	Wed, 18 Oct 2023 01:51:29 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qt2Gw-0006Je-Vy; Wed, 18 Oct 2023 10:51:22 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 0/7] netfilter updates for net-next
Date: Wed, 18 Oct 2023 10:51:04 +0200
Message-ID: <20231018085118.10829-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

This series contains initial netfilter skb drop_reason support, from
myself.

First few patches fix up a few spots to make sure we won't trip
when followup patches embed error numbers in the upper bits
(we already do this in some places).

Then, nftables and bridge netfilter get converted to call kfree_skb_reason
directly to let tooling pinpoint exact location of packet drops,
rather than the existing NF_DROP catchall in nf_hook_slow().

I would like to eventually convert all netfilter modules, but as some
callers cannot deal with NF_STOLEN (notably act_ct), more preparation
work is needed for this.

Last patch gets rid of an ugly 'de-const' cast in nftables.

The following changes since commit a0a86022474304e012aad5d41943fdd31a036284:

  Merge branch 'devlink-deadlock' (2023-10-18 09:23:02 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git tags/nf-next-23-10-18

for you to fetch changes up to 256001672153af5786c6ca148114693d7d76d836:

  netfilter: nf_tables: de-constify set commit ops function argument (2023-10-18 10:26:43 +0200)

----------------------------------------------------------------
netfilter next pull request 2023-10-18

----------------------------------------------------------------
Florian Westphal (7):
      netfilter: xt_mangle: only check verdict part of return value
      netfilter: nf_tables: mask out non-verdict bits when checking return value
      netfilter: conntrack: convert nf_conntrack_update to netfilter verdicts
      netfilter: nf_nat: mask out non-verdict bits when checking return value
      netfilter: make nftables drops visible in net dropmonitor
      netfilter: bridge: convert br_netfilter to NF_DROP_REASON
      netfilter: nf_tables: de-constify set commit ops function argument

 include/linux/netfilter.h            | 10 +++++++
 include/net/netfilter/nf_tables.h    |  2 +-
 net/bridge/br_netfilter_hooks.c      | 26 ++++++++--------
 net/bridge/br_netfilter_ipv6.c       |  6 ++--
 net/ipv4/netfilter/iptable_mangle.c  |  9 +++---
 net/ipv6/netfilter/ip6table_mangle.c |  9 +++---
 net/netfilter/core.c                 |  6 ++--
 net/netfilter/nf_conntrack_core.c    | 58 ++++++++++++++++++++----------------
 net/netfilter/nf_nat_proto.c         |  5 ++--
 net/netfilter/nf_tables_core.c       |  8 +++--
 net/netfilter/nf_tables_trace.c      |  8 +++--
 net/netfilter/nfnetlink_queue.c      | 15 ++++++----
 net/netfilter/nft_set_pipapo.c       |  7 ++---
 13 files changed, 100 insertions(+), 69 deletions(-)

