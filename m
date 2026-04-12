Return-Path: <netdev+bounces-277782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIKMNtiT22lvDgkAu9opvQ
	(envelope-from <netdev+bounces-277782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:45:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2B3E3D3E
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCAF430015BF
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C66E27FD4B;
	Sun, 12 Apr 2026 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOOGO3K/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD819C546
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775997907; cv=none; b=S5BLrUq6r1s/Bql0zQB9A09/n+cEJeH1crXOh7ZuENig3qZkQtN2ADtCEUq6fl7y2i+Vv+q72onDPpM4IPj2rFI8Z3FaGvXIvnKbhmnSmyALNW86jlrOu69aLBtp1wjT9euKqA3Ni3/PDo9FtwsEZu2SV3REamSZOAXIj8YELOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775997907; c=relaxed/simple;
	bh=8Ln9L+1bUr1auVhrM1bMb8RKDwIuVqKervYg3i/L+/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eaccCx8V9JM+MnnO41DDHLeqECK2PoQmD2ut/x9VZc+FceDZHrDUi177RbXmp2zehMPf0G3g0Y0Z5JBwQQ6dEQuzhrbpD3nGxiQcIFKihn6KWayGC3PA68dDtBxaoM4cD2319uDVVimR7S4abxLsIrEhTbealr5WfS40qOxdG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOOGO3K/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad617d5b80so19451065ad.1
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 05:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775997905; x=1776602705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gvU9RvpBK2u7s6ovScuGMG+gjl6YN1La+ofcMQ5MbNc=;
        b=QOOGO3K/Tpb2g2ixVQWmRjGzjVV+IXEaZ0aRmrm3UUxo7YwMNoeIypR4wZJ8j60hEj
         BPZV6TfQ7Jtx7G9qsGij6p77OJnlozD5G3lFFNxZ1m5u3E8vbN3ME06493rby3g53c3x
         em2calVPZ0Pg6lb/FNjjOxlVBtsU/hvWq5EwBx3/Wa+bXpIakrH5vpsrc7akXQVnTv0g
         S/f5F557Of225IKdyhP4EHDKhO7BdGM6Bv/yL1BemjqaS6j9rvshVesMUVH2K+zBC9G0
         /s9o4xDGijjPW1svIHY3hxhRvTQtzqQXNmZQYEPN8f5wMt+4pGLsm/ZxuevT/dBS3GxD
         PVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775997905; x=1776602705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvU9RvpBK2u7s6ovScuGMG+gjl6YN1La+ofcMQ5MbNc=;
        b=iKND9ohRIACGLdfDRj/MOGuZxZx6I7h8LY4Q5IHkubJ12lBcxUF7BjCPzVmsclR/m0
         L5oqHv0+8fgxZLGas4uYnVpGMSczCaSYtob3j3mjyS9/aWoo8KG7Etw8KujlEfZWey/t
         /dHOU8ijveCBs3Fj5CB2ohjHBQASzlGCTUGNz4/WWbzw6f8Sj0/vMaMgMdJNaJOtnRh3
         MTfITiGVSL7+tS6cfegVqRKcU95hj3OA4AtgSt7yg7iZJucba3vj6/ZdQRlgEtheMajJ
         0W2tmNKLAgmY418USRSDdaKaByODXr/Jgi8I3ur4XYsGYQ7vu8nWEmxS+adQ3JbCgQ7F
         qwIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GnuCfId1E3cilYVWCkxmnrTtyjn+b4iTOkOqCNHMpbzH1UBHz10yaB/7g32HOB9Blt3QP+3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7irfAb/UhM2sN+sk63Xv8QPXWKW52L3RENdCWUIGNe1hJMFhA
	vJZ7K1M6nOAqZvNAGYqXIeR6LCN255dV2dl5xpp1aGFzSyADRYOHDjad
X-Gm-Gg: AeBDieuZbhLOtBX8CafcYI/Znywi2IePERKRuH47LmfMJaaCcYBqsCFHTJrBhKUNI3n
	O6cZC1e0Wjoj/S3YVJWn3R+d6Fd2O0ifjR1bMYBfSfgIDKtBLZhdWRNly9eB4JWq3ogUGxqPXxd
	TFeBRY5xV3UzKAJurAoXbaQVOjZ8BPLBR2UKn/Tk2qohxIG76QUp5siHYG+3pwNdVqabSU+9Jp5
	XyBU5zH/mqCQtd6RO4EAf/nasYpAMPGbIGluO3R2Dcy9kcdhHzeOQg7HAqaKV4hZVJxHthUxnYU
	5XIL0i1sGMNJ1uM0Wc/JhliqVOqlLR++AiT1Oz/07CA/SVvpU+QViysks5vXSaPxZbgbRaETxRy
	PZ8bxMl0Xrkowt2Ty/U/H2UsiMMz7/iqbaffTqdJUVYRcs1UlTfgoixKwr9ha8dFnp8SjcAzi0T
	hqn5HiZLWWydLfgLfuRr+oZTK8YDFUA+pcgjc6bSIf/mvt+z13Qf/c/MHH+WRXaeR0u+7vZu+Za
	LKsC0fA6uSGsx4dWc3n4VPyBgVN
X-Received: by 2002:a17:902:ba94:b0:2b2:5840:80c4 with SMTP id d9443c01a7336-2b2d5a291e5mr70378175ad.25.1775997905142;
        Sun, 12 Apr 2026 05:45:05 -0700 (PDT)
Received: from localhost.localdomain (ec2-54-199-123-161.ap-northeast-1.compute.amazonaws.com. [54.199.123.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm80273025ad.79.2026.04.12.05.45.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Apr 2026 05:45:04 -0700 (PDT)
From: Xiaobo Liu <cppcoffee@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Xiaobo Liu <cppcoffee@gmail.com>
Subject: [PATCH] RDS: Fix memory leak in rds_rdma_extra_size()
Date: Sun, 12 Apr 2026 20:44:55 +0800
Message-ID: <20260412124455.2008-1-cppcoffee@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,oss.oracle.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-277782-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cppcoffee@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1F2B3E3D3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Free iov->iov when copy_from_user() or page count validation fails in rds_rdma_extra_size().

This preserves the existing success path and avoids leaking the allocated iovec array on error.
---
 net/rds/rdma.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index aa6465dc7..91a20c1e2 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -560,6 +560,7 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
 	struct rds_iovec *vec;
 	struct rds_iovec __user *local_vec;
 	int tot_pages = 0;
+	int ret = 0;
 	unsigned int nr_pages;
 	unsigned int i;
 
@@ -578,16 +579,20 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
 	vec = &iov->iov[0];
 
 	if (copy_from_user(vec, local_vec, args->nr_local *
-			   sizeof(struct rds_iovec)))
-		return -EFAULT;
+			   sizeof(struct rds_iovec))) {
+		ret = -EFAULT;
+		goto out;
+	}
 	iov->len = args->nr_local;
 
 	/* figure out the number of pages in the vector */
 	for (i = 0; i < args->nr_local; i++, vec++) {
 
 		nr_pages = rds_pages_in_vec(vec);
-		if (nr_pages == 0)
-			return -EINVAL;
+		if (nr_pages == 0) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		tot_pages += nr_pages;
 
@@ -595,11 +600,20 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
 		 * nr_pages for one entry is limited to (UINT_MAX>>PAGE_SHIFT)+1,
 		 * so tot_pages cannot overflow without first going negative.
 		 */
-		if (tot_pages < 0)
-			return -EINVAL;
+		if (tot_pages < 0) {
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
-	return tot_pages * sizeof(struct scatterlist);
+	ret = tot_pages * sizeof(struct scatterlist);
+
+out:
+	if (ret < 0) {
+		kfree(iov->iov);
+		iov->iov = NULL;
+	}
+	return ret;
 }
 
 /*
-- 
2.34.1


