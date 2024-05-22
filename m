Return-Path: <netdev+bounces-97474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497058CB84B
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917DBB25F00
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE9115CD6B;
	Wed, 22 May 2024 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZ+xhW3X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA315CD40
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339760; cv=none; b=aE/pcugopnHaU3Bnoz7zvTQJp1wbWQtZtsn1vPUdJNL3ePKz3PFfQHXX+v3oXQH3F6OUHyVp6GIUdUFif/pVKN/Ml3X0WhQGhyuGBUqii+uypp/wAQJV7MFtfkDNUBep8hvp3nrAExpQ9OYWvYD0APov1I5pLFq0+j1akv7ggqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339760; c=relaxed/simple;
	bh=4TJ9KnGVL7+630dLfE+B26mDy9GQEt32Ng1AK59vk04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=svU+HGVu81B0EXeGcEzqNTItGRsKaQ5iZE1ZRuGxYGtahdScrEFFWnX76CdBozv9uBLhGUurYrP/owkAJoJhK++EX3Q+uA/Gc1N/WxDACT7+8x5MIHVb0U3RBZRlA2OSBLoZ26zI6hFH0xF9ndnniF5yOMW7HLyDQFlosrGzHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bZ+xhW3X; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f2fbeba118so30885295ad.1
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339758; x=1716944558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EY5v4vW6zuGUWHn5v3Q67qpIi54gAcWCg0e6EyybCAo=;
        b=bZ+xhW3XF5p3WUl6h3YDmNelPNKHBtgynK7HIuwayLHp4DS3jkNIYQkCLcQe8RGjVU
         DW7a3+HhtbMjWvbI5wHAgCoH3YWEAkhRDE8r2JFNE5mhNKReYC+WW58KJf0L/9r1SbYm
         Kl24t+i2Pi4FCm/8IXLxGgfLTyUcHKVzw8l34BnhT3mFkDXUTXPwHC4XTSPBIWRbVGEf
         v++KLTreaJR9jV+0haHcRMDJYVBm7k+732cD7IwyZgLfoS+uIjtm7i031p5HAgI3x8Cp
         ZRlJYXcXgI0ow/0ttMK9wjakyy8MS8sVj0HiD3n+TGwXO0NGkO/LQJkVKR6fT+v7V1VH
         kXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339758; x=1716944558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EY5v4vW6zuGUWHn5v3Q67qpIi54gAcWCg0e6EyybCAo=;
        b=nA8dG2aNiztLDEGOHnLs5Ml9VGKta3m7zCXhbC3SOybbaqOp22dKxQ0E31BL7/yl3C
         3reBBdWSRgdGtaDBS3t1y+qfwg7Hgak+Kdv130QsvaOJscnuWHayj4iB9BBwFYkMTcUh
         gweRzZDXxLi7xFfuC8COFt1kMM740cl8Y1cS12k9wgigqIjkZquvt8Uk1JpzNgi0mBa3
         RP5I/A/vj34AmpAEWRoKymGQc/UXKLutiSRoVBxr6D3sAhwCRSWIGT7s3zAuAWV8U0Ak
         XXQ+HonB/HfMbNZzfzZCx3Nv1HGu2SVHCbEcl4pliM05Ghu9e1MtxPEqzrZgIQD/jywX
         CW7A==
X-Forwarded-Encrypted: i=1; AJvYcCWB4vMdGd19z+gFDRosC8WPJn+VhHcjygakXQxcvRv2BmX0VhbzJV24eyM8WSrmdqjD+wKxaANKklVVUQDDmQNbwycDuIV3
X-Gm-Message-State: AOJu0YxC8qXtkzxwsR33wW+gbs4W+YztTG23u3dEST3mAOd8kSMEQxI4
	SKXOyAxqTWzR1kWgLp1BYivW+t4Fi1Ast3i10Yb6NZcYwwr3IRG4wuDmRddGYecqFWuU+OHJ82J
	Jrg==
X-Google-Smtp-Source: AGHT+IEx273+qW/DV4uOgH8Knay37/ukzBb9Gp8aRj7jknrJ931FW//nLLnnBAL0LEjWeDb8f6l1RtSdL7g=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:ecc6:b0:1f3:82d:95c0 with SMTP id
 d9443c01a7336-1f31c9dc851mr382085ad.12.1716339758083; Tue, 21 May 2024
 18:02:38 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:51 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-66-edliaw@google.com>
Subject: [PATCH v5 65/68] selftests/vDSO: Append to CFLAGS in Makefile
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

Instead of overwriting the CFLAGS that is imported from lib.mk, append
to it instead.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/vDSO/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index d53a4d8008f9..fd36979435b6 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -12,7 +12,7 @@ TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
 
-CFLAGS := -std=gnu99
+CFLAGS += -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
 LDFLAGS_vdso_test_correctness := -ldl
 ifeq ($(CONFIG_X86_32),y)
-- 
2.45.1.288.g0e0cd299f1-goog


