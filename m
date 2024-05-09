Return-Path: <netdev+bounces-95099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55D18C16A6
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66221C21066
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6711F13D897;
	Thu,  9 May 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRxG1DeM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8713D610
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284965; cv=none; b=DnF0ddayqrlaTh1LhMaCGZn0K31D4jq/LcLnrkKnKrjILbXVWQ1V7KHB/N6UBf1JViexr9hWXfa86J75CNXIMCAnDQpv1Fn/jljEYxNPDKP7VOsZaQD3yyRRB2ytdWRYeta8Jv89Sv4qn8Cck7D6Usfi30yPqeSJ4ANufR5n6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284965; c=relaxed/simple;
	bh=DaG/27qWh2/JZ9Z87R2vLxvxszcgvyNhPpNxQzRNES0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a9pTENai+vAymiQXIcQmjCVlCYl8pFQ1yg1bbc5yoTD5H/1MjlEfthfWCj071XP3PRczfIoWjFT54zsd7q5B0Bbm682rXL2wmnfNcpfAL6Fqoo6N1Nf5E1I5l8zJpKqdFmHeDiWDgIenrgJT7oMraoZ6bnmXuTiDBK5mJ/xpmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=fail (0-bit key) header.d=google.com header.i=@google.com header.b=gRxG1DeM reason="key not found in DNS"; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ef9edf9910so1233788b3a.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284962; x=1715889762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m279s+e6M30hZxl/PZzqmSNhzRgg4yVrloVP9fngHJo=;
        b=gRxG1DeMUp8MWa0CV/ABlrv1NaJpJWM8QNLH0u1SYQcBEzZAeB9HurZVJwxcvmVBgA
         aLYX9G/JKMVGwGT8mxD4d/XOMON9M98ZL9LiH+oppQ/AX48EuCUYcvlmx24ulNKeFLP5
         6TTHz5D0P6ItdykHyqqfpGWQssUBTWypUqtsbF8QtWDI3eN/i99l3bMKRCHI672xl+G+
         sEVM+ekmhFbnX+T88nT57hMlj7NiRYkiKRxr3ceyVh7CgmCl0PMTIENtbjrP2zRwda5c
         3X97rgOWbE9aVqR22aLfu+wH8Jt22/HHbHi4mmOZeUuJTjxykUu6u4PM1Ajh7pI8B+nR
         oUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284962; x=1715889762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m279s+e6M30hZxl/PZzqmSNhzRgg4yVrloVP9fngHJo=;
        b=BFPMDRw2JHoMUh5C5rgykupZg78yfEYmn+HGr2S6F/HKAtI2flA2VpQhVbAz8ayeIC
         pJP2/Mcyx/a2XQA4za0pp8kemMckLJvdrur6FNpsD/LC4vjcEIncACd8bJvqo2+TDYeN
         QidSvDtsa5T+eFS1LPpl4MZQBpG6q7BwYuJ7RgZYv5abOAiC3SRJUNDohCMwaOUVgcgZ
         HI7vZ0dSxPSOszllDKVwHAih1m6Nkyiv/VCeyp1dTFyYzShO0ECbwzLeDuTM/TZyl0Xi
         h8TFvbkVBlHFNjmbYLuenADZzSNMCgwCmlF3cCVykioRfr7sWfKwRcgaTA2dYNdAF8bt
         DdoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZlo3IB+81UU+G+XhG+0c15s3poIsVPdW0FDM6f+OrtBaFMl3D6x1ZZOh8vedco2dGBdUKTl/Ls8+69K4do9rT+Onio+Sw
X-Gm-Message-State: AOJu0YwDQRakQplavMQG2Km20rbXY8rwntmArlHAyQKT46TVx3UaU0rK
	lDxm9R8O0iO4dJDVEOIhIpdRt3b4RPwpvcafqbxMB8hpqLmWHl6v3sNX0H7eC6MMQDs+EOncylg
	PDA==
X-Google-Smtp-Source: AGHT+IGCr5mZelKS9iX9bRXqnB7kjyhmCMgwx5eyUHoa4Y3/aN3G/xPHARYQx5VNmnnQO5Sez15H5lzxkdg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3a0f:b0:6f3:8468:432f with SMTP id
 d2e1a72fcca58-6f4e0373b47mr9098b3a.3.1715284962387; Thu, 09 May 2024 13:02:42
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:31 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-40-edliaw@google.com>
Subject: [PATCH v3 39/68] selftests/nolibc: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Willy Tarreau <w@1wt.eu>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <linux@weissschuh.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 94bb6e11c16f..a28813f4367f 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #define _LARGEFILE64_SOURCE
 
 /* libc-specific include files
-- 
2.45.0.118.g7fe29c98d7-goog


