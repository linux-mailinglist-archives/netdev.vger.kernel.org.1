Return-Path: <netdev+bounces-276843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBMXEXg712lQLwgAu9opvQ
	(envelope-from <netdev+bounces-276843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 07:39:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4980E3C655E
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 07:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABB503011BD6
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 05:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E1A3019A9;
	Thu,  9 Apr 2026 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxKuQp8K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B32220F49
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 05:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775713120; cv=none; b=CBnXtkyrfNEkyDnpQf445v5oTYicssEx00cD33wKt5RJ6N5PQ7AiowGUmoHufY418P8OmLYW7qOpVLeHPf5JOOldhsI53VB4vKSiJ2i5mu7nafcf1dhV7Uyiow4AJIjfAgl/AqYoB5F3YJRy759YnefAL0jH12DwdklHw9kjwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775713120; c=relaxed/simple;
	bh=jSZqAPWmD5UeBY3lSP9uJxinqmVaSj4JkxvzKupoWFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SU8YYUuBkUGB0iIOJ1kDX4jyr/1BxFGxdEutyvHOFIeuzeFTixc/uaV+FdjPOCFIzqMuvV66B+bFXV7t5DLAvedwWD9Vyqu1BJZy8lzmMA5jSd9G72NFvyk0+F/EnihDsOcYw/DzZo/JlrVlRrBfSasqhlpzO+48xgWctau9mvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxKuQp8K; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d95017a68so419699a91.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 22:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775713118; x=1776317918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILbJrQUr91XnPo4IXS4Hz0fGhwl0HdfH9Des4pJSJPA=;
        b=VxKuQp8KU5Qh/TWF33nPzfh5les7E8yWE0Z+fTjDg7i31dwIfhAV23FHYhzUzcF++r
         PQHAolb7gq2lVlMq4LfXDqONX7A0M/lWBR2IMMB54rncwk1aIQHpmsP32ZozBMAInsIl
         h7fgpfbjeXm4G8Z74TfncG5CpKpRMh+Wk4pcYy13yRpVMXvKoL7bXDNHrduvjWE9S+S3
         l0XFM0OClmmaEB3Zolm6DDuuwoEx2GWoPSFo2QfnVd4I/hsRMjovHXJCQrwRRl4DwW0Y
         wJxF+CkSij4yRibcKJH9DlPRzN/zs68sdfxwq8kHlviasEhl4gLwUmfrmty9YwGuQy1W
         ASvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775713118; x=1776317918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILbJrQUr91XnPo4IXS4Hz0fGhwl0HdfH9Des4pJSJPA=;
        b=EDSKUPzP11Frsxj2l9xt+JR576F0TYovZD99hvVWertJPyvLfKRqk4R7ha1batevDJ
         j7mRaCnXkKvMk+nW7T4xpcmWxQE4x4JUTJ/TbX9qLROGO1nlTZ/mMfIpPkwE+Nx62BW+
         p++ePsQodmaDgUIyOCkFChQYB4WBHHR72wMFFKFjIhRb0+PwqKYmkn7u11uDQUs/d3Vm
         ZcvVU3wqh+90qSemZFdZRc7HAGVeuo1NQcReuXpw6AOk9Y7bvHKAApfaFU4jSW6rXufK
         bO3SAwxgrYOj91bBRshqPwiGisVeTDUMUDRrhdaxVlFLP6P4xncsGqI0oPec97U2WaJU
         nXlw==
X-Forwarded-Encrypted: i=1; AJvYcCV79QuG50CM3CmuA9b4tVAIXkT0rOeptY/titwnmAF9TAo1T4hoT/7O++TBS5GZkt0+vT5b+Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwovoeNZTgPs/ebHh/sqWAql3hVR0DgRCGOW/RlFdXjdWr0s3yl
	Tu7HEB9Y/veAjjc7sAFNte+selE1wmvvRkwgZgReCLvUNi5VVemmtF7e
X-Gm-Gg: AeBDiet3FsAJvByyTkRh46QFK+J1/CCZBvU0cOGINZjeOreq1io/uzkGmWwUcmSh4vH
	nf3djkB7ztLhoGO0i7QGh5o1BIyE+d73TfWBEA+p2fcbL0tUzD+CehHXp8qloB3Orurpr3kESy9
	1J9DPEII9Vt8qtrDvJ1mbFNzyuz8mGbii5wylDh3RXvkqprygOpKcDMgoOcMHp+z9R6gXfuMsZS
	q+QHvJH8Cfdxu/ak79MbThRRLN1aoZbDQQ6sWOCZhPVzxPi83FJaxHoUMbTBXOKfSCpUdni+D6N
	FqRM5sfIL55Eja+EMx/uJTrP5hIN+Lc/x+A1+lS0kMQkoBY0TAB6MRJDDnjtS3P4QYZH22vcdfZ
	15I/9l3cA2mpjcj9DnAkPsgKKPxZRbDd4mz8V3Xo/y6S1fRz2maJRFyzComMSHV12xCSY55XzLK
	5jIHU2nN3MdQy4SpkKIvH8Mu+wISDzwjd9nmPBhOjF4cOQhJGy5bhnf7kRsNrAfzQdsWlrVF6TT
	phoAfOuNgtF
X-Received: by 2002:a17:90b:4b0b:b0:35b:e554:53a6 with SMTP id 98e67ed59e1d1-35e357e8828mr2303089a91.11.1775713117796;
        Wed, 08 Apr 2026 22:38:37 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34c459a3sm641380a91.3.2026.04.08.22.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 22:38:37 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH nf] netfilter: nft_fwd_netdev: use recursion counter in neigh egress path
