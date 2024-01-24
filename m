Return-Path: <netdev+bounces-65328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886F839FB2
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 03:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351F01F25668
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 02:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D5217592;
	Wed, 24 Jan 2024 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lBWqawv2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA81755B
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064870; cv=none; b=KP2GU5JcqNKjjKt6Jty6q22AX4i9t/a/ciBidfKE84g9aBTLXbOshiHbfBY0a8o9qt2cyjuHs0YCQ/B2F2IGw/sRAylPhHuvIepMiiU39Na98CJCgsrW67RjjgjnvM/CCpPrdjVQC4AQU9sIexJIszfsr1QWMY3FdweI2890hLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064870; c=relaxed/simple;
	bh=tt8whk6QkKHecHFyCKI/nRn5ZBU9W9pAuOHdt0se2xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cUlYxA4ua4sRBxsukFG0Icr96ctNiZU5+MuQNdcUnLkC8t9v7mA3ihIQBykXkJ6OWIOl77D7+1SNLDLiqFItJ3tPHDcI5yHV76qU/uRqvEEnVErigw7D6Z7Oo01pw+9g0dhdmwh75WIGg8KCGAoEU+UIFYbUR7AAdGArJ/I0VaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lBWqawv2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dd839abbf7so1013311b3a.2
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 18:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706064868; x=1706669668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq2iCmnPB94WcqySTTnm3WLG+4jkf9fY7fGI3ZdGS38=;
        b=lBWqawv255peTQgAaJTSwyWO/xMZ/Z61MJM19Pd72d1GUf3VWxvstprmEAb19wpmr8
         wmpeAZLF4p22jCFQK6n+n9fNscx8QF4vNIr1roD7E3vaUhQQ8QbJ/KpcsSvGScJEkYks
         1eyU/XBZpUoTl2/M0p/WrbPBKtzqwk569zJ0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706064868; x=1706669668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bq2iCmnPB94WcqySTTnm3WLG+4jkf9fY7fGI3ZdGS38=;
        b=ERkrd5aa5VMqhOr9m5ANAZ9U9B5X6qJvkYWQmOSCaUjSSikxP8f0kO6Gau6mggLoOm
         HD8gcMm/0QZl2zmOl/dRZvlVMRYfeKHuVDOJC6CII+feLnaV2v9oKZI4NDwAuu8pB08N
         th2XHYz8fhCSurgj+Y5e5Lsvu+eNl/MUoFV8qBZnfrBEcfZ5M8y1a9Itar4jwNIuziFH
         x4bPsTFeqmZjHPsiDMLwVyyoS+gQduVvkUAmeKigmZlgx2cx4LVhfgzkvLubw2d+je85
         neIxICunzs8+jCxsBfUOaScypV12FfCkxh6bVHhqSd1vB8K8WXH0fTKVRqbHyx15oitS
         0Hww==
X-Gm-Message-State: AOJu0YzMEAABVufb9yPQR5gHWlN+y5f0bml2RmF9SU/6QmymjBkRMmqT
	OE0z2HBiKatWCaI6ywTlquyjKsh4AuRb0hKEuEl8WCAUyM5T+zQHOhtEj6NrUuC2rbgCNJEqVa6
	kaQzHt4OdpDzxKiaqoTdRzMKacivwNpjq25DM8lBr0RmSYi552MlR62TElyUNPgAfqMNIW8UrHm
	EEzASbneBze+ZZS9aWA7SzK52DneK4WgjqqYg=
X-Google-Smtp-Source: AGHT+IGodI8N0Czn5sWE4mbKrdlX6VeLBQ+z79W6omRxv5iM82o7VtlJXdsv7TV9KmnVN9aTE4/aNA==
X-Received: by 2002:a05:6a00:3a09:b0:6db:a0e5:7ec3 with SMTP id fj9-20020a056a003a0900b006dba0e57ec3mr9228809pfb.22.1706064867592;
        Tue, 23 Jan 2024 18:54:27 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id z14-20020a62d10e000000b006d9b38f2e75sm12974229pfg.32.2024.01.23.18.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 18:54:26 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [net-next 2/3] eventpoll: Add per-epoll busy poll packet budget
Date: Wed, 24 Jan 2024 02:53:58 +0000
Message-Id: <20240124025359.11419-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124025359.11419-1-jdamato@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using epoll-based busy poll, the packet budget is hardcoded to
BUSY_POLL_BUDGET (8).

Add support for a per-epoll context busy poll packet budget. If not
specified, the default value (BUSY_POLL_BUDGET) is used.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/eventpoll.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4503fec01278..40bd97477b91 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -229,6 +229,8 @@ struct eventpoll {
 	unsigned int napi_id;
 	/* busy poll timeout */
 	u64 busy_poll_usecs;
+	/* busy poll packet budget */
+	u16 busy_poll_budget;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -437,10 +439,14 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
 static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
+	u16 budget = READ_ONCE(ep->busy_poll_budget);
+
+	if (!budget)
+		budget = BUSY_POLL_BUDGET;
 
 	if ((napi_id >= MIN_NAPI_ID) && ep_busy_loop_on(ep)) {
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
-			       BUSY_POLL_BUDGET);
+			       budget);
 		if (ep_events_available(ep))
 			return true;
 		/*
@@ -2098,6 +2104,7 @@ static int do_epoll_create(int flags)
 	}
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ep->busy_poll_usecs = 0;
+	ep->busy_poll_budget = 0;
 #endif
 	ep->file = file;
 	fd_install(fd, file);
-- 
2.25.1


