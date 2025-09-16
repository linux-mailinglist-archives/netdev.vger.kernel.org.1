Return-Path: <netdev+bounces-223541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D156AB59722
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A49C320A0F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95225313E3C;
	Tue, 16 Sep 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I1tJQ1kz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C531352A;
	Tue, 16 Sep 2025 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028370; cv=none; b=RZ7VP5W2mTu2sAFkpcyFM2y9fXoZDZq4p7kKYz/RZ8X3n+gW/RGiWWrM1P1SpgSG95Wp53KUKnW0dzjBzoN/Gp8otFPo1cc7UQ27PC/60IiE42QVOQxArQJ1EZo/ZORa64FZTRbUMF3gqO35URQFaj9eUn15+jUNY65M80Mi6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028370; c=relaxed/simple;
	bh=NdsjIpLQ/ZCIkYQFwRJqqaobbgPnADrDW11zLKXJU0M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O6PgRhT4bzt3nmnSbnCfltBIUnQdDUlB1b7Gdhi3jtFnSluXsHCyhriYQjIz+AEfxXowEuP+YXnir8qXCWAkN0rTV3OEiWE07YTGSvk0YoqsrnieFTwnpjkK41elS7NDTsshlLi0Hd1CSE9vYT6MGmeKp5RM+2RJwydiIQXu3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I1tJQ1kz; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9RMM3014997;
	Tue, 16 Sep 2025 06:12:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=S43lXPw2lCJOOulxOQ+29E0
	fsDGAddr6dm3x72BG9Bk=; b=I1tJQ1kzg5YbjS2KVQXzWdOnTtkbtgagUFBU2+N
	dNT+2zwtXVQpi3lZzLwqnXWizDV8ZoalbWAOvU3odGE3zfVqP190bix01Ijj8W1j
	+CqRlVA2L72Cwh3sXviGIB1pAtXrVQ+2KkqA6HP/DTLliCP+qUytXrqVG1fayrvk
	HGKEmtQcTqK/KpwALqb+G/J+YdY7OvlMOdd1hnWAOvgiv/VGH8wLytApZNzG9MYy
	pM5R/sgURrBdRwb3yO8zUWmaCDYOePfGKiWQggH4iodSGGatI6JEtBrlC2IwNLtC
	SnXu8AdDVEbXwfIxFfhM4XmiTxLAoRmqHbzXL1pmcwIzvSg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 496tgysjs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 06:12:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Sep 2025 06:12:44 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Sep 2025 06:12:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Sep 2025 06:12:36 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 523123F7045;
	Tue, 16 Sep 2025 06:12:36 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>
Subject: [net PATCH v2] octeon_ep: Clear VF info at PF when VF driver is removed
Date: Tue, 16 Sep 2025 06:12:25 -0700
Message-ID: <20250916131225.21589-1-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KpVN2XWN c=1 sm=1 tr=0 ts=68c96246 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=DmOvae2lHUslj-ssQz4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: D9z8UjjYgHqZDk8tCwnomO0at0y4l_MF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDE5OCBTYWx0ZWRfX82iOB9Wa8OmN bn+b8j1mduxKKnETsINw6R5hD29y2+qrea9YaK4QpL5D4ONHPP/k62qEpOcKXlY92EdDjauuMUC 6w+ODDxScC/YJ8EaSR9tEMGUfrZxl6IVZnSHbit+INRvJCUzh47boHi3PjFFhVmeV8PUVIWmNq3
 vvapK9pW+9OmxbCqssakLixhBa9KTWYVYyPRELIU9K7Jdry11Zo6WEDmnqJaT/0qlcpi+7MOUoa m1pjam1bd5t2EkA5uwwYSq7HcrEiCuvdPsQaRfy1DazftnOWnUhfIdRvYmnjZ6ZsZ2J4BKI2YYn ydVmgXN2o2Jyl8UmVKOpRZD86Sv9lr/BGJz/IE9N+lT2iAHHa+DEl9seRAQh7aT8bsyOxB2tA7f RjqD8GsP
X-Proofpoint-GUID: D9z8UjjYgHqZDk8tCwnomO0at0y4l_MF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01

When a VF (Virtual Function) driver is removed, the PF (Physical Function)
driver continues to retain stale VF-specific information. This can lead to
inconsistencies or unexpected behavior when the VF is re-initialized or
reassigned.

This patch ensures that the PF driver clears the corresponding VF info
when the VF driver is removed, maintaining a clean state and preventing
potential issues.

Fixes: cde29af9e68e ("octeon_ep: add PF-VF mailbox communication")
Signed-off-by: Sathesh B Edara <sedara@marvell.com>
---
Changes:
V2:
  - Commit header format corrected.

 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
index ebecdd29f3bd..f2759d2073d1 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -205,6 +205,8 @@ static void octep_pfvf_dev_remove(struct octep_device *oct,  u32 vf_id,
 {
 	int err;
 
+	/* Reset VF-specific information maintained by the PF */
+	memset(&oct->vf_info[vf_id], 0, sizeof(struct octep_pfvf_info));
 	err = octep_ctrl_net_dev_remove(oct, vf_id);
 	if (err) {
 		rsp->s.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
-- 
2.36.0


