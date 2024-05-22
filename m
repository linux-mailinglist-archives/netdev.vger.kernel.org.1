Return-Path: <netdev+bounces-97433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AC48CB772
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639FF282791
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179DF149E06;
	Wed, 22 May 2024 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJyjl3Ll"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE2148854
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339640; cv=none; b=jVSXk0Ujqx8MKLMGSX7rVowWxpcSznaKkdaw07nGwF7w0rSZeulyc+h5RpLEg6VMAkJ/W6yOmwg8W1uQL/nJ5PZEAqohxD1ZlbP3/7u0CIAz2l+wOrJ1NStIRBYU+9Rc0B33/iV/wOESzm4l1rTwHrDXpDRafccsnfEiXvh69fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339640; c=relaxed/simple;
	bh=JFhciCbc61MBa4XyewvFb1lKT00Bu3BgfLyFEhkBF2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOSkc5nqmVzNL28gKD1grRzNYgJ8nN7DVQ2S4Xr8a2o0TxI2ZxX72NVNmGqAntnWezH+CHhrIIutkPAmSn7PT1VgY7G6oWG+OAARgcsatF2JgKLuJL+vw0zox4BrmtCzFoHOvJ68/1iLY3yExsCv+3e6rkfPiSd/NqkBf+S1KYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tJyjl3Ll; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso299418a12.0
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339637; x=1716944437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxajjTXnYYVOFD9uBYzEDwXtIEu/3Rsj0ndr4XzJYGw=;
        b=tJyjl3LlC40c7l4MvoBWOON7OCzq0T3nLPe5vwJH9t2SN4J8/6rWW5ZI7jNkIi8/c7
         gsoILil87wyJfIRMWhee+QD1eQ25BFMB/oNT7+xp2xDHmK5gvl7e1GNhnLQHMbGCelNY
         Y4g+PXx/5Hd9R8Y+WTRzCgEAfDfLtK6oNbZiP6s4y/ma0sTVIGUk0yVjt59UxEOwd+H8
         DqaVM+S/EaOOlp/AQDtrQAH5vOSSr8LM3g+Om7Y+bhPaZ4bX7P9mZwef34tMM8fQig5D
         wz1ayQePg75RGvaxuxVDudCexW3ck2idYBGDSKJn4I252m0IyIwHJcvSZm8qNog/JkUS
         MVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339637; x=1716944437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxajjTXnYYVOFD9uBYzEDwXtIEu/3Rsj0ndr4XzJYGw=;
        b=h9or74jKwQJhiAgfwvcIWtdfHCs1gl2kbpKcYgHkKVhEhxb6LPkvvF86x72JGHaFEB
         85vDwmb4tscH7A6p+y7iK6xfvZRQ6Q5OoC7yItNXxncbB9ClYQpVXUxxpfPT8PogxfTn
         7I/AEBRsv4bZ2VDc9xWBs13nUmuIkKEvlpKFfalnWLA88iMkMPdlCWN62IiejjUugWzi
         u/j6dHEa2iXMbPK8hHbCxU4D0ZCg5p4fWcTBdJn578IfOn/xrvGt4yFABDIZn8Q/emBz
         2bviE0N4DxRApa7IU1LubnaOuNE7V7VSWh/LLePplLUcjQkmzFIPJ6yxWdQGH8FAFvUx
         mLeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbFqECEcMPm/H4TnxBlrwlNzHLN/KHO9t022FE3wHO6sEr2bKfv+llPyANpPj3WQGz8waDbVUPPadYIY9OS2fdHPWZVHp+
X-Gm-Message-State: AOJu0YyN1ac2EA1GlGRKPRHXJx3/Zt6TMBcduKqz7iBkSo2NPT7ln7+i
	SdPzclrGQwNDlNaHfu7Jspy89QeAUQX+222wGeawpr+7Lj6q4iW+UTpVN4NU5QjsibuHSkuv6/B
	A9g==
X-Google-Smtp-Source: AGHT+IEnjqQT67JKIH5im85s2TXusw89Zmodc/cXnUeHwbA1PsuQIpfWppspP0Q6xlgu0hmLR6KjvP2VuXY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:59f:b0:658:7c4c:25b with SMTP id
 41be03b00d2f7-67601b5a4c7mr2750a12.4.1716339637230; Tue, 21 May 2024 18:00:37
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:10 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-25-edliaw@google.com>
Subject: [PATCH v5 24/68] selftests/ipc: Drop define _GNU_SOURCE
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
 tools/testing/selftests/ipc/msgque.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index c75ea4094870..45aba6aa8e1d 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
-- 
2.45.1.288.g0e0cd299f1-goog


