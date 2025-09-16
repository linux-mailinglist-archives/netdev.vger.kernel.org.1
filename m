Return-Path: <netdev+bounces-223484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFFDB594F8
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC7C4E0E18
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A01D2D7397;
	Tue, 16 Sep 2025 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iAhOZc7j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7787E2D6E64;
	Tue, 16 Sep 2025 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021566; cv=none; b=TrIjralx9oO1jgWO9u0xJzS9JSTTSrkaN/J7Xl6UF1N/c2hPTwCDSq3B63CTW1B21O2SQNT/Obxznz8JYyYZPCQMSK7kmHNrsHdmDhh+/v/L0Kp7/Y214kl8iKomPUhtOPGoHyby1+HzzGAAbLp27BUWm2rw2s2pEHJL/fy2e7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021566; c=relaxed/simple;
	bh=ZkEUkqP6FZBlXHDVGb/IKSKdn6/DO0jUbBztVIUKexc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FmOpVHGbadaeFgYboQqKFo3VwC8At2+WeHblw8yZpNzlSbH43tz2RCzevx/4xC/70I9+QSngjydkUmH+EDH2P+bLv5BIG1PrvQ4nSCc+fXcsHbBJc9oISyIlpddpapn448q/06F/jYdUnB+Hu7VYlsWNy8a9CJ4lvq3A1Bp9680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iAhOZc7j; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GBEO7k001188;
	Tue, 16 Sep 2025 04:19:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=Ab6LVYTy3wdjdNsodU2BuvBNogQMb57VcpoD69+tAxk=; b=iAh
	OZc7jmcfoAtKTuIe75kPTRsGY9bQ/+LUnpDyF2IJC8bkI57JMeuhlYUat3pA1iRK
	W+wCJjHrudUN6jAOikspco4s0yGhCVh0BlwF6lwcEUV2K9wExM9NlMSakBK1TNcm
	T93rBFVjg1fuTunzzFkZSfDEwZ4G1SS8ALl84uaBQTx5ocSZsStjpIqTqyuS325X
	ZYNJU/5VPQ+lF6PeS1gaK3X8TOqg5/VENXB14fH+u8jx/A/ifItZ0KkAxU+rGWnD
	1QjNageV6cE70PUTY1U29kDztHFfgLOogiZciSWgydl+XZHSlmkKH4gwnF00uHZV
	l/wkLSLyCkZlm8LK55Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4976ukg060-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 04:19:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Sep 2025 04:19:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Sep 2025 04:19:09 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id D27375E6872;
	Tue, 16 Sep 2025 04:18:57 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:48:56 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: Query regarding Phy loopback support
Message-ID: <aMlHoBWqe8YOwnv8@test-OptiPlex-Tower-Plus-7010>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDEwNiBTYWx0ZWRfX5veuNGpLKakX n6LyHf6Y88IWZgqddag0rcKhZKvpfVv3lxY7T9IQAKX+CTwSMegQS9VOwR2QHmXiXvWQ5X3kKXB PzQ6fPnbqV7eAvBeq02rD9eNeU8Z0rlhS8WZVlCG3l6E2vCo0YgGNa+ZX35SmfqaP1Kih7ZZw4V
 QBEbPR1pZ4/u0f4NNSUs4gG3YIrKWJ3lYj6SlhkaKzKhig5iKlzaPXIBnxfIbGxFrWskea014UN 5tBfWDaYRcp1erPy/61eYDfYjQSXd7Pez27fQgbwKUxA+G+yj6sT83WrfAfbuWmjEUfOdN14CkL v9RZsUXoNxYpYIQ7NmcDnP7plwNDdii3zlUYvy4IwCmkzUnEkYPd4/Pr88rYS7VP9FSrD/zLfxc J82oVcTK
X-Proofpoint-GUID: N1wQo6NOJfc867ctH2CRmUh7HuymDQ6R
X-Proofpoint-ORIG-GUID: N1wQo6NOJfc867ctH2CRmUh7HuymDQ6R
X-Authority-Analysis: v=2.4 cv=deWA3WXe c=1 sm=1 tr=0 ts=68c947a7 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=Q0HHoM9fUppamqbhzqYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01

We're looking for a standard way to configure PHY loopback on a network 
interface using common Linux tools like ethtool, ip, or devlink.

Currently, ethtool -k eth0 loopback on enables a generic loopback, but it 
doesn't specify if it's an internal, external, or PHY loopback. 
Need suggestions to implement this feature in a standard way.


