Return-Path: <netdev+bounces-121097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76AD95BAD2
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0777E1C23296
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A311CCB3F;
	Thu, 22 Aug 2024 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VZGIeHUD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF3C1CCB36
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341488; cv=none; b=gkse2yZ2CcVAMpQfxLrx0R8/RXPIJnA42Q9ThQSUlwkhSu4urL5aHPsD657v5mpLVJgzqpq8rlReCmo0JsHf23CPNKB/4ANscYAinc7bkTxXIBPa2QaipPfSMPd6yhSkzlN1zhnZIdi4h0PX0Q4b//COmGFOz2AeJAR0b3/BXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341488; c=relaxed/simple;
	bh=gDDBCPpOC1eDlyXMtb+M28G43nhd2o9AYEneDllbejE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1lCCfiAnC+JCJKlf0B9CUYzCvDeiePu+jYvVWP/L0v9cbuu1PR0lls+iOHjnacxgLdd9nhEeOKTM9xtKJXz1VxWbHdvwShzEDEd6iHnrit8x/DRLTnqmbOo/Z3N19unpw0H/M93oLOSSthRRZYbizKIX1Tr+/qjtNq4RGb3lYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VZGIeHUD; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MDRHP9020678;
	Thu, 22 Aug 2024 08:44:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=Iyis40lxIGSxee/Qz5fQ/C2M2PF4yoS2KNmODSG/FUI=; b=
	VZGIeHUDbuIMWiGict+E/ufWSY5bjJpvAdLKeLyGRh/NkZcXZy9EHJRdDHRKiLve
	o8jJcz1Afl9NFGoJrmwxO74MYYvL2clhytULX6P/TQJ9Reev17km816xarBLbvH1
	0kjw0od2r7WYv8ZhEIv0E/Cz5VuLzHmHHjF7tSwgCX+zlOZdbxXn50FzmqOCEMNt
	OvPg3Ez2zEaepVOFdIVPI+73TNKuGVCi6cWoCVjPT63X42GxRrw/KVSxpo/FyfVe
	Ui4E01annvhviUQoRe+fewDul+uuzgZf8Pf/sZwBWBq7ADxtu3Hb1MQPxqxKWxvG
	+1dwmvodjmvozGp0niR4hA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 415rwvmuyh-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 22 Aug 2024 08:44:35 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 22 Aug 2024 15:44:34 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v5 2/2] docs: ABI: update OCP TimeCard sysfs entries
Date: Thu, 22 Aug 2024 08:44:22 -0700
Message-ID: <20240822154422.1703972-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240822154422.1703972-1-vadfed@meta.com>
References: <20240822154422.1703972-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kdSbid2nBPyS9jB0ogv9rb7PKrgeuj0O
X-Proofpoint-GUID: kdSbid2nBPyS9jB0ogv9rb7PKrgeuj0O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_09,2024-08-22_01,2024-05-17_01

Update documentation according to the changes in the driver.

New attributes group tty is exposed and ttyGNSS, ttyGNSS2, ttyMAC and
ttyNMEA are moved to this group. Also, these attributes are no more
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


