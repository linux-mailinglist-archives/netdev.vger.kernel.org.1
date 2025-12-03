Return-Path: <netdev+bounces-243352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D763DC9D8EC
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 03:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9037C3A896D
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 02:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA7322FE0E;
	Wed,  3 Dec 2025 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKwmJMTB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6079B22A4FC
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764727891; cv=none; b=gcwWiArfW+5RnrrcIpAeEVUpNAFCxi7Kacsw1ZdcX2RxIg8EKdwdj7D0XjRsMbS4hk4PpzqbdN3/Vx3TRn5Oxx59AiRPGZfoI7PNpRdrEi6Ntos05JQVUda2th5K4q7ngSkFD5YDkxi6SSSdmnxCB/zWjXuApBetRhVP47v3xcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764727891; c=relaxed/simple;
	bh=RT+BDj15EQHdd3M1qICzSCuoLzYhQ2rx+LzW6G7jhjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J5iZNhRYZX2ADlNF5AwlSyBWRZaSIcDVflSl29x6F4rVEaVbYVA7Fmsw+09Fs5aEEeaTmAPwJ3PC2oStsuXWTiQ9wpIWI50omhojJvEIPQl1BY7nznE2E1TNlTEVFf2PblHXMGt/UrxpjBjJ6cVoilttshgbHNxMBltHW1s4bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKwmJMTB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bdb6f9561f9so5584687a12.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 18:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764727889; x=1765332689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SrshDHaC0MNLolr0re5e//KpT3feCFpyouwfUOnJ0fk=;
        b=RKwmJMTB8mssqNc0kS3mTPbWVr8u1v4XZ+Hz0YeKkknI+x+bzcdA/vfVjZSk+PwciI
         caM3zUNeJaWQ7majHmfEbiYzMK774dL1Qmhk6EApatrEEN4WVLmI7tA/a9xzHozp+weU
         NAEm76GnrnOlIKDEKGX2OLLbcPrQlKZVzdYtfncbf96+PxMUjtiTewnLDFBDTTaIakyK
         5ZGuKFOApq3XhtbLO+kpeWv0cML/KLryHuBzqIn3jINUDmjfLakkvKY/Ad7iq2ABiXqf
         qJM1WGX/8lA5LuoS957t/PpV8B6BMucKrhIUHuG0wCPR4MU6Mo/LLG0VFbnn60vWkcDR
         Vn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764727889; x=1765332689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrshDHaC0MNLolr0re5e//KpT3feCFpyouwfUOnJ0fk=;
        b=hITcePdmn5thk+2eid92QjvwNuCpXulIRTljYEeLOY4Jd4XiHj87DNkqW5D/TiDIqi
         BZiMcTxX6dFtdZ5JtZTDX6OfiyKhVRiJ2g7Azz6gKncTEg0CWBntHdfk8R84CQm6JY6C
         UR8NdnsKOjsW85xpYfLtUJAW5XXP24thJXS+WEeXasLx6GV2GVCEQBcmsaL8OyhUHjh/
         IMoBhbPTDGio1uC+KcHkr+T9Dmsx1zOJQpZrOkPjraARCl2PiFkpwKc+Gb+phYTmBpnX
         9EqOjdF8c9A9u7HqdX/wAFf191g4cdXk9ABQKtgCGDkyxvQ3y3ucNmozwAybAkXVu/VZ
         WN1w==
X-Gm-Message-State: AOJu0Yxkbu3uTY7ASMh081h1p2iHaWc2WK6cWFN16GyRWTAgBeLdN2Vl
	8es1SoOXnbFPbLL27mIcmZfDTPiZ8g5qj46r+/l/TRhNAczm5Vo5EFb4+ajNgA==
X-Gm-Gg: ASbGncsBJjHQ97CFL9nkewHjE7nmhTkFWFpnT0fU31YQTtni1MGoLpZ/dlOvQDzwh/v
	ibPVri46GalQMV3/G8cIgvuXHXEWp/xWhuEsO3ps5C+DEktKyRRCgiR6q6rY6JcZDJ4bsjta1CF
	gk366GO1v0QzSMvGFIqFQbIATHPArAyvMA36dFYMYFuCCBxW/KpygVOJ2wCYixbiGvptPhELZCN
	5SH3O0iTc/Ml6jiUOKqrCJfa+/4xc98lCgvcTfZNnJRcAyyOU1v6qb2sePEb27j+VcAXYIODaMo
	+43TBxzeiIJyHx5r4KOlTArWz9ZvpFV+jRde9JoZC1RHjRAC0R601bIU0JlPRDO1uxeTJpFv8If
	4Cs1K2z+WYHm5rPjGRdSZvDUvG1oEsJ3a9BFqOLT1G/89HuZiIJ0cPRXubsq7ieppVaIQhsVyvB
	/AC+0IAgDegjYajMuGLYC/A/F/Jr+ap280b/NX0NmRv93CFIPYoK2N34yuBdn6/I8BhyCdaYmFB
	qcB1rscF9colKmEmiC7a6cHOu0cJw==
X-Google-Smtp-Source: AGHT+IHrDhdqPrcTTPMS016c0PoyhnyaRNq/OscPs8JcF7CqzUwsu6nSob+K1zCB2vo0lPY69SA3EA==
X-Received: by 2002:a05:7300:7a8e:b0:2a4:3593:9695 with SMTP id 5a478bee46e88-2ab92e099afmr383225eec.18.1764727889285;
        Tue, 02 Dec 2025 18:11:29 -0800 (PST)
Received: from localhost.localdomain (ip72-203-121-181.oc.oc.cox.net. [72.203.121.181])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a9653ca11esm59543997eec.0.2025.12.02.18.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 18:11:28 -0800 (PST)
From: Akhilesh Nema <nemaakhilesh@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	Akhilesh Nema <nemaakhilesh@gmail.com>
Subject: [PATCH iproute2 1/1] lib,tc: Fix 'UINT_MAX' undeclared error observed during the build with musl libc
Date: Tue,  2 Dec 2025 18:11:24 -0800
Message-Id: <20251203021124.17535-1-nemaakhilesh@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- utils_math.c:136:20: error: 'UINT_MAX' undeclared (first use in this function)
- tc_core.c:51:22: error: 'UINT_MAX' undeclared (first use in this function)

Signed-off-by: Akhilesh Nema <nemaakhilesh@gmail.com>
---
 lib/utils_math.c | 1 +
 tc/tc_core.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/utils_math.c b/lib/utils_math.c
index a7e74744..fd2ddc7c 100644
--- a/lib/utils_math.c
+++ b/lib/utils_math.c
@@ -4,6 +4,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <math.h>
+#include <limits.h>
 #include <asm/types.h>
 
 #include "utils.h"
diff --git a/tc/tc_core.c b/tc/tc_core.c
index a422e02c..b13b7d78 100644
--- a/tc/tc_core.c
+++ b/tc/tc_core.c
@@ -11,6 +11,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <math.h>
+#include <limits.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
-- 
2.25.1


