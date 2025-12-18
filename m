Return-Path: <netdev+bounces-245427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5903DCCD14B
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 19:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6926B30161EF
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9493311963;
	Thu, 18 Dec 2025 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lmg5qzPW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62742FF66B
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080611; cv=none; b=MajZGxp29FIREmi7wkWIpTwick/Ib8wJAja4zGycddBrZtv6G/KDPV2krpB1K/AGMjRnj0P1R52USkmU5r9qAeh6ryojfRX5mD4zPQujSwXX3jsuu2XxNWdf2NSPasHdkzr4TdBEfzGO2NDv/O0zk9iUm5g/qk4SzHCvr3V9K/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080611; c=relaxed/simple;
	bh=exa/YP9fyICJ77EYEDHbnzjy54eXhqjQuSP7ACG5gVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdX1KOsvYRBqSK7SXiAzt6g2DWzqYHzu1pwMO6j6ns13NgMxJJvfcmL+LlaubDmIK7UQe/JPQZhF5bOtaCEJoJ6M5FFcVPpZr6Ps6zR6yrrg9rlH86325bCMhFypRe2Pf8sZEtj1lSOwtnNdTt/yuh2OTld5QowCREouyVVJJcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lmg5qzPW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a099233e8dso9007855ad.3
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080609; x=1766685409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=Lmg5qzPWNdy+3X74kgwy6dIAUNjod6ycKO7PHpu31yrEjhKLTy83jOyIWulobNfCc3
         vxIYU+SwoVtKIMmVDPt9t3DVceOYGOPpuuQ2JPCxr4TdLprbNBNFiiRZIcza+wLjlhN7
         RVYbAp5YwDxRXNQrgiBFiZQOLH35xvH5ElLw0wWs4W0oU3D6sgJIfLNgKLSctTHNQaNL
         iIdmfqVwcVUp6QKyXv0pHOBc/5t+bvCFr9HYscZfA+SmzObgzMIeQRKEz9wIm8ZZG4s2
         tgQHY7fgW5K5vwTzbwcs8CwXENCWeYZg624KobkZa8KWOh5Li7P/YE5rE8xeXorpOY3t
         esLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080609; x=1766685409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=sXtB2mM7yWOt3z/3NVuACKvnumSWQ5JqYG74/0HabycrFXJcOd4yhaXNbMtwulK/Z7
         pIKlGIckdu3eRyPBmGLBG/gZCUFlxYEA3HTz0MnEPWB8KUXXm3H78ohJ8xllxWUZbHqf
         Ta9D47U4FaHozU0EcMxnSAon4nX3BLArrpUsLxhDhkntuFCzc6zcYC/dO+O/cmcueDb8
         QvviCPxKwALn/Z7cW5OAhSxLFUf1BgPlOnyrBc3bHPBYDpWCYkO3MVDIPUPFU/f7Ez5V
         aVDRyCH3zcVjgwEe4cwUg6X8wr6WGMaMhXHzgrGS2zLbYbRGFwaXMQ3OrtC0tQsS0Fh5
         N04g==
X-Gm-Message-State: AOJu0YyzK+ZfZ2vvl+4N8O5AjhiA+/HtiH8xfqM3ta7alfc3ALtk1ZBs
	cZ3OQ5UKItsqIuKZR7Zet2ZxFJG0T08lHCrKy10U9NuJlQm1N6BB/RN8zWwkaw==
X-Gm-Gg: AY/fxX4ckaT3OE7fqRqvHo8nnvgAj/Xm56+jx2RJiP/xqFDir6RElrvb+IkltcyHcD6
	Zsaq0WjWLz+S3rBPl5npIyDS8PntZ2TqW4BECScWBCInqSYeGVWg1pTDIO/SIQXBOOVJwx72d20
	pVBZIqNtUbf5AvxSTOnFFAsQHclY7STDUd4xvZCcPLjqYFGGGf1kf9jmEOFmMMP2qlLzlHRPqaD
	gEHmQ7YDoiYd+0LY2OPxyPBixF97HcdbGEIMRqILT/6oBEDce2dZHwUQnicZjzRDhVV4s0fDc3g
	Zz6Q2qQOAB3gE1EJEhLoQm1JpX4jjgjjFjrqI1jNumascpoF6pC5AR28BzEsh0Ct2SBAbpjJiSh
	zAh1+hIEXIEuybxg3Yd8AaAoN8skWXzWn79raQgBEHz1vZiNjZyKWwz9RBv9yyxlfmAfrweZqNE
	eop9LEBSunIwVh
X-Google-Smtp-Source: AGHT+IEX5gBjqW6w28GPiBH/FtYGs7ySjffOR91L2p+J3IG4qzC5UlZVLnZrrs86GFuZNUn7N4v9Kg==
X-Received: by 2002:a17:903:320e:b0:2a1:360e:53a7 with SMTP id d9443c01a7336-2a2f22229f9mr1244225ad.13.1766080609299;
        Thu, 18 Dec 2025 09:56:49 -0800 (PST)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d193ce63sm31901615ad.91.2025.12.18.09.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:48 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 16/16] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
Date: Thu, 18 Dec 2025 09:56:26 -0800
Message-ID: <20251218175628.1460321-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cgrp_storage_busy has been removed. Use bpf_bprintf_nest_level
instead. This percpu variable is also in the bpf subsystem so that
if it is removed in the future, BPF-CI will catch this type of CI-
breaking change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 10cba526d3e6..f1642794f70e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -875,8 +875,8 @@ static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
 	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_number", int, BTF_F_COMPACT,
 			  "int cpu_number = (int)100", 100);
 #endif
-	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_cgrp_storage_busy", int, BTF_F_COMPACT,
-			  "static int bpf_cgrp_storage_busy = (int)2", 2);
+	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_bprintf_nest_level", int, BTF_F_COMPACT,
+			  "static int bpf_bprintf_nest_level = (int)2", 2);
 }
 
 struct btf_dump_string_ctx {
-- 
2.47.3


