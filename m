Return-Path: <netdev+bounces-133040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87F5994586
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B3F1F257B5
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82CB1BC060;
	Tue,  8 Oct 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBQVv/AR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64818C32F
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383740; cv=none; b=jI3ZhRizSKlHbCkUmY5IjD/4kUgBLtvelywK6uAwszBCWkFfCB1HdVW5yLeTX/pHOY+rZyjqpduYPnyV/ZHfBs+Juq1BpTwZs1nejgls4QWAIx6JgJ+kfMrtuW/4wR54NocImfeJttVvlHhrCI8Anj279Bv4zuH0z91yxpdF35s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383740; c=relaxed/simple;
	bh=WUcIsxzdozoXzuX7b2XeUGypOM+OdSPbsKtFcoPe6xE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lkwTK6YEctw/JmlwuE4Ivt2DWZZYM2WNyHd+xRuu24zgNPLmU5Z5B/UbzkpuJVbSk9HEFn6K57W/ln6f28d3A4PYXxoFtHerfBmvkpzwunKv5VysTR/lnHATsZPrXOt3bF0QJe3Fmfdr3YdSvCwJW8ydIaedPIMqIekFxp1TXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBQVv/AR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728383738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWwE4mR8UgUEuS0dtcthvc4twWJQGG6zF+aNN8WtJI4=;
	b=gBQVv/ARbiJBbPlLUlbqLKiAjp5SXfzGTr2cGcNSw816nS+tfpZDRa4GorEYosnpIspD5/
	HXzV2sT6pT6WIZWqxAsxPyVS70Emdoq3udu1071ZuvwTXnHTI1EXY3ndZTzXPpgHhXFI64
	wrgC6jPMv7AEnRH6SDjQJ66Cb6UMLgg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-QXiIICk4N---DmfU6saZ2g-1; Tue, 08 Oct 2024 06:35:36 -0400
X-MC-Unique: QXiIICk4N---DmfU6saZ2g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a994e6c8244so186706266b.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 03:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728383736; x=1728988536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWwE4mR8UgUEuS0dtcthvc4twWJQGG6zF+aNN8WtJI4=;
        b=jXcVdqisMxQd5YXuTclbUJY1E3+B/HjUjMIAd3ZnPNqD6hQ+UWHAknXDMhfZiaG8Ur
         oEsUKnd/B8U8/xijSm1uMw5gpd0/y2FWV34tYTmtDYVQJrnGXi+7uwuJMzQPgcwNqleC
         czFHwVmc1UWMW8kHW36bHzjJTtrg/TTkfgF9h58dg9TWXT+T3R9j+/D2ad7K2oFwjngn
         4QVdB21RwkHS0zISuZZfEvMP5tspWap16F4SMmC/0vhfWjoodjX5t8rxHaHjak7xBhE5
         9dMx4Z7jb0yFzn7kDwzr84+MWWPdzSMk6BgRPmCETRlLRW0EKoXQVj9uH6zYQJysiEcA
         l67A==
X-Forwarded-Encrypted: i=1; AJvYcCWQAwSKzPx0oGfSmxCfulsCjT4hp5TbsVenJtERiXq+Ul3JctzQf8Uux5/qHCh9+uJePWNHZFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZ2JGlBCMJHcVcD5sviHUsno2oRYw66AzJIAmdquQ50NmN57n
	Q9T5z543V9WfM8Mkjk1iBBpicI6c1U+aLsjl5Fyjkal7mDuLOSKu0fUXnqyuc91KxSds6BjBgYO
	zq8k3lT+qm35+DhciWuL4fe7B2jTra9Med7u/5l8acU8eG8gnnQV69w==
X-Received: by 2002:a17:907:318d:b0:a90:41a9:7c3e with SMTP id a640c23a62f3a-a991c0af160mr1517007766b.65.1728383735696;
        Tue, 08 Oct 2024 03:35:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1/nMNFhRHrZX/Ta+Ms02g+SMDncRE8XhwNr/i9kDjUsTs4Zqs4vi4pmb2/JzpucQ0P4EcYw==
X-Received: by 2002:a17:907:318d:b0:a90:41a9:7c3e with SMTP id a640c23a62f3a-a991c0af160mr1517004366b.65.1728383735182;
        Tue, 08 Oct 2024 03:35:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993f0d00e3sm422335966b.193.2024.10.08.03.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 03:35:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EFAB515F3ADB; Tue, 08 Oct 2024 12:35:32 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 08 Oct 2024 12:35:18 +0200
