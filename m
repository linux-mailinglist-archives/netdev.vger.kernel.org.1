Return-Path: <netdev+bounces-80239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7425C87DCB3
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 10:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68472818A4
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BEA1170F;
	Sun, 17 Mar 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="mY4FauMz"
X-Original-To: netdev@vger.kernel.org
Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD61865
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710666228; cv=none; b=ro//vcgtEN3GuzsorGh/h7Gz/W8xNwI5bnbwrd5TJHovu9md3KjNp0/GM+CoFJGzR1lvb3DRoRxirtiAwjB/dVWfjFi9jTZubcaosfamwpgNU3pIePMcCvzU3ELyX4t+ZCgRhYFCPy2E2KxGAv8tn/9qRb2I/H56sbgPRWPgrHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710666228; c=relaxed/simple;
	bh=jCdp5h9uAq86KbvuIp1CzhowEo0UigLnsQOU6AjN6WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzXL/Y0dyko6JAlocYIeT5MXZKuMUcvAdcL6RJu4y826uTxEJpd4Vcd2btES0TH3r2knZMgdwZmyv5BuR9PYUAwQ33VRiDTqk5zUujRPjRLAhq7HVg+t0AYENbX+kF0g0vvwcJ9KLa6q3xnh1KU2lnpWV7Co0hVFTIaEtLEnyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=mY4FauMz; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 84A13601D2;
	Sun, 17 Mar 2024 10:03:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710666220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A/PusXDv5aJdtUZpDHS6v6Te8BjuZktlZKmKkBA0isQ=;
	b=mY4FauMzEUjP9sIGRdWyaIQ5TRHrjg6JtbpL0V+8dEDYE3tq5+xnN9GWHqAAMIHSKZyP5v
	8rVKCMJErDD8jlHrpbD6WlAHE4Ye2C5dv8IT2jqz61OSW6cb91YtJ3peo1Q4/fTAYgj/b+
	ZhCB5zH5AE+RKxkrNJFOGTHFm5riObRHZw+HzR4ZERMbF/EGfIX3NxnmCi4HW0MZLiYeJg
	Ed1cMFbK8j/sf7+Y8olaYPrl93wIX5byPHiC003eC2na5E1DM+aVuRuf0F9azXWQseIQim
	nT/mCLyW6djDYvGdVCTED9CC6szVtKQMZpmzOUFaY2hNu9Pl/XS4IzFyVwtUBw==
From: Max Gautier <mg@max.gautier.name>
To: netdev@vger.kernel.org
Cc: Max Gautier <mg@max.gautier.name>
Subject: [PATCH iproute2-next v2] arpd: create /var/lib/arpd on first use
Date: Sun, 17 Mar 2024 10:01:24 +0100
Message-ID: <20240317090134.4219-1-mg@max.gautier.name>
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
index 1ef837c6..a64888aa 100644
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
@@ -668,6 +670,14 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (strcmp(default_dbname, dbname) == 0
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


