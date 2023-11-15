Return-Path: <netdev+bounces-48162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD0F7ECABC
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B85A1F22870
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E311C3A8D7;
	Wed, 15 Nov 2023 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C796D46;
	Wed, 15 Nov 2023 10:45:19 -0800 (PST)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 0/6] Netfilter fixes for net
Date: Wed, 15 Nov 2023 19:45:08 +0100
Message-Id: <20231115184514.8965-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

The following patchset contains Netfilter fixes for net:

1) Remove unused variable causing compilation warning in nft_set_rbtree,
   from Yang Li. This unused variable is a left over from previous
   merge window.

2) Possible return of uninitialized in nf_conntrack_bridge, from
   Linkui Xiao. This is there since nf_conntrack_bridge is available.

3) Fix incorrect pointer math in nft_byteorder, from Dan Carpenter.
   Problem has been there since 2016.

4) Fix bogus error in destroy set element command. Problem is there
   since this new destroy command was added.

5) Fix race condition in ipset between swap and destroy commands and
   add/del/test control plane. This problem is there since ipset was
   merged.

6) Split async and sync catchall GC in two function to fix unsafe
   iteration over RCU. This is a fix-for-fix that was included in
   the previous pull request.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-23-11-15

Thanks.

----------------------------------------------------------------

The following changes since commit 4b7b492615cf3017190f55444f7016812b66611d:

  af_unix: fix use-after-free in unix_stream_read_actor() (2023-11-14 10:51:13 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-23-11-15

for you to fetch changes up to 8837ba3e58ea1e3d09ae36db80b1e80853aada95:

  netfilter: nf_tables: split async and sync catchall in two functions (2023-11-14 16:16:21 +0100)

----------------------------------------------------------------
netfilter pull request 23-11-15

----------------------------------------------------------------
Dan Carpenter (1):
      netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()

Jozsef Kadlecsik (1):
      netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test

Linkui Xiao (1):
      netfilter: nf_conntrack_bridge: initialize err to 0

Pablo Neira Ayuso (2):
      netfilter: nf_tables: bogus ENOENT when destroying element which does not exist
      netfilter: nf_tables: split async and sync catchall in two functions

Yang Li (1):
      netfilter: nft_set_rbtree: Remove unused variable nft_net

 include/net/netfilter/nf_tables.h          |  4 +-
 net/bridge/netfilter/nf_conntrack_bridge.c |  2 +-
 net/netfilter/ipset/ip_set_core.c          | 14 +++----
 net/netfilter/nf_tables_api.c              | 60 ++++++++++++++++--------------
 net/netfilter/nft_byteorder.c              |  5 ++-
 net/netfilter/nft_meta.c                   |  2 +-
 net/netfilter/nft_set_rbtree.c             |  2 -
 7 files changed, 47 insertions(+), 42 deletions(-)

