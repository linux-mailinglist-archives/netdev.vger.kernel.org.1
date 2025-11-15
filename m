Return-Path: <netdev+bounces-238903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A87EFC60CC0
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 00:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8BC3351D75
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 23:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD721264619;
	Sat, 15 Nov 2025 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghuwx7YD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9824A069
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249637; cv=none; b=qVVvjzvbKdXr0QfIzfJq7BJ7eF1UVt9AVGgZFizZrrshFHtGKbrvIPx/tpdN46kwYQGn+YUtUYrAf996yERsedPmecRwkiq+CZnWOS5/lWl+8NWG3spUH/L8Y0RzXLZOmSABWKN5Kux+TQDrcGAfEjNTmLL1CDGemWD8XLYb3rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249637; c=relaxed/simple;
	bh=dHmHkgxwtVGP2qlrIIp+KtfQ11f/l805pWFr0tUyMak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGfl3XSA/KKUBDKeTTvjyCFJ5YfRiTW/SBd8eKw0/uD7x0untb3uB7tEL2YqJSU2hl82Cz3UFFSqM+jzEqwo5IynWwXOXZI1rhgR99YBdk43HKb1COFa+g/LR6SK/uptb2WpcpXsH9yU1fUMFPM0A6IJN6wmNDXFPaByBCaGtxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghuwx7YD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763249635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCG6zWED2vtpkGlo/z+TFGbepyg457VloAXrSIFah48=;
	b=ghuwx7YDp3WoarR6gmoM0ydE9go4FVvxyweMamT6VUs5bUB+Zo3SaXYvDRLwdJ7efQ/MkZ
	feSf9Wm6JXtDWREqaW+P3Dvri8aCxby7gjxJt7BAvjfOsGVjNJ4Ytus5v1+IEq5ThdCLuk
	Lzxyxh3+t7VG7Zj6up8JFJqA4ZvSR14=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-r0pKoMfiO8aNFYlMPxOGLw-1; Sat,
 15 Nov 2025 18:33:51 -0500
X-MC-Unique: r0pKoMfiO8aNFYlMPxOGLw-1
X-Mimecast-MFC-AGG-ID: r0pKoMfiO8aNFYlMPxOGLw_1763249630
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A92018D95D1;
	Sat, 15 Nov 2025 23:33:50 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA2CE19560B0;
	Sat, 15 Nov 2025 23:33:47 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	ivecera@redhat.com,
	jiri@resnulli.us,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next v4 1/3] lib: Move mnlg to lib for shared use
Date: Sun, 16 Nov 2025 00:33:39 +0100
Message-ID: <20251115233341.2701607-2-poros@redhat.com>
In-Reply-To: <20251115233341.2701607-1-poros@redhat.com>
References: <20251115233341.2701607-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Move mnlg.c to lib/ and mnlg.h to include/ to allow code reuse
across multiple tools.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 devlink/Makefile            | 2 +-
 {devlink => include}/mnlg.h | 0
 lib/Makefile                | 2 +-
 {devlink => lib}/mnlg.c     | 0
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename {devlink => include}/mnlg.h (100%)
 rename {devlink => lib}/mnlg.c (100%)

diff --git a/devlink/Makefile b/devlink/Makefile
index 1a1eed7ef6e440..ec62f0c69d8e0d 100644
--- a/devlink/Makefile
+++ b/devlink/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../config.mk
 
-DEVLINKOBJ = devlink.o mnlg.o
+DEVLINKOBJ = devlink.o
 TARGETS += devlink
 LDLIBS += -lm
 
diff --git a/devlink/mnlg.h b/include/mnlg.h
similarity index 100%
rename from devlink/mnlg.h
rename to include/mnlg.h
diff --git a/lib/Makefile b/lib/Makefile
index 0ba629427cbb2d..340c37bc945a4f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -20,7 +20,7 @@ endif
 
 NLOBJ=libgenl.o libnetlink.o
 ifeq ($(HAVE_MNL),y)
-NLOBJ += mnl_utils.o
+NLOBJ += mnl_utils.o mnlg.o
 endif
 
 all: libnetlink.a libutil.a
diff --git a/devlink/mnlg.c b/lib/mnlg.c
similarity index 100%
rename from devlink/mnlg.c
rename to lib/mnlg.c
-- 
2.51.0


