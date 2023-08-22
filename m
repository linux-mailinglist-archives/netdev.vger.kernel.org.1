Return-Path: <netdev+bounces-29693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05777845F4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051451C209BD
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4871DA2E;
	Tue, 22 Aug 2023 15:43:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FFC1C28D
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:43:51 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDF2CCB;
	Tue, 22 Aug 2023 08:43:49 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qYTXg-0003EH-TZ; Tue, 22 Aug 2023 17:43:40 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 00/10] netfilter updates for net-next
Date: Tue, 22 Aug 2023 17:43:21 +0200
Message-ID: <20230822154336.12888-1-fw@strlen.de>
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

This batch contains a few updates for your *net-next* tree.
First patch resolves a fortify warning by wrapping the to-be-copied
members via struct_group.

Second patch replaces array[0] with array[] in ebtables uapi.
Both changes from GONG Ruiqi.

The largest chunk is replacement of strncpy with strscpy_pad()
in netfilter, from Justin Stitt.

Last patch, from myself, aborts ruleset validation if a fatal
signal is pending, this speeds up process exit.

The following changes since commit 43c2817225fce05701f062a996255007481935e2:

  net: remove unnecessary input parameter 'how' in ifdown function (2023-08-22 13:19:02 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git tags/nf-next-23-08-22

for you to fetch changes up to 169384fbe8513185499bcbb817d198e6a63eb37e:

  netfilter: nf_tables: allow loop termination for pending fatal signal (2023-08-22 15:14:32 +0200)

----------------------------------------------------------------
nf-next pull request 2023-08-22

----------------------------------------------------------------
Florian Westphal (1):
      netfilter: nf_tables: allow loop termination for pending fatal signal

GONG, Ruiqi (2):
      netfilter: ebtables: fix fortify warnings in size_entry_mwt()
      netfilter: ebtables: replace zero-length array members

Justin Stitt (7):
      netfilter: ipset: refactor deprecated strncpy
      netfilter: nf_tables: refactor deprecated strncpy
      netfilter: nf_tables: refactor deprecated strncpy
      netfilter: nft_osf: refactor deprecated strncpy
      netfilter: nft_meta: refactor deprecated strncpy
      netfilter: x_tables: refactor deprecated strncpy
      netfilter: xtables: refactor deprecated strncpy

 include/uapi/linux/netfilter_bridge/ebtables.h | 22 ++++++++++++----------
 net/bridge/netfilter/ebtables.c                |  3 +--
 net/netfilter/ipset/ip_set_core.c              | 10 +++++-----
 net/netfilter/nf_tables_api.c                  |  6 ++++++
 net/netfilter/nft_ct.c                         |  2 +-
 net/netfilter/nft_fib.c                        |  2 +-
 net/netfilter/nft_meta.c                       |  6 +++---
 net/netfilter/nft_osf.c                        |  6 +++---
 net/netfilter/x_tables.c                       |  5 ++---
 net/netfilter/xt_repldata.h                    |  2 +-
 10 files changed, 35 insertions(+), 29 deletions(-)

