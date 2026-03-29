Return-Path: <netdev+bounces-272941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIJjEKRYyWkuxgUAu9opvQ
	(envelope-from <netdev+bounces-272941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:51:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 458AF353287
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57657300383D
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A93379EE6;
	Sun, 29 Mar 2026 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbNMOS4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA5D3815FF
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774803102; cv=none; b=GcUtOtYuey6Ome2In9qZZk1zyEdeviBk6DKY0b8USnXuAeuy9MmdLT2R5StxtaO4aRiDY+u+qGaTDtRyiV33fvQrOlru39pDEMnEZL07Co2JYIp2QItJGy95l4Jaetb/SMXLwqBxSiXcurcjD65YebHWgdCwvDPzO/w3BKMr9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774803102; c=relaxed/simple;
	bh=+/li8ir0cS6ptJjeq5uk7yw+iqBQNmezjlb7upWUo0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFbRXq9Y6YbV2q1rCuqtkfLe03tC7AGNS+txDpHj/ks8IQXf3egxb3suN+RcK/U155p+HsR9d8xLTuxao+UblV4ilCnH2a/T4giiHc8/PAafiG/USIQqfY/2dIOtLvQzNcocSohbpDvrlhvdjcNenOu9ChWZ1nFqeQ9eX/xKMtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbNMOS4w; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d9827661bso451364a91.3
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774803099; x=1775407899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXMpi9W0ohIEOw0qI/5F6ExlkOwkg6UyfvzQqFC3OoM=;
        b=QbNMOS4wRUWU2R6DenjyxiucOrCYfXMqn1uIZ/2ZRnam2zRVtQz91YcgrJU4TzPAoy
         QReKhxtwVZHWk+g8VT9xGnwYEY+WnSpyIMNKWvhg54iH+i8Gca7RD1QKsRq2m4KBA19+
         fIe8dEPJeeMTTqDwfOB+RRTBujFnWB+RcfmBmUvCVt7zc7SZjRHecKidx88oUax7sXA4
         Q2JoxxZhPkQaNVsRuZZ+pg7D1YRMwcGoQMhmRPGQmjWhw5cY9I11Fs6xgwKnoUpwDgoL
         uLSqWJ8lG9aYpHP5+EvwNW/Byl7p43SB2l3yF1q17JhKll13x9R9ZF2OcTm/pJbVgfW4
         0FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774803099; x=1775407899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXMpi9W0ohIEOw0qI/5F6ExlkOwkg6UyfvzQqFC3OoM=;
        b=fDanALBRlxW4vl8/zMo7XPX52xtJBXfLVRj1c2XMijCcTK84A7s6OfIyv5KJarCv/W
         DfmSD4477rR0soyGAFFPgr91+rr4sHhLVVxa//S7/TML/qGoofoAQ6GdBXAQrP2qr49c
         M5VNg1RNWllAY85WcSM4nXxj5L+yy+PLa8/0Nj3D7ZrZBazZq4Bj1KoFQ0EnQ3I1jdjA
         oeh6g12kuTMWh4HDrOWekh+77xj1+c7w5xsBg8hjyLRYzfSbK0sxwFxMsj/xY/gMCmGP
         KO5TAskx682bYhNlZIGf5yqZoklQPp1X1SbplD8JboAzQ2XHZvBSwd7etRgkysMGqgTD
         PO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLJJ19rr5K9FvvBMydy6gVLfT7NWix52DjivrvRDjRZYCe+f/IbDGsBWt8xY8/c4xhsX8hqlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh19PsTZvvkymjQHzYn+q76BgBYHVgWaTdqfUshvJdz/QVA5qx
	1Jb521BJfJa9z/3mSh+D5WswFw1Fd2LVLQqVs2P30UFyrIw20F6hpsn6
X-Gm-Gg: ATEYQzwlVJXuL7Kl/vY0w5BwED0972lRLnJFaMsitK69ftBTkXwmHoYWSGxVswhSEAj
	dbvYaRq2qwCjcnqP4eSmp5dqKqLjMRv9lEX4G9RovAbydOWd1MrcbGR0dIjASI/aY+fNJ5zCRsO
	ryH9uztkBSgxSF6Ce+KttTVcwD6530A7/R0Ws2CuuxbXchT9PVmCFH9B4u9aCRVqik0t9myQQYw
	ZemlQsM5LhrhTL7GpiL1Z4KfNC4SSIcuDi/JzWn3pjQrRvM25X1nE5gDjIazjp1z138KXWxazIM
	7kuJe2glc+ETmwueCxR839/YG+QwzhqQiH+irhe4tA2OBn3wemoGUfolbBkqLUHt6TxmbS2U45x
	A8lqKtxHb48dloLpD26TK/oEq2JECN8idQCaKy0021U+5aaedC0yQCgS4mhMrKCL9OzLoBwlLiM
	qriFlYPYrF1FyQgJ0Szls52thcbsgtn2qT4nE=
X-Received: by 2002:a17:90b:164a:b0:35c:30a8:322 with SMTP id 98e67ed59e1d1-35c30a80a30mr9555894a91.0.1774803099575;
        Sun, 29 Mar 2026 09:51:39 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22ba5700sm10416654a91.8.2026.03.29.09.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:51:38 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH] netfilter: ctnetlink: validate expect class against master helper
Date: Mon, 30 Mar 2026 00:51:31 +0800
Message-ID: <20260329165131.240989-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nwl.cc,vger.kernel.org,netfilter.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-272941-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 458AF353287
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ctnetlink_alloc_expect() validates CTA_EXPECT_CLASS against the
helper specified by CTA_EXPECT_HELP_NAME.  However,
__nf_ct_expect_check() and nf_ct_expect_insert() later index the
expect_policy array using the master conntrack's actual helper.

When the supplied helper has a larger expect_class_max than the
master's helper, the class passes validation but produces an
out-of-bounds read on the master helper's heap-allocated policy
array during expectation insertion.

Validate the class against the master conntrack's own helper
instead, since that is the helper whose policy array will actually
be indexed.

  BUG: KASAN: slab-out-of-bounds in nf_ct_expect_related_report+0x2479/0x27c0
  Read of size 4 at addr ffff8880043fe408 by task poc/102
  Call Trace:
   nf_ct_expect_related_report+0x2479/0x27c0
   ctnetlink_create_expect+0x22b/0x3b0
   ctnetlink_new_expect+0x4bd/0x5c0
   nfnetlink_rcv_msg+0x67a/0x950
   netlink_rcv_skb+0x120/0x350

Fixes: b8c5e52c13ed ("netfilter: ctnetlink: allow to set expectation class")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/netfilter/nf_conntrack_netlink.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 3f408f3713bb..c57c665363e0 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3542,9 +3542,14 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
 	if (!help)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	if (cda[CTA_EXPECT_CLASS] && helper) {
+	if (cda[CTA_EXPECT_CLASS]) {
+		struct nf_conntrack_helper *master_helper;
+
+		master_helper = rcu_dereference(help->helper);
+		if (!master_helper)
+			return ERR_PTR(-EOPNOTSUPP);
 		class = ntohl(nla_get_be32(cda[CTA_EXPECT_CLASS]));
-		if (class > helper->expect_class_max)
+		if (class > master_helper->expect_class_max)
 			return ERR_PTR(-EINVAL);
 	}
 	exp = nf_ct_expect_alloc(ct);
-- 
2.43.0


