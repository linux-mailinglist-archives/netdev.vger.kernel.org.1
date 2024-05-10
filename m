Return-Path: <netdev+bounces-95192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6418C1A92
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDF51C21EB7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CF6DDC3;
	Fri, 10 May 2024 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMwzbfWA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886E5381A
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299791; cv=none; b=aBl51ECNIGZi/ptcb9SeeaaNLacABezQ5vez4qgO1Nciz+7d+4DBqV5MbRejDcnHCmjhXC0HiCTy++1zm723xGGKWjuPLm7ZMCsdUGoUgE+2/NqGCxu4DsKF36Z2ua99wmjZPEVl01VBBMH4ieW+wxDXkKEx96reXYDSgI1yjlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299791; c=relaxed/simple;
	bh=fU2P3ohii6eOx7fFDBDMrp0qI5AdjDGRbNifJZQ3D6o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mTTL6oZHtDxGNCKBzRYXcBzlSZZGl9DgojW13TUiWQSWwayIVb83DYtwrv7rA/N3Aq7L07RA8CLgA/TWjAs5c7/sTQ3ubriQyQvIC8b5GbDbndIMqYgqkdobGsHSVDwNwD+zlWUKTAIetFMQrYxUp55dZHzhUCNLHJR1A5zKZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMwzbfWA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61c9675ae5aso23905517b3.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299788; x=1715904588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uqtc6lb/bjRHtHw2HifamjvJeZYo3Iv/aojOVKqDLuc=;
        b=iMwzbfWADYzCPMDndmgHFn00o1+BKONgdmpKKz/Wkkr0HLzaVF+J1f3LYTBpjPATO+
         0GPhQWJzqA2gUUTcg+Bmrch6B2+wMsCg0mtPwSgddyM+8YVxwytm6PLuWox3nzv5bHYl
         1RMApk+i2xo/cf7eEQ+o/AL47bG/eqQXgxgvlynmEP59kSiVaObm6e3Y8vqpB8mKd00Q
         skYW+49pWncMcJcj2JYo5kTodhI8irLgyi5+7pV2nM7EyJyuUOc//Jf/yhcbUIS9Q6bq
         8oIrnGXkObXCVOw6znLLe+uq+nJg7ys9+I1VpcNjI0iu8k+n1BEK8wvPxu04Hgivfgx+
         bdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299788; x=1715904588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uqtc6lb/bjRHtHw2HifamjvJeZYo3Iv/aojOVKqDLuc=;
        b=QTdBjT2PkJ8TXXxofKL2vDuZm+lg3b89/aC1ASFiBg1TOJ2jqrlG3vPNm0RA4D4+Aq
         Vgg4wGwnkApWltnDChG/4XQb+SrBvPq/JjC3OajqGg+ATU8eIujxkQxKEfJp/SdhbrDI
         LcNR8R8xIabI6p1P8dT9xRB6zuquJIkWP6kz1b+Ued61JJRkYH9PPMvii/QVgixohDM5
         IoeCX+Y/9wUMADJH8+LWKE4S+9hJd2q0xZPYWwsYxgYklJ9vDYZpFn8ENqIzfRHBdk+O
         IllPrpiSDZYtDtUp4vF6G1TgG2HQFmoU2mtTWcch44xrahJij7fvQA0BuLoAMz9xXwOP
         4gpA==
X-Forwarded-Encrypted: i=1; AJvYcCUpLSqZEPnYmteJWYwj079tNAPAeERh70GCtHrZQkXp+fDmWfYtXHdsP9KKnT2lwwxSRYTPLHxp0jEyTHE2JZ9a1hU4cbCV
X-Gm-Message-State: AOJu0YzUSoXugo3wmFYg+td2WuIPrYsnHNNQOa5ipYMCMpk5WaIqoH+6
	B3f8UnqjdDsE6V9EM3Dg3XYDJP7b2VbGa/RhOJJCC0QVCmSyzev/6nSEScuXuJjWIqT/93ZvV3G
	laQ==
X-Google-Smtp-Source: AGHT+IGVLgMcKP7k6+jbHoBvicQj4jJfGTq3ct3mJmsySja7BFFB2IfjyDeVqng7lmOeRf+Hm3qC1VhoGlw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6211:b0:618:8bdf:9d56 with SMTP id
 00721157ae682-622afffb2b1mr2640537b3.7.1715299788317; Thu, 09 May 2024
 17:09:48 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:32 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-16-edliaw@google.com>
Subject: [PATCH v4 15/66] selftests/filelock: Drop define _GNU_SOURCE
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
 tools/testing/selftests/filelock/ofdlocks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index a55b79810ab2..301c63ddcceb 100644
--- a/tools/testing/selftests/filelock/ofdlocks.c
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <assert.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


