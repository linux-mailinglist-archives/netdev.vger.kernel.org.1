Return-Path: <netdev+bounces-112380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91267938BC2
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 11:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6A4B2110A
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91DF1662E7;
	Mon, 22 Jul 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dzmm2rB7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8DF161311;
	Mon, 22 Jul 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639447; cv=none; b=ubBCceRoH/DhWyE+lzJH8+CAToiqoGsDJHfrraU4ZNF+ZErO2BJ8iafmHxL8ubsOuMP+44B4KlvG5ioIMvz0qJfStSltjXYTCQmHO73d+fYOas9MvaTmSBNmlQ9wZIsl1Y/I3R9R6ungcaXsswa6JKo/MNBu02mZF/jYtw+Ixr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639447; c=relaxed/simple;
	bh=F5XBAe/GKrCj0xLEXgFxWDYnSZgfCE914QJJeyW8fc8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIUD50j1vvWZrLLK30jC+Lw6v3LEwwN96fvqoqzEhTiANHFf/NnajNdljAIheRzmHL8+/u/8ojcUPavqJxXcpwB9ZFGkrEDoIn32CWw70xjL+u32ycq1reNQ7q87r9RmrbRNFgmYTRLoB0xjHi+MvdVK+LpAuQpmQMgGB9xslWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dzmm2rB7; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7wtTW005443;
	Mon, 22 Jul 2024 02:10:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=UZ8qbwV8H5Uru+28S5SaGf9Al
	hy/rbNI7CI4WhPzKlU=; b=dzmm2rB7zo2tr5pLB+fubm3C4F6L+MIp6nF8GXX04
	iNvpNVXVUgJWJvk/hBTfDvo3Vg4tmnyR7vFcRV4//Gnk6jGloxEvfVMr+LG4jEEw
	wxSDKEUJCZM1rKOaGzn0hm/UkdpjRbr3pnDUuCHyR3iVl/6aGVoFhLc3lneECGd/
	TNYqYgoqztuERvV0GYvJt8y3e2A7AmA06dcOgZVQdrf4CtEsQX1QA0BXgMRjoTqw
	J25xtF2PNgH9FF56Vj0VYemw/a/WCVeW7297NaUk8soVQS7MPe96oPcYCET+HkS+
	L03Fssg9crdG1WBhbk6HsMuLkbydqsrbETSKCF6U12w8A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40hkgrr6yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 02:10:15 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 22 Jul 2024 02:10:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 22 Jul 2024 02:10:14 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 971D73F7041;
	Mon, 22 Jul 2024 02:10:08 -0700 (PDT)
Date: Mon, 22 Jul 2024 14:40:07 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Alex Elder <elder@ieee.org>
CC: Andrew Lunn <andrew@lunn.ch>, Ayush Singh <ayush@beagleboard.org>,
        <jkridner@beagleboard.org>, <robertcnelson@beagleboard.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Johan Hovold
	<johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <greybus-dev@lists.linaro.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] greybus: gb-beagleplay: Add firmware upload API
Message-ID: <Zp4h72rWwgnGmvcP@test-OptiPlex-Tower-Plus-7010>
References: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
 <20240719-beagleplay_fw_upgrade-v1-3-8664d4513252@beagleboard.org>
 <Zppeg3eKcKEifJNW@test-OptiPlex-Tower-Plus-7010>
 <b3269dc8-85ac-41d2-8691-0a70b630de50@lunn.ch>
 <e7e88268-a56b-447c-9d59-6a4eb8fcd25a@ieee.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e7e88268-a56b-447c-9d59-6a4eb8fcd25a@ieee.org>
X-Proofpoint-ORIG-GUID: uf0FV3BztW2j4yQ85RZegmP76Gjj-a41
X-Proofpoint-GUID: uf0FV3BztW2j4yQ85RZegmP76Gjj-a41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_05,2024-07-18_01,2024-05-17_01

On 2024-07-20 at 03:09:55, Alex Elder (elder@ieee.org) wrote:
> On 7/19/24 2:15 PM, Andrew Lunn wrote:
> > > >   drivers/greybus/Kconfig         |   1 +
> > > >   drivers/greybus/gb-beagleplay.c | 625 +++++++++++++++++++++++++++++++++++++++-
> > 
> > > > +static u8 csum8(const u8 *data, size_t size, u8 base)
> > > > +{
> > > > +	size_t i;
> > > > +	u8 sum = base;
> > > follow reverse x-mas tree
> > 
> > Since this is not networking, even thought it was posted to the netdev
> > list, this comment might not be correct. I had a quick look at some
> > greybus code and reverse x-mas tree is not strictly used.
> > 
> > Please see what the Graybus Maintainers say.
> 
> Andrew is correct.  The Greybus code does not strictly follow
> the "reverse christmas tree" convention, so there is no need
> to do that here.  Please understand that, while checkpatch.pl
> offers good and well-intentioned advice, not everything it
> warns about must be fixed, and in some cases it suggests things
> certain maintainers don't agree with.
> 
> 					-Alex
> 
> > 	Andrew
> 
> Ok got it. 

