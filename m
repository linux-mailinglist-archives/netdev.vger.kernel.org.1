Return-Path: <netdev+bounces-95197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37528C1AAC
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5BB8B2167D
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6471312AAD3;
	Fri, 10 May 2024 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NfPYhVCZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2446FC01
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299803; cv=none; b=Z+f4JVtTGNxvcDCZXwJYXiFVrHnueRsZo+KUVd12f2vAfE8+a7i+o9RhXD4G+TNBGpA21CapNxvNCNocObznpTsCAkU3f59gf+cZEUeVVqy0JNM0j15FJRcqzXkDnNEl09nEWLHi+A1uIcF+GD/KKeOVU1FnC+LCzIjOt2oO75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299803; c=relaxed/simple;
	bh=qbmkyF0+P08/z/Fp9ZayOXH0wErOspB3sKr8OqJ3zqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cOVavpxCcTVu2lm/mtJ3zuTYXZTp5tiM/AcK0Png/8Sw7Wf9lh+ATW0cJKrqqXtBaAMtDCg1EhrBVhQuAWN9Rzk4P+czpi2WZ3KV1795wzrhM3plWfS3vngvXOz1HSek593Gi3UoWpNYHW2+qTemOf0R5RZidt+vXBpzne5K1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NfPYhVCZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de468af2b73so2511150276.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299801; x=1715904601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7gmE/+1tJ7Ep2oqmr2taMm5VZCwXrcQv9eKCkUAc/7U=;
        b=NfPYhVCZw8/6vRnxi5mwooE+sTm/zS4DcErqO33jFYRyYjxzUKVdolwxgomkX2Ur0R
         l65rmdSEdY6cSGQS/D6c4smxibXHNbmVgSLEge1gTtRdZ4W68jzDEsAWU6Gs72xLTRL8
         4ouG9L5f2HTZNxuyhOd/8DyoZlA7eXJ/uJ+PlXoY9PXE6k9MRljXDE47D+2hm2wrheGb
         SmTsrODv/3QPkAQm9/qbZcqKJ6r6FtbKdH9eyRlM55uvZSBjgsF0uIPMyUejVOpn7X3T
         MZZ9Okt7kpx2w7E/mv6ekgov6pH+DfgUx7XD+sVAV1arj7MSiefc1FLNxKnGYhdow8tY
         PrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299801; x=1715904601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gmE/+1tJ7Ep2oqmr2taMm5VZCwXrcQv9eKCkUAc/7U=;
        b=Cx4AOM+2pOu01Sh5T11PDccAYSzNrVEw7XA+1n+QGW/9zKbCLpoM2lphMqmVe7WIKl
         wbkGZZggFe7OpZmECsdq+OVN1tGkHCiNji0bZR5HwwnMdsYl4DxjB+alOwPwzSh+cjGF
         ti2w43HEOToCqI/MzdoQ5NpVb1BocFOUhICRwNO9UnxQV7F5zs07FAk0BC+97nx9BIoB
         Q4M10+cTGWSzYNs37Gd/JiT1bFORWALm5OgHRrDqjWfH8OFQUAWWq7OIQuCpK1GPVtnp
         02H4zZmpjqOTlK5m3GoRTJ/ketRPwmqrJN+I5w0ImG8OSmc/gBwvFWOhUwe6MWY83jLa
         c4yg==
X-Forwarded-Encrypted: i=1; AJvYcCWfzPjcjngE7Im743EwYioofVfYOa7hu+oMlv+y/2z3+uU6JQSImg4mjNrvMdUCoYK11q7gf8i3Nuvm6Gbp5Fjz16r8oqoM
X-Gm-Message-State: AOJu0YycRbbk2OR+sXMf9g0Uw7KzSyKZqV9LG6Pdr5H631MyWvIsBR9E
	KP03ay6aHo4oVEPMN8XbuiOD1X80j/c+zybVyOESJBauJObnFxQWL0WjNBMa6E669vmtpZxjhsx
	h0w==
X-Google-Smtp-Source: AGHT+IEoDu0ZcQdyPuiQJKnDncyGUY3Booo+z0EW8VBY1J3sHBK3DT/V9Dd5nwidmRrvGe1vHB9FlAyGRV4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1002:b0:de5:9f2c:c17c with SMTP id
 3f1490d57ef6-dee4f37bbfbmr289205276.9.1715299800737; Thu, 09 May 2024
 17:10:00 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:37 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-21-edliaw@google.com>
Subject: [PATCH v4 20/66] selftests/futex: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index a392d0917b4e..f79f9bac7918 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
-- 
2.45.0.118.g7fe29c98d7-goog


