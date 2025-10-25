Return-Path: <netdev+bounces-232806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E386C08F3C
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B92407D60
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 10:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E3C2DC774;
	Sat, 25 Oct 2025 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kidrXcya"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C482F4A00
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388456; cv=none; b=M64IL3nvSWMX6xlidoLQ5EPurmr4QjKN+3VqHLysYfKNN2RB0ReHjmAMAO4A6rwT2RfT59La8CloRfYqt2SvD1zRJmFA4X0yJbcHl+9w6VJUa8j2iWe+x2gH6s6ZccEZpwGL6KCUE9lXqbYYSmbl1Vjt7Zgw3heZ8JFSVxa9rGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388456; c=relaxed/simple;
	bh=DhFNkYNE1Zezkv5loAETVAvlIZuMp1+C/BhWEyMh8qM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1pQxglXq11f/B9F3DJYivkPDiDMzjqz/0o2gnxGpLoRwJb2ctOFTdCP5/m+tpv+UklON8x0Q91V4Lbr8DQx6zwyMPElnHKyrS3dim4X130k6kbQW7wTu0auBNWCCU9T+jrL9XL5efZx0B6EfSKbOIHoGBAJHOrIdMO9OOh2UsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kidrXcya; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59P9Al8X781313;
	Sat, 25 Oct 2025 03:34:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=QJeK3zcpgyDz9ctBGLUQC/P1o
	p1A7hBQj9GcOBfBGY8=; b=kidrXcyaPCejuBM8lnWDjdMU06zMJ68eV3hLUkYij
	K3+m/pViKwzfPStiLWvBzG8SgHO3f0EGX2QzDj2K4Z10DOM92xVrAVKLLnpCH+V9
	1L7LYicXEB03SXfiEYpie1HrxkISclB7fKEW3INGuMlFuin6WI3buNNIqtVkD8vu
	RqW4oiuRAk8jxrYhEL/cNDZH17jb3ugKuhmu0F7Stkh90jR2DjJpU9vObnSwTclJ
	tUztpe7gacLJJUtpznqUq+tFEi6k8bQf4vP/cQK+IGuOsoPPId4dWYbu8/I7APL3
	msPW8IVaZBOZ9RSdF+U+hsonzpgJI7jIT7PYUnP3uqXSw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a0nev8kkp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Oct 2025 03:34:06 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 25 Oct 2025 03:34:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 25 Oct 2025 03:34:17 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 10AE55B6921;
	Sat, 25 Oct 2025 03:33:59 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <saikrishnag@marvell.com>, <netdev@vger.kernel.org>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v4 11/11] octeontx2-pf: Use new bandwidth profiles in receive queue
Date: Sat, 25 Oct 2025 16:02:47 +0530
Message-ID: <1761388367-16579-12-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1761388367-16579-1-git-send-email-sbhatta@marvell.com>
References: <1761388367-16579-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=CNQnnBrD c=1 sm=1 tr=0 ts=68fca79e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=VbpyGYBai7zdicxOX80A:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDA5NSBTYWx0ZWRfX1ZCC5y4dhe5t
 gzz66IOb0k3+dyX0ecX/8x35j5unviwlkLeonT0CwupcPlL85EGKdXzUm9pdENF6XjqDuXM6SCu
 VDlkSOBLjyzyre5J4B5+UBHTr6RcP4vuzKC0sXQcTc2O19V1zdCAwzt9TcLplVXwTZ8He9Phjf4
 9PEB2FnGRaSgjvmYVg20TBtPYAVFTV6hnstbp39Hz3JsVo+Zj1zGeeOcMgFl8jr+rEz1RYXO6e5
 rVTdUAnGIWG7t3DwPPkB212HxPcJyz8Bjh/LtkUuDmGXadu3Ggf0Ela1RNjo646d7P5vsN+XwQ9
 IAd69XdriJ12Qt3ZLv7ZQVQYcEgUpyY9ZHDo+OqGUmG6z40bbmNx+3LP9ROSxGeVJsL5/8IaiZA
 Xco1giJ3Y83ZgO3AgPrhOfqzivv6uQ==
X-Proofpoint-ORIG-GUID: G5B1ktQ9pjOcoXSrtK-NIRoW3Nl5vSZg
X-Proofpoint-GUID: G5B1ktQ9pjOcoXSrtK-NIRoW3Nl5vSZg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_03,2025-10-22_01,2025-03-28_01

Receive queue points to a bandwidth profile for rate limiting.
Since cn20k has additional bandwidth profiles use them
too while mapping receive queue to bandwidth profile.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index cab157aac251..3e1bf22cba69 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -341,6 +341,12 @@ int cn10k_map_unmap_rq_policer(struct otx2_nic *pfvf, int rq_idx,
 	aq->rq.band_prof_id = policer;
 	aq->rq_mask.band_prof_id = GENMASK(9, 0);
 
+	/* If policer id is greater than 1023 then it implies hardware supports
+	 * more leaf profiles. In that case use band_prof_id_h for 4 MSBs.
+	 */
+	aq->rq.band_prof_id_h = policer >> 10;
+	aq->rq_mask.band_prof_id_h = GENMASK(3, 0);
+
 	/* Fill AQ info */
 	aq->qidx = rq_idx;
 	aq->ctype = NIX_AQ_CTYPE_RQ;
-- 
2.48.1


