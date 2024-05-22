Return-Path: <netdev+bounces-97423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5928CB73E
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECE71F21D73
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264CF85276;
	Wed, 22 May 2024 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkQhF8xT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9884A4D
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339616; cv=none; b=gSf7O9FC5rIQBfMmurqWFMw37i1q1RFlGtnKezLvvFreozbOzeW55iBUe7rYd3PVinA6MVJpjqMxQSRpfyVvXWy/2ygNBYxw8Y8UBaTwOrVUrRBhIxNe7oSe37n2xUnN92r/ObFAWQlNG3NjHgQSr4gWmb3ghM65MBuoEZEg8rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339616; c=relaxed/simple;
	bh=wsyMQnSJoz2Wb99bdxmDTEHWi5oTqZOWO4XctcEHfZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mCgsqWHVA6HRs9YddbWDDLrTYrh555UzaL7CtRcWjWJ14yedsZcqgG9Ulger7lZSlkFaaDDStg5mLZXmZXxRzKsbssyUT6CgU1zKLJtQz4hj9H2gyUVhMhMvBEHbejFjz1P0bJiVz32aZxnfMH8BRx0rRvVwmk6VhK1lkV2YZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XkQhF8xT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2bd92c35e65so1345317a91.2
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339612; x=1716944412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsA+RTqEPsjVoyQz5htVdcF3IiHZQEx5aOWSYNx99Ok=;
        b=XkQhF8xTBH7x+fZzve2HF0FQepqr47zFBURLol2odjLRMjJqtHznQZ8//+43psjXO/
         yu+wQrPAQJq+Z8NKmfPeiEI/hQV/+O1kfH/8jzOA0SA3xw8wY7eCnP19UxRxMDekdA5s
         thFu7ZMGchQr5p1x4w8Z03G/pxEqpikRev7OVrVjKCiVv19Qz9aHxRNMu46uiqcxb9wh
         TIWKD80Tnp/TjacnGOKNZjFgu0GG5RNwDOYiecQix+va28C8FtBUK3FLF+pU1mJoscOw
         QrmtrWBFDDS+KNhyTHozakubWiv3OxSBtAO8ODJPfdgqGtKF7KWNrdEBFIsti0WJnpgv
         BoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339612; x=1716944412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsA+RTqEPsjVoyQz5htVdcF3IiHZQEx5aOWSYNx99Ok=;
        b=uFNT7/4xoDf1vMI57BaeV8j1mDX2+phpM5uPhxCTW7V93ICwDH+/9I34zSV8YETpJn
         UipPZ6RuckXFi01iqAbMt/cIPoVOcmI8FHrA18sT03GeBNgkreb4I3JUvMi8WQF4ypkO
         fQkvkHBeHW6PAFnQOpwN9tpLzyI6gNpThxhtVeXcHq4ghGKCQmgS24rdaJuVGmZ4gA4f
         7Gw63W35kIUIX5aHrAcDq1z2ffTvRSL1NfXKDOVW2Z1Y6I1y8SXcR947QPfiiK7clf+j
         +vfdOwDfn9Qv/P4LHKTX+OBq73Ay+rCgpkwNiLs8Kw0blHUcsPL6I1SzXzuA5UOl7VSj
         F1cA==
X-Forwarded-Encrypted: i=1; AJvYcCWXG0TRrRNizY0hl3Oov9bui6MuGdhGQNES9+9UrQx19OvKPdThg5CLVBLzcJfj/c2zv3g55S7XT6IiwkdZYb2u8q2uPKQi
X-Gm-Message-State: AOJu0YzzMDnqW+Xwdxu29vFYgd7WAG7wo6et0O2rXq91+acRgXB8FoHT
	WvyWTkEb4R4NeQxgUByBF8pH0e5jXsh/fa4wae8n2Q6JgjgAm2I0uVfoSTCaWoqAWFFx8F3e/kt
	GlQ==
X-Google-Smtp-Source: AGHT+IEcD4R5LAcOkQ6bfXkqs31q98gBsHVg7hM3ofLnT8WyE84ISOt6pDCwS+T69u05hB7J0k9BXfKJ8Es=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:c40e:b0:1e8:37ea:d17 with SMTP id
 d9443c01a7336-1f31c948c7emr89065ad.1.1716339612406; Tue, 21 May 2024 18:00:12
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:00 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-15-edliaw@google.com>
Subject: [PATCH v5 14/68] selftests/exec: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/exec/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index fb4472ddffd8..c5bdb653422b 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
-CFLAGS += -D_GNU_SOURCE
 
 TEST_PROGS := binfmt_script.py
 TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
-- 
2.45.1.288.g0e0cd299f1-goog


