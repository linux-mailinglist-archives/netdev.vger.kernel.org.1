Return-Path: <netdev+bounces-193010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BB1AC2229
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346037B9381
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF29B226D0A;
	Fri, 23 May 2025 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="mTcVVqj4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56422126D;
	Fri, 23 May 2025 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748000859; cv=none; b=FyI6sThtclQ8WhZ401xOehSAEnZm2AHBcBnCaFYuTBcfqWiFZsjOz6PEk+hQtd7oC/CpC2TtH8hVwzJEIXOiyuacCnAFErhR3ICszxQ6TOsiGQtnBOPtx4LaTbpjvoiBKxp9US/oXPMoRuF+na2fLjLNOrNjPikcrmdmYvL6gdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748000859; c=relaxed/simple;
	bh=ZR5kz7d36d8yCLqbSg4vLkBvfTbFkjuBbM5sJ1CHLDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EopfUhkTr4a0lG9Ycqh2TzB1K6nCA+H/UPX7S1TkM4QEkvgM9OIwasS0qk71nh9jtsWUNl58zizL9T8j8+OaqrUOHp2nVOeTBLU27Vwl2RB2wAp8dEn5Cn1gVvWwOAW3CqKsxkbVsz/CtxvaX/s/g714ktza+WqUsFN9DsHaE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=mTcVVqj4; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 162e370a0;
	Fri, 23 May 2025 19:47:25 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: jmaloy@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] tipc: use kfree_sensitive() for aead cleanup
Date: Fri, 23 May 2025 11:47:17 +0000
Message-Id: <20250523114717.4021518-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0IeVh4dH0oaTkpMT0lNTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktJT09PS1VKS0tVS1
	kG
X-HM-Tid: 0a96fcf82f9d03a1kunm474f0ff82a1fbd
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nyo6Lyo6HTE*DBQ#PhFJEUhO
	HSEKCT1VSlVKTE9DS0tLQ09NQk1LVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFKTEpPNwY+
DKIM-Signature:a=rsa-sha256;
	b=mTcVVqj4sUnDZeCJT5yutYFBLElqi3h0XPxjibifhIBbBFAGvD0ES7F0e+3mchL16Cx71lyYVvEcj5Cm9VaNeuQYQrUUFRHKIZNbqv8bSBoEdyWGx6gkJje2MrDLlknqehPF8x5EnOEa3d9qMlwPliiuxBvpH4L0uehHzuxes5U=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=FtFNpINy3v4709RDNflSnbTarNaggYuhoYDtYThRXVY=;
	h=date:mime-version:subject:message-id:from;

The tipc_aead_free() function currently uses kfree() to release the aead
structure. However, this structure contains sensitive information, such
as key's SALT value, which should be securely erased from memory to
prevent potential leakage.

To enhance security, replace kfree() with kfree_sensitive() when freeing
the aead structure. This change ensures that sensitive data is explicitly
cleared before memory deallocation, aligning with the approach used in
tipc_aead_init() and adhering to best practices for handling confidential
information.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 net/tipc/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 8584893b4785..f4cfe88670f5 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -425,7 +425,7 @@ static void tipc_aead_free(struct rcu_head *rp)
 	}
 	free_percpu(aead->tfm_entry);
 	kfree_sensitive(aead->key);
-	kfree(aead);
+	kfree_sensitive(aead);
 }
 
 static int tipc_aead_users(struct tipc_aead __rcu *aead)
-- 
2.34.1


