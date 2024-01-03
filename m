Return-Path: <netdev+bounces-61072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C956D822602
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 01:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5747928469C
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512A5654;
	Wed,  3 Jan 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="IlmK1pPd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD512580
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9a795cffbso4696228b3a.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 16:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704242171; x=1704846971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHkrjOkOte7bqKcE1yFAWukI27bsGeUXJY3eIZvDCE4=;
        b=IlmK1pPdeRD3IoHt+wfkQOXPb3cFO7azQ9eGcbz4SWEgmVItdIi80KYn0XH5YMhVFR
         CtQ3RLNUviMPAHfnggsTNQ0nL7BRS9nplYQAhoHq/g7sq9YK4t5t3hhxVKKoZD83Lko1
         YZcs5JnJKmlTfEZLKEWUs5WnH7VmQHB7s8tTCP61lTkEWgJIb9Swd9GnkB6m4YsSE/HL
         L4kmr/jEMLDqjycrEO52v/LE4fXjNtYqS1U0oTgULnK1dRzTSP0lKtcmP4tAJqK0p7Yk
         H9Rov0Jh/rNCev1A/5aN3qhnqWTKTbvlxzbTphy3rJk1+zroJWvvdRyzqHgojoC8s64c
         8/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704242171; x=1704846971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHkrjOkOte7bqKcE1yFAWukI27bsGeUXJY3eIZvDCE4=;
        b=wijaCfiYusTBDVwRj1KqxBXnzVkC/buQIDqbvmMvkYA37xRM3HuHy7xXmpB/KMUb18
         4M3lGhxzT0RIGL5zrg6nqUotTWMgNSCj38ZXerDnmrey0Bv7KMgRvW7si73Tfvzmc8Ym
         1QJM6E8n0e/9rKbVOZ4PqGMAzVWx98O+REgREn1M2LraH3eCiyoKOv8gko96W4GbxirZ
         Cp7TZEUOCM3AMFyrrfaQ9BF0hvK/0t+P75nGPpIvXfzfJG7tfvdkH2R6vWD8jJ8LjB28
         9OndkPlxa0umF4vA87y4irNx76XzQEDDULgNmSqLOYkVfTwT9Vdsqa04XfC8G338e7YV
         owSg==
X-Gm-Message-State: AOJu0Yz7g/csEofct+FhcIKxp+9Ejk6UaVLtOd+4b+TdagWDPtFS4grW
	pb/HBFEpkCipY4pBsceZeYrr/5Kh2VsPZQ==
X-Google-Smtp-Source: AGHT+IFzISESChFBSf3uNjITx7VGfMPOQ9b/b8lBWRO7prmqXYDqcoZ2Q9sDDjjzIOREo1Ehadn5WA==
X-Received: by 2002:a05:6a00:acd:b0:6d9:93d7:478 with SMTP id c13-20020a056a000acd00b006d993d70478mr255927pfl.34.1704242171103;
        Tue, 02 Jan 2024 16:36:11 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7854c000000b006d9af59eecesm16698260pfn.20.2024.01.02.16.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 16:36:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: leon@kernel.org
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute2 3/8] rdma: make pretty behave like other commands
Date: Tue,  2 Jan 2024 16:34:28 -0800
Message-ID: <20240103003558.20615-4-stephen@networkplumber.org>
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

For tc, ip, etc the -pretty flag only has meaning if json
is used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 rdma/rdma.c  | 3 +--
 rdma/rdma.h  | 1 -
 rdma/stat.c  | 6 ++----
 rdma/utils.c | 6 ++----
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/rdma/rdma.c b/rdma/rdma.c
index 60ba8c0e5594..bee1985f96d8 100644
--- a/rdma/rdma.c
+++ b/rdma/rdma.c
@@ -115,7 +115,7 @@ int main(int argc, char **argv)
 			       filename, version);
 			return EXIT_SUCCESS;
 		case 'p':
-			pretty = 1;
+			++pretty;
 			break;
 		case 'd':
 			if (show_details)
@@ -153,7 +153,6 @@ int main(int argc, char **argv)
 
 	rd.show_details = show_details;
 	rd.show_driver_details = show_driver_details;
-	rd.pretty_output = pretty;
 	rd.show_raw = show_raw;
 
 	err = rd_init(&rd, filename);
diff --git a/rdma/rdma.h b/rdma/rdma.h
index f6830c851fb1..f9308dbcfafd 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -68,7 +68,6 @@ struct rd {
 	struct nlmsghdr *nlh;
 	char *buff;
 	json_writer_t *jw;
-	int pretty_output;
 	bool suppress_errors;
 	struct list_head filter_list;
 	char *link_name;
diff --git a/rdma/stat.c b/rdma/stat.c
index 6a3f8ca44892..b428a62ac707 100644
--- a/rdma/stat.c
+++ b/rdma/stat.c
@@ -208,8 +208,7 @@ int res_get_hwcounters(struct rd *rd, struct nlattr *hwc_table, bool print)
 
 		nm = mnl_attr_get_str(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
 		v = mnl_attr_get_u64(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_VALUE]);
-		if (rd->pretty_output)
-			newline_indent(rd);
+		newline_indent(rd);
 		res_print_u64(rd, nm, v, hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
 	}
 
@@ -802,8 +801,7 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
 			} else {
 				print_string(PRINT_FP, NULL, ",", NULL);
 			}
-			if (rd->pretty_output)
-				newline_indent(rd);
+			newline_indent(rd);
 
 			print_string(PRINT_ANY, NULL, "%s", name);
 		}
diff --git a/rdma/utils.c b/rdma/utils.c
index 32e12a64193a..f332b2602e6f 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -920,8 +920,7 @@ void print_driver_table(struct rd *rd, struct nlattr *tb)
 	if (!rd->show_driver_details || !tb)
 		return;
 
-	if (rd->pretty_output)
-		newline_indent(rd);
+	newline_indent(rd);
 
 	/*
 	 * Driver attrs are tuples of {key, [print-type], value}.
@@ -933,8 +932,7 @@ void print_driver_table(struct rd *rd, struct nlattr *tb)
 	mnl_attr_for_each_nested(tb_entry, tb) {
 
 		if (cc > MAX_LINE_LENGTH) {
-			if (rd->pretty_output)
-				newline_indent(rd);
+			newline_indent(rd);
 			cc = 0;
 		}
 		if (rd_attr_check(tb_entry, &type) != MNL_CB_OK)
-- 
2.43.0


