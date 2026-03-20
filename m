Return-Path: <netdev+bounces-269817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA1UDMn2vGkt5AIAu9opvQ
	(envelope-from <netdev+bounces-269817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:27:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C50382D69A1
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE58A300BDBF
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A1135BDBC;
	Fri, 20 Mar 2026 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo8JvIkh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2198B2DC782
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991611; cv=none; b=ZHP/Tm33+SUZe+VsopWfFYGcUM3ycfwROqYvuEagAb464HxRAaphzqOH6esr7/X/4GZg9r/nDQbPuEUOCrlWcBYzSz2xt9KpbndfAEgmXPsLbV28X1QnLNooPmosj1itBM6rOY6UwvB2bWqaUKJ2iGV5zgfPscii1JZLLBY0yoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991611; c=relaxed/simple;
	bh=vMQdNvrRme6yVeAJXlE2gsl4gWcmXQsoRwYJ3tDkr/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSuWMBCW5/0238sUonhc88lHTjecHoJ4Cogc6NtxMoLNDrgbMEka1bNbo/fJfdJJVlmkG+5ewZDMBxRDzOJdN9jG5CEJ4J0palAr9uOWReE/EASy5whZLhV3g6swe6D6yqwpNqOFzLUOuXPEZ9AQJ9wkQf33PStAvXLeWI2jLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo8JvIkh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fb439299so11621855e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773991608; x=1774596408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3KJVSi9z2Jj/Hmyk1wzxgMI7Rqoa0UBGy/TFgOK0dk=;
        b=lo8JvIkh99/vtEmaRv0YbTHuIgkZXzP2yjuZfYhhyA8bQjWfIObyvcVgyOWT3e2BqS
         iFwoPn89scvSGd8fW3/1C6xb9i5XdwvraO40t3xYawzlrmm4aApfyoG4Jl+cJrJWgH08
         nFwp1JbvdLiGn8KZVQ6VSYH+tuQTHZGXyEaj+eQCbStSKkuMDS/ZFIUErKLOLkWM9St1
         2WwPjA4RzzlrTzJ1dnNLU6Zjdb4QuMF7crm3IwF1xY0UrOYfqRWuW7LsPhOtlkN/N5ry
         zNTLTM3nMNGojr5044DICXF0xu+yMAkHU3sjoJ0ib24j1MoYK/tYbR10JJP2GSu0vWiG
         PPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773991608; x=1774596408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3KJVSi9z2Jj/Hmyk1wzxgMI7Rqoa0UBGy/TFgOK0dk=;
        b=q7LqXmzQ8piLumPuJSYz2FB/bSHCGm+G9qSNlc7Itv51+bJb4XHhXNwkVye8yBR7xA
         VKCzFRZZJv+2X9GM0yPjXTmkY6CkVokyVhL7gTYlGkf4282JfFPCEHnMl6EPkm+94Ezg
         eomhF3h0xUr/fVecNYlTd7S78OtVJxPsYFERzpJHQzMdbLGarKuaARVUv88RTl9uazHI
         nglqc9uY+AoXP1NeJ9CwPQsSjYXTRJNpN+fAGQCWo40Fc9Rly9zMRVB7NFQp1WLgst8H
         FifaF/u64bc2BANhMb9OPrLm2GVCI2iPuwQBITOqYAuaigX4zlYR4hWB4lr06Na4sl4v
         VzTQ==
X-Gm-Message-State: AOJu0YyBrKOTApmyLcOjN7nH1MA12PHLgW4XsuHU86xNx2Wrp7DLjr3e
	jX+yXn9JTO1v5pfgn//MCJL7iwkyh9ST3ZHGWUqCNm+urX+++yWR2Tu4
X-Gm-Gg: ATEYQzyhSPNLNU7Y6TmldN8BkOFwCIK/smG6fjBF1QDCmJKxJk1xDTkAS5koZ6MsMjl
	SsD3uL3MEGAXXkOf8Cy3uZl4bANyTNI3vmUn+qSeaSNLZUaIKkatDHmjz1YjuN8w7bM0dwPllaW
	+3QT1aKKZV4B4+3y+d+/oJfbcFSZxZF2eHv+rN7zx7F55GHQ7ymjplO9JkXKIE37ED+BXpbotne
	BsqKFSEwg1ImoXL2+GDZMIO/h1z4ZMc1hmJHRy8YEakiMBfua7V1UUNbs4aD7AVkqdh0Ybzoi/3
	nUdeKGxyP3MRuwZPBAEXPkdEHtUa67ig7S5OvfT15bsatIanrh5sKHwfo6WYXPd9ihGLAlxeuh2
	tYxghzqHnX63JMYEAuygH+MG1VEQN25m8eGtNtPpmA5tSRkUKVmNJGGjLvpkgh5fBa0OvKN/Iz+
	0qQnncld9QlZvRkc/tqEqba0c38e67OfDh3Aqt0PV/d+GUD0UmOHBAF8MHH9wmYWfi7fbWiTq0W
	1mpLfNkMs9x
X-Received: by 2002:a05:600c:698e:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-486fee1af00mr24751375e9.24.1773991608143;
        Fri, 20 Mar 2026 00:26:48 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe879d37sm14871185e9.1.2026.03.20.00.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 00:26:47 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	bpf <bpf@vger.kernel.org>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH bpf-next] bpf: use RCU-safe iteration in dev_map_redirect_multi() SKB path
