Return-Path: <netdev+bounces-245503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 174E9CCF4C4
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 11:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A02DF300C6DF
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48BE1DED57;
	Fri, 19 Dec 2025 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="L04XhHI6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040F62AD25;
	Fri, 19 Dec 2025 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138891; cv=none; b=T7ltRsfE8BH+L+UsuBgJSZZjGgsoeNxTwgVgVk2J+Duo3EbSrb7UH7n7z1v+dWGeln6CJ7Hc/XRJw8+v/EAuz05Ee5aq0xFyD2E9S8/OsCw5mnwYC/56rz9NTUQwnsXRMWe6gALefnPHpFnQ67E61Gb9I+Q3irYIVCEJuMzYHtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138891; c=relaxed/simple;
	bh=UWbq08b0Hpu/lBLQ5OAmgYM6EFjmL0dDAyx92j59vyY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d15z7EoD1IrItXU4qMUHMsI51V/nwhzQogFYMmbiPM9D++P3r3i7kKqaa6bkHef16TKkgSKdlSHJzj7E8z9j147eqQZtV7EGRtuqX3OHBrLxrFF4YV+Ci7bhiigGdpthswDYuQya1D3X2vWozC0jZBl8lp86FUlDgnfyAeZqYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=L04XhHI6; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIJjQAV748899;
	Fri, 19 Dec 2025 02:08:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=eJ65JwEZyEnGBzukli50p+w
	fdVbbv2fbYNyp8+ZXVCM=; b=L04XhHI6boVYryUM7Dwlca77Nof7uefGLxoBIH9
	u6pLV3FHF+Ar7SI82ko8ao1RqijXytvMkd3qreL9yqJ6CgZ67mq8p8tiFuGMw1Oh
	LZ9x2wlK7NwjtnJTV6cpjy/9ttUKuut3/qkbqNVtJTMN2N4xuWXrKDYWc4KxaCTY
	4eiXpHPVOOWeqW8g+Prc0lKoPhFQpHR0axX9idEl1n4XdInJY+iyiaXrVfiocGwC
	1G0xht65kbTGE+JE6lpXR/fzhP6tPicJJrPNSSJYNEKFLN1v2Nv8uqB7ig1/uJy4
	GMjOe6K4TRVc3cZJucR84gfQEbeyPpeAzwku4KEmV8UhMrQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4b4r249gej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 02:08:06 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 19 Dec 2025 02:08:05 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 19 Dec 2025 02:08:05 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id E71A15B695F;
	Fri, 19 Dec 2025 02:08:04 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>
Subject: [PATCH net v2 0/3] disable interrupts and ensure dbell updation
Date: Fri, 19 Dec 2025 10:07:46 +0000
Message-ID: <20251219100751.3063135-1-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=csSWUl4i c=1 sm=1 tr=0 ts=69452406 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=p6aAtTO9TJaHXOhTCywA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4MyBTYWx0ZWRfX5bizsohWjY3P
 AUE1olgePqkYRSlIJjqe2C1GrCybSjusrW7K7hOHvfWBxz4Fzr8Azc0Ryr331FoNbQofHF3cTq7
 xsKbi5h44wjgD15lRZj6d5iLOX2NAmxYWYgvlcDc2OsiBnWmZud+b9ZebDZdCpk2Kg0U0clQmdS
 6bDDtBx4SOWOWuLDmyXhG9nwrHkHBxx/ZgWi8TcMCtsdG7Nvp9cxjVKH50NnzXAvS+QbpMPVRWq
 iAEvqJWBwVjFs7Jej0y3r0WCzsX0TAC7BPg/d1e5ZGmZNyJVMDAd2wr9C8Yf/1VjANkFdQHcXv2
 ZO2QShYshvx8kco4k15N7A5knEgvkoYom7Zns0/s9C8YyUzRxAdaPcTMuloyeS19ujIQmLc/Jmx
 YGDC/5I5WkGvBvqfgIao3ckbzmvFw36V2CwzzcANceVsehjxgYlVvZD+uJXKuySrXURKvP31oZl
 WrKWLPffy8a08LhjpCw==
X-Proofpoint-ORIG-GUID: Vp42G9qEXQsaNBAFpgLvCg9uc9H66B5g
X-Proofpoint-GUID: Vp42G9qEXQsaNBAFpgLvCg9uc9H66B5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01

Disable per ring interrupts when netdev goes down and ensure dbell BADDR
updation for both PFs and VFs by adding wait and check for updated value.

Vimlesh Kumar (3):
  octeon_ep: disable per ring interrupts
  octeon_ep: ensure dbell BADDR updation
  octeon_ep_vf: ensure dbell BADDR updation

V2: 
- Use BIT_ULL macro wherever applicable.
- Format code to avoid line exceeding 80 columns.
- Use ULLONG_MAX and return standard err code.
- Place limit to unbounded loop by adding timeout.
 
V1: https://lore.kernel.org/all/20251212122304.2562229-1-vimleshk@marvell.com/

 .../marvell/octeon_ep/octep_cn9k_pf.c         | 15 ++++++--
 .../marvell/octeon_ep/octep_cnxk_pf.c         | 37 +++++++++++++++----
 .../ethernet/marvell/octeon_ep/octep_main.h   |  6 ++-
 .../net/ethernet/marvell/octeon_ep/octep_rx.c |  4 +-
 .../marvell/octeon_ep_vf/octep_vf_cn9k.c      |  3 +-
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c      | 25 +++++++++++--
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  6 ++-
 .../marvell/octeon_ep_vf/octep_vf_rx.c        |  4 +-
 8 files changed, 82 insertions(+), 18 deletions(-)

-- 
2.47.0


