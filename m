Return-Path: <netdev+bounces-40282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182657C68A6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 10:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09681C21107
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E2208B9;
	Thu, 12 Oct 2023 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E2F1F952
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 08:57:38 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC1690;
	Thu, 12 Oct 2023 01:57:35 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qqrVY-00075T-P3; Thu, 12 Oct 2023 10:57:28 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net 0/7] netfilter updates for net
Date: Thu, 12 Oct 2023 10:57:03 +0200
Message-ID: <20231012085724.15155-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

The following contains patches for your *net* tree.

Patch 1, from Pablo Neira Ayuso, fixes a performance regression
(since 6.4) when a large pending set update has to be canceled towards
the end of the transaction.

Patch 2 from myself, silences an incorrect compiler warning reported
with a few (older) compiler toolchains.

Patch 3, from Kees Cook, adds __counted_by annotation to
nft_pipapo set backend type.  I took this for net instead of -next
given infra is already in place and no actual code change is made.

Patch 4, from Pablo Neira Ayso, disables timeout resets on
stateful element reset.  The rest should only affect internal object
state, e.g. reset a quota or counter, but not affect a pending timeout.

Patches 5 and 6 fix NULL dereferences in 'inner header' match,
control plane doesn't test for netlink attribute presence before
accessing them. Broken since feature was added in 6.2, fixes from
Xingyuan Mo.

Last patch, from myself, fixes a bogus rule match when skb has
a 0-length mac header, in this case we'd fetch data from network
header instead of canceling rule evaluation.  This is a day 0 bug,
present since nftables was merged in 3.13.

The following changes since commit 50e492143374c17ad89c865a1a44837b3f5c8226:

  octeontx2-pf: Fix page pool frag allocation warning (2023-10-12 09:48:51 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-23-10-12

for you to fetch changes up to d351c1ea2de3e36e608fc355d8ae7d0cc80e6cd6:

  netfilter: nft_payload: fix wrong mac header matching (2023-10-12 10:28:45 +0200)

----------------------------------------------------------------
nf pull request 2023-10-12

----------------------------------------------------------------
Florian Westphal (2):
      netfilter: nfnetlink_log: silence bogus compiler warning
      netfilter: nft_payload: fix wrong mac header matching

Kees Cook (1):
      netfilter: nf_tables: Annotate struct nft_pipapo_match with __counted_by

Pablo Neira Ayuso (2):
      netfilter: nf_tables: do not remove elements if set backend implements .abort
      netfilter: nf_tables: do not refresh timeout when resetting element

Xingyuan Mo (2):
      nf_tables: fix NULL pointer dereference in nft_inner_init()
      nf_tables: fix NULL pointer dereference in nft_expr_inner_parse()

 net/netfilter/nf_tables_api.c  | 25 ++++++++++---------------
 net/netfilter/nfnetlink_log.c  |  2 +-
 net/netfilter/nft_inner.c      |  1 +
 net/netfilter/nft_payload.c    |  2 +-
 net/netfilter/nft_set_pipapo.h |  2 +-
 5 files changed, 14 insertions(+), 18 deletions(-)

