Return-Path: <netdev+bounces-199489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 879C5AE0804
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFFB1882D8F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B9322CBC0;
	Thu, 19 Jun 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNIp8jlS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76EB229B1A
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341287; cv=none; b=YGlGyqhqRRh1utu3G8Br/EIqItBaVMWX1PBRFFthQ5p5t2AXl1BxvgWPHYDqtKV3uN2dDdPI4rrNB/+uRmFtnLzAtqS7kPn72vEjqudWgvJSfXQ4StcgOKEPdwK3f42mQzHaqoxPlZizbEb62oeNzlrCS2Eu4CZatu4pnxz/HJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341287; c=relaxed/simple;
	bh=uv58hnw/sVYfFwx1h1aG2ibXiOn0AKn+uIN/pxIXy8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NwjYVB1etP+2SZbl26hBTTm58GtVGduJBR6tCHD/O5DZkCKfLaOiEbRCfEXk8QnRWtVJ1uIf4ruNDlvALPGEfh1jqZiMNnouM61caPabs4SztUSq76dkWuvQ0dDUD7mQdL0NuGzJLuV6cZNnrmtq1zv/HG8vFmbpN12gcsCkZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNIp8jlS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750341284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8k7DNcFMCpr4QRW1f07I76U1qlk4vYR8dGQgh7DX67c=;
	b=cNIp8jlSNvRaJ5n6RQqoPhgsTTN6HPuR8Wc7lKZHLHbqJ0MIJJ2mDGOQuIhAZFjMOBTAB8
	qK/PgyN2bYYFekaUcU1Y2Bec7xJy/pTMqDFyxkLhIL6/gpP1DLqmSNdXgEFFX+G6YMkdoH
	/TZThRWmk+2pdiOnecU8i6yED4pOuL0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-yLpzJY5qP3y9_yotxRBTUw-1; Thu,
 19 Jun 2025 09:54:40 -0400
X-MC-Unique: yLpzJY5qP3y9_yotxRBTUw-1
X-Mimecast-MFC-AGG-ID: yLpzJY5qP3y9_yotxRBTUw_1750341279
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62062180047F;
	Thu, 19 Jun 2025 13:54:39 +0000 (UTC)
Received: from queeg.. (unknown [10.43.135.229])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02F2419560A3;
	Thu, 19 Jun 2025 13:54:37 +0000 (UTC)
From: Miroslav Lichvar <mlichvar@redhat.com>
To: netdev@vger.kernel.org
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next] testptp: add option to enable external timestamping edges
Date: Thu, 19 Jun 2025 15:53:42 +0200
Message-ID: <20250619135436.1249494-1-mlichvar@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Some drivers (e.g. ice) don't enable any edges by default when external
timestamping is requested by the PTP_EXTTS_REQUEST ioctl, which makes
testptp -e unusable for testing hardware supported by these drivers.

Add -E option to specify if the rising, falling, or both edges should
be enabled by the ioctl.

Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
---
 tools/testing/selftests/ptp/testptp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index edc08a4433fd..ed1e2886ba3c 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -120,6 +120,7 @@ static void usage(char *progname)
 		" -c         query the ptp clock's capabilities\n"
 		" -d name    device to open\n"
 		" -e val     read 'val' external time stamp events\n"
+		" -E val     enable rising (1), falling (2), or both (3) edges\n"
 		" -f val     adjust the ptp clock frequency by 'val' ppb\n"
 		" -F chan    Enable single channel mask and keep device open for debugfs verification.\n"
 		" -g         get the ptp clock time\n"
@@ -178,6 +179,7 @@ int main(int argc, char *argv[])
 	int adjphase = 0;
 	int capabilities = 0;
 	int extts = 0;
+	int edge = 0;
 	int flagtest = 0;
 	int gettime = 0;
 	int index = 0;
@@ -202,7 +204,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xy:z"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:E:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xy:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -213,6 +215,11 @@ int main(int argc, char *argv[])
 		case 'e':
 			extts = atoi(optarg);
 			break;
+		case 'E':
+			edge = atoi(optarg);
+			edge = (edge & 1 ? PTP_RISING_EDGE : 0) |
+				(edge & 2 ? PTP_FALLING_EDGE : 0);
+			break;
 		case 'f':
 			adjfreq = atoi(optarg);
 			break;
@@ -444,7 +451,7 @@ int main(int argc, char *argv[])
 		if (!readonly) {
 			memset(&extts_request, 0, sizeof(extts_request));
 			extts_request.index = index;
-			extts_request.flags = PTP_ENABLE_FEATURE;
+			extts_request.flags = PTP_ENABLE_FEATURE | edge;
 			if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
 				perror("PTP_EXTTS_REQUEST");
 				extts = 0;
-- 
2.49.0


