Return-Path: <netdev+bounces-42236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220E77CDC66
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4AF1C2082D
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 12:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B3347CD;
	Wed, 18 Oct 2023 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701A339B4
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 12:56:21 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2590109;
	Wed, 18 Oct 2023 05:56:19 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qt65q-0008CF-3y; Wed, 18 Oct 2023 14:56:10 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net 0/4] netfilter: updates for net
Date: Wed, 18 Oct 2023 14:55:56 +0200
Message-ID: <20231018125605.27299-1-fw@strlen.de>
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

This series contains fixes for your *net* tree.
First patch, from Phil Sutter, reduces number of audit notifications
when userspace requests to re-set stateful objects.
This change also comes with a selftest update.

Second patch, also from Phil, moves the nftables audit selftest
to its own netns to avoid interference with the init netns.

Third patch, from Pablo Neira, fixes an inconsistency with the "rbtree"
set backend: When set element X has expired, a request to delete element
X should fail (like with all other backends).

Finally, patch four, also from Pablo, reverts a recent attempt to speed
up abort of a large pending update with the "pipapo" set backend.

It could cause stray references to remain in the set, which then
results in a double-free.

The following changes since commit 2915240eddba96b37de4c7e9a3d0ac6f9548454b:

  neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section (2023-10-18 11:16:43 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-23-10-18

for you to fetch changes up to f86fb94011aeb3b26337fc22204ca726aeb8bc24:

  netfilter: nf_tables: revert do not remove elements if set backend implements .abort (2023-10-18 13:47:32 +0200)

----------------------------------------------------------------
netfilter pr 2023-18-10

----------------------------------------------------------------
Pablo Neira Ayuso (2):
      netfilter: nft_set_rbtree: .deactivate fails if element has expired
      netfilter: nf_tables: revert do not remove elements if set backend implements .abort

Phil Sutter (2):
      netfilter: nf_tables: audit log object reset once per table
      selftests: netfilter: Run nft_audit.sh in its own netns

 net/netfilter/nf_tables_api.c                  | 55 ++++++++++++++------------
 net/netfilter/nft_set_rbtree.c                 |  2 +
 tools/testing/selftests/netfilter/nft_audit.sh | 52 ++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 26 deletions(-)

