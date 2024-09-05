Return-Path: <netdev+bounces-125313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D102596CB9A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862641F2656A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4260C79D0;
	Thu,  5 Sep 2024 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tsfl+XKi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63C728EB;
	Thu,  5 Sep 2024 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495265; cv=none; b=RQ4lfdXmfmyk0uKVG/UGTT3GAaMx8QvrmiN9ozblzggoIlz8KUJNXeLTUZwHciu6dwDSR6hNHVt0QTfxbXjfOliqqishQSVNYjGJIzOnfrmh8XeKibv71uPbS7aJwv8eqmQryp5R2bEOLRPYZTbXgjR/LG4Ewp/7BA5UeVSl1MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495265; c=relaxed/simple;
	bh=Ph/b40sS3y4vA24Edlt58Zs6hPW4jW+bVh2lWBLifRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6/Tsm1R7ZzXcIFu6NwdKtXVUCIYgnuQ6J9OH3HrIsyRyXd2fH7akl+vOVAgJ9jOdK/2kxt5v0fRg4YiclWxDFB6xBGyvtc7Lwu2K5nFsiVD8dJdY398WO+yeAmX/fo7fl7EEzFU8p7V00wJEvPRISsNoyxUnA/xo0M8R1GSFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tsfl+XKi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-717594b4ce7so174603b3a.0;
        Wed, 04 Sep 2024 17:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725495263; x=1726100063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9Qxv0MhIUJqf7Mc01izOPbAr1VqnmVdpgZRy2Cr4ZI=;
        b=Tsfl+XKikd42pREfw/Qs2p3Y6bX4/IZ5flT04GvtnXZeR3rZvBzY4GhY910hEafta0
         gTjlI27HnL9ag0ovb8I1nRBqReVCQM5OdEgFF7kwNfN5BTJixocXkWmsgqyz6EXpEMUU
         0yfDA0aqGbekiAKLO6ZgNJU0TFERhPAclBnhw2bw1e7I84CMMaONcSgynkt63wRWWnC/
         6qSpIhqz7fMzgPJvOBLp5ni7YAjf5m03e2nv9FlcNylfdf1SNRFwhqQ7YZq9tU1CrE+v
         lBPlG3HELF7IjX2hYW3WgAdbYyrlYonJVjHdryQW9txc7mRnWxkSghLM47AZjetDDyvh
         0LuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725495263; x=1726100063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9Qxv0MhIUJqf7Mc01izOPbAr1VqnmVdpgZRy2Cr4ZI=;
        b=VfnTXn1yrr/lZii+IaxCR5c/ynLzZ364Cb96ndi911EVa5iMxY0NEt+QBAnHf+ULjm
         NKHbZxu6Nue99ZwBl7Y+GSaAJoF5e5kvEAyD0qZGyGQEceqT13bu5sd2O03SqAU9GGGE
         PujLLnihn7sx5vqcF6upUtkU+EcJqbfco5Q4uQ8kGXe+SbtXHQ9doIm2lOdaw4xi/hqR
         5ZVg2UuS88+yYzyA2X28tiTA9eqq2S4stqxvtRvO3doCrqyVTxUd0b+pj6a9T86r8g3w
         u04WLX/t2oPGxTmzZRiiqIW7wZcK4By9HR0jup8qwKe9Knr92BEdnDx2UusmmaCj9NTM
         dCJA==
X-Forwarded-Encrypted: i=1; AJvYcCVegTQfnhW0ZXGOqtVU2WNC9vm6fllJuFiT4z0OXet4Ungs/fBizNLgPXhFt79asmSd+uUbLP1ScrEgQorObyMV9XQJ/EGO@vger.kernel.org, AJvYcCWrv5AbqLBgWkeK8Uxke7C0KJMvoxV6rPQPkUIY9BsbvQcyhEkf0lenFKMGwAVLZ8f+XtGsAknnVNBwhVE=@vger.kernel.org, AJvYcCXxaikxPOPzwuj5mtTeemvMNd40/kQqXTh5RE/uDn4Yu0Aknw8/Dgt/CiFFewsLUa6lrkcHR54P@vger.kernel.org
X-Gm-Message-State: AOJu0YzPBlY1mH+CLhyWOWmWRC7U20XHMOqYBiQ/JxNHUiU/XKLMDIW8
	3fgaBxK760xFPgtIQj/oPDIIkP7rZVqJxvsrmkEWx93kexwjcJts3tQjTheb
X-Google-Smtp-Source: AGHT+IFTk2+yaksGZJTPn3s9d2vWrrUKU5MF3evxgeD+PJnTeRY/a6zvlgXjEuhIQl+mqfGqMYLOPA==
X-Received: by 2002:a05:6a00:2193:b0:70d:ca45:a004 with SMTP id d2e1a72fcca58-715dfb68c18mr26407717b3a.13.1725495263022;
        Wed, 04 Sep 2024 17:14:23 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778534921sm2159781b3a.76.2024.09.04.17.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 17:14:22 -0700 (PDT)
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
Subject: [PATCH v11 2/8] selftests/landlock: Add test for handling unknown scope
Date: Wed,  4 Sep 2024 18:13:56 -0600
Message-Id: <74b363aaa7ddf80e1e5e132ce3d550a3a8bbf6da.1725494372.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725494372.git.fahimitahera@gmail.com>
References: <cover.1725494372.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The test function, "ruleset_with_unknown_scope", is designed to validate
the behaviour of the "landlock_create_ruleset" function when it is
provided with an unsupported or unknown scope mask.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
Changes in versions:
v11:
* Change commit subject and apply coding style
---
 .../testing/selftests/landlock/scoped_test.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/scoped_test.c

diff --git a/tools/testing/selftests/landlock/scoped_test.c b/tools/testing/selftests/landlock/scoped_test.c
new file mode 100644
index 000000000000..36d7266de9dc
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_test.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Common scope restriction
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
+TEST(ruleset_with_unknown_scope)
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


