Return-Path: <netdev+bounces-130819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B598BA98
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD9A1C20D06
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB73B1BF305;
	Tue,  1 Oct 2024 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGQIf8UA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766BF1BF300;
	Tue,  1 Oct 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780781; cv=none; b=oKCPB/xai3c2b+M54syvxdFtkTK46tLoAFUcaFaX+CC7OrJWVUprR2Q/BJk/R/VJ84WbnEJOMeJy7D9l8nBJuyAmVqXqVzO1mU6krEmGczHN9BTBAv3w0sb2CHIJIy3P1c7Iw9YQJmVhjX5W0n//FbaD+Mo03foPwT9xmMs7LvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780781; c=relaxed/simple;
	bh=hHktRGRHnagoMBsEpOOtBADWcTPvrku1pefgGTO8zy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+2Nf7cYGmld81FeX8UsAI5CYtdcP6Ti2hZ/MOM9p+Ctgrn1ygSQR62GdyjV2ceFfhIjM3sUVaGk7WshvKUHeRS0syVsU/ilFyM7qw6G/Vu2kOSe6492J8COTozVFiEekghJi6c+yTgO4cyMTvL/sBlBmZiy0MrASFVG4N92C/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGQIf8UA; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e075ceebdaso4005640a91.2;
        Tue, 01 Oct 2024 04:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727780780; x=1728385580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uCOUNshkTAWwEsb1eAJ4f3GEGp7Z7j/QF5oPcgLSMQs=;
        b=mGQIf8UAjUkGAYbjuYGZUkwK42SzMDIPa+rCPtFHC61BSA+P7BXFQQrHPS8XMXK1Ae
         JvMGgl79QdsNSSKCk1Dgb0vVgbgnKj54jQ1M24/CMo+NFGj4R4VxBV3RGaNcbskQeXaW
         xNqa0w2+ikMu1ttsHPY5PbGSYlJwc/hJ6+FI2rWwqv2/N0EG/pG/HNtXDtoE7CueFwkd
         QIdTy7a/d2mbwmhO3Rz9oH0aPX/mCA7JuAySHxgmefhMPpvYT6w6Q+v9dfmOVl4RhZRU
         FOTNl/lD2Dnor9JejlQpQmCGHoooQNg1zqSVi66jPG7OwUhIz8JpzQ6SzLxmxXmGNkUh
         1zOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727780780; x=1728385580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCOUNshkTAWwEsb1eAJ4f3GEGp7Z7j/QF5oPcgLSMQs=;
        b=GW+UKUr6QAtgI/zlI8d6jDQExRad4iRwW8UAJnRLtILYz8zZeaW9PRJwvouo9Y6oQN
         dpQljj8zeDnOBO3CcMcTwbxQhC8G/PDhtfleM7HarFyhpjoga+f8KacOdtiQpaodXnv7
         yDzamWp1dUiUf0WS7O3bjja0+aB+cRyAxLZom6oc0N3wnM0E/qbJ5er2HJ797/tZjB0g
         3G6XdK6iQLJUlq8Z6Ih4XMrzH+Fum46YgEs6nxcq+EVRi08l1V0HHwH0pGFVi8iMxWCS
         e065SJgkn05zRUFr/DOIpyR/YW5iVfQLjQG5jCOkwKwJAyPRRjpmGozocLrl2tcaaldO
         k8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOAw4Pw4MXcxayOrPuWw4jpstCtObSuHg5sjKOiiOm6S5224qOlT0fkWSLPka3F8WAo65rf++G/YfJacc=@vger.kernel.org, AJvYcCVv+iwa0K98d8aB8DQeShuYzo27Amqjx3Lm1RxWaLvpFa44xjLIzpW9L0hzDTupjRHO6hP/iMAw@vger.kernel.org
X-Gm-Message-State: AOJu0YwkrWB+SCuymtS3X1rjUKRNE/+AvE4SDmg2bwQWDa8FGuljydQN
	VjhPQWFzUhHAo03u+nspVgJYxLvvAAZeb5/yyxpI8H6V9zv4Dwv5
X-Google-Smtp-Source: AGHT+IGDCY1l0dVGLxXgTkVV1bVRXnfqinrKZmy7aqXSY4XQ/CRB7cRtJyuAdLdPi5Yz9dn9A1YSmA==
X-Received: by 2002:a17:90a:39cf:b0:2d1:bf48:e767 with SMTP id 98e67ed59e1d1-2e0b8ea5e7cmr15771437a91.29.1727780779548;
        Tue, 01 Oct 2024 04:06:19 -0700 (PDT)
Received: from fedora.. ([106.219.166.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bc46sm9742276a91.7.2024.10.01.04.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:06:19 -0700 (PDT)
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
Subject: [PATCH net-next v2] octeontx2-af: Change block parameter to const pointer in get_lf_str_list
Date: Tue,  1 Oct 2024 16:35:43 +0530
Message-ID: <20241001110542.5404-2-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.1
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

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
v2: change target branch to net-next and remove fix tag.
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
2.46.1


