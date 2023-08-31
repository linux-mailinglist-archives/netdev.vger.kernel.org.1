Return-Path: <netdev+bounces-31581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9877078EE7A
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91FF1C20ABF
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D239111C84;
	Thu, 31 Aug 2023 13:22:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C188411C82
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:22:39 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC09CEB
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401da71b7faso8193215e9.2
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693488157; x=1694092957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fO1qCKwrMIuDKlrQa6pAbTr3sD/BPmYH7vzrt4lfo9o=;
        b=jW4bLm8RExVM/v3A5SR+xzOzAhCwWQx4pL0d8ds4Tqu/s3J/x3FwRR3m5PDMWZReaU
         PYj6mBSf8Mc5l2rCx6bov5VlkEyOS2hbYpLzSWWKvVQVFFyjc8mxCvQoM0FW44KjViZc
         kpFYMSK4+CjTKPCGlotI4B99+WRNzLOa4kBzjMlpiChlwYMxdhKseufad9Y/NHrKMXyA
         VdqqvtRqjUVg2MY22OSaJudoGffKNe6+4ItheukCb2Cd22aPj4Fm9Hvt72BvXl0mX0vC
         o/B/mYwVOeUv4SY0zXArbbBj9hHAlZjLkEMPeanyw8Y0c2MG0UVXyqNe8jTn2lxDgH2p
         Pf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693488157; x=1694092957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fO1qCKwrMIuDKlrQa6pAbTr3sD/BPmYH7vzrt4lfo9o=;
        b=hqt9K1xen+DG6k0pr9sPFMCuBh7pt28Vs+pKPy5J5B/ACyO2MNQiWJSir77jN0Vo23
         IGiRYPx6jxFohI7zCd0GbVId2llCNQhko+fAgXCiovRobHHOuUzBE4k/fTK0H+YYaM1r
         u9o5ebDi3OWnZHguG/Uu9fcI8H2EP/X/SU7fqkkziYgJ+r+cHIM0pFaKBm+MzWDthT/X
         2ejVq7DqSmzo6Zn9IdthnR2mVOd8goypQfmgBUtnN+lAZL2i07KSBaesSrwkn5RG8PMU
         hNA5Z+5qHcCH8Cd5M/ENb0wM2zTJ+vPLXlzk2sd8raoTVj5idEQAZTcJKmMZqm6vbsEW
         Z6Cg==
X-Gm-Message-State: AOJu0YwHkmyJxw1Ky/x6lU7Sc3C4FVcXHVzgPIpoNKnlQylMaquRRoZX
	+8F/d9LDFLiqhDlJwPF9QUImhOw45CyKtadvUtI=
X-Google-Smtp-Source: AGHT+IEnkZkoiP7m5NenJYYYcSu3pgmvitG/W5ttddAtcuyLs5XlHd+CMeXNzCJCDNeC3hmLrypk6Q==
X-Received: by 2002:a1c:7718:0:b0:400:57d1:4914 with SMTP id t24-20020a1c7718000000b0040057d14914mr4086176wmi.5.1693488156990;
        Thu, 31 Aug 2023 06:22:36 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bca49000000b003fed1ba0b8esm1981983wml.8.2023.08.31.06.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:22:36 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next 3/6] devlink: implement command line args dry parsing
Date: Thu, 31 Aug 2023 15:22:26 +0200
Message-ID: <20230831132229.471693-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831132229.471693-1-jiri@resnulli.us>
References: <20230831132229.471693-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

In preparation to the follow-up dump selector patch, introduce function
dl_argv_dry_parse() which allows to do dry parsing of command line
arguments without printing out any error messages to the user.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index e7b5b788863a..8d2424f58cc2 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -64,6 +64,7 @@
 static int g_new_line_count;
 static int g_indent_level;
 static bool g_indent_newline;
+static bool g_err_suspended;
 
 #define INDENT_STR_STEP 2
 #define INDENT_STR_MAXLEN 32
@@ -74,6 +75,8 @@ pr_err(const char *fmt, ...)
 {
 	va_list ap;
 
+	if (g_err_suspended)
+		return;
 	va_start(ap, fmt);
 	vfprintf(stderr, fmt, ap);
 	va_end(ap);
@@ -2284,6 +2287,21 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 	return dl_args_finding_required_validate(o_required, o_found);
 }
 
+static int dl_argv_dry_parse(struct dl *dl, uint64_t o_required,
+			     uint64_t o_optional)
+{
+	char **argv = dl->argv;
+	int argc = dl->argc;
+	int err;
+
+	g_err_suspended = true;
+	err = dl_argv_parse(dl, o_required, o_optional);
+	g_err_suspended = false;
+	dl->argv = argv;
+	dl->argc = argc;
+	return err;
+}
+
 static void
 dl_function_attr_put(struct nlmsghdr *nlh, const struct dl_opts *opts)
 {
-- 
2.41.0


