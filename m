Return-Path: <netdev+bounces-128917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23C97C6E2
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 11:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C3AEB235D1
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF731993B8;
	Thu, 19 Sep 2024 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRGxBWID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E781CFC0C;
	Thu, 19 Sep 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737644; cv=none; b=FXYl2MkIG4KesC3lnrQ5QxN2hqS3K3Jcu8jRuxKbgUVydktjNU0DD5blHkzjQ0iZaDUjlKejwuJXLFwTIV+vKPPTZt/AVM49OObMNpRDFkEw7LiJYfPG+UIE6uxb2w27SeykU3l8cNXlma0xVWeho9JbzIuk5d5j8EAtkzWuEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737644; c=relaxed/simple;
	bh=AU986l34BYcMhrEGJUyJ8eifExDZXbldXJzAM6FzRSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oy7FNtstCZ+tk2pR1XJB+9Amt0o8YuT6xHXlRLQHC47IF283DMjHaR4gJ+czLebFsb6PsTMJexzP3r5+tie6yLPEfwf11d+G4EnG/qNjH/1z7GNXroFL3yKz7ifqBWA+W70aa+iumTw6yYuP5FLeY/GvwzqgaV642jlLbI9Tluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRGxBWID; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db1f0e1641so116852a12.1;
        Thu, 19 Sep 2024 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726737642; x=1727342442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2HCkCdBBUpVJ0qsYsnBW5q14r0IwDCMEBz+OlfqvwaI=;
        b=mRGxBWID0UzKN67g+VWayTZ+/vEp0nIukzkAaghF/iGJq1/cONhbcJljwxblI53sJB
         qMlIubSBD2gwGNurGVPpdWfTMyv7yK3fDkVi6Hnn7GRaGJD/Mr5+aHj2SOlmz1/3JdRx
         QlBHCzTQ2j5cnNlLe6R1Q5Lq2Xs7bVtuQwbKzJoAu/acWXWrjp/oiZ3Mj/55990HxxLr
         GaE8zooITAPHr/Kr4YlXl0TcyygbUfEJKrisEH0LU2JufYWv6shMHhcW9K9llA/ODHf5
         To7gr6ik0IDG01GCGNPXR/5+mk5tg8SJ3cDVK8a1sFK7m45LviLAeyR62lKjDErnB8TO
         z0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726737642; x=1727342442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HCkCdBBUpVJ0qsYsnBW5q14r0IwDCMEBz+OlfqvwaI=;
        b=df+5Mb4pUhWsXfGLIhaGTtU5+lM7phf+dbPDMqPrnoeiN7PDKm8i3GPN2Im8TbRukP
         Ts7NVCYy5clpg2nD7QtmCzpzH5zIfOSLx65fflD4Ng9RzS1urwmqzFq43nPw3+rM4yCU
         HuMhLhkuzGwYMALNw7yrWC7cBDz+D1R60dowGBZMO6D+6t1SAWSWJgsBNmJ3svVM/Jbj
         JsToG7gWyeEuKxSDTUVg0YlEH7A2xf4cBPqv8Q2Pe2poPwOUJdowvQkgnChwzD5j4kg7
         cg/vQQJFB63Ev7mBNE4lpLZ1ovVfXfhCmk5u12Pu5bHpX5j12AgIFaYtZi0cqBOOhBUK
         Xibw==
X-Forwarded-Encrypted: i=1; AJvYcCUHv3XwWAoJRRosUdUZJbaAEak9LCbh9PdDbqaZ0ts2uCzaTpO8PZg6s1mTbOZxOsy0yswHUEKT@vger.kernel.org, AJvYcCUqKppff2KATZmzI8oJE5eWSTv/iTAtaN8X92SbhrRTaYHh4BNyd6r/ifVYkRx0CJym9Gnu+rVWp8Q17XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEltb5g8TZ7NR8bxCrEA9+OseDiogolnhR1OHqHl/zivmszcbb
	LgrQ2pfddMaAcBhIaGdprPycNvt1M/TIU7sgeptR6fmtpYYI6ZAO
X-Google-Smtp-Source: AGHT+IHC65bgZbGkrU/oDmLG+6tw2yQfdW5AiZJJIOtY8+xEQBNqxfKeGsUnMLf2uVeSng8N9IxbjA==
X-Received: by 2002:a05:6a21:2d85:b0:1cf:440a:d785 with SMTP id adf61e73a8af0-1cf75ee4d5amr34727850637.11.1726737642053;
        Thu, 19 Sep 2024 02:20:42 -0700 (PDT)
Received: from fedora.. ([106.219.160.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ee8a040sm1256568a91.3.2024.09.19.02.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:20:41 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	jerinj@marvell.com,
	hkelam@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: rsaladi2@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] octeontx2-af: Change block parameter to const pointer in get_lf_str_list
Date: Thu, 19 Sep 2024 14:49:36 +0530
Message-ID: <20240919091935.68209-2-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert struct rvu_block block to const struct rvu_block *block in
get_lf_str_list() function parameter. This improves efficiency by
avoiding structure copying and reflects the function's read-only
access to block.

Fixes: e77bcdd1f639 (octeontx2-af: Display all enabled PF VF rsrc_alloc entries.)
Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
Compile tested only
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 87ba77e5026a..8c700ee4a82b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -663,16 +663,16 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
 
 RVU_DEBUG_FOPS(lmtst_map_table, lmtst_map_table_display, NULL);
 
-static void get_lf_str_list(struct rvu_block block, int pcifunc,
+static void get_lf_str_list(const struct rvu_block *block, int pcifunc,
 			    char *lfs)
 {
-	int lf = 0, seq = 0, len = 0, prev_lf = block.lf.max;
+	int lf = 0, seq = 0, len = 0, prev_lf = block->lf.max;
 
-	for_each_set_bit(lf, block.lf.bmap, block.lf.max) {
-		if (lf >= block.lf.max)
+	for_each_set_bit(lf, block->lf.bmap, block->lf.max) {
+		if (lf >= block->lf.max)
 			break;
 
-		if (block.fn_map[lf] != pcifunc)
+		if (block->fn_map[lf] != pcifunc)
 			continue;
 
 		if (lf == prev_lf + 1) {
@@ -719,7 +719,7 @@ static int get_max_column_width(struct rvu *rvu)
 				if (!strlen(block.name))
 					continue;
 
-				get_lf_str_list(block, pcifunc, buf);
+				get_lf_str_list(&block, pcifunc, buf);
 				if (lf_str_size <= strlen(buf))
 					lf_str_size = strlen(buf) + 1;
 			}
@@ -803,7 +803,7 @@ static ssize_t rvu_dbg_rsrc_attach_status(struct file *filp,
 					continue;
 				len = 0;
 				lfs[len] = '\0';
-				get_lf_str_list(block, pcifunc, lfs);
+				get_lf_str_list(&block, pcifunc, lfs);
 				if (strlen(lfs))
 					flag = 1;
 
-- 
2.46.0


