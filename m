Return-Path: <netdev+bounces-20690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9A3760A5C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471361C20E12
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 06:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051E81C37;
	Tue, 25 Jul 2023 06:32:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890719F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:32:12 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4551137
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:32:09 -0700 (PDT)
Received: from localhost.localdomain (dynamic-078-049-060-212.78.49.pool.telefonica.de [78.49.60.212])
	by mail.svario.it (Postfix) with ESMTPSA id E362BD86EC;
	Tue, 25 Jul 2023 08:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1690266728; bh=N3CvFOlw/vrolni8Bxxy5Cs2j/PJsP0UeP3cZNUQH48=;
	h=From:To:Cc:Subject:Date:From;
	b=FUa369rvaX17ztrTJWsdm2HGpHa6KkYOTxgdS08lvR7XJm7dmpYnVvGxfRgS8cIPN
	 Lmn6D85pKhPZ06UsSh8ZFyUFywu2jqCdBAPg430IR4SgAf1W06GWHhKKoRM2k3nK9v
	 z94NvMqvWgYbIjRxjsRnyR8t9LDFmOL9N6WRHCgL5kOnm7eh3UWEQgyN7GfOtM2wFW
	 iwJyVVokT+Hww8HrLHql3JVHvjrDixtk6UJ8BAdrQsDcHK0ZJySodoL+CsdXWF9N4Y
	 gR1B3Hcxl1EwvfWfvlieLsZTOg4EBQOFsRY5k1hu5/ycqfKrxiO3bKXBt7tXO/YuJA
	 CloEILgS4/Nxg==
From: Gioele Barabucci <gioele@svario.it>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 v2] Read configuration files from /etc and /usr
Date: Tue, 25 Jul 2023 08:31:38 +0200
Message-Id: <20230725063138.167623-1-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for the so called "stateless" configuration pattern (read
from /etc, fall back to /usr), giving system administrators a way to
define local configuration without changing any distro-provided files.

In practice this means that each configuration file FOO is loaded
from /usr/lib/iproute2/FOO unless /etc/iproute2/FOO exists.

Signed-off-by: Gioele Barabucci <gioele@svario.it>

--
v2: squash into one patch
---
 Makefile                 |  10 +-
 include/utils.h          |   7 +-
 lib/bpf_legacy.c         |  12 +-
 lib/rt_names.c           | 254 ++++++++++++++++++++++++---------------
 man/man8/Makefile        |   3 +-
 man/man8/ip-address.8.in |   5 +-
 man/man8/ip-link.8.in    |  12 +-
 man/man8/ip-route.8.in   |  43 ++++---
 tc/m_ematch.c            |  17 ++-
 tc/tc_util.c             |  18 ++-
 10 files changed, 236 insertions(+), 145 deletions(-)

diff --git a/Makefile b/Makefile
index 8a17d614..7d1819ce 100644
--- a/Makefile
+++ b/Makefile
@@ -16,7 +16,8 @@ endif
 
 PREFIX?=/usr
 SBINDIR?=/sbin
-CONFDIR?=/etc/iproute2
+CONF_ETC_DIR?=/etc/iproute2
+CONF_USR_DIR?=$(PREFIX)/lib/iproute2
 NETNS_RUN_DIR?=/var/run/netns
 NETNS_ETC_DIR?=/etc/netns
 DATADIR?=$(PREFIX)/share
@@ -37,7 +38,8 @@ ifneq ($(SHARED_LIBS),y)
 DEFINES+= -DNO_SHARED_LIBS
 endif
 
-DEFINES+=-DCONFDIR=\"$(CONFDIR)\" \
+DEFINES+=-DCONF_USR_DIR=\"$(CONF_USR_DIR)\" \
+         -DCONF_ETC_DIR=\"$(CONF_ETC_DIR)\" \
          -DNETNS_RUN_DIR=\"$(NETNS_RUN_DIR)\" \
          -DNETNS_ETC_DIR=\"$(NETNS_ETC_DIR)\"
 
@@ -100,11 +102,11 @@ config.mk:
 
 install: all
 	install -m 0755 -d $(DESTDIR)$(SBINDIR)
