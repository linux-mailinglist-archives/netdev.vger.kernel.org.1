Return-Path: <netdev+bounces-231397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3E3BF8BE7
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A12384FB029
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678F227FD7D;
	Tue, 21 Oct 2025 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TttCF6Aq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961C1AD5A
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079235; cv=none; b=VNzbQGkFd/HnhTfAPBmPGCX6L3zKaDb/U753Fcv2nxGvMk6R+Wf9HUo4Okwldo1worfDbBz4dC3udWnupWm7K/6bPT8meJvwFHCRGEeD1lvm7Fngwfn1Kx3GpFckvrX2iuyHBzWQ/+er3ZJqnuCuikfrCLkZo1mX+O7XG9E/MPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079235; c=relaxed/simple;
	bh=V93iWxG4sCRBtMfI86h2y42zg0yWAYGyoXyKOjUqD00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMz6u8b+avZ+PfA6J4DilJjzMvp3SosDP1ng/A7A3CkiNKz/Xkvf/F5bp48o5GBy9dVt1NVMN9CixPV20VF3B+jTtJ7QBN5AB5FvCTxQFMpppLcqZ3NvRvwi3alY3ERlwG/JQM/29fLd2LbSr+E9/7JlV3upz846Cw1dlXxCuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TttCF6Aq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761079232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKNtUJTKHTiD6vTE4MXagtk/YgU1+NH6ZLuJOHzQ9es=;
	b=TttCF6Aq4tNgWfmIusNjESoWH5hFgCrXn02bypLOFxpCUJz0cXq14nusXeo60GIV+Ui2BB
	0DwZlZV+zvm23Y+ZMyLHiOivL2WDQ0fkKfP0AJaPcKV+W0LyYoQoMetUoWe3o5eBDWUoRs
	Qoe4jfRc0MsnJSewqQeDYZhCn7sA2MY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-pygbgBsbMguSE3w7E9jMDg-1; Tue,
 21 Oct 2025 16:40:31 -0400
X-MC-Unique: pygbgBsbMguSE3w7E9jMDg-1
X-Mimecast-MFC-AGG-ID: pygbgBsbMguSE3w7E9jMDg_1761079229
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CF8B1956094;
	Tue, 21 Oct 2025 20:40:29 +0000 (UTC)
Received: from tc2.redhat.com (unknown [10.44.32.244])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0EA61800583;
	Tue, 21 Oct 2025 20:40:26 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2-next 2/3] nstat: convert to high-level json_print API
Date: Tue, 21 Oct 2025 22:39:17 +0200
Message-ID: <f38fe2b8a9b0505cb8be954286647d7a0773e2d3.1761078778.git.aclaudi@redhat.com>
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
 misc/nstat.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/misc/nstat.c b/misc/nstat.c
index b2e19bde..4a9f3326 100644
--- a/misc/nstat.c
+++ b/misc/nstat.c
@@ -24,7 +24,7 @@
 #include <math.h>
 #include <getopt.h>
 
-#include <json_writer.h>
+#include "json_print.h"
 #include "version.h"
 #include "utils.h"
 
@@ -309,15 +309,13 @@ static void load_netstat(void)
 
 static void dump_kern_db(FILE *fp, int to_hist)
 {
-	json_writer_t *jw = json_output ? jsonw_new(fp) : NULL;
 	struct nstat_ent *n, *h;
 
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
 
@@ -340,31 +338,28 @@ static void dump_kern_db(FILE *fp, int to_hist)
 			}
 		}
 
-		if (jw)
-			jsonw_uint_field(jw, n->id, val);
+		if (is_json_context())
+			print_lluint(PRINT_JSON, n->id, NULL, val);
 		else
 			fprintf(fp, "%-32s%-16llu%6.1f\n", n->id, val, n->rate);
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
-	json_writer_t *jw = json_output ? jsonw_new(fp) : NULL;
 	struct nstat_ent *n, *h;
 
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
 
@@ -389,19 +384,18 @@ static void dump_incr_db(FILE *fp)
 		if (!match(n->id))
 			continue;
 
-		if (jw)
-			jsonw_uint_field(jw, n->id, val);
+		if (is_json_context())
+			print_lluint(PRINT_JSON, n->id, NULL, val);
 		else
 			fprintf(fp, "%-32s%-16llu%6.1f%s\n", n->id, val,
 				n->rate, ovfl?" (overflow)":"");
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


