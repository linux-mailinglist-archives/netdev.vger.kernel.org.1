Return-Path: <netdev+bounces-131542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A46D98ECBB
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E21C219CE
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22114149C6F;
	Thu,  3 Oct 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a3y8GoBY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774FB146A71
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727950522; cv=none; b=nBn51j0BreLKet58bdsNDZ+HgYmvVDrKpMbWeEV7wlf9Bu+MlA5S+gwvDkYssz1brE0PH6/QpnCXa2dclUWqqNuxw9KeUecDmYZDjbKjrgW8QltkGGOzzvA6hdjsB9e0mCv+W95pBcxGB5r7Ix/Uv4C/o3y4Nb0urN7l4aKzGOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727950522; c=relaxed/simple;
	bh=W/q391NOLcv4N9mlbQz9RJQksLSfpRms186k8UVJH4c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VJoUCv1onYo8EE4odF5XTbB6Q4+DDoPRm7uSj3Rdc53as/k2VIASJS5LJRPVkvG1Ii8zoSsR2qZUJyU2I55PZTZu1Qkd52KKqXfNewq6HEVq5ksvGQV6sRonF6MYVsR7U2cdGB14RNlCj1ZJm/zGTk6jyjwerkBS/MuuQ/4BZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a3y8GoBY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2608234531so1108902276.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727950519; x=1728555319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hHKdquS6rEAHEJhD2/T+ynunH+V8kyPoT7KF23CFusM=;
        b=a3y8GoBYEUUmN0ipH1yRF5e6otP0uwaVzf+ITX/k2bky84yi6Wpnwg9vhhV2AEqRsR
         VhKSZrxBugrWirlQP3pjTy5PEKCTaHHuI+y3tErZts6zo6T3rLGbfMq3WVO3IY1yMnP8
         gxlJaw7womYP+V9v97n+j3mvID+c60atfPlanRGVdeElIWfiDd5X++szhUvlV2m6ST9c
         Ox/PXcM90Qh19L28U8XWUIirO3ZtLC3Kk6EZOy68IbTXbsPg1A7Qi6MbTb7zNkrPMniJ
         P6hQgZRahf5XG1JRm1+ZX4JiAaroC7kqbbxzoIHEyAABuz0juV9aLOLfGHjWyhMKlxeG
         RzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727950519; x=1728555319;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHKdquS6rEAHEJhD2/T+ynunH+V8kyPoT7KF23CFusM=;
        b=SDNbV9DJrQrFGdTjM4cgpclcCZD9u1iFUn3wTDxPNiAgHsyYP6c5aqu00TT2sEsvqp
         99bj1GXWK7fVR5LZMyJKpHgiwowV1VVm5qdp7p5uWfoi0KXKTvmHFCi10JlH8r/amm0n
         KZp0qsqjfj3O3JMo1ale+RuZB4VIUQ0O/v8AZ9fviN2zYhpJyceTNJnBOTRu6YjKf8FV
         o7yJ5g7uaiFYBSBnrWjMB3alNBVZxcRrAiksHNGitlmX/47qPA+CEjUuXoQHbCNWZFVY
         Q5iSB4j8B1qMX+AIVDKXgiJL+iQlnc2/knpSbsGxJSEtMNkTRoAB4GKiEepbFLGM+CPO
         O8hA==
X-Gm-Message-State: AOJu0YzrlQjlyoxO1qauHirhlUsCOuebhBKV/uMClFXcWY4CKinn3MPo
	LgOHYRxS22gRyreevlSKWNoIWCNO4liH0VPTT36SK3/RJrf38pzoFi4lzwJ1HEPj7vlBfQ+rhr3
	TL8q11/oajHYK73taCTCEtDpVcTe6wTW77AvbEmiMV81wbTg3X8JEF/8HEdncnkxhC+7MUNcfgC
	svK8oKjqWVqjRwO1ApODI1F23v/oJ75uqcdKBI6w==
X-Google-Smtp-Source: AGHT+IHbTtVLF5lQRzT0cojiPwAXbALhrRqnHeQPHtnAhxKUugHPtymnjGPCwftIdoHQpZYJ1Eb0btP9KbgV
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:12b:2883:ac1c:9f5])
 (user=maheshb job=sendgmr) by 2002:a05:6902:f08:b0:e16:4d66:982e with SMTP id
 3f1490d57ef6-e26383bed76mr15020276.5.1727950518812; Thu, 03 Oct 2024 03:15:18
 -0700 (PDT)
Date: Thu,  3 Oct 2024 03:15:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241003101506.769418-1-maheshb@google.com>
Subject: [PATCH net-next] selftest/ptp: update ptp selftest to exercise the
 gettimex options
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Kselftest <linux-kselftest@vger.kernel.org>
Cc: Mahesh Bandewar <mahesh@bandewar.net>, Mahesh Bandewar <maheshb@google.com>, 
	Shuah Khan <shuah@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