Date: Fri, 20 Mar 2026 07:26:45 +0000
Message-ID: <20260320072645.16731-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-269817-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.934];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C50382D69A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The DEVMAP_HASH branch in dev_map_redirect_multi() uses
hlist_for_each_entry_safe() to iterate hash buckets, but this function
runs under RCU protection (called from xdp_do_generic_redirect_map()
in softirq context). Concurrent writers (__dev_map_hash_update_elem,
dev_map_hash_delete_elem) modify the list using RCU primitives
(hlist_add_head_rcu, hlist_del_rcu).

hlist_for_each_entry_safe() performs plain pointer dereferences without
rcu_dereference(), missing the acquire barrier needed to pair with
writers' rcu_assign_pointer(). On weakly-ordered architectures (ARM64,
POWER), a reader can observe a partially-constructed node. It also
defeats CONFIG_PROVE_RCU lockdep validation and KCSAN data-race
detection.

Replace with hlist_for_each_entry_rcu() using rcu_read_lock_bh_held()
as the lockdep condition, consistent with the rcu_dereference_check()
used in the DEVMAP (non-hash) branch of the same functions. Also fix
the same incorrect lockdep_is_held(&dtab->index_lock) condition in
dev_map_enqueue_multi(), where the lock is not held either.

Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/bpf/devmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 3d619d01088e..cc0a43ebab6b 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -665,7 +665,7 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 		for (i = 0; i < dtab->n_buckets; i++) {
 			head = dev_map_index_hash(dtab, i);
 			hlist_for_each_entry_rcu(dst, head, index_hlist,
-						 lockdep_is_held(&dtab->index_lock)) {
+						rcu_read_lock_bh_held()) {
 				if (!is_valid_dst(dst, xdpf))
 					continue;
 
@@ -747,7 +747,6 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 	struct bpf_dtab_netdev *dst, *last_dst = NULL;
 	int excluded_devices[1+MAX_NEST_DEV];
 	struct hlist_head *head;
-	struct hlist_node *next;
 	int num_excluded = 0;
 	unsigned int i;
 	int err;
@@ -787,7 +786,7 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 	} else { /* BPF_MAP_TYPE_DEVMAP_HASH */
 		for (i = 0; i < dtab->n_buckets; i++) {
 			head = dev_map_index_hash(dtab, i);
-			hlist_for_each_entry_safe(dst, next, head, index_hlist) {
+			hlist_for_each_entry_rcu(dst, head, index_hlist, rcu_read_lock_bh_held()) {
 				if (is_ifindex_excluded(excluded_devices, num_excluded,
 							dst->dev->ifindex))
 					continue;
-- 
2.53.0


