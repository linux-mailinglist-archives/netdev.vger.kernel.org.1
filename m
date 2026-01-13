Return-Path: <netdev+bounces-249314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60048D16926
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EBC63009FB1
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B96A31B117;
	Tue, 13 Jan 2026 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y99O4m7I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C442F28FB
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 03:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768276606; cv=none; b=cFp2JN85CSL31b7F46r53mIlv5UbYJRUfOOVLF4S8JnFM339VSmuraeUPmIxCDWS86/W+2dWC2HpGd4FYQLabIRVYQz/taj9TYMf8qGYXQh613I0PAS5kWBzCHmm56aOYlCdrJy27YYKUlUaGOpno29cwsPhthSBZQxJgpKJQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768276606; c=relaxed/simple;
	bh=jlM3gx0KLHdeSg3Vk45rjyjqQXEqDuDMGF1V7rxLhKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QFqTVuKxmgOu3/2TIJVu/gdK9s2Ecar4vSe0bQ7G+5iBIDZJk5DNUfFH6dUBRWyOK5RAx2Y2of41GxBy7DlJdjuUMAjKMfAvsSCHsw27KPY9thrhfBuvwBM0EHTZ8BG5zmPAiGezrc6dnsQb6Iye/mf0fpiSgreLBc5ESeC/Mlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y99O4m7I; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79276cef7beso22350967b3.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 19:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768276604; x=1768881404; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WlnkL/pvl/AUSTJYeph4CNCR9P4ylO9I/OH9LNbWUpI=;
        b=Y99O4m7I8swsssVyM/79GLdHFPCokPElnHHCWvHYf3V4ttMTQvdwNnJtztAZFRV3EA
         RBYSsbjgnSBSLe4no70sb2NFyID003Ac9+QSFVeP5GeQMZJXaBVmlSKhgbBpBws8AeD8
         kSBIgdhUW3DMK+38AzryRePmIZNoHWHNjOiM/8mruJbH5bKk0QjVYlFinggzkPGK1lnq
         v2qViDvHJNUyVLx1KNJ0RZaKrgRS5Rma1jgUwZnHApCxsSWDqC2mOeP7+tb91yg4q3qN
         zbWUtbcESx561rGa+k4S9KFmK+1gkN7Xj2lo0R0h6zJL6biggBh+c2paiIj9z6kzo8b7
         da4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768276604; x=1768881404;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlnkL/pvl/AUSTJYeph4CNCR9P4ylO9I/OH9LNbWUpI=;
        b=jWAVHXPoCopKYHVwU6pON325xlPiTBevDtcNpvsbD0Baw+bSL5eqO/w1LhFqGDsnmk
         RI8ABKUYlNwcd/4vKGtxAq8MtD6Nnc/AotT/hqVvoReCvMwXLEkxclFcsyVJtYdQcBhr
         JAwsN+rE2cR11V2GBTMXCELg+9PdvcWpqx8AjLwh+mBdm6hGSIBkQAENJhMyaN2WJ5N8
         qVI5m8JnMxF4PMXG+hCID/caK/dr0LUQUz4/9CTeZu4y3vlx8vjvJgpR/2xIK9SHuTnp
         3iGd04wTLhA+MZRhNw+E6FuOLolYmoznbknIEfRu1V4wSSW8Y3DRxlBDG2vDYuS5mnnn
         AqaA==
X-Gm-Message-State: AOJu0YyzurHwJXKMbewoYfnGfg1v7pVeCgdGE0UddMKtH33kOW7DJ7lV
	z/HY9ngt00jbQsl/WtIRZeKl6dADWZo3z4HdZCy78k9GLh/ElB7E0MLf
