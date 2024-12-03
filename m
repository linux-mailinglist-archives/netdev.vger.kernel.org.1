Return-Path: <netdev+bounces-148418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EA09E1771
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFD51653AD
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38221E0B7D;
	Tue,  3 Dec 2024 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpnEbj3O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5071E0B6F
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218058; cv=none; b=T+QAHC1qHcAESBiMBwLc0uWXpTtNfILppJ4wNA3Th2sXrBAT/+KW597FfafaVdbO0i3+xmgcFAVS6h9WFGKrxxt7ROcEkkm7bwJUsKtXxgKgWlFU97Ez/ChRi7K65YkfBIWgy/zL2HYP+NtzF43Sf8UZbEnw+11uyaUmzkd+HIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218058; c=relaxed/simple;
	bh=bQAv1UxQssB3tMoCrEaPaH8YhrV81zDOO65SEhBhWbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=eKnoo1z+gp0ZE7MJEU33Zr7/THIx9BLtdiymEB8Ed39cq9S+OvmpOfSa5qE9ZBey6T+8SVQQdR72FbG+xU6h+zU/R1ViXvlMbzv0grLgN2zhFGXcQerWleauT4waZSA/eZltcDH4+cLDpEUAqAZ3R+etxL8rd/Mx/e1+GUU2Y0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XpnEbj3O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733218056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CKW1cKzOvQu3PHZh9xUbsjiPM1Bs37pILAwq3THS0w=;
	b=XpnEbj3Oh55Fsf7PcI7bHtsEJaVv/dWVwoigDbw6lH0ZdOD7b6UbsonJnTYASN7Pl8RxeI
	byl8t6BmE9nlGuGwChpWfDBZyBxQKreM0bgXLqMsQsSbw+ZBQQ7Paj71wia86xRmxUw3eD
	Xbojy30o+JF3icK9C0+v0ch1KvuV660=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-tEqySOjNO7eq6scrrNViFQ-1; Tue,
 03 Dec 2024 04:27:32 -0500
X-MC-Unique: tEqySOjNO7eq6scrrNViFQ-1
X-Mimecast-MFC-AGG-ID: tEqySOjNO7eq6scrrNViFQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EBE81955F3C;
	Tue,  3 Dec 2024 09:27:31 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AEAD1956052;
	Tue,  3 Dec 2024 09:27:28 +0000 (UTC)
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
Subject: [PATCH 4/5] tools: ynl: add install target for specs and docs
Date: Tue,  3 Dec 2024 10:27:03 +0100
Message-ID: <d2448df420b3a6631bc9fbae6a4619c0b519e302.1733216767.git.jstancek@redhat.com>
In-Reply-To: <cover.1733216767.git.jstancek@redhat.com>
References: <cover.1733216767.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Generate docs using ynl_gen_rst and add install target for
both specs and generates rst files.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/generated/.gitignore |  1 +
 tools/net/ynl/generated/Makefile   | 34 +++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/generated/.gitignore b/tools/net/ynl/generated/.gitignore
index ade488626d26..859a6fb446e1 100644
--- a/tools/net/ynl/generated/.gitignore
+++ b/tools/net/ynl/generated/.gitignore
@@ -1,2 +1,3 @@
 *-user.c
 *-user.h
+*.rst
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 00af721b1571..d28509ac0573 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -7,12 +7,18 @@ ifeq ("$(DEBUG)","1")
   CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
 endif
 
+INSTALL	    ?= install
+prefix      ?= /usr
+datarootdir ?= $(prefix)/share
+docdir      ?= $(datarootdir)/doc
+
 include ../Makefile.deps
 
 YNL_GEN_ARG_ethtool:=--user-header linux/ethtool_netlink.h \
 	--exclude-op stats-get
 
 TOOL:=../pyynl/ynl_gen_c.py
+TOOL_RST:=../pyynl/ynl_gen_rst.py
 
 GENS_PATHS=$(shell grep -nrI --files-without-match \
 		'protocol: netlink' \
@@ -22,7 +28,11 @@ SRCS=$(patsubst %,%-user.c,${GENS})
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
@@ -40,8 +50,12 @@ protos.a: $(OBJS)
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
@@ -49,5 +63,19 @@ distclean: clean
 regen:
 	@../ynl-regen.sh
 
-.PHONY: all clean distclean regen
+install-rsts:
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
+install: install-rsts install-specs
+
+.PHONY: all clean distclean regen install
 .DEFAULT_GOAL: all
-- 
2.43.0


