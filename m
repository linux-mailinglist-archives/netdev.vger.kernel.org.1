Return-Path: <netdev+bounces-97471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DAE8CB83A
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CAA280FB4
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C665215B115;
	Wed, 22 May 2024 01:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wuX8x+Cj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6B3BBD5
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339752; cv=none; b=PriS54UzErEfbpB2STQtVRgZD8iCfdAftzsuS/mjxSToats9/W3hTo89hV8CAITx+2B/WPJQ2uivdMNKF/oRZ0ZqmojNUJsKFyGiElMX/OnYQECYpuI0oV5r7/1atPmB+FcKSBdIhZ3JyA9JrFXZplDNiGez/KLm6UEhCjA6iGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339752; c=relaxed/simple;
	bh=wwHClzW3HS3k2rxcD4xGD4N6MPHNqeSCS7dmFIcppCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FKl8GZGPn0hPcvj49MVIULuFnvzAd+lEC419aee3Soa6XVd1ZyQckkNV9u/AYGZLeou7J9fLkIJ9nkd5ct9xVCNRhe8zDp0wXU0I4HiwYu3Wfjf6FU0WbihbzyuMZT0GSzlMYBJGUdZC1x3VTfmToOFindRWJCkXV4E6eD+sjt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wuX8x+Cj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b3773153feso11296614a91.0
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339751; x=1716944551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/alAv/4/ktSZrlS0Fd5uW+NL7frJ+JSUceLln6ipw0=;
        b=wuX8x+CjchNTr9X9opshIhqVft6MqCMBCtr5VA38Gljf19w/RGAGdV7FcG84sMRt0b
         otwPYBEprSfBW7bSogSTU4p6z4TcjIWHI6oCg7OGtS2FiMEECiknKtEOd2wtvhrO3ZE0
         5i3oRS1BoD4AvPbSZ7lURZ3MlYaExtWsSOKgd1Jpa9mgj2/IApdqwFSg28PqgLwY+LrY
         JOHdv3fEqlRGcNAqsTtWlvyr0HKsapg8DggCdrFhKIE9IgRNvTOhn4xb1ih/c9l6vGKw
         uPGKwrYKrBY9Um/ntaXZ+W0Dw7ZqOR/IJfpyV1Jf9IzhxXFfU8rbli7nRikY//HXoIUe
         C3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339751; x=1716944551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/alAv/4/ktSZrlS0Fd5uW+NL7frJ+JSUceLln6ipw0=;
        b=MaEimgRBWHTdS43llD91g1P4KO5k8oiS+XTY0RFUCcs4LOuDOWa2ifMnO1bJBau7IG
         4vdilhcIhMSnIkVoYzQI4nT/4Ywh48fpt/WaWUw7rzOm3oIhTEq/maccSsXJ48qSOym5
         nMIR9+CcBjum0yjbKDa451sco9AEZI0ektHj4/okHWhAlEAY2oe79siFbMIlzEqnT7IN
         TuqeXBwcC1rlSYQdEUze2CWJYm9Px7ORZfekiPLC74rzVleL2aLg13ehDRHoZ0wRp1kT
         SVQj5b5dn1BsTgt3tP4wXOb0C9bhv975yK6LFihNq9WilnVQqKOIBQLxwvuN5OGw+a5S
         C3OA==
X-Forwarded-Encrypted: i=1; AJvYcCU/AzKTCaLOQ5FLaoyOXVmO9nIG02eb0RMSBfnILTgLCehtEl1NtsAqihAm1JUxj1/ZpHHBzd9Vu89qn7g17byR7fEjCgv8
X-Gm-Message-State: AOJu0Yzcr9oIrnDnxgABonNYR6/iSfskF+yQNfAOE2DWytGoehGRpqRK
	Q3Dkag6nAiyRDNimIUGNlXLQC9u8IOuQlfFYd1JbfrxZQRiqurg34tFO48Z1DnAGS9gANk9ldA0
	fMA==
X-Google-Smtp-Source: AGHT+IFKRYUemB9bQi8KmbkmxRhMBRRK8qY6EnK/nEzjCpEKdmTU9GKLzNY+XB779KpN4GXjVpxm8X7d6Ns=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:3008:b0:2b2:804e:fbb8 with SMTP id
 98e67ed59e1d1-2bd9f5d4c18mr2338a91.5.1716339750670; Tue, 21 May 2024 18:02:30
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:48 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-63-edliaw@google.com>
Subject: [PATCH v5 62/68] selftests/tmpfs: Drop duplicate -D_GNU_SOURCE
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

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/tmpfs/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/tmpfs/Makefile b/tools/testing/selftests/tmpfs/Makefile
index aa11ccc92e5b..3be931e1193f 100644
--- a/tools/testing/selftests/tmpfs/Makefile
+++ b/tools/testing/selftests/tmpfs/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2
-CFLAGS += -D_GNU_SOURCE
 
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += bug-link-o-tmpfile
-- 
2.45.1.288.g0e0cd299f1-goog


