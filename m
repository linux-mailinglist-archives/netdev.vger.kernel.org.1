Return-Path: <netdev+bounces-192163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E68B4ABEBA9
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319F31BA5DA0
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977DD230BC3;
	Wed, 21 May 2025 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hprMeYK3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849B22B8D5
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747807568; cv=none; b=XmyLLUUdxB60xxy73Mz7dSD1jtnDQInI/eHEgBMS6gpPeVudMxH5I4zoUuUHDklzaf8aR9kwp/CF8HM2DbZoGU27jqs64wNAKLbEXScajk/SqnDS3zdydfogFCRI9GWNCZcD0HAa6Yzbs6AkiuoNECoiGAXPCPH8Ds0ABA5pOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747807568; c=relaxed/simple;
	bh=fVZU6+8OvVRtAbmS7naLfkmlH9HFvAXAOKFK3R83awI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZ9dHpH/fCwUinTV4q3THa96ShKB3u7KLD+yhuITYGkqfYJWKJlhkw0id5jk18eGeoCn7uB3wvAziDeMFSBatjab8LrhUUwahzSZ8qFXHsnrYBIR1sng/bcmAr0ltxiLA67WNobzrlYCi3IurXbIpzmmbISirtqvFQ1Onga/Bn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hprMeYK3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso8044429b3a.2
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 23:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747807566; x=1748412366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iCVDly0IxOzISeZOCLN5D4tPXfLcRItbXp8G989jII=;
        b=hprMeYK3Y8FCuDXSy8CKBRcIf93qb2VcjWGn7UKSDLmhc6n5WI9/pXPnZ6emzL9TRS
         JG/kefu/qAfbeFmr/tz8+fevxA65dmq+gUmeVRtKXix0Mo1JrhqhcDyyDNEeBnKib0qM
         yh4beyLzbTAjgvYqlFbqiUfyDZOI5Jd95X6Jka3agHqhCnbm7JcrOJovzDzHtGYW3omI
         MwmkwYSLcmEk5pHORbd0mONiMgidbLZ4nJvaa7tdJTjnQK+2DoQwimqNGxS5ijP38veD
         oXOCsYEq87RsPqHqB04KdnHeKOpfTUwei092Q4Mm4cppUphbzVaY5I/MKAUxc2ujkkbI
         Co0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747807566; x=1748412366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iCVDly0IxOzISeZOCLN5D4tPXfLcRItbXp8G989jII=;
        b=ct6YPZYGzKP0cAvtIvj/tvGdUhy/8Cqp0/F3WOU5i9eU6yGhNzvqBU8WkwGjLvm97k
         dqNKhLk7PfaFAT1S3EFxNhTzwpR6nWs9mrrK/SIc82n3P069ud2JyPs0ntAcaCaDXBbi
         6FHI30i4d9ptaI3FK8z47t6kd7lUpkXnKkeHlTx7IKwUZGk2UckxcjsJvvAeYKb6Ssk7
         diihEljzaAF/Ztm56ObJXjrXYSviJpHfa0r1ASrd+1ItZ/IdrYDqDj7VEuQ4oysdNGn8
         yrwhCRyfGi9q2xFjJywEiIzCG7J0AViSYkbpd+fcw4CCj9c7Jxm3K0HU35RKL2BpawrN
         f+Vw==
X-Gm-Message-State: AOJu0YwjeBidCo3H8tGtqZlFaq7mBclonfteS9z/PTBV5BZFxM7t7yLh
	hIM57cxkASReI4ujWyV+t/UwVJx+ZkhEb7XOVI7QV+8HVrp1Du0Eksned2I0pORW
X-Gm-Gg: ASbGncvFbWC9n3aVpJEUMA7Jtv2+WZi459P6bF6sBCc/e0tBg1NTOPBJjPWSeovXkif
	ywZKLwi5+j5laWd1//bn+6ugaBW1w0wyvg2ADVS3Swccro32XN7aLmnhM0y8VerW9IN6Kp9lmOC
	OU0jlvWs38h56UL/x/ryjDqDKmdS/gOfhVRrIDBuF7cQ4udX9dbxLJJYUeCmQlDoQ1mZ32oldx6
	S9tAoDYMHZc3OfHi9SUDAfOc9vSuzdxtQELdqkIO5Oog//HiHh+bEalX7tIudtKNh2rXKT8dcem
	cp0GS55yWcNA9sxdSkqudb4b8d3e8upqbmU/hsbpci92SjdDJX+u2S0P997+qiHFu5o=
X-Google-Smtp-Source: AGHT+IHsr41lbyz2j6zq16oMSStIPlqNtOtQ2NJd/Sh63guWpizffZv2Hmwce8X2Ri+VV0UjVcZBWA==
X-Received: by 2002:a05:6a00:c86:b0:740:9e87:9625 with SMTP id d2e1a72fcca58-742acc8ff71mr27317799b3a.4.1747807565644;
        Tue, 20 May 2025 23:06:05 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a229esm8848936b3a.161.2025.05.20.23.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 23:06:05 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: netdev@vger.kernel.org
Cc: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH v3] net: rds: Replace strncpy with strscpy in connection setup
Date: Wed, 21 May 2025 11:35:57 +0530
Message-Id: <20250521060557.3099412-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430181657.GW3339421@horms.kernel.org>
References: <20250430181657.GW3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaces strncpy() with strscpy_pad() for copying the transport field.
Unlike strscpy(), strscpy_pad() ensures the destination buffer is fully padded with null bytes, avoiding garbage data.
This is safer for struct copies and comparisons. As strncpy() is deprecated (see: kernel.org/doc/html/latest/process/deprecated.html#strcpy),
this change improves correctness and adheres to kernel guidelines for safe, bounded string handling.

Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 net/rds/connection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index c749c5525b40..fb2f14a1279a 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -749,7 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo->laddr = conn->c_laddr.s6_addr32[3];
 	cinfo->faddr = conn->c_faddr.s6_addr32[3];
 	cinfo->tos = conn->c_tos;
-	strncpy(cinfo->transport, conn->c_trans->t_name,
+	strscpy(cinfo->transport, conn->c_trans->t_name,
 		sizeof(cinfo->transport));
 	cinfo->flags = 0;
 
@@ -775,7 +775,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo6->next_rx_seq = cp->cp_next_rx_seq;
 	cinfo6->laddr = conn->c_laddr;
 	cinfo6->faddr = conn->c_faddr;
-	strncpy(cinfo6->transport, conn->c_trans->t_name,
+	strscpy(cinfo6->transport, conn->c_trans->t_name,
 		sizeof(cinfo6->transport));
 	cinfo6->flags = 0;
 
-- 
2.34.1


