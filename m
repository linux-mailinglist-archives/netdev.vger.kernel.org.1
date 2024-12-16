Return-Path: <netdev+bounces-152152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045E19F2E6A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915EA1889124
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDAD20458D;
	Mon, 16 Dec 2024 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzhMpcBG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9C204C3E
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345741; cv=none; b=kEFTizlobWxmO2C/QkXX+oCBYo2I50PM1unPY/DOQIJWx/2UqKpB8dqJj1Q3S4RHyESlhZEQqs8ZgfR1QGbR1wivTHRBxmjvdEqltLmZxQWLzyjQFHT9+SEKXhwcpGSHASV8G/F+fMxZXaqC/3+x2IuScc3ZXOPb8PGMeLXnfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345741; c=relaxed/simple;
	bh=N/wUQLAnBME2XdtaW/dnTdqAPs0z813+/Aguh8OsAro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=lc9xteL0VZfWDFhtT6UTEklv+G9dnNx+0BAgwBIyopOX1bX7+KCql1E5YAATmq9zpo06zOX2eTju6+I31S+2nOB83fc5gY8fQ+Dj3Muai9n4awJ4NvFqVpgUxeCZo2vXZvziullqvh5T45zrTbUjlRtqCI77bdPxh7/5W0ex8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzhMpcBG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734345737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n40TTeyeXxDATT9p70QeA8QlaNAyq8YWOLnuryY7UcU=;
	b=OzhMpcBGHAJO8xSTu621l8jKvcyMo/6xx4iDOUq5ifhRMnIXwx0PCDGGj456uFmp/B2EeU
	ZPhgTapY/+HwLSxM1r46Tk+NXR3CausXuddzZUvazieVqIEGSLulpGCDhxDg/7WmuexOOL
	anOkTMFU7rpqeIiGiLhwL1eDcq7YYR4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-Tn1MnRscPUaILODF89rHHg-1; Mon,
 16 Dec 2024 05:42:14 -0500
X-MC-Unique: Tn1MnRscPUaILODF89rHHg-1
X-Mimecast-MFC-AGG-ID: Tn1MnRscPUaILODF89rHHg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5B80195609F;
	Mon, 16 Dec 2024 10:42:12 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.0])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04F4E3000197;
	Mon, 16 Dec 2024 10:42:08 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	jdamato@fastly.com
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH v3 3/4] tools: ynl: add install target for generated content
Date: Mon, 16 Dec 2024 11:41:43 +0100
Message-ID: <a2e4ffb9cbd4a9c2fd0d7944b603794bff66e593.1734345017.git.jstancek@redhat.com>
In-Reply-To: <cover.1734345017.git.jstancek@redhat.com>
References: <cover.1734345017.git.jstancek@redhat.com>
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

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/generated/.gitignore |  1 +
 tools/net/ynl/generated/Makefile   | 40 +++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/generated/.gitignore b/tools/net/ynl/generated/.gitignore
index ade488626d26..859a6fb446e1 100644
--- a/tools/net/ynl/generated/.gitignore
+++ b/tools/net/ynl/generated/.gitignore
@@ -1,2 +1,3 @@
 *-user.c
 *-user.h
+*.rst
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 00af721b1571..208f7fead784 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -7,12 +7,19 @@ ifeq ("$(DEBUG)","1")
   CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
 endif
 
+INSTALL	    ?= install
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
 
 GENS_PATHS=$(shell grep -nrI --files-without-match \
 		'protocol: netlink' \
@@ -22,7 +29,11 @@ SRCS=$(patsubst %,%-user.c,${GENS})
 HDRS=$(patsubst %,%-user.h,${GENS})
 OBJS=$(patsubst %,%-user.o,${GENS})
 
-all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI)
+SPECS_PATHS=$(wildcard ../../../../Documentation/netlink/specs/*.yaml)
+SPECS=$(patsubst ../../../../Documentation/netlink/specs/%.yaml,%,${SPECS_PATHS})
+RSTS=$(patsubst %,%.rst,${SPECS})
+
+all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI) $(RSTS)
 
 protos.a: $(OBJS)
 	@echo -e "\tAR $@"
@@ -40,8 +51,12 @@ protos.a: $(OBJS)
 	@echo -e "\tCC $@"
 	@$(COMPILE.c) $(CFLAGS_$*) -o $@ $<
 
+%.rst: ../../../../Documentation/netlink/specs/%.yaml $(TOOL2)
+	@echo -e "\tGEN_RST $@"
+	@$(TOOL_RST) -o $@ -i $<
+
 clean:
-	rm -f *.o
+	rm -f *.o *.rst
 
 distclean: clean
 	rm -f *.c *.h *.a
@@ -49,5 +64,24 @@ distclean: clean
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
+	@$(INSTALL) -m 0644 ../../../../Documentation/netlink/specs/*.yaml $(DESTDIR)$(datarootdir)/ynl/specs/
+
+install: install-headers install-rsts install-specs
+
+.PHONY: all clean distclean regen install install-headers install-rsts install-specs
 .DEFAULT_GOAL: all
-- 
2.43.0


