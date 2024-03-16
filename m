Return-Path: <netdev+bounces-80208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2414287D962
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 10:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32448B21166
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E83EAE4;
	Sat, 16 Mar 2024 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="Ar2mZWun"
X-Original-To: netdev@vger.kernel.org
Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9BD527
	for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580243; cv=none; b=TOotx4j6NdNKpiLc18Q3H6k6oPoxdvuWaxCBxyagJu+jdZ8MUmuUG+Mqm8FqS3iSpuaGhjv6oxrn219oY8yAuDdK/i66bImRdEgBuXMKgo3AEaffJW+r6OHc6oxKNDQ7FKTlmzMTsGizObJ/Qt9RBVVfiBe2SoXZGVUnuIj1dbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580243; c=relaxed/simple;
	bh=SnDYE6MIbcOLeUh4eCXEKDIzZy8o0qOvZpyLdX83nkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kh3g72RL3Uq2Ss23qiQ85+TBHfhOQAP0yxzDTWFA+DqqGftDuxbJMorVhfXo/EG28MDS+yYSdRE+O5hMlinqfH3vg5upcXQA39q5tloDUqKcv/I445xEqpa0NlVWxh+TjMygJS2jVN9MwcIEsPjCrBPxudau5O8wHaFYfJM5kfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=Ar2mZWun; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 3B8F8602EB;
	Sat, 16 Mar 2024 10:10:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710580231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUur7ZJ8Elq3Kp0oQ1CQ/Rf3KC4I+dE3p1Hl9qE0Wbg=;
	b=Ar2mZWun+CzUALQ82G8/3yvExNqncIIGBL+5J03lvFVSztZ4x37hGMykNAOpCOubIfgLc3
	BzQuAoC4n0FixWc2J52zSnVFK8j/xt2U7rSKdJUQrQSlpb33UbUI1IMz45DNx6s1biB6SA
	vxBgsYVhjWT+uXGuT7cZgP8H+d9BpZkEzzxblqfXoLu86MFFeZf897IY+1AL1M09lE3Lo7
	mG3FrL5ZhfXxs7wXDUwDUhDp39ad8epbL8DrEGga1laqU+N5vNZbdfHXHHg19do2uEeV4C
	WjwJG+amdQIW9v4Sw8J8m8S/gKTgrDjk2SoL1WLn+pHX127QbItrh0sCtjWsQw==
From: Max Gautier <mg@max.gautier.name>
To: netdev@vger.kernel.org
Cc: Max Gautier <mg@max.gautier.name>
Subject: [PATCH iproute2-next] arpd: create /var/lib/arpd on first use
Date: Sat, 16 Mar 2024 10:06:44 +0100
Message-ID: <20240316091026.11164-1-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313093856.17fc459e@hermes.local>
References: <20240313093856.17fc459e@hermes.local>
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
---
Instead of modifying the default location, I opted to create it at
runtime, but only for the default location and assuming that /var/lib
exists. My thinking is that not changing defaults is somewhat better,
plus using /var/tmp directly might cause security concerns (I don't know
that it does, but at least someone could create a db file which the root
user would then open by default. Not sure what that could cause, so I'd
rather avoid it).

 Makefile    |  2 +-
 misc/arpd.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

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
index 1ef837c6..a133226c 100644
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
+char const * const	default_dbname = ARPDDIR "/arpd.db";
+char const	*dbname = default_dbname;
 
 int	ifnum;
 int	*ifvec;
@@ -668,6 +670,14 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (default_dbname == dbname
+			&& mkdir(ARPDDIR, 0755) != 0
+			&& errno != EEXIST
+			) {
+		perror("create_db_dir");
+		exit(-1);
+	}
+
 	dbase = dbopen(dbname, O_CREAT|O_RDWR, 0644, DB_HASH, NULL);
 	if (dbase == NULL) {
 		perror("db_open");
-- 
2.44.0


