Return-Path: <netdev+bounces-27739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822CE77D108
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F5B28142D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD2A15AC8;
	Tue, 15 Aug 2023 17:32:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12040EDE
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 17:32:21 +0000 (UTC)
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504CB1BD1;
	Tue, 15 Aug 2023 10:32:20 -0700 (PDT)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
	by mg.bb.i.ssi.bg (Proxmox) with ESMTP id C89D9FF87;
	Tue, 15 Aug 2023 20:32:18 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id B0967FDF0;
	Tue, 15 Aug 2023 20:32:18 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 2438D3C079A;
	Tue, 15 Aug 2023 20:32:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1692120736; bh=DmUGBB67o/PyhIKOEYZ9nTkCUuQziqzsg9YKkk9WS1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EGwTMgwXjWKELpYscuTQrnwYAetTEwnXItcgVJ/NBCfGW2gsTDEKnoVCN8qG1o1z8
	 jofuF72JB/pgq+MIbzb77SS9ux2cCXRRWCuHp2F3aEgjIyqf6KuBJPhcgay3sE7zxG
	 zzx7aZYMGcXiEsERm8RnI26c2dWjyCUJokeiTRCs=
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 37FHWFqY168609;
	Tue, 15 Aug 2023 20:32:15 +0300
Received: (from root@localhost)
	by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 37FHWFx6168608;
	Tue, 15 Aug 2023 20:32:15 +0300
From: Julian Anastasov <ja@ssi.bg>
To: Simon Horman <horms@verge.net.au>
Cc: lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        netdev@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Dust Li <dust.li@linux.alibaba.com>,
        Jiejian Wu <jiejian@linux.alibaba.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: [PATCH RFC net-next 01/14] rculist_bl: add hlist_bl_for_each_entry_continue_rcu
Date: Tue, 15 Aug 2023 20:30:18 +0300
Message-ID: <20230815173031.168344-2-ja@ssi.bg>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815173031.168344-1-ja@ssi.bg>
References: <20230815173031.168344-1-ja@ssi.bg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add hlist_bl_for_each_entry_continue_rcu and hlist_bl_next_rcu

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 include/linux/rculist_bl.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/rculist_bl.h b/include/linux/rculist_bl.h
index 0b952d06eb0b..93a757793d83 100644
--- a/include/linux/rculist_bl.h
+++ b/include/linux/rculist_bl.h
@@ -24,6 +24,10 @@ static inline struct hlist_bl_node *hlist_bl_first_rcu(struct hlist_bl_head *h)
 		((unsigned long)rcu_dereference_check(h->first, hlist_bl_is_locked(h)) & ~LIST_BL_LOCKMASK);
 }
 
+/* return the next element in an RCU protected list */
+#define hlist_bl_next_rcu(node)	\
+	(*((struct hlist_bl_node __rcu **)(&(node)->next)))
+
 /**
  * hlist_bl_del_rcu - deletes entry from hash list without re-initialization
  * @n: the element to delete from the hash list.
@@ -98,4 +102,17 @@ static inline void hlist_bl_add_head_rcu(struct hlist_bl_node *n,
 		({ tpos = hlist_bl_entry(pos, typeof(*tpos), member); 1; }); \
 		pos = rcu_dereference_raw(pos->next))
 
+/**
+ * hlist_bl_for_each_entry_continue_rcu - iterate over a list continuing after
+ *   current point
+ * @tpos:	the type * to use as a loop cursor.
+ * @pos:	the &struct hlist_bl_node to use as a loop cursor.
+ * @member:	the name of the hlist_bl_node within the struct.
+ */
+#define hlist_bl_for_each_entry_continue_rcu(tpos, pos, member)		\
+	for (pos = rcu_dereference_raw(hlist_bl_next_rcu(&(tpos)->member)); \
+	     pos &&							\
+	     ({ tpos = hlist_bl_entry(pos, typeof(*tpos), member); 1; }); \
+	     pos = rcu_dereference_raw(hlist_bl_next_rcu(pos)))
+
 #endif
-- 
2.41.0



