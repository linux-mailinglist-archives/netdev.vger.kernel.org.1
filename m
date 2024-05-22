Return-Path: <netdev+bounces-97424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A88CB743
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730F21F21A91
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6556D134412;
	Wed, 22 May 2024 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JAmk3JAn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2384FD0
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339618; cv=none; b=R+oHQL92PN2hnrTPf/TdSuFNOvkRdDCWbGCbg/iiNDCGpvsjjMSi+3SMr9JRP7SN06oatdkLxjxrjT7/VntF7SYQB/4xlcicVJnXqutPuDU7UhZsL+E7McrDuiefjNRXWz/nb9PL45s1JPI6QXouYpV0+Fb7cD+jvxax4O2Evko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339618; c=relaxed/simple;
	bh=bwGxj56rDXZcmxX6KG1pualMpakVJVhSxYm/fRQ200M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OF3fazrVkfG4TQm/i2/NMZFg9uIRInBvj12w1GDdMFKLYvAzk8gWgJ/eq4zcamfse/vl4ZuXTTyS6w3q3H5Mm+gyWxQgrBn2ASBHSZ4lVJ2GsYJf2w8eNO5ctwe3NiJNJrdlGQ3wtIpBk6arMp1dbolTzIP481ve3iJo6EpTVGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JAmk3JAn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de54ccab44aso25067772276.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339615; x=1716944415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SekOhk5uN00IhSEFy2Kx0Wz+un/KHciPZvQ+RL+rSjU=;
        b=JAmk3JAnfNrgh3tRLQx5oNewyBfaUFGJko6bCu068aDSwyY/WqpBD1KPiBOFmgkZf0
         OvHd28CyFtuEvSLmUgbiwDzanC6HzvxULQDEPsl4D1AN2AD2QtV700LQ29Fzk95hyoSW
         3uzTUFqNt+wCDTQY9uKhGsiHum6NspzXYvR/9fwEPdOSaOyk2WK6j2dGiP89Ya7mTMOV
         3WBECTHP0/YhJPV434T/v4/e0Tf5/+UAYOGrnAvbkxJC9sBj1ZXAS8m417pqHXMsXhRm
         1DHQxjUfjdqFrD+6ULatygRIo8FnSuM/d+5dcYX9icHuRe2ROC/TYooC9wrwIN2JTHuJ
         ctqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339615; x=1716944415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SekOhk5uN00IhSEFy2Kx0Wz+un/KHciPZvQ+RL+rSjU=;
        b=VVe3pyl+L6z9a7hQ05aGAhHDpZl1jB+/2xxC2R5bt3o9Dp8Fev24YE2Hah5TvV9kC4
         jTxokPx7vVyRjX+Uqz4lcsD+EpFzEF4krrpHzjRHxWI3Pkf7huYmoNsMtWpj2WjbcHGv
         6eij59TsoWsp88nJuy0NSUD6cmsh+INRyuWAs35e3a9FRcLmBOzpYupBcuxOfW3izBC3
         0xPF+sbZVY/wIxbD5a94FAH7jm10m2CR7+tiRxifKlTi+KI4N9WgtssSp7xSnqBoLDKC
         7gmCF8+0wXh0rjNHJmHddAJzcCVo48Sr4NXCMg6CFb+7Kdou4p31dVw2bqDkZVprw/dF
         cxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzFDn3mmBnZR5GHwtv0KZX4DCk4uXlqmE4rXPftMZ54VlnYGYueU9Blq+7cNGZxN0+KHjPa54MKYkSV8p089Z8aGRC9S9O
X-Gm-Message-State: AOJu0Yx6l+YawTCf0g4F17GGPgwBILF2uxY/pkXTDVm3GOXnd8LgjJE5
	P5Ngh4cKl7JOK+yV64kekNX4rZ6aU/Vzapyg8xx4V+zsZo4LhWW53sjVfgsZ0f+itA9X74QwYAf
	Tlg==
X-Google-Smtp-Source: AGHT+IE9bSYLh/E/LGMxrrx+sHbG1nGNJ4Z5EJs4Lw6O6tg4A/yJwqWA/HgEqsXHwdInVe2s+KZjs0ddQxY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:2e09:0:b0:dc9:c54e:c5eb with SMTP id
 3f1490d57ef6-df4e0d5b5d4mr203793276.7.1716339614945; Tue, 21 May 2024
 18:00:14 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:01 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-16-edliaw@google.com>
Subject: [PATCH v5 15/68] selftests/fchmodat2: Drop define _GNU_SOURCE
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
2.45.1.288.g0e0cd299f1-goog


