Return-Path: <netdev+bounces-250690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9813D38CFA
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 07:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 887E33011FA0
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 06:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465FB32D0EF;
	Sat, 17 Jan 2026 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV9QiUDO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC423093C4
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768631981; cv=none; b=o9zXIeMpR+2PmskZvASy0QAO1FLUjZuy2dxjp0xLc+XjC9W+hEnAmyGhNgtO4lkoNVH+3UfB+miKX6frQlh1OUsOVq0Nw7vct3ZAazoRvFPMWC9AwDz3ys64D+yDTT4iD9o57up0ufTvXQJSzKVHELgna31pXe/yxIBfonx+Zrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768631981; c=relaxed/simple;
	bh=Op9TUg/VxMA16PKUtAu/Gj0/Vt+zMazAsyJERnDzqzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bAFYqzjzZjw8dR9wAyfGHHB4gfidf3x8p1UpGKb+EnstH1T+M9ecrPLtfHJb22AhNbH2MwbIbmVK3l8io6R5suKv0PFRPTgO8a7Jw+XViu1hpOQ5rvUFnYYUK99q8zJQzMvmm1Dp8VwIZnm+OB6ar6puP8kIQF8thpFaOF6FN3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV9QiUDO; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so1644726a12.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 22:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768631979; x=1769236779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8M1w05leQx+7ot5JX8ZEDxjSGqt4GVLt9y7yaclp6cc=;
        b=BV9QiUDOlMaEd4G4YhFLNNTZkXn12Z8bkVDJW+4QYyFYvuqHuZSqrCegxX6PT4XU6d
         rRIz2+9PTC01dnmBDVDjuJdKsCPSrh4KptqGR7kd4JpxlhPpGzJ2pp2uvD/kgkG8fdxU
         Y88oesAy6+HWUx8sV7bZdm2A88kU6VuQPRlKfumIHWtnWLVxfPZu69ZJSfDWx+wXN2jg
         5RXlUuNcwJR5lEwWAINMRtuIwMn6mVF5EVY1l6J1+IVZ9jh1LzhuVhRjPBe/2wvP4/Ox
         gCQL6f9IpIQD321IogQhypjEpMVGJkbPNEVh44d3YE36n4DGS58LX0ytFLUc55rI+fsq
         nQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768631979; x=1769236779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8M1w05leQx+7ot5JX8ZEDxjSGqt4GVLt9y7yaclp6cc=;
        b=rI86eU1xrll6R/qRV6goOI1yl36YJ6aHHddOy/C9w2JpJ/fzpFS1Ax/cE+vyz4pfWP
         eRz6QKxwS1VnbyZawOIOtQZ/RkNHKoGro+3eOC4IJ+Rp9KfrT2XgxIeytBsjncYEv8Yy
         guPVa2yba7aWOzjZQv9ULxzxnXIQ8QnFy8sifEwjjIJQbgQMyacz6qQoSUdBJYoeEgwT
         3sd/MFQUzps3onQ9d/0zMDfqhJvoU4gmVkhygGfBsjCb1fIGmCom+lfdGE+z3BofdVQC
         lKzE2GRyR43ENp9gCOjah5Dtgn2kGuTQGvVoeWBw0Gfu9cl4HqO1plvQbvgh76c19mmf
         acuw==
X-Forwarded-Encrypted: i=1; AJvYcCUfazhv69Axp6xCiq2+NAAK5+kf9Sg14oaHHiiNE9EZIlRsK0TfVIoqXoYCPxSzEyerKKe+2f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwTE0iMaRPPwdUSv/TjX3djaexPVzFxq7U1iIY/1iD+o4AepF/
	n/HAUzxpD8U/TbVCrDjcCFG+D36dGoxPn6KQdPSBFXp8uX5PdKEkbJaX
X-Gm-Gg: AY/fxX5XgzoxO/+tlZcR28QQhkrxavHWZpeHB9M0m+y6/FLfVIZJoHyWlTKmF6yjbh4
	A0b4fRSiA/qnqaZHXJjicQLbW3RA4Y2FHwwb6IiPwZ8k3/VFqUVO5g+U/UhYrfIy7nGpVO8xt4E
	/Hz/KTRnvATMe13SMvA78CDVAycypEVoOzXT8BEF545sf2cSR1+adNNpnBm02aSfXqbj2kp7+u0
	8LM0kU6qcNJ+L/Pv1/0jmv+ZaVKElJWBDqJxzkUmVf6313h5UEW28bvkV/V+TSwahhT27sPOLyi
	UvmBd9wA3c9qg39MRzXcLBXSUL/XQAt1C6W7YpSiT1l2pcd/Njjy0cBrHIljIMfQ4gx1+ei4E9n
	65aTMUytcslcpauFugBo5wFVMgxMrzhbNAfVGKO0x9Mya0dChd7kRt8Agxk6j/DrD0Vt9aUxN/w
	zVk9Hez7G8cHvKMbpmEtGWmnOCvyA7n65cSVb3+SXeFYxZX0++1E/WEZPxqGQkuvfDgCI=
X-Received: by 2002:a17:902:c94c:b0:2a0:e956:8ae8 with SMTP id d9443c01a7336-2a71887892dmr47471135ad.14.1768631979210;
        Fri, 16 Jan 2026 22:39:39 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:84da:333b:cc85:1610])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce2ebsm38239785ad.32.2026.01.16.22.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 22:39:38 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mingo@kernel.org
Cc: takamitz@amazon.co.jp,
	tglx@kernel.org,
	linux-hams@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+62360d745376b40120b5@syzkaller.appspotmail.com
Subject: [PATCH] rose: Fix use-after-free in rose_timer_expiry
Date: Sat, 17 Jan 2026 12:09:30 +0530
Message-ID: <20260117063930.1256413-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A use-after-free bug can occur when rose_timer_expiry() in state
ROSE_STATE_2 releases the rose_neigh structure via rose_neigh_put(),
while the neighbour's timers (ftimer and t0timer) are still active
or being processed.

The race occurs between:
1. rose_timer_expiry() freeing rose_neigh via rose_neigh_put()
2. rose_t0timer_expiry() attempting to rearm itself via
   rose_start_t0timer(), which calls add_timer() on the freed
   structure

This leads to a KASAN use-after-free report when the timer code
attempts to access the freed memory:

BUG: KASAN: slab-use-after-free in timer_is_static_object+0x80/0x90
Read of size 8 at addr ffff88807e5e8498 by task syz.4.6813/32052

The buggy address is located 152 bytes inside of freed 512-byte
region allocated by rose_add_node().

Fix this by calling timer_shutdown() on both ftimer and t0timer
before releasing the rose_neigh structure. timer_shutdown() ensures
the timers are stopped and prevents them from being rearmed, even
if their callbacks are currently executing.

This fix is based on code analysis as no C reproducer is available
for this issue.

Reported-by: syzbot+62360d745376b40120b5@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/rose/rose_timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rose/rose_timer.c b/net/rose/rose_timer.c
index bb60a1654d61..6e6483c024fa 100644
--- a/net/rose/rose_timer.c
+++ b/net/rose/rose_timer.c
@@ -180,6 +180,8 @@ static void rose_timer_expiry(struct timer_list *t)
 		break;
 
 	case ROSE_STATE_2:	/* T3 */
+		timer_shutdown(&rose->neighbour->ftimer);
+		timer_shutdown(&rose->neighbour->t0timer);
 		rose_neigh_put(rose->neighbour);
 		rose_disconnect(sk, ETIMEDOUT, -1, -1);
 		break;
-- 
2.43.0