-	install -m 0755 -d $(DESTDIR)$(CONFDIR)
+	install -m 0755 -d $(DESTDIR)$(CONF_USR_DIR)
 	install -m 0755 -d $(DESTDIR)$(ARPDDIR)
 	install -m 0755 -d $(DESTDIR)$(HDRDIR)
 	@for i in $(SUBDIRS);  do $(MAKE) -C $$i install; done
-	install -m 0644 $(shell find etc/iproute2 -maxdepth 1 -type f) $(DESTDIR)$(CONFDIR)
+	install -m 0644 $(shell find etc/iproute2 -maxdepth 1 -type f) $(DESTDIR)$(CONF_USR_DIR)
 	install -m 0755 -d $(DESTDIR)$(BASH_COMPDIR)
 	install -m 0644 bash-completion/tc $(DESTDIR)$(BASH_COMPDIR)
 	install -m 0644 bash-completion/devlink $(DESTDIR)$(BASH_COMPDIR)
diff --git a/include/utils.h b/include/utils.h
index 0b5d86a2..3159dbab 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -38,8 +38,11 @@ extern int numeric;
 extern bool do_all;
 extern int echo_request;
 
-#ifndef CONFDIR
-#define CONFDIR		"/etc/iproute2"
+#ifndef CONF_USR_DIR
+#define CONF_USR_DIR "/usr/lib/iproute2"
+#endif
+#ifndef CONF_ETC_DIR
+#define CONF_ETC_DIR "/etc/iproute2"
 #endif
 
 #define SPRINT_BSIZE 64
diff --git a/lib/bpf_legacy.c b/lib/bpf_legacy.c
index 8ac64235..52a951c6 100644
--- a/lib/bpf_legacy.c
+++ b/lib/bpf_legacy.c
@@ -2751,7 +2751,7 @@ static bool bpf_pinning_reserved(uint32_t pinning)
 	}
 }
 
-static void bpf_hash_init(struct bpf_elf_ctx *ctx, const char *db_file)
+static int bpf_hash_init(struct bpf_elf_ctx *ctx, const char *db_file)
 {
 	struct bpf_hash_entry *entry;
 	char subpath[PATH_MAX] = {};
@@ -2761,14 +2761,14 @@ static void bpf_hash_init(struct bpf_elf_ctx *ctx, const char *db_file)
 
 	fp = fopen(db_file, "r");
 	if (!fp)
-		return;
+		return -errno;
 
 	while ((ret = bpf_read_pin_mapping(fp, &pinning, subpath))) {
 		if (ret == -1) {
 			fprintf(stderr, "Database %s is corrupted at: %s\n",
 				db_file, subpath);
 			fclose(fp);
-			return;
+			return -1;
 		}
 
 		if (bpf_pinning_reserved(pinning)) {
@@ -2796,6 +2796,8 @@ static void bpf_hash_init(struct bpf_elf_ctx *ctx, const char *db_file)
 	}
 
 	fclose(fp);
+
+	return 0;
 }
 
 static void bpf_hash_destroy(struct bpf_elf_ctx *ctx)
@@ -2924,7 +2926,9 @@ static int bpf_elf_ctx_init(struct bpf_elf_ctx *ctx, const char *pathname,
 	}
 
 	bpf_save_finfo(ctx);
-	bpf_hash_init(ctx, CONFDIR "/bpf_pinning");
+	ret = bpf_hash_init(ctx, CONF_USR_DIR "/bpf_pinning");
+	if (ret == -ENOENT)
+		bpf_hash_init(ctx, CONF_ETC_DIR "/bpf_pinning");
 
 	return 0;
 out_free:
diff --git a/lib/rt_names.c b/lib/rt_names.c
index 68db74e3..2d804f5c 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -12,8 +12,10 @@
 #include <string.h>
 #include <sys/time.h>
 #include <sys/socket.h>
+#include <sys/stat.h>
 #include <dirent.h>
 #include <limits.h>
+#include <errno.h>
 
 #include <asm/types.h>
 #include <linux/rtnetlink.h>
@@ -56,7 +58,7 @@ static int fread_id_name(FILE *fp, int *id, char *namebuf)
 	return 0;
 }
 
