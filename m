Return-Path: <netdev+bounces-61074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CC5822604
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 01:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CBE2848DF
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1273F7E8;
	Wed,  3 Jan 2024 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ezpBRlDm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AF655
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbebe6191bso2891810b6e.3
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 16:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704242170; x=1704846970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joh+KKCav0TyiAWmMDEkWm48inIYUD1e06QlNTY3D3Y=;
        b=ezpBRlDm8aNCLaslaMfATM4cMraeAEhFzogx23w8UTF7FdRhW7ACvCBuc0mfv8hOFW
         sp5I9EVWmgClaNfXllEN9ZoiVwcSgbunJxMYJHCMly5xEVpGJzDkK49forUQfBaERQGh
         HDhMz+UdmeGTPAlTZa1UxoWPPYxEeRkDEsNN1PGCjPjy8/TKp0ekz/TC9VSsOqAqZz5r
         EmQngW4ljWvP6N6IhMh2tzcLRw32a9NMbsNI/zuHlQ1SeHZYAE/fDOy8li2noCG8fHe4
         UiVNEdGH9I1IofEOLRkfngWCKieKcyr2U2NpsMfhdSeeeKZG9XckfALl/yDdlPeMptPC
         5/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704242170; x=1704846970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joh+KKCav0TyiAWmMDEkWm48inIYUD1e06QlNTY3D3Y=;
        b=WWsEn+9Try+h+gY9BL8wqM10dHZtYwY8+KtwMtyhQEJqWpmzIWbua9B3Nfne6c9aVh
         U4sCCWoAlybGuNYwEOlf7t3id2ouaa+GetY0c41hiQPzlGcvYodf9ZnH7FKcACR2AZ4a
         R/YlpahpPHbgDtN101KOS8yw7fCZvncTyzVQx5yU2S9qk8W5kBnSMZVbS8gRCTcNRwT7
         UVzGRmprVjvYmsvC59S2bDguTFoNIxCw71vJJUT9MvLGeOa+ThYMSz3v+iqhqkTjzvZf
         M5BkX/ioK9fVRB20inTNpMBJ+9zZaBrum3P5Z0jnBUUSW15HF+Tim1OytOEI1IZXoi9/
         uhKg==
X-Gm-Message-State: AOJu0YwnHhFvru3nqpMB/z2GR9ly6GUftyL+jzTIWOxSIUc44WyYFOuw
	WSXu2OA+ZH7+u4hvLB+VQ+Jnxf76scWRXQ==
X-Google-Smtp-Source: AGHT+IGH9Mk8vHs6LOaqNgxPvjewYYEir9LD+VyTQVXK65zCsh8MiJqHt3eNZmK1qrY+EwkEb/8Xnw==
X-Received: by 2002:a05:6808:23ce:b0:3bc:2217:61ac with SMTP id bq14-20020a05680823ce00b003bc221761acmr935052oib.15.1704242170450;
        Tue, 02 Jan 2024 16:36:10 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7854c000000b006d9af59eecesm16698260pfn.20.2024.01.02.16.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 16:36:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: leon@kernel.org
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute2 2/8] rdma: use standard flag for json
Date: Tue,  2 Jan 2024 16:34:27 -0800
Message-ID: <20240103003558.20615-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103003558.20615-1-stephen@networkplumber.org>
References: <20240103003558.20615-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The other iproute2 utils use variable json as flag.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 rdma/rdma.c  |  7 ++++---
 rdma/rdma.h  |  1 -
 rdma/res.c   |  5 ++---
 rdma/stat.c  |  4 ++--
 rdma/utils.c | 12 ++++++------
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/rdma/rdma.c b/rdma/rdma.c
index 8dc2d3e344be..60ba8c0e5594 100644
--- a/rdma/rdma.c
+++ b/rdma/rdma.c
@@ -8,6 +8,9 @@
 #include "version.h"
 #include "color.h"
 
