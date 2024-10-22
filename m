Return-Path: <netdev+bounces-137966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F6A9AB481
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2C5285B52
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2221B654C;
	Tue, 22 Oct 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+0poDUi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE464256D
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616249; cv=none; b=PPLG5ox1HbEbSLC/fmjbuse/PKoBFA6snvj70ScQwSJZIU6BMyeJs7bjhi7HHgXfKINCaxBd/8y1dvSO3RLH7DOL+hYe7771PrjwbfiZHzPIxxW+a8r0eKjSd0RacWzNOOiZLn6f2izIwLu9djG+UFB0zozVIS8IWrhv4RVAcpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616249; c=relaxed/simple;
	bh=iufFbICdqJF6m1zyI2SMlCLECYvQAXdZI5A3s/y0h9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CKXaZeC0MU7ynSfuxQwx5ls0fKBNMYBeJ4m9mq+BncCun+SnrXCYLjV6UeJKcNdHb2K2snhun3hZqL3hdhnWV+JER4Vd82wqLDgg1aYSVocoYZh9TnEInpFLjAdWTtm3g16N3Dio4bgXM+fyM68VVJw9xFPKqdWnqDPKkdEs11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+0poDUi; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-4603d3e4552so47282301cf.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729616245; x=1730221045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oUUTPVaPMeKSDCJ9oFRfYJvG5DbG1YpEZmMBBeHmzVg=;
        b=Q+0poDUin/HqBD+qm+6NY/wD3ZXvISI7HlK7APPCFnv73ZqR8t6a/u5OWlRY/luh69
         rf8PTicGF0Nx2+8E1Wc4wK6a55cxz8FQh5jZzH5utrDCoDSlYJSNBQcpZScZV+SDDtwe
         fEod+6dyPcawTn0Yce0BJYUWswIF4r4wWzexv4g5t2O0Al7N4wRnElbEq+mWlqH+kMZW
         lW4YHC4UDMRaNTu04W6cD5vvMLw5D3hGqD+aWKR0/Av7Ru2DHGcGK3kEjc3weerdRU1a
         UY3vohnn9vc+jwxZ/BF9fr4DTp66VXfRjXSnakk5cm2n9RwrVjUsZtJMvVfiUU54052X
         SF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729616245; x=1730221045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUUTPVaPMeKSDCJ9oFRfYJvG5DbG1YpEZmMBBeHmzVg=;
        b=K5fqSh8wujngtkjH7AXttAHSxlJDxW58kD/v6caGDBisLhprKu5IJHvMzHbkAnm3qO
         wCyWcaTHgvBaAKFXv/rOCXUryzmqW+tRzDuCTM7izlyXc1+2rTHnqshcJEDPmUP8kp9D
         +R3g/tTuHFpBwMHVFUwHJvbSOarjU0XPv47bMo9rrBBfWTDlAzMHmWnChPjn6T0D2V5s
         ttIxdCOQl8MVbVmGb6CVDxkYCm17klQ6EfRO5wMGRYKz/7/PqQXxRv/c1Ur8jzGSsA34
         JGTEg1MZY7md/vFzZpg4trOTUD9fdHrhDvF8iwJ7HZJdF62J5RdKlhsy4z2S3fYZBEhf
         GuRg==
X-Gm-Message-State: AOJu0YyrmX21I+REvswmNLb5RdMJt9b8VSv3c50YpfX90E9Xtq8+nOsF
	4WT9D++/QBrEaMCgJ5Tro2SmQQK8Aul6B0rjn/p+kQIDJRb6cOOI
X-Google-Smtp-Source: AGHT+IGKOSeREJ3My4kgsyV9fpLn0g3ILK1AsPV+EZGBTn1qmRFik2b37XShK3kv8+jxni14CI6DIw==
X-Received: by 2002:ac8:7e81:0:b0:460:9b8a:d02f with SMTP id d75a77b69052e-461130d0703mr2788801cf.51.1729616245409;
        Tue, 22 Oct 2024 09:57:25 -0700 (PDT)
Received: from localhost.localdomain (host-36-27.ilcul54.champaign.il.us.clients.pavlovmedia.net. [68.180.36.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c3fe1csm30866411cf.10.2024.10.22.09.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:57:24 -0700 (PDT)
From: Gax-c <zichenxie0106@gmail.com>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	petrm@nvidia.com,
	idosch@nvidia.com
Cc: netdev@vger.kernel.org,
	zzjas98@gmail.com,
	chenyuan0y@gmail.com,
	Zichen Xie <zichenxie0106@gmail.com>
Subject: [PATCH] netdevsim: Add trailing zero to terminate the string in nsim_nexthop_bucket_activity_write()
Date: Tue, 22 Oct 2024 11:57:13 -0500
Message-Id: <20241022165712.8425-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

This was found by a static analyzer.
We should not forget the trailing zero after copy_from_user()
if we will further do some string operations, sscanf() in this
case. Adding a trailing zero will ensure that the function
performs properly.

Fixes: c6385c0b67c5 ("netdevsim: Allow reporting activity on nexthop buckets")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
---
 drivers/net/netdevsim/fib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index 41e80f78b316..dbb11cd46a86 100644
--- a/drivers/net/netdevsim/fib.c
+++ b/drivers/net/netdevsim/fib.c
@@ -1377,10 +1377,11 @@ static ssize_t nsim_nexthop_bucket_activity_write(struct file *file,
 
 	if (pos != 0)
 		return -EINVAL;
-	if (size > sizeof(buf))
+	if (size > sizeof(buf) - 1)
 		return -EINVAL;
 	if (copy_from_user(buf, user_buf, size))
 		return -EFAULT;
+	buf[size] = 0;
 	if (sscanf(buf, "%u %hu", &nhid, &bucket_index) != 2)
 		return -EINVAL;
 
-- 
2.34.1


