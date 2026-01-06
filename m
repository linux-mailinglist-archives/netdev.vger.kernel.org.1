Return-Path: <netdev+bounces-247358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B6771CF8533
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 13:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9C11301B59D
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 12:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33228322C7F;
	Tue,  6 Jan 2026 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqD4vSD8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8391E868
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702793; cv=none; b=mn7MQ3WHA/cHHHTIbGDjWLg0Ruj7nm7G9mBUZCTQ9zgMgc4o+sZm4BAmAc5Kp7YAX4hP2tzfNhwBeKpZqLu86oPG1fbQSLZvLigGpggiimAke+Il4k5rFoOKcaSLD1ZtswY3XKq6vKIJuW8xmoDy+adGdE12ndy2GL75b3O5iyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702793; c=relaxed/simple;
	bh=DmmMG6Xd0V+yKRI0NieT+ZD/F0sL4CohjJmMoYF0Ok8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0afDZ1q/3hJ74stEsknbQ6Lr+XjwzbPQSIsVDn+kx79HKU6Aj0U7XFZP9Byq2ZP5ud44vxpu7rE0mXGmHHvWh3eoGInk48DLzBhABgbaHRWpI02/5EsneQZim9ePvRMsRc7YavCI8CUAH0wrZrUKjgw5kRQ9K2YLRdiFE/QWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqD4vSD8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bd1b0e2c1eeso704082a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 04:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767702791; x=1768307591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FoD+zbo2HQpI2DIEJb0/r0C6yD/iXNrlDMtyH30+9Sk=;
        b=iqD4vSD8N5GApOyWDEzmPtJg2hrrhnWXITmV7mi8xoLwYmjBneyZE6VdG4TJt9Y0ax
         JoYDnMwxHs1J10HHsqhR9Q6QcePB1/NPdo5mgug8nqibwkKtdyte9r+jD0vLnLIyqOq+
         tbIZGHEi9glaD+EEzCG+oGMleEnUjyc4dypHEm3TI0xzVYbcmH5dBkOddBQDF5FWzAbH
         iS/62jcqZ4PswWZQYvSei3a868eUQPkYrdcF3lBFjj2JCy2kAfWdW2SHxLQh7SFEDbP4
         1MR5CHOcuyCvpCHNP7rtpAq9dnBqF2M59xcuN742luVhOHOWk6FT+HHemLz8zHXEY/hl
         5cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767702791; x=1768307591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoD+zbo2HQpI2DIEJb0/r0C6yD/iXNrlDMtyH30+9Sk=;
        b=wPBbI1djUDmuMpyumobBY+ACU41EcHBi1z1dSen2gyQyVvhJlDXdn2VzF74irfH5vS
         ODZWH3p4oZVSB+dpj18y4jDvo3wA2mbsmusyxE+JoH/PpjQnb/Fhbh01YdmGM/ysjYbH
         1IkQ95RjSYA2RGYBtS5EG2P+ZcIJqp5qxMmMcWgmPJJodLERP5VnbELDVaGJd/1nhYcS
         ad2KsW3Cr5xK8pcXT0+rrqjKuxiSmHwn4FZ5EC6la8oirmNxXdruPX3O6EB52GltWbVl
         BSglSQsLKGmibeosE22dj6aJNyCBw3Cib2TyvesxfuWKbrxl9z2NlHXGQmRYBrt5YYkW
         ieEA==
X-Gm-Message-State: AOJu0YzNckGrLoQOxx12W7KrfpeqS6Gaio2+kPydogD1GYdPrhrEiEmd
	8XQOz+cE3RcReEhLTawwFnonLyDJI0c6e/+IknUZsEXEkCaeJdvNcpPubcH+MTXWs88=
X-Gm-Gg: AY/fxX60soAzPCF9qpHGljZkFrnzqrYZFmUWyOQLrES9tSfnSa3GLSReGF+TFo2lhtG
	Ow+NXWIs0uI1G897urvqEsRQzVFyjypU73FnQsrPFc/qhxihxFuagHPRRJIzaktDCX5X2YRsHiG
	eoCmBYcqTBaZNDN1KSDpbZ3isQTZdwxHoq4/j88+kQSTF09i9EOPmNMducfsrYfH4uvb7wXyDfQ
	a8YoeIpe3NJlRIXPwoHljTISKjkkyE2SM4XIc2vsLuQhiWOKY4oTTShMEdWP6whIUgBYrZkoket
	iVxUB3doB/zfYpbNIJbM29CENxp7wwneDqErD209Ma2PwR2qRT8J49obAWpXd0SDFroNpysD9cg
	PlngUMr0915oWbn+3m1r011mBHgJZN/kMrueKj1l8oCbsoTb8WJzK2kgP6oPHoaMYx1O1BU1qKd
	6D+LLojg==
X-Google-Smtp-Source: AGHT+IHnt1uQG57rcHloEdBPY1GTBpeMHJ/klaJ/TO+ZT4cbOqNaxyJIWbnilirm+kduEvNaekazbQ==
X-Received: by 2002:a05:6a21:3386:b0:366:14ac:e1e5 with SMTP id adf61e73a8af0-3898242d82emr2549255637.75.1767702790930;
        Tue, 06 Jan 2026 04:33:10 -0800 (PST)
Received: from oslab.. ([2402:f000:4:1006:809:0:a77:18ea])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb74435sm2223417a91.14.2026.01.06.04.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:33:10 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: ayush.sawal@chelsio.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kernelxing@tencent.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] chcr_ktls: add a defensive NULL check to prevent a possible null-pointer dereference in chcr_ktls_dev_del()
Date: Tue,  6 Jan 2026 20:33:02 +0800
Message-ID: <20260106123302.166220-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this function, u_ctx is guarded by an if statement, which indicates that
it may be NULL:

  u_ctx = tx_info->adap->uld[CXGB4_ULD_KTLS].handle;
  if (u_ctx && u_ctx->detach)
    return;

Consequently, a potential null-pointer dereference may occur when
tx_info->tid != -1, as shown below:

  if (tx_info->tid != -1) {
    ...
    xa_erase(&u_ctx->tid_list, tx_info->tid);
  }

Therefore, add a defensive NULL check to prevent this issue.

Fixes: 65e302a9bd57 ("cxgb4/ch_ktls: Clear resources when pf4 device is removed")
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index 4e2096e49684..79292314a012 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -389,7 +389,8 @@ static void chcr_ktls_dev_del(struct net_device *netdev,
 		cxgb4_remove_tid(&tx_info->adap->tids, tx_info->tx_chan,
 				 tx_info->tid, tx_info->ip_family);
 
-		xa_erase(&u_ctx->tid_list, tx_info->tid);
+		if (u_ctx)
+			xa_erase(&u_ctx->tid_list, tx_info->tid);
 	}
 
 	port_stats = &tx_info->adap->ch_ktls_stats.ktls_port[tx_info->port_id];
-- 
2.43.0


