Return-Path: <netdev+bounces-240354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E2DC73BCF
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 688AF35F19B
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 11:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AAD3321AD;
	Thu, 20 Nov 2025 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LZXEFDPM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0AA3346B4;
	Thu, 20 Nov 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637838; cv=none; b=nptQ/8NzYmBJyQYlf772OX+dP8hqRROBEZrUhMWj1yNAfDKIT9ASJJR77JbcZiMZVYCXwm33pB70LlVrWezXc/6Uvx/UZ5R/z91AYRWEj8LixNkPLgogDX8y0nsMhxdocgLCaA3loMSHyNEw29+jhS1yiYT2gUkt8Cc9/b5Xj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637838; c=relaxed/simple;
	bh=YS5HREsKEC8OKWgvy4lwzpSQqtGcdz4fbfWwqDF0h9o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qRSauW2mp45b6OwrmagxuoFT78Nm7T9rVyNKf+Ug7QF0sXrlrjKJ9LNpoUa3Cuxxg586YttHmWWk15elqb9Gy5melI7Rb25oYchUsogQHCzo4BsEmVo6Wy3GQdz1DdTc+9l7UukG1hhOvaNFfyMw7+ddU7zGKYoVlASu+qJ9ALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LZXEFDPM; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJMVJ5q943860;
	Thu, 20 Nov 2025 03:23:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ik6eblAVmlx1PcsgcjrpnoN
	zjYB67zircpmsSsLh+t0=; b=LZXEFDPMN7YvpVmRs8SfVDSOMyjDA81OugXj9Ii
	I5teTD5eITa/Uk7WJcJxXOeiKIghZtI6RRROTEKbJnoOKq2jtPQfQibiUCHROMQr
	aV/QpN4aKxrVuVlOCufc6jEp9CPvbZBC5eFqetbn7+coqjXDb8CO25DO5hp2Zn1Z
	w7LsnrSSVIevFXHjodEhUkxaEoN+BFPsn6Hyat4zzbnWZT/Xd71focfcT78dVpSr
	gSdkNJqxtZfG/nUErVImUkld25GsGLsba4CqH5bQfhVzARpLqeMkw099//VFFY11
	Q0mPBOTVn9XoqOaUkAcm27hUGEl3efg1tRtweXWYRCE8riw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ag8fs7xnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 03:23:52 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 20 Nov 2025 03:24:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 20 Nov 2025 03:24:02 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 20A933F70D2;
	Thu, 20 Nov 2025 03:23:50 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>
Subject: [PATCH net-next v1 0/1] octeon_ep: reset firmware ready status
Date: Thu, 20 Nov 2025 11:23:43 +0000
Message-ID: <20251120112345.649021-1-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=D7ZK6/Rj c=1 sm=1 tr=0 ts=691efa48 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=8wXc3f0853CcbwX-YN4A:9
X-Proofpoint-ORIG-GUID: G0ud3GY9w68HQRQnD91R-O9ojgvHxkis
X-Proofpoint-GUID: G0ud3GY9w68HQRQnD91R-O9ojgvHxkis
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA3MSBTYWx0ZWRfX+MUsomdipcKN
 tVQIysM2xDdD64QN4nIIdRLeSksL86n3k6s4dsSpPzuT4QEwzQ//RRhF5jqHh5Qb+yFSMYxZyIV
 8qxI16bQ8ONcPOKNVP0avjPDKX1W0sIgbO8+rdwj5bm0UYbFCDgsJ0y23oBCz6E7AndZcAGONAK
 J34i3SioeZ1EC5gkFbnJmQpdJ/RzY3ODynnUWpKUV6nRenTMtOJSbUEH/0IId8nnVFtRNbealyW
 Bjl12nxPSYOQEtdaLNVcwY/gt5W8D3vubC/GkmJMT8OJr+fLEh53shg/MAs/9FBF8c0GN6lCAuQ
 1wal1DY1LlKkkGpoeK+Ouuf/wYoOOnAMJxQtdmmBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_04,2025-11-20_01,2025-10-01_01

Add support to reset firmware ready status
when the driver is removed(either in unload
or unbind)

Vimlesh Kumar (1):
  octeon_ep: reset firmware ready status

 .../marvell/octeon_ep/octep_cn9k_pf.c         | 22 +++++++++++++++++++
 .../marvell/octeon_ep/octep_cnxk_pf.c         |  2 +-
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h    | 11 ++++++++++
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h    |  1 +
 4 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.34.1


