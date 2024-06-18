Return-Path: <netdev+bounces-104422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A923D90C787
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15AF3B223B5
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4474014A62B;
	Tue, 18 Jun 2024 09:00:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273019BBA
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701218; cv=none; b=TvL4Yb9LRWPqvzEZ4E7x6DAkTplG1eFthRcqTP2Z044fQPLm2PeQxewqb4j5hFTE0Nw5enkZhUG6TLDAUjrbkcU01VtBJsDDiL23op0FO0zsofl+pGhrhBLjrw7Mi4POOOLEdTIFrAhm8iYFntmLqy4gCFmQ16x7eEaebxmtmHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701218; c=relaxed/simple;
	bh=GvpPYD/v96UdvdfJ3klBoL51jQdI45sxX47cLWjgwlo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NPO5VLnvcDu4I0G1P5uURT7mR5O6EfEskJ4hDB9BkYH4zHuGCqYNocJ/0Y1RskpC9GSwYdx3+VSmszhhNC56bzC+Uh5H1vEcVEOGx1hLwGl2PUkkycBt7Xo5jt4A9FoJI3604u4X4dWRxQOn8REpGDnpmSNpp8YgdxpXlQzJY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas52t1718700926t124t09752
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.159.97.141])
X-QQ-SSF:00400000000000F0FVF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 15890126120200180271
To: "'Hariprasad Kelam'" <hkelam@marvell.com>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<andrew@lunn.ch>,
	<netdev@vger.kernel.org>
Cc: <mengyuanlou@net-swift.com>
References: <20240605020852.24144-1-jiawenwu@trustnetic.com> <20240605020852.24144-3-jiawenwu@trustnetic.com>  <PH0PR18MB44741630B62B890E39814445DEFA2@PH0PR18MB4474.namprd18.prod.outlook.com>
In-Reply-To:  <PH0PR18MB44741630B62B890E39814445DEFA2@PH0PR18MB4474.namprd18.prod.outlook.com>
Subject: RE: [PATCH net-next v2 2/3] net: txgbe: support Flow Director perfect filters
Date: Tue, 18 Jun 2024 16:55:25 +0800
Message-ID: <00d401dac15d$426bc7d0$c7435770$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQH0eqJcG+ogIoRI8v7BTXwUMbAV0QIsFs7TAYcJZQixfCsmIA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

> > +	/* determine if we need to drop or route the packet */
> > +	if (fsp->ring_cookie == RX_CLS_FLOW_DISC)
> > +		input->action = TXGBE_RDB_FDIR_DROP_QUEUE;
> > +	else
> > +		input->action = fsp->ring_cookie;
> > +
> > +	spin_lock(&txgbe->fdir_perfect_lock);
> 
>  ethtool ops is already protected with rtnl_lock , which can be confirmed by calling ASSERT_RTNL().
>  Why do we need a spin_lock here ?

When driver performs reset function, it needs to restore FDIR configuration, there is no rtnl_lock.



