Return-Path: <netdev+bounces-189662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 700D3AB31E9
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951661899AEC
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFFE259CA4;
	Mon, 12 May 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lB/8RNIK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0695C25A2AC
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039356; cv=none; b=ETEchDxRZxHANhOcBw3AaFuEeE2xxZarw/M82FPCkSynDRyORo4Zc4NGuuiXDWzYAhNDARshxlkUAn3i8peGNTKPeaPXY7C0aAfPhTG7Z9lqQMdSf2sTQnsA9T6NVzmn2PrTyJKfRwVh8vsjez4tNhZNTpHddIcEEOMWRKfXblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039356; c=relaxed/simple;
	bh=KQUbfk65gPyKcbZ2cIk45hwJvb4dw//pQIv8xvooWe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfCdmBmH66qwqb80HgfaQNJV3MZTs+BwZhkuPH4rDdtgNhUwWKH8e3g6oPeMBQVFaMe9zHEprxo1WDoMvB3BjtCjqLjVqmZYRqZdoMFFzHbqyqRS0LmH5LoBSDQju+AS+iW9UAzRN4ChxSTTCmjvs53Hz3emeEAyo99hZ7EUsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lB/8RNIK; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BNm7rT017644;
	Mon, 12 May 2025 01:42:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=r05WdWR5hGmDdEtiZUfHifohY
	kYgcjv45zioUWLarSg=; b=lB/8RNIKLApELVyvrQAZrjfAsvM0VKjGhxyrTfBbt
	C8qD04r/ibQfG6NgCKAo8itxTz0es9IkBHybKNn68OjUOle/bXiSluXdR9t2tyje
	EPB2eHlzH9Z9wd1hD4g6Lw8uJh5kbObiDzrx3KHV4czVTL/KLHrzGL3uuW8Lfh7O
	MgKBR4L/AIY9sALucgDm4qSIgjg6VH6s4ppAhofthTlQ9zGTXDW2NBhzN3UY9zMh
	EMEXfS9z9n7xWhFxilKyyvsy1V160dG7ECGG//3FEfn8PdO9EbEu2ZHi69QNG9Ox
	vGAPoYGHeRaL5Y3OhZww1shjsvrcIh1UspS6zoXp/AdVg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46k5r6gp2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 01:42:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 May 2025 01:42:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 May 2025 01:42:13 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id B1EB43F7089;
	Mon, 12 May 2025 01:42:08 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH 1/4] octeontx2-af: convert dev_dbg to tracepoint in mbox
Date: Mon, 12 May 2025 14:11:51 +0530
Message-ID: <1747039315-3372-2-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1747039315-3372-1-git-send-email-sbhatta@marvell.com>
References: <1747039315-3372-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=6821b466 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=nvB0ett4rcpRluyxjm8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: PRcAFaJWqZms6vmPQvzAvg3u3QDwwneV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA5MSBTYWx0ZWRfX+wiWY/tYkxfq RZeQjJ5rFKvXKi3Jn9oLL14X6VhzxB1eJwO+qVJz4Ll7X6U8qoQI3JCte4Pw50Kx1jtyn+omyoY TFTvJUpcJbYBhi2RszuhhEgFjTw4aQ6vcLqGymmD3WVsdpImx7dCCn+WqyzoIcPJ8k2fB1SHxZ3
 AFyhTdER5uoJrIsCKuh13JSkTD16oo2MtfiOqKagxxZKjpD5Fg3Of7BIu/rPAo4Pd9XsvYXNgQv KlgwrwXDBPMYLmJLUc1Kue3MpdzdvZ5a/3e1UkNO929MMmIxweRRp64Z6ZMxJ7wczw9qHyjhz9y 5snG3I7rGCWRNFPyfr8u1J6eiT1fFvpdlOe1WrqnXXuNiIQ/sEQ7BEFWwNsVYVwjSpViFiEtgH7
 YbCd2lZatLaRqamiORXrLdBx40NkgBHd3vi4oEBxvSzSuhVZCKR0TvGPl9XbEgqEGWuo8dU+
X-Proofpoint-ORIG-GUID: PRcAFaJWqZms6vmPQvzAvg3u3QDwwneV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01

Use tracepoint instead of dev_dbg since the entire
mailbox code uses tracepoints for debugging.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c      |  3 +--
 drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 1e5aa53..5547d20 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -188,14 +188,13 @@ int otx2_mbox_wait_for_rsp(struct otx2_mbox *mbox, int devid)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(MBOX_RSP_TIMEOUT);
 	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
-	struct device *sender = &mbox->pdev->dev;
 
 	while (!time_after(jiffies, timeout)) {
 		if (mdev->num_msgs == mdev->msgs_acked)
 			return 0;
 		usleep_range(800, 1000);
 	}
-	dev_dbg(sender, "timed out while waiting for rsp\n");
+	trace_otx2_msg_wait_rsp(mbox->pdev);
 	return -EIO;
 }
 EXPORT_SYMBOL(otx2_mbox_wait_for_rsp);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
index 5704520f..f3b28c1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
@@ -95,6 +95,17 @@ TRACE_EVENT(otx2_msg_process,
 		      otx2_mbox_id2name(__entry->id), __entry->err)
 );
 
+TRACE_EVENT(otx2_msg_wait_rsp,
+	    TP_PROTO(const struct pci_dev *pdev),
+	    TP_ARGS(pdev),
+	    TP_STRUCT__entry(__string(dev, pci_name(pdev))
+	    ),
+	    TP_fast_assign(__assign_str(dev, pci_name(pdev))
+	    ),
+	    TP_printk("[%s] timed out while waiting for response\n",
+		      __get_str(dev))
+);
+
 #endif /* __RVU_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.7.4


