Return-Path: <netdev+bounces-118033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13559505B1
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38311C20D71
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8018119ADA3;
	Tue, 13 Aug 2024 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="pmj3izJ7"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8819AD8D
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553787; cv=pass; b=QdjUmK6HB0rS3ymtYbSlLP7nkrhhSMjDwXUqZIG/H1uY7M/bkaT6YrFyHpXhpuXUa19va5U1sEQoFOGfOuamWO4qCZ+cXeu0GduzjSCkiJy18vfkFZSmUorF9azefc8sAyn2d/KiJesBs6nf12PZJCyT41DFFus5WVAzCsi/XaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553787; c=relaxed/simple;
	bh=dRKKVpf7HNPCUgSlJykr6sV1dSg68HuKwGhQyF/66tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RngAadTwCnV2eAOXTLSlCEYY/om4NJb2HIscBHDF0V7foWBWGLSc1h7jJ/kn6eptSWCLCDfUQKchxz5D27Ht/lFiZXkICkdqkxloIzw+7bOhz0fRTh0P3WnaIlFmH5yyJI3gRr5oVi/i5Kn/2PzDOhQ702UaMVoWYF1OCyK8tLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=pmj3izJ7; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Delivered-To: maciek@machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723553777; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NhSn3oVXwo3IUXMhGk7Tw+xDSKnItdyeRn1ZRnNdKOxdplZ1P0kMvov8CxGm50zt5rI6A8nJTC2RoRJLlSnkTb6j7TCnFHNyQuIq7x3zzXYF9nkbxRYt7Oqf3C6+oZZsKtiPnmewcPlMzDKGN3VNzRQyLUCbOE1cy/HorwiJchs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723553777; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5KzrrdkmMb5M8nz9an5gcqE+De9mYbddjo+yWqmV+7w=; 
	b=dTfRRCJdtMiE1NenJxtmiEHoGUugWjro/rUImZCllJCzjY7x4Q4x+nYnn3KS5K5DtdUdG1VsJ/1m6jXQRWpsXmxs2lCkm7ppVk9yMe+9lWfYc2S25tAY8hkC08BZAJDk34wfLPlwQQEzjaRmwsteoqCzcdB37rWI759vL7cuJAk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723553777;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=5KzrrdkmMb5M8nz9an5gcqE+De9mYbddjo+yWqmV+7w=;
	b=pmj3izJ77kBfH68tbG94UL16akNz6BV2h07xdpJr/wbowncGFFv2uGC8bTif1IjR
	0dQSOMJTVPSOqmtaBlRnO52EeWDv9QHnwb+fITagDtFCFcPwP7vK+VOrQknaRa8+Uq+
	8r71h4aNXZqYwZD/uXX2vXJrY8wba3ay/3dwLG2XgNevo6GHYABFn2DpY8kyeHaynja
	suypLKagEuAqFBW2PtXgSe5jjAaFJeoATpYuAWhm0Fuuow3DvtF3NbNx3Lva3+fJ6u3
	E1h/3gPSpW3tGOox/JMciFpISXOvTwegUDcCFRa+c7pL2+ikxMytaBVoMOZVjqmrV8K
	olMYFGMQUQ==
Received: by mx.zohomail.com with SMTPS id 17235537763111005.0319638378652;
	Tue, 13 Aug 2024 05:56:16 -0700 (PDT)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: maciek@machnikowski.net
Cc: netdev@vger.kernel.org,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	vadfed@meta.com,
	darinzon@amazon.com,
	kuba@kernel.org
Subject: [RFC 3/3] ptp: Add setting esterror and reading timex structure
Date: Tue, 13 Aug 2024 12:56:02 +0000
Message-Id: <20240813125602.155827-4-maciek@machnikowski.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813125602.155827-1-maciek@machnikowski.net>
References: <20240813125602.155827-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Implement setting the esterror using clock_adjtime for ptp clocks
and reading the clock setting using timex structure and
clock_adjtime

Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 tools/testing/selftests/ptp/testptp.c | 39 +++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 011252fe238c..38405803b881 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -117,6 +117,7 @@ static void usage(char *progname)
 {
 	fprintf(stderr,
 		"usage: %s [options]\n"
+		" -a val     adjust the estimated error by 'val' ns\n"
 		" -c         query the ptp clock's capabilities\n"
 		" -d name    device to open\n"
 		" -e val     read 'val' external time stamp events\n"
@@ -140,6 +141,7 @@ static void usage(char *progname)
 		" -H val     set output phase to 'val' nanoseconds (requires -p)\n"
 		" -w val     set output pulse width to 'val' nanoseconds (requires -p)\n"
 		" -P val     enable or disable (val=1|0) the system clock PPS\n"
+		" -r         read clock info in the  timex structure using clock_adjtime\n"
 		" -s         set the ptp clock time from the system time\n"
 		" -S         set the system time from the ptp clock time\n"
 		" -t val     shift the ptp clock time by 'val' seconds\n"
@@ -175,12 +177,14 @@ int main(int argc, char *argv[])
 	int adjns = 0;
 	int adjphase = 0;
 	int capabilities = 0;
+	long esterror = 0;
 	int extts = 0;
 	int flagtest = 0;
 	int gettime = 0;
 	int index = 0;
 	int list_pins = 0;
 	int pct_offset = 0;
+	int readclk = 0;
 	int getextended = 0;
 	int getcross = 0;
 	int n_samples = 0;
@@ -198,8 +202,11 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
+	while (EOF != (c = getopt(argc, argv, "a:cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xz"))) {
 		switch (c) {
+		case 'a':
+			esterror = atoi(optarg);
+			break;
 		case 'c':
 			capabilities = 1;
 			break;
@@ -250,6 +257,9 @@ int main(int argc, char *argv[])
 		case 'P':
 			pps = atoi(optarg);
 			break;
+		case 'r':
+			readclk = 1;
+			break;
 		case 's':
 			settime = 1;
 			break;
@@ -290,7 +300,6 @@ int main(int argc, char *argv[])
 			return -1;
 		}
 	}
-
 	fd = open(device, O_RDWR);
 	if (fd < 0) {
 		fprintf(stderr, "opening %s: %s\n", device, strerror(errno));
@@ -621,6 +630,32 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (esterror) {
+		memset(&tx, 0, sizeof(tx));
+		tx.modes = ADJ_ESTERROR;
+		tx.esterror = esterror;
+		if (clock_adjtime(clkid, &tx))
+			perror("clock_adjtime");
+		else
+			puts("esterror adjustment okay");
+	}
+
+	if (readclk) {
+		struct timex clk_info = {0};
+
+		memset(&tx, 0, sizeof(tx));
+		if (clock_adjtime(clkid, &tx)) {
+			perror("clock_adjtime");
+		} else {
+			printf("clock_adjtime:\n"
+			       "\tstatus %d,\n"
+			       "\toffset %ld,\n"
+			       "\tfreq %ld,\n"
+			       "\testerror %ld\n",
+			       tx.status, tx.offset, tx.freq, tx.esterror);
+		}
+	}
+
 	close(fd);
 	return 0;
 }
-- 
2.34.1


