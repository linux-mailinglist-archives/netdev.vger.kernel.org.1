Return-Path: <netdev+bounces-164720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF93A2ED3F
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EE9166D73
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A541224B18;
	Mon, 10 Feb 2025 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1/7SyWk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65722489B
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193003; cv=none; b=LCkBx3ptw0OzzkGn0MRQ7yglW7NkyjIjBNAthpPM26+nawbZjxTCUqkHwJ/3IIbf/obV4xZpMypfniy/D98ZJ8vuGXil1L+d5yHenSqlp21AH7PpR0cucuTujg5ZQ1sUKW2mzpnaNaljJ2LILXjymfINcgi+ARJX5wKTxJHOGLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193003; c=relaxed/simple;
	bh=y31JsElUi4iOjLAKsF/RUVuozCne0PCJHL7mCxBoqlY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VRbgMMEeTy1hBGtpG/glXUJVaTObm+vrJMer+4ZEO2yrpYD1mc3L5+FH4YYM0+4a6A5QYSsnOpWir8vxY1kB2DwCPUXxDfFRxzOoFSSLchA0D+RolCayYATSkjQw5m81DIwXB61Nqt2xM7CehQCrOi8w8XH4uXCnOp4zHVRoybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1/7SyWk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f7f03d856so25592575ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 05:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739193001; x=1739797801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSi2o9SnM7s8OPmpUwpGbkqVLc5F43m7o8woyYHv6jU=;
        b=j1/7SyWkazR5kD66UVP3m/33qbE2YjWqSZtH7C5ztgui9DX/+yGp4EJ7lXyaQnvvml
         dLdeCCmK38+Q7lICZ9IDoRlIMaXVql3eQPtib+Zwdy7lBVp4zz605dbqAV4XW0f60Z1U
         VsxbsrxRrXB42XH8wlp8dTdoYjj25EtytiyEob97C4zwhOnSyekUz2THKsi/RT1ub3uX
         swn+/i+Wl4noLANu5jnRqF6bx34/JE7MQ1I5K5A1LxLgsjX2LmFt4MUVDf3tMyGKjAuy
         AKiC5iinluqUyQs64HfWEREa3wXDKKCMLJ9/jsdk6dQQtrbQHVxiBgECqhWVlkcCJg98
         F86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739193001; x=1739797801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSi2o9SnM7s8OPmpUwpGbkqVLc5F43m7o8woyYHv6jU=;
        b=mQQMqW0WFW7/HngBnVGw+OhKO6FeERp1JsHAZlRbErXBO/5Pl0msiQRtEWpziJl6/j
         +YqMpQqlZVuecJrJD3ch8rk8M+/IntV08P7EvqYn/zdfDQaKrYgo1HLepeQmcOAkD5l5
         U4Fj8vQ2u4lL+NDRBgcaFunIfvjm0Np7tRWWbXQO1/+ZyxD50DOyOw7pmHP4TJq1oWaG
         YTQQXC+5kfPVtawIMVyDoNN7yKi4jDR1uXn7UCNuF/i+ouajcuPpl1AgitE0ajRY8u8E
         cgrYyymuO7aG6xNW2PihLdhFh4HVp9oeiYuCgy+1K82paswKLkyJtQmzqjHW26UfgAKz
         4YcA==
X-Gm-Message-State: AOJu0YxmhpCDsmYLw25FwGwwjfY7pv2yhmeEYgL3uIdZPh0Pi0qMvMOW
	MalmWeKTGYJQ8D7BqKz4gnqY3WARZDLnjfxUhSFj4GsK4xm6+uBf
X-Gm-Gg: ASbGncsr2I9OSZTRzxrM+deCQA1jPs6g1Ux5q5ucOHWpvYs/NDZBFjC3afg0gd12vMB
	v8VHv5DnKIXDWv0gySBxway1iBRn2JNq6LPfqnmKS/IlHVYmyPihlb0TqWRRdUacvusi8UzQ30J
	1yn3zr+VyorQlUtMTPl07MTVByRNnpQItIoFh47vgYTyyGHXWNjM2tcgYyzzo2Z57q/gU/9ukWt
	Y1uwuREeIbevWNP6R9UfNYHlhZm7nCSJO6l5t6XL+Bm3f5PX0gAyiY2przyzYv63BvsEqMaUn9f
	zfqnghy0AsclQJ9E3ZUu+R4M6h+41+JnsFQ95cE2pRbJgT308aFI3w==
X-Google-Smtp-Source: AGHT+IGxnebEy+2NabR2VKn66UrQcBGzDwo1cT2Fo/Rpq+xP12TQbLWDVm3P/MMZDoR6c62hEPWyDA==
X-Received: by 2002:a05:6a20:12d1:b0:1e1:a06b:375a with SMTP id adf61e73a8af0-1ee03b70822mr24208380637.35.1739193000813;
        Mon, 10 Feb 2025 05:10:00 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048a9d1desm7457035b3a.23.2025.02.10.05.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:10:00 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v1] page_pool: avoid infinite loop to schedule delayed worker
Date: Mon, 10 Feb 2025 21:09:53 +0800
Message-Id: <20250210130953.26831-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the buggy driver causes the inflight less than 0 [1] and warns
us in page_pool_inflight(), it means we should not expect the
whole page_pool to get back to work normally.

We noticed the kworker is waken up repeatedly and infinitely[1]
in production. If the page pool detect the error happening,
probably letting it go is a better way and do not flood the
var log messages. This patch mitigates the adverse effect.

[1]
[Mon Feb 10 20:36:11 2025] ------------[ cut here ]------------
[Mon Feb 10 20:36:11 2025] Negative(-51446) inflight packet-pages
...
[Mon Feb 10 20:36:11 2025] Call Trace:
[Mon Feb 10 20:36:11 2025]  page_pool_release_retry+0x23/0x70
[Mon Feb 10 20:36:11 2025]  process_one_work+0x1b1/0x370
[Mon Feb 10 20:36:11 2025]  worker_thread+0x37/0x3a0
[Mon Feb 10 20:36:11 2025]  kthread+0x11a/0x140
[Mon Feb 10 20:36:11 2025]  ? process_one_work+0x370/0x370
[Mon Feb 10 20:36:11 2025]  ? __kthread_cancel_work+0x40/0x40
[Mon Feb 10 20:36:11 2025]  ret_from_fork+0x35/0x40
[Mon Feb 10 20:36:11 2025] ---[ end trace ebffe800f33e7e34 ]---

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/page_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1c6fec08bc43..8e9f5801aabb 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1167,7 +1167,7 @@ void page_pool_destroy(struct page_pool *pool)
 	page_pool_disable_direct_recycling(pool);
 	page_pool_free_frag(pool);
 
-	if (!page_pool_release(pool))
+	if (page_pool_release(pool) <= 0)
 		return;
 
 	page_pool_detached(pool);
-- 
2.43.5


