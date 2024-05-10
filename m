Return-Path: <netdev+bounces-95223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 093328C1B3A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 898C8B245A5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6993713BAFB;
	Fri, 10 May 2024 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3UAtSei"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3582313B58A
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299885; cv=none; b=Ee67gxfxzSw4LIELFFtV++wPs6SuNsGOsblYhEamOGP/xht1Ut0C7RmMeVluONi/qsB4Ed6MxctGkh3ovzj0RO7S70atyMEjNnfBF37J76gvXaYf1VsAyP10YAk2W2ax/3jvX7PeQbCPXgLRvD8BJrDk1Gtu/KjHFLg1jiyW35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299885; c=relaxed/simple;
	bh=IyUlAGHuB4F0ACGEqw9XDD1VWDnG6Gr5lWYbpcHYvy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=msELwUoX6zGj2aQWITCBiCBX9YZ+MPpH5uvJTywIEAsAvyI/wFdEo8L+/Dy7WCrg8voUGhwXx4IRuoFa1a16oETyIjuJCWKAP2rMujKGfPFV1/jkIZ8uYiq7ZTzMgct9xd7nAglEwba3Qsk7bQH8XHfulMMNZ5Uo0rHvSDbHRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3UAtSei; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0c296333so30243287b3.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299881; x=1715904681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=N3UAtSeiPrlt9OW2F0rY6m+iv9lq7dDYhKPowMfiXC0i4M50l9Dq0C9BY4cBKpwwg7
         4g6Mso3wfhFFxAlqDrz2MZQMJX/BVKKsTSO0W12iZ0mWIZagIVaL1MDW33UdTQmbTbE+
         lwyQuyKgkExHf0eOHbu/v+DVpB7mWUq0XdsaAJICDUe9zrvd7cg7OddH7V1tZtlvSHwD
         HKgaAxuHATqOmhoKn76xQshp45Ob9vFkc06thVQ8OpsulnW+BalfUaJQ8pXpEpDV7geb
         suWaXWhKX4tDdAjpjzOtOqlzSVoqjniLl6CS3BH4zRnuPDy/NZmeoCatx+ZfUc/pCvLo
         spTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299881; x=1715904681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=JDRqr69EgxtLXncLuXTDANWvchMSOmYIKGZdOiinGcGDJNL604+CBkcDyV1OKL/Dqw
         aEYmrA6dMYxALsTIbrZJ5Xb/jEhFI2RJrs++w63KIOxzU2kFqJKRr7O6anPW1FigdXc0
         vMy1VXv4xgle7e3xwk55qfdxn9zPu9HHUTqKk/ysBNysA6QhCHV7Dy4ubex7GohLKjI3
         aMpUo5O3z/bxuNsi7TOk435llg8f7nlREpaBS4JhGjb8egYRtidiiixTzLAZWdJ4VYJe
         AKbH0uNRsPjDF/V2OoErUTvYg+maM/Xwm09lhptO/NeJX2998iLK2eKzfCsNP+LPOIva
         uclg==
X-Forwarded-Encrypted: i=1; AJvYcCXrTAnTlrbO5xsddnOadfbsfyOT//gkjH2ZqjE5w/AbmzJGyO1IHe548MkAnvNR8XFp6zI2uxeh8C8iDBCLOh7ZAugu+6fs
X-Gm-Message-State: AOJu0YzyhhAiUxCdkjGn6PkzG1ez9UkkQIpYA53joMGuM4WHN0M6xIiI
	IrNtZKWPNgkk4nnRIQxdmkFtj/QOghJ+eyAiGGRmNW5slJaL/gFXucC0oIXV96DtT/Tr1eZT6wx
	IGw==
X-Google-Smtp-Source: AGHT+IE/x9wCS8dXfiCveNKLMUww3zuulXyRB+TBegOeq8yRgm7kXDMXOCAjHlMh4xirNEVxhfl/HnwXW8Y=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1004:b0:dbe:d0a9:2be3 with SMTP id
 3f1490d57ef6-dee4e558e2dmr363352276.3.1715299881350; Thu, 09 May 2024
 17:11:21 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:03 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-47-edliaw@google.com>
Subject: [PATCH v4 46/66] selftests/proc: Drop duplicate -D_GNU_SOURCE
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
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index cd95369254c0..25c34cc9238e 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
-- 
2.45.0.118.g7fe29c98d7-goog