X-Gm-Gg: AY/fxX6nIBN9ouYGJL2x089+RGjTVX4O821I/KKP++nKr/XMmWqsbGEDcT8JoUVkcqp
	ME5iG6LbtjWt8jFj4PDwQc7HorDy1MwVnaiE8FIWPgGTGFT2aoklzcdTxvSkgNzQAlQ1aIdPBVt
	kMFCjSnYRh2AzXBE3wCLEZ10S9x9TOlArcqWvbY/k8f24lLFkLBjSzsg9+RTrOoSiQPXWvLoQEs
	pb+OFzWnGE1Y6K3MxY6cSmst8nD4XzECaaIERv54ipTVLotB7yhUOdX1Ycz538uURbLwFSfMirn
	g+gKi5xG1W1lAMWnyeG3b8MpE74rA1Kd5x/GhASIc6wf8p2ElVftZ+RmTEOv1r2nipWP5B1hrUf
	F8FkYv+SYro6P5vBTT0dCZk0QWOkWcz8wy/8h36xPNkHBfOYidbkKJtjuQ4Po6YTJhUAnvdAym9
	g/ABAd9ZuJ
X-Google-Smtp-Source: AGHT+IFyPwA8o1tyotURgzQpdAivG3wlDzrcE3XTbtDNIlhmL9z5TdgOBXXRwwe467aX49LvMY7JnQ==
X-Received: by 2002:a05:690e:11ca:b0:63e:145f:a4bd with SMTP id 956f58d0204a3-64716af54c4mr17802800d50.22.1768276604143;
        Mon, 12 Jan 2026 19:56:44 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b246fsm8784756d50.17.2026.01.12.19.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:56:43 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:56:31 -0800
Subject: [PATCH net-next] tools/net/ynl: suppress jobserver warning in
 ynltool version detection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ynl-make-fix-v1-1-c399e76925ad@meta.com>
X-B4-Tracking: v=1; b=H4sIAG/CZWkC/x3MQQrCMBAF0KsMf92BJlFbchVxEeK0HdSpJEUip
 XcXfAd4O6oUlYpIO4p8tOpqiOQ6Ql6SzcJ6RyT43l965zx/7cmv9BCetHEeU5AQ8mk4D+gI7yK
 Ttn93hcnGJm3D7Th+zWgnYGgAAAA=
X-Change-ID: 20260112-ynl-make-fix-c8a3e33c4757
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

When building ynltool with parallel make (-jN), a warning is emitted:

  make[1]: warning: jobserver unavailable: using -j1.
  Add '+' to parent make rule.

The warning trips up local runs of NIPA's ingest_mdir.py, which
correctly fails on make warnings.

This occurs because SRC_VERSION uses $(shell make ...) to make
kernelversion. The $(shell) function inherits make's MAKEFLAGS env var
which specifies "--jobserver-auth=R,W" pointing to file descriptors that
the invoked make sub-shell does not have access to.

Observed with:

$ make --version | head -1
GNU Make 4.3

Instead of suppressing MAKEFLAGS and foregoing all future MAKEFLAGS
(some of which may be desirable, such as variable overrides) or
introducing a new make target, we instead just ignore the warning by
piping stderr to /dev/null. If 'make kernelversion' fails, the ' || echo
"unknown"' phrase will catch the failure.

Before:
	NIPA ingest_mdir.py:

	ynl
	 Full series FAIL   (1)
	   Generated files up to date; build has 1 warnings/errors; no diff in
	   generated;

After:
	NIPA ingest_mdir.py:

	Series level tests:
	 ynl                             OKAY

Validated output:
	$ ./ynltool/ynltool --version
	ynltool 6.19.0-rc4

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/net/ynl/ynltool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynltool/Makefile b/tools/net/ynl/ynltool/Makefile
index f5b1de32daa5..48b0f32050f0 100644
--- a/tools/net/ynl/ynltool/Makefile
+++ b/tools/net/ynl/ynltool/Makefile
@@ -13,7 +13,7 @@ endif
 CFLAGS += -I../lib -I../generated -I../../../include/uapi/
 
 SRC_VERSION := \
-	$(shell make --no-print-directory -sC ../../../.. kernelversion || \
+	$(shell make --no-print-directory -sC ../../../.. kernelversion 2>/dev/null || \
 		echo "unknown")
 
 CFLAGS += -DSRC_VERSION='"$(SRC_VERSION)"'

---
base-commit: 2f2d896ec59a11a9baaa56818466db7a3178c041
change-id: 20260112-ynl-make-fix-c8a3e33c4757

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


