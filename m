Return-Path: <netdev+bounces-102057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438F09014C3
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 09:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB864281BFF
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 07:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7732179AE;
	Sun,  9 Jun 2024 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PySHLLVh"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9CC8F3
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717917644; cv=none; b=DMKhgrvzDO7WygJb6WiBG6WXdi/isFMCpaiigsPvgO7yIbJxCaW5M9a+fVEsWZuY7XDT6eT7cZ8QPWuCJ13EUgIvGvQgAb1IGtdVfb5XDk3QCi4uzwDCxPJac+3VwA1xcf8cvuiZbrY+DDREKoiduNJy/kckborskfPszY6caSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717917644; c=relaxed/simple;
	bh=tYZsCR6MpDfSUZaZYcDfWrRPgJ+stN8XSR0FiLVtq2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nMGbPBDW5DBqJZcFe0gGxZVFtTDhCBQgFvjSALnCdMLP7Hi8j85670yrA6ScuNKxWst73cQfqPwb1qo+YPHOKxixCfE0CGaoh6UfU2JHr+tvM6FbgqajVIk6KZneBmOIkq1GquFGrl81KBv33yRC/D7mFwRwhR4gitDZZWEgeps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PySHLLVh; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: davem@davemloft.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717917639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yBuBf30Snq1/ScFCv+eHyCx4GQE1qvyltqCPKA7D91Q=;
	b=PySHLLVhsh6tMRPDMRMi4JgaSCD34JJppAAaVYOKNx3E6lmGawFPKv/Mln9H2OxsHUBJG6
	wnE3UKwrZZsFXVUSNqdz3c5XI0P8if8XE2Mz+o+g54/JoJCmQyZ4ru+iPxbbj3irETb3Jn
	q9yhjMDo15HsGjvKjeUWLrcVW3rtUW8=
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: bigeasy@linutronix.de
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: yajun.deng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: bigeasy@linutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next] net: dev: Simplify the conditional of backlog lock functions
Date: Sun,  9 Jun 2024 15:20:22 +0800
Message-Id: <20240609072022.2997-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The use_backlog_threads() contains the conditional of PREEMPT_RT, so we
don't need to add PREEMPT_RT in the backlog lock.

Remove the conditional of PREEMPT_RT in the backlog lock.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 net/core/dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e62698c7a0e6..db6b6fc997e6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -229,7 +229,7 @@ static inline void backlog_lock_irq_save(struct softnet_data *sd,
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irqsave(&sd->input_pkt_queue.lock, *flags);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_save(*flags);
 }
 
@@ -237,7 +237,7 @@ static inline void backlog_lock_irq_disable(struct softnet_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irq(&sd->input_pkt_queue.lock);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_disable();
 }
 
@@ -246,7 +246,7 @@ static inline void backlog_unlock_irq_restore(struct softnet_data *sd,
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, *flags);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_restore(*flags);
 }
 
@@ -254,7 +254,7 @@ static inline void backlog_unlock_irq_enable(struct softnet_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irq(&sd->input_pkt_queue.lock);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_enable();
 }
 
-- 
2.34.1


