Return-Path: <netdev+bounces-97439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D71C8CB791
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AFFB23F0D
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF3C14C5A5;
	Wed, 22 May 2024 01:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phSMDsef"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203ED14B977
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339655; cv=none; b=huelUZN6KNPvBGlc19BZIORzlm5TmSHmpYO6VCaRnHORV97DUxYYj4Za1ALufq1bWpHsGM5OIT+XIkUK1XdSvw83xHh6/BopYru4SKi21JVIwpNjZ71UkgOgr7Ks090/OEW6W6J2JuyOveG1V1/RSrhEs86UA/dAyUlq6T1Zo1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339655; c=relaxed/simple;
	bh=GLz+NiSWIjggktWvXvCcxV3SQNfJgybR45MEAL0/SM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L4KUAFxTeOucgN047Gl2RrD0bVeMZY3zVCDCDbx+0UOM2SF0lZbSrJdByX97TE5B9MWL+dmpsELB9t/XhJUTrtsv/Jpuxgykz57uUlxMPOXyejf7qQQ8x5BCOgRHfyr69egT4nerzH2LpacIaahTT1WNiGuXYtkrBoaZDIZv9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phSMDsef; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b265d41949so12213222a91.1
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339653; x=1716944453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVf/OpY3d2Q/Mya51rq/+c3LTiKmdxaF1eraxGBViHY=;
        b=phSMDsefeA2sbkUfbGrtDhUbKgOqAmIJEDa6t6Ot3Sc9JJD2auaf2auLgw/fC7ghQ+
         d+wOIzPtrNJgIWdungvxRRm2x/vhlPlnA+3ka/FmZboN+kmZJQbwa5gw/TQwTzt01Rsc
         2B3zMcEIG9xSaUeeMj4Tm4ULLEnGlGGl7+1W7wicfbFGpb2U+hoM1SZDY3Ay9hWGeqbx
         2hd6iHS+UYSvWDw1dpm8zH+J7MPCUouQrMjZXHuGRf5RkMjcWaZpAQRi/rUcLo06NHr8
         iXqRJ5ONHnGdZcS/u5s0VgDqnjqBZFtZIL4dBAYZP2jlTRqaeCpe+lTUuUB0yCgFwNA1
         L5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339653; x=1716944453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVf/OpY3d2Q/Mya51rq/+c3LTiKmdxaF1eraxGBViHY=;
        b=LXxD2jiyG2SeyQJtZTrnAQ195h/YI+iiIy/hOyLSMfL/2sEWUGxsyfNjSoCZIGJhIe
         Dr7qWjZj9XC0Yg9tDj18+QRSB2H9zRLcIzvm4dUj+we3cKQ5loMNKjHjbbhDDwkfa4BR
         f10TKssE7EnG0cErybeMlag++YhrfuWzduOJFvR8IxlskqI77rUqQ7k21evP8vrrJCnn
         jBdPugab6f//MkCe5n+m8GsfcHamtSinv0TXMYi5OcmmArHvMI7rwTdKEI6ub0Pk90gd
         tbITfYEPfGaTXFW71yPeVo21Bo+776A4ds7I7mtjnyxsdVTQVSt/aNjnxg1RtzsvyyFp
         QEYA==
X-Forwarded-Encrypted: i=1; AJvYcCX5dexf+y8aIaYDj5GIh6AfvLdj9FDe8aJ4A5smXpdQScgAA+R3J6Gn8Y/w9Q+Yq4L/cB0WmMJM7qEACM4btNdP0pJcfdD1
X-Gm-Message-State: AOJu0YxupMqjrEcSywPkXCiZHI9WS3yRZS/ZCUQxDn1U1euqKLj6yPrv
	NfTw0KJV28Dnth7OM3AUYamS1zTsvnXL5safy0Q4/GNZu5o7e9+2sdKOvJ4vr0hGA+mjWZIhWOJ
	jAA==
X-Google-Smtp-Source: AGHT+IERmvjUACU1dGq+usdhCn15n3wBhF0S7qzqPTxOiEhahwny+LRi4B/1JnjPnSFaHmLZJYt2JZRastY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:1195:b0:2ac:992c:4c71 with SMTP id
 98e67ed59e1d1-2bd9f5d9a10mr1843a91.9.1716339653260; Tue, 21 May 2024 18:00:53
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:16 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-31-edliaw@google.com>
Subject: [PATCH v5 30/68] selftests/mincore: Drop define _GNU_SOURCE
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
 tools/testing/selftests/mincore/mincore_selftest.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index e949a43a6145..e12398366523 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -4,9 +4,6 @@
  *
  * Copyright (C) 2020 Collabora, Ltd.
  */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
-- 
2.45.1.288.g0e0cd299f1-goog