-static void
+static int
 rtnl_hash_initialize(const char *file, struct rtnl_hash_entry **hash, int size)
 {
 	struct rtnl_hash_entry *entry;
@@ -67,14 +69,14 @@ rtnl_hash_initialize(const char *file, struct rtnl_hash_entry **hash, int size)
 
 	fp = fopen(file, "r");
 	if (!fp)
-		return;
+		return -errno;
 
 	while ((ret = fread_id_name(fp, &id, &namebuf[0]))) {
 		if (ret == -1) {
 			fprintf(stderr, "Database %s is corrupted at %s\n",
 					file, namebuf);
 			fclose(fp);
-			return;
+			return -1;
 		}
 
 		if (id < 0)
@@ -91,9 +93,11 @@ rtnl_hash_initialize(const char *file, struct rtnl_hash_entry **hash, int size)
 		hash[id & (size - 1)] = entry;
 	}
 	fclose(fp);
+
+	return 0;
 }
 
-static void rtnl_tab_initialize(const char *file, char **tab, int size)
+static int rtnl_tab_initialize(const char *file, char **tab, int size)
 {
 	FILE *fp;
 	int id;
@@ -102,14 +106,14 @@ static void rtnl_tab_initialize(const char *file, char **tab, int size)
 
 	fp = fopen(file, "r");
 	if (!fp)
-		return;
+		return -errno;
 
 	while ((ret = fread_id_name(fp, &id, &namebuf[0]))) {
 		if (ret == -1) {
 			fprintf(stderr, "Database %s is corrupted at %s\n",
 					file, namebuf);
 			fclose(fp);
-			return;
+			return -1;
 		}
 		if (id < 0 || id > size)
 			continue;
@@ -117,6 +121,8 @@ static void rtnl_tab_initialize(const char *file, char **tab, int size)
 		tab[id] = strdup(namebuf);
 	}
 	fclose(fp);
+
+	return 0;
 }
 
 static char *rtnl_rtprot_tab[256] = {
@@ -145,40 +151,101 @@ static char *rtnl_rtprot_tab[256] = {
 };
 
 
+static void
+rtnl_tabhash_initialize_dir(const char *ddir, void *tabhash, const int size,
+                            const bool is_tab)
+{
+	char dirpath_usr[PATH_MAX], dirpath_etc[PATH_MAX];
+	struct dirent *de;
+	DIR *d;
+
+	snprintf(dirpath_usr, sizeof(dirpath_usr), "%s/%s", CONF_USR_DIR, ddir);
+	snprintf(dirpath_etc, sizeof(dirpath_etc), "%s/%s", CONF_ETC_DIR, ddir);
+
+	/* load /usr/lib/iproute2/foo.d/X conf files, unless /etc/iproute2/foo.d/X exists */
+	d = opendir(dirpath_usr);
+	while (d && (de = readdir(d)) != NULL) {
+		char path[PATH_MAX];
+		size_t len;
+		struct stat sb;
+
+		if (*de->d_name == '.')
+			continue;
+
+		/* only consider filenames ending in '.conf' */
+		len = strlen(de->d_name);
+		if (len <= 5)
+			continue;
+		if (strcmp(de->d_name + len - 5, ".conf"))
+			continue;
+
+		/* only consider filenames not present in /etc */
+		snprintf(path, sizeof(path), "%s/%s", dirpath_etc, de->d_name);
+		if (lstat(path, &sb) == 0)
+			continue;
+
+		/* load the conf file in /usr */
+		snprintf(path, sizeof(path), "%s/%s", dirpath_usr, de->d_name);
+		if (is_tab)
+			rtnl_tab_initialize(path, (char**)tabhash, size);
+		else
+			rtnl_hash_initialize(path, (struct rtnl_hash_entry**)tabhash, size);
+	}
+	if (d)
+		closedir(d);
+
+	/* load /etc/iproute2/foo.d/X conf files */
+	d = opendir(dirpath_etc);
+	while (d && (de = readdir(d)) != NULL) {
+		char path[PATH_MAX];
+		size_t len;
+
+		if (*de->d_name == '.')
+			continue;
+
+		/* only consider filenames ending in '.conf' */
+		len = strlen(de->d_name);
+		if (len <= 5)
+			continue;
+		if (strcmp(de->d_name + len - 5, ".conf"))
+			continue;
+
+		/* load the conf file in /etc */
+		snprintf(path, sizeof(path), "%s/%s", dirpath_etc, de->d_name);
+		if (is_tab)
+			rtnl_tab_initialize(path, (char**)tabhash, size);
+		else
+			rtnl_hash_initialize(path, (struct rtnl_hash_entry**)tabhash, size);
+	}
+	if (d)
+		closedir(d);
+}
+
+static void
+rtnl_tab_initialize_dir(const char *ddir, char **tab, const int size) {
+	rtnl_tabhash_initialize_dir(ddir, (void*)tab, size, true);
+}
+
+static void
+rtnl_hash_initialize_dir(const char *ddir, struct rtnl_hash_entry **tab,
+                         const int size) {
+	rtnl_tabhash_initialize_dir(ddir, (void*)tab, size, false);
+}
+
 static int rtnl_rtprot_init;
 
 static void rtnl_rtprot_initialize(void)
 {
-	struct dirent *de;
-	DIR *d;
+	int ret;
 
 	rtnl_rtprot_init = 1;
-	rtnl_tab_initialize(CONFDIR "/rt_protos",
-			    rtnl_rtprot_tab, 256);
+	ret = rtnl_tab_initialize(CONF_ETC_DIR "/rt_protos",
+	                          rtnl_rtprot_tab, 256);
+	if (ret == -ENOENT)
+		rtnl_tab_initialize(CONF_USR_DIR "/rt_protos",
+		                    rtnl_rtprot_tab, 256);
 
-	d = opendir(CONFDIR "/rt_protos.d");
-	if (!d)
-		return;
-
-	while ((de = readdir(d)) != NULL) {
-		char path[PATH_MAX];
-		size_t len;
-
-		if (*de->d_name == '.')
-			continue;
-
-		/* only consider filenames ending in '.conf' */
-		len = strlen(de->d_name);
-		if (len <= 5)
-			continue;
-		if (strcmp(de->d_name + len - 5, ".conf"))
-			continue;
-
-		snprintf(path, sizeof(path), CONFDIR "/rt_protos.d/%s",
-			 de->d_name);
-		rtnl_tab_initialize(path, rtnl_rtprot_tab, 256);
-	}
-	closedir(d);
+	rtnl_tab_initialize_dir("rt_protos.d", rtnl_rtprot_tab, 256);
 }
 
 const char *rtnl_rtprot_n2a(int id, char *buf, int len)
@@ -240,10 +307,17 @@ static bool rtnl_addrprot_tab_initialized;
 
 static void rtnl_addrprot_initialize(void)
 {
-	rtnl_tab_initialize(CONFDIR "/rt_addrprotos",
-			    rtnl_addrprot_tab,
-			    ARRAY_SIZE(rtnl_addrprot_tab));
+	int ret;
+
 	rtnl_addrprot_tab_initialized = true;
+
+	ret = rtnl_tab_initialize(CONF_ETC_DIR "/rt_addrprotos",
+	                          rtnl_addrprot_tab,
+	                          ARRAY_SIZE(rtnl_addrprot_tab));
+	if (ret == -ENOENT)
+		ret = rtnl_tab_initialize(CONF_USR_DIR "/rt_addrprotos",
+		                          rtnl_addrprot_tab,
+		                          ARRAY_SIZE(rtnl_addrprot_tab));
 }
 
 const char *rtnl_addrprot_n2a(__u8 id, char *buf, int len)
@@ -296,9 +370,14 @@ static int rtnl_rtscope_init;
 
 static void rtnl_rtscope_initialize(void)
 {
+	int ret;
+
 	rtnl_rtscope_init = 1;
-	rtnl_tab_initialize(CONFDIR "/rt_scopes",
-			    rtnl_rtscope_tab, 256);
+	ret = rtnl_tab_initialize(CONF_ETC_DIR "/rt_scopes",
+			          rtnl_rtscope_tab, 256);
+	if (ret == -ENOENT)
+		rtnl_tab_initialize(CONF_USR_DIR "/rt_scopes",
+				    rtnl_rtscope_tab, 256);
 }
 
 const char *rtnl_rtscope_n2a(int id, char *buf, int len)
@@ -361,9 +440,14 @@ static int rtnl_rtrealm_init;
 
 static void rtnl_rtrealm_initialize(void)
 {
+	int ret;
+
 	rtnl_rtrealm_init = 1;
-	rtnl_tab_initialize(CONFDIR "/rt_realms",
-			    rtnl_rtrealm_tab, 256);
+	ret = rtnl_tab_initialize(CONF_ETC_DIR "/rt_realms",
+	                          rtnl_rtrealm_tab, 256);
+	if (ret == -ENOENT)
+		rtnl_tab_initialize(CONF_USR_DIR "/rt_realms",
+		                    rtnl_rtrealm_tab, 256);
 }
 
 const char *rtnl_rtrealm_n2a(int id, char *buf, int len)
@@ -430,41 +514,21 @@ static int rtnl_rttable_init;
 
 static void rtnl_rttable_initialize(void)
 {
-	struct dirent *de;
-	DIR *d;
 	int i;
+	int ret;
 
 	rtnl_rttable_init = 1;
 	for (i = 0; i < 256; i++) {
 		if (rtnl_rttable_hash[i])
 			rtnl_rttable_hash[i]->id = i;
 	}
-	rtnl_hash_initialize(CONFDIR "/rt_tables",
-			     rtnl_rttable_hash, 256);
+	ret = rtnl_hash_initialize(CONF_ETC_DIR "/rt_tables",
+	                           rtnl_rttable_hash, 256);
+	if (ret == -ENOENT)
+		rtnl_hash_initialize(CONF_USR_DIR "/rt_tables",
+		                     rtnl_rttable_hash, 256);
 
-	d = opendir(CONFDIR "/rt_tables.d");
-	if (!d)
-		return;
-
-	while ((de = readdir(d)) != NULL) {
-		char path[PATH_MAX];
-		size_t len;
-
-		if (*de->d_name == '.')
-			continue;
-
-		/* only consider filenames ending in '.conf' */
-		len = strlen(de->d_name);
-		if (len <= 5)
-			continue;
-		if (strcmp(de->d_name + len - 5, ".conf"))
-			continue;
-
-		snprintf(path, sizeof(path),
-			 CONFDIR "/rt_tables.d/%s", de->d_name);
-		rtnl_hash_initialize(path, rtnl_rttable_hash, 256);
-	}
-	closedir(d);
+	rtnl_hash_initialize_dir("rt_tables.d", rtnl_rttable_hash, 256);
 }
 
 const char *rtnl_rttable_n2a(__u32 id, char *buf, int len)
@@ -526,9 +590,14 @@ static int rtnl_rtdsfield_init;
 
 static void rtnl_rtdsfield_initialize(void)
 {
+	int ret;
+
 	rtnl_rtdsfield_init = 1;
-	rtnl_tab_initialize(CONFDIR "/rt_dsfield",
-			    rtnl_rtdsfield_tab, 256);
+	ret = rtnl_tab_initialize(CONF_ETC_DIR "/rt_dsfield",
+	                          rtnl_rtdsfield_tab, 256);
+	if (ret == -ENOENT)
+		rtnl_tab_initialize(CONF_USR_DIR "/rt_dsfield",
+		                    rtnl_rtdsfield_tab, 256);
 }
 
 const char *rtnl_dsfield_n2a(int id, char *buf, int len)
@@ -605,9 +674,14 @@ static int rtnl_group_init;
 
 static void rtnl_group_initialize(void)
 {
+	int ret;
+
 	rtnl_group_init = 1;
-	rtnl_hash_initialize(CONFDIR "/group",
-			     rtnl_group_hash, 256);
+	ret = rtnl_hash_initialize(CONF_ETC_DIR "/group",
+	                           rtnl_group_hash, 256);
+	if (ret == -ENOENT)
+		rtnl_hash_initialize(CONF_USR_DIR "/group",
+		                     rtnl_group_hash, 256);
 }
 
 int rtnl_group_a2n(int *id, const char *arg)
@@ -695,9 +769,14 @@ static int nl_proto_init;
 
 static void nl_proto_initialize(void)
 {
+	int ret;
+
 	nl_proto_init = 1;
-	rtnl_tab_initialize(CONFDIR "/nl_protos",
-			    nl_proto_tab, 256);
+	ret = rtnl_tab_initialize(CONF_ETC_DIR "/nl_protos",
+	                          nl_proto_tab, 256);
+	if (ret == -ENOENT)
+		rtnl_tab_initialize(CONF_USR_DIR "/nl_protos",
+		                    nl_proto_tab, 256);
 }
 
 const char *nl_proto_n2a(int id, char *buf, int len)
@@ -757,35 +836,10 @@ static int protodown_reason_init;
 
 static void protodown_reason_initialize(void)
 {
-	struct dirent *de;
-	DIR *d;
-
 	protodown_reason_init = 1;
 
-	d = opendir(CONFDIR "/protodown_reasons.d");
-	if (!d)
-		return;
-
-	while ((de = readdir(d)) != NULL) {
-		char path[PATH_MAX];
-		size_t len;
-
-		if (*de->d_name == '.')
-			continue;
-
-		/* only consider filenames ending in '.conf' */
-		len = strlen(de->d_name);
-		if (len <= 5)
-			continue;
-		if (strcmp(de->d_name + len - 5, ".conf"))
-			continue;
-
-		snprintf(path, sizeof(path), CONFDIR "/protodown_reasons.d/%s",
-			 de->d_name);
-		rtnl_tab_initialize(path, protodown_reason_tab,
-				    PROTODOWN_REASON_NUM_BITS);
-	}
-	closedir(d);
+	rtnl_tab_initialize_dir("protodown_reasons.d", protodown_reason_tab,
+                                PROTODOWN_REASON_NUM_BITS);
 }
 
 int protodown_reason_n2a(int id, char *buf, int len)
diff --git a/man/man8/Makefile b/man/man8/Makefile
index b1fd87bd..6dab182f 100644
--- a/man/man8/Makefile
+++ b/man/man8/Makefile
@@ -9,7 +9,8 @@ all: $(TARGETS)
 	sed \
 		-e "s|@NETNS_ETC_DIR@|$(NETNS_ETC_DIR)|g" \
 		-e "s|@NETNS_RUN_DIR@|$(NETNS_RUN_DIR)|g" \
-		-e "s|@SYSCONFDIR@|$(CONFDIR)|g" \
+		-e "s|@SYSCONF_ETC_DIR@|$(CONF_ETC_DIR)|g" \
+		-e "s|@SYSCONF_USR_DIR@|$(CONF_USR_DIR)|g" \
 		$< > $@
 
 distclean: clean
diff --git a/man/man8/ip-address.8.in b/man/man8/ip-address.8.in
index abdd6a20..b9a476a5 100644
--- a/man/man8/ip-address.8.in
+++ b/man/man8/ip-address.8.in
@@ -208,8 +208,9 @@ The maximum allowed total length of label is 15 characters.
 .TP
 .BI scope " SCOPE_VALUE"
 the scope of the area where this address is valid.
-The available scopes are listed in file
-.BR "@SYSCONFDIR@/rt_scopes" .
+The available scopes are listed in
+.BR "@SYSCONF_USR_DIR@/rt_scopes" or
+.BR "@SYSCONF_ETC_DIR@/rt_scopes" (has precedence if exists).
 Predefined scope values are:
 
 .in +8
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 6a82ddc4..8f07de9a 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -2250,8 +2250,9 @@ give the device a symbolic name for easy reference.
 .TP
 .BI group " GROUP"
 specify the group the device belongs to.
-The available groups are listed in file
-.BR "@SYSCONFDIR@/group" .
+The available groups are listed in
+.BR "@SYSCONF_USR_DIR@/group" or
+.BR "@SYSCONF_ETC_DIR@/group" (has precedence if exists).
 
 .TP
 .BI vf " NUM"
@@ -2851,9 +2852,10 @@ specifies which help of link type to display.
 
 .SS
 .I GROUP
-may be a number or a string from the file
-.B @SYSCONFDIR@/group
-which can be manually filled.
+may be a number or a string from
+.B @SYSCONF_USR_DIR@/group or
+.B @SYSCONF_ETC_DIR@/group
+which can be manually filled and has precedence if exists.
 
 .SH "EXAMPLES"
 .PP
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index c2b00833..76151689 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -356,8 +356,9 @@ normal routing tables.
 .P
 .B Route tables:
 Linux-2.x can pack routes into several routing tables identified
-by a number in the range from 1 to 2^32-1 or by name from the file
-.B @SYSCONFDIR@/rt_tables
+by a number in the range from 1 to 2^32-1 or by name from
+.B @SYSCONF_USR_DIR@/rt_tables or
+.B @SYSCONF_ETC_DIR@/rt_tables (has precedence if exists).
 By default all normal routes are inserted into the
 .B main
 table (ID 254) and the kernel only uses this table when calculating routes.
@@ -420,7 +421,8 @@ may still match a route with a zero TOS.
 .I TOS
 is either an 8 bit hexadecimal number or an identifier
 from
-.BR "@SYSCONFDIR@/rt_dsfield" .
+.BR "@SYSCONF_USR_DIR@/rt_dsfield" or
+.BR "@SYSCONF_ETC_DIR@/rt_dsfield" (has precedence if exists).
 
 .TP
 .BI metric " NUMBER"
@@ -434,8 +436,9 @@ is an arbitrary 32bit number, where routes with lower values are preferred.
 .BI table " TABLEID"
 the table to add this route to.
 .I TABLEID
-may be a number or a string from the file
-.BR "@SYSCONFDIR@/rt_tables" .
+may be a number or a string from
+.BR "@SYSCONF_USR_DIR@/rt_tables" or
+.BR "@SYSCONF_ETC_DIR@/rt_tables" (has precedence if exists).
 If this parameter is omitted,
 .B ip
 assumes the
@@ -475,8 +478,9 @@ covered by the route prefix.
 .BI realm " REALMID"
 the realm to which this route is assigned.
 .I REALMID
-may be a number or a string from the file
-.BR "@SYSCONFDIR@/rt_realms" .
+may be a number or a string from
+.BR "@SYSCONF_USR_DIR@/rt_realms" or
+.BR "@SYSCONF_ETC_DIR@/rt_realms" (has precedence if exists).
 
 .TP
 .BI mtu " MTU"
@@ -626,8 +630,9 @@ command.
 .BI scope " SCOPE_VAL"
 the scope of the destinations covered by the route prefix.
 .I SCOPE_VAL
-may be a number or a string from the file
-.BR "@SYSCONFDIR@/rt_scopes" .
+may be a number or a string from
+.BR "@SYSCONF_USR_DIR@/rt_scopes" or
+.BR "@SYSCONF_ETC_DIR@/rt_scopes" (has precedence if exists).
 If this parameter is omitted,
 .B ip
 assumes scope
@@ -646,8 +651,9 @@ routes.
 .BI protocol " RTPROTO"
 the routing protocol identifier of this route.
 .I RTPROTO
-may be a number or a string from the file
-.BR "@SYSCONFDIR@/rt_protos" .
+may be a number or a string from
+.BR "@SYSCONF_ETC_DIR@/rt_protos" or
+.BR "@SYSCONF_ETC_DIR@/rt_protos" (has precedence if exists).
 If the routing protocol ID is not given,
 .B ip assumes protocol
 .B boot
@@ -879,8 +885,9 @@ matching packets are dropped.
 - Decapsulate the inner IPv6 packet and forward it according to the
 specified lookup table.
 .I TABLEID
-is either a number or a string from the file
-.BR "@SYSCONFDIR@/rt_tables" .
+is either a number or a string from
+.BR "@SYSCONF_USR_DIR@/rt_tables" or
+.BR "@SYSCONF_ETC_DIR@/rt_tables" (has precedence if exists).
 If
 .B vrftable
 is used, the argument must be a VRF device associated with
@@ -895,8 +902,9 @@ and an inner IPv6 packet. Other matching packets are dropped.
 - Decapsulate the inner IPv4 packet and forward it according to the
 specified lookup table.
 .I TABLEID
-is either a number or a string from the file
-.BR "@SYSCONFDIR@/rt_tables" .
+is either a number or a string from
+.BR "@SYSCONF_USR_DIR@/rt_tables" or
+.BR "@SYSCONF_ETC_DIR@/rt_tables" (has precedence if exists).
 The argument must be a VRF device associated with the table id.
 Moreover, the VRF table associated with the table id must be configured
 with the VRF strict mode turned on (net.vrf.strict_mode=1). This action
@@ -908,8 +916,9 @@ at all, and an inner IPv4 packet. Other matching packets are dropped.
 - Decapsulate the inner IPv4 or IPv6 packet and forward it according
 to the specified lookup table.
 .I TABLEID
-is either a number or a string from the file
-.BR "@SYSCONFDIR@/rt_tables" .
+is either a number or a string from
+.BR "@SYSCONF_USR_DIR@/rt_tables" or
+.BR "@SYSCONF_ETC_DIR@/rt_tables" (has precedence if exists).
 The argument must be a VRF device associated with the table id.
 Moreover, the VRF table associated with the table id must be configured
 with the VRF strict mode turned on (net.vrf.strict_mode=1). This action
diff --git a/tc/m_ematch.c b/tc/m_ematch.c
index e30ee205..1d0a208f 100644
--- a/tc/m_ematch.c
+++ b/tc/m_ematch.c
@@ -21,7 +21,8 @@
 #include "tc_util.h"
 #include "m_ematch.h"
 
-#define EMATCH_MAP "/etc/iproute2/ematch_map"
+#define EMATCH_MAP_USR	"/usr/lib/iproute2/ematch_map"
+#define EMATCH_MAP_ETC	"/etc/iproute2/ematch_map"
 
 static struct ematch_util *ematch_list;
 
@@ -39,11 +40,11 @@ static void bstr_print(FILE *fd, const struct bstr *b, int ascii);
 static inline void map_warning(int num, char *kind)
 {
 	fprintf(stderr,
-	    "Error: Unable to find ematch \"%s\" in %s\n" \
+	    "Error: Unable to find ematch \"%s\" in %s or %s\n" \
 	    "Please assign a unique ID to the ematch kind the suggested " \
 	    "entry is:\n" \
 	    "\t%d\t%s\n",
-	    kind, EMATCH_MAP, num, kind);
+	    kind, EMATCH_MAP_ETC, EMATCH_MAP_USR, num, kind);
 }
 
 static int lookup_map(__u16 num, char *dst, int len, const char *file)
