Return-Path: <netdev+bounces-161457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DBAA2192F
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 09:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5627A3A4CC8
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 08:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72752198A1A;
	Wed, 29 Jan 2025 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOUwnCTT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDF18C910;
	Wed, 29 Jan 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738140218; cv=none; b=NoGXTcbV1N6F1qV2iiynZIwMWw/VYTK9nP4hbBB/5iUnyluR+4PJdRlasvBR3kztVJMpX1Xn9ITuetk7IaQ2UUzx39SPKIiorK16I4/lAMXNaeqKrkCZCrVvVjZYyqqJeO/hgxho/ts6D0k4nD6anBxfSUbvmz1Q9PG6F5SZ3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738140218; c=relaxed/simple;
	bh=rKKSEPJpsa21Liaz7riCVFcsY9pSVaiUZYgzorMKlhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtXKZHn0meNU1NZvERp/wXcwGMzIB/XJzyfWcJ4yO4dCrY/lxayK2cVSHz+Q0RMu91DGle1ROwWbaEvj+1u0pXSJRBdq9V2GtcpmnGoftmtSL4TIoR8ow74b5fpsSUiQ1N3YxIyGUwXWgOIszP75xI+xFYUHKisNFjj1iEOQL4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOUwnCTT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so3533641f8f.0;
        Wed, 29 Jan 2025 00:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738140214; x=1738745014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9UTab+BuGhY0qFgHUczFebQwnU4DoDWvLKanmKSHZA=;
        b=eOUwnCTTKFGUDmiljaOV+7do3JHeYibbHSAIRcGljiJf6fea6Ra0sKS1gpGn7naWMO
         mc6hB3Bq1/4adztb0lAhAiGQST7wTEUfMWUJ2JXMqhrQ3mb1OKCxQKc6cglPA1wtWByN
         4mgkdkxuDDRuVgioZvMKFnYtbR1FrBi4NlkBfVtXIJpt7d6ULkGjqHnWbOH1pOND+83M
         FGnVdVKdBQoOn32Oc4B1eTY3Rb+D61mjS8hLMlr5a7/PJDtwJPp7AHENi3FTUDzCYMH1
         vwsMLz5YV3ijdkhdEcaCVy5xKOD9fFxN+qBSz3hvy4UyuFbHLo+a75uuGkj0fOV1Ibhj
         y2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738140214; x=1738745014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9UTab+BuGhY0qFgHUczFebQwnU4DoDWvLKanmKSHZA=;
        b=OpXhWGYHwJWTJnbSKWu78d58CQK3iEJoa77bfIi9JCLgvyPDqLcCVlW5rAqETBxheQ
         yV75VnA3sQnsKe7biH24yWC9PMkICZ+B3ooEbZaWzFMBZQLCn37Z6+haZo43YoQ70UDB
         MZfEP4aQZ/KDyKI4ifoQjHdy8t0EKZeQxtQqLB9dayWK05kcFq2O91zXjGNtgV3sFg5H
         7XuNsyAmoUHze6hx4c0chTMDpbFbls0MEONYjamcrxx4dIP0Quo3i1qOxjDtiR9SaXIN
         C5QDcg90GlTH0ixcPaIrplmuguekkQttgaCaR0KNMNFmdnf1HsJGvuHycClkV+jyF4ED
         qUDg==
X-Gm-Message-State: AOJu0YxvW4xJO14CTkEpw2RnGIdrVtDDya45Feepxpu6aXrCjN3iAjbC
	7PVRrjpcZ6AoN40+sqkssmPe8OslgQtGPx3PcWXDkeEQ+4BAIEmkDpwCNfqQDXU=
X-Gm-Gg: ASbGncv3dGGhcEoprP4XLBp4WAzdME4ZnGATkZDoK2Zg8wWLqaGWV5oNyY/cj64bTf5
	A3gywAt78FK9cnvPN/4AJWBRYjvw1Pr+FE3oAC+LZ0lzsm81v/f7uI1/oqpPoYHk/SpL55w6WzW
	u30xxdNw2ItjO6Q8EZ1q7NIdzV6065mGJKbwxjc3f0K+n/lxIIw/AAc7rANTaMqbzBzYhOEkj6u
	ZON6rhMU3sWjsBuN0S5ySm0I/9YHXn+2F6k8GRgfCJGYDklJd9zubRZfE8TJXZMv25Nn1YXjW9O
	nLq+zkbdla89psyQ3ku8NQfajI0=
X-Google-Smtp-Source: AGHT+IGQglAR2f069Sjze69GOgYqyApizJnyVd9JPRHjyS8oxRn9IsJXlYczPHm7n+qUdDv0sff5wg==
X-Received: by 2002:a5d:560b:0:b0:38a:418e:21c7 with SMTP id ffacd0b85a97d-38c520ba470mr1202909f8f.53.1738140214095;
        Wed, 29 Jan 2025 00:43:34 -0800 (PST)
Received: from localhost.localdomain ([37.41.15.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d6edsm16101563f8f.40.2025.01.29.00.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 00:43:33 -0800 (PST)
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
Subject: [PATCH v2] net: ipmr: Fix out-of-bounds access in mr_mfc_uses_dev()
Date: Wed, 29 Jan 2025 12:43:10 +0400
Message-ID: <20250129084310.54397-1-asharji1828@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129082601.51019-1-asharji1828@gmail.com>
References: <20250129082601.51019-1-asharji1828@gmail.com>
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


