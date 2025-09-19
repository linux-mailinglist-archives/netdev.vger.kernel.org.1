Return-Path: <netdev+bounces-224790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842E6B8A289
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDAE4E702A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE50311597;
	Fri, 19 Sep 2025 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="skK3Wdm1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fp1dkayW"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514293148C3
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294188; cv=none; b=kKJjnBbMJ7fIQPD1JC30iV2swyby3eW6YZo3x85AKcf/GzT3WNq6hlPGHl++EyqFoY1y9YGLqBgoF/nP6rD413YjUVPsa6ysICkDiKx+AUP9vfieOLLfaGDeXzlqb9JRKNOus3av954h1cWzaDphGs4qTCNjVwCOD5Q6gmkmt/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294188; c=relaxed/simple;
	bh=+n/iblNGj7Y18B6Y1Ew5oSCPFMViAjMlu1qCnod5KLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKlOL89TNH+FkSYX3wmZ6TlSyzCsW3P7eQ+wyNdT3aCe4ldEqPD/YIP1CXYjHf5MtmoPc8j8g3CkD/M8gh5vZGzOUQtkg3nXM+/yxgvfNxdMwgkpQ4ngG/Vc/xYLWHy6yRC3cOw084+YOFiVC3AWjnkKPDm9FzxXU+c4L9etEqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=skK3Wdm1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fp1dkayW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3669B14000D8;
	Fri, 19 Sep 2025 11:03:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 19 Sep 2025 11:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1758294184; x=1758380584; bh=hfNLlqj1sWO8mO3nDoYG41w3rzr/iqt1
	jxuqP6W0nHI=; b=skK3Wdm1eap8+niowJ+Z7UKz8Os+xzY+gwF0LqbGjEbUH7pD
	drftn+90M+aPY5h+b5W2dwNuqt4Vd4ar1SCk5ZzBMmuIZv8Kd8aOJsXlAe6rDuZX
	b3XCLB2B8dTUBXPXJVW01HvYgIC5ZvHHCo/aTpn6BJNQKb0OQ67Cdzddc43b3/ME
	GW3y7xPvnoFp/8hn3txbhnNQigGCoaXi3f93uBhlt0a//1g/fzHKksevgkMuABS5
	mguhar6tfGBPy+pZdP1WRCBrcC+lAApAchKPrP9xwS4rOQkYOcZiCsOMVxNP7Wqb
	hQUJrgoXEX72iDM/fyrfSjaZnsro8uwMgSOcpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758294184; x=
	1758380584; bh=hfNLlqj1sWO8mO3nDoYG41w3rzr/iqt1jxuqP6W0nHI=; b=f
	p1dkayWxnclMCi/rdxBVxcc7wwij6HnFD3YeOsPZOisgYsgdP1coMFZJJ1/29bbm
	KqH7G18apkOPvkxWR9Cr7hUNePvHU/1AsjKl9vqRe273Nej6JMS4NF2fBmFx03+n
	ZB6zHSZHWEWCYSxLaLrhmn54MTusnADA1vExqqSXUSTVhCa5pkOdk0morvsHRJgu
	bz7GURSTWTi57pX01SVTxFJ3dWKVTWBndQmDvhZUdYGoHxwOJadKIAL9cVSrZdEg
	EUKc5FOCkujTf3K53hCbphY3dRj5J/Bpa4Yxv/lZuRnUC2/D38zv3VZRs4P3zB0+
	6mc5gxbdKUKRYDIHN8qhA==
X-ME-Sender: <xms:p3DNaNKfrxSVLUZGEDQGLmJNRn58grhJaqoLFlodZjAiged1iG58gg>
    <xme:p3DNaGR1Cz_0-Dw5rpp87XCLiG3j0DVDAn-bTzcqOeuOFYkX2fZEpVpOjuaWjTecK
    3jB7LHgrFzkdPrStLo>
X-ME-Received: <xmr:p3DNaEsthRfC_dXAjbShNoQ5RfvaF7igZBFy5Bu9HJUKtivExHOx80Ysmy8G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgfdvgeeitefffedvgfdutdelgeeihfegueehteevveegveejudelfeff
    ieehledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmmhhivghtuhhsleejseihrghhohhordgtoh
    hmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghnthhonhhiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhpvghnvhhpnhdquggvvhgvlheslhhi
    shhtshdrshhouhhrtggvfhhorhhgvgdrnhgvth
X-ME-Proxy: <xmx:p3DNaPbywsvKhHNL1asEHbkscQKpdne8aIJcSk4H4Rrk5pMtLYWqsQ>
    <xmx:p3DNaCG4gy5OGU3k-XMr7aQn-WQfRW3quW7tpxkUWIRAtONdU7QSmw>
    <xmx:p3DNaLxmssrXWhfoshTT0io2MuTAUtIVMpV5oPETe8MSemNevnxNvA>
    <xmx:p3DNaMkVgDdkn44MVgMOfNXzl4rkf_Z17kIW77Ud_V76VDcd_IG0-w>
    <xmx:qHDNaID2z28D9vAOlGcnILxYcenlqQKpTciJvqqZ5IRVYUoJ8cNE16fL>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 11:03:03 -0400 (EDT)
Date: Fri, 19 Sep 2025 17:03:01 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Marek Mietus <mmietus97@yahoo.com>
Cc: netdev@vger.kernel.org, antonio@openvpn.net, kuba@kernel.org,
	openvpn-devel@lists.sourceforge.net
Subject: Re: [PATCH net-next v2 3/3] net: ovpn: use new noref xmit flow in
 ovpn_udp4_output
Message-ID: <aM1wpYP5LYhM3jcz@krikkit>
References: <20250912112420.4394-1-mmietus97@yahoo.com>
 <20250912112420.4394-4-mmietus97@yahoo.com>
 <aMlApjuzBJsHVMjN@krikkit>
 <cd8193c9-1af8-4182-8e6a-a769acfde340@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd8193c9-1af8-4182-8e6a-a769acfde340@yahoo.com>

2025-09-18, 18:29:08 +0200, Marek Mietus wrote:
> W dniu 9/16/25 o 12:49, Sabrina Dubroca pisze:
> > 2025-09-12, 13:24:20 +0200, Marek Mietus wrote:
> > Why are you changing only ipv4? Is there something in the ipv6 code
> > that prevents this?
> > 
> 
> I'm not sure. I'm not as acquainted with IPv6 as I am with IPv4. (and thought I'd hold off
> until I got a positive response about the series)

Ok, understood.

> IPv4 already has some noref xmit optimizations, so it just felt like the right place to start.

There's also some in IPv6, see d14730b8e911 ("ipv6: use RCU in inet6_csk_xmit()").

-- 
Sabrina

