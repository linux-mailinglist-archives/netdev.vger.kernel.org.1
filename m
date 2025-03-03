Return-Path: <netdev+bounces-171235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECABFA4C161
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF0618889F4
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC186211468;
	Mon,  3 Mar 2025 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibR3gfYh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90521128D;
	Mon,  3 Mar 2025 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007538; cv=none; b=co1ormY/Mlb5UtMvOctdwhMGNP+Y4OEKXqLkis2D563f1FsLv+d4K1vUz7OrL5jwBhH6oeSmBLFokvkS3tDtdc89P1lEubLkEbAwWscR7LEOpGSo6NiNema6gsBv7IJkjUNlfyeeMERB8hOXgb/5lQBOqXMaCKDJFQ7/L11dU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007538; c=relaxed/simple;
	bh=68eMQJn9U5ISKmgEkbjyN0pmdAyTnTwPqx2KXySX+/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rCqe7Wxz1PpygZ8g+X8Mx1ywbi/Fvkeo6GYvr9+Kkd0r4yEyqDD5b4TKhHmXMnwlPvpUbrJ1YVTeIAkhVlVdVdC0/JaWC6dCvJhwLjQUQZp8Uvcl4cvON/+KdUNCH0KCTpIBoftsYkACFj3aA8ogVol+KwVehcmsfmCysBwPJe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibR3gfYh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2232aead377so84107745ad.0;
        Mon, 03 Mar 2025 05:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741007536; x=1741612336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AzgjeKIve24Fd+6sZv+68MykgeG3DIorGDi+sVwYibs=;
        b=ibR3gfYhOBR8zkhpuCTXrscEGNyB5/bfLxHFaG2qOxPUr8WWHd5PyWlqVKGDMmY807
         Wvajxdiq5JT+JdhotL9nzk2g199UNVv7W9OWFYseSgq9R+Z3PFbXWpYquDCZHUxYqJXQ
         NQEpa+OztJrNtNr8CQQAkSy/7dm6A59LtlmbTFCPBz3YJ22Oqi+o7KsArjQ5frw1wSSr
         pLAY6QhPr+XhOb7fkcxIxfzgHviusAA2dnjVyLVaIlpSKQbxfr8sEJEYm/FkHV+AhJDm
         xPKWbc27WZ9cZI8MzaInI+NYl7M5fBeyUrjt7o7YhReaBIKpgxzI9eRwd71qFYOmg99b
         FIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007536; x=1741612336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzgjeKIve24Fd+6sZv+68MykgeG3DIorGDi+sVwYibs=;
        b=RRXu1YAYLHsqAvqvmSl0kVhHhPMI36PRkeNjgiTuxy0Oc2HIXmdEqj+mI3lEOC9rBa
         2E5F1aWK0SLo9DaNSLOwVGUdYqJbDlm6pBBJQK+7H3uvcIM6oWB13fhJVcjNOzNJk91b
         K8hrno0jYr3MnB1UCG6tHrLxWY7TMWGM7qt0Y8Eb2sWdWUT687zZC6s4DrCidlei83Yd
         e/cm7yMpuYv6IrNH/oitqpBYmB7PLl2zrpE4aS5foQBTAc+BP6sx1QEr3fcbFTGee13B
         R34uXM4PPEeDCGI0E5Uztmq14dxhxkNSgyYxNJpDMv8ndZTxKfXrs/ilj8aQRaXZ75Bt
         CN5g==
X-Forwarded-Encrypted: i=1; AJvYcCUMto8iOi+mfiP2uei/8+9R0iLlyAJBwLhmfnvJoCQ2TAG3hu6f7+GZKBrvcv/sdYrGFlZAc2Qk@vger.kernel.org, AJvYcCUXjRQOjlPe5PFpa5au8gunKf1oRdv1drG6cZWWeFdd+G1fulPCbWZiMqLb0aHnZNKXfK5NIa6IVYjjj+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBxBs1dcbynVrExS32e/ZK51fKcfj8qd5xaMLo/G7IHY/19Fp
	W3FBmD01N1b/K8ltl6tCf1wbzSeyoXZSIbuQnltfpQGC4cLC7xXx
X-Gm-Gg: ASbGncs6qCrQ98jR5eRnYoCQu5XdkV9FGgkHV3dTiPDoEkCdJjhoc0/fl3i11E3dIQo
	UlX3+h7Gevl9CXplULL19s/wiEpoUE3srhUsFKZYrH6p6r8wkzA8HZ6lJdavUi+7dBYIHL80dD7
	NyT+l4GV+5sB5TmEx9es6u4CpRDUnq40mfHSVJ2vqXIoyjTs76ULDW9p3g9Vcyo+aGJ2+8NkZ1V
	5dxWr6y8UqFUEmIiAPme25Qi1uOYNnUIW4IsUZ34s0fA/1iwp+t2c2OUxA0Ax2lEoKA0fDOoPPb
	SQqv3hYOxhmg6z9DCbrCJOBuxnjXfu9HsjZblGsipw==
X-Google-Smtp-Source: AGHT+IGUbSmpt02l8nhbQ1R20Qoqzc0uLkQ8eYbH2yARwiWWhJqLqC0tgoarto+OVZO3BKwq2dQ27Q==
X-Received: by 2002:a05:6a20:6a1c:b0:1ee:8099:e657 with SMTP id adf61e73a8af0-1f2f4e4c8a9mr22839759637.40.1741007536348;
        Mon, 03 Mar 2025 05:12:16 -0800 (PST)
Received: from fedora.. ([186.220.38.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf245asm8133458a12.5.2025.03.03.05.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:12:16 -0800 (PST)
From: joaomboni <joaoboni017@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joaomboni <joaoboni017@gmail.com>
Subject: [PATCH] =?UTF-8?q?e1000:=20Adicionado=20const=20para=20melhorar?= =?UTF-8?q?=20a=20seguran=C3=A7a=20do=20c=C3=B3digo?=
Date: Mon,  3 Mar 2025 10:11:55 -0300
Message-ID: <20250303131155.74189-1-joaoboni017@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: joaomboni <joaoboni017@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 3f089c3d47b2..96bc85f09aaf 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -9,7 +9,7 @@
 #include <linux/if_vlan.h>
 
 char e1000_driver_name[] = "e1000";
-static char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
+static const char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
 static const char e1000_copyright[] = "Copyright (c) 1999-2006 Intel Corporation.";
 
 /* e1000_pci_tbl - PCI Device ID Table
-- 
2.48.1


