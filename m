Return-Path: <netdev+bounces-239578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60370C69D8B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97B4F35AE7A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC3359FAF;
	Tue, 18 Nov 2025 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q90ZFRD2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3518E358D26
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475054; cv=none; b=AuAGvTw15RRc+6775u0lZnmsqG2Q9bmxrOby400HcAW+eBBCkaO+c4GuTUBS9jvcIik5iCQAHUwb6SYqvXJIQpyfM7sPRzayy7DVMwwP2cvhc87wB1GywItsQBa4o5UJmFsBWHPvbH8HgovgDWDDSQQAssVxy6u/1DSSJ27WkIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475054; c=relaxed/simple;
	bh=dHmHkgxwtVGP2qlrIIp+KtfQ11f/l805pWFr0tUyMak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guTRv6aDH1yW8gHVlUSq9cJhQRItlFZbWXkZENfPC32iZc/CtpQ06hH+zmFtsPtpQ+vhKavPNp/Jh+/nc5RhGMAPq6UXgIYQzGFIVZ2BrHLcBCZrZUovceoYzdEi1OHLyy6mla5gvoCSv6WpEOJIwFfswWt6M7a7O3y4hOze9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q90ZFRD2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763475052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCG6zWED2vtpkGlo/z+TFGbepyg457VloAXrSIFah48=;
	b=Q90ZFRD2cRLfKQtBk64lDJViNtL1lPKJ2tTQAAR/CnHN94Oh9w/stloseLo3G1zRZsM4pd
	L1IUJvl3S79Ak+Cd65louxT/t/nRZKirEFnHaHZ3V1miu9v2ShYSJn8rnwXOKwBZJz3j8i
	QR2VfrNkQWH0fSQdL5W1kTfcg6DLQLc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-zxAvkqK8Mg25GtpulH6S0Q-1; Tue,
 18 Nov 2025 09:10:49 -0500
X-MC-Unique: zxAvkqK8Mg25GtpulH6S0Q-1
X-Mimecast-MFC-AGG-ID: zxAvkqK8Mg25GtpulH6S0Q_1763475048
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FF4919560A3;
	Tue, 18 Nov 2025 14:10:47 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.225.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F01003003754;
	Tue, 18 Nov 2025 14:10:44 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	ivecera@redhat.com,
	jiri@resnulli.us,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next v5 1/3] lib: Move mnlg to lib for shared use
Date: Tue, 18 Nov 2025 15:10:29 +0100
Message-ID: <20251118141031.236430-2-poros@redhat.com>
In-Reply-To: <20251118141031.236430-1-poros@redhat.com>
References: <20251118141031.236430-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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


