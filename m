Return-Path: <netdev+bounces-97441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441EB8CB79E
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760081C24163
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D24814EC42;
	Wed, 22 May 2024 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ptrc7+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2314D703
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339665; cv=none; b=k2G1rVZMs23NeYgw1FQ+lVIRRQTLBy03k+Mte7DQeWywhnglAcB2m69AH6PIP8EBOAQx2ZfEW5BDZUnpzWURR0Y5F15/ZnKR9pf6tO2QIC20ChGLPpaDVVXSScLXuCaN2ZqvCWw8O1DtPXlDAU+zU+/OXtic2aXFiUnqD7bL+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339665; c=relaxed/simple;
	bh=L1CR96I/OKaP1P4IlG6D5+TQKAt/OUSZ/m3bvebvktY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qi7fumU8GEnKejDock9YEWUAIEfz8u23kiQozxLD9NDhnHHsgERwnvaweyqH/EvEpcxicf2wK6Xk8p3Na6snpun4uYvOGmAkuRMOLwDmLWBA/NXpQ88hN7EnCbA4lLVbKmwDrl2RuUZALhaTPEoYFPB8st30kXlkQUG+nVzZTYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ptrc7+D; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b028ae5easo207925187b3.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339662; x=1716944462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNYd9WLAMtXto9r5wZywfmnRKL4Xp7DbTMTwTIIZc1U=;
        b=3ptrc7+DHpo5Z2uFFxCCvdB1yQWxjrxuEPtnBbt9Q9Wv1v9opF2N3VND/L1e+LqNDK
         7ZAfSaEKw/70QeLNwcMwmoqqDnZyachMI61+0SMNs4XHriOb6P6eFZknFiVaa1UPVBkY
         f3OGZvuOzmNu+x/t4vaJ2nJBZzZZ1GyHfFmrOeqp+Uf/+mnTrPvUmwP7UNaRvYFBVjMW
         I7wK6uk1x++3P+99G/6ZHKThJqtmga1VJvOwGp5XZJxwHYCQZb/h0UQSPUpU5pUVcraq
         rQHBayJuW5boc1bhKQaSg/JpZc5eBpH1ylB+55gQbmexAdQ6ArdvQeBQXotXRynD89H8
         TFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339662; x=1716944462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNYd9WLAMtXto9r5wZywfmnRKL4Xp7DbTMTwTIIZc1U=;
        b=RweWL9uxeFszKtgRqkFdLK8NjYJt2fFY8eVelPG8t7W0QjErLBx/z/rVOU8fzSNC/S
         Gk7JM5s3ZjAIKMGNGsXt4N8ex/xURVR/FKUME0a5rZa/x0AfVQgh1l2KQiVf3fSBqd4g
         zCH20PDCc8GLiHk9MEcHQ81uXtyj+FTFObFdSNBPKorGWb/KVyfm51mFEgX/IQgxRcPK
         J2JKtJAP0MB7BhkQ1O8MzmmetniAuabmFQDf66MuLET7/6qPRnJChB0d+c1ifkrNAY4I
         PxjbeSB6QbDzlQrEy+TrzjZxeT4v5Tev0nEaVjkieVJqfM9DrPKPpqNJLoByrfQ4kt6/
         vdTg==
X-Forwarded-Encrypted: i=1; AJvYcCXllFfg6LA58rd1NNvqWRnvaB8G1lYZH5/Hgsg7R0KA6tPhuMMTgP+6f3dVzy40cIqO1abkMPbQCz4v83muNkqa56Pd4BMy
X-Gm-Message-State: AOJu0YxlqqGz9ExWrNEBzd0h3d35gdicmp7qvji5gOIk6sAEwMqZ5nO7
	VFLtKLEdy3rYEYpW0kWjjAZ7V1buQAuOmSFpqSAj/LZwL4XyYJkZIVwSfkvyoaVZ//0aeffGNl5
	25Q==
X-Google-Smtp-Source: AGHT+IGvJ489QQDb0KgifWCogWHmTsAg74XgHxgtSKVsW0Rsdv0Ifz5z25Fo5jer52C2SyPHmPiOLDqfRaQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:db4f:0:b0:627:dd6a:134 with SMTP id
 00721157ae682-627e46f6335mr1764617b3.3.1716339661939; Tue, 21 May 2024
 18:01:01 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:18 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-33-edliaw@google.com>
Subject: [PATCH v5 32/68] selftests/mount: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mount/nosymfollow-test.c          | 1 -
 tools/testing/selftests/mount/unprivileged-remount-test.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/mount/nosymfollow-test.c b/tools/testing/selftests/mount/nosymfollow-test.c
index 650d6d80a1d2..285453750ffc 100644
--- a/tools/testing/selftests/mount/nosymfollow-test.c
+++ b/tools/testing/selftests/mount/nosymfollow-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index d2917054fe3a..daffcf5c2f6d 100644
--- a/tools/testing/selftests/mount/unprivileged-remount-test.c
+++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.1.288.g0e0cd299f1-goog


