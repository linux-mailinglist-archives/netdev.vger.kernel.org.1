Return-Path: <netdev+bounces-231510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0407BF9BD5
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 04:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998D75658CC
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93048221FB8;
	Wed, 22 Oct 2025 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="lv26I2Xy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8E5221282;
	Wed, 22 Oct 2025 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100208; cv=none; b=dGvauP66BfmXg6QcKwVnLvrKineQWxN9MFpaVmyb8PYPkuCTjs5y++RR0WQuc7H/z47z6e3d4Rkz+lWhXzaV/PdeSgpOSk4uP2VNVvGbH0sPb/j6vZx/1itjEDoVJ0KF3ufIAEo/Ewm5t5l4AeBuQ+ejKJ1DSwtPK1Uq2Pgktbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100208; c=relaxed/simple;
	bh=nL5OpE8VSi09xoMa52FvGYHtlPIOpRB2poQAX7RpnUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UE7oFkXL1gh0SdIVrgRTNdfK/39hggq/h283wHKNMyMAtYfydRCzv2BDkJ+MjD3FzZSzzb56WCBhdCYaFaPoujcmotRk3S3PofJgxFM6XDuYOM0/nTxi2itbyQJYrzHwz03HCzvgsyyVHWeOCD6ALl6iCiQWB/jMlr8ieRuRNVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=lv26I2Xy; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M28eW31473070;
	Wed, 22 Oct 2025 02:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=+kQKwWlHD0KEJH+Nb7OHDeBVYcPh1DbK+sA2XmbQ/5Y=; b=
	lv26I2Xy9JEpOTQoB9Fbr7S0s8G+oxVlOfe3AcNel9urx9RRreJZid3P1RQYfp1u
	j7SRaY9Yb07FagHVGD1FlgW4LafOGFGP15QuEOA4Ulo6VrdeH/6nn5U4bU2OqeCZ
	X979x+nTbvkh0JWl4KCGiY8L77gY8Th3ibpeh3INb0hWYAxnxN+4LA+fXeek94lF
	chxoN9mrD7xu3E4LVbTYRnV43LTC5OeGAXPpI1G02cnDYMFabkkS/gYp65wfs3tO
	c4GUH9vHYlb4BrWjgp6w1v8ryd2jxkKtKtEcZM8JwxZjFisV6cm0YeLSOF3lgzj5
	P2kCLDNQJIThlJWDUfs4tQ==
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49v1v5c2jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Oct 2025 02:29:42 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Tue, 21 Oct 2025 19:29:41 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Tue, 21 Oct 2025 19:29:38 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <kuba@kernel.org>
CC: <ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
        <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
        <lizhi.xu@windriver.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <samsun1006219@gmail.com>, <sdf@fomichev.me>,
        <syzkaller-bugs@googlegroups.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH V3] usbnet: Prevents free active kevent
Date: Wed, 22 Oct 2025 10:29:37 +0800
Message-ID: <20251022022937.1799714-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021183252.2eb25aac@kernel.org>
References: <20251021183252.2eb25aac@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDAxOSBTYWx0ZWRfX0qxcADagfoWs
 goQgINwrKOZEMyI5LGqI0cNEsOTsiwLx3ipocOPOFSbYUgy8HWibMoRwsSZc02/DeoOAR3XL870
 uwWSo/yMulFZSxiyAtAX5H5sSBqhEx547fVVXyTVHkJ63itCipwXzREUaUp+ZF4FfgYDDIHFWiD
 OqMsXCo9BSuGo/Ub1m1E/g3frWBUfho0E0ieg1wv1BWO3FcqQCazeJ2gly9LhoqeFWR9g3KfWpE
 H+L/kUzaz/LO6W8cgwjdWkfydBjx7OKwGICkkvvSBHBt77l98FAIdcVMBRwMYPKBpre/wuw2vFG
 kjzLHN/3OtPbmbvlrFe7Xn6Zkug8R+DkCYi+luPAgMjZDsOq2P0WVVb+jAygHsUnXU1PuGhHZh5
 pMlX1xaqtPl6zCvxg2x4x22xaLIMtQ==
X-Proofpoint-GUID: PGjGzVj_trjw-qXofp2AK8DxyQp3spUB
X-Proofpoint-ORIG-GUID: PGjGzVj_trjw-qXofp2AK8DxyQp3spUB
X-Authority-Analysis: v=2.4 cv=ANdmIO46 c=1 sm=1 tr=0 ts=68f84196 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=AM3EBoPtxtKq-eUOr5sA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510220019

On Tue, 21 Oct 2025 18:32:52 -0700, Jakub Kicinski wrote:
> > --- a/drivers/net/usb/usbnet.c
> > +++ b/drivers/net/usb/usbnet.c
> > @@ -1672,6 +1672,9 @@ void usbnet_disconnect (struct usb_interface *intf)
> >  	usb_free_urb(dev->interrupt);
> >  	kfree(dev->padding_pkt);
> >  
> > +	cancel_work_sync(&dev->kevent);
> > +	timer_delete_sync(&dev->delay);
> > +
> >  	free_netdev(net);
> 
> Is this the best spot to place the cancel?
> I think it may be better right after unregister_netdev().
> I haven't analyze this driver too closely but for example since
> kevent may call the sub-driver having it running after we already
> called dev->driver_info->unbind() seems risky.
I agree with your analysis. I'll update the patch and release a new version.

BR,
Lizhi

