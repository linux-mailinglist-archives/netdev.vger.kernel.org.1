Return-Path: <netdev+bounces-123442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21FB964DC5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3542AB20C04
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7AC1B8EBA;
	Thu, 29 Aug 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="U42EkSum"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED101B8E9E
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956599; cv=none; b=rTNGs28l1VJ/Mw6peuYzxM4ywZKv4MXU/rqbPS7BUobArLtkMO4IrzYQXx7jSmE1OqWELqIsJ8T3iVxQYA+T6bwd+lsPYdeZgi0W05QabLz6mmiVlKQLu0V08A3OYUjMbdvUD/Rea9aH2SKfRAAMgYC3QlkgGaD44PYS4Ze/Ej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956599; c=relaxed/simple;
	bh=gDDBCPpOC1eDlyXMtb+M28G43nhd2o9AYEneDllbejE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3Cxk4u85RT183vcrsYI/DxConKAmbonzwQUnx+Tn9V4fb9mvAWyykaWaz1dNdo0dtqHutfK4XqnFxmzXguwVJqdXQYBnLKdKjw0Z/zJrLx3Y9QuSacj/DdTxlMvQ0Nq0EjaYx1/bwM/iT1g7r2Tl6d9M33uimaiB3RMOstBa/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=U42EkSum; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 47TIY3Iu012390;
	Thu, 29 Aug 2024 11:36:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=Iyis40lxIGSxee/Qz5fQ/C2M2PF4yoS2KNmODSG/FUI=; b=
	U42EkSumWcspiT2MVRkO5qL8Yohpd/XSVhK6PxKAhPXguKlafUzGSPB+omq22riz
	LsJGMLgqE++7jOylh8YyNqJRGtzjXH5djNvqctzmWK/Lp+iCk0ODhNIBmTumUqJv
	t+dAFbm1dDLNuS+JJsZApmzEY0mcC5aqTl/2foRONSqU63eOheJaWHrSDZYpTg5q
	c38/pWEZTUIYs0+pOiaEcJqE92Bf+ARCgVixw5qqoOIfZqxCJ0Khy2OYoDTpDeJy
	XCwkf30NbiErD5uX9jn+5ifkFYzCMrBEFRKTgpalMTp8D0f6K/cfYbLvWILrpec1
	YZeAohGw83SSoScl2qjMqQ==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41axcg00kb-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 29 Aug 2024 11:36:26 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 29 Aug 2024 18:36:16 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v7 3/3] docs: ABI: update OCP TimeCard sysfs entries
Date: Thu, 29 Aug 2024 11:36:03 -0700
Message-ID: <20240829183603.1156671-4-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829183603.1156671-1-vadfed@meta.com>
References: <20240829183603.1156671-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YWdYiH3kxfK1Aw9mXGN45YguR1PxDRL-
X-Proofpoint-ORIG-GUID: YWdYiH3kxfK1Aw9mXGN45YguR1PxDRL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01

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


