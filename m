Return-Path: <netdev+bounces-232779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A51C3C08C69
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 08:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A00E4E67FD
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 06:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D72D97BF;
	Sat, 25 Oct 2025 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtDxybyd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4962D73B1
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375207; cv=none; b=S08+jY8Few4Y5zRj1NvMfrLYdFe1I3OJydDAbHOaLbq2kZm7gEzGANDYkCmvNF9pF6NQqZJMr8nD/S1ldwzvGqqHr8HtxiNNLhcs9ZSz3kLfdMQoh2M2IGXP8YzZfSvUogQk4nuCxO0RM/h8IA1U3sjThW2ZRMYPKbRuCo/w7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375207; c=relaxed/simple;
	bh=wijw4i1M0vTfBFIbS7+/cqkVMQiKCJdpRlsjiYYJilA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c20Bj5aAI03egbK/ViQH+kIsriLKbKgc7jOqirZqqVBtXlXyslYhwZHS0HpMQpXFhR/Togkjc4TpD99sXI9VTPx/O32NV1KkUz/YR5D3rtV+XBE8t3BfXJl7o/K6FN7WgFEovyn9yPZNUFceatIDV6xja0HQAKp/kdR9ltQqKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtDxybyd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781206cce18so2933784b3a.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 23:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761375205; x=1761980005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYxOi7/j9cjsZqMBUihMGCpPdFfgZqdeuZI37Hp+Tuo=;
        b=KtDxybydnYZddupZNm4crER3d/FqPBvKR8c6vqyzd63LC/9KJdzPlgX4Z1qaIbjxh4
         eDBdsFFDQWadwsAGdPvtMNghRXeC/1e/bwxcjfPpWt5CpxM7tzSqyVN59dkQiewKAhRq
         h9Ne+JLfPnEgitUbl0MNdL6X01dMbkkZCbf8uCDAuMl12AtGWmviU7y14CMibk/UUwZH
         PJo4ycEsDRAZEY51Ojq5RYwhc9J3HMCPA7S2fBxukPdNIsvpKciwCxH8PqAJVy23QAAM
         e7bc12n+Y4Ctd4HZNCQZKSuOYrGbgbeCkgWuUVbnWxzhb89hwID3x/cLv+4bI4oGI8Rm
         WO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761375205; x=1761980005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYxOi7/j9cjsZqMBUihMGCpPdFfgZqdeuZI37Hp+Tuo=;
        b=EkAI4+l22WDKKn+klJ6d2HCL24ff/w55mVibXOj2XhNMlRmA8YVcXSLttxvimC+ndY
         z2A1A4CdISoqAxFlFmNUKM1hG5kbT+JLWoJkKc1PPDbBo33tbQxD0dgdJqWlaJpfvkEQ
         idpcAaw+6nEPUg5+kbave6mxo2TJ/dk3DaIaLHYfdQNojVL9Okl0Zcsy2Yxl0KBY1RCb
         gzLC0Iwe32dCGy50+TUD2rQQn21Qz82tn1VhRzM6o41koT/Fw5k6RVhAe+yidfWKetC1
         4Gl01o83GC8SengNWDUXzOUvnAGjgY2BC05yk5e6RMhxAK8dcn202H/f0SK8ak6qtnuq
         pPaA==
X-Forwarded-Encrypted: i=1; AJvYcCXPW5Rpge8QRZEE1NAPXS4wRHkKUn1etK+Ugr2MLwXb9kcB45uHmiK2XdQFNY2b63ILNfCz9FA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8UkK1UT0gJ3eek9nkLf+/Eh6NRoDLTfTvlSGNlnapgN94Mt3
	+E46HOdKRzCSzukqdW1dO7WSA8/16Ti0/nagHb6FXzOO49nJOMjzoKUg
X-Gm-Gg: ASbGncsGifCe4CiwsSVZCcpYbq70JxyzXzjQW9BsWM1pb319M/4kcujE5Pt4pD/TqfY
	LuPyAfs/elR8NN0iKHsdko/nCIxEhYbjXXPhUyzaSynB5Wv8+MDBqjE8MXAygtLZYVhk7ZHyUnK
	cAAi9VBmTMBRG7lrwABg1WP8rcJQteDuTbm2RJADFyoJ8bcrm7t5DOUXv7isrYVjIC7Z/V6VLut
	7xz91Wr+qYfI3zD1Gwq+UUdBzZhD1aZCokVuM2JLYwGgoYPjWgsAFMgSsJDA5MZ+Z+OKAJZW05q
	MEWjWlKJ0tLPzQpfr2VR9i9BXyOkZZsBGO06eqsj8IN4em8Hd4xhYPV8UXlv14uTSmoAkxxYd1y
	qE4rtCP4vnSBN9tkLJ1hk8Enr4J0nwG1MI0db/bkvjIwf+JhgOvD28XvmDgRwsRBTSB7rHhpcRD
	YSNjeYbL5RSoi1097l/3qp16urFb4TVwEC+ez753QprQ==
X-Google-Smtp-Source: AGHT+IFQ0YTZEGeIJ8YN+UDuP3ySMc4ZngeurKJEicfSScvo2krlJZu4E7wNkT5tG9m9tU42s7mT2Q==
X-Received: by 2002:a05:6a00:23cb:b0:7a2:7dab:d51f with SMTP id d2e1a72fcca58-7a284e62981mr6779258b3a.16.1761375205034;
        Fri, 24 Oct 2025 23:53:25 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140699basm1262820b3a.50.2025.10.24.23.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 23:53:24 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/2] xsk: avoid using heavy lock when the pool is not shared
Date: Sat, 25 Oct 2025 14:53:09 +0800
Message-Id: <20251025065310.5676-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251025065310.5676-1-kerneljasonxing@gmail.com>
References: <20251025065310.5676-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The commit f09ced4053bc ("xsk: Fix race in SKB mode transmit with
shared cq") uses a heavy lock (spin_lock_irqsave) for the shared
pool scenario which is that multiple sockets share the same pool.

It does harm to the case where the pool is only owned by one xsk.
The patch distinguishes those two cases through checking if the xsk
list only has one xsk. If so, that means the pool is exclusive and
we don't need to hold the lock and disable IRQ at all. The benefit
of this is to avoid those two operations being executed extremely
frequently.

With this patch, the performance number[1] could go from 1,872,565 pps
to 2,147,803 pps. It's a noticeable rise of around 14.6%.

[1]: taskset -c 1 ./xdpsock -i enp2s0f1 -q 0 -t -S -s 64

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..76f797fcc49c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -548,12 +548,15 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 
 static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 {
+	bool lock = !list_is_singular(&pool->xsk_tx_list);
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&pool->cq_lock, flags);
+	if (lock)
+		spin_lock_irqsave(&pool->cq_lock, flags);
 	ret = xskq_prod_reserve(pool->cq);
-	spin_unlock_irqrestore(&pool->cq_lock, flags);
+	if (lock)
+		spin_unlock_irqrestore(&pool->cq_lock, flags);
 
 	return ret;
 }
@@ -588,11 +591,14 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
+	bool lock = !list_is_singular(&pool->xsk_tx_list);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pool->cq_lock, flags);
+	if (lock)
+		spin_lock_irqsave(&pool->cq_lock, flags);
 	xskq_prod_cancel_n(pool->cq, n);
-	spin_unlock_irqrestore(&pool->cq_lock, flags);
+	if (lock)
+		spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
-- 
2.41.3


