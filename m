Return-Path: <netdev+bounces-119984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB990957C3F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 06:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DF41C23CD1
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 04:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FD91459F6;
	Tue, 20 Aug 2024 04:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czFbGotx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7661FD7;
	Tue, 20 Aug 2024 04:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724126953; cv=none; b=fAZfczGybkLutOb1haeaCCikc82/fQq/eM8/MV3m0n+UmmzAAUWyp4bbCvsxewY0apWirhm4EutBGMdx2s1SpCmnHngWJAY29Afz/MVrv1FgdzykApdTPOoTb759HE0F6K1UnjTUGcTUnj1+5E1PB3c+9fVi7NWst6N++fqB3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724126953; c=relaxed/simple;
	bh=liI0lPS/VOlwLeNGo34KdmRPUfwYpXaRm4y0I446ccw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSc8pWh8hezZ/dEJ/Qg3H0KnX/pOP7nifAqWKecbYBh90Eiia/xis/wzY3Tb+sghmu66Ef6Fg+ujUOkD+EVg2CEt6zG3rZ/nRSirJRZgqMzmkxsxiN0znkDpGwE8qw636DMiopuTSV67s632jgVbyguk2yTK0nXhYdDcqphEqIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czFbGotx; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a264a24ea7so3747078a12.3;
        Mon, 19 Aug 2024 21:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724126951; x=1724731751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paDt3+snKheW0hTbgqIvLcV2+jGv0GbAWHframJxjhg=;
        b=czFbGotxTRUlC2TOmHAJHhW2B1Cy38q8kEasn3KVAvDtXLNZlpW2W4Snejps57MSm5
         rofN6cd7yr3ON2DvxG/Wr+IJKblDh44BNJexXjBFwptIKE3xvnN5Cg7VZxTx0K5H373O
         AWXQjHvx75AI5pb+eWfhqAvreLA9zbQOGE5xBsTHCYwKkltgQSnF31vn6Rtgpgvah4NY
         D2no+rdUFZxH5VrPpWd0+X4Gn9RjdQVGOmWlskW4tCW2EUNaRZ9QpzM1RS0/8Ov34gKH
         UjDqnCL5I2sq6avK1GtKMNE2aGzdTL2EnDkO7AKfGZv+ynERDTsKbGSdJf1fbRXe6WJG
         WzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724126951; x=1724731751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paDt3+snKheW0hTbgqIvLcV2+jGv0GbAWHframJxjhg=;
        b=eN9yBvA50Dc9xob7EbDdnk8GqBmHUhOmgA4hKUpE7TEZ3XdOVAHs42M7gGUXx9Ag7/
         4ke8f6qLXBrmpn4drbwEQEp2LQumxY1yYHwo+gahJVDpzTOGlNNxUb3lRMtGCxzyITt2
         XrOa7XhusZw4fx7FTxFGOZS9cYAKJGIe1uDoapjAT4CUoQrnD8QGRG2C92R5ytzFJIT9
         EXUS949pUiRYt1550ienObsTMA/1310FNNpgKcxSzq+QI0/6S+TToJXkg2jpXPPD2DES
         XcjH7+YjM4jqlfYNR6yLCGxE1H0JxnVN94+6WJt96P9e/N2DiFoK4qdDMUL/6zqvw98f
         +EQg==
X-Forwarded-Encrypted: i=1; AJvYcCUwLAn+KpDCJw0f0qLuDzIAMHVg9Ev/fU/+HlJzsIJ7CXLwQkCTj4mcXm8pmQKjOn53Nu7wI5IILQxEsZI/3OG9wimvDBZDiakeBXJwAgv5lhiOxJZgAc3XIwOXDsN4Pn9ECloIYIpwWTi/Xsaht5J2aZdnJbOSbAI1yRlQmCdYkM++MiP8IieA6fqN
X-Gm-Message-State: AOJu0YxWj60Njn3oGGVMkcWOHlc0ZsVlA4DEA+dEEuGh9NegubBrWPje
	fksnDgsXRxsiuWFow/p6R/PrHL9V7vcbLlRwG2xB51W88Nkzd5K4
X-Google-Smtp-Source: AGHT+IEHHfOQnuhnS4Ryh29PiVGt/7mGXs60KFI2kapkV31k4eUwIcTARhn7p0wUR/42CH3nBxhSSw==
X-Received: by 2002:a17:90a:c28b:b0:2c9:96fc:ac52 with SMTP id 98e67ed59e1d1-2d3dffddd10mr15042723a91.26.1724126951114;
        Mon, 19 Aug 2024 21:09:11 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8149652a91.27.2024.08.19.21.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 21:09:10 -0700 (PDT)
From: Tahera Fahimi <fahimitahera@gmail.com>
To: outreachy@lists.linux.dev
Cc: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	jannh@google.com,
	netdev@vger.kernel.org,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v10 2/6] selftests/Landlock: general scoped restriction tests
Date: Mon, 19 Aug 2024 22:08:52 -0600
Message-Id: <6c0558cefc8295687f8a3a900b0582f74730dbb2.1724125513.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724125513.git.fahimitahera@gmail.com>
References: <cover.1724125513.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The test function, "ruleset_with_unknown_scoped", is designed to
validate the behaviour of the "landlock_create_ruleset" function
when it is provided with an unsupported or unknown scoped mask.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 .../testing/selftests/landlock/scoped_test.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/scoped_test.c

diff --git a/tools/testing/selftests/landlock/scoped_test.c b/tools/testing/selftests/landlock/scoped_test.c
new file mode 100644
index 000000000000..aee853582451
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_test.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Scope Restriction
+ *
+ * Copyright © 2024 Tahera Fahimi <fahimitahera@gmail.com>
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <linux/landlock.h>
+#include <sys/prctl.h>
+
+#include "common.h"
+
+#define ACCESS_LAST LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
+
+TEST(ruleset_with_unknown_scoped)
+{
+	__u64 scoped_mask;
+
+	for (scoped_mask = 1ULL << 63; scoped_mask != ACCESS_LAST;
+	     scoped_mask >>= 1) {
+		struct landlock_ruleset_attr ruleset_attr = {
+			.scoped = scoped_mask,
+		};
+
+		ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
+						      sizeof(ruleset_attr), 0));
+		ASSERT_EQ(EINVAL, errno);
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


