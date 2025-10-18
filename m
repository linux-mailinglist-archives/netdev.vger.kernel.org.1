Return-Path: <netdev+bounces-230675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAEDBED1B2
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 16:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2335F4E2855
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8010D1FECBA;
	Sat, 18 Oct 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="e0YPhrjS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283F155C87;
	Sat, 18 Oct 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799024; cv=none; b=WuYv2Dnm/hCnAsDMQKmzQ9PxVQ8x9alxMt81ISEH2WBAwhrXfwz8GNwOBCKGi8kWMRQrvA8v6ckamfNsmvu63tysXz0hCbWTykqHIX3Rl1MEMnwpSznz0XAQsiaVXpJ0fYsXw6VBNHlmWc6fFeG7UZhINL8pWSuxbM/y2jz08z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799024; c=relaxed/simple;
	bh=648pd+hZ6Bg1u6gnUsjo34ly2X07I4BsBHTSBU2VNSQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Txms7wMO2tlFdmY/yQ7A6SGbUYE+uayHRm0F5SpKS0IN1o2OvL0jUzOsl/agQvFzlfQM6M8JgFLyAzXq808bNLOsCa8yRFh9142C6pZ/hGqNgMEzhrCjf5MODYpZ1TyNmtCFCckUnq1D+klqYYM0TMV8vPlHxEeiC1exNpdPnu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=e0YPhrjS; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59IEjvLW2559050;
	Sat, 18 Oct 2025 14:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=ymGMIUoiN
	lhIje32PB6Z8x28aCxMWufIy8EjLDuIhys=; b=e0YPhrjSbMpYzew9WTNuvsNcP
	xS/yti30ul+sJBErxiCVWO3mbSdNhMgtNPw0OI5R6C3T1W0I/qxsEuslj4bTP3cE
	YWf2m8m+enAAFG9B/QCrHiZylhKa5kNC9G1WNp5cO2n6QJXlCbpXPkwN1ZKSlbzh
	qEm9M76PMwNeQ/GKxjkZQWIKg+7xgD/2dl5dyf0agTEKi2W3tPpcFRQMW2le8VnP
	N9l+j8tYdHPuL8AydxtiilL5Wnnfk+wWqH57PnDY0eBldtOgzphbkRuTHqufdUzd
	JryNp1KHMdnMyBXDxslCo/K/nw6jYu2cftCFh32uAo6KkxcE2WgG2mqCH2MvA==
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49v03y0es6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 18 Oct 2025 14:49:45 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Sat, 18 Oct 2025 07:49:44 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Sat, 18 Oct 2025 07:49:41 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <samsun1006219@gmail.com>
CC: <kuba@kernel.org>, <ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
        <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
        <syzkaller-bugs@googlegroups.com>, <syzkaller@googlegroups.com>
Subject: [PATCH V3] usbnet: Prevents free active kevent
Date: Sat, 18 Oct 2025 22:49:40 +0800
Message-ID: <20251018144940.583693-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3jIIqOmQKCp8U2T1uU619rxrOXGS_3YP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDEwNiBTYWx0ZWRfXw9F4p7WilCxZ
 /7jQsOi0hdHgiiAOxZgunqzld+QkRM+umDkZg5xTDCAMvxcQp3Erpon7naPCZ3Q71o+EjPUu8fb
 EgCr3PNpZ8afkCpe1/adDe6mwoO1neOjGWkCx3r9j8mdsnr3XxIbMAi+IJnqULV53tjRr3JlO43
 QYXmJSMAAWmYaN6mrYYF9YbDbvF9Ky2Z2kq+LFu+298GbQWE6sZhaNaENJMHuf2nOmZA0fsvT5T
 pgsgT8BCSf7iaTDh1x/qNIAJJjTgtc6Q/07aaZXCN1JFdiPLZcTIjGD0zkOe/mszVvvNCT1bqvV
 m7PpyRQsTm3ZDOQdXUHzxp5a0JnFoHrzHXjrCvMtF4dUIZ0qZHx2mQ7gw07uGSTgnPOtWpylbUg
 nf/4+hMvzCTnbj+QV5nDuho/uocsxg==
X-Proofpoint-ORIG-GUID: 3jIIqOmQKCp8U2T1uU619rxrOXGS_3YP
X-Authority-Analysis: v=2.4 cv=Uolu9uwB c=1 sm=1 tr=0 ts=68f3a90a cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=pGLkceISAAAA:8
 a=t7CeM3EgAAAA:8 a=eAUpJhlxHBEC5-Y6-xsA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510180106

The root cause of this issue are:
1. When probing the usbnet device, executing usbnet_link_change(dev, 0, 0);
put the kevent work in global workqueue. However, the kevent has not yet
been scheduled when the usbnet device is unregistered. Therefore, executing
free_netdev() results in the "free active object (kevent)" error reported
here.

2. Another factor is that when calling usbnet_disconnect()->unregister_netdev(),
if the usbnet device is up, ndo_stop() is executed to cancel the kevent.
However, because the device is not up, ndo_stop() is not executed.

The solution to this problem is to cancel the kevent before executing
free_netdev(), which also deletes the delay timer.

Fixes: a69e617e533e ("usbnet: Fix linkwatch use-after-free on disconnect")
Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=8bfd7bcc98f7300afb84
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 -> V2: update comments for typos
V2 -> V3: add fixes tag

 drivers/net/usb/usbnet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index bf01f2728531..f0294f0e6612 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1672,6 +1672,9 @@ void usbnet_disconnect (struct usb_interface *intf)
 	usb_free_urb(dev->interrupt);
 	kfree(dev->padding_pkt);
 
+	cancel_work_sync(&dev->kevent);
+	timer_delete_sync(&dev->delay);
+
 	free_netdev(net);
 }
 EXPORT_SYMBOL_GPL(usbnet_disconnect);
-- 
2.43.0


