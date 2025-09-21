Return-Path: <netdev+bounces-225092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AF5B8E27B
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 19:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE81917CE28
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DB01E3762;
	Sun, 21 Sep 2025 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gyvhGWpx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1CDF72;
	Sun, 21 Sep 2025 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476726; cv=none; b=XVCJZVZJPSg8SowKPO6C0gsrk+W8Bxz84A4N2sfjH6zVnOyuHJlITtZM6w31O2L3J6eCZXUcjYJMSJXcfEBW4HZvSg2q18PnbStzMxXA71ucik8wL3Dyo1zpJecKc5erCOdbJGmP2nXuEVzomuBv8omxPBk+YAxUZPWP2d/96UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476726; c=relaxed/simple;
	bh=k75h3vyn+toM45sEOSU6f34YilzE5L6BQlA1fqCp7xY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X54rc5puJDA05RoslQFp7AWhftcxrjZAAY+naizSOgzJ9bJn4o+ovHM0TN68uq7chRAktHKD6zjA2BIjuiRheXIPIu7c25+K8gtLV1OjLY6VacMczKlVXQk/5pwxtWl496Ly9mqHCeEPdyKqg8WLiBAiT2YZgZ1RlyqIq6LMhzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gyvhGWpx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LHCdpB005257;
	Sun, 21 Sep 2025 10:45:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=aonWGXZwnqaYZaf+BiWo7j+Tw
	TEIN8skrepV3igixHQ=; b=gyvhGWpxt959FXJSxKfrxxeS0Z0t+Jb4WZvmuqBnZ
	Zk4kl4gdeyN99H0r9RiI8+5yrVIvrHduwoCCD75QAlqttgYhik0Jx2e5swoOGY2Y
	8u4xoSRIUdoQgxv5YriNYW4T2Bwq1dg+vUM0I4OSjZTx8tm0IJsdffuHD7Vs3xj5
	55ChVBcWrKC+/dnKokR4rUGgPpRbxoK3ee4jFG4qPZ+9AtD2YrG8PYrIAOpC+Jyv
	ddqDs79vUcqy3Vx6RTxE91d6rlGmrkm0TWWBOlCG9zpzmGewXglDnt2m2KhG5D9v
	9ONasHoQkXdVdrP43eLd4jPlljgWWj5ooEV6e2yTOvzEA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 499ushspwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 10:45:02 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 21 Sep 2025 10:45:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 21 Sep 2025 10:45:01 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 2D2A23F7054;
	Sun, 21 Sep 2025 10:44:56 -0700 (PDT)
Date: Sun, 21 Sep 2025 23:14:55 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: Re: Query regarding Phy loopback support
Message-ID: <aNA5l3JEl5JMHfZM@test-OptiPlex-Tower-Plus-7010>
References: <aMlHoBWqe8YOwnv8@test-OptiPlex-Tower-Plus-7010>
 <3b76cc60-f0c5-478b-b26c-e951a71d3d0b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3b76cc60-f0c5-478b-b26c-e951a71d3d0b@lunn.ch>
X-Proofpoint-GUID: Fb52pkH_ZKHVdVK0Y7YK0n4kew_kvhEH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDExNCBTYWx0ZWRfX2Eqsu/uK1nE5 bhgwDNlhF/rfQs7ciGnj4Cpp21JTClZp/s76FcJ1mQyjbh7SAJe/6sA67dbkBXRRZzrRs2i+q9i XtC14nXt71AAZ1Zxfa7v3HagQsASSjBlD5RFL8Lkh6sWlLbjyiySiRaOYDxUFOla+U+n6bBf6Jt
 2gImYntzv4ZUDA7pU9FOHHiLPcJBdcAlr1lo9MGBvxup3gTDs0RVUPVb5kXbsAFhGURG8MRAZIi iKLJS+lCL42mlDhp7zSzqaeLxfs8QCZfEwjTsDEZhE9XR4n6ZXmdc01lhVeI9g/0I46QV5y0m3v XyP0eKtEsYKNEcc1Ni4IaZV40aTWvjyIWafms2DV8aaiajh6SbzMhwUkbz73NKlfjwcyxvIVehg WYgC8ysa
X-Authority-Analysis: v=2.4 cv=auayCTZV c=1 sm=1 tr=0 ts=68d0399e cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=hxte4uG_x_hChuEVWo0A:9 a=CjuIK1q_8ugA:10 a=quENcT-jsP8hFS3YNsuE:22
X-Proofpoint-ORIG-GUID: Fb52pkH_ZKHVdVK0Y7YK0n4kew_kvhEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_04,2025-09-19_01,2025-03-28_01

On 2025-09-16 at 22:13:20, Andrew Lunn (andrew@lunn.ch) wrote:
> On Tue, Sep 16, 2025 at 04:48:56PM +0530, Hariprasad Kelam wrote:
> > We're looking for a standard way to configure PHY loopback on a network 
> > interface using common Linux tools like ethtool, ip, or devlink.
> > 
> > Currently, ethtool -k eth0 loopback on enables a generic loopback, but it 
> > doesn't specify if it's an internal, external, or PHY loopback. 
> > Need suggestions to implement this feature in a standard way.
> 
> What actually do you mean by PHY loopback?

The Octeon silicon series supports both MAC (RPM) and PHY (GSERM) loopback 
modes for testing.

We are seeking a solution to support the following loopback types:

MAC Level

Far-end loopback: Ingress data is routed back to egress data (MAC-to-MAC).

Near-end external loopback: Egress traffic is routed back to ingress traffic at the PCS layer.

PHY Level

Near-end digital loopback

Near-end analog loopback

Far-end digital loopback

Far-end analog loopback

We need suggestions on how to enable and manage these specific modes.

Thanks,
Hariprasad k





