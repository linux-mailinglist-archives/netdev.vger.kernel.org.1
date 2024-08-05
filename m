Return-Path: <netdev+bounces-115909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7037948542
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 00:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DA01F235CC
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A85416DECF;
	Mon,  5 Aug 2024 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IC3Ri1Q8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116214C5A1
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895529; cv=none; b=dY0sU0lxzjol2/VvrFT3mHJMcqJzc/z0q3ACzoq1tOHMF7IooYq2CYL2xVW2Nn81szj3ptSrzOdGG8nHHyl6PZKfHnEPHHrtZYafXb6tSJcv6i2CmR3nPooM+m7ERa9HDjlw2hnHXu1UPbFva6PpJVQkrr0+4Lk1lGLnjLOLRV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895529; c=relaxed/simple;
	bh=OutB4SmwTuXnpzwnAeVCeLrkDUKImL5Zn0dp+2n7REs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxhPECiA9FPs0tFPGo3eQXUc9TNGHEGtdOcHujjKSgRJwAiSVM72toUeBWHqZoRQ9Yf6M18QtLOhZjolVVzZJSgVnF4W5pp64EcwzR0y9gwC6kXXUk8FRmkk9CzaL+l7UHOaJiU+U+TfXJ11hD6Hjvz/fW+0UgyY9gjQ3F5TWro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IC3Ri1Q8; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475LvAQR014602;
	Mon, 5 Aug 2024 15:05:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=M7SecbCtkGqGmalNbhYVkl6y9qy5wCiRCj4gU1HdodI=; b=
	IC3Ri1Q8tyRBeVRILPORf4CsWTh5fsHzB9rKTGwmLtkqZiB3+itujXxmElRfnjG/
	tg2y4GS1lvPwkbdM1FCi0+dptnckrtZQ2bONAVxwvTLIojv7ae3wdi0Sx1if2Ra0
	IMaXdrX0SMAoMZX8JwPzaCeS9u34cGRksmK/Js3H/GVvARdqRjSGpbD5CZYU02wa
	n7x+Kg5oGVQDdUlbTJhg1HJhHnpYvSe0LN0wgvxNT0UnfyqILMfZmBic87GOC8UD
	CsEaz+o9QNC0y0KEPh3Z5mmgOEBP1bvTWJEMvig3E5nBlvoKg9gAyI4SEYLbjCT5
	/ArVqNByUWd0rvDqdAPcPQ==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40u3yys990-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 05 Aug 2024 15:05:12 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 5 Aug 2024 22:05:10 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v2 2/2] docs: ABI: update OCP TimeCard sysfs entries
Date: Mon, 5 Aug 2024 15:05:00 -0700
Message-ID: <20240805220500.1808797-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240805220500.1808797-1-vadfed@meta.com>
References: <20240805220500.1808797-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 04hNv_JNORObIoCoqy0TnFl4eE4cZgMn
X-Proofpoint-ORIG-GUID: 04hNv_JNORObIoCoqy0TnFl4eE4cZgMn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_10,2024-08-02_01,2024-05-17_01

Update documentation according to the changes in the driver.

New attributes group tty is exposed and ttyGNSS, ttyGNSS2, ttyMAC and
ttyNMEA are moved to this gruop. Also, these attributes are no more
links to the devices but rather simple text files containing names of
tty devices.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 Documentation/ABI/testing/sysfs-timecard | 31 ++++++++++++++----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index 220478156297..3ae41b7634ac 100644
--- a/Documentation/ABI/testing/sysfs-timecard
+++ b/Documentation/ABI/testing/sysfs-timecard
@@ -258,24 +258,29 @@ Description:	(RW) When retrieving the PHC with the PTP SYS_OFFSET_EXTENDED
 		the estimated point where the FPGA latches the PHC time.  This
 		value may be changed by writing an unsigned integer.
 
-What:		/sys/class/timecard/ocpN/ttyGNSS
-What:		/sys/class/timecard/ocpN/ttyGNSS2
-Date:		September 2021
+What:		/sys/class/timecard/ocpN/tty
+Date:		August 2024
+Contact:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
+Description:	(RO) Directory containing the sysfs nodes for TTY attributes
+
+What:		/sys/class/timecard/ocpN/tty/ttyGNSS
+What:		/sys/class/timecard/ocpN/tty/ttyGNSS2
+Date:		August 2024
 Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
-Description:	These optional attributes link to the TTY serial ports
-		associated with the GNSS devices.
+Description:	(RO) These optional attributes contain names of the TTY serial
+		ports associated with the GNSS devices.
 
-What:		/sys/class/timecard/ocpN/ttyMAC
-Date:		September 2021
+What:		/sys/class/timecard/ocpN/tty/ttyMAC
+Date:		August 2024
 Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
-Description:	This optional attribute links to the TTY serial port
-		associated with the Miniature Atomic Clock.
+Description:	(RO) This optional attribute contains name of the TTY serial
+		port associated with the Miniature Atomic Clock.
 
-What:		/sys/class/timecard/ocpN/ttyNMEA
-Date:		September 2021
+What:		/sys/class/timecard/ocpN/tty/ttyNMEA
+Date:		August 2024
 Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
-Description:	This optional attribute links to the TTY serial port
-		which outputs the PHC time in NMEA ZDA format.
+Description:	(RO) This optional attribute contains name of the TTY serial
+		port which outputs the PHC time in NMEA ZDA format.
 
 What:		/sys/class/timecard/ocpN/utc_tai_offset
 Date:		September 2021
-- 
2.43.5