@@ -160,8 +161,12 @@ static struct ematch_util *get_ematch_kind(char *kind)
 static struct ematch_util *get_ematch_kind_num(__u16 kind)
 {
 	char name[513];
+	int ret;
 
-	if (lookup_map(kind, name, sizeof(name), EMATCH_MAP) < 0)
+	ret = lookup_map(kind, name, sizeof(name), EMATCH_MAP_ETC);
+	if (ret == -ENOENT)
+		ret = lookup_map(kind, name, sizeof(name), EMATCH_MAP_USR);
+	if (ret < 0)
 		return NULL;
 
 	return get_ematch_kind(name);
@@ -227,7 +232,9 @@ static int parse_tree(struct nlmsghdr *n, struct ematch *tree)
 				return -1;
 			}
 
-			err = lookup_map_id(buf, &num, EMATCH_MAP);
+			err = lookup_map_id(buf, &num, EMATCH_MAP_ETC);
+			if (err == -ENOENT)
+				err = lookup_map_id(buf, &num, EMATCH_MAP_USR);
 			if (err < 0) {
 				if (err == -ENOENT)
 					map_warning(e->kind_num, buf);
diff --git a/tc/tc_util.c b/tc/tc_util.c
index ed9efa70..e6235291 100644
--- a/tc/tc_util.c
+++ b/tc/tc_util.c
@@ -28,7 +28,8 @@
 
 static struct db_names *cls_names;
 
-#define NAMES_DB "/etc/iproute2/tc_cls"
+#define NAMES_DB_USR "/usr/lib/iproute2/tc_cls"
+#define NAMES_DB_ETC "/etc/iproute2/tc_cls"
 
 int cls_names_init(char *path)
 {
@@ -38,11 +39,18 @@ int cls_names_init(char *path)
 	if (!cls_names)
 		return -1;
 
-	ret = db_names_load(cls_names, path ?: NAMES_DB);
-	if (ret == -ENOENT && path) {
-		fprintf(stderr, "Can't open class names file: %s\n", path);
-		return -1;
+	if (path) {
+		ret = db_names_load(cls_names, path);
+		if (ret == -ENOENT) {
+			fprintf(stderr, "Can't open class names file: %s\n", path);
+			return -1;
+		}
 	}
+
+	ret = db_names_load(cls_names, NAMES_DB_ETC);
+	if (ret == -ENOENT)
+		ret = db_names_load(cls_names, NAMES_DB_USR);
+
 	if (ret) {
 		db_names_free(cls_names);
 		cls_names = NULL;
-- 
2.39.2


