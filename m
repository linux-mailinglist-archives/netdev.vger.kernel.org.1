Return-Path: <netdev+bounces-118839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4787F952EA0
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3DD1F22103
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83D219DFB9;
	Thu, 15 Aug 2024 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GmfWc+iD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF58719DF70
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726768; cv=none; b=MKl59bVV/rmCjd2ARvJmDktpaTq5ZGB/CvgsZy8kl+YjK5AkipSp7D85frZPuy53tN/+HY5sy7WM85bfBnrQgYOuBQrc3qs16OC7z4B+nljAdxFTx4+Ip7z03WjuvVaejSfFUcZ9nQkj9S8faal5lqNwzcqzWaWbiQ5Vd+eo0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726768; c=relaxed/simple;
	bh=gDDBCPpOC1eDlyXMtb+M28G43nhd2o9AYEneDllbejE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9fXZZJ3Bus/8ZSfLQ9fIMFN+7WLAWDO/3kzjWhdN4pl0TwgtgHYpI+OVSwGg61LSHdE2TIXxMJfiOlTG/0WJ69SrGI7FCTjqMx4WrsDxTI2u+3geDyum69lfuiRWSz1F2nI0ooi7VhfBNSHy1NE6GALOdo/rDwOghTbl9WiTCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GmfWc+iD; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FC1a8i007134;
	Thu, 15 Aug 2024 05:59:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=Iyis40lxIGSxee/Qz5fQ/C2M2PF4yoS2KNmODSG/FUI=; b=
	GmfWc+iDUFi7oEAaFzxDVJxSV4zTq98jOcDkPXzrMrdfZ/6yfqtiDTJio7Cp6dNH
	pCYJBtAiVAnOWewAHuz8sjjMXdX3JG4dCVHFOuamic3BlkZbsJ9JiZI5jkelWFFF
	IX2M5IxeEoatxoNIOZ9XzJl2Ow3Qrk0XG0okLcXCm+bJKpTTJNL0SO+cb05UaAG/
	NPSFclhTsWyXCrGi78NCjLKrOkrbqfZq3qwCIRMKyAefjKLhTh0GfXgJQD1jFmEB
	s/J+1WMkL2/FtljlEb1KHKcEAc22IDaDRGmLrBR2L8NT9WQgp05ZKfT1/lqMqrqQ
	3JJtqcs5e3DCffMvkyz7iQ==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 410u2c7ang-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Aug 2024 05:59:19 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 15 Aug 2024 12:59:17 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v3 2/2] docs: ABI: update OCP TimeCard sysfs entries
Date: Thu, 15 Aug 2024 05:59:05 -0700
Message-ID: <20240815125905.1667148-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240815125905.1667148-1-vadfed@meta.com>
References: <20240815125905.1667148-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rwzXn3wpAYjnQTi49rd0DkRTvHIsHELJ
X-Proofpoint-ORIG-GUID: rwzXn3wpAYjnQTi49rd0DkRTvHIsHELJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_03,2024-08-15_01,2024-05-17_01

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


