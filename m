Return-Path: <netdev+bounces-99272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C275B8D442A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F53286869
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDE354FB1;
	Thu, 30 May 2024 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqqrp33P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAFD5647B
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039700; cv=none; b=soyl2fs2J804NA99Gr0cZNQrb+oaG6v6agcFC1YYlBsn8WEj4R0j1xIlAkDyL/cqJzMAjmDnAq+iG643Xj1kHXgYHisBKz15H0TffrOYqbDA6P+Mj/RST69c/EkOAqXBl9KtA4FSeRTEArLEEsu00gIWgT7k1+bczFWDppABid8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039700; c=relaxed/simple;
	bh=cvXcMx9l++AOxS1bUlBF9OE0JuWh1P9WQPBfXgd6rgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ttzRiXiBFPCRgCMBrWSU8nn4twl40azAWUflgAWNG8oij8EWAKYZnMTVsTFW9S3HIf9un74geJ3cafHHi9R0iFj5BX0g6FnijZDY6hk4EooQv7+2I//0KZbSKfFORJIWT6PTerJR/MD/YzyKdpHvXEUxV7lhTldYDcKBn47auUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iqqrp33P; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70231566377so254454b3a.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 20:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717039698; x=1717644498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AcIS2DB3SRfxRMB+nZJAOQPaZWEf+4JritcBFBDshKs=;
        b=Iqqrp33PhJzStzGt532KNiTZkOTdKHCXyltNQZMsjo8uCSwplyNYJOuMVm/ZR5FEVb
         0rs3+g6+c3aA3wnX6Ea1FB9DBnB+sAMJABH1Z/RG9ZwaWE3xwrBNuMypSZPM4MpK9Hu3
         CXtG7ymUGR26cRxMNMYijicmjh6/oW1iBSttDvo9cx5ABIRhZlPeD1IOSI52rToBfOup
         162o3aJ57oDAapZL57PrJ0yczH0aLdGv8+rgNmQPfUGyrI2GAWzjArPMI8x/bdDj4ljR
         2PadiPrXB7CS7ULlquwQoOjbkPnDpNt/oq5x/+5U8Qq0xkvtKVCC56xUtL3KP1JOxcJ3
         ebGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039698; x=1717644498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcIS2DB3SRfxRMB+nZJAOQPaZWEf+4JritcBFBDshKs=;
        b=urHk5VmaVT4qUuqyl1ItWK8FTeuI8bpQfiBjhOebzlnNYTv6NLuiqLIjz3qwGXWfcQ
         PMRGWBV5HRFWFVcHeYB0xcsysHDQAEa+yvyZNB9RXgfYSkUihIPHZ+10LpaURTStdacQ
         PQU54R8AL9Nw/qiF2MjYsTsI6jlUwBSy8R4ZiXYwPjv6ICcEvRQWFgxcqcs6kAStlqaJ
         J5gzKMNhj3pjdDhSHONlYbGP9UcIx8M0l1hoHSHMQsIu8FdAaMnYWAoJ8ksrvJ8SgAN0
         lEA8ULiVM0JCs+Iq/4frWo6tFKZwyECjUnk0KTgX8LphtkKm5cJZOB0IGiJ297LWHa81
         iWJQ==
X-Gm-Message-State: AOJu0Yy/X/EZ2CjSNiFX07Mn7U6IQcGVqFBMrYnHNGMBg2lsbtKhe1jH
	LG4dUqtKG+brCWHqwXX7K1S68o7ewXo+HkXawfn7UA/NhlmWQ4YB
X-Google-Smtp-Source: AGHT+IFxnUj+yf7nDjSft2jWxq5ov9nDjf9e5sIHeYYvEetjc1vD2FqC+BmCmDlOgmzet0gFcvCNBw==
X-Received: by 2002:a05:6a20:9192:b0:1af:b0be:4661 with SMTP id adf61e73a8af0-1b26454b0b3mr1042054637.19.1717039697818;
        Wed, 29 May 2024 20:28:17 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a77a1eb2sm595027a91.51.2024.05.29.20.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 20:28:17 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>,
	John Sperbeck <jsperbeck@google.com>
Subject: [PATCH net] net: rps: fix error when CONFIG_RFS_ACCEL is off
Date: Thu, 30 May 2024 11:27:17 +0800
Message-Id: <20240530032717.57787-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

John Sperbeck reported that if we turn off CONFIG_RFS_ACCEL, the 'head'
is not defined, which will trigger compile error. So I move the 'head'
out of the CONFIG_RFS_ACCEL scope.

Fixes: 84b6823cd96b ("net: rps: protect last_qtail with rps_input_queue_tail_save() helper")
Reported-by: John Sperbeck <jsperbeck@google.com>
Closes: https://lore.kernel.org/all/20240529203421.2432481-1-jsperbeck@google.com/
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 85fe8138f3e4..e62698c7a0e6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4516,12 +4516,13 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	    struct rps_dev_flow *rflow, u16 next_cpu)
 {
 	if (next_cpu < nr_cpu_ids) {
+		u32 head;
 #ifdef CONFIG_RFS_ACCEL
 		struct netdev_rx_queue *rxqueue;
 		struct rps_dev_flow_table *flow_table;
 		struct rps_dev_flow *old_rflow;
-		u32 flow_id, head;
 		u16 rxq_index;
+		u32 flow_id;
 		int rc;
 
 		/* Should we steer this flow to a different hardware queue? */
-- 
2.37.3


