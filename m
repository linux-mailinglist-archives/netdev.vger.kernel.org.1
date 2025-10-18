Return-Path: <netdev+bounces-230658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0067BEC63C
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 04:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7C119A7630
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80048273D9A;
	Sat, 18 Oct 2025 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="V0iUx5sS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9724EA81;
	Sat, 18 Oct 2025 02:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760756168; cv=none; b=O9jeYE8epibqhrExnObBriXY7BAukvgTyCdd9CCKPfu+LDpuz244fVwDHaletXVhgExOmipx7tSNXRqsEBDSFnLCac0GozoqaDms/80h/dhL5QKts8IxUZ3Nh9mSgR+0kfgtPZOVlNxyuPD2t4n3DR55cE3uPkO1C4iQj/0X5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760756168; c=relaxed/simple;
	bh=+5oOPNDj4k5rECDdfajDXY5qRVPcA2BuFlWfjZRZrVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5DXsstFY398l7Wpjc/EMU1b9whkydJte9AiuTmVvuX0ReMXgY1CUED7PkXJcNILI2Af+99XgvuL9zL6Ff8PYdO6KQgnPicCiUXhQE1OOsyasY/IcDo78rF1mhnqCtwm4WzhABmgeN3O/UlYTMxI4P186Sw8yEO012mv/mYpbPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=V0iUx5sS; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59I2A9Y3521369;
	Sat, 18 Oct 2025 02:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=S2JR8vo2XxD0vTBK5qKMOyko11Mj16QiJ5O4zIN0A4U=; b=
	V0iUx5sSWcmUl4EP7JeVV0AraWC5mKYPr1hdg+9JxWEJxbIGjyGTA+V0yv7Rr8WK
	pYQv/p7ReL7pK38NGMFYh0g8xbzWJ4rNyQmZoVFqkfcRKcNEJroTgg5VcU/Fhod0
	BO4m4bBofjnKV0gO4eGEcqm3kOMI4IwVdeepvfn1U+wuCoP8c+Bnq80r+oi17XDS
	Z3FPCa9MSs1k4BrprC1IWEMLVqo17zoT624+CKR02CiZRVjxQIgEkgJlg/koOGe/
	/5Lrk/ZjgqFAyDo6si1C8gvb7R+9VrHKD05FrsSM/JcZK0zZNV6yjhjOPsnbOi5k
	F/AWEPGcagKv0QMJnNIMuQ==
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49v1v580r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 18 Oct 2025 02:54:40 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Fri, 17 Oct 2025 19:54:37 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Fri, 17 Oct 2025 19:54:33 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <kuba@kernel.org>
CC: <ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
        <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
        <lizhi.xu@windriver.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <samsun1006219@gmail.com>, <sdf@fomichev.me>,
        <syzkaller-bugs@googlegroups.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH V2] usbnet: Prevents free active kevent
Date: Sat, 18 Oct 2025 10:54:32 +0800
Message-ID: <20251018025432.3076176-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017152731.4bb7f1f9@kernel.org>
References: <20251017152731.4bb7f1f9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX4P1ly4xdIDYD
 KG4hKN+7+A8HcH73q6O0pvLN8RoqH3ehcLYFWSYLzhBEJry3f5PbLUtm9AiZwzoD6bLeIEkkCBA
 vxWHAzBm+rEd7ppQr97rv11UL5cEHvrzMnzo5zIf+xBS7ePq/VDfkTAvbBKB7Xtr4bKVq/XAn0B
 RbeHF1DPFsLQa9+UgrpvVvSmtxjA3368nm/l9zetKLbJDYsVV4ZBeGf8+FqukgMXzhaPsROshoH
 Zy1pryU+ngf2eQgl33RaMJd58IV6/orcnfsTq9MFTYyxSthX2DyAKx7uZYbp5o7CRD89MlhquYd
 iaelqR2zOSmbRE8FMipYP8pqYBjdKuMEN5Tt8+iP+A5Hc4u7YvQ2Tzdlv0TuXHYO3LHd1qXJQvc
 1obzYQs26CzVRZMcdCIGs4iV4CTs8w==
X-Proofpoint-GUID: 1OUIEQobEWcvt5hrPTv8sKcXsRbE6xc1
X-Proofpoint-ORIG-GUID: 1OUIEQobEWcvt5hrPTv8sKcXsRbE6xc1
X-Authority-Analysis: v=2.4 cv=ANdmIO46 c=1 sm=1 tr=0 ts=68f30170 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KThm-CiCeT3EGkx5rsgA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510180020

On Fri, 17 Oct 2025 15:27:31 -0700, Jakub Kicinski wrote:
> On Fri, 17 Oct 2025 17:05:41 +0800 Lizhi Xu wrote:
> > The root cause of this issue are:
> > 1. When probing the usbnet device, executing usbnet_link_change(dev, 0, 0);
> > put the kevent work in global workqueue. However, the kevent has not yet
> > been scheduled when the usbnet device is unregistered. Therefore, executing
> > free_netdev() results in the "free active object (kevent)" error reported
> > here.
> >
> > 2. Another factor is that when calling usbnet_disconnect()->unregister_netdev(),
> > if the usbnet device is up, ndo_stop() is executed to cancel the kevent.
> > However, because the device is not up, ndo_stop() is not executed.
> >
> > The solution to this problem is to cancel the kevent before executing
> > free_netdev(), which also deletes the delay timer.
> 
> Please add a fixes tag, and repost.
Fixes: a69e617e533e ("usbnet: Fix linkwatch use-after-free on disconnect")

Later, I will repost new version patch in a new thread
and at the correct time.

BR,
Lizhi

