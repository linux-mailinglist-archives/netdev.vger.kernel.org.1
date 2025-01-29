Return-Path: <netdev+bounces-161458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3D1A21967
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 09:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271301885FA0
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEDB1A2380;
	Wed, 29 Jan 2025 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5x4s7Qc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723452D627;
	Wed, 29 Jan 2025 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738140645; cv=none; b=CxC7k6Ulbu+RiaYLNWgJTnaeQc36NhRKuLSYXVjaNrImFCq8ijxeAGwNUmRT94ZKylfAe3cZQfEaLNNkNd0PMCYfcZI47fYUwMCqJmfziH8FrOV9wZOkeJ33BfcfZNa++uH1VA+1nQI60/2QBd/DZFt27gXq/DPBJwJYHPtwDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738140645; c=relaxed/simple;
	bh=rKKSEPJpsa21Liaz7riCVFcsY9pSVaiUZYgzorMKlhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRTPCp0U7jcQh5biE4u6DnYX7xKG+zFaooaPILjPHcs03JXEsy1hVwovhynoV2kTo3CMKF75R+CQtnx+9tyHTcFeJIhPl/JHs4R9quRdxa1lNl6P0TlYnjfP5f5/pSJpbAkoC2WUeAfJude+sVmvYHd9Pu1yOy6DEtOa2/NS6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5x4s7Qc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385eed29d17so3404621f8f.0;
        Wed, 29 Jan 2025 00:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738140641; x=1738745441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9UTab+BuGhY0qFgHUczFebQwnU4DoDWvLKanmKSHZA=;
        b=e5x4s7Qcq7myjidqRdBmDH84tbEohAx6pMT8bsF7a9atd8mvTJqqHUBLgOt1rLUgJm
         eyDggQ7BpeH1IZM9Wg0R3rLGOiUnfMjAmjrGpoF1l+p9rmT976Z8/1T71OrW5N8156T4
         /MRRWLSFsbFWDQfwuWsJeNSPUAhjB3i0rrfaajbFZiTUtZCdvBHLntkrvJwNyPMhTgES
         rqYVFROJO1CWsFspnv30UukOrHSf7WQaxL20U+5W3BMgg1CwQZPrBpQON3X6VClg97nm
         sV9tE5dvHDbVZWon7CZeNisBZua606qq1QLnlVCzvytPU5xdFa0Su/ejGIwCuAGbddbQ
         2h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738140641; x=1738745441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9UTab+BuGhY0qFgHUczFebQwnU4DoDWvLKanmKSHZA=;
        b=NPaDe0UMJnoyxAAAaVSiy7H3bvepjtvoDSuQVcwJaHlXj/abuBJ81X1T8rEtsV2pRS
         kPkYb7xWQzJc6P3+eVLQ2TnJycWRFjfZ6BejIQm8qDK3S/4g29rB093UlaEtPqsfT770
         hSCayabYI6NXoPugL7v4wCWriHCJEs2qmShNgK7FvoWNU8/RzCrlKqyvh9YKYM7w6egT
         /nyVqgTL8CPj2UDJ8DfagixUm+oRbsQHhVe9UCAIACNXjKxPqe8v5z0CmWPv7tYTfK0o
         fBS3QKyScFIIqN9NNSPU+7OOc2NEfiwUZ2Mmoj8Sm4mxD3GUiBvV7+ug/XU+2Y299fcz
         ZE/A==
X-Gm-Message-State: AOJu0Yy9Fqo6PD6D1BSB7/l98Z9yWgtskid4MFZ+S+cECoDxydY2C3CY
	l2N8KXHyCefpZrs5CMkbC1IO0dgftxOoH2HScEJ2zWUzRRnJf8Mer6uwrAsDjkI=
X-Gm-Gg: ASbGnct4fysj7+KnDGonpFtFYzFrjYAbJWBb1d+sGGyWjuFTGT/71ZLkoND0DWzViDW
	e2G1vo9zKaBx7oYpjdswzT98ct7kCu5boNOMRiHgWhttHDv6LTgSRxPc68lArBMIzTJt+cdpb1d
	g+jiGDoLWQVrUZ0kRPxEf3j9teNh0CZh5AcXf0NM6DNYCwrbnpppdysftngCeO6mi0kTCaxG1ZJ
	8y1av+JYiLZIbCUjMlqQ9FCJWSng24xVtVJvwzlpiL3E1QgX2pp8FLu54u4DUHcraUbegKXaiYP
	99MniBMiiB1VUTbuTE3XayMLD6RPKskUm5qs0A==
