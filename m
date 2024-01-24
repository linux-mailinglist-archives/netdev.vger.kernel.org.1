Return-Path: <netdev+bounces-65502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BA683AD72
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3847A1F21F71
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0697C0A3;
	Wed, 24 Jan 2024 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AZLbZ93v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17FC7C08B
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110508; cv=none; b=mg2VTCV1fpgy+ZJ7rAogukk6tuO+wlhKwiB2FyCrk0+Dg8w+89aMk0NnOKKpjWXACUPUBQW2qBfMyNGfFx+uoyl9nhZ9i1nWeCtR7Vcq5Qm9zfFFLWxv1NQs+0QZyo+pt3uGPrd9/sF7lzL/tzEZs7RF5yOuYuDN+J2zcHh57xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110508; c=relaxed/simple;
	bh=9HIfTQpLD4fua4isfUO3HP8HOHgh/oO46rw99VvqGu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIpHHVioEAVSXUGjR0YdJc0VIOurC3HO56uWZvckBHex9+/3KlbRFFLTVrWstzjurMu0JTe9nhQQZZzSh2XLI3OabRNC+KdSc5bOqbl5Dj6olsd9e1uyQVXgs7YOwhmCw7DodZsg5II5veqBs0nE7jZJWjNVx9nK1B+tvuQTWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AZLbZ93v; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d76671e5a4so20515485ad.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 07:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706110506; x=1706715306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DclYFdg38kKK4gZosJfKozj+uLWfYpEqHI9SwMjHpvA=;
        b=AZLbZ93vxEZHozQMa2kVC48efjEZ+bABWPwJjPOces71u/xCG4AqdSV90nEpn+DwJu
         6qz4Qqv1Xjw6M2TIEfWjSGdekA5pvlDnLW/2zB9rY7VbfrBS/wMGQ2wMe7YEjji9m3VD
         Oxc/wBNoHvjGsNaLd+srVMI2b21j1kqT7tKbs2Wpy3ZyzMc1K1PC2qgv5Ata8iXvQGKL
         jVAXtNDNlsFVvT4LD6hfvdmRs7fSAn2Fvk/I8QTYrGHJm4TRSXC7zb+Pa6Ojvcf0OETf
         uIOmmrwkLdpclQw3iG4djMjv6ftko0CGoyOQdkOqaf/MiwfgEc7ou+OMwow+EmLkA/5t
         G9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110506; x=1706715306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DclYFdg38kKK4gZosJfKozj+uLWfYpEqHI9SwMjHpvA=;
        b=gCvkc7FNruO6j4P5rwY3cOfksYVXbf/FTU+WqTW3rkc3XXlMIdVqVEOjvv868Z9Jsr
         cz6NXZqMJsaVpJo48gO0+UeIGFM/9DAqOEvfa3rkRUIKqhSWR0hMlK7MVts9mcMhVRvt
         bDtLtIeGC/D/KOZ6O5l9j0qaIEyzjTJ77W6SD0GUGG3jIGEDiuvf+kgxPtYZsHHWUWeu
         tEFBUlGwLvjVSJe+K4QdGLR6iyv0llaqghtMXCHgGxqDOFKKsabZQi3kIehXJTiFqecz
         0BzzAww3rSdeAnvpDkJ8/AYM/SzbpKanAAaK4RcfSb+Uz1K9RdKqp6u9g3pRdyuhMJZY
         WQJQ==
X-Gm-Message-State: AOJu0YwSmXXAEE5pT6c9oHZIDSt1QwZ1hylEzLA0M6O2/nEJv6wH67He
	sjjZQiu7Qy1W60/plV3tC+9+SDExXtrtfEzR7EplGzEd9LIXC9ZhXm6Awr3gbQ==
X-Google-Smtp-Source: AGHT+IGvC8WSTIirzl2B6ZMhWxS/q7uc5Om1FcLxc4zZJwZE6Y/r9NNoXsl+ujD+/jr/Cg2Ag7qYVQ==
X-Received: by 2002:a17:902:ce89:b0:1d5:636:2f9f with SMTP id f9-20020a170902ce8900b001d506362f9fmr1180198plg.25.1706110506324;
        Wed, 24 Jan 2024 07:35:06 -0800 (PST)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c1:7b01:4fb3:24d0:ad57:53c9])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170903284600b001d7284b9461sm7824837plb.128.2024.01.24.07.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:35:06 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org
Cc: liuhangbin@gmail.com,
	jhs@mojatatu.com,
	kernel@mojatatu.com
Subject: [PATCH iproute2-next 2/2] tc: Add NLM_F_ECHO support for filters
Date: Wed, 24 Jan 2024 12:34:56 -0300
Message-ID: <20240124153456.117048-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124153456.117048-1-victor@mojatatu.com>
References: <20240124153456.117048-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the user specifies this flag for a filter command the kernel will
return the command's result back to user space.
For example:

  tc -echo filter add dev lo parent ffff: protocol ip matchall action ok

  added filter dev lo parent ffff: protocol ip pref 49152 matchall chain 0

As illustrated above, the kernel will give us a pref of 491252

The same can be done for other filter commands (replace, delete, and
change). For example:

  tc -echo filter del dev lo parent ffff: pref 49152 protocol ip matchall

  deleted filter dev lo parent ffff: protocol ip pref 49152 matchall chain 0

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 tc/tc_filter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tc/tc_filter.c b/tc/tc_filter.c
index eb45c5887..54790ddc6 100644
--- a/tc/tc_filter.c
+++ b/tc/tc_filter.c
@@ -76,6 +76,7 @@ static int tc_filter_modify(int cmd, unsigned int flags, int argc, char **argv)
 	char  d[IFNAMSIZ] = {};
 	char  k[FILTER_NAMESZ] = {};
 	struct tc_estimator est = {};
+	int ret;
 
 	if (cmd == RTM_NEWTFILTER && flags & NLM_F_CREATE)
 		protocol = htons(ETH_P_ALL);
@@ -221,7 +222,12 @@ static int tc_filter_modify(int cmd, unsigned int flags, int argc, char **argv)
 	if (est.ewma_log)
 		addattr_l(&req.n, sizeof(req), TCA_RATE, &est, sizeof(est));
 
-	if (rtnl_talk(&rth, &req.n, NULL) < 0) {
+	if (echo_request)
+		ret = rtnl_echo_talk(&rth, &req.n, json, print_filter);
+	else
+		ret = rtnl_talk(&rth, &req.n, NULL);
+
+	if (ret < 0) {
 		fprintf(stderr, "We have an error talking to the kernel\n");
 		return 2;
 	}
-- 
2.25.1


