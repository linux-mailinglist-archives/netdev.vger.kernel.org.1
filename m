Return-Path: <netdev+bounces-99785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448C28D672F
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12BF1F2768B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74287F7F7;
	Fri, 31 May 2024 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="morn/Lfc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608E61422DF
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173967; cv=none; b=d34T2YhXKrRXCmTiat7HAAmVa+0s2BotljNyR/jF4gvNBgekbUZMsI+ABV4oP4MpGw6lXnV4BNEiimcEMHcxJZVrUJTJJAWxDRuIDFDtXTV4Naq2Ejmkl6pshCmMzpGamD1e/TSh7qNJaqXEudFE0qynpNiBclaokYjOqCskM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173967; c=relaxed/simple;
	bh=6O7ZIXmh9OdiepBqNZ5zAttBwLJ441WONalJSasbZXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PsUc1yz+VCWLvFINNoIeYZXFGemVJh8J11T9GZ3CxP4XgAN1JkK0dAqkFaVGToZrJqqUkHZZccuVaZTd2OOTm2ZLr1qG8XyM4QtGP2T0wfgVRlDdRjk2z2uwYhLHSOCRD6nRfCgV4pQ7O+yjcKIqewR91V2zYMiqa6EUZW4uHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=morn/Lfc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f4603237e0so1641187b3a.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717173965; x=1717778765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CZsowjbi3GVz9t8tYtNoa+sU7TtRfndL2TpU1EztciQ=;
        b=morn/LfcqDY5prVK6ASf6JFs0pZylS9c9kdm+ann1beN+8MKNziEc/xvIm9oOomKEe
         hAKvq5WpCzq3RdUTR3Wd7n7z8NGeUsW1uLxjhilghsz4HVhJ5hDLChKP53m+Kb681H5+
         dfUtYjV3HgHMNMhUNGCWlOiK5e8Ce5d5kuh2ES7qyvKWJr8iYPsVY+f+GUVYoezt54Sg
         LqFeceSqxOHlLWxaZ4NX1jt3TX4j37CFRbEJYo8dqI1/hT1T6YtPQq9JEB8AmSeh+K9t
         rFnMN7j/WaTe1P+J6+qeJNW4eNU5wDaIRyBcTCBcDkPZTYVysY6Qk3pWccdkxOQmHFr2
         2bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717173965; x=1717778765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZsowjbi3GVz9t8tYtNoa+sU7TtRfndL2TpU1EztciQ=;
        b=usuni+ozyncX+pS1IaDl3AUgHivcWjgtaAndQQfyHum8G1Z25GJSQq9QS69DVdBZ4Y
         GSpt9B7yPOli/TXV74MQchERUrw4MWCgv/VhQdKtUUwdAMKa80D8qxSY9bA1GnQBDk8J
         FOjUqTVkVrlK86nWu9U7fQGkcVsWZ2DIhOnW+kKxIYDnzVmo/DRefhfmaYpYg3JouGBQ
         utvWYnReRvweCP2WUYHDmVEGVm7+yZcF99rJd89yRNJTlqQMcZO/vpXyWYEVdmZP51o7
         OhcEyUByRO0/bs5Xz/qiLdRzMLCHOrQVxlNA/d9deb+7LzWjmww8ZudS3jw/A5cPkQmH
         BaOg==
X-Gm-Message-State: AOJu0Yyl+rGaVS3PksVWhjk5L759BMHgnTW9Jti4zgl08Bg/5sH0fevE
	Tsdkw1RZ/s36Q6o2HBPY/lrB617RsnB8yOI7gyqBlZ1GqGZJ2x1S
X-Google-Smtp-Source: AGHT+IFrtgUCYVc9Qi+YugLPx9Wc6eHnGYewzwVwjlo7+yzkNT8fmKgpaqwV9BlFiKr/LLgXDQ/ftw==
X-Received: by 2002:a05:6a20:840a:b0:1a7:8dd9:5fd3 with SMTP id adf61e73a8af0-1b264d1a88bmr8403169637.18.1717173965431;
        Fri, 31 May 2024 09:46:05 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35937a4dbsm1472789a12.59.2024.05.31.09.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 09:46:04 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] net: allow rps/rfs related configs to be switched
Date: Sat,  1 Jun 2024 00:44:40 +0800
Message-Id: <20240531164440.13292-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

After John Sperbeck reported a compile error if the CONFIG_RFS_ACCEL
is off, I found that I cannot easily enable/disable the config
because of lack of the prompt when using 'make menuconfig'. Therefore,
I decided to change rps/rfc related configs altogether.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index f0a8692496ff..cea38fc2e2ef 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -290,12 +290,12 @@ config MAX_SKB_FRAGS
 	  If unsure, say 17.
 
 config RPS
-	bool
+	bool "Enable receive packet steering"
 	depends on SMP && SYSFS
 	default y
 
 config RFS_ACCEL
-	bool
+	bool "Enable hardware acceleration of RFS"
 	depends on RPS
 	select CPU_RMAP
 	default y
@@ -351,7 +351,7 @@ config BPF_STREAM_PARSER
 	  BPF_MAP_TYPE_SOCKMAP.
 
 config NET_FLOW_LIMIT
-	bool
+	bool "Enable net flow limit"
 	depends on RPS
 	default y
 	help
-- 
2.37.3


