Return-Path: <netdev+bounces-252783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHCNCOZRc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:48:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEA1748FD
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67A623008627
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E43309DCB;
	Fri, 23 Jan 2026 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BqEUIBfQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D53C2DE711;
	Fri, 23 Jan 2026 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165281; cv=none; b=GJPIwIlLONJNxYNPahtBYOaTP6/UL3Dk+Cs+nSMGL2nTbhZCnp3YAiwCY4lGR7vxYhKUb/6D94LdGMTAh6S7irgiAGFW0hrtUfmaJhAuKcn1LMMO8m034Huxd44Trol3s8b/RHvXtAWEaF+1HP9czKcdsqL+DNll4unhsicZpDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165281; c=relaxed/simple;
	bh=VuCbbT2xk7dTc5ffPUZcubuxjoKkLoMCLsgt9W8rbTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CvBKO75e7EqdCHCcDVfIb70UNT37+3htSP5sEG9hFjd/AYjFcyrbS9+/soygj0nOZexIboQV8B7mlh03bFyUDtaokOMDTGCkfLKBMk+S/2l//CzpkDRxuvywhRVQlEFH6SUKl6drMZnfSaNhuuejuEiBZ0oHwUzaKwSgzqCnvJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BqEUIBfQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N9Chsd633099;
	Fri, 23 Jan 2026 02:47:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=uBhbbYKkl8R7lD7U35Naqhj
	zf+zsqgR836urkk92zOg=; b=BqEUIBfQY3TLSBCcFro3t+7bDitgUB0UPhTV45b
	mZRZz+LsAvJoveD5+oacO0aVUBxIxVk0zV6oGOJXybMk2vh4Mquh6GR59EkM2t9w
	P10r+Fg48wEpEFrnYT7zR0i7CjFPG95FFpiQlAfLyaCLieLBkm2vS9cxCtWorPaw
	1SKIqFB6vQ+MPmr/5+97a1qMNNWhwBdIcLx+i5cjKCOhha2rjVsRjtH3nNt2KLan
	b/MGIqXN2tZ5rEQ1Gqjjz/ArToTYALmS6ZZKPsR66VBvcmI9DjRRNH3s4oseFlA8
	cM6QDWzuIdH/VqIk76iQBFPWEctfW1+ZxI4igS1QM6/grTg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bv65504e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 02:47:37 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 Jan 2026 02:47:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 23 Jan 2026 02:47:36 -0800
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 987AD5B6964;
	Fri, 23 Jan 2026 02:47:32 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next PatchV4 0/2] Octeontx2-pf: Add support for DMAC_FILTER trap
Date: Fri, 23 Jan 2026 16:17:29 +0530
Message-ID: <20260123104731.2710019-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA4NyBTYWx0ZWRfX/jToeZbs9/jM
 N15zwWQPszheO+4hz8UqiLcG9XMEwXcxZAm/A1C8Ke8Ypk6CE2O27NuW8lQHjAgaFFta984nwjk
 fMHxAwxz5bb3DUQXzNM6gBLpHTjQLyuL9JXLdcRg8W3YAeV5bP8QUC3+7/bjd+C3V0G5/7d7olA
 CqWv5ul+jBWzaqmOxnJXzgSVUBzY1u0KbulTAFGeSyUbmR7Ta68YGqVgas/z/g4xlEpYD+kp7F9
 A0OUtj2htYtOTWS/VN6/+2gMww7qvB9IGMdzG8EnTMawiR5iOIObkt8U8vwKDsfAkS60HLKYQdi
 5jQpWOAXJeEzbcVDfLaCtN5ziOnVyMYeG9p24dSqwK7ZBLUz+pvZbXw7VgoCtUhqVW3daw/CiPb
 7qbIiBm8199xxkl6/zkp+3UEWW9vC8azFq2PkPdV9AHsKPYb5buCHByOnX1LJtIRVlZhEvYw0T3
 pQcWut5s6CFbD5FmHwA==
X-Authority-Analysis: v=2.4 cv=EJILElZC c=1 sm=1 tr=0 ts=697351c9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yfvZBKtj2kfplXi_T7QA:9
X-Proofpoint-GUID: og_fLU_UeB2EZTuOmJOHsTj0FUwIvrsx
X-Proofpoint-ORIG-GUID: og_fLU_UeB2EZTuOmJOHsTj0FUwIvrsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_01,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hkelam@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252783-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:mid,marvell.com:dkim];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2BEA1748FD
X-Rspamd-Action: no action

Octeontx2/CN10K silicon MAC blocks CGX/RPM supports DMAC filters.
These patches add devlink trap support for this functionality.

Patch 1: Introduces mailbox handlers to retrieve the DMAC filter 
         drop counter.
 
Patch 2: Adds driver callbacks to support devlink traps.

Hariprasad Kelam (2):
  octeontx2-af: Mailbox handlers to fetch DMAC filter drop counter
  Octeontx2-pf: Add support for DMAC_FILTER trap
----
V4 * Address AI review comments 

V3 * Address review comments suggested by Claude Code

V2 * fix warnings reported by kernel test robot

 .../net/ethernet/marvell/octeontx2/af/cgx.c   |  11 ++
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |   2 +
 .../marvell/octeontx2/af/lmac_common.h        |   1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   7 +
 .../net/ethernet/marvell/octeontx2/af/rpm.c   |  18 +-
 .../net/ethernet/marvell/octeontx2/af/rpm.h   |   2 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  23 +++
 .../marvell/octeontx2/nic/otx2_devlink.c      | 167 ++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_devlink.h      |  23 ++-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   7 +
 10 files changed, 259 insertions(+), 2 deletions(-)

-- 
2.34.1


