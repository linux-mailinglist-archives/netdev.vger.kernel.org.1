Return-Path: <netdev+bounces-183677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C06A9182E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F055460C12
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F65A226CFD;
	Thu, 17 Apr 2025 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU4FMxi9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C322578D;
	Thu, 17 Apr 2025 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744882921; cv=none; b=VTW8cauHKbxiwmUDtpd2W9PHnYixitxZD072PZxcquAS60bd+bO8LHgVX2V8OcNS5gK4ZhqbLJfhfoYb/3TbCk1mp1IoGryA50LjSQBFBWqlWvKmtJlFnUUMFDlIgYFEScFlAhGA2oMRMQc3yYtJtIA0UZbsOxzFG8KvhXp8LSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744882921; c=relaxed/simple;
	bh=Axgrubfzs/zW1JzbQxcbdZH/LwxzFYFWlRzlzPZlvBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ba2Lj7AEEC2SHtXGPSjSkmi0vtlf2lNG7ct40xMtYtS1kuh+4Bk3qdJwWqBr8LA9QVhPUBZ3FCozktVo1U5T0PdcZNW7dRiSvmRv2nXexRgFnQfETjVQF3D8BHFWtRDQAvmVHaLyxio0SMmV9CQEvnioG/JugeWNTN4TBqcO3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CU4FMxi9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3031354f134so376167a91.3;
        Thu, 17 Apr 2025 02:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744882919; x=1745487719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uvSKpQg6AqCSchkTbefy7r55u9161g23HpSQe+CAo3g=;
        b=CU4FMxi9HgnUMPZolSAAX+Nkh9wF7tX1BV8F+S/tv0BKlcMmOlM67QVIRoKWNuxB9+
         KIxGlFAgvS3jxmMhO+yJTG0Qnvu7XnrDyA4zMdzH2hryntXOkY/HwhxLYdqvpvdHQKOT
         PJ8EMVhQ3Avi5cENPBghSho7b8AZSW6s7v53gFrA/AUw5q87kzU9QRihgqmuIn/oDwE9
         /uXNW9JkOApss+8UvwTM1EmzqMp1SRwtCBXsADqzT9aYrswU3bX+VjnN5k659PYWHxtN
         6qu+AfV+VKvNDbeUZFfZzV/NU/+pr/PtAyChA4u5v2PWL4IRO7s4+NMJob/H+uof2327
         eWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744882919; x=1745487719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvSKpQg6AqCSchkTbefy7r55u9161g23HpSQe+CAo3g=;
        b=Iqy1aK1rx4n7HPC3+j2Ow53dScoTpNJZIllHO1QH3sI+hE4aS0DnrZXP2j+z3eKKn5
         W/8rFwSzfb6wpOMrCXV+Q65qxndxRUQuEOI60U7863uPJAnuhe6nX8vfbVvhBeHrB+WG
         hFQ90ZsYbL9Qdi1ol95JEfyJE84OBqkw++H4i1e4PCTLzDNppG2OhZYWIZyapXycbXkL
         cvDRMB4iIdmciDUwsdsvGcDhXaN8WnxnycBSHd1BU9Wj1YhL51bYKCbm9UWkqKxOCuVD
         HrZEz1jZ/bSP8jx/jj6gYlpdmFYwsyxJ0uVX1/JYU1s5ebZG04KCoYY60xN38qIy0vek
         l1Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUw1PLLc39vme/yqgB1+E6yD6bz3En/mvmqz2nrWIBNG/zC3BW6n0ubKEwq8HO9J0bCEnY1YY9O@vger.kernel.org, AJvYcCXGWUaKhp7RFqlcXi4EFugY3FjI8dfpuQMM8+fXhTcu5kfvEom0G0MGW0TfJKxmV+WP0Cgty5+lBkz+lic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6jmpOMr8R8nTZKvt1tgKuRfsNOGM2yFB5Pwodp9L0A8dIgTuR
	IdwA+fW5JAa2+wIfZ9qMgG0zlXsv/seaSLvPFZTZmr3PQ+JDkw6h
X-Gm-Gg: ASbGncv1gjnCB2SnWJxGpn9gIKqLEVbf5esjK/reAI8ylqB/JhsIvlPu2Js7vxSBifF
	nNm/MlgOTcb/FSPpNWoEqYYj3xmA/5nWcdt2sbb9yE52UzX45rqcAOvweyLBoNa/t37Eyk+f722
	7MHEp+NmL2zht82lxaG4zMcSSZek9tTmqCS9PdAQzFvYz61Coi+KzlG0DpSLOCiKrhaIy2kyr81
	XNCHwzgbTM1cfgvdDHtOypkChtDoek/pIATENgJar262ai4jRn0phAi/7gJmZ3111ROuNjXs8k9
	LCoR7UtJXw0bJj9c/CpwsBpCH2lDgma2/V/kveU/ntnbvtjzREBibUWb3zO6Mmjv7QfvAIo=
X-Google-Smtp-Source: AGHT+IHN4Aib5jeb5YC+42bbXiYICwbu3kOvFQE/yidpu5XKQfNjROjzmQPdpx66cwYL1NBoTjfbgQ==
X-Received: by 2002:a17:90b:50c8:b0:2ff:698d:ef74 with SMTP id 98e67ed59e1d1-3086415c614mr6361358a91.26.1744882919154;
        Thu, 17 Apr 2025 02:41:59 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308613638d9sm3186267a91.42.2025.04.17.02.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 02:41:58 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] net: ipv4: Fix uninitialized pointer warning in fnhe_remove_oldest
Date: Thu, 17 Apr 2025 15:11:26 +0530
Message-Id: <20250417094126.34352-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected issue:
net/ipv4/route.c:605 fnhe_remove_oldest() error:
uninitialized symbol 'oldest_p'.

Initialize oldest_p to NULL to avoid uninitialized pointer warning in
fnhe_remove_oldest.

Check that oldest_p is not NULL after the loop to ensure no dereferencing
of uninitialized pointers.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 net/ipv4/route.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 753704f75b2c..2e5159127cb9 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -587,7 +587,7 @@ static void fnhe_flush_routes(struct fib_nh_exception *fnhe)
 
 static void fnhe_remove_oldest(struct fnhe_hash_bucket *hash)
 {
-	struct fib_nh_exception __rcu **fnhe_p, **oldest_p;
+	struct fib_nh_exception __rcu **fnhe_p, **oldest_p = NULL;
 	struct fib_nh_exception *fnhe, *oldest = NULL;
 
 	for (fnhe_p = &hash->chain; ; fnhe_p = &fnhe->fnhe_next) {
@@ -601,9 +601,12 @@ static void fnhe_remove_oldest(struct fnhe_hash_bucket *hash)
 			oldest_p = fnhe_p;
 		}
 	}
-	fnhe_flush_routes(oldest);
-	*oldest_p = oldest->fnhe_next;
-	kfree_rcu(oldest, rcu);
+
+	if (oldest_p) {  /* Ensure to have valid oldest_p element */
+		fnhe_flush_routes(oldest);
+		*oldest_p = oldest->fnhe_next;
+		kfree_rcu(oldest, rcu);
+	}
 }
 
 static u32 fnhe_hashfun(__be32 daddr)
-- 
2.34.1


