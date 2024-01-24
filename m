Return-Path: <netdev+bounces-65501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2DB83AD71
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD071B22B7F
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D849A7A734;
	Wed, 24 Jan 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jotevIcJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078787C082
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110506; cv=none; b=Gq6Lgq1yzrk5b51pGRcKnhxXBCRKdzg6dDzFfZ6SFmhhqqGlg2P7IftjurMZzlUb+VVYJz9b+qxpulpy6pUuLmwZ/SXVpOEOBFcypd7pv/MHbkbi9Naafi+sJpWEEb5KXdc8n7Ynt4WqD5GQ9nCMhPKF+zkH8/Gc0y2UjeDLofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110506; c=relaxed/simple;
	bh=xjpx4/p4kJjqH6ivvfhm1dV+hL6S1Yp9UzN6xhYBtHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLenguDPDGARHbjvAaZiZtuxqAq549UxNLKoCstx1+JdexFceSJ490DNfjPoZwca8oj+R/rUVaUj/g0FbgT8vYHPc0kNloLQRiPg5Wdqf7esyTxtgaS7BLKk0wgZ3kD2lgkdtURJKtV7uVXSXaFwBo33kgzJPaIf8d+DDABotxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=jotevIcJ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so879525a12.3
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 07:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706110504; x=1706715304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPFYhqdZLcl+3VvqDHsMb47q6ZAy28knZkPIRciKrr8=;
        b=jotevIcJXW88yaR11jDdtet9LAy/qfLRliLDN53jPKniMJVzbRGfABg0Vj2Wv+7kid
         oM5/Msab7LVtcpTowQi84HE7bJOzd+KU/sdDLrEOurMM+nvngEhHeQfrPIiY+YEA1NkW
         VS/W4fhAkucsvCBou23qUP/TTRXql5d5wea3k0LGJ04txAbfoWk9/R9ckJplxlqkBC9n
         5zRguaNzXiIL35ucd3Vowv4npvnTzq+v/koG3ZfkXR8yJHkbGH+7Q8eoAbF/RNmsQ75N
         l+ef/p0lVExqICJQpaaLm+eehAzmo1jsa6vtbQd/p/KHhdywAQYvq/9+MJZc9AHd9+UE
         gKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110504; x=1706715304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPFYhqdZLcl+3VvqDHsMb47q6ZAy28knZkPIRciKrr8=;
        b=Au4i1Dn+f42joRTKiN7mva+OC3G88LEdE1KT5rLPGldniNkhDU5oPYQN/TVDXrghvu
         Wm5bkQz0vYAjXEMpHv3ZeAZI9kzZzb9ZESeMb9zLMJ2jBuxIq+ovI+tp/Zdk4mzlwtmJ
         ux9DHZPLaCwRqPGS28GcMkTj5sO6rP2XTzaTkLOBMQAQcikpqxRuT+P5u2uM6P/QQp3A
         UPHuN1IyInvW3tj3qdWoyWR9utOsJqwwKdcT1WtIcWvLQa8sQi68cXqqrYKucb8iaaGP
         cHxdWg7HbOk2FRTi7y+FbwaHqeJJGQH5M75Ej3CW+XLUpQbjzK+rjP6RhFhf9GEMYVvd
         o7KA==
X-Gm-Message-State: AOJu0Yy29I0Y9UI4P7HLhL6zjMnQr6+TXnZHj8IcBKpSBA9twOsNdIh/
	RkFGoyl+rvOYBjmVyaLXfjDaL2xfYelEtp8XV947DdRhY+HSdIGE0NBPjXxMOg==
X-Google-Smtp-Source: AGHT+IGPf1XBImWq19P2q+7c5AraHD8LYeZ5nZ/p3s3WCgNLUpiwUwrInX3TsN/8nFFvaaiJOS3xkg==
X-Received: by 2002:a17:903:985:b0:1d7:562f:67da with SMTP id mb5-20020a170903098500b001d7562f67damr828085plb.41.1706110504081;
        Wed, 24 Jan 2024 07:35:04 -0800 (PST)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c1:7b01:4fb3:24d0:ad57:53c9])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170903284600b001d7284b9461sm7824837plb.128.2024.01.24.07.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:35:03 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org
Cc: liuhangbin@gmail.com,
	jhs@mojatatu.com,
	kernel@mojatatu.com
Subject: [PATCH iproute2-next 1/2] tc: add NLM_F_ECHO support for actions
Date: Wed, 24 Jan 2024 12:34:55 -0300
Message-ID: <20240124153456.117048-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124153456.117048-1-victor@mojatatu.com>
References: <20240124153456.117048-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the -echo flag to tc command line and support for it in
tc actions. If the user specifies this flag for an action command, the
kernel will return the command's result back to user space.
For example:

  tc -echo actions add action mirred egress mirror dev lo

  total acts 0
  Added action
        action order 1: mirred (Egress Mirror to device lo) pipe
        index 10 ref 1 bind 0
        not_in_hw

As illustrated above, the kernel will give us an index of 10