X-Google-Smtp-Source: AGHT+IEmYAVXvvwB5M8D9W+NT1ten/cd2FNxp3/3IOffbYOa6rnTKGD3guhYWdeWxMu5p1a46QTnoQ==
X-Received: by 2002:a5d:6110:0:b0:385:f220:f788 with SMTP id ffacd0b85a97d-38c520b6a59mr1687268f8f.48.1738140640476;
        Wed, 29 Jan 2025 00:50:40 -0800 (PST)
Received: from localhost.localdomain ([37.41.15.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a18918dsm16653852f8f.57.2025.01.29.00.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 00:50:40 -0800 (PST)
From: Abdullah <asharji1828@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	Abdullah <asharji1828@gmail.com>,
	syzbot+5cfae50c0e5f2c500013@syzkaller.appspotmail.com
Subject: [PATCH v3] net: ipmr: Fix out-of-bounds access i mr_mfc_uses_dev()
Date: Wed, 29 Jan 2025 12:50:17 +0400
Message-ID: <20250129085017.55991-1-asharji1828@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <678fe2d1.050a0220.15cac.00b3.GAE@google.com>
References: <678fe2d1.050a0220.15cac.00b3.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue was reported by Syzbot as an out-of-bounds read:
UBSAN: array-index-out-of-bounds in net/ipv4/ipmr_base.c:289:10
Index -772737152 is out of range for type 'const struct vif_device[32]'

The problem occurs when the minvif/maxvif values in the mr_mfc struct
become invalid (possibly due to memory corruption or uninitialized values).
This patch fixes the issue by ensuring proper boundary checks and rcu_read
locking before accessing vif_table[] in mr_mfc_uses_dev().

Fixes: <COMMIT_HASH>
Reported-by: syzbot+5cfae50c0e5f2c500013@syzkaller.appspotmail.com
Signed-off-by: Abdullah <asharji1828@gmail.com>
---
 net/ipv4/ipmr_base.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 03b6eee407a2..7c38d0cf41fc 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -280,9 +280,31 @@ static bool mr_mfc_uses_dev(const struct mr_table *mrt,
 			    const struct mr_mfc *c,
 			    const struct net_device *dev)
 {
+	/**
+	* Helper function that checks if *dev is part of the OIL (Outgoing Interfaces List).
+	* @mrt: Is the multi-routing table.
+	* @c: Is the Multicast Forwarding Cache.
+	* @dev: The net device being checked.
+	*
+	* vif_dev: Pointer to the net device's struct.
+	* vif: Pointer to the actual device.
+	*
+	* OIL is a subset of mrt->vif_table[].
+	* minvif: Start index of OIL in vif_table[].
+	* maxvif: End index of OIL in vif_table[].
+	*
+	* Returns:
+	* - true if `dev` is part of the OIL.
+	* - false otherwise.
+	*/
+
 	int ct;
+	
+	int minvif = c->mfc_un.res.minvif, maxvif = c->mfc_un.res.maxvif;
+	if (minvif < 0 || maxvif > 32)
+		return false;
 
-	for (ct = c->mfc_un.res.minvif; ct < c->mfc_un.res.maxvif; ct++) {
+	for (ct = minvif; ct < maxvif; ct++) {
 		const struct net_device *vif_dev;
 		const struct vif_device *vif;
 
@@ -309,7 +331,8 @@ int mr_table_dump(struct mr_table *mrt, struct sk_buff *skb,
 
 	if (filter->filter_set)
 		flags |= NLM_F_DUMP_FILTERED;
-
+	
+	rcu_read_lock();
 	list_for_each_entry_rcu(mfc, &mrt->mfc_cache_list, list,
 				lockdep_rtnl_is_held()) {
 		if (e < s_e)
@@ -325,7 +348,8 @@ int mr_table_dump(struct mr_table *mrt, struct sk_buff *skb,
 next_entry:
 		e++;
 	}
-
+	rcu_read_unlock();
+	
 	spin_lock_bh(lock);
 	list_for_each_entry(mfc, &mrt->mfc_unres_queue, list) {
 		if (e < s_e)
-- 
2.43.0


