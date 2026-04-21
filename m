Return-Path: <netdev+bounces-280186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMYMMgCj52nw+QEAu9opvQ
	(envelope-from <netdev+bounces-280186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:17:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2934B43D39D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0294F30421DD
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52562218EB1;
	Tue, 21 Apr 2026 16:09:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9A71E2614
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787795; cv=none; b=T1HBJWXRSO3H+U26zpFXlDbaLDpwt4kTG8U/eQ1jzleEl2G8zuzuHO/T8sW9rSKux9RyQxcqO3uFpXDuk9MdmNG5ca7TSpijg1zcjTHiAWvPZ5lcBjIyrWMb22PyVOCa/QBNot8oDSgzvujIpV4FeVrBIMbahYDZwLilSUHTsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787795; c=relaxed/simple;
	bh=OSnuaCIIpwIgyHOrVk2/OtdRAqQ0f0tuJ8fyC/1QgA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBX3/gkYyf3ls4Mu41yP1TgbTNoebcidqMOuzIZFdUkG5LRxLu5Jj0uwHXvLHjpvIflehd5EgmbPC3wf96E3ZVTaks+Hgyf/hjD46wb57qpYYtsPIxPAbicEst0cPEej/WEViOJepvOk8Cqb5DPCeO+RUo1TwUmR5NFoj1nDQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAC3MAE7oedp+A_ZAA--.52811S2;
	Wed, 22 Apr 2026 00:09:32 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sbrivio@redhat.com,
	vladbu@mellanox.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	kanolyc@gmail.com,
	z1652074432@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2 1/1] net/sched: cls_flower: avoid stale mask references after delete
Date: Wed, 22 Apr 2026 00:03:02 +0800
Message-ID: <20260421160303.1919562-1-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAC3MAE7oedp+A_ZAA--.52811S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4ktryfKF4UuF15Ar1fZwb_yoWrGw1kpF
	ZrG34UJrWDXF15W3ZIy3yj9wn0kas7AFy5WF1rW395tr97ta9YkFykZ3y29Fn8Kr4UWryS
	vF4qyr1rZ3WkCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi_HU3UUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQAECWnnOeEJTwAAsc
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-280186-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mellanox.com,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2934B43D39D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuhang Zheng <z1652074432@gmail.com>

cls_flower keeps filter and mask state separately. After a filter is
removed or replaced, some paths can still need the mask data associated
with that filter.

Cache the mask key and dissector in struct cls_fl_filter when the mask
is assigned, and use the cached copies in dump and offload paths. This
avoids depending on the external mask object's lifetime after delete or
replace.

Fixes: 92149190067d ("net: sched: flower: set unlocked flag for flower proto ops")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Yucheng Lu <kanolyc@gmail.com>
Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---

changes in v2:
- target the net tree instead of nf
- fix the Fixes tag to the first triggerable introduction
- correct the Yuan Tan Reported-by address and add the forwarder sign-off
- v1 Link: https://lore.kernel.org/all/0fdcae6ac3e07afbbd43958f6b42e2ed6281e3d2.1773559972.git.z1652074432@gmail.com

 net/sched/cls_flower.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 099ff6a3e1f5..c1f10b4ec748 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -124,8 +124,10 @@ struct cls_fl_head {
 
 struct cls_fl_filter {
 	struct fl_flow_mask *mask;
+	struct flow_dissector mask_dissector;
 	struct rhash_head ht_node;
 	struct fl_flow_key mkey;
+	struct fl_flow_key mask_key;
 	struct tcf_exts exts;
 	struct tcf_result res;
 	struct fl_flow_key key;
@@ -445,6 +447,12 @@ static void fl_destroy_filter_work(struct work_struct *work)
 	__fl_destroy_filter(f);
 }
 
+static void fl_filter_copy_mask(struct cls_fl_filter *f)
+{
+	f->mask_key = f->mask->key;
+	f->mask_dissector = f->mask->dissector;
+}
+
 static void fl_hw_destroy_filter(struct tcf_proto *tp, struct cls_fl_filter *f,
 				 bool rtnl_held, struct netlink_ext_ack *extack)
 {
@@ -476,8 +484,8 @@ static int fl_hw_replace_filter(struct tcf_proto *tp,
 	tc_cls_common_offload_init(&cls_flower.common, tp, f->flags, extack);
 	cls_flower.command = FLOW_CLS_REPLACE;
 	cls_flower.cookie = (unsigned long) f;
-	cls_flower.rule->match.dissector = &f->mask->dissector;
-	cls_flower.rule->match.mask = &f->mask->key;
+	cls_flower.rule->match.dissector = &f->mask_dissector;
+	cls_flower.rule->match.mask = &f->mask_key;
 	cls_flower.rule->match.key = &f->mkey;
 	cls_flower.classid = f->res.classid;
 
@@ -2489,6 +2497,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	err = fl_check_assign_mask(head, fnew, fold, mask);
 	if (err)
 		goto unbind_filter;
+	fl_filter_copy_mask(fnew);
 
 	err = fl_ht_insert_unique(fnew, fold, &in_ht);
 	if (err)
@@ -2705,8 +2714,8 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
 		cls_flower.command = add ?
 			FLOW_CLS_REPLACE : FLOW_CLS_DESTROY;
 		cls_flower.cookie = (unsigned long)f;
-		cls_flower.rule->match.dissector = &f->mask->dissector;
-		cls_flower.rule->match.mask = &f->mask->key;
+		cls_flower.rule->match.dissector = &f->mask_dissector;
+		cls_flower.rule->match.mask = &f->mask_key;
 		cls_flower.rule->match.key = &f->mkey;
 
 		err = tc_setup_offload_action(&cls_flower.rule->action, &f->exts,
@@ -3709,7 +3718,7 @@ static int fl_dump(struct net *net, struct tcf_proto *tp, void *fh,
 		goto nla_put_failure_locked;
 
 	key = &f->key;
-	mask = &f->mask->key;
+	mask = &f->mask_key;
 	skip_hw = tc_skip_hw(f->flags);
 
 	if (fl_dump_key(skb, net, key, mask))
-- 
2.43.0


