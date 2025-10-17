Return-Path: <netdev+bounces-230374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5B8BE74A5
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 10:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBE18561E92
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566562BDC10;
	Fri, 17 Oct 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="JDSc3UiG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705826F44C;
	Fri, 17 Oct 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690999; cv=none; b=mev1GDnfu18DWFfdhd8w1J+oDlCGudHSBelodcS3oXHxn9S98ig2z1h7EAmtkNsBG+VQV75bYA1xD4t+AgvyaqPsMnwqyHMdoMHwo/pNKlay8Uq4QrzdpDlvZ0oaLOBxW79akv5WgKFhDsVSQK6FSJoB6zORvHr2enyf5kgQPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690999; c=relaxed/simple;
	bh=Jh8KxGa426q94Ijq8kI+AebY3xfvGryjfcUsyjuRlsc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9BmZmGZdle9dqsMM18h0hw4+ARG2NFEagZFUVQv7TwCfmFaS9DJ5h2YCe4qXtKS+X/j2WGwyGtqxni+XwJsrTyUH0dzswF4vDRTxGjHi6V3FluXM1sgGUzsKPzLwInF+W8ccF0RQv9/MFphxJvDvuCqRJ4YRfS+nHYsoiQeIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=JDSc3UiG; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H5e2lA3490858;
	Fri, 17 Oct 2025 08:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ug/2E/nD8chEPuYG/rbfdQvE+iVPQsZrIDwrtFEgKN0=; b=
	JDSc3UiGhrkQqvSNu3Uhe0L9YaiQpg3Zhut8rer1V32E9LqpDvWrvjtXe+bjfJ5X
	cBL8GPY69nI2uOuaBNB/xqbzagFKzU1cdT9ygT8Z3BEySCcZEHgPRWgqu7Erspu4
	ElLCAiW5cRJ/bOOWhNNZT7Aljq+iuvqhjNH/V6Rc8XUBnMO2By3Sq0JMnrxV3XqI
	QO/igX2tu8hdaAc41K90nXgpqagL3xpzaPaF/oaqqNNE1p2AvphYpI/Mni7zm/HO
	at8ccfbJQCve0xUe9p91304+xccCQzCRQ+bG26h5vNzY9jTMsZH3Z8GuiOmNcf9Q
	podJlDrPFDK4PAWhio5kjA==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49qcewqes7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 17 Oct 2025 08:49:23 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Fri, 17 Oct 2025 01:49:22 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Fri, 17 Oct 2025 01:49:18 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <samsun1006219@gmail.com>
CC: <ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
        <syzkaller-bugs@googlegroups.com>, <syzkaller@googlegroups.com>
Subject: [PATCH] usbnet: Prevents free active kevent
Date: Fri, 17 Oct 2025 16:49:18 +0800
Message-ID: <20251017084918.3637324-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEkJfYPrHq1H9DfVPBKGqp5jZVhsfWZBccdFY+rvP9nS02SBxQ@mail.gmail.com>
References: <CAEkJfYPrHq1H9DfVPBKGqp5jZVhsfWZBccdFY+rvP9nS02SBxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WkuLmktTWkjMtdxUZTbpFyOtiZaigocC
X-Proofpoint-ORIG-GUID: WkuLmktTWkjMtdxUZTbpFyOtiZaigocC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDA2NSBTYWx0ZWRfX4nyFtCdF2pyG
 JGof/8N7kqL6p3PCHAq+vgHMmbqBg+qwhHeKRtUSiU6iJaaRJ87uqmZ6818ce3PD6XQh9y9YzGE
 JEH3NSXxR6vFnpXcreJMWuZitku6SU24poKtZw8Mgm0owEywBqk1TQZU5q5BHqK7/kqS5JO49Yy
 KyGkeVxDQ/whnyQG/JHT7jJmwSdfVoNvU5/AE2t/YmGGQEo+JdR5yKPkwTzkV0Ckhs9NzR/05+k
 vi60AFIJKMWkAnOT/7Ekp2OXaN9v6aG2U2SvHmPfCrgQsGYrihgZI9WPBXu78QF9B7aQJfb97RF
 tF9CdDt2/6Qw9IB2ZFyUJMmDE0Ays1oKrcLGUts+E+8lNMYiGhqDPDk0USwp01X2sk9WxqzPKuI
 QMncqChWet6neAFKvAgMjKhvVMeTDQ==
X-Authority-Analysis: v=2.4 cv=M+xA6iws c=1 sm=1 tr=0 ts=68f20313 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=pGLkceISAAAA:8
 a=t7CeM3EgAAAA:8 a=uWKex4Jl0yNLDR3AargA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510170065

The root cause of this issue are:
1. When probing the usbnet device, executing usbnet_link_change(dev, 0, 0);
places the kevent in the waitqueue. However, the kevent has not yet been
scheduled when the usbnet device is unregistered. Therefore, executing
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