Date: Thu,  9 Apr 2026 13:36:30 +0800
Message-ID: <20260409053629.698822-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nwl.cc,kernel.org,vger.kernel.org,netfilter.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-276843-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: 4980E3C655E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nft_fwd_neigh_eval() can be attached to NF_NETDEV_EGRESS chains since
commit f87b9464d152 ("netfilter: nft_fwd_netdev: Support egress hook").
When a forwarding rule targets the same device (or two devices forward
to each other), the evaluator calls neigh_xmit() which reaches
dev_queue_xmit(), re-entering nf_hook_egress() before the previous
invocation returns. This recurses until the kernel stack is exhausted.

The nf_dup_skb_recursion counter in nf_do_netdev_egress() was added by
commit fcd53c51d037 ("netfilter: nf_dup_netdev: add and use recursion
counter") to prevent exactly this class of bug, but nft_fwd_neigh_eval()
bypasses that helper entirely by calling neigh_xmit() directly.

 BUG: KASAN: slab-out-of-bounds in nft_do_chain (net/netfilter/nf_tables_core.c:287)
 Call Trace:
  nft_do_chain (net/netfilter/nf_tables_core.c:287)
  nft_do_chain_netdev (net/netfilter/nft_chain_filter.c:289)
  nf_hook_slow (include/linux/netfilter.h:158)
  __dev_queue_xmit (net/core/dev.c:4807)
  neigh_resolve_output (include/linux/seqlock.h:392)
  neigh_xmit (net/core/neighbour.c:3230)
  nft_fwd_neigh_eval (net/netfilter/nft_fwd_netdev.c:150)
  nft_do_chain (net/netfilter/nf_tables_core.c:287)
  nft_do_chain_netdev (net/netfilter/nft_chain_filter.c:289)
  nf_hook_slow (include/linux/netfilter.h:158)
  __dev_queue_xmit (net/core/dev.c:4807)
  [repeats until stack exhaustion]

 Kernel panic - not syncing: Fatal exception in interrupt

Export the recursion counter helpers from nf_dup_netdev and use them
in nft_fwd_neigh_eval() to bound the recursion depth, matching the
protection already present in nf_do_netdev_egress().

Fixes: f87b9464d152 ("netfilter: nft_fwd_netdev: Support egress hook")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 include/net/netfilter/nf_dup_netdev.h |  4 ++++
 net/netfilter/nf_dup_netdev.c         | 18 ++++++++++++++++++
 net/netfilter/nft_fwd_netdev.c        |  7 +++++++
 3 files changed, 29 insertions(+)

diff --git a/include/net/netfilter/nf_dup_netdev.h b/include/net/netfilter/nf_dup_netdev.h
index b175d271aec9..17362f76d1d1 100644
--- a/include/net/netfilter/nf_dup_netdev.h
+++ b/include/net/netfilter/nf_dup_netdev.h
@@ -7,6 +7,10 @@
 void nf_dup_netdev_egress(const struct nft_pktinfo *pkt, int oif);
 void nf_fwd_netdev_egress(const struct nft_pktinfo *pkt, int oif);
 
+bool nf_dup_netdev_has_recursed(void);
+void nf_dup_netdev_recursion_inc(void);
+void nf_dup_netdev_recursion_dec(void);
+
 struct nft_offload_ctx;
 struct nft_flow_rule;
 
diff --git a/net/netfilter/nf_dup_netdev.c b/net/netfilter/nf_dup_netdev.c
index fab8b9011098..e2fe8bb6fe0d 100644
--- a/net/netfilter/nf_dup_netdev.c
+++ b/net/netfilter/nf_dup_netdev.c
@@ -29,6 +29,24 @@ static u8 *nf_get_nf_dup_skb_recursion(void)
 
 #endif
 
+bool nf_dup_netdev_has_recursed(void)
+{
+	return *nf_get_nf_dup_skb_recursion() > NF_RECURSION_LIMIT;
+}
+EXPORT_SYMBOL_GPL(nf_dup_netdev_has_recursed);
+
+void nf_dup_netdev_recursion_inc(void)
+{
+	(*nf_get_nf_dup_skb_recursion())++;
+}
+EXPORT_SYMBOL_GPL(nf_dup_netdev_recursion_inc);
+
+void nf_dup_netdev_recursion_dec(void)
+{
+	(*nf_get_nf_dup_skb_recursion())--;
+}
+EXPORT_SYMBOL_GPL(nf_dup_netdev_recursion_dec);
+
 static void nf_do_netdev_egress(struct sk_buff *skb, struct net_device *dev,
 				enum nf_dev_hooks hook)
 {
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 152a9fb4d23a..d85f72af3589 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -141,13 +141,20 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 		goto out;
 	}
 
+	if (nf_dup_netdev_has_recursed()) {
+		verdict = NF_DROP;
+		goto out;
+	}
+
 	dev = dev_get_by_index_rcu(nft_net(pkt), oif);
 	if (dev == NULL)
 		return;
 
 	skb->dev = dev;
 	skb_clear_tstamp(skb);
+	nf_dup_netdev_recursion_inc();
 	neigh_xmit(neigh_table, dev, addr, skb);
+	nf_dup_netdev_recursion_dec();
 out:
 	regs->verdict.code = verdict;
 }
-- 
2.43.0


