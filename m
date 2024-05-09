Return-Path: <netdev+bounces-95124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468C78C1728
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA30D1F2106F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DCA148826;
	Thu,  9 May 2024 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxx88+Sz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4631E1487D2
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285036; cv=none; b=RZ0UGAdI+S0MJb8DxY/Abu4zaIc3nDJ56BxmlSZOufazxoHCtsuPbk+GuZkZ4BAn0Udx4g/oul/AMOUPiUqAKPZMigVoPOICJThxE/kcEz2CtSPfBrhhZooxMo0MOfHTJxnbxQ+T0hoXdmrlnlhqF5u/LuRZKkKSKMVdC7gGiDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285036; c=relaxed/simple;
	bh=7wiquuIy2HmiwVC4XjxmaNtMUrPxv9NbPSe9jY3hsTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XjcMUiY+rZ5F24glevjttvRMOjAogYHLYEwg1fTRCueOhZD1AK4e5gIHT67oj8jUeJS03eWyDSU+FtqyE0GsawG7gg+KbFkTdpo9ITXzcy3xinZ5QDD2u6HNdsvi1NA7nEmDHuNoJBZcIQ1iKrcY+1WnKuLj3A7Wwv8IR5UsPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxx88+Sz; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so2114917276.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285032; x=1715889832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Da34EKHnCK9seOvE3VE8u71Ty/vHaksZJ1GNDYeo1pk=;
        b=oxx88+Sz06v0naCCHlb+wF1AFD/ZlK/nZgHB2P5R883k43PyqkciXYpMWsHNzUfQFb
         9YDTZ0R0dUufh2t+MGIaTh3upc6aBY+vt0tiwi2JjsRAy2oj4unxNfx/+ao0l36PGQnA
         XccK//KAWUWEj/9acPBtxcyxsNn5pVxvEItprfCSgEL5PZL53cLGIoUjn4Ch3AGuIHbH
         Wh22gBBw7HdKJefhBsIH0738te4x3w3eqkuyrb6gCI43c/Kshd1xZ25xSC6HCIX1HbNv
         H+rKWRVV7CPvqrM5EwUNSxxHcxlFPgm+BGJkBNOUwbwjwBIBtxmY0/udU5Ap4/U1fGkZ
         7d9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285032; x=1715889832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Da34EKHnCK9seOvE3VE8u71Ty/vHaksZJ1GNDYeo1pk=;
        b=EsFyLNt0mse1ISGmGkEYNHXZRZxF6br36H+Sz6Ic9DSBWxv3zEfBCDp1zFsRCl5eXv
         iijYCybhEZ+FDesREEkQ82F1+IJeAMZEa/o+pW2BJac2hLwoSg9TX1+tHqYYu7dEgrOw
         seyc1VSef76KGL39sUriPeKxGBKCbtfj3u3563NidFFq/uCs2yc5G9xXoiPAShjr1YFj
         l74SV5jQ0ohQ8no7JCc+OnCnVwh6DPGW/ACXPwW6LiTqIbH6WHT+dcPaZgzzVRfLXZIO
         ADMrsZ8N9tgYGrS0nWwtM9SqGUPK/sXR2P+gda1WzbK7gydZodQHycyrM195XfzRpiqw
         Y6zA==
X-Forwarded-Encrypted: i=1; AJvYcCXFrSKJ/FuQe/+xv7eqr1JIM50aMUHn4S6hK9z2arXsfS38D/1yMSEynFrH6kqF1r7rF+ri1bZ6zHfW0274XYX4QCaERkXh
X-Gm-Message-State: AOJu0YzpoylapM+wAXTfymnehQoOQpKUelfItQKmgzYhRH+eRvWRVmW+
	yD23APGsLB0NHctnVQ1BPLxqaOawmoiQJ8aEVtOfzvU9XpBto1L4u1XmVXdB3//R1NOW/+8cES9
	z9g==
X-Google-Smtp-Source: AGHT+IEcrTSWOKSKP/8y5gSbqy8Cg7jq9XxevNNU1pb6k757xhbvcE9eORBsQpvoCyyV8uYdVeGH/q8F0hU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1081:b0:de5:53a9:384a with SMTP id
 3f1490d57ef6-dee4f53a18emr149007276.13.1715285032313; Thu, 09 May 2024
 13:03:52 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:56 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-65-edliaw@google.com>
Subject: [PATCH v3 64/68] selftests/uevent: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/uevent/uevent_filtering.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
index dbe55f3a66f4..e308eaf3fc37 100644
--- a/tools/testing/selftests/uevent/uevent_filtering.c
+++ b/tools/testing/selftests/uevent/uevent_filtering.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/netlink.h>
-- 
2.45.0.118.g7fe29c98d7-goog


