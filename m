Return-Path: <netdev+bounces-97473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBD78CB844
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617371F27082
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD23615B97C;
	Wed, 22 May 2024 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ttx4SwfG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7BA15B14F
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339757; cv=none; b=aeNXPuVNFFbGisCbKObPSncDCeoeL6ieVR8APXd7/apefhpDw+g7HiOFNPgIXxddVwPEjUzu289pa2+s3Rp6kKZ+EpKt8ELyHho+twmHI5GGtClKRLucs01WtC+aukZ3wulUw72NLDtnBotfGJT+tfvcTWagFhAx3W9HNnmV9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339757; c=relaxed/simple;
	bh=XjLDp8cUGRvX84+Q9aIS9dPGIChvC28mo14HZv80yTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nysfjtDMc/pFdm5EuSdHwnNVaBveMKtN09J0VXcqX6xLqWPOBubwxdupFasW0wvnmE55gwyZNScUK1NIiecyYow7XfeC9u43IqRTjX3pMXDBdORhrefayvz7X7adY5MrLyWod0Qm/8IbWA90gS0z31QhTkPbLkW1TOfL85GnxpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ttx4SwfG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec48e36217so112420705ad.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339755; x=1716944555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=THfAbUsdCLmnmf31zE9Pe2u6BNmh9uFbN2fzLklxkz4=;
        b=Ttx4SwfGpYtRUciUtJ77Ge/oZUkOiEnh0nbzrjoCNQSWj28wTIZoGlDtdGA1+VMaH4
         szwEgTUpamUcS5qv6trSk/8AKtL/IelA0T/jV1n55zbyPjPpYM3miMQD8ZtNCdAD3CVf
         vHjlHT6K6ansLXHepO5KnVTzc7VfPcYa+n8fUDU1xWkioLpHqY23te8IHGUlPgrIK0MY
         ki8WonnyoeqEW606KnvyE+mv1dcgWUqSxwtFGC+cj5dMurlLEn2V8Rpunxm6COR02XRJ
         OJWB1wvRciGCbFMvncc343C1V9jUasf3nheprsJiG7u0MCzVODyDbawYYiFbihTzp+i6
         Jh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339755; x=1716944555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THfAbUsdCLmnmf31zE9Pe2u6BNmh9uFbN2fzLklxkz4=;
        b=nagEwNvsCYolW5Zb3PJEqQ4JkqWOZgEca+OJzNTS8FD+mpVK/wjekC9qusUELYTWN/
         Di3k1DgBxv8tTrpvBBOWwrsSIjZbFKD+oNU1S0PgB6RosloqlkovzvanXea5Po+SAEUS
         xkBv6RRa7BoaO+UTS5B4VeIzzvOUaO8d4Di5NawOs6gnk73i7arohW5NxuSQh4MW0WJM
         94LhLMNok2bDhXxupTbcuMBCKXg0m+D86ql5LcWFe0qhHUYzd/nl2VrKe8G1ZcEpjxAb
         g7n/qZ1Iyz0m/nJFu+qS6aGmP6L+/rTcRcmx+0Qzk6BDiMDSJg/JdtFDroW3wiZU1cZD
         3TbA==
X-Forwarded-Encrypted: i=1; AJvYcCU+PCOarToCQKR8wGXCP0t/P60Yx1CcQpvTRbBX3zsybt72AsapNPZrXeR/IsrbzX32BsqBI8mZYlV4hSzQAOMJZkEViQBQ
X-Gm-Message-State: AOJu0YwcpoKQoxSnoLH0gl1/4oBbaxElZeWjmWfe6VLGoVAWndKj1DLL
	UtVEvDTKaqiKijSWiaRE2PI61h8s98PRj9XGq1zptNfkiEajmUuU4h0le9+gEBgTewE+FJnU6qS
	6+Q==
X-Google-Smtp-Source: AGHT+IF2I2FWOecHFUCcN7nKq/bwhFKSfcaBbhOfbRL9O8f91+0Uq1k+MIvBsT42EkpQs0UJXpRvR7cMkog=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f7cd:b0:1eb:829:b6e3 with SMTP id
 d9443c01a7336-1f31c9672a0mr175035ad.4.1716339755383; Tue, 21 May 2024
 18:02:35 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:50 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-65-edliaw@google.com>
Subject: [PATCH v5 64/68] selftests/user_events: Drop define _GNU_SOURCE
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
 tools/testing/selftests/user_events/abi_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 7288a05136ba..a1f156dbbd56 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -4,8 +4,6 @@
  *
  * Copyright (c) 2022 Beau Belgrave <beaub@linux.microsoft.com>
  */
-
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <errno.h>
-- 
2.45.1.288.g0e0cd299f1-goog


