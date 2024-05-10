Return-Path: <netdev+bounces-95231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D9F8C1B5A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EF01C20AD7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DE213D60A;
	Fri, 10 May 2024 00:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QP679QKJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F113D2A9
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299900; cv=none; b=DFF8K3FTNrB4WmXI9ruTTjpZgiTwpx2uCGtdgGE2UnFzONqLUTUs2v2ZfbPc8m7N48e64JDZwRN9AsraFuJofSdOEj/ZETMPiHAs5YOctuD3OEVCZ+h4cOx7NDMJb9+Vc9fs+L1hu+nUAK5vN6v/9ECJKjMOhtVYHr1I+/jCv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299900; c=relaxed/simple;
	bh=JvbDWxGt73x+3I5wycvjFh+GG2YkBR1D3FMaXjgEOUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=taaOLPQjqp1cfXudxysMmqyG0M09rpiXs/y0l4nPHXFQD14yo68vBy0xdSh8LdGKbNfbanu3Ulb5tIHjolajv3sgwqpad5Q8UUPlHZJH3L1w4/Rmz2WRTvCtJPkCYjBaudJlF3BnCdGIKSw7X7f6T7eWEXMwBmbvlHx2WB4KwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QP679QKJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de617c7649dso2181088276.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299898; x=1715904698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WWgoFurwAg8h9SR6wezGd5h5K+Y3bRntTGdapCnYLQ=;
        b=QP679QKJ+YJmUJRm34oeIG2z2fV+eM5+XdTrCwfV3+3XDob7WXz7VcW2vVJIl+ymif
         DtsIA/CliHTTsjmF5m0TikO7867fp+6gSTDWNVuL3FFExEU3lt/9RU9o82DqKRskInMw
         OUFYnwG/v9PfiyXeX5L9a3L/9VCdD2SY/k6Vd6j6Uk2h3tmyZSBVROJ0UxTUuA46x5zY
         sD3BGmKGBS535ty0/EQJhQEGQZ2DYWvrLvXb4IVftMe7RDGttpOuusFpaCgbrQ/EDJyl
         UGhvFjlABNB2orh/7PnnVebuPNvOjyXbkW4MeLCVvvFpXQM2O4n6Aevfb5DeH5PnK799
         WzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299898; x=1715904698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WWgoFurwAg8h9SR6wezGd5h5K+Y3bRntTGdapCnYLQ=;
        b=R9Cqsy/iXZcRhBmeLQrgxgSvnTGTvtMJrEqbYR5fX75TjqS2AaNKNDcgBGvuc+XT0/
         XXWNhFaMK0qsiEfpCbn1pWJ0Jy91/zz7dDfCscPJuQuUP0MUlUkehGIvtX1ceXWHz4ej
         4DQgO8QZsEE0CC6ZfToSdbN9LQm1kuJ8QW/m18GI9YZhIoiZqFpSx+nkq5NpHS8+oHNt
         vqLRAFnxSQGfhUZuvjdFxmGjtfermOS6MWSanBbLqiA0/VQn14iQ0iam1MmG89hbq1Dh
         Uqk3njqK8Eny69LflAiNqIlcEnVelRdVjyeJuwRwWQwNZ/ve1muqVf1jbG/B16DSt++8
         U1xg==
X-Forwarded-Encrypted: i=1; AJvYcCUta74wXhR8nn0namQ4WwRUigd7ucVyXVcNb8NeSNGD6R6GSmkP0OYPBME8/Vlsfp2JhVSxop/izGyUvZrqNIfM66PmgySQ
X-Gm-Message-State: AOJu0YxorZFsXWfBfS9+Vx9OwLoWzwgM+2emWIF7C9TcxJDeHWBm744v
	RIkAyfE36K8YtPCR7X9U2ZnfBN+VTGDuct44LwjGE3RA2gc8+btzV0nxnLCRfJ+jfrIeMgxK0mJ
	j+Q==
X-Google-Smtp-Source: AGHT+IHvqoyfuJd+zpWyzRtMJpM3tPkSIvIsjPanUafDlQuCX9siiHmpPTAd92EjaLgk71HiYZjK7/db9Q4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:b31a:0:b0:de4:64c4:d90c with SMTP id
 3f1490d57ef6-dee4f4fb5bdmr99366276.12.1715299898422; Thu, 09 May 2024
 17:11:38 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:10 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-54-edliaw@google.com>
Subject: [PATCH v4 53/66] selftests/safesetid: Drop define _GNU_SOURCE
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
 tools/testing/selftests/safesetid/safesetid-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index eb9bf0aee951..89b9d83b76f6 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <pwd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


