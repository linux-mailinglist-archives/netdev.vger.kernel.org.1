Return-Path: <netdev+bounces-100494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01EC8FAE9B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A292F2889EC
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B11714386B;
	Tue,  4 Jun 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="M0wYwcfl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646931411F2
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492801; cv=none; b=GEoUQYqgLaiXMlnXXCl/XvfqW1oIlWz+f6JmkYmwVkf4htDeWUZhZPHcHWxRM7ijA1uei7D75g4ukk9/Ch/7nI3KtzXOVDDhswB5GRRlHKwzZ4WMU5h0buFC0PlZijVus4ht/C2p8i47VspXVpmvhO9ZpJM6cXtuRMSRezyfHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492801; c=relaxed/simple;
	bh=ia6r9oZ4Z3uSQMdE9t5Sa/l64F1lYlmPlvnvpLM8faI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T83OERVlfd5+lZRSJ5rO3sfjfg+FEHtOWw126STlIJObWW5AZfJLd4LZ08WkSHr8v4vLGIu4phuZzcJDEGLJcg1gqxsjH37lAMZXXGb7qCnlGEsJH2FI5s6IE5usMvBkpC4DOcw+J6GEbERXMOhPk2uwU2/kqWl5uAJ9YfmYx0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=M0wYwcfl; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 4540Bb0e016905;
	Tue, 4 Jun 2024 02:19:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=s2048-2021-q4;
 bh=ZJZmk7Eb1VPqFlxpdT/6EfgzU2zBq88KNDe0gEngwQs=;
 b=M0wYwcfl3peLz0IDt9l3uYgwfGkEWkj+AO965LUJ5lRROX2xOji3OKWl9elKIuBAcbrQ
 UWLrDIWz9jwQyzMjfxh4CoxZvrr6pbV8LHdHfex9tagKYlkY7R11uTqew/bn4Qm/Dq7Q
 teI+9YEPEoFDTaOQeT2bop2nSXFpg9vyT6xb6Adb42/hQhj+1QACduagF0nWJH2aYaDO
 MJrQ9LB3PFWyMICLSmrjwJhNEdpAOFHcJEsH7HbS/9uEwM0V1rOClR1dNDlOsSpYDJOI
 DFUjE+ZOWbfaZweF79p5D2Sy4Ki/bEp+45D7dJwnY2BXjctJzbDRRWXy5ObWzaOc5Jj7 Gg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3yhq42thkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 04 Jun 2024 02:19:48 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Tue, 4 Jun 2024 09:19:46 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Michael Chan
	<michael.chan@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
        "Vadim
 Fedorenko" <vadfed@meta.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] bnxt_en: fix atomic counter for ptp packets
Date: Tue, 4 Jun 2024 02:19:39 -0700
Message-ID: <20240604091939.785535-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Mh_VvSlWLOe2hp68AUdfdhK63PdzX8N-
X-Proofpoint-GUID: Mh_VvSlWLOe2hp68AUdfdhK63PdzX8N-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_03,2024-05-30_01,2024-05-17_01

atomic_dec_if_positive returns new value regardless if it is updated or
not. The commit in fixes changed the behavior of the condition to one
that differs from original code. Restore original condition to properly
maintain atomic counter.

Fixes: 165f87691a89 ("bnxt_en: add timestamping statistics support")
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6d9faa78e391..7dc00c0d8992 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -513,7 +513,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 
 		if (ptp && ptp->tx_tstamp_en && !skb_is_gso(skb)) {
-			if (!atomic_dec_if_positive(&ptp->tx_avail)) {
+			if (atomic_dec_if_positive(&ptp->tx_avail) < 0) {
 				atomic64_inc(&ptp->stats.ts_err);
 				goto tx_no_ts;
 			}
-- 
2.43.0


