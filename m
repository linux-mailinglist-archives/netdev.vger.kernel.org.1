Return-Path: <netdev+bounces-192227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E83FEABF008
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BBE1BA6691
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF71C2472BC;
	Wed, 21 May 2025 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="O2zENCWN"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69016238173
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820194; cv=none; b=XCsBjUBwriSnvINfrMtQOJXALRD9I7gcTDVacxUGIiJDm1/I81hYg8oY/oSpJTJIFtKZXzvxRjGg7noH3LJEnEloSvwksnf832GdoVWylQmG53LvuQ6Xoyz0+zWH5yv2knB6Xg9+2SWPIQc08NQ+FV1HX/yDnwdpM+XmhmfC3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820194; c=relaxed/simple;
	bh=UK7aJvsqM2vH3L/OaTPjdzR9TMKipU17+D0PDPSpMlo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZw9cBVA+5woLuhYQUss2SlbKVALQLfQcBWccypcS9uU39EVtd3aji/8oJ8TgmZ7CPiwxsYtsFqDqBV3/X023GLRV4dSjMenNF8p43WtWiCe4niWg5TnG9ubEoM3aIzzO/BiaplRVBCbcYUfNUl4/CZfweilx2OWrtpwudCxuTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=O2zENCWN; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1747820190;
	bh=UK7aJvsqM2vH3L/OaTPjdzR9TMKipU17+D0PDPSpMlo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O2zENCWNntU5C0sxUO5EGTNw0IP9OBE+Ua8uXJs3sZrXom7dTPB9FFSrjmX9GVYFq
	 NmViiFfh+g8tczlJL8aJfsznKk1NMfnuQUlCZI4gK9RTAMyh4JIcBCUtN0n+QTIAIk
	 FgOkTX1E3uKOVltt8i9nxJND/QIKTDah801sMzdd6aAf4gx2M+a+ba3R8VW50BqAgB
	 YVJKblf1e5F/enmUk26Ryl+/GXtq5L2Cl1V7AQBqEyFq+ce8PEPs4TTMTNGwc6SMqI
	 tf24TSAnBDAO40BskvsolTPW6p2YQXRc1E4f6adzl55ukB3lFigJ623P0OEL2X6BqH
	 SsTGYXwL4cLyQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E3DB1640A1;
	Wed, 21 May 2025 17:36:30 +0800 (AWST)
Message-ID: <16a7ce7340db35fbbd017c142d375190849cd514.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] net: mctp: use nlmsg_payload() for netlink
 message data extraction
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Simon Horman <horms@kernel.org>
Cc: Matt Johnston <matt@codeconstruct.com.au>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Date: Wed, 21 May 2025 17:36:30 +0800
In-Reply-To: <20250521090159.GR365796@horms.kernel.org>
References: 
	<20250520-mctp-nlmsg-payload-v1-1-93dd0fed0548@codeconstruct.com.au>
	 <20250520152315.GB365796@horms.kernel.org>
	 <c41a3d3d22c078eab43f8ccd4eeef25d668fa9f9.camel@codeconstruct.com.au>
	 <20250521090159.GR365796@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Horms,

> Thanks for the explanation. I think it might be best to add some commenta=
ry
> to the commit message, as this was not obvious to me. But I don't feel
> strongly about this.

Yep, makes sense to record this in the commit message, so I have sent a
v2 to suit.

Cheers,


Jeremy

