Return-Path: <netdev+bounces-148359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9761E9E13E3
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F825B21B18
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB6C19A297;
	Tue,  3 Dec 2024 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="G1o/iCQ1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80E18FC80;
	Tue,  3 Dec 2024 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210517; cv=none; b=c9lW2vWOBfea1uLSuHSrztzoI3Cis0ZuVgyEmKxuSEMfoFzoVGLrfZT9b/g3Gw8M+fjpUWhHjly4uMH04RSrljvlYYaF9Fz3ccBYYz9BRgxUDlfg2bSj8yJHCNoyy4jbpaeLAeubtHGSm+7xkqbmgXUGsf0z9CLydacLatbgnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210517; c=relaxed/simple;
	bh=D97lafiK1Dz1T1qMxnfrOPti0xqJ0khVEoxdGNjSRaY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LZqgFqpcnVZ2p+4YKP+7ytag4CcxSz5LzZeQ/aFrmOpKu5cP6FrckRZAi7J8QWs7PflwlnSbXgKpwo2kIfGrvoP62NT0+OYE6UX13rCdomfk3WMpfZuyrzTyGNDAaHgHRXosoFgrp4vKeCpxDqNli4yWeQaOg7IIAvDe54CH4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=G1o/iCQ1; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2JPtbi011753;
	Mon, 2 Dec 2024 23:21:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Njk/5UtOnXKpvjX/ojP8Ziw
	q2YByuT5IwXVGUEvz2RQ=; b=G1o/iCQ1ef9Y1I7vIzb1Fu0edLWwvwAqeS1u3fy
	fYYnghsP4Nm7N2F98aSYQ7i/UdEhgFVM/0oUK3HHCgPNqizjlovW5/ReRIDumwCV
	dca2nhVv7vma6fPrz5TBOeaGSrKZZJVLs9dmlfrGHqHC5mI5SCMj+0mjkdBIwwjP
	+WoUTi+9Aaf93QhKOvI/KtHjBPGcbqPrGhjNKuJuXEgWiZUWUBDAZiNmD6drE26D
	lF7XfUWUMhVIIoh9HnShqGGwyQ5q4fDkzrz/AbXuI6lsiomdqbBAWv0ugQjQ0Arg
	aa0x4sWq0n4wd6FeTMELe8XCeQhdFwrWfDxST8+qwerFccA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 439b8qa76r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 23:21:33 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 2 Dec 2024 23:21:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 2 Dec 2024 23:21:32 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 322505B6952;
	Mon,  2 Dec 2024 23:21:32 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <einstein.xue@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>
Subject: [PATCH net v1 0/4] Fix race conditions in ndo_get_stats64
Date: Mon, 2 Dec 2024 23:21:26 -0800
Message-ID: <20241203072130.2316913-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3vvjNPXkHXzmUTXfuSUp6mzZ7xN5_RyK
X-Proofpoint-GUID: 3vvjNPXkHXzmUTXfuSUp6mzZ7xN5_RyK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Fix race conditions in ndo_get_stats64 by implementing a state variable
check, and remove unnecessary firmware stats fetch which is currently
unnecessary

Shinas Rasheed (4):
  octeon_ep: fix race conditions in ndo_get_stats64
  octeon_ep: remove firmware stats fetch in ndo_get_stats64
  octeon_ep_vf: fix race conditions in ndo_get_stats64
  octeon_ep_vf: remove firmware stats fetch in ndo_get_stats64

 .../ethernet/marvell/octeon_ep/octep_main.c   | 34 ++++++++++++-----
 .../ethernet/marvell/octeon_ep/octep_main.h   |  8 ++++
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 37 +++++++++++++++----
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  9 +++++
 4 files changed, 71 insertions(+), 17 deletions(-)

-- 
2.25.1


