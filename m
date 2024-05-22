Return-Path: <netdev+bounces-97432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F88CB76B
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFAA28116F
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96898148842;
	Wed, 22 May 2024 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnJIEF4/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC41487FF
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339637; cv=none; b=LotSmRXs30cNfaUpUiWWLTV1rE9BMNjMQxjL0Iok/nVHZHE+NCVwYXSNInCEj/zfpCuLXfgmaRvsODeAmN3U0q+NIanplXU7jrDIrb68kK97rD7vft5jWd2i8QxA6tbUULpYsHQSWigFw7wp3ROLTtCDZu5lUqBL22t4UMOBNcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339637; c=relaxed/simple;
	bh=fCWkZIz40C66c8ZuJ4q30JGVy/DoIJa9iLkeIwQ83So=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qbLUV55O4OLwpZAw8TFzwPGtQgG9UgF4ruGI2UYONlsW4DQSv5Mz20ayNKlkg+8LOWnNG2bFXTPtxVMMVdgz57vGyqIwNEruFy8W2tMMyaaOaPpXTQgXXDqTWP1iWV2v3ovUGz08g5yzCOGPYFYmp4xS0CIhl2gSPs6KlBzS9qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnJIEF4/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6204c4f4240so216605627b3.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339635; x=1716944435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rW5R596XV/BhyRO+Ck1A05EK/itIG2yrmFZ6NrHh18s=;
        b=cnJIEF4/TzKTmlxcWeq8SDaB3xEPS+7PNv295XGG+jjbFJchGx8wKybyjx2eEtWSs9
         4sJHzk7/7OZPR4HN1LzuaIeO6P2wc9Q45X1NoGDSyBLXq6yrFccE/G8r/Pxwt59sWZO3
         Y49EGFjzxMpAHK1iIHBwDn9BtptkPSFqxKRoqAUAcDriRstIMUEY/Jl0O8HWMAcbAWuR
         4oh0gzodT/AGuSH9634tqx/YbZTYq2XN6AMkwe+5uq4Mer+Y+aODiQYQ+6EJ4mP5nF84
         9uYZS6VV0GhoaltI6jlCfmj1I5npFyq2IIs2RjN3p9w/FQ/drdB32glw/kUOeYPK1JMM
         dSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339635; x=1716944435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rW5R596XV/BhyRO+Ck1A05EK/itIG2yrmFZ6NrHh18s=;
        b=Ycdyncxg+sWBixiDOn9QOk5NtJRWdmumRes4b1jz7On4UEVKBs4xfItp7uoZuGNcsl
         v70VtCqdKDrPPD63X+tktHyWdtOdJZCmwtIvta+SJhTA6OMwOls5J+Mdd6VLgz4zkV2s
         OC10Lv8Yu2h9UZQ+tXz4OiIXiUDFlWc4ZeUqNKDcuWj+V5mKN8hKR7g0ywXinOhZ5tq7
         3xWRKs4rEffMiDGTWlofgY4ehO7Mk8SK4ClcJkIC9BVYmk5IFpYkDOEhEko2Z6v/VIoN
         40afN9rXrpCPdbJSJBZzZXpdXJyUiAJqzwS+vqtX9xJPHQ/gC+IO5imYkFkhlHuRKQTz
         roKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwkxXwzyHlPtKmlYMiNd+9UOQXxJggbrGniYZVIxyPJ5I70LVsUbF3aMtoEf1a+1o167tGbQfDPzw/WGe2APobQaaZZn2F
X-Gm-Message-State: AOJu0Yx4+HRKwm5/nMcZ1cPEstrSBdvS0EmPj50itIEAYAusX4ouJY3U
	+AOX807GtYVPwaEAQZw+WwL4JMoAXoqWZLrISUh48/qpm4Ipy72sa2iELXwfGPpEfkBP9peua2w
	w5A==
X-Google-Smtp-Source: AGHT+IGfBUkXH3c2aGY6dfFSwVcPLg4SGb/q7ma1iwiCk9LmStygJFAZaLHBuK+Wl9geeHgSjlAVdx8zQ2g=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:e20c:0:b0:622:c8eb:6ffd with SMTP id
 00721157ae682-627e457c42bmr1733007b3.0.1716339635044; Tue, 21 May 2024
 18:00:35 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:09 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-24-edliaw@google.com>
Subject: [PATCH v5 23/68] selftests/iommu: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/iommu/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 32c5fdfd0eef..fd6477911f24 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -2,8 +2,6 @@
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
 
-CFLAGS += -D_GNU_SOURCE
-
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
-- 
2.45.1.288.g0e0cd299f1-goog


