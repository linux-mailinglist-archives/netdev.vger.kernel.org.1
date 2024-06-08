Return-Path: <netdev+bounces-102044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F949013DF
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 00:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FB02822B1
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 22:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176FE224F0;
	Sat,  8 Jun 2024 22:20:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057751804E
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717885239; cv=none; b=br/Cfh1oG/Cprh7YykwHcIC7yov+fj+tGANzGQpgGm5eFTLX36TKNTv5+APIyy/N4SqTr+hIykv8tv5NoTSFvsOF3wHFyp/+B8EW65hv01MnXrFSw4EdBq6giZT2IaT6XShphWcJ5fxPPlJN+VoqDj+8oLLKDOgQlAJeryw7+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717885239; c=relaxed/simple;
	bh=2aY8rKjiXkmAOU3I4vAgIaAFjS6TYFYYnubVSgpRh3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AnzS8BkscDerMyzJ4QpmUK4Kro2wlkPxPcbZUW6/rxl4ProPaXnJUCxRB0grmmuOqCEIFZN7T+YI//pFsyDiOa5l5nJfbzPqSVvtBtm6FLoK8WnqcoYQkotk4iTRbh5qKBnO5JCwuvFqJvY+EwbCZsDt7+84k35Zx1YLQrbdTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sG4QM-0003iO-81; Sun, 09 Jun 2024 00:20:34 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	willemb@google.com,
	pablo@netfilter.org
Subject: [PATCH net-next v2 0/2] net: flow dissector: allow explicit passing of netns
Date: Sun,  9 Jun 2024 00:10:38 +0200
Message-ID: <20240608221057.16070-1-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change since last version:
 fix kdoc comment warning reported by kbuild robot, no other changes,
 thus retaining RvB tags from Eric and Willem.
 v1: https://lore.kernel.org/netdev/20240607083205.3000-1-fw@strlen.de/

Years ago flow dissector gained ability to delegate flow dissection
to a bpf program, scoped per netns.

The netns is derived from skb->dev, and if that is not available, from
skb->sk.  If neither is set, we hit a (benign) WARN_ON_ONCE().

This WARN_ON_ONCE can be triggered from netfilter.
Known skb origins are nf_send_reset and ipv4 stack generated IGMP
messages.

Lets allow callers to pass the current netns explicitly and make
nf_tables use those instead.

This targets net-next instead of net because the WARN is benign and this
is not a regression.

Florian Westphal (2):
  net: add and use skb_get_hash_net
  net: add and use __skb_get_hash_symmetric_net

 include/linux/skbuff.h          | 20 +++++++++++++++++---
 net/core/flow_dissector.c       | 21 ++++++++++++++-------
 net/netfilter/nf_tables_trace.c |  2 +-
 net/netfilter/nft_hash.c        |  3 ++-
 4 files changed, 34 insertions(+), 12 deletions(-)

-- 
2.44.2


