Return-Path: <netdev+bounces-136402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40A19A1A79
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8428728265D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 06:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535A4179954;
	Thu, 17 Oct 2024 06:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="btqf/5VV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773C1779AE;
	Thu, 17 Oct 2024 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145290; cv=none; b=ONGn57FQbvOhCXAF0fXimckcKEVTjVgmegeqXJxBnSSIofu8YCGJHUlKvt5XByNmSS2WkUW5/SrRKbVph7Z1qtLuuFpx04gKfAA0+KRprwzUFOtsMGGsSEb3GSapQNCGNp7xMHabCetM6jToueuqhZQh2YMYZtx0ck9kB6/Z11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145290; c=relaxed/simple;
	bh=rAuyPr2cU6+++tAkhBZnCcAnNxu7b2cgu47Ggioiw44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnvPkH49tTgvuSIzepqKnCVtCpU3CjtVVsgdT1LHchcj/KhL7Er1rba0sbzeIioAI9Va+j/CwXOz2rm6/vZzpF5XkqAOnMzE70jAGlkZ9tW0oOo68v5xRNsR2A2zlmfwpa9BTpcsiIA48YHPIMpwHs3CJ3fGPofI+wZjBifYGPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=btqf/5VV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H0OpYc008752;
	Thu, 17 Oct 2024 06:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RknAiKzQML312t9LVvS8jFmWO33Sb6NWhE5vNMHCU
	A8=; b=btqf/5VVLvbLuxhsqog2nRy24P5JOyRzV+H0NqaUN3eWaOzX1FwttIcOQ
	IZYk3QpqXLyoYv+1ZWcSttOy3/CULMkglGUH6nB3hu73xmqUwAsmjuo4SRsWUfoK
	fcdBQMCwva8Ktz2Kb9dc4qh9X/Oo6cHbQLPZ3S+zJI76Xsr1OWp9eGCKVLCepcnk
	HrhJIEMXXKsvkA8DlMTr3IHajFPfyYFSv2vg0VC2bxtORgSL1booOvIV6Rvg2wUZ
	Lpbe30xPdwoyyayaFu/HxUhLlwdGHQACjHVowze1hmHkRwSqN2B+k6vid2g+Iwnd
	G3rhjnGjvfHBu8JjJbPQ2AhFzcZ2Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ar0u11cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 06:08:03 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49H683k3013342;
	Thu, 17 Oct 2024 06:08:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ar0u11cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 06:08:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49H2xafa005936;
	Thu, 17 Oct 2024 06:08:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4286514tgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 06:08:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49H67wLr54919672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 06:07:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE3F22004E;
	Thu, 17 Oct 2024 06:07:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAAD420043;
	Thu, 17 Oct 2024 06:07:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Oct 2024 06:07:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 2B1EAE0251; Thu, 17 Oct 2024 08:07:58 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v3 0/2] PtP driver for s390 clocks
Date: Thu, 17 Oct 2024 08:07:47 +0200
Message-ID: <20241017060749.3893793-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rBi5OCQLHra0s6Wu3IqKcrNheLtXmOq3
X-Proofpoint-ORIG-GUID: tNK7h9Hpn46k0pyqqQUx1nhRTBugv2F0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=953 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170039

Hi,

these patches add support for using the s390 physical and TOD clock as ptp
clock. To do so, the first patch adds a clock id to the s390 TOD clock,
while the second patch adds the PtP driver itself.

Changes in v3:
- drop 'IBM' from clock names
- use u128 as return type of eitod_to_ns()
- fix calculation in eitod_to_timespec64()

Changes in v2:
- add missing MODULE_DESCRIPTION()
- drop udev event patch
- simplify eitod_to_ns()
- use store_tod_clock_ext() instead of store_tod_clock_ext_cc()
- move stp_enabled() declaration to stp.h
- use s390 instead of 'Z' in clock names
- defconfig symbol should be default-n

Sven Schnelle (2):
  s390/time: Add clocksource id to TOD clock
  s390/time: Add PtP driver

 MAINTAINERS                     |   6 ++
 arch/s390/include/asm/stp.h     |   1 +
 arch/s390/include/asm/timex.h   |   6 ++
 arch/s390/kernel/time.c         |   7 ++
 drivers/ptp/Kconfig             |  11 +++
 drivers/ptp/Makefile            |   1 +
 drivers/ptp/ptp_s390.c          | 129 ++++++++++++++++++++++++++++++++
 include/linux/clocksource_ids.h |   1 +
 8 files changed, 162 insertions(+)
 create mode 100644 drivers/ptp/ptp_s390.c

-- 
2.43.0


