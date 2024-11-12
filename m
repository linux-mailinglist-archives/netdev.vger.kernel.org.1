Return-Path: <netdev+bounces-143995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 723C39C5077
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA801F22F4C
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9BE20E01D;
	Tue, 12 Nov 2024 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhoNivtf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761F420DD7F
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399723; cv=none; b=ucNgMaScrM7/P/nr4VoYW8RUGdjTWBwnf46uJp+eB+kvXBNpcHgupqlwWcHmkORMkfJ0r45jYogsF2XOAoeDmDEyWKExgFWQOmDA1LUWbQoJNnhstRVVs1NXS3eVVUf7KCqzumh4RO+OrfCnavlT7k0YXxdM1YCofMnXn/4lbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399723; c=relaxed/simple;
	bh=++XM4V6wI8Xhdiajd405Uqj018PNtVWC8MQcEcxPG/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=hI2iSvSEK/srjMtKGNWOseZnadSKd61D4kUE1EKc9oUkdeKCP5LWc3JI+ltQhy/kT5b2VlpdBZqxSUB9bmuHmYQHwlIu+6dG8gQ7qSXvRwf79QY5qWw8BGKjalzpEjHQBx1fMdvHe9b9K2E0pIBsYa+hi6TtPCBaCTLbUkQsBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhoNivtf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731399720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DERHPlYAHqCx/cx8+YLoEZT9A/bzMvqhAmeVISrWXXY=;
	b=dhoNivtfC5Sk1if4bBWeUOpmJB61lNA8cX6yV0qUnd7Wu2OQa4ptupHfJ1Sz+7LHDpiaf3
	zwD5LsVIDN5qpxY3e69e2axRdKcdmZe4Ybl26/9V2n5fXmMypBe3N42PsWONs9w0MEszf7
	Dx+FZCYSX62aZRJSrOu/G9TMm4TEeo8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-qOkbjITmMU-Qfl-0NivRRA-1; Tue,
 12 Nov 2024 03:21:55 -0500
X-MC-Unique: qOkbjITmMU-Qfl-0NivRRA-1
X-Mimecast-MFC-AGG-ID: qOkbjITmMU-Qfl-0NivRRA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB5D71955F4A;
	Tue, 12 Nov 2024 08:21:53 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74A0930000DF;
	Tue, 12 Nov 2024 08:21:50 +0000 (UTC)
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
Subject: [PATCH v2 2/2] tools: ynl: extend CFLAGS to keep options from environment
Date: Tue, 12 Nov 2024 09:21:33 +0100
Message-ID: <265b2d5d3a6d4721a161219f081058ed47dc846a.1731399562.git.jstancek@redhat.com>
In-Reply-To: <cover.1731399562.git.jstancek@redhat.com>
References: <cover.1731399562.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
Acked-by: Jakub Kicinski <kuba@kernel.org>
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


