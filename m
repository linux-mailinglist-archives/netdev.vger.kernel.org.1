Return-Path: <netdev+bounces-289620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFWqHKPdDGphpAUAu9opvQ
	(envelope-from <netdev+bounces-289620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:01:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7BA585616
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06D7B303DABB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63BE3EC2D0;
	Tue, 19 May 2026 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wU9E1OOV"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433453DF00B
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227949; cv=none; b=maoZXEct/gt2y+HBYr7NZwTJ1lUjiAtHBhbgho123Iw5SujOUH/0/lEkcqNfIPpL2ENPFSdbY+I7dtYFBpnvQVMKOFbFJdWxiOd8Wosn/3oLn8jdoieSZS6hClzznQYpGEhwBf8gikYgkGustQL7BQ4CroLutyy7wdRN86stNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227949; c=relaxed/simple;
	bh=diuE7PQ8Pon9vMXdOPJIS446mlbcUV4fCnM51klAihE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKtqoYkJkPaPX+feU+AfMWiY9IO2ZY+SKVz+sCVTBzMoeeU7OA/ALhtlU1e0YkwlDYsnRa18wm2a3DmYKDCCsGAjyEEPskatR2HJp54tfY61eSmr3euwd/WpdKR0QJ/9GpWCDPwC+tAAMcLScl1JEPzG2qKty3O03DknBMgx+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wU9E1OOV; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779227946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+XTc5KfpwasDw2bVqQ0ao7p4cs5JHtFCbk2g1BNKx4=;
	b=wU9E1OOVibgOPnB7VTXwdXftkcnRedZ3P232U2wIayqqFxkeJgzPNaiwuerSQWo2ITmUoV
	NKAnGIVPaa8buPkv95P966Nlk+m1sfq8xv5JMBf0tKnqU4fPV8tLJFmvlkiBSPLUfxVAUI
	zmjp5JL4FY8N00/kvjfCeKa1Q1N6lfI=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Shakeel Butt ' <shakeel.butt@linux.dev>,
	'Roman Gushchin ' <roman.gushchin@linux.dev>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH bpf-next 01/12] bpf: Remove __rcu tagging in st_link->map
Date: Tue, 19 May 2026 14:58:08 -0700
Message-ID: <20260519215841.2984970-2-martin.lau@linux.dev>
In-Reply-To: <20260519215841.2984970-1-martin.lau@linux.dev>
References: <20260519215841.2984970-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289620-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: BC7BA585616
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Martin KaFai Lau <martin.lau@kernel.org>

st_link->map is always written under update_mutex. The paths that read
st_link->map with rcu_read_lock() are not in the fast path, so they can
simply take update_mutex instead. Remove the __rcu annotation and replace
all RCU accessors with direct pointer reads under update_mutex. Use
READ_ONCE() in bpf_struct_ops_map_link_poll() which reads the pointer
without holding update_mutex.

It is a simplification change.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_struct_ops.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 521cb9d7e8c7..08791180d71d 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -57,7 +57,7 @@ struct bpf_struct_ops_map {
 
 struct bpf_struct_ops_link {
 	struct bpf_link link;
-	struct bpf_map __rcu *map;
+	struct bpf_map *map;
 	wait_queue_head_t wait_hup;
 };
 
@@ -1220,8 +1220,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 	struct bpf_struct_ops_map *st_map;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
-	st_map = (struct bpf_struct_ops_map *)
-		rcu_dereference_protected(st_link->map, true);
+	st_map = (struct bpf_struct_ops_map *)st_link->map;
 	if (st_map) {
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 		bpf_map_put(&st_map->map);
@@ -1236,11 +1235,11 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
 	struct bpf_map *map;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
-	rcu_read_lock();
-	map = rcu_dereference(st_link->map);
+	mutex_lock(&update_mutex);
+	map = st_link->map;
 	if (map)
 		seq_printf(seq, "map_id:\t%d\n", map->id);
-	rcu_read_unlock();
+	mutex_unlock(&update_mutex);
 }
 
 static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
@@ -1250,11 +1249,11 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
 	struct bpf_map *map;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
-	rcu_read_lock();
-	map = rcu_dereference(st_link->map);
+	mutex_lock(&update_mutex);
+	map = st_link->map;
 	if (map)
 		info->struct_ops.map_id = map->id;
-	rcu_read_unlock();
+	mutex_unlock(&update_mutex);
 	return 0;
 }
 
@@ -1277,7 +1276,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 
 	mutex_lock(&update_mutex);
 
-	old_map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	old_map = st_link->map;
 	if (!old_map) {
 		err = -ENOLINK;
 		goto err_out;
@@ -1299,7 +1298,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		goto err_out;
 
 	bpf_map_inc(new_map);
-	rcu_assign_pointer(st_link->map, new_map);
+	WRITE_ONCE(st_link->map, new_map);
 	bpf_map_put(old_map);
 
 err_out:
@@ -1316,7 +1315,7 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 
 	mutex_lock(&update_mutex);
 
-	map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	map = st_link->map;
 	if (!map) {
 		mutex_unlock(&update_mutex);
 		return 0;
@@ -1325,7 +1324,7 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 
 	st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 
-	RCU_INIT_POINTER(st_link->map, NULL);
+	WRITE_ONCE(st_link->map, NULL);
 	/* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
 	 * bpf_map_inc() in bpf_struct_ops_map_link_update().
 	 */
@@ -1345,7 +1344,7 @@ static __poll_t bpf_struct_ops_map_link_poll(struct file *file,
 
 	poll_wait(file, &st_link->wait_hup, pts);
 
-	return rcu_access_pointer(st_link->map) ? 0 : EPOLLHUP;
+	return READ_ONCE(st_link->map) ? 0 : EPOLLHUP;
 }
 
 static const struct bpf_link_ops bpf_struct_ops_map_lops = {
@@ -1401,7 +1400,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 		link = NULL;
 		goto err_out;
 	}
-	RCU_INIT_POINTER(link->map, map);
+	link->map = map;
 	mutex_unlock(&update_mutex);
 
 	return bpf_link_settle(&link_primer);
-- 
2.53.0-Meta


