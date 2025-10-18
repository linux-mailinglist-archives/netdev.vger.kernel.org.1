Return-Path: <netdev+bounces-230661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F16BEC80E
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 07:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E874919A84E0
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 05:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A439F223DFB;
	Sat, 18 Oct 2025 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAFljKAP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2AF9443
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760765277; cv=none; b=LVhyHcXVZh1xn3DqVeFJMbOVEhEROJspJ9I7OlvDk/Ju8U3qVtSfn0yLYinqytYOgtZ+W08ZPmpYijxRZw/EsYwELo90BzqwglCMa/5vI6AulGkoDJEtvbCyE/O7vjMEEEWMXM240IsMfHRA4V7iMTUXGrbaQ1g+c/PWhlueTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760765277; c=relaxed/simple;
	bh=qEX4ZRyADdtMHHuQSPQXlzifu4jiBpegoYGgV4Kwd8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJ+t/5N95k1nX6FDU8Ikx2lL4hf/hNlTcG07abCT2yDicDxKCFXsxpgQ3l38O9Z/23eafP9xqiD4BlEWozuPDaWuR2OrYsyl7zRfuu6G8OKpHiF6CJUkdbRLQo/YlxW/WIwoioROVMRFdm9liiZ0hkmdhB97tR/fr8zgH6r0Pbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAFljKAP; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33bc2178d6aso1585439a91.0
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 22:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760765275; x=1761370075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VLm5DAG9fXkl0zixt19/6W0LNVYzxfSWdxnFtQHdyc4=;
        b=eAFljKAPIJn1uL6DGW8NtFyZnPN7RZWpx0Fx9bVs4Kker7uvzki90VaCmyVKgrekO8
         hl1zZaJ9I2+AayBZ5aiCr8Dzxt1BJr98BHxEcBgQo1VoBfjOT5Er0cgWlINWP/TNOm7b
         jhv9qPzLXay5vAapC1oTY5Ze5Bi4DYEFguPD8Al8MWNMy22DVqisiPLsSCyTab9forcz
         rM+8Ku6N2h6BF4w4nMroVZdRzMLlQPTfjDU/iWdhbuovhUfNJuvIjM6jpK7U6PvxzTd5
         P9RzB9jxaQJM5AF+jDUA56KxdHQrc7qHvm0CdKxfq5SkHdIlNEVvhjaITSlkDbOOar/4
         AVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760765275; x=1761370075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLm5DAG9fXkl0zixt19/6W0LNVYzxfSWdxnFtQHdyc4=;
        b=J7crVG7KpDyo7wp4/n1dWzUitMN9qj9wBmZXjicV+aibcjmyiZYKQKee8i9bAVub1Y
         UHbgr+z1gIj0CwVQQb1+c0cF5UcFTrxw0pBCWd818HAeaAN51oV85X2QPAfKwIuuxv1A
         pj4hQXBKaaC49xpAEWVtzxWrTAEIMLfm9MMPFKugpwF5V1lQ0gNFTEOrIh6ezNMUKVIN
         a2RtKxRiWrQSMSx9jjpMVgwz4xdyv08KIOCIfklHWsD3XIBsxWir5bVAWZEN+MAC7bcg
         obA45mTJbz7w/zxUDp9vcVKSi/oSYE7L4V6UDLb8H0xY6usAneba2T7f9KYNbwImNbhp
         XAVw==
X-Forwarded-Encrypted: i=1; AJvYcCXV1iq5U8ZWkeXfnhOEkn/GHJLjIgS8LkuxZvEbVmFf32MSDjFC8ceeysuQljBj69P+wdu7nLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm+WMqPj3l4UNmgxVtAtVU4nGPlZd75va8z0tgaBvt5/T4LsjR
	fgEGL2k+6CT7kVS60gswc3NpNvXCiMCMSMzrVF7rThKxIgTzAjv4XNiU
X-Gm-Gg: ASbGncvVa/iNQV58mnHBHIncSLGIRG1y9DikNXvS136khnWnDV3u6RmwboHPuFj9Om4
	e8OmCV0sai0/pInkg5+QKuqhLzQM0EnvBPiaL7rP892oLBcETw5E1YImEXrxaMtau4eFt6i8fVt
	QOxRgh1Dvz/lPldtk78QY0Sumw0fxxAgfhVw2Z+lePv8T/UFlPkkWXAs9X3VWYVAXnCRuVf52Mf
	ilViTtQ6X4ADjW9cM2eluuXZzT7yva+ahIlgNy+yXPVXdNo/eDZaaIQmfbf0BMB77mL0e02rvlI
	4+B4KUmpbdQ7+LA3vQ8FZByAukjbQVejXQ/d+vij0/kwhkLsK37d7UnDL8HYA9YFh+0y/XjXCc+
	Jet8lhxGDJu8QFBCIU96iPeUbmGqqhRU/OXuftyDFei8zw4vBPDqpeUmRba01Kwx88L/HgeTDxz
	rVBtKdttA=
X-Google-Smtp-Source: AGHT+IHogwMOGocmpixntoYw7rwI5KNqsmnHI3NmlBhSuqqzwCNh1cN6EApDN5X0d3rxS2SowaGvIw==
X-Received: by 2002:a17:90b:3ec6:b0:339:ef05:3575 with SMTP id 98e67ed59e1d1-33bcf8f94c3mr9100489a91.26.1760765275018;
        Fri, 17 Oct 2025 22:27:55 -0700 (PDT)
Received: from fedora ([122.173.29.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33baac8b4dbsm3268832a91.5.2025.10.17.22.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 22:27:54 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: horms@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	i.shihao.999@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH  net-next v2]: 3c515 : replace cleanup_module with __exit
Date: Sat, 18 Oct 2025 10:55:41 +0530
Message-ID: <20251018052541.124365-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update old legacy cleanup_module from the file with __exit
module as per kernel code practices and restore the #ifdef
MODULE condition to allow successful compilation as a built
-in driver.

The file had an old cleanup_module still in use which could
be updated with __exit module function although its init_module
is indeed newer however the cleanup_module was still
using the older version of exit.

To set proper exit module function replace cleanup_module
with __exit corkscrew_exit_module to align it to the
kernel code consistency.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>

---

changes v2:
- Restore ifdef module condition to compile as built in module
- Adjust subject prefix from "net:ethernet" to "3c515"

---
 drivers/net/ethernet/3com/3c515.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/3com/3c515.c b/drivers/net/ethernet/3com/3c515.c
index ecdea58e6a21..2227c83a4862 100644
--- a/drivers/net/ethernet/3com/3c515.c
+++ b/drivers/net/ethernet/3com/3c515.c
@@ -1547,9 +1547,8 @@ static const struct ethtool_ops netdev_ethtool_ops = {
 	.set_msglevel		= netdev_set_msglevel,
 };

-
 #ifdef MODULE
-void cleanup_module(void)
+static void __exit corkscrew_exit_module(void)
 {
 	while (!list_empty(&root_corkscrew_dev)) {
 		struct net_device *dev;
@@ -1563,4 +1562,5 @@ void cleanup_module(void)
 		free_netdev(dev);
 	}
 }
+module_exit(corkscrew_exit_module);
 #endif				/* MODULE */
--
2.51.0


