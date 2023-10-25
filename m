Return-Path: <netdev+bounces-44132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C697D67E2
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBDD0B211FD
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 10:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD8226289;
	Wed, 25 Oct 2023 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285475CBE
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 10:08:29 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8021710A;
	Wed, 25 Oct 2023 03:08:27 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 0/2] Netfilter fixes for net
Date: Wed, 25 Oct 2023 12:08:17 +0200
Message-Id: <20231025100819.2664-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch contains two late Netfilter's flowtable fixes for net:

1) Flowtable GC pushes back packets to classic path in every GC run,
   ie. every second. This is because NF_FLOW_HW_ESTABLISHED is only
   used by sched/act_ct (never set) and IPS_SEEN_REPLY might be unset
   by the time the flow is offloaded (this status bit is only reliable
   in the sched/act_ct datapath).

2) sched/act_ct logic to push back packets to classic path to reevaluate
   if UDP flow is unidirectional only applies if IPS_HW_OFFLOAD_BIT is
   set on and no hardware offload request is pending to be handled.
   From Vlad Buslov.

These two patches fixes two problems that were introduced in the
previous 6.5 development cycle.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-23-10-25

Thanks.

----------------------------------------------------------------

The following changes since commit d2a0fc372aca561556e765d0a9ec365c7c12f0ad:

  tcp: fix wrong RTO timeout when received SACK reneging (2023-10-22 11:47:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-23-10-25

for you to fetch changes up to a63b6622120cd03a304796dbccb80655b3a21798:

  net/sched: act_ct: additional checks for outdated flows (2023-10-25 11:35:57 +0200)

----------------------------------------------------------------
netfilter pull request 23-10-25

----------------------------------------------------------------
Pablo Neira Ayuso (1):
      netfilter: flowtable: GC pushes back packets to classic path

Vlad Buslov (1):
      net/sched: act_ct: additional checks for outdated flows

 include/net/netfilter/nf_flow_table.h |  1 +
 net/netfilter/nf_flow_table_core.c    | 14 +++++++-------
 net/sched/act_ct.c                    |  9 +++++++++
 3 files changed, 17 insertions(+), 7 deletions(-)

