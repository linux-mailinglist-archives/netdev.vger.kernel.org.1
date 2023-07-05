Return-Path: <netdev+bounces-15660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A89749146
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 01:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E50528116B
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 23:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E16156F7;
	Wed,  5 Jul 2023 23:04:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8B154BE
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 23:04:15 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAA7E102;
	Wed,  5 Jul 2023 16:04:14 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net 0/6] Netfilter fixes for net
Date: Thu,  6 Jul 2023 01:04:00 +0200
Message-Id: <20230705230406.52201-1-pablo@netfilter.org>
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

The following patchset contains Netfilter fixes for net:

1) Fix missing overflow use refcount checks in nf_tables.

2) Do not set IPS_ASSURED for IPS_NAT_CLASH entries in GRE tracker,
   from Florian Westphal.

3) Bail out if nf_ct_helper_hash is NULL before registering helper,
   from Florent Revest.

4) Use siphash() instead siphash_4u64() to fix performance regression,
   also from Florian.

5) Do not allow to add rules to removed chains via ID,
   from Thadeu Lima de Souza Cascardo.

6) Fix oob read access in byteorder expression, also from Thadeu.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-23-07-06

Thanks.

----------------------------------------------------------------

The following changes since commit c451410ca7e3d8eeb31d141fc20c200e21754ba4:

  Merge branch 'mptcp-fixes' (2023-07-05 10:51:14 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-23-07-06

for you to fetch changes up to caf3ef7468f7534771b5c44cd8dbd6f7f87c2cbd:

  netfilter: nf_tables: prevent OOB access in nft_byteorder_eval (2023-07-06 00:53:14 +0200)

----------------------------------------------------------------
netfilter pull request 23-07-06

----------------------------------------------------------------
Florent Revest (1):
      netfilter: conntrack: Avoid nf_ct_helper_hash uses after free

Florian Westphal (2):
      netfilter: conntrack: gre: don't set assured flag for clash entries
      netfilter: conntrack: don't fold port numbers into addresses before hashing

Pablo Neira Ayuso (1):
      netfilter: nf_tables: report use refcount overflow

Thadeu Lima de Souza Cascardo (2):
      netfilter: nf_tables: do not ignore genmask when looking up chain by id
      netfilter: nf_tables: prevent OOB access in nft_byteorder_eval

 include/net/netfilter/nf_conntrack_tuple.h |   3 +
 include/net/netfilter/nf_tables.h          |  31 ++++-
 net/netfilter/nf_conntrack_core.c          |  20 ++--
 net/netfilter/nf_conntrack_helper.c        |   4 +
 net/netfilter/nf_conntrack_proto_gre.c     |  10 +-
 net/netfilter/nf_tables_api.c              | 174 ++++++++++++++++++-----------
 net/netfilter/nft_byteorder.c              |  14 +--
 net/netfilter/nft_flow_offload.c           |   6 +-
 net/netfilter/nft_immediate.c              |   8 +-
 net/netfilter/nft_objref.c                 |   8 +-
 10 files changed, 178 insertions(+), 100 deletions(-)

