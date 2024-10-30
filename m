Return-Path: <netdev+bounces-140375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27159B63FD
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C8A1C21142
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5D81E22ED;
	Wed, 30 Oct 2024 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuhZ5kq8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA517579;
	Wed, 30 Oct 2024 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294683; cv=none; b=bEiWSNJRMw5Q1eeGhQVQZVUdleJn0IzRzniaRduMHgt+tgJSQUbVPAy9yMqsNBmAOpg7o1NOVAeNQaGV1w5miQXKVtrdxEYck/5edO2ImA6FGKHl11JMCztk87z0DL2ZxsqJeNCvA7h7IYd0Pwbzwjw36Nthwo7UxFSosZFgB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294683; c=relaxed/simple;
	bh=9upia9eBhbxQjlK2aUQDN8k83XS07xkN1JVkNJ3tfio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9QVWg3mm9CUsdo2UOwuFVjl3UPRCbgx8GAFLUIPkWIGuHqZt9rYZ6xqV/XlXNSntrgjNZaxvbFK0D6kwXFbNL2g1oTv1h19Cxvoo1qstgVffZvqaR6nNTJEphE0wYmFH5K97m4/FaxpDOdZf505QMo8byFQTB/uyY4i9xU5usM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuhZ5kq8; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7eda47b7343so4244651a12.0;
        Wed, 30 Oct 2024 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294681; x=1730899481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKT8U+Ir2Cw4EGV5p8at38Hbk5ntbf+As5d+x2XbNPQ=;
        b=OuhZ5kq8jH8CqAUWge9JZ0kLfvR5JWgvUsmb731K0fjlW5vJQMjrx34tJggLVicToL
         ps1brB9XHJP8SCHUt9syKQJrG9rmBwZXgwUzieNiwmB9y/yxlRMdvLHE31rFt5jUwHkE
         wM4+O6wPlTMkXyjNc9plG4SdVW7/OM2UFjO4twVkiTVRRbKsTDANdFBjdErQRuSeLb9L
         NS4/jTxlf1sZt1nIIxdoQobTzzsFUDuWrY8BDNG3vJlDFiyKnp7+5tPSjIGvFDtwN+R1
         cXHvYlUI7czqGgcje7EVsINdz5AentF9AStHC2mrPcmnfSaGxINQLekIN6ymdTCToTno
         8XMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294681; x=1730899481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKT8U+Ir2Cw4EGV5p8at38Hbk5ntbf+As5d+x2XbNPQ=;
        b=Hd/IapQoXHvtocAFwfo9qUEOcxAo+n1sHYx79u4+GSQsrYHvkHmVKbOBd9hkt3gvad
         to3w7Fw8g4Ac0+u7ZROJRF6T0zf1VUphsqeZ34ZdMoHVm0q2iKce+4mRQIxU3FNg7+xf
         dH8tadX4KFKodyQ4WMsT68dftSio79E/uHFBdBXc3U1My5SfC/5tBVImn4GGhfxfK2k+
         vVfDz/JVQuQdITW3It6HVi8aAsvLVy6JOhExHIPOBRIjgXMG+lxDFGe4G2oSoE68t9Q9
         EVphxTza4OALcJTToF3KUtR5yo0onX8v3l8cPuRgiGwkhPjLZkcjJz2KTAz1V2f+sahk
         VGEw==
X-Forwarded-Encrypted: i=1; AJvYcCWCa08m1jgLkZv0XNyudAWPlDkNoQZHljI2o5EsxlLcsce/6P/DrFHn/7jl+0ssjudIV81iUa3jYKFGeLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+2l6FqmIBCDOi6eR7NeYt9fNa3Sx4pl1CHPye+OhT4w3ZBSD
	bHKwqfbSYZFPf67BWRNA1n1ugY1cFgBcyZcQ00BBCCDfeaKVS3Gi
X-Google-Smtp-Source: AGHT+IHA5X00UE4/R3EXjGVYhmUcKmKOhChmtXag6PpNg14uYFjeAGEkFSa4N1U6oUSqoJtztzbSdw==
X-Received: by 2002:a17:90a:fe0a:b0:2e2:d5fc:2847 with SMTP id 98e67ed59e1d1-2e8f11bad33mr19014421a91.30.1730294680996;
        Wed, 30 Oct 2024 06:24:40 -0700 (PDT)
Received: from feng.cse.unsw.EDU.AU (dyn-dhcp-166.cse.unsw.EDU.AU. [129.94.175.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa36672sm1683676a91.14.2024.10.30.06.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:24:40 -0700 (PDT)
From: Tuo Li <islituo@gmail.com>
To: ayush.sawal@chelsio.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	almasrymina@google.com,
	dtatulea@nvidia.com,
	jacob.e.keller@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] chcr_ktls: fix a possible null-pointer dereference in chcr_ktls_dev_add()
Date: Thu, 31 Oct 2024 00:23:52 +1100
Message-ID: <20241030132352.154488-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a possible null-pointer dereference related to the wait-completion
synchronization mechanism in the function chcr_ktls_dev_add().

Consider the following execution scenario:

  chcr_ktls_cpl_act_open_rpl()   //641
    u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;   //686
    if (u_ctx) {  //687
    complete(&tx_info->completion);  //704

The variable u_ctx is checked by an if statement at Line 687, which means
it can be NULL. Then, complete() is called at Line 704, which will wake
up wait_for_completion_xxx().

Consider the wait_for_completion_timeout() in chcr_ktls_dev_add():

  chcr_ktls_dev_add()  //412
    u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;  //432
    wait_for_completion_timeout(&tx_info->completion, 30 * HZ); //551
    xa_erase(&u_ctx->tid_list, tx_info->tid);  //580

The variable u_ctx is dereferenced without being rechecked at Line 580
after the wait_for_completion_timeout(), which can introduce a null-pointer
dereference. Besides, the variable u_ctx is also checked at Line 442 in
chcr_ktls_dev_add(), which indicates that u_ctx is likely to be NULL in
some execution contexts.

To fix this possible null-pointer dereference, a NULL check is put ahead of
the call to xa_erase().

This potential bug was discovered using an experimental static analysis
tool developed by our team. The tool deduces complete() and
wait_for_completion() pairs using alias analysis. It then applies data
flow analysis to detect null-pointer dereferences across synchronization
points.

Fixes: 65e302a9bd57 ("cxgb4/ch_ktls: Clear resources when pf4 device is removed") 
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index e8e460a92e0e..524c8e032bc8 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -577,7 +577,8 @@ static int chcr_ktls_dev_add(struct net_device *netdev, struct sock *sk,
 	cxgb4_remove_tid(&tx_info->adap->tids, tx_info->tx_chan,
 			 tx_info->tid, tx_info->ip_family);
 
-	xa_erase(&u_ctx->tid_list, tx_info->tid);
+	if (u_ctx)
+		xa_erase(&u_ctx->tid_list, tx_info->tid);
 
 put_module:
 	/* release module refcount */
-- 
2.43.0