+/* Global utils flags */
+int json;
+
 static void help(char *name)
 {
 	pr_out("Usage: %s [ OPTIONS ] OBJECT { COMMAND | help }\n"
@@ -96,7 +99,6 @@ int main(int argc, char **argv)
 	bool show_driver_details = false;
 	const char *batch_file = NULL;
 	bool show_details = false;
-	bool json_output = false;
 	bool show_raw = false;
 	bool force = false;
 	struct rd rd = {};
@@ -125,7 +127,7 @@ int main(int argc, char **argv)
 			show_raw = true;
 			break;
 		case 'j':
-			json_output = 1;
+			++json;
 			break;
 		case 'f':
 			force = true;
@@ -151,7 +153,6 @@ int main(int argc, char **argv)
 
 	rd.show_details = show_details;
 	rd.show_driver_details = show_driver_details;
-	rd.json_output = json_output;
 	rd.pretty_output = pretty;
 	rd.show_raw = show_raw;
 
diff --git a/rdma/rdma.h b/rdma/rdma.h
index 0bf77f4dcf9e..f6830c851fb1 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -68,7 +68,6 @@ struct rd {
 	struct nlmsghdr *nlh;
 	char *buff;
 	json_writer_t *jw;
-	int json_output;
 	int pretty_output;
 	bool suppress_errors;
 	struct list_head filter_list;
diff --git a/rdma/res.c b/rdma/res.c
index 715cf93c4fab..f64224e1f3eb 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -160,7 +160,7 @@ void print_comm(struct rd *rd, const char *str, struct nlattr **nla_line)
 	if (!str)
 		return;
 
-	if (nla_line[RDMA_NLDEV_ATTR_RES_PID] || rd->json_output)
+	if (nla_line[RDMA_NLDEV_ATTR_RES_PID] || is_json_context())
 		snprintf(tmp, sizeof(tmp), "%s", str);
 	else
 		snprintf(tmp, sizeof(tmp), "[%s]", str);
@@ -187,8 +187,7 @@ void print_link(struct rd *rd, uint32_t idx, const char *name, uint32_t port,
 		snprintf(tmp, sizeof(tmp), "%s/-", name);
 	}
 
-	if (!rd->json_output)
-		print_string(PRINT_ANY, NULL, "link %s ", tmp);
+	print_string(PRINT_FP, NULL, "link %s ", tmp);
 }
 
 void print_qp_type(struct rd *rd, uint32_t val)
diff --git a/rdma/stat.c b/rdma/stat.c
index 28b1ad857219..6a3f8ca44892 100644
--- a/rdma/stat.c
+++ b/rdma/stat.c
@@ -208,7 +208,7 @@ int res_get_hwcounters(struct rd *rd, struct nlattr *hwc_table, bool print)
 
 		nm = mnl_attr_get_str(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
 		v = mnl_attr_get_u64(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_VALUE]);
-		if (rd->pretty_output && !rd->json_output)
+		if (rd->pretty_output)
 			newline_indent(rd);
 		res_print_u64(rd, nm, v, hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
 	}
@@ -802,7 +802,7 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
 			} else {
 				print_string(PRINT_FP, NULL, ",", NULL);
 			}
-			if (rd->pretty_output && !rd->json_output)
+			if (rd->pretty_output)
 				newline_indent(rd);
 
 			print_string(PRINT_ANY, NULL, "%s", name);
diff --git a/rdma/utils.c b/rdma/utils.c
index f73a9f19b617..32e12a64193a 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -572,7 +572,7 @@ int rd_exec_link(struct rd *rd, int (*cb)(struct rd *rd), bool strict_port)
 	uint32_t port;
 	int ret = 0;
 
-	new_json_obj(rd->json_output);
+	new_json_obj(json);
 	if (rd_no_arg(rd)) {
 		list_for_each_entry(dev_map, &rd->dev_map_list, list) {
 			rd->dev_idx = dev_map->idx;
@@ -621,7 +621,7 @@ int rd_exec_dev(struct rd *rd, int (*cb)(struct rd *rd))
 	struct dev_map *dev_map;
 	int ret = 0;
 
-	new_json_obj(rd->json_output);
+	new_json_obj(json);
 	if (rd_no_arg(rd)) {
 		list_for_each_entry(dev_map, &rd->dev_map_list, list) {
 			rd->dev_idx = dev_map->idx;
@@ -794,7 +794,7 @@ static int print_driver_string(struct rd *rd, const char *key_str,
 static int print_driver_s32(struct rd *rd, const char *key_str, int32_t val,
 			      enum rdma_nldev_print_type print_type)
 {
-	if (!rd->json_output) {
+	if (!is_json_context()) {
 		switch (print_type) {
 		case RDMA_NLDEV_PRINT_TYPE_UNSPEC:
 			return pr_out("%s %d ", key_str, val);
@@ -811,7 +811,7 @@ static int print_driver_s32(struct rd *rd, const char *key_str, int32_t val,
 static int print_driver_u32(struct rd *rd, const char *key_str, uint32_t val,
 			      enum rdma_nldev_print_type print_type)
 {
-	if (!rd->json_output) {
+	if (!is_json_context()) {
 		switch (print_type) {
 		case RDMA_NLDEV_PRINT_TYPE_UNSPEC:
 			return pr_out("%s %u ", key_str, val);
@@ -828,7 +828,7 @@ static int print_driver_u32(struct rd *rd, const char *key_str, uint32_t val,
 static int print_driver_s64(struct rd *rd, const char *key_str, int64_t val,
 			      enum rdma_nldev_print_type print_type)
 {
-	if (!rd->json_output) {
+	if (!is_json_context()) {
 		switch (print_type) {
 		case RDMA_NLDEV_PRINT_TYPE_UNSPEC:
 			return pr_out("%s %" PRId64 " ", key_str, val);
@@ -845,7 +845,7 @@ static int print_driver_s64(struct rd *rd, const char *key_str, int64_t val,
 static int print_driver_u64(struct rd *rd, const char *key_str, uint64_t val,
 			      enum rdma_nldev_print_type print_type)
 {
-	if (!rd->json_output) {
+	if (!is_json_context()) {
 		switch (print_type) {
 		case RDMA_NLDEV_PRINT_TYPE_UNSPEC:
 			return pr_out("%s %" PRIu64 " ", key_str, val);
-- 
2.43.0


