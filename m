Return-Path: <netdev+bounces-21479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C3C763AF9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C9B1C2132E
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F2C253B2;
	Wed, 26 Jul 2023 15:25:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C1CA63
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:25:35 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2799BF;
	Wed, 26 Jul 2023 08:25:33 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qOgOG-0001Gb-BL; Wed, 26 Jul 2023 17:25:28 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net 0/3] netfilter fixes for net
Date: Wed, 26 Jul 2023 17:23:46 +0200
Message-ID: <20230726152524.26268-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

Here are three netfilter fixes for the *net* tree:
1. On-demand overlap detection in 'rbtree' set can cause memory leaks.
   This is broken since 6.2.

2. An earlier fix in 6.4 to address an imbalance in refcounts during
   transaction error unwinding was incomplete, from Pablo Neira.

3. Disallow adding a rule to a deleted chain, also from Pablo.
   Broken since 5.9.

The following changes since commit d4a7ce642100765119a872d4aba1bf63e3a22c8a:

  igc: Fix Kernel Panic during ndo_tx_timeout callback (2023-07-26 09:54:40 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-23-07-26

for you to fetch changes up to 0ebc1064e4874d5987722a2ddbc18f94aa53b211:

  netfilter: nf_tables: disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID (2023-07-26 16:48:49 +0200)

----------------------------------------------------------------
netfilter pull request 2023-07-26

----------------------------------------------------------------
Florian Westphal (1):
      netfilter: nft_set_rbtree: fix overlap expiration walk

Pablo Neira Ayuso (2):
      netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR
      netfilter: nf_tables: disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID

 net/netfilter/nf_tables_api.c  |  5 +++--
 net/netfilter/nft_immediate.c  | 27 ++++++++++++++++++---------
 net/netfilter/nft_set_rbtree.c | 20 ++++++++++++++------
 3 files changed, 35 insertions(+), 17 deletions(-)

