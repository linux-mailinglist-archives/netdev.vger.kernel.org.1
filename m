Return-Path: <netdev+bounces-231396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CEBBF8BE4
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C20A14E9AB9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C882127FD5D;
	Tue, 21 Oct 2025 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cp/PXi0P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D627F01B
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079233; cv=none; b=LC0BTdBLyQLM9EdutRrZrTqD//hUdKBSLd0jj0s6j+kPJq2m0Jk6UYaiDjVZlVvyVG0Eey1RY4TSrtZY4cnefrGtcCCi0Y1+cZhqO4hetf0wcNxzwhpOSW1y336Yl6RnyaBC6t62hZbFK/Dhu5S/kvyrnencQyrzkKlMtQRHPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079233; c=relaxed/simple;
	bh=vG6aOsEJkTJns7A1YV3hZ+60Jvyml0ObACpemHN/wGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kuy/c2+GU9997p4F2dPAMDBSkUM/ZDTMPGSbfTa3nGneCo2wjxUBQVAghmIGiBQXTXZZsUA5OeUSFQcSFgPBdjKVwo/y+564gvzilGYEGKJWXXX+Yp5pGBdRFi1w84J6qKmbSz5JMCyA6F8I6jU1rWjuf5DDmQjFgOIdoSfT5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cp/PXi0P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761079230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCnMrF/qYP12WT0GrAUAV/LDa/mArnd9/ygShkjBnJ8=;
	b=cp/PXi0PdG3zm6xmoN7h3FHlBbU5NVVOftdLM6fK02/uD4lbKIzLZx3zjaIR9YbMjGXZeK
	7ykMu+3o0HIiARhG6OnFGS1VmBAsrOBf4hELl+gKXvAJKmnvuJcc+qApBaVNa+LQUkw74i
	4oypnjlNzWsEUKIII2X6ez36gsywj1s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-ox9v_0jnMnCk-ssaJNSCVA-1; Tue,
 21 Oct 2025 16:40:27 -0400
X-MC-Unique: ox9v_0jnMnCk-ssaJNSCVA-1
X-Mimecast-MFC-AGG-ID: ox9v_0jnMnCk-ssaJNSCVA_1761079226
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C4D518002F7;
	Tue, 21 Oct 2025 20:40:26 +0000 (UTC)
Received: from tc2.redhat.com (unknown [10.44.32.244])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0A8A180057C;
	Tue, 21 Oct 2025 20:40:24 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2-next 1/3] ifstat: convert to high-level json_print API
Date: Tue, 21 Oct 2025 22:39:16 +0200
Message-ID: <daa4073f61bdf93da6e1215ad8a0fad641ca7192.1761078778.git.aclaudi@redhat.com>
In-Reply-To: <cover.1761078778.git.aclaudi@redhat.com>
References: <cover.1761078778.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Replace the low-level json_writer API calls with the high-level
json_print API to maintain consistency with the rest of the iproute2
codebase.

Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 misc/ifstat.c | 85 ++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 48 deletions(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index a47d0b16..ec59a9eb 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -28,7 +28,7 @@
 #include <linux/if_link.h>
 
 #include "libnetlink.h"
-#include "json_writer.h"
+#include "json_print.h"
 #include "version.h"
 #include "utils.h"
 
@@ -337,15 +337,13 @@ static void load_raw_table(FILE *fp)
 
 static void dump_raw_db(FILE *fp, int to_hist)
 {
-	json_writer_t *jw = json_output ? jsonw_new(fp) : NULL;
 	struct ifstat_ent *n, *h;
 
 	h = hist_db;
-	if (jw) {
-		jsonw_start_object(jw);
-		jsonw_pretty(jw, pretty);
-		jsonw_name(jw, info_source);
-		jsonw_start_object(jw);
+	new_json_obj_plain(json_output);
+	if (is_json_context()) {
+		open_json_object(NULL);
+		open_json_object(info_source);
 	} else
 		fprintf(fp, "#%s\n", info_source);
 
@@ -369,13 +367,12 @@ static void dump_raw_db(FILE *fp, int to_hist)
 			}
 		}
 
-		if (jw) {
-			jsonw_name(jw, n->name);
-			jsonw_start_object(jw);
+		if (is_json_context()) {
+			open_json_object(n->name);
 
 			for (i = 0; i < MAXS && stats[i]; i++)
-				jsonw_uint_field(jw, stats[i], vals[i]);
-			jsonw_end_object(jw);
+				print_lluint(PRINT_JSON, stats[i], NULL, vals[i]);
+			close_json_object();
 		} else {
 			fprintf(fp, "%d %s ", n->ifindex, n->name);
 			for (i = 0; i < MAXS; i++)
@@ -384,12 +381,11 @@ static void dump_raw_db(FILE *fp, int to_hist)
 			fprintf(fp, "\n");
 		}
 	}
-	if (jw) {
-		jsonw_end_object(jw);
-
-		jsonw_end_object(jw);
-		jsonw_destroy(&jw);
+	if (is_json_context()) {
+		close_json_object();
+		close_json_object();
 	}
+	delete_json_obj_plain();
 }
 
 /* use communication definitions of meg/kilo etc */
@@ -483,18 +479,17 @@ static void print_head(FILE *fp)
 	}
 }
 
