Return-Path: <netdev+bounces-249408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC50DD18121
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C634430570A5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF3138A2A7;
	Tue, 13 Jan 2026 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="W/ZFRaPq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9D320CD1;
	Tue, 13 Jan 2026 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300156; cv=none; b=hotmAmrSrZr04qw97HzlicO6pXtBwCq6QOfpl0bl8Gse0VT7zmvb2EqYR/x+DgBgYTlt9aEbKflABnjABCPaBK+HSzjFx3ZaJWa3y2/mk812gM5+hw02d2a+q1Ey/ArbhHWRQzJH9KjQQ14EhLcX7pxsocfmZMp+ExNeH7CsbCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300156; c=relaxed/simple;
	bh=958uEsBvuGutp4Otysod1/slf92aEhG5yd9rySa1xEw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVQSu75ZXFu/BZCe4ZXY92pXqCj/DouEuirpZvKxoDlyxSl0hcvMZsz0Owpfbj0YJajgFwwBt2ujTJEs8DMGPBEYQJ6ZJ5Cp3QM1xhvlFIW0eK2x3mTNy9sTCuM9nhIPOd6DrAygbYC23vey5QQutZosuO0XgFYqKc6V2ziNmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=W/ZFRaPq; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7Q6uT3356404;
	Tue, 13 Jan 2026 02:29:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=6l74VBKYhLftVG1FnNPpQ/UmX
	VY2GiQrvbYNW+WEX6I=; b=W/ZFRaPqrvJLkxE+EPu+lLpLm+8WrlfXzP/atGvvz
	kgBC8CODGthLmqPq1t2Kh+bmMzvBAXsSn7+JF/+Jv7ELVvXZmzHuGvQ7dsF6B9Dm
	JlvP3siU1cE1o4K/iLyuKqz2DLKzE6o40EL/NwuhSVqiKjKIJc+4OcI1cQvi+rN0
	qFerT2MYAYjU8xbG5yzLFHWZZxL9ukzqes2f377TWBGmahcdDcVkow7kabxAhkuD
	UYq5I5msqJQ5RctDb+BGrCcmbZ2kZ5RNZRJDg3uGQGrNgbId2gLN79Po120uWkEv
	r85z8HVHmFpIv1Ujr57VbSn3SIPckvxOgjzG2O8wtcglA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bnd2g8u0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 02:29:07 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 02:29:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 02:29:29 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 724F53F70BC;
	Tue, 13 Jan 2026 02:29:03 -0800 (PST)
Date: Tue, 13 Jan 2026 15:59:02 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v3 01/13] octeontx2-af: npc: cn20k: Index
 management
Message-ID: <aWYebi6adm9zD2gB@rkannoth-OptiPlex-7090>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
 <20260109054828.1822307-2-rkannoth@marvell.com>
 <20260110145842.2f81ffdc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110145842.2f81ffdc@kernel.org>
X-Proofpoint-ORIG-GUID: ZHa9bP1GM6OLGE3gT6hjLSzwwMISkGFK
X-Authority-Analysis: v=2.4 cv=OvlCCi/t c=1 sm=1 tr=0 ts=69661e73 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=qGgK2Hk79BvTSmNXD5oA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-GUID: ZHa9bP1GM6OLGE3gT6hjLSzwwMISkGFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4OCBTYWx0ZWRfX3trGGrcMc/Zz
 y64+z46OJD02KVF6+B//x6giq18au3P0kenfdXDyDkBYDIO/4oLHxv+pyVGegykK8vPI7dRbLIo
 ghiYtsiSeSQrbR0EQaCuN0rgely2TJp29bKbjTS1ndNZJv1bwGctlbXlqJ1+etviFwvTmlesTRQ
 /DsZgiQhUNMeN88o9MRsGzLq38UQm3PiD76Yd7NLF9TbLaQUQO3hGz/8TTR8Rlq2Z8aZ2kKIaiR
 2+vNS3p/JheqwDtsQ6YnYObAInBGMj/BQZZaoPMbRi6RKqWEg2bMSnLgCWbnqricSpyhsoDk3Es
 7oVXPPJRCN6EF1MvSAI9Vijr6h0+Aqg2qVxTEnbrAYOPIqGtXuYB8X/RKZSlaeNqVdXxfsfSrti
 jYP9HIfIH8BRze0OU7Q7PXJL8UBmlTO8NeHiC3ovhbbCep6hftdeBHYKqdt9MSmCIt1inCsftgW
 KbwxdpucYPcNrLmFvRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01

On 2026-01-11 at 04:28:42, Jakub Kicinski (kuba@kernel.org) wrote:
> On Fri, 9 Jan 2026 11:18:16 +0530 Ratheesh Kannoth wrote:
> > +static int
> > +npc_subbank_srch_order_parse_n_fill(struct rvu *rvu, char *options,
> > +				    int num_subbanks)
>
> Please avoid writable debugfs files,
I explored devlink option, but the input string is too big.

> do you really need them?
Customer can change subbank search order by modifying the search order
thru this devlink.

> The string parsing looks buggy / missing some checks for boundary
> conditions...
i fixed, review comments shown patchwork AI in v4. We are in the process of setting up
AI tool locally and run it.(Not yet ready).

