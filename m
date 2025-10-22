Return-Path: <netdev+bounces-231514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE90BF9C06
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 04:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C98E19C4868
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6605517BB35;
	Wed, 22 Oct 2025 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="o/gQEfPE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89845153BED;
	Wed, 22 Oct 2025 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100830; cv=none; b=nPdvx9HJX19uRe6IOIl4NyntGkngvmW7GI58xzpCevvfHgx6OmbDFV8zeW3A6C1O7QNbIlB0QVsVyq8KX8QTEio4lYZjPPV6pm6IKdUWIJ5BcPZPBxaw3kZyNFX8b+UUUb+aaDsR4DxL1yyNNrEq2VS94c8oYuuTiGPunBNqU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100830; c=relaxed/simple;
	bh=YfLxz+1xwnVOpzZ2JUu5fbWVJwN2+rzZWBbl8phqto8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ukvj3YqgwsgM9gTQ3EsYuJ9LNOLzTI5+911faDcVFyVXjrMANGrXTYoyLddjQ5SfWGzuZNl7hX4PXh24sz71zPZ4aJELCCqzcIoNbJkI+4ROekJii/2yMLp2/U1Njhxkz+FbThDTClTk+lPuQGCAEDgzByIAcaUPauu4/xmGBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=o/gQEfPE; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M1x5NO2299378;
	Wed, 22 Oct 2025 02:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=ZjKAK0Bf+
	4pkvg3Bam7nabKNYs94G5UaVYnLMnn5k8U=; b=o/gQEfPEprw+UkLDMU1/5CqIu
	TiN593tmtyoA8hQ8YS8umOdvzL921S+Zd93B2QN98dk144UJExjF/0ecwzUZydwY
	jtdas6XuGJScCOIbnWk66QhTjVU9YCgsg+uwkzhILdi1EMAIvMQYVcKDBSj+4AI4
	dGzcw143X+8LTLgftuMS66OEtFcRyPFIytaUzZbVxy+JFU+3EC4nlv4pHY2hR/zF
	PiDSsMjhy9+ngEAGiKzXaH0gFTsim2/g176qrhN2nSb1Of/hTpIVqGEyH2qt+KDa
	1MajoAMndVlunL90Z+/DkvPA0r/SAa5rN7G+2joO+GtukBif+f6a1ugq5EQtg==
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49wrpx9y6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Oct 2025 02:40:12 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Tue, 21 Oct 2025 19:40:11 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Tue, 21 Oct 2025 19:40:08 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <samsun1006219@gmail.com>
CC: <kuba@kernel.org>, <ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
        <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
        <syzkaller-bugs@googlegroups.com>, <syzkaller@googlegroups.com>
Subject: [PATCH V4] usbnet: Prevents free active kevent
Date: Wed, 22 Oct 2025 10:40:07 +0800
Message-ID: <20251022024007.1831898-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=b9O/I9Gx c=1 sm=1 tr=0 ts=68f8440c cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=pGLkceISAAAA:8
 a=t7CeM3EgAAAA:8 a=KMxUBI-LuQ3xbY_cxn0A:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-GUID: HfAhk5HfZUqTgAHLbbzazWwXt4njlAaX
X-Proofpoint-ORIG-GUID: HfAhk5HfZUqTgAHLbbzazWwXt4njlAaX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDAyMSBTYWx0ZWRfXz66lZ1KamRCd
 Whoy6tAKHt9qMn/ImYhHv98VXuvgyTKc/jAEIhx1Pem3QNdf1oo0dVg4YeaNA32rgO9ZTrVjtNm
 XHvfINhdPalGFlamFQ34PQSPn+s1rEQJGgKAchiZZO4w/k3yEMJ7xH+fr/x4WIvxtlwXRSuJkup
 gAmikifYYSoq/BF/A5iH9mFqZnjiNCKOdRqsJSn0dHXfpmhiBuCThPRDG1ZbAHkIo4W5yvTOtyi
 bkVRkwZCq/oS9ElqBAIm95gUKflumLTqX+XMUyIjA04rZtZYlooAh7vSgZTLnQrridaToVygnJP
 RNlPTcjJA/i+sgZhd2lduLUDt3s/AtfWlgl+MaEB/n6Js+dfZuqlrPHwnFZliAmvyM9fESy1xUc
 pLqtmjnENY0soNbVqycslXpcZzhj3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510220021

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
free_netdev().

Fixes: a69e617e533e ("usbnet: Fix linkwatch use-after-free on disconnect")
Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=8bfd7bcc98f7300afb84
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 -> V2: update comments for typos
V2 -> V3: add fixes tag
V3 -> V4: move cancel_work_sync to right after unregister_netdev

 drivers/net/usb/usbnet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index bf01f2728531..697cd9d866d3 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1659,6 +1659,8 @@ void usbnet_disconnect (struct usb_interface *intf)
 	net = dev->net;
 	unregister_netdev (net);
 
+	cancel_work_sync(&dev->kevent);
+
 	while ((urb = usb_get_from_anchor(&dev->deferred))) {
 		dev_kfree_skb(urb->context);
 		kfree(urb->sg);
-- 
2.43.0


