Return-Path: <netdev+bounces-19588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF5075B4F9
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E761C214C0
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B842FA33;
	Thu, 20 Jul 2023 16:51:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02432FA2F
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 16:51:55 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F391E43;
	Thu, 20 Jul 2023 09:51:54 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qMWsV-0001LQ-TW; Thu, 20 Jul 2023 18:51:47 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net 0/5] Netfilter fixes for net:
Date: Thu, 20 Jul 2023 18:51:32 +0200
Message-ID: <20230720165143.30208-1-fw@strlen.de>
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
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following patchset contains Netfilter fixes for net:
1. Fix spurious -EEXIST error from userspace due to
   padding holes, this was broken since 4.9 days
   when 'ignore duplicate entries on insert' feature was
   added.

2. Fix a sched-while-atomic bug, present since 5.19.

3. Properly remove elements if they lack an "end range".
   nft userspace always sets an end range attribute, even
   when its the same as the start, but the abi doesn't
   have such a restriction. Always broken since it was
   added in 5.6, all three from myself.

4 + 5: Bound chain needs to be skipped in netns release
   and on rule flush paths, from Pablo Neira.

The following changes since commit ac528649f7c63bc233cc0d33cff11f767cc666e3:

  Merge branch 'net-support-stp-on-bridge-in-non-root-netns' (2023-07-20 10:46:33 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-23-07-20

for you to fetch changes up to 6eaf41e87a223ae6f8e7a28d6e78384ad7e407f8:

  netfilter: nf_tables: skip bound chain on rule flush (2023-07-20 17:21:11 +0200)

----------------------------------------------------------------
netfilter pull request 2023-07-20

----------------------------------------------------------------
Florian Westphal (3):
      netfilter: nf_tables: fix spurious set element insertion failure
      netfilter: nf_tables: can't schedule in nft_chain_validate
      netfilter: nft_set_pipapo: fix improper element removal

Pablo Neira Ayuso (2):
      netfilter: nf_tables: skip bound chain in netns release path
      netfilter: nf_tables: skip bound chain on rule flush

 net/netfilter/nf_tables_api.c  | 12 ++++++++++--
 net/netfilter/nft_set_pipapo.c |  6 +++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

