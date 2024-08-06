Return-Path: <netdev+bounces-116191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7203C9496BD
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF541C2136A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FBB59155;
	Tue,  6 Aug 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="eQx3WLkf"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01072501.me.com (qs51p00im-qukt01072501.me.com [17.57.155.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC7C7603F
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965329; cv=none; b=lFECi2gToPeYda0+gYOziT9OYYBMDMZ0dDDug+AkBhnpfg6EPpMoGwGOEE/3720P67Tu8n9xGghPf/cgfXf8JEobaY+nH/MJhpSQr0Bp9k0Z1FdYQASrioCBd5SF7ADPZxD++78xDU1cNkfrdcXdmBkfJak6/aYx9EX/0QyoSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965329; c=relaxed/simple;
	bh=8EnOfnQc5awRMnkFtVV217X1/jCf5ygnJDCReCt8/BY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGCBjpkF39cLtssSrh8lszFBsOKtsFn2Q3HNasCmsGFbkxU/Dr3ZURCQJQvbIQKno1bKuAjYYvmrfOCCcmBZY+TQfAMqY4hO10Z+tgOOQGU+lRsmmFdZJ30DsRtLo82VpdyEhvm6KE2Yn9KzMZKQOzo4xRz4/LYeMLP8HHI21kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=eQx3WLkf; arc=none smtp.client-ip=17.57.155.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1722965326; bh=I54BpuHlFXJ14PzdceLKFzF/ikAKzgpc8iyj+Ds8T8Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eQx3WLkf6F+07Ojqz3zk3dmHGdgRIezrIDpxO9QtQpSWJ8P7KADfhgA+nE0xDFq2B
	 VjgVa9G8jQBnGxbnUzLFIlW+v7O/802JRW2H0RPbja5Indhj777RrNQ0M+lPd1TGYT
	 O+iyxj1NlmvEZolyI34a5yflxPTuybuvmGXvlEC46BQotoecUYmJgvMJUoB1WB6t4q
	 F50Cf8XLITx4s+eO+0kDYIPQMITYK8q3YosYOCdJ2q/Vpp/+5Hx4jvA8rlPlqLo1Qt
	 ZBfDYtVO5686kQksi1G9hm15UWb/w42rf0w0Q5whvuJqa1+FOy7MOWj22bLiLeiP9S
	 A6tDQJ3gHFoHQ==
Received: from fossa.se1.pen.gy (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072501.me.com (Postfix) with ESMTPSA id 88716440429;
	Tue,  6 Aug 2024 17:28:43 +0000 (UTC)
From: Foster Snowhill <forst@pen.gy>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Georgi Valkov <gvalkov@gmail.com>,
	Oliver Neukum <oneukum@suse.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH net-next 1/5] usbnet: ipheth: race between ipheth_close and error handling
Date: Tue,  6 Aug 2024 19:28:05 +0200
Message-ID: <20240806172809.675044-1-forst@pen.gy>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xKZZWHYtk5nDuCNqkQSujrzv2VdPu78K
X-Proofpoint-ORIG-GUID: xKZZWHYtk5nDuCNqkQSujrzv2VdPu78K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_14,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408060123

From: Oliver Neukum <oneukum@suse.com>

ipheth_sndbulk_callback() can submit carrier_work
as a part of its error handling. That means that
the driver must make sure that the work is cancelled
after it has made sure that no more URB can terminate
with an error condition.

Hence the order of actions in ipheth_close() needs
to be inverted.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Foster Snowhill <forst@pen.gy>
Tested-by: Georgi Valkov <gvalkov@gmail.com>
---
v1:
  No code changes. Fixed two "ipeth" -> "ipheth" typos in commit msg.
RFC: https://lore.kernel.org/netdev/20231121144330.3990-1-oneukum@suse.com/
---
 drivers/net/usb/ipheth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 687d70cfc556..6eeef10edada 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -475,8 +475,8 @@ static int ipheth_close(struct net_device *net)
 {
 	struct ipheth_device *dev = netdev_priv(net);
 
-	cancel_delayed_work_sync(&dev->carrier_work);
 	netif_stop_queue(net);
+	cancel_delayed_work_sync(&dev->carrier_work);
 	return 0;
 }
 
-- 
2.45.1


