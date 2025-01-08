Return-Path: <netdev+bounces-156284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB67FA05DB9
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59E41885477
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE5C1FE468;
	Wed,  8 Jan 2025 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GP6uZMcz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE4D1FDE06
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344627; cv=none; b=nKs/65X32suATLSJ/0bIF3px+GS1f84fF7BHCwFOaVy4Fowg4w4JW4beHn1tGLsZF/qkSU6LdqVAdrcprbXka7XpFpyi0hSNHF3WFtD8Z+jwLTfSNUZWwp2Fmykc5C2/QiUbHtLzdMObHE7Le5KViiF+2XGnk5JCqzQYc7fUXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344627; c=relaxed/simple;
	bh=dgb739Q2qPOzeOxuFTW//1gwqwRgxTJZnWz9xC0qBP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=XJVul4BfXSqwJNxOipabN6RlDqBWvd/0n0A4RuQcZ+S2yecFXBOEu+Rah7Q58qYw3Ldnc4sFAXxD7qp7XN2n5DfurLngoRy2CPyaygnOpJPpGJ4/RPLPboLAAbgmXB8wfPoJWm7nY5/ngVxChHztFUnMEP/FK2eKVdvwF9qQqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GP6uZMcz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736344624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FuXC58lKPSKnc9DIEAeVOgswaDFI/mCcftf/6xtmMb8=;
	b=GP6uZMczswN3s+pXT1aRnALwx+zGoG4Bd7GaKvg10VVTXsvxXSurcKIa/N/DZW2yBGFvr8
	RisgQVn9GHeNfrkRiR/y7aL3lYbgm5WikYrnXowHR4QXNfd8JXYszfmZLEQynCPeo3xNqK
	E2C5rxi09fVabFuBhlFdQWakm6/zRKk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-2Uwi93idNGGjo5JUGo1Fcg-1; Wed,
 08 Jan 2025 08:57:02 -0500
X-MC-Unique: 2Uwi93idNGGjo5JUGo1Fcg-1
X-Mimecast-MFC-AGG-ID: 2Uwi93idNGGjo5JUGo1Fcg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DD2919560BD;
	Wed,  8 Jan 2025 13:57:01 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.0])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE6F6300018D;
	Wed,  8 Jan 2025 13:56:58 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	jdamato@fastly.com
Cc: pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH v4 3/4] tools: ynl: add install target for generated content
Date: Wed,  8 Jan 2025 14:56:16 +0100
Message-ID: <645c68e3d201f1ef4276e3daddfe06262a0c2804.1736343575.git.jstancek@redhat.com>
In-Reply-To: <cover.1736343575.git.jstancek@redhat.com>
References: <cover.1736343575.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Generate docs using ynl_gen_rst and add install target for
headers, specs and generates rst files.

Factor out SPECS_DIR since it's repeated many times.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/generated/.gitignore |  1 +
 tools/net/ynl/generated/Makefile   | 49 +++++++++++++++++++++++++-----
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/tools/net/ynl/generated/.gitignore b/tools/net/ynl/generated/.gitignore
index ade488626d26..859a6fb446e1 100644
--- a/tools/net/ynl/generated/.gitignore
+++ b/tools/net/ynl/generated/.gitignore
@@ -1,2 +1,3 @@
 *-user.c
 *-user.h
+*.rst
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 00af721b1571..21f9e299dc75 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -7,32 +7,44 @@ ifeq ("$(DEBUG)","1")
   CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
 endif
 
+INSTALL     ?= install
+prefix      ?= /usr
+datarootdir ?= $(prefix)/share
+docdir      ?= $(datarootdir)/doc
+includedir  ?= $(prefix)/include
+
 include ../Makefile.deps
 
 YNL_GEN_ARG_ethtool:=--user-header linux/ethtool_netlink.h \
 	--exclude-op stats-get
 
 TOOL:=../pyynl/ynl_gen_c.py
