Return-Path: <netdev+bounces-166225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB36A3515C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 23:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF6B3ACACA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D5726B0B2;
	Thu, 13 Feb 2025 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stackhpc-com.20230601.gappssmtp.com header.i=@stackhpc-com.20230601.gappssmtp.com header.b="A2u7Y/t2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9EA28A2BF
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486250; cv=none; b=M5+NOWQw4U2InNnEClFH5gqY0fV4R8aGocSypqNNbgZplabJhpsbaPEEMCiZtKwJSCI8SOuLDGfrSG4aDCQZwlmeOt1qE7KNhVom/ynf+8HPM9WwQELKCOjo/7Ek3/ULde39oLpWRBbobdO2hZxiLZCI7KItJLE5AYnwCGfsdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486250; c=relaxed/simple;
	bh=N/GtVIKbrNKHp7u3+KNILK8UBLBvStnUFI+L8StGAaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AL360OHlAiouuOZWvRKNNsGx4CVABZnuo6hbX2sAcudIbA/Y9+jOENEum4/iLYfBeBul3uTFyE8boWH7x0Se9KbAIzKKaeMJ9MUN2sp9X8NvLaLEZ7imQzkYZRYd2HyYIgNcP4O8c0Fl1hp+O0uns6ERAqxQNgbTZFnmnrN6nKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stackhpc.com; spf=pass smtp.mailfrom=stackhpc.com; dkim=pass (2048-bit key) header.d=stackhpc-com.20230601.gappssmtp.com header.i=@stackhpc-com.20230601.gappssmtp.com header.b=A2u7Y/t2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stackhpc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stackhpc.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7fa1bc957so269394566b.2
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 14:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackhpc-com.20230601.gappssmtp.com; s=20230601; t=1739486246; x=1740091046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ti/+VOCIocKPttQDHr6Em+kigGLsq9eSkNytFJLAUac=;
        b=A2u7Y/t2ehz7os7HGBH+Q6nQGAit08DAsKKfKJfPvjvjZkghmGfap/8zxANq/bwQVf
         Ifgz1Vv5ERg7feko7Tl5UoZbFmy1A42MHQtl6zGfrBYNAsRNqB5gjkLR/AzSRebDQhny
         eEIDgMfkCoyxid3I3+cfJqRB6HcF94JAckewZ2C6y7mi3i7PKdKG6YVtnJpUkaJZlpS7
         wmczJQME7I938POjwRDk5Rc0TF9ZxikN5sS319/v8JfQZ99OL6OdrmwdBb/DRfH+NMXO
         ANFWeoPjRuO8ec9ja/44t+JPFQo34hoALh4ySgci98qCJHCjt1iiheQ+/pGscqBUWZOs
         PnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486246; x=1740091046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ti/+VOCIocKPttQDHr6Em+kigGLsq9eSkNytFJLAUac=;
        b=chmDJ/0k6stdYATuf3aZAqPuBQURWp0j1B0CDVX9YdkaiGEqSNvB7gGbK8nE9LV6DN
         0yGxLW38rjHWsyHX9jA5+QZ29V56nW5BPrcFhM1NoDLxr6EUixyx5rG23+ioU/nKmWG0
         5RA0roiI+fFtWXYvuDyOt/hg8uCDhqoumd9O31TtnHz/yr3CWheq2fZ3LIeSV5s03jHA
         G20ucMwD9BcMg32/iYhcRusyCOvMRN4E3+J0OtUyh9pnLK7iBgSq/3IU5NXki8HhMvGA
         0SzdIR/rBxtVqUIrfiXBbHTDkznfecOEawGtSATWqehggmJdmWuzyvWLwFBAhpZjY2MD
         pb7Q==
X-Gm-Message-State: AOJu0YxsP0gBvILmlgAjFiXaEkxPOLiotL7MHZrzKQilHnMuYKKpX0xE
	tR9Rm+4o32KohSvyBDdS6HhWu36SZzuXw3aXYb494XA9dUUPFWGWq7qp5YkNOQ5D3UgY+QtbrUv
	56q4=
X-Gm-Gg: ASbGncvJu4kcVoibQwYod/xWbk64HAzdDsMRD5J7iYUry2YHxOcWbNBh2N4eRaCtsAW
	pFEvN221ga2Ha/SMOIupJuIb0uTI+uPIYRkjn22df2HHQtE+GEcB+3A76mOm+/IHugmUPibZHBr
	MH55539uyw4wubjTScarryQ8Rz1c5Kx2fQXnS631Umijv+3t8koQtTIc7skpuqISwM4vEcgYD7M
	/lPfEFwIzER50dVZIiE+v1q8fKu3GlniFKSjetnkNW/eQYUWfWXf/b/8wl4xCFGG6oV4ZzJb6Qe
	nb7dC49n2OChBLEBuEqUEnPqEOFPUAyk9PNSn6u6Vw==
X-Google-Smtp-Source: AGHT+IFuBSfVPFLF33nT61zGbV5yd7riktQvhGMwBwbDz01AUO1aLz2R/gLee3Suw5FJfRGW6bPCmA==
X-Received: by 2002:a17:906:c111:b0:ab7:a679:4b00 with SMTP id a640c23a62f3a-aba5017ed23mr494191366b.40.1739486245814;
        Thu, 13 Feb 2025 14:37:25 -0800 (PST)
Received: from pierre-rl9.compute.sms-lab.cloud ([185.45.78.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533c146asm211756866b.178.2025.02.13.14.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:37:25 -0800 (PST)
From: Pierre Riteau <pierre@stackhpc.com>
To: netdev@vger.kernel.org
Cc: Pierre Riteau <pierre@stackhpc.com>
Subject: [PATCH net] net/sched: cls_api: fix error handling causing NULL dereference
Date: Thu, 13 Feb 2025 23:36:10 +0100
Message-ID: <20250213223610.320278-1-pierre@stackhpc.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_exts_miss_cookie_base_alloc() calls xa_alloc_cyclic() which can
return 1 if the allocation succeeded after wrapping. This was treated as
an error, with value 1 returned to caller tcf_exts_init_ex() which sets
exts->actions to NULL and returns 1 to caller fl_change().

fl_change() treats err == 1 as success, calling tcf_exts_validate_ex()
which calls tcf_action_init() with exts->actions as argument, where it
is dereferenced.

Example trace:

BUG: kernel NULL pointer dereference, address: 0000000000000000
CPU: 114 PID: 16151 Comm: handler114 Kdump: loaded Not tainted 5.14.0-503.16.1.el9_5.x86_64 #1
RIP: 0010:tcf_action_init+0x1f8/0x2c0
Call Trace:
 tcf_action_init+0x1f8/0x2c0
 tcf_exts_validate_ex+0x175/0x190
 fl_change+0x537/0x1120 [cls_flower]

Fixes: 80cd22c35c90 ("net/sched: cls_api: Support hardware miss to tc action")
Signed-off-by: Pierre Riteau <pierre@stackhpc.com>
---
 net/sched/cls_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 8e47e5355be6..4f648af8cfaa 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -97,7 +97,7 @@ tcf_exts_miss_cookie_base_alloc(struct tcf_exts *exts, struct tcf_proto *tp,
 
 	err = xa_alloc_cyclic(&tcf_exts_miss_cookies_xa, &n->miss_cookie_base,
 			      n, xa_limit_32b, &next, GFP_KERNEL);
-	if (err)
+	if (err < 0)
 		goto err_xa_alloc;
 
 	exts->miss_cookie_node = n;
-- 
2.43.5