With the inclusion of commit c259acab839e ("ptp/ioctl: support
MONOTONIC{,_RAW} timestamps for PTP_SYS_OFFSET_EXTENDED") clock_gettime()
now allows retrieval of pre/post timestamps for CLOCK_MONOTONIC and
CLOCK_MONOTONIC_RAW timebases along with the previously supported
CLOCK_REALTIME.

This patch adds a command line option 'y' to the testptp program to
choose one of the allowed timebases [realtime aka system, monotonic,
and monotonic-raw).

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/ptp/testptp.c | 62 ++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 011252fe238c..58064151f2c8 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -146,6 +146,7 @@ static void usage(char *progname)
 		" -T val     set the ptp clock time to 'val' seconds\n"
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
 		" -X         get a ptp clock cross timestamp\n"
+		" -y val     pre/post tstamp timebase to use {realtime|monotonic|monotonic-raw}\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
 		progname, PTP_MAX_SAMPLES);
 }
@@ -189,6 +190,7 @@ int main(int argc, char *argv[])
 	int seconds = 0;
 	int settime = 0;
 	int channel = -1;
+	clockid_t ext_clockid = CLOCK_REALTIME;
 
 	int64_t t1, t2, tp;
 	int64_t interval, offset;
@@ -198,7 +200,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xy:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -278,6 +280,21 @@ int main(int argc, char *argv[])
 		case 'X':
 			getcross = 1;
 			break;
+		case 'y':
+			if (!strcasecmp(optarg, "realtime"))
+				ext_clockid = CLOCK_REALTIME;
+			else if (!strcasecmp(optarg, "monotonic"))
+				ext_clockid = CLOCK_MONOTONIC;
+			else if (!strcasecmp(optarg, "monotonic-raw"))
+				ext_clockid = CLOCK_MONOTONIC_RAW;
+			else {
+				fprintf(stderr,
+					"type needs to be realtime, monotonic or monotonic-raw; was given %s\n",
+					optarg);
+				return -1;
+			}
+			break;
+
 		case 'z':
 			flagtest = 1;
 			break;
@@ -566,6 +583,7 @@ int main(int argc, char *argv[])
 		}
 
 		soe->n_samples = getextended;
+		soe->clockid = ext_clockid;
 
 		if (ioctl(fd, PTP_SYS_OFFSET_EXTENDED, soe)) {
 			perror("PTP_SYS_OFFSET_EXTENDED");
@@ -574,12 +592,46 @@ int main(int argc, char *argv[])
 			       getextended);
 
 			for (i = 0; i < getextended; i++) {
-				printf("sample #%2d: system time before: %lld.%09u\n",
-				       i, soe->ts[i][0].sec, soe->ts[i][0].nsec);
+				switch (ext_clockid) {
+				case CLOCK_REALTIME:
+					printf("sample #%2d: real time before: %lld.%09u\n",
+					       i, soe->ts[i][0].sec,
+					       soe->ts[i][0].nsec);
+					break;
+				case CLOCK_MONOTONIC:
+					printf("sample #%2d: monotonic time before: %lld.%09u\n",
+					       i, soe->ts[i][0].sec,
+					       soe->ts[i][0].nsec);
+					break;
+				case CLOCK_MONOTONIC_RAW:
+					printf("sample #%2d: monotonic-raw time before: %lld.%09u\n",
+					       i, soe->ts[i][0].sec,
+					       soe->ts[i][0].nsec);
+					break;
+				default:
+					break;
+				}
 				printf("            phc time: %lld.%09u\n",
 				       soe->ts[i][1].sec, soe->ts[i][1].nsec);
-				printf("            system time after: %lld.%09u\n",
-				       soe->ts[i][2].sec, soe->ts[i][2].nsec);
+				switch (ext_clockid) {
+				case CLOCK_REALTIME:
+					printf("            real time after: %lld.%09u\n",
+					       soe->ts[i][2].sec,
+					       soe->ts[i][2].nsec);
+					break;
+				case CLOCK_MONOTONIC:
+					printf("            monotonic time after: %lld.%09u\n",
+					       soe->ts[i][2].sec,
+					       soe->ts[i][2].nsec);
+					break;
+				case CLOCK_MONOTONIC_RAW:
+					printf("            monotonic-raw time after: %lld.%09u\n",
+					       soe->ts[i][2].sec,
+					       soe->ts[i][2].nsec);
+					break;
+				default:
+					break;
+				}
 			}
 		}
 
-- 
2.46.1.824.gd892dcdcdd-goog


