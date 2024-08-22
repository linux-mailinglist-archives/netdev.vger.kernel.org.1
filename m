Return-Path: <netdev+bounces-121127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 211A895BE09
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 20:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEAE1F25C98
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 18:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846951CFEA0;
	Thu, 22 Aug 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp6t6cTU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443A1CF286;
	Thu, 22 Aug 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350301; cv=none; b=q3tssSQmVjmcNPU6TSxEnyxgWkBwo7hj0ceCynWiCmWFImJrde835wD4/msDMcDA5C+FZm7kf4UMc+r+aFrgQfq2OxwECAd3jHJG24Rt2EZQPXYcXkOth3ZdzEea1sf4FM/2kL+x9xiAhcxQMf1zX4unhrTwgWqTjYQva/QC1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350301; c=relaxed/simple;
	bh=A05D2Gc05qT4V1eccDLiffdblAb+LV32m8sUgyon084=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KJpx5F/ceEqV8Q3pEpAqlXeVjhTNp2uZklinT4HbJC6eIYD7/ATuMTPeNz35xCzEEYpzoCMYs5HkOgoyvwVoYKJvnQmh25TqNte1XKRL6BfswMvM50Mf7TUJUx/h+M+XqiHR3zCh2igTUTN0J122DGzKCc+y+0n9cvBgYwXr680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp6t6cTU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20223b5c1c0so10381545ad.2;
        Thu, 22 Aug 2024 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724350299; x=1724955099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNG67etRpmbFoR543m1YIG0LZE60EP8XIWtrKthQBgo=;
        b=jp6t6cTUWDBwJjWLHy7RH41/ia/5k8KcxOk9el4fLVUPz9WKQE0p1Vi2AUv/UShwUc
         iq/EG/yQIU0XCtBuQbOSLcMdHboDq+3xgLH9kKcz4PVuYB+JCgbvSOsSP7PUPFP5EC+L
         q1peqak/zqVRT6GD0+7kLHF8HBeEszd3+1NRb2tVR0g0rwL9Lnu53D6womT5ipfrH/B5
         SokhKdDCdJis8PRw6mk3WqA0UMXQAwautFT0y4gI48tGF84MUc0e6cA0vZ7R8+PqoDk6
         zBgoxnho3YEu/0dG0IDPs5RJMzJ2oQ8xlDA/IEHdEaMrCw65JYuVrdWO5HCg/X5oL5tx
         8Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724350299; x=1724955099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNG67etRpmbFoR543m1YIG0LZE60EP8XIWtrKthQBgo=;
        b=jVOxkWKg9ShH/+9F6yWoJErrvJ9if+2kI+TuCTkPg2ahJwcy2GGdl9ioqRSnr4uQlX
         0GpYMlW77S15U0TfatTGez3q5SfUHTsxR5Mn5DKr4zXwY1yq/wZhrXa+0VnMOCx6jiB5
         QNX7OqgO4S1sGFNLrl31jEsvrLq5hmgwR9u56Q0ARPe180G1vyLK5qeVqWKhWZyCtUi+
         TThpdMh1kPvPSdM407PK5fBxlIcVjKw4GKpVwGgVEVx7IIR8Dg8oss7Agb0HWCVkWXBh
         wCdugwv9D6gfS/9qGI+USqVp5crbWf5FbTPqByUvqP2OZ0woufSANSYMTa85s5/xLTRI
         tX2g==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZXMZg6tErNwtrO2bCqoAREYd4D/nXt/FW9NTM5CM3+3dGqLz6vFkAYGFl8k/erEpWp+KXayP/Ny20FA=@vger.kernel.org, AJvYcCVFyXQGlCxYrEBgDnAtPpXPZU+K/j+i6A/W02i3uW1wk8D+cV0KQ115zN9k4Dymk4PBC19mEMR9@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAf1MkaJEcWrgbTwtX4MoX2U7VaHGEWDIqmSjWLlvQ8uRpTdL
	iBdvgRjRsJGJlUOj/740O6aQcZ2uNjQ57pTDI4cWBSFvhQV7Dm3m
X-Google-Smtp-Source: AGHT+IEsv5bpxwIHa8vqXEhWiIUlfLxE0wILbUZew8Lm3s6hLcp/D+7eE72ll9aRakt9he4VallMUg==
X-Received: by 2002:a17:902:f98b:b0:1fd:9105:7dd3 with SMTP id d9443c01a7336-203681d8e0emr53955695ad.64.1724350299146;
        Thu, 22 Aug 2024 11:11:39 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385580831sm15450765ad.76.2024.08.22.11.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:11:38 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: wei.liu@kernel.org,
	paul@xen.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	madhuparnabhowmik04@gmail.com,
	xen-devel@lists.xenproject.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net] net/xen-netback: prevent UAF in xenvif_flush_hash()
Date: Fri, 23 Aug 2024 03:11:09 +0900
Message-Id: <20240822181109.2577354-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the list_for_each_entry_rcu iteration call of xenvif_flush_hash, 
kfree_rcu does not exist inside the rcu read critical section, so if 
kfree_rcu is called when the rcu grace period ends during the iteration, 
UAF occurs when accessing head->next after the entry becomes free.

Therefore, to solve this, you need to change it to list_for_each_entry_safe.

Fixes: f3265971ded9 ("net: xen-netback: hash.c: Use built-in RCU list checking")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/xen-netback/hash.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/xen-netback/hash.c b/drivers/net/xen-netback/hash.c
index ff96f22648ef..45ddce35f6d2 100644
--- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -95,7 +95,7 @@ static u32 xenvif_new_hash(struct xenvif *vif, const u8 *data,
 
 static void xenvif_flush_hash(struct xenvif *vif)
 {
-	struct xenvif_hash_cache_entry *entry;
+	struct xenvif_hash_cache_entry *entry, *n;
 	unsigned long flags;
 
 	if (xenvif_hash_cache_size == 0)
@@ -103,8 +103,7 @@ static void xenvif_flush_hash(struct xenvif *vif)
 
 	spin_lock_irqsave(&vif->hash.cache.lock, flags);
 
-	list_for_each_entry_rcu(entry, &vif->hash.cache.list, link,
-				lockdep_is_held(&vif->hash.cache.lock)) {
+	list_for_each_entry_safe(entry, n, &vif->hash.cache.list, link) {
 		list_del_rcu(&entry->link);
 		vif->hash.cache.count--;
 		kfree_rcu(entry, rcu);
--

