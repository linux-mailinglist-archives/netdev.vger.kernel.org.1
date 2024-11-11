Return-Path: <netdev+bounces-143752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74169C3F3B
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156051C21A4A
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F31A254E;
	Mon, 11 Nov 2024 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4fuJPSI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9722A1A0BE0
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330316; cv=none; b=tNRadP78kOGIM+rWiNvSu/WqSLkTnZZqMeTpmCaH+uOyIr9gDaM7EG2mobQ2H+vcc9cma41bQ29Lz6oIozNEG55lWZpblRuvJ0vHFqQnMlSr3WTk+5ESm1wJ4ReIqjZIYfmOavqORO+4C13HszWFQsbNf1yLgqoGIBSKRadmiDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330316; c=relaxed/simple;
	bh=uG/pFbMdG0e8ZG2tWJC+Gb85Mz0eh9fzdCCob6utzRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=UJjTQPVJGs33n0+83CzX+erDfeMd5SNoQJ1HL3sH69DfiVefDdiVMzc2qa+O79lyvf6PXP4qncQp2USFELu688INt5FsMJkREffqpyUcmUnM5TP8S+IEENH5z7pkxFWXKpCOR+1feVpiHXQTzRCZpDJk3EYfXhpimYmdictVH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4fuJPSI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731330313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmezhH3dme05Z9rNAI3jZBuchcKR9CtW8TfuwIxI3EE=;
	b=X4fuJPSIjkUsLLqGNU09RVnHaEACW3kk0U22GtXN57gIqLMbhvqPp542tJb+SeNenkr8Xk
	scI9fagmlyHnP5OkeQmFVqo+yZGPjm1gCZq8M7D9WkYI3Y6IaF81xbo/SVl/AJpxhBIlLd
	W3GN49WyFG5C2uiuf9FpgBfjms9ooHY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-cyZ7HJ9TMwCS9_8Vz4IjXA-1; Mon,
 11 Nov 2024 08:05:09 -0500
X-MC-Unique: cyZ7HJ9TMwCS9_8Vz4IjXA-1
X-Mimecast-MFC-AGG-ID: cyZ7HJ9TMwCS9_8Vz4IjXA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 096A91955D62;
	Mon, 11 Nov 2024 13:05:08 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 151E71956089;
	Mon, 11 Nov 2024 13:05:04 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH 2/2] tools: ynl: extend CFLAGS to keep options from environment
Date: Mon, 11 Nov 2024 14:04:45 +0100
Message-ID: <f462afa3cc8d9bc7e7d5e21f1ff7cc3d1d4f02f5.1730976866.git.jstancek@redhat.com>
In-Reply-To: <cover.1730976866.git.jstancek@redhat.com>
References: <cover.1730976866.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Package build environments like Fedora rpmbuild introduced hardening
options (e.g. -pie -Wl,-z,now) by passing a -spec option to CFLAGS
and LDFLAGS.

ynl Makefiles currently override CFLAGS but not LDFLAGS, which leads
to a mismatch and build failure:
        CC sample devlink
  /usr/bin/ld: devlink.o: relocation R_X86_64_32 against symbol `ynl_devlink_family' can not be used when making a PIE object; recompile with -fPIE
  /usr/bin/ld: failed to set dynamic section sizes: bad value
  collect2: error: ld returned 1 exit status

Extend CFLAGS to support hardening options set by build environment.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/generated/Makefile | 2 +-
 tools/net/ynl/lib/Makefile       | 2 +-
 tools/net/ynl/samples/Makefile   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 713f5fb9cc2d..7db5240de58a 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CC=gcc
-CFLAGS=-std=gnu11 -O2 -W -Wall -Wextra -Wno-unused-parameter -Wshadow \
+CFLAGS += -std=gnu11 -O2 -W -Wall -Wextra -Wno-unused-parameter -Wshadow \
 	-I../lib/ -idirafter $(UAPI_PATH)
 ifeq ("$(DEBUG)","1")
   CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
diff --git a/tools/net/ynl/lib/Makefile b/tools/net/ynl/lib/Makefile
index 2887cc5de530..94c49cca3dca 100644
--- a/tools/net/ynl/lib/Makefile
+++ b/tools/net/ynl/lib/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CC=gcc
-CFLAGS=-std=gnu11 -O2 -W -Wall -Wextra -Wno-unused-parameter -Wshadow
+CFLAGS += -std=gnu11 -O2 -W -Wall -Wextra -Wno-unused-parameter -Wshadow
 ifeq ("$(DEBUG)","1")
   CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
 endif
diff --git a/tools/net/ynl/samples/Makefile b/tools/net/ynl/samples/Makefile
index e194a7565861..c9494a564da4 100644
--- a/tools/net/ynl/samples/Makefile
+++ b/tools/net/ynl/samples/Makefile
@@ -3,7 +3,7 @@
 include ../Makefile.deps
 
 CC=gcc
-CFLAGS=-std=gnu11 -O2 -W -Wall -Wextra -Wno-unused-parameter -Wshadow \
+CFLAGS += -std=gnu11 -O2 -W -Wall -Wextra -Wno-unused-parameter -Wshadow \
 	-I../lib/ -I../generated/ -idirafter $(UAPI_PATH)
 ifeq ("$(DEBUG)","1")
   CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
-- 
2.43.0


