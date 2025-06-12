Return-Path: <netdev+bounces-196805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EB9AD670D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 07:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAF83A2EC7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 05:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E331C84CE;
	Thu, 12 Jun 2025 05:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="PG+913EB"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050E1AAA1F
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 05:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704550; cv=none; b=uMti0BB/H3nSTdnLx2HK0WUcwRXCZzQIeCLikvxisBMB6RcSL8/90K8jx4GnSFnZk/afupfkB9msdhhXqiHQ+x58/+Z3R+LaMhYacKn6Ud9xEyrq74FzRKwticNftsXh/LGSoP8AvSCLnQAS0dzjOXxDVTI2iYXxHHn/dqzqo0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704550; c=relaxed/simple;
	bh=DpUIxVDwXwPki7W4efTic4e1QI+t9zRuxmDntrBxCzw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiLSIUHz67zHBRtKxU2mZ3FMgXp4/y1t+cXC7+jTwpgFzFFh3xu8ReRA1wm/xhMx0eQ9PAPjghVjJAkm8cHhWmtRNY10gJ848o5M0cjlG7B65p0gezzVQKy7lFC9o6Rh7qnNSOzUS7Q053leGvXSRDv4NPun9f6PyaUzvaATvvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=PG+913EB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B252020728;
	Thu, 12 Jun 2025 07:02:25 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y_3StHxjh2JR; Thu, 12 Jun 2025 07:02:25 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 3805C2069C;
	Thu, 12 Jun 2025 07:02:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 3805C2069C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1749704545;
	bh=DpUIxVDwXwPki7W4efTic4e1QI+t9zRuxmDntrBxCzw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=PG+913EB+iY0MgZhWhcgUOaLoWL07BhgCdJGYmwmdw0byJRgdeEWDkN8A1umk158L
	 NGflkjrGHsOKOb/zVCmwn8vHZ8Rst+HcrRpLvscKsJBFPz7PX9c1GN9LjxVrUnHTRU
	 Xx+2a7s64dku5kENMwe6/GzNasm4aKmE01Jk6T9twlOanejrrS6YQLXEIbzvV3gG9K
	 erxENH4kof32V+IBkaBR2/aJAEuIeV0R6UFPq8vhwB2cP+ZdHcawLmnsKsfwBTuvfC
	 XlE0OvdnM3vFMlK/KEM0txwMVOA+InRNcxMa4TmiTx43eITr1TPcu/xzZQ2bBhPaY0
	 kXVp4QOBTPzBg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Jun 2025 07:02:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 07:02:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 703883182B55; Thu, 12 Jun 2025 07:02:24 +0200 (CEST)
Date: Thu, 12 Jun 2025 07:02:24 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Aakash Kumar Shankarappa <saakashkumar@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, Abed Mohammad Kamaluddin <akamaluddin@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH]    =?utf-8?Q?xf?=
 =?utf-8?Q?rm=3A_Duplicate_SPI_Handling_?= =?utf-8?B?4oCT?= IPsec-v3
 Compliance Concern
Message-ID: <aEpfYEgDvEqVfOOo@gauss3.secunet.de>
References: <20250609065014.381215-1-saakashkumar@marvell.com>
 <aElfx2P9VBN/q0A6@gauss3.secunet.de>
 <BL1PPF236BDCF3EECB8A4EA9D923CE2A0D5DA75A@BL1PPF236BDCF3E.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PPF236BDCF3EECB8A4EA9D923CE2A0D5DA75A@BL1PPF236BDCF3E.namprd18.prod.outlook.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Jun 11, 2025 at 11:39:59AM +0000, Aakash Kumar Shankarappa wrote:
> Hi Steffen,
> Thanks for the review.
> Agreed. As per the RFC, for unicast traffic, the packet is looked up in the SAD based on the SPI and optionally the protocol.
> Since the protocol is optional and no existing lookup incorporates spi + protocol , I used the closest available function — xfrm_state_lookup_byspi(). If you agree, I can add a new lookup function that matches on both SPI and protocol, as shown below.
> Let me know your comment.

Yes, something like this should do it.

