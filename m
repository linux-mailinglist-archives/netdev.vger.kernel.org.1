Return-Path: <netdev+bounces-238659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB081C5D019
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FBF3AA969
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA22B30B51E;
	Fri, 14 Nov 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7c5PO79"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03112191F91
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121972; cv=none; b=Yr1dwPtxLVkW2/ybCeXHOz96uaF+hh5IOw3qvSEQWtk/m9UClASY556ac0vYGcd4GbJg0iwM8hMb8nmi3CJKMVGiIJq60TSVs7gMf3edWi85Sv9/a8CGBNGQxiiG95dasAIpzzfyC5krH8g5EBcbpWWnjFwrBEDmpUKrnOU2bqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121972; c=relaxed/simple;
	bh=dHmHkgxwtVGP2qlrIIp+KtfQ11f/l805pWFr0tUyMak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omwymwLJovBKx9gYwPPohsRBOWT3sqQBgr7m4rw4VzPIyvCyA+lOuuXws7f221y6ZUMB6ZQX003/rsj/z1W2g/v66lpTtddHebZkapj5ccOb7KcG6FuEZtCgYdhMTT9DwY4TVOgy+yP55kX8ibaEkCddzCgifp7TB3wc3iAK3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7c5PO79; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763121970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCG6zWED2vtpkGlo/z+TFGbepyg457VloAXrSIFah48=;
	b=W7c5PO79XbUsR9lsMHEvZofZHfrZx2VQfy2gie6UNiAWt06DKRRCXp9NJnTJmZPfpVTfID
	0jTqwffEgoEEEJaQ8igOg78vZ/efU1i4PTZSODbx2ATX057ALIZ1Kt2lq2TBPk1BEX2pMw
	kfAb5lz82HxxeScZhfk+PYYUmxWbmA8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-egwm5G_mPd-0ygdqDZyb-Q-1; Fri,
 14 Nov 2025 07:06:06 -0500
X-MC-Unique: egwm5G_mPd-0ygdqDZyb-Q-1
X-Mimecast-MFC-AGG-ID: egwm5G_mPd-0ygdqDZyb-Q_1763121966
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 973D8180045C;
	Fri, 14 Nov 2025 12:06:05 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6384F19560B9;
	Fri, 14 Nov 2025 12:06:03 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	ivecera@redhat.com,
	jiri@resnulli.us,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next v3 1/3] lib: Move mnlg to lib for shared use
Date: Fri, 14 Nov 2025 13:05:53 +0100
Message-ID: <20251114120555.2430520-2-poros@redhat.com>
In-Reply-To: <20251114120555.2430520-1-poros@redhat.com>
References: <20251114120555.2430520-1-poros@redhat.com>
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


