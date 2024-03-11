Return-Path: <netdev+bounces-79237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A03028785DB
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39115B20988
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72714594B;
	Mon, 11 Mar 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="axbe1rBe"
X-Original-To: netdev@vger.kernel.org
Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771743C6A6
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176293; cv=none; b=If7aFJvI0g8DLBZrvIPi8bepDP/fZkrbaA9P3doeNC8x5jIwHOJwg1+gWRXlaMR5hnCNML8pw/DD6igVz1rdGFPWAc9BzrB7oV5CjMK5Yn2NMe/6dp4FArxl9E2gigEFa/gBAIY9OH2kjJEckdSz/sqeupkrKhW8t1ExxWg4BeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176293; c=relaxed/simple;
	bh=+qqBA4lXdMvOC6Yg2ypQIuLf89voWfBvS+fyAJMOMwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTVwLtpOScPeiKcnbAXs8Wy2A68c+oKIjgPQoKk1DOr3SO5tkTb0g15KRSXlMFhEj/p4WI6o23WPuW//dCs21hPwC8yw3uKwXJ8pn4vLx9io37z2BkozSu9hRje/OxaTLhUjS+VPebVGhKkyTD9L99HnXiYUYmhddYZJKp3KhcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=axbe1rBe; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Received: from localhost (unknown [IPv6:2001:910:10ee:0:a8ca:b785:63e5:1af1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id E209760260;
	Mon, 11 Mar 2024 17:58:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710176281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2I5Ng0sOFAmn7xZoCbwK53i2aj5c0BYQes8nUDeGiGk=;
	b=axbe1rBeF1mwUWfx6rO+TnlILpPU/2CpMVrdPg4HImQmrKK/dEEDM80FuvFOOmrsgklQ20
	JoD2tan7hLDExlm94WT4SOAxKqD14qZJh6D5JZqGZnE9ZjQNUeG4f/OSB1S+uUkQr8eqrM
	17X6KulRp/5/AELigIFIGZuUKi0Y7g0wee+r+rLQ7Zcl1zi39poNjyVFZtMt47Jc3DfDxV
	xrlGVAsjMODPECvC2zYyzDj+JvLlsTto2TPhHUjcgv5TQdOheUNeZ/23ogwCRQPRvG6zqO
	6bPq8KnMNotcVEkheFCoLDoInIN0ANlCN5LZtGjb+BSSvjNp+m7nnOfcslPxTw==
From: Max Gautier <mg@max.gautier.name>
To: netdev@vger.kernel.org
Cc: Max Gautier <mg@max.gautier.name>
Subject: [PATCH iproute2-next] Makefile: use systemd-tmpfiles to create /var/lib/arpd
Date: Mon, 11 Mar 2024 17:57:27 +0100
Message-ID: <20240311165803.62431-1-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only apply on systemd systems (detected in the configure script).
The motivation is to build distributions packages without /var to go
towards stateless systems, see link below (TL;DR: provisionning anything
outside of /usr on boot).

The feature flag can be overridden on make invocation:
`make USE_TMPFILES_D=n DESTDIR=<install_loc> install`

Links: https://0pointer.net/blog/projects/stateless.html
---
 Makefile          |  8 +++++++-
 configure         | 14 ++++++++++++++
 etc/tmpfiles.conf |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 etc/tmpfiles.conf

diff --git a/Makefile b/Makefile
index 8024d45e..8ce69a35 100644
--- a/Makefile
+++ b/Makefile
@@ -101,10 +101,16 @@ config.mk:
 		sh configure $(KERNEL_INCLUDE); \
 	fi
 
+ifeq ($(USE_TMPFILES_D),y)
+INSTALL_ARPDDIR := install -m 0644 -D etc/tmpfiles.conf $(DESTDIR)$(TMPFILESDIR)/iproute2-arpd.conf
+else
+INSTALL_ARPDDIR := install -m 0755 -d $(DESTDIR)$(ARPDDIR)
+endif
+
 install: all
 	install -m 0755 -d $(DESTDIR)$(SBINDIR)
 	install -m 0755 -d $(DESTDIR)$(CONF_USR_DIR)
-	install -m 0755 -d $(DESTDIR)$(ARPDDIR)
+	$(INSTALL_ARPDDIR)
 	install -m 0755 -d $(DESTDIR)$(HDRDIR)
 	@for i in $(SUBDIRS);  do $(MAKE) -C $$i install; done
 	install -m 0644 $(shell find etc/iproute2 -maxdepth 1 -type f) $(DESTDIR)$(CONF_USR_DIR)
diff --git a/configure b/configure
index 928048b3..2e974e75 100755
--- a/configure
+++ b/configure
@@ -432,6 +432,17 @@ check_cap()
 	fi
 }
 
+check_tmpfiles_d()
+{
+    if ${PKG_CONFIG} systemd --exists; then
+        echo "USE_TMPFILES_D ?= y" >>$CONFIG
+        echo "yes"
+        echo 'TMPFILESDIR ?=' "$(${PKG_CONFIG} systemd --variable=tmpfilesdir)" >> $CONFIG
+	else
+		echo "no"
+	fi
+}
+
 check_color()
 {
 	case "$COLOR" in
@@ -615,6 +626,9 @@ check_cap
 echo -n "color output: "
 check_color
 
+echo -n "systemd tmpfiles: "
+check_tmpfiles_d
+
 echo >> $CONFIG
 echo "%.o: %.c" >> $CONFIG
 echo '	$(QUIET_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CPPFLAGS) -c -o $@ $<' >> $CONFIG
diff --git a/etc/tmpfiles.conf b/etc/tmpfiles.conf
new file mode 100644
index 00000000..39c6d13c
--- /dev/null
+++ b/etc/tmpfiles.conf
@@ -0,0 +1 @@
+d %S/arpd 0755
-- 
2.44.0


