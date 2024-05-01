Return-Path: <netdev+bounces-92776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9425B8B8CD6
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F1A1C20A92
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D78612FB0B;
	Wed,  1 May 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dVUDfAc0"
X-Original-To: netdev@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF54F898
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576622; cv=none; b=UWVUdveUvD0V3sCqlNYVFBB62mOzhd89kOhtwJTZZjcpB7WL3nMmZSfiOo33P+1404ZDDNwIU5/e37/v2TyUgTHv6QFUBuyTeVMjjABVdop8ufsWBZ52Is6+8EJsz16UmG/itIjctg7OX5KY0saNzZC194ZHEpQ1aEkg5iuSFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576622; c=relaxed/simple;
	bh=mGcZdG/+nmxvHyKdPyzNeZ8XxJfzmVu6En0dHBRr+/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CQQKe0BrDbB1y732Uc7aGkL2WS/9eYmQxWwxkSmbpcNfAXI2xxGXd8vhR9Jsm02TDOcAGpfN88v1vZKc2DBRQ9/ki+vUIyVJhZkFNA1D9La2s5dfbUaTMGzIN0xyWBkesVeKp4j6SObTEuM/ak/aDL5AMZXtQ8ihr8edFQRXItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dVUDfAc0; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vrgeHLh8T398ENDhsWPoilnrsDD3PIGJ3Go+ZA2gpHI=; b=dVUDfAc0Tsoo5RT0FQnTn6BWLL
	mtzMc6QqCEJXe6Px894dy2C6PQL9dCnF7Nq8sdaeTjKFNafvSIo4zsGMjIGr0nT9qm2glqlUd1nZ4
	6X/wydsFlzs9T8iv+2q5QWFqZX4G7HnQMdAwRGlmj9vHQ03Brp4ktCbrJ0pWTH00vBCDS7Wk4civI
	8b7sTy3dR2huK9Up+nM3P10Hugh1JJGcDbBwx5GDrHKMgT8UGp3mGGwMFLSZHemzLsVxmbW9xupsv
	SayWqbKAj1WJVzKZamgHl0dWsMHbjLyPrjZge2CVdAEXJ/vLNLTXQJK8w4aEz3rnC0+tJujoNjSW3
	1MU4hpeA==;
Received: from 179-125-75-252-dinamico.pombonet.net.br ([179.125.75.252] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1s2BhZ-002dHq-0r; Wed, 01 May 2024 17:16:57 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH v2] net: fix out-of-bounds access in ops_init
Date: Wed,  1 May 2024 12:16:39 -0300
Message-Id: <20240501151639.3369988-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net_alloc_generic is called by net_alloc, which is called without any
locking. It reads max_gen_ptrs, which is changed under pernet_ops_rwsem. It
is read twice, first to allocate an array, then to set s.len, which is
later used to limit the bounds of the array access.

It is possible that the array is allocated and another thread is
registering a new pernet ops, increments max_gen_ptrs, which is then used
to set s.len with a larger than allocated length for the variable array.

Fix it by reading max_gen_ptrs only once in net_alloc_generic. If
max_gen_ptrs is later incremented, it will be caught in net_assign_generic.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Fixes: 073862ba5d24 ("netns: fix net_alloc_generic()")
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/net_namespace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index f0540c557515..4a4f0f87ee36 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -70,11 +70,13 @@ DEFINE_COOKIE(net_cookie);
 static struct net_generic *net_alloc_generic(void)
 {
 	struct net_generic *ng;
-	unsigned int generic_size = offsetof(struct net_generic, ptr[max_gen_ptrs]);
+	unsigned int generic_size;
+	unsigned int gen_ptrs = READ_ONCE(max_gen_ptrs);
+	generic_size = offsetof(struct net_generic, ptr[gen_ptrs]);
 
 	ng = kzalloc(generic_size, GFP_KERNEL);
 	if (ng)
-		ng->s.len = max_gen_ptrs;
+		ng->s.len = gen_ptrs;
 
 	return ng;
 }
@@ -1307,7 +1309,12 @@ static int register_pernet_operations(struct list_head *list,
 		if (error < 0)
 			return error;
 		*ops->id = error;
-		max_gen_ptrs = max(max_gen_ptrs, *ops->id + 1);
+		/*
+		 * This does not require READ_ONCE as writers will take
+		 * pernet_ops_rwsem. But WRITE_ONCE is needed to protect
+		 * net_alloc_generic.
+		 */
+		WRITE_ONCE(max_gen_ptrs, max(max_gen_ptrs, *ops->id + 1));
 	}
 	error = __register_pernet_operations(list, ops);
 	if (error) {
-- 
2.34.1


