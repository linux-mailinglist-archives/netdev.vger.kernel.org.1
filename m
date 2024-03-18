Return-Path: <netdev+bounces-80445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6359187EC9A
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 16:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBDA1C20B83
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928D524D1;
	Mon, 18 Mar 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="SujP5SMa"
X-Original-To: netdev@vger.kernel.org
Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C14F61C
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777051; cv=none; b=WWmETR6udYK4SjdZdrT3MoMVjkx9lJgaNONnFYlZ7Yh57sH3mCLlPc5FRdoWUKzzOk+Anv62/M83m2nvyJ0TxaJJRZjc4Uuhm+8yi8EWj1Exn6vMjtlvIEmafHbx6+BXyjIsmxFjJul4fAwX/C1xEubNI1qDtV5CQV43YCvuVNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777051; c=relaxed/simple;
	bh=KCBkYioUDNmpy9quFijr3Fr37zEL+AJpOMwJq/70KTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ksqh6sjAm74q26IbDCOQdD5ubEf9XMFJdIThugiT46BdcREKto5mFygpPfpQDG8b6Aoi157PoiR+OrdAUQuAywT57E6SuY9IWbbKYCWfmQZdYF01GVOrVLekS+QPUraCNlNWSZc5A6YDHo5XXepTUmqa2/B1YI8laMI5qkzpqCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=SujP5SMa; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Received: from localhost (unknown [IPv6:2001:910:10ee:0:fc9:9524:11d1:7aa4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 6C9FB60327;
	Mon, 18 Mar 2024 16:50:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710777047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RcUZpxKU67ixyFV8o8+oe1vN3sYTUJrMS0BD1T/DsM=;
	b=SujP5SMahvFg+mJT/VjiwyPvb6r80VzwI4h+a0NqCciJwZ6nztQnzzIVWaZuNw1TWNBSoO
	XzM9YN6MzwSoGFY+ytz+VOl2kJV7+x1EYbkWpvGyePZz1aVWxGi2zTHW+djM28amvRLMiK
	1LfJwPsHJfcI0V6WniBPT0vw/cf2eN1Ss4KKg/txALU/g7VGGix1lPFNQEBBlZW88l9lF7
	LDw+Er4kF2UrWvr3s6IoHUNfdudgRcBvYVO+gSj15hTQbEAQ8GpoEUnIkohTNifMODIKYi
	Z7v2qBGjvT0RiMBxRW7Sp5DFGw7eZjQ9+7us0lyBS0XII3fTC4G+7LEqLluZQQ==
From: Max Gautier <mg@max.gautier.name>
To: netdev@vger.kernel.org
Cc: Max Gautier <mg@max.gautier.name>
Subject: [PATCH iproute2-next v3] arpd: create /var/lib/arpd on first use
Date: Mon, 18 Mar 2024 16:49:13 +0100
Message-ID: <20240318155038.29080-1-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240316091026.11164-1-mg@max.gautier.name>
References: <20240316091026.11164-1-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The motivation is to build distributions packages without /var to go
towards stateless systems, see link below (TL;DR: provisionning anything
outside of /usr on boot).

We only try do create the database directory when it's in the default
location, and assume its parent (/var/lib in the usual case) exists.

Links: https://0pointer.net/blog/projects/stateless.html
Signed-off-by: Max Gautier <mg@max.gautier.name>
---
Some slight syntax changes from list feedback.
 Makefile    |  2 +-
 misc/arpd.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8024d45e..2b2c3dec 100644
--- a/Makefile
+++ b/Makefile
@@ -42,6 +42,7 @@ DEFINES+=-DCONF_USR_DIR=\"$(CONF_USR_DIR)\" \
          -DCONF_ETC_DIR=\"$(CONF_ETC_DIR)\" \
          -DNETNS_RUN_DIR=\"$(NETNS_RUN_DIR)\" \
          -DNETNS_ETC_DIR=\"$(NETNS_ETC_DIR)\" \
+         -DARPDDIR=\"$(ARPDDIR)\" \
          -DCONF_COLOR=$(CONF_COLOR)
 
 #options for AX.25
@@ -104,7 +105,6 @@ config.mk:
 install: all
 	install -m 0755 -d $(DESTDIR)$(SBINDIR)
 	install -m 0755 -d $(DESTDIR)$(CONF_USR_DIR)
-	install -m 0755 -d $(DESTDIR)$(ARPDDIR)
 	install -m 0755 -d $(DESTDIR)$(HDRDIR)
 	@for i in $(SUBDIRS);  do $(MAKE) -C $$i install; done
 	install -m 0644 $(shell find etc/iproute2 -maxdepth 1 -type f) $(DESTDIR)$(CONF_USR_DIR)
diff --git a/misc/arpd.c b/misc/arpd.c
index 1ef837c6..65ac6a38 100644
--- a/misc/arpd.c
+++ b/misc/arpd.c
@@ -19,6 +19,7 @@
 #include <fcntl.h>
 #include <sys/uio.h>
 #include <sys/socket.h>
+#include <sys/stat.h>
 #include <sys/time.h>
 #include <time.h>
 #include <signal.h>
@@ -35,7 +36,8 @@
 #include "rt_names.h"
 
 DB	*dbase;
-char	*dbname = "/var/lib/arpd/arpd.db";
+char const	default_dbname[] = ARPDDIR "/arpd.db";
+char const	*dbname = default_dbname;
 
 int	ifnum;
 int	*ifvec;
@@ -668,6 +670,13 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (strcmp(default_dbname, dbname) == 0) {
+		if (mkdir(ARPDDIR, 0755) != 0 && errno != EEXIST) {
+			perror("create_db_dir");
+			exit(-1);
+		}
+	}
+
 	dbase = dbopen(dbname, O_CREAT|O_RDWR, 0644, DB_HASH, NULL);
 	if (dbase == NULL) {
 		perror("db_open");
-- 
2.44.0