-static void print_one_json(json_writer_t *jw, const struct ifstat_ent *n,
+static void print_one_json(const struct ifstat_ent *n,
 			   const unsigned long long *vals)
 {
 	int i, m = show_errors ? 20 : 10;
 
-	jsonw_name(jw, n->name);
-	jsonw_start_object(jw);
+	open_json_object(n->name);
 
 	for (i = 0; i < m && stats[i]; i++)
-		jsonw_uint_field(jw, stats[i], vals[i]);
+		print_lluint(PRINT_JSON, stats[i], NULL, vals[i]);
 
-	jsonw_end_object(jw);
+	close_json_object();
 }
 
 static void print_one_if(FILE *fp, const struct ifstat_ent *n,
@@ -547,14 +542,12 @@ static void print_one_if(FILE *fp, const struct ifstat_ent *n,
 
 static void dump_kern_db(FILE *fp)
 {
-	json_writer_t *jw = json_output ? jsonw_new(fp) : NULL;
 	struct ifstat_ent *n;
 
-	if (jw) {
-		jsonw_start_object(jw);
-		jsonw_pretty(jw, pretty);
-		jsonw_name(jw, info_source);
-		jsonw_start_object(jw);
+	new_json_obj_plain(json_output);
+	if (is_json_context()) {
+		open_json_object(NULL);
+		open_json_object(info_source);
 	} else
 		print_head(fp);
 
@@ -562,30 +555,27 @@ static void dump_kern_db(FILE *fp)
 		if (!match(n->name))
 			continue;
 
-		if (jw)
-			print_one_json(jw, n, n->val);
+		if (is_json_context())
+			print_one_json(n, n->val);
 		else
 			print_one_if(fp, n, n->val);
 	}
-	if (jw) {
-		jsonw_end_object(jw);
-
-		jsonw_end_object(jw);
-		jsonw_destroy(&jw);
+	if (is_json_context()) {
+		close_json_object();
+		close_json_object();
 	}
+	delete_json_obj_plain();
 }
 
 static void dump_incr_db(FILE *fp)
 {
 	struct ifstat_ent *n, *h;
-	json_writer_t *jw = json_output ? jsonw_new(fp) : NULL;
 
 	h = hist_db;
-	if (jw) {
-		jsonw_start_object(jw);
-		jsonw_pretty(jw, pretty);
-		jsonw_name(jw, info_source);
-		jsonw_start_object(jw);
+	new_json_obj_plain(json_output);
+	if (is_json_context()) {
+		open_json_object(NULL);
+		open_json_object(info_source);
 	} else
 		print_head(fp);
 
@@ -607,18 +597,17 @@ static void dump_incr_db(FILE *fp)
 		if (!match(n->name))
 			continue;
 
-		if (jw)
-			print_one_json(jw, n, n->val);
+		if (is_json_context())
+			print_one_json(n, n->val);
 		else
 			print_one_if(fp, n, vals);
 	}
 
-	if (jw) {
-		jsonw_end_object(jw);
-
-		jsonw_end_object(jw);
-		jsonw_destroy(&jw);
+	if (is_json_context()) {
+		close_json_object();
+		close_json_object();
 	}
+	delete_json_obj_plain();
 }
 
 static int children;
-- 
2.51.0


