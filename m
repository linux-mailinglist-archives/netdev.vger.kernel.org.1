Return-Path: <netdev+bounces-269111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDUJJ+7WumkXcgIAu9opvQ
	(envelope-from <netdev+bounces-269111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:46:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 166B82BF8D3
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1113630E267D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964323A7850;
	Wed, 18 Mar 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9+w6dDr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36DC3F20EB
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851072; cv=none; b=ZsPJ2FgUEJpxNRxnqdIJoXwaLJA/Nl5jk+jCSlHhMDymRFFENj8oki5DiYm/PY9+9x6wdO1TqOzQf6hp97K4gdic5TW3Qf8TF4mx0AYLIESfcK0T5r86qtaBRTYTw4UDjGDwvJHyJsIvl7Dz2BxVhdpM60L37vDre9VL0mCc9Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851072; c=relaxed/simple;
	bh=6C4YOpc354nfZBWHSuQ9tbTzStWV7uDznRf3O0+yqpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZ5YI/aqj8tS4Dke7DXSP46lYT7yYrDdKYLIeCcOMA2NSY9WY+fdRZcF7HG9+Zwp6Ps/UBqFY/YaCWF3Fe7D8muzxvhq8yH87N/zWFj6UDeviLSc6SYEa3jbwkkWYwytDY6mJFq5jGHSWArIo9SqoRPaihwpGguSVy4V/QZzbWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9+w6dDr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso207255e9.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773851065; x=1774455865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BTDQkS5soYcggVEgfxDDpLcf2lsOsR+x97CoGga5L3I=;
        b=A9+w6dDr61TGB5LaUtIRTKEVYbkhLkwuG2+UecYGH4DiK5vEpuCyj59Vmb4AxpVzg8
         al1bbv+spyTgWeaw3ChSvHU/JXHgKNt0tKRewVBY4b17M81fytdn5tCO/3vFQci7jKEa
         tK1Z19abNQhP3avB7YT5ZZyT6BAnotrY4p2wsmbPdcxywC2fbFnQ69HOShefoW3KIvsC
         +DZrsxCi0aQNtW8NmgOaigiL0KOnfNXS/lRSfFk37eXsuQ4zl0d0cTPdJfXqTVpJ4YL1
         5igJbn5nhZjp7tf2sh8CszTwapSlmg8atiltLdJRIM3KbPNGzCqS2vZ23BYc6PNsegqm
         m03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851065; x=1774455865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTDQkS5soYcggVEgfxDDpLcf2lsOsR+x97CoGga5L3I=;
        b=MD/AbMqgcSf6Tlig4/C1Wr5kyELTqH6Bj7mLWyUmpggPSqvno+bfNZooZe9M0uxjuu
         bk9XHpMfQzuHXNLMfGA6eAX5YA4w1+0hvZRDDAp3cUflQDdEmY9QY6OgvAtE5B0n0Va1
         aUgusKFyGVwBh5QPqBSH4qdA434oGi4Z2If5F+76i3rNIwhjpspK/Q4vfNTKisGMmIBO
         UE2lT441q5a1OtZRufJksKJsZ3aAIeNixORc73M+qr6BPKZ16YliiFkC6E4lASOWfyRG
         ObPbvLvczoOJd95wfSvjUdYGh62EU9xDR0/QKDPHvM6Fx7g3BZ9VOnlaUM4QKu+C6ePk
         XTKg==
X-Gm-Message-State: AOJu0Yyd6IK2qN9hS5triYMcH/MuSV/BSZu7k3JObxW93mgFrOMGX1JJ
	5iL9gAXaYCqQaPrbXbs3Ivode+dJeFxrFwHYKo2EK9vjUgQioj48Sawq
X-Gm-Gg: ATEYQzwA8u3BniWTlQSmzJc6dET7wZMFWNpNtykeOeLdAILhKhHkF/ctNeVJlZ1/Uz8
	iiIWFiyd82wsLmAKzmxAdGXqtwPsQ4rb9s42nw5HQfz7Kll683iJZ4iH9ZG0NgTmYBItMeIvNWu
	ASySgt1KbA/69JEWgYdZ5PprHg6nv3XLAO94zSA2M/iZSPFtcodc2nRt9VivXes5qf2gdXWOaVj
	ySF1cRJzN2MRzclmMsjDkLkeggXuqRQv6TY2ImLpTh0Yxuy0bD9nKSlth0GZITo7XqDSosAJCbn
	VQbChPysEJQZCG0j/hfwex57crzPaHnDOdpLoCRnZYPCsB50Np2VmzSeqELsMAx0OKuLnSstzp+
	dm47Tvuj3hFhdnefKU3Uh7UtVSBlNKQpF8mx5tRYaBMPgF6hbkvCkCLbQcFBhAOchKeJ+NR4Ws6
	4GpqDYj9/RN5gBeR/cB48J0vVHC7+WS89FnW2OX/K0N6u3EOMfilyaJVFeBOA5KUYb5lFGEf/DA
	zZsYfRYv+cp
X-Received: by 2002:a05:600c:4e0d:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-486f4456f02mr63983395e9.17.1773851064495;
        Wed, 18 Mar 2026 09:24:24 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892244sm9738790f8f.22.2026.03.18.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:24:23 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] bpf: use RCU-safe iteration in dev_map_redirect_multi() SKB path
Date: Wed, 18 Mar 2026 16:24:20 +0000
Message-ID: <20260318162420.7684-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-269111-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.966];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 166B82BF8D3
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

Replace with hlist_for_each_entry_rcu(), matching the XDP-frame path
(dev_map_enqueue_multi) which already uses the correct macro for the
same hash iteration.

Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/bpf/devmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 3d619d01088e..c8d256405c29 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
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
+			hlist_for_each_entry_rcu(dst, head, index_hlist, lockdep_is_held(&dtab->index_lock)) {
 				if (is_ifindex_excluded(excluded_devices, num_excluded,
 							dst->dev->ifindex))
 					continue;
-- 
2.53.0