The same can be done for other action commands (replace, change, and
delete). For example:

  tc -echo actions delete action mirred index 10

  total acts 0
  Deleted action
        action order 1: mirred (Egress Mirror to device lo) pipe
        index 10 ref 0 bind 0
        not_in_hw

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 man/man8/tc.8 |  6 +++++-
 tc/m_action.c | 25 ++++++++++++++++++++++---
 tc/tc.c       |  6 +++++-
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/man/man8/tc.8 b/man/man8/tc.8
index 3175454b9..dce58af17 100644
--- a/man/man8/tc.8
+++ b/man/man8/tc.8
@@ -127,7 +127,7 @@ tc \- show / manipulate traffic control settings
 \fB[ \fB-nm \fR| \fB-nam\fR[\fIes\fR] \fB] \fR|
 \fB[ \fR{ \fB-cf \fR| \fB-c\fR[\fIonf\fR] \fR} \fB[ filename ] \fB] \fR
 \fB[ -t\fR[imestamp\fR] \fB\] \fR| \fB[ -t\fR[short\fR] \fR| \fB[
--o\fR[neline\fR] \fB]\fR }
+-o\fR[neline\fR] \fB] \fR| \fB[ -echo ]\fR }
 
 .ti 8
 .IR FORMAT " := {"
@@ -743,6 +743,10 @@ When\fB\ tc monitor\fR\ runs, print timestamp before the event message in format
 When\fB\ tc monitor\fR\ runs, prints short timestamp before the event message in format:
    [<YYYY>-<MM>-<DD>T<hh:mm:ss>.<ms>]
 
+.TP
+.BR "\-echo"
+Request the kernel to send the applied configuration back.
+
 .SH FORMAT
 The show command has additional formatting options:
 
diff --git a/tc/m_action.c b/tc/m_action.c
index 16474c561..fd9621e1b 100644
--- a/tc/m_action.c
+++ b/tc/m_action.c
@@ -688,7 +688,16 @@ static int tc_action_gd(int cmd, unsigned int flags,
 
 	req.n.nlmsg_seq = rth.dump = ++rth.seq;
 
-	if (rtnl_talk(&rth, &req.n, cmd == RTM_DELACTION ? NULL : &ans) < 0) {
+	if (cmd == RTM_DELACTION) {
+		if (echo_request)
+			ret = rtnl_echo_talk(&rth, &req.n, json, print_action);
+		else
+			ret = rtnl_talk(&rth, &req.n, NULL);
+	} else {
+		ret = rtnl_talk(&rth, &req.n, &ans);
+	}
+
+	if (ret < 0) {
 		fprintf(stderr, "We have an error talking to the kernel\n");
 		return 1;
 	}
@@ -738,7 +747,12 @@ static int tc_action_modify(int cmd, unsigned int flags,
 	}
 	tail->rta_len = (void *) NLMSG_TAIL(&req.n) - (void *) tail;
 
-	if (rtnl_talk(&rth, &req.n, NULL) < 0) {
+	if (echo_request)
+		ret = rtnl_echo_talk(&rth, &req.n, json, print_action);
+	else
+		ret = rtnl_talk(&rth, &req.n, NULL);
+
+	if (ret < 0) {
 		fprintf(stderr, "We have an error talking to the kernel\n");
 		ret = -1;
 	}
@@ -836,7 +850,12 @@ static int tc_act_list_or_flush(int *argc_p, char ***argv_p, int event)
 		req.n.nlmsg_type = RTM_DELACTION;
 		req.n.nlmsg_flags |= NLM_F_ROOT;
 		req.n.nlmsg_flags |= NLM_F_REQUEST;
-		if (rtnl_talk(&rth, &req.n, NULL) < 0) {
+
+		if (echo_request)
+			ret = rtnl_echo_talk(&rth, &req.n, json, print_action);
+		else
+			ret = rtnl_talk(&rth, &req.n, NULL);
+		if (ret < 0) {
 			fprintf(stderr, "We have an error flushing\n");
 			return 1;
 		}
diff --git a/tc/tc.c b/tc/tc.c
index 575157a86..7a746cf51 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -38,6 +38,8 @@ int json;
 int oneline;
 int brief;
 
+int echo_request;
+
 static char *conf_file;
 
 struct rtnl_handle rth;
@@ -196,7 +198,7 @@ static void usage(void)
 		"		    -o[neline] | -j[son] | -p[retty] | -c[olor]\n"
 		"		    -b[atch] [filename] | -n[etns] name | -N[umeric] |\n"
 		"		     -nm | -nam[es] | { -cf | -conf } path\n"
-		"		     -br[ief] }\n");
+		"		     -br[ief] | -echo }\n");
 }
 
 static int do_cmd(int argc, char **argv)
@@ -314,6 +316,8 @@ int main(int argc, char **argv)
 			++oneline;
 		} else if (matches(argv[1], "-brief") == 0) {
 			++brief;
+		} else if (strcmp(argv[1], "-echo") == 0) {
+			++echo_request;
 		} else {
 			fprintf(stderr,
 				"Option \"%s\" is unknown, try \"tc -help\".\n",
-- 
2.25.1


