Return-Path: <netdev+bounces-201006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E96DAE7CEC
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279D93AC5DA
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE80F2DCC07;
	Wed, 25 Jun 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Czhzmarc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F349273F9;
	Wed, 25 Jun 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843368; cv=none; b=qoMjWB2F4dLEumuWe/OkeO3JXz9pNRiS7vwC5EYnClb5r/7QUMy5fJFlb5T/me06qYFLatJzqEuUkRiYa6UZS7oU1zbfN4jtfKVeY5yA1VixeCjuynlEA8njUL2MOt0by6wDWpDPa42YS9XM3AdiewcIK6gbU9SnKkhd171czMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843368; c=relaxed/simple;
	bh=BXTwXG/QzO6u1XNLD87/IzNVSJyF6sBtIFpnTngt3Yk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NRnNIsZ1RJdU/qU9QZBjsvcfrPOEAlFYLJmFF9aZDRRLbZtEh0QmGyAmrGawnelcgxGqzCqbk4y6rQemQ7koSOt1Jjlf1jey+u8zVGOzM4hXJfNFi4XXTvPH91HmihZ+vWH6xCu1MD7GjyrMxv/9T7I3lFJTGRUNmYU4FHKCFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Czhzmarc; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P6jEwu017602;
	Wed, 25 Jun 2025 02:21:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=yM1XFNaBNgpqbCZ5K8XLwlM
	71AV44uTsxqGf72BIZl8=; b=CzhzmarcZp1VZY1vHQo1taA2kl1GZwKh7N1pUjq
	cGEqiiivcOqV17gL3HPiwxVbwgQWmpkYku2vdwjNXrVf3DsUYfwmA6PWMI+XsqTG
	5SQZ/iVoi9OLwusRrf+bqfPNzOO1pW4ISw6q70hw0ZICTGKAHsewW/f+CPJsFUjQ
	erZDZbhk+I8iQ75vKpgMtovAf00aoEon5eavh4Hd2uo53iURh4aR4tbKBSrHu76y
	sKJM93o1U5air+Izy9+zJagLCqtu8pgNs08SxxldMkuE61VNyS97wdykpHyHEmU+
	2Q1wqhGk97BZ5xger5BXqNLVf17SAAV0gLIiFB6bDGiBMVA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47gc3kgad5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 02:21:17 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 25 Jun 2025 02:21:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 25 Jun 2025 02:21:16 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id C05813F704F;
	Wed, 25 Jun 2025 02:21:08 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next 0/3] Octeontx2-pf: extend link modes support
Date: Wed, 25 Jun 2025 14:51:04 +0530
Message-ID: <20250625092107.9746-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZOiaDZqfK0UXBYuDfJIqg4j285MC_8jT
X-Proofpoint-ORIG-GUID: ZOiaDZqfK0UXBYuDfJIqg4j285MC_8jT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2OSBTYWx0ZWRfX434TGp3hrFVe FMzRWgxCqZq+LG+GIKD1klh4CdWQGDUZaCYkjg+zuJ1szwOVvTEspWzNvpe3gNn3luAc6wbl27m 7Mooq5pSTMiI+8dYU0kYFZkd1wT/JIC6HWdP7bzvdnpJYKwxSTdTQDMa65kzCtJdXRYaCMo/LqF
 qN12c1SOLvlabE24tIgn5LBq5/z1mm+2wvP9i9EzN/soHVZ24wkqHjoBlmw8XQGGTiXjI+qfwcg RS12LtkDy8gZ1Ni2Bxe5jaYHGHwtrZogmlFYtzmdcuz21iFrV8d6C7cDAliuTZ/GZXtejLw147D Bi1AVmvFDwl0q0flutuBNxg8KtZF2KupX3IwllZv/Uie4NJwzYb3p6bECGvrZ1wdHXMgkwZignB
 e7WSlKaDhb966QZEP2yAacjz2ReAMdnGvlwkaatlLtYEqs0HUO2KKyiy2l3d/KfHEMz4k9Pd
X-Authority-Analysis: v=2.4 cv=D4ZHKuRj c=1 sm=1 tr=0 ts=685bbf8d cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=6IFa9wvqVegA:10 a=xG7LojJKveJkHGXijn4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01

This series of patches adds multi advertise mode support along with
other improvements in link mode management code flow.

Patch1: Currently all SGMII modes 10/100/1000baseT are mapped with
        single firmware mode. This patch updates these link modes
        with corresponding firmware modes.

Patch2: Due to limitation in current kernel <-> firmware communication,
        link modes are divided into multiple groups, and identified
        with their group index.

Patch3: Adds support for multi advertise mode.

Hariprasad Kelam (3):
  Octeontx-pf: Update SGMII mode mapping
  Octeontx2-af: Introduce mode group index
  Octeontx2-pf: ethtool: support multi advertise mode

 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 55 ++++++++++------
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  1 +
 .../ethernet/marvell/octeontx2/af/cgx_fw_if.h | 33 +++++++++-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  9 ++-
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  9 ++-
 .../marvell/octeontx2/nic/otx2_ethtool.c      | 62 +++++++++----------
 6 files changed, 113 insertions(+), 56 deletions(-)

-- 
2.34.1


