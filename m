Return-Path: <netdev+bounces-95191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2558C1A8F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE9AB23485
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D284353804;
	Fri, 10 May 2024 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDPkNFH4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7B8524C4
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299788; cv=none; b=N5E6VwQL4J6BR4ebR4YMxnN45ftqwJ/E9UywOW5YkPfudf65ZBjojkyvI9otWcudrR2Znyoz5HswH/zCYkPVY420H5Xl6R5LcCeUNaTqmbjGXSTSA+34vOyUn/nCboU5r39rdHrD2F4HefH1U6f0senL+8T+kALvFsww0RkWqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299788; c=relaxed/simple;
	bh=VJMdzYkkWNobVas7QA48PzMgvlHzpsjOh24f/lA6Juc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BeSb/0dVsS2Cw/WMm339RMfpAPd7F/mKnT2v0C3csPZAr+ZTi5ba/2nZ3Ffj5zAeXIAd0cvddtZrdU+4+CWX1Wm1yF9TmrUQ/6IGCnnVPaKpzRgMWF+aDYSbkBce6aO2qYWC+9Fzleb2AAfKUpWjUfqC4PwN+U+71iyynhD8KGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDPkNFH4; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ee2f06e652so14304075ad.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299786; x=1715904586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6pzUPfc9dzXnDgIcrAO1vEqFEJkqCnVb2h/9OrkRu8=;
        b=nDPkNFH4kqkTWQo6t7Vzz4yumSsflMvN2UQHNrPA5AnyZGF/ULVPBtqytFviIzmjsO
         Gfq6mFRg4bVFG1nfPNls3xWaQ6/BazVAkObg4//yGL4r3ur20M7ck4S2AakCjPosefHq
         j6Y8UTLZmk4QhKN3OXYxf6p/EOHSa9SlG2L9Ipf5BZQ6W8c4m+Ykh28Q0dKeSKWJdbiy
         g9vI5+zSrVLu0CnfGVx3x/pXxQxjhahU5FyljdA6DFJKd5yZ0Nfw4j0qXJtly3hZonLx
         mWQpQI/PVSqwKl9P17SVX2yIGt9Vm24fpWmPeMY1Cvyiz7St4vUobnAoFsXLK2e83KOR
         /G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299786; x=1715904586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6pzUPfc9dzXnDgIcrAO1vEqFEJkqCnVb2h/9OrkRu8=;
        b=q0R6o8lVBN76GOyUTfyK3AuwPByY5LYWjzwqlz2Yak4/PD31beBZAznyX3YW1NMfyL
         5oJ9AKNMc48FKpiJHTAkhRN0w0Szmm13EdkjJGa4dKXOi99LDowWCSZ+6LC/zBdqHOqj
         2gT/55pepozh3JjyI88cY5cFWq/h2q+vqlK6nWeLHv54PcDqAbYGus4Jo/2I+9K+26j5
         f0I0bNTx8hRK92q8SnwL7O/Se8XqleWSRxcKqvp7D7n/DrWsbd/E1RDXbTJl2jSJ8seS
         uUAZPBLvHrImR5U60se8n67339X4sa1hG/zhO3UuC+e0UvbzBMCGiD9NyHsSpH/31F27
         84Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ7J7kWYzIbTxwUnLhrwJXlIopT4Si2N6cKjuWxtBeEr0nACWfnarL7eDYLBtPGfASSyHTwVzr1+lLQ+9LxVBKOt2xByej
X-Gm-Message-State: AOJu0Yx67WjA0e3EQYhERS+ljDMALGUH5hjmTZFlHa7eDLp/HjBm/1V3
	SluCdi9T0enQYtYHGsHRgUe//j+LPXNSrQhdULbI7+IQqHaTcQWgaKFLVIhQiJixafHi7dLDP0L
	yow==
X-Google-Smtp-Source: AGHT+IFRiEIaxUZf+B09qoF4C7spnjmBUeOfByi8Z7hCbfbBT+bOyMsubD1CDFgj4SuGnEmEdt3tFwdeaFk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f201:b0:1eb:51a3:75ee with SMTP id
 d9443c01a7336-1ef43d17fb2mr26315ad.4.1715299785832; Thu, 09 May 2024 17:09:45
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:31 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-15-edliaw@google.com>
Subject: [PATCH v4 14/66] selftests/fchmodat2: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/fchmodat2/fchmodat2_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/fchmodat2/fchmodat2_test.c b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
index e0319417124d..6b411859c2cd 100644
--- a/tools/testing/selftests/fchmodat2/fchmodat2_test.c
+++ b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-- 
2.45.0.118.g7fe29c98d7-goog


