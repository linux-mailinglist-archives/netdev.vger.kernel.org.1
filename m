Return-Path: <netdev+bounces-120253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3CC958AEB
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A8C280C18
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61461922F3;
	Tue, 20 Aug 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cM+zwO5V"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168E1922D3
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167005; cv=none; b=OIdEepN2z5quTZuGy7InTtdFGdjXceZOYLp2+lV5mlh2kZHCrIRhYrGuBTx0Gk8Q6ipSaIZ/m2/FY4D2eHKyVxXt4EG3oxQE0Nrubc11Wph0gSxAAHDard83XdzVAfz0uFBu5A1bJ6xTd/UUHVn7nIshYxoTF09EWlMLNSO4I7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167005; c=relaxed/simple;
	bh=gDDBCPpOC1eDlyXMtb+M28G43nhd2o9AYEneDllbejE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m60nMeMfFt959y7qhrqomqkR0ma6VG4xi4a66E4AVwyqF8xXzhXdpyuatU3Ehiy9Hek0KgXJMEe1P21OSuVPE9vOpLtOkFf95olBXgN54KFfcCD7GqyI5jQ0aqfiHipoPmehwjrzF07r9G0o8jP+BuCQu/llIxyR24ZIC2iXdTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cM+zwO5V; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K2i1OV007049;
	Tue, 20 Aug 2024 08:16:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=Iyis40lxIGSxee/Qz5fQ/C2M2PF4yoS2KNmODSG/FUI=; b=
	cM+zwO5V5HbhyFXFjE1JGyh3ek7B/XAXhnGAnFjZ1xErcWg9tC/sTD/vye8SawzY
	3jJS8FHZm52IJ3njM5XrZ12+hvNPBoUZWzQRxBrbdXd++yecqGAVh06RTsl30LEu
	Gh6qXqbnfp9RrGNXdWKuAqyZ2lVghatjCX+pMv4T8Dnu/TDhLGa1SVoErNu04bMc
	L02lcz9TWnBcH8clASsBDAxvk+2A0eSzSFmfcMUzxjf4g6sRRSNrn+1Aeleu6dgP
	CCciLUQKD3fcz1dklDh4pyyY2k0cYG5CcXYmN+hJQYi2k0P1lbotZgQMga5rwVCS
	SSz9k2SLrF8K7YcrjX093A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 414jkkb4dh-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Aug 2024 08:16:29 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Tue, 20 Aug 2024 15:16:26 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v4 2/2] docs: ABI: update OCP TimeCard sysfs entries
Date: Tue, 20 Aug 2024 08:16:17 -0700
Message-ID: <20240820151617.3835870-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240820151617.3835870-1-vadfed@meta.com>
References: <20240820151617.3835870-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6EUsdCTz1MRz0Fbh_vDHop75qlPyAFtd
X-Proofpoint-GUID: 6EUsdCTz1MRz0Fbh_vDHop75qlPyAFtd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_11,2024-08-19_03,2024-05-17_01

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