+TOOL_RST:=../pyynl/ynl_gen_rst.py
 
+SPECS_DIR:=../../../../Documentation/netlink/specs
 GENS_PATHS=$(shell grep -nrI --files-without-match \
 		'protocol: netlink' \
-		../../../../Documentation/netlink/specs/)
-GENS=$(patsubst ../../../../Documentation/netlink/specs/%.yaml,%,${GENS_PATHS})
+		$(SPECS_DIR))
+GENS=$(patsubst $(SPECS_DIR)/%.yaml,%,${GENS_PATHS})
 SRCS=$(patsubst %,%-user.c,${GENS})
 HDRS=$(patsubst %,%-user.h,${GENS})
 OBJS=$(patsubst %,%-user.o,${GENS})
 
-all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI)
+SPECS_PATHS=$(wildcard $(SPECS_DIR)/*.yaml)
+SPECS=$(patsubst $(SPECS_DIR)/%.yaml,%,${SPECS_PATHS})
+RSTS=$(patsubst %,%.rst,${SPECS})
+
+all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI) $(RSTS)
 
 protos.a: $(OBJS)
 	@echo -e "\tAR $@"
 	@ar rcs $@ $(OBJS)
 
-%-user.h: ../../../../Documentation/netlink/specs/%.yaml $(TOOL)
+%-user.h: $(SPECS_DIR)/%.yaml $(TOOL)
 	@echo -e "\tGEN $@"
 	@$(TOOL) --mode user --header --spec $< -o $@ $(YNL_GEN_ARG_$*)
 
-%-user.c: ../../../../Documentation/netlink/specs/%.yaml $(TOOL)
+%-user.c: $(SPECS_DIR)/%.yaml $(TOOL)
 	@echo -e "\tGEN $@"
 	@$(TOOL) --mode user --source --spec $< -o $@ $(YNL_GEN_ARG_$*)
 
@@ -40,14 +52,37 @@ protos.a: $(OBJS)
 	@echo -e "\tCC $@"
 	@$(COMPILE.c) $(CFLAGS_$*) -o $@ $<
 
+%.rst: $(SPECS_DIR)/%.yaml $(TOOL_RST)
+	@echo -e "\tGEN_RST $@"
+	@$(TOOL_RST) -o $@ -i $<
+
 clean:
 	rm -f *.o
 
 distclean: clean
-	rm -f *.c *.h *.a
+	rm -f *.c *.h *.a *.rst
 
 regen:
 	@../ynl-regen.sh
 
-.PHONY: all clean distclean regen
+install-headers: $(HDRS)
+	@echo -e "\tINSTALL generated headers"
+	@$(INSTALL) -d $(DESTDIR)$(includedir)/ynl
+	@$(INSTALL) -m 0644 *.h $(DESTDIR)$(includedir)/ynl/
+
+install-rsts: $(RSTS)
+	@echo -e "\tINSTALL generated docs"
+	@$(INSTALL) -d $(DESTDIR)$(docdir)/ynl
+	@$(INSTALL) -m 0644 $(RSTS) $(DESTDIR)$(docdir)/ynl/
+
+install-specs:
+	@echo -e "\tINSTALL specs"
+	@$(INSTALL) -d $(DESTDIR)$(datarootdir)/ynl
+	@$(INSTALL) -m 0644 ../../../../Documentation/netlink/*.yaml $(DESTDIR)$(datarootdir)/ynl/
+	@$(INSTALL) -d $(DESTDIR)$(datarootdir)/ynl/specs
+	@$(INSTALL) -m 0644 $(SPECS_DIR)/*.yaml $(DESTDIR)$(datarootdir)/ynl/specs/
+
+install: install-headers install-rsts install-specs
+
+.PHONY: all clean distclean regen install install-headers install-rsts install-specs
 .DEFAULT_GOAL: all
-- 
2.43.0


