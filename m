Return-Path: <netdev+bounces-280163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mML/LK6S52lE+AEAu9opvQ
	(envelope-from <netdev+bounces-280163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:07:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8F843C881
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E75693048909
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DCF3D9DA1;
	Tue, 21 Apr 2026 14:57:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF3B3DA5BD
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783427; cv=none; b=guSlBScpKTZSAsv69lxvzx4McjFmeuvG/nI4sSGMDckTdyt2TKjn3BJXcmxmI+CVzZ1n/I+dRrR0wsJZi24mcHShjIIeJD+/7lyVs4p/I/gfMc+AGvd7rVTJlXr+/O5S73jURTUaNbrrfO3rTNr7r1LA8aOhORYMo+XORR3cXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783427; c=relaxed/simple;
	bh=vEyLqj7GaYFLC6EbF+/TuhCsA+lmUXD5qUR6PdSVoXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fqqd/YjXNXmBvK7eOnzX4/ceV9SNdu9jIEbdAGqGUeDKtIjDU5JuAiG41JNDJz/rq2v3BHMTghHSdCT2IJjNtcu/9+G5ucz6E0hyn4rOz2UGQHvU2APyFw+xx2qefCs7PUrFG0Gnt3njClHQLvR68gRwAI85ytEVlVkh/Sx+emk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowABn4AAbkOdpBvrYAA--.15877S2;
	Tue, 21 Apr 2026 22:56:27 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	Felix Maurer <fmaurer@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kees@kernel.org,
	kexinsun@smail.nju.edu.cn,
	luka.gejak@linux.dev,
	Arvid.Brodin@xdin.com,
	m-karicheri2@ti.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	xuyuqiabc@gmail.com,
	royenheart@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v3 1/1] net: hsr: limit node table growth
Date: Tue, 21 Apr 2026 22:50:01 +0800
Message-ID: <3bdbe54e81bd89c1443b05500368fb45bddc3191.1776754203.git.royenheart@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowABn4AAbkOdpBvrYAA--.15877S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF15ZF1fZrWUJFyDXry7Jrb_yoWrCrWUpF
	ZI9rWrtrZ3Jry8Kr4vy3WIvFWYqF4kGw4jgrZ7Ww1xu3WDtry7XFsI9rWYvF1rJFZ7Gr4a
	kFWqgr4kCrs0vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi_HU3UUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEECWnnOeEHlgADsJ
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280163-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,smail.nju.edu.cn,linux.dev,xdin.com,ti.com,gmail.com,lzu.edu.cn];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: BB8F843C881
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haoze Xie <royenheart@gmail.com>

The HSR/PRP node learning paths allocate one persistent entry per
previously unseen source MAC. Since learned entries stay alive until the
prune timer catches up, the node tables can otherwise grow without a
bound under high churn of learned senders.

Limit the number of learned entries in each node table and stop adding
new ones once the configured limit is reached. This keeps node-table
resource use bounded across the affected learning paths.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Fixes: 451d8123f897 ("net: prp: add packet handling support")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Yuqi Xu <xuyuqiabc@gmail.com>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
changes in v3:
- replace the v2 learning-suppression approach with direct node-table growth limiting
- add a node_table_size module parameter and stop learning new entries once each table reaches the configured limit
- fix the full-table handling so failed learning returns NULL instead of reusing an existing node
- v2 Link: https://lore.kernel.org/all/b053e938014c9bac22f7f687ecc2970f23a2b74a.1775281843.git.royenheart@gmail.com/

changes in v2:
- generalize the fix beyond PRP SAN traffic and cover HSR/PRP tagged sender floods
- decide whether learning is needed from local-exclusive delivery instead of protocol-specific SAN checks
- use the normal NULL return semantics from hsr_get_node() instead of ERR_PTR-based error plumbing
- skip duplicate-discard state checks when no node state exists
- v1 Link: https://lore.kernel.org/all/9c88b4b7844f867d065e7a7aba28b2c026386168.1775056603.git.royenheart@outlook.com/

 net/hsr/hsr_framereg.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index d09875b33588..8a5a2a54a81f 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -14,12 +14,18 @@
 #include <kunit/visibility.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
+#include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/rculist.h>
 #include "hsr_main.h"
 #include "hsr_framereg.h"
 #include "hsr_netlink.h"
 
+static unsigned int hsr_node_table_size = 1024;
+module_param_named(node_table_size, hsr_node_table_size, uint, 0644);
+MODULE_PARM_DESC(node_table_size,
+		 "Maximum number of learned entries in each HSR/PRP node table (0 = unlimited)");
+
 bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr)
 {
 	if (!hsr->redbox || !is_valid_ether_addr(hsr->macaddress_redbox))
@@ -189,6 +195,7 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 				     enum hsr_port_type rx_port)
 {
 	struct hsr_node *new_node, *node = NULL;
+	unsigned int node_count = 0;
 	unsigned long now;
 	size_t block_sz;
 	int i;
@@ -226,20 +233,31 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 	spin_lock_bh(&hsr->list_lock);
 	list_for_each_entry_rcu(node, node_db, mac_list,
 				lockdep_is_held(&hsr->list_lock)) {
+		node_count++;
 		if (ether_addr_equal(node->macaddress_A, addr))
-			goto out;
+			goto out_found;
 		if (ether_addr_equal(node->macaddress_B, addr))
-			goto out;
+			goto out_found;
 	}
+
+	if (hsr_node_table_size && node_count >= hsr_node_table_size)
+		goto out_drop;
 	list_add_tail_rcu(&new_node->mac_list, node_db);
 	spin_unlock_bh(&hsr->list_lock);
 	return new_node;
-out:
+out_found:
 	spin_unlock_bh(&hsr->list_lock);
+	xa_destroy(&new_node->seq_blocks);
 	kfree(new_node->block_buf);
-free:
 	kfree(new_node);
 	return node;
+out_drop:
+	spin_unlock_bh(&hsr->list_lock);
+	xa_destroy(&new_node->seq_blocks);
+	kfree(new_node->block_buf);
+free:
+	kfree(new_node);
+	return NULL;
 }
 
 void prp_update_san_info(struct hsr_node *node, bool is_sup)
-- 
2.53.0


