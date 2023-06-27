Return-Path: <netdev+bounces-14247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5294673FC11
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF191C20B06
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 12:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AF5168CC;
	Tue, 27 Jun 2023 12:39:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0959210F9
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 12:39:08 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C38CDD
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 05:39:07 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qE7yM-0003u3-7v; Tue, 27 Jun 2023 14:39:06 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH net v3 0/3] net/sched: act_ipt bug fixes
Date: Tue, 27 Jun 2023 14:38:10 +0200
Message-Id: <20230627123813.3036-1-fw@strlen.de>
X-Mailer: git-send-email 2.39.3
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

v3: prefer skb_header() helper in patch 2.  No other changes.
I've retained Acks and RvB-Tags of v2.

While checking if netfilter could be updated to replace selected
instances of NF_DROP with kfree_skb_reason+NF_STOLEN to improve
debugging info via drop monitor I found that act_ipt is incompatible
with such an approach.  Moreover, it lacks multiple sanity checks
to avoid certain code paths that make assumptions that the tc layer
doesn't meet, such as header sanity checks, availability of skb_dst,
skb_nfct() and so on.

act_ipt test in the tc selftest still pass with this applied.

I think that we should consider removal of this module, while
this should take care of all problems, its ipv4 only and I don't
think there are any netfilter targets that lack a native tc
equivalent, even when ignoring bpf.

Florian Westphal (3):
  net/sched: act_ipt: add sanity checks on table name and hook locations
  net/sched: act_ipt: add sanity checks on skb before calling target
  net/sched: act_ipt: zero skb->cb before calling target

 net/sched/act_ipt.c | 70 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 7 deletions(-)

-- 
2.39.3


