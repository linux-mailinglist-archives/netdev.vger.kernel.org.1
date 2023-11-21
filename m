Return-Path: <netdev+bounces-49634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6867B7F2D23
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC344B21717
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762F4A99C;
	Tue, 21 Nov 2023 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE2E7;
	Tue, 21 Nov 2023 04:28:22 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1r5PrY-0005Ax-Sz; Tue, 21 Nov 2023 13:28:20 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: lorenzo@kernel.org,
	<netdev@vger.kernel.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/8] netfilter: make nf_flowtable lifetime differ from container struct
Date: Tue, 21 Nov 2023 13:27:43 +0100
Message-ID: <20231121122800.13521-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series detaches nf_flowtable from the two existing container
structures.

Allocation and freeing is moved to the flowtable core.
Then, memory release is changed so it passes through another
synchronize_rcu() call.

Next, a new nftables flowtable flag is introduced to mark a flowtable
for explicit XDP-based offload.

Such flowtables have more restrictions,
in particular, if two flowtables are tagged as 'xdp offloaded', they
cannot share any net devices.

It would be possible to avoid such new 'xdp flag', but I see no way
to do so without breaking backwards compatbility: at this time the same
net_device can be part of any number of flowtables, this is very
inefficient from an XDP point of view: it would have to perform lookups
in all associated flowtables in a loop until a match is found.

This is hardly desirable.

Last two patches expose the hash table mapping and make utility
function available for XDP.

The XDP kfunc will be added in a followup patch.

Florian Westphal (8):
  netfilter: flowtable: move nf_flowtable out of container structures
  netfilter: nf_flowtable: replace init callback with a create one
  netfilter: nf_flowtable: make free a real free function
  netfilter: nf_flowtable: delay flowtable release a second time
  netfilter: nf_tables: reject flowtable hw offload for same device
  netfilter: nf_tables: add xdp offload flag
  netfilter: nf_tables: add flowtable map for xdp offload
  netfilter: nf_tables: permit duplicate flowtable mappings

 include/net/netfilter/nf_flow_table.h    |  15 ++-
 include/net/netfilter/nf_tables.h        |  15 ++-
 include/uapi/linux/netfilter/nf_tables.h |   5 +-
 net/netfilter/nf_flow_table_core.c       |  39 ++++--
 net/netfilter/nf_flow_table_inet.c       |   6 +-
 net/netfilter/nf_flow_table_offload.c    | 157 ++++++++++++++++++++++-
 net/netfilter/nf_tables_api.c            | 113 +++++++++++-----
 net/netfilter/nft_flow_offload.c         |   4 +-
 net/sched/act_ct.c                       |  37 +++---
 9 files changed, 315 insertions(+), 76 deletions(-)

-- 
2.41.0


