Return-Path: <netdev+bounces-100813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6EF8FC1D4
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 04:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0871F25F07
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F91838DD6;
	Wed,  5 Jun 2024 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZny1w5l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31B52AE75
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 02:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554584; cv=none; b=TToWEfRibdGNqmQ9Qdbap7qHnegzj0QokUQx+gXK+Syy8gxx2XxTDj9aXUR5hw9Ud3Y7zRxoj3Qf3dSZedYPh1w47+23ah+RwmZQZu0rVDtaZfd8KhWv4owmdqFZCn08Ut5dgQsibtI9aFdxDLq8r1l+0YjtIfo+/UsP/RGxlsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554584; c=relaxed/simple;
	bh=xiK5I1bSWSjTAI5Nb93Vt44KlFMCto4AvcesUeXQQR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LY/QiOcVfUQRNuKwwj2UMoGRVEFBlTx6r9Cr2ZvVuHy4Frwl+eCL2okdNT3ge0XBbx1snmz1vRCa/6suPXC2TLhFCAiAB8beb3w7EOnWfbLgtlAoFA9upvONBNbrTIjAB2dwLbsPR9GqRSUDMFYGZfU6k9Y1hU6arMyk51QZbWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZny1w5l; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d1e9a2decfso1050430b6e.1
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 19:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717554582; x=1718159382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b242zK5cCq9h4CZ8V4JjeNw0ALl4rsTNRUZuYF5Pzqg=;
        b=bZny1w5lU5FDLMozaBJbAscz3aohSyvw0rZoMXZH8x+RFWsa+tXEte86ThUYEInjKM
         0YhD9sTJ/fSl1bZlM01+nG/I6TBFeJRHCDDEKVGJM8M3r3nRLWPX+LUesUPIBsKKamZt
         HrWDu5u2sfAmiLE33kIuNiSIF5SvLcc2dLDKUwbol637l2yasdv0183wRVYOoRZnHGok
         grJQ3/E8N7hAVBh5RGtovSdPPL4qZC6l2MrhJ4mAfvZRPZu6FhynUuZHoV+Dr+XZK3Zw
         +rDkBuNkqYl9IrZRjSZZCA8vpHbGmu6COrY6FvRC8MNkM6zXzNJs1/5YXbO8jhqQWsjp
         UnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717554582; x=1718159382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b242zK5cCq9h4CZ8V4JjeNw0ALl4rsTNRUZuYF5Pzqg=;
        b=P+09D/kUPjlZjnGo/Lqjhh9QtFbQ9GKtqbghDiiTrRhQxmFvW3V2Mugybgt1OxUWi1
         lqftedBjH9gVuxUQ+zTCJWmM7j1m4iT9s//y4ffzs7OzMZtEOPnkpifXNIxv6E/elTlN
         ebLFwyad/ixqWqDQDAYAw4+lDid55w1a5Kqhy5FBJnjBlLut+nyiMoQbbRfuZh5rHseJ
         UBOfT2vklVhURI554dIgkd11420vlrdVAuuYOwcVekNsqOMaIY6LB1I4SzoNecmhNY4p
         iQ/kTvlPXxKqlWwlDpGJAtEFydyGnC0mqo+lPAA/DbLloojY8s4IsSGK88UWxeS73vHp
         8PkQ==
X-Gm-Message-State: AOJu0Yyg3AsFDouooLkZZtqWot7o2uXYKKWX20rWqAaUqa7wfFFXfo0I
	vVy/SPgfNQVJHCq5l7y9WOQE6fSCYQAV9TaZdm8mpisUPLbxK86Z
X-Google-Smtp-Source: AGHT+IG8UlMlv/UB2RQ9oVE0XP4KwhtLVHNPEm+LQ4LbVNbBsKo9E1zQnigxP+l2HmvGJoKBa8f82Q==
X-Received: by 2002:a05:6870:a693:b0:24f:d57f:86af with SMTP id 586e51a60fabf-25121d424bfmr1436945fac.19.1717554581739;
        Tue, 04 Jun 2024 19:29:41 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702425e1954sm7679878b3a.83.2024.06.04.19.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 19:29:41 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2] net: allow rps/rfs related configs to be switched
Date: Wed,  5 Jun 2024 10:29:32 +0800
Message-Id: <20240605022932.33703-1-kerneljasonxing@gmail.com>
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
v2
Link: https://lore.kernel.org/all/20240531164440.13292-1-kerneljasonxing@gmail.com/
1. add 'help' and remove 'drop' from prompt (Simon)
---
 net/Kconfig | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index f0a8692496ff..9fe65fa26e48 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -290,15 +290,21 @@ config MAX_SKB_FRAGS
 	  If unsure, say 17.
 
 config RPS
-	bool
+	bool "Receive packet steering"
 	depends on SMP && SYSFS
 	default y
+	help
+	  Software receive side packet steering (RPS) distributes the
+	  load of received packet processing across multiple CPUs.
 
 config RFS_ACCEL
-	bool
+	bool "Hardware acceleration of RFS"
 	depends on RPS
 	select CPU_RMAP
 	default y
+	help
+	  Allowing drivers for multiqueue hardware with flow filter tables to
+	  accelerate RFS.
 
 config SOCK_RX_QUEUE_MAPPING
 	bool
@@ -351,7 +357,7 @@ config BPF_STREAM_PARSER
 	  BPF_MAP_TYPE_SOCKMAP.
 
 config NET_FLOW_LIMIT
-	bool
+	bool "Net flow limit"
 	depends on RPS
 	default y
 	help
-- 
2.37.3