Subject: [PATCH bpf 3/4] selftests/bpf: Provide a generic [un]load_module
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241008-fix-kfunc-btf-caching-for-modules-v1-3-dfefd9aa4318@redhat.com>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
In-Reply-To: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Simon Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

From: Simon Sundberg <simon.sundberg@kau.se>

Generalize the previous [un]load_bpf_testmod() helpers (in
testing_helpers.c) to the more generic [un]load_module(), which can
load an arbitrary kernel module by name. This allows future selftests
to more easily load custom kernel modules other than bpf_testmod.ko.
Refactor [un]load_bpf_testmod() to wrap this new helper.

Signed-off-by: Simon Sundberg <simon.sundberg@kau.se>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/testing_helpers.c | 34 +++++++++++++++++----------
 tools/testing/selftests/bpf/testing_helpers.h |  2 ++
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index d3c3c3a24150f99abd13ecb7d7b11d8f7351560d..5e9f16683be5460b1a295fb9754df761cbd090ea 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -367,7 +367,7 @@ int delete_module(const char *name, int flags)
 	return syscall(__NR_delete_module, name, flags);
 }
 
-int unload_bpf_testmod(bool verbose)
+int unload_module(const char *name, bool verbose)
 {
 	int ret, cnt = 0;
 
@@ -375,11 +375,11 @@ int unload_bpf_testmod(bool verbose)
 		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");
 
 	for (;;) {
-		ret = delete_module("bpf_testmod", 0);
+		ret = delete_module(name, 0);
 		if (!ret || errno != EAGAIN)
 			break;
 		if (++cnt > 10000) {
-			fprintf(stdout, "Unload of bpf_testmod timed out\n");
+			fprintf(stdout, "Unload of %s timed out\n", name);
 			break;
 		}
 		usleep(100);
@@ -388,41 +388,51 @@ int unload_bpf_testmod(bool verbose)
 	if (ret) {
 		if (errno == ENOENT) {
 			if (verbose)
-				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
+				fprintf(stdout, "%s.ko is already unloaded.\n", name);
 			return -1;
 		}
-		fprintf(stdout, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
+		fprintf(stdout, "Failed to unload %s.ko from kernel: %d\n", name, -errno);
 		return -1;
 	}
 	if (verbose)
-		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
+		fprintf(stdout, "Successfully unloaded %s.ko.\n", name);
 	return 0;
 }
 
-int load_bpf_testmod(bool verbose)
+int load_module(const char *path, bool verbose)
 {
 	int fd;
 
 	if (verbose)
-		fprintf(stdout, "Loading bpf_testmod.ko...\n");
+		fprintf(stdout, "Loading %s...\n", path);
 
-	fd = open("bpf_testmod.ko", O_RDONLY);
+	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		fprintf(stdout, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
+		fprintf(stdout, "Can't find %s kernel module: %d\n", path, -errno);
 		return -ENOENT;
 	}
 	if (finit_module(fd, "", 0)) {
-		fprintf(stdout, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
+		fprintf(stdout, "Failed to load %s into the kernel: %d\n", path, -errno);
 		close(fd);
 		return -EINVAL;
 	}
 	close(fd);
 
 	if (verbose)
-		fprintf(stdout, "Successfully loaded bpf_testmod.ko.\n");
+		fprintf(stdout, "Successfully loaded %s.\n", path);
 	return 0;
 }
 
+int unload_bpf_testmod(bool verbose)
+{
+	return unload_module("bpf_testmod", verbose);
+}
+
+int load_bpf_testmod(bool verbose)
+{
+	return load_module("bpf_testmod.ko", verbose);
+}
+
 /*
  * Trigger synchronize_rcu() in kernel.
  */
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index d55f6ab124338ccab33bc120ca7e3baa18264aea..46d7f7089f636b0d2476859fd0fa5e1c4b305419 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -38,6 +38,8 @@ int unload_bpf_testmod(bool verbose);
 int kern_sync_rcu(void);
 int finit_module(int fd, const char *param_values, int flags);
 int delete_module(const char *name, int flags);
+int load_module(const char *path, bool verbose);
+int unload_module(const char *name, bool verbose);
 
 static inline __u64 get_time_ns(void)
 {

-- 
2.47.0


