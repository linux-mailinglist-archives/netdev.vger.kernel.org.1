Return-Path: <netdev+bounces-230383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E9FBE7735
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F593B622B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59F2D7DD3;
	Fri, 17 Oct 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="NgmAaihE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844CD2D5A19;
	Fri, 17 Oct 2025 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691974; cv=none; b=B7fnMElZ/1dTvaZ8tmf6wO7kE7JzQvwvJurmnqlt4ERndD61yrTksWVO0MX1kPYiWCfQbkheATEuINKOUsxYHOjpokF2fgPj27N+LF4P0LpYvwupJg91+jfNrUPREbqeNublhWXivIWtyIlA9HzhSuGPvF54761BggoHn6SukaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691974; c=relaxed/simple;
	bh=LoX/Lxbv304qvjIS2a1OaSK5tvEqDMSDHw8eDppiorE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=St08W0OAEEEqOlsLP5kGpa//4+rCxFtF4530W9b3sOBuNLcOaNVIOqyIA6JsiwfJCSR6nTV99dRaayEpJSARZ9iCHAN6w9He6WspGd6+hoajYZyFEKdAI4I6k3yQncBQ4P/D0PiAaVO7Dv2p83egtKptwtgnwH2tRa492mwuWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=NgmAaihE; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H5efbc2691225;
	Fri, 17 Oct 2025 09:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=/JgYiI9yeG91Adi49Cc7NZy4njx/Viy4D1GT0w1uQr4=; b=
	NgmAaihE4W7EaDnOTKsLS6JMJdRgsgFM/GyZJGuaJeLyklP8yp8pLs45Y+1Lp15q
	vlxAFd8+IVdsKr/w1hPzJMnK4vZ1JbtAi3C7IWRZQryZYSixx0sOKjZlca6nGvvU
	kjYhy/KWAuUc7tzCJtD9YC1UxOWGouRTDY68q1qLG0zlHoeLV0lj4f8RU2hTRVdf
	z3ggUdVoOwjYw7CYllg4uXdbqLL1OF5hrxCkOM8iVZdiCUogK+wAlmJ7k/L29pS1
	zHxdveM0LbND1kHmtvPB9ckoZeFqLDVxdCLFehCv94RbK0SoduWTCcM44lMor1MU
	6h/Dv8sEaPIuDvGgBBBbzQ==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49sthhbuxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 17 Oct 2025 09:05:48 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Fri, 17 Oct 2025 02:05:46 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Fri, 17 Oct 2025 02:05:42 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <lizhi.xu@windriver.com>
CC: <ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <samsun1006219@gmail.com>, <sdf@fomichev.me>,
        <syzkaller-bugs@googlegroups.com>, <syzkaller@googlegroups.com>
Subject: [PATCH V2] usbnet: Prevents free active kevent
Date: Fri, 17 Oct 2025 17:05:41 +0800
Message-ID: <20251017090541.3705538-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017084918.3637324-1-lizhi.xu@windriver.com>
References: <20251017084918.3637324-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VV4ZH7_U5ea0fMZ3gSC0haIyQafL_hv8
X-Proofpoint-ORIG-GUID: VV4ZH7_U5ea0fMZ3gSC0haIyQafL_hv8
X-Authority-Analysis: v=2.4 cv=QLBlhwLL c=1 sm=1 tr=0 ts=68f206ec cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=pGLkceISAAAA:8
 a=t7CeM3EgAAAA:8 a=eAUpJhlxHBEC5-Y6-xsA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDA2NyBTYWx0ZWRfX5zONk/G5X5FH
 nWSMnMoqLtuUXccvjZwjgnyNGg6TARIIFRPymMslnOI9l0mEywrpYLZX34bfR5KbkK0URov24VI
 TmcbWd45O36+7TMCPDjQzPJ9v81UUQvJb8B7MgPvmb/J2t6Y4xJI0IyfqQPhW4K0Pk5nHdwDUXK
 ad+ZhY7+ItFENsWnFNW7CXUoH986ywwi7odeRSfGEhuBcT6b8GDdRn5wvRTmQgg7S2VG2m/qDql
 0tGgcAgapT1fS6ynW4Pfg6ltrHG5gv2ORqsUgkj6QlkY1oRcTldaLE6+f0z7qezYiOTf5W/z9OX
 yKWd0Pv+xCjs9bzmhDIuaBK9D9DTJ/nM7frtvBX3XUV+LX9Z+eQtbGjHnyLIoFowOt0Hh7dRwyK
 oGJoGOKbN+iNSlLICCnpXFggM3ypIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510170067

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

Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=8bfd7bcc98f7300afb84
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 -> V2: update comments for typos

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


