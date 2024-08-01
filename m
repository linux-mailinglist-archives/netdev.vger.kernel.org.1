Return-Path: <netdev+bounces-114747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD16943CB9
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFF5B28073
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 00:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C94D1CB30B;
	Thu,  1 Aug 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b3H4//d9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ADE1C9EB9;
	Thu,  1 Aug 2024 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471487; cv=none; b=kCCx4GYDIpB1e4jGrdeMm+PbEutOj2B/0AHqSS0QI62IYcQl2I3FXFddKIqZVYE8UsrE98D1Kr87z3Iibqj7NIDOtKvzuVTCmsXE0ey/kymmYEZ7VYGeFklOfNy0Wr6KJQiNv85qmzvwdK8ufU2OkgIJnlFdlz9t9/awLcFprzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471487; c=relaxed/simple;
	bh=EzrHojQbHayY1rc4Q/zx5hfkqvcJ3zN/wIqGJ5/06xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqAl1btv7obiIlVsdKJ5JXUbA93KKIKnrDT6eSmgYeQBNJjt8AYYR5ujV/+LDKZYBu0npLfZn8dPRHeLqF3p+TxWpjdLrwfTuRylf1nHUNwxDYJE1VWHwko0JYTFFlTvsRz+TIRBXizF7kmTZ8EflRrQD2MOW5hUNYRKDz0vxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b3H4//d9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AuM3/GrAXMsIi+A6go0Z7DzaZf+OKFjJLl1R8WuyiaQ=; b=b3H4//d9d9Sj9u8/iuUX6VS8hJ
	itlx2ImLOk1GIbcKJysTVZN8bH/N5E8cd0RMt/WLQ0iJ9tjJfuuWT5yAJPd7kIdFGKJajB0vQeOaG
	LYN5nVREqSuvMjHn4Y5qidUDtq4bnAAilU8lsPp8kHwn18fk3gOrVAV6B7whjF1BYodo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZJVq-003isF-Os; Thu, 01 Aug 2024 02:17:46 +0200
Date: Thu, 1 Aug 2024 02:17:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk@kernel.org, robh@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, alim.akhtar@samsung.com,
	linux-fsd@tesla.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com, joabreu@synopsys.com, rcsekar@samsung.com,
	ssiddha@tesla.com, jayati.sahu@samsung.com,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Message-ID: <62872c29-0032-4ad8-b771-d57469950c75@lunn.ch>
References: <20240730091648.72322-1-swathi.ks@samsung.com>
 <CGME20240730092907epcas5p1b81eaf13a57535e32e11709602aeee06@epcas5p1.samsung.com>
 <20240730091648.72322-4-swathi.ks@samsung.com>
 <1090d2c2-196f-4635-90a0-c73ded00cead@lunn.ch>
 <00b301dae303$d065caf0$713160d0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b301dae303$d065caf0$713160d0$@samsung.com>

> > What is the interface connected to? A switch?
> 
> Hi Andrew, 
> Thanks for the quick review. AFAIK, this has been discussed earlier. I am
> providing the links to the same here for quick reference. 
> 
> [1] https://lkml.org/lkml/2024/7/29/419
> [2] https://lkml.org/lkml/2024/6/6/817
> [3] https://lkml.org/lkml/2024/6/6/507
> [4] https://lkml.org/lkml/2023/8/14/1341
> 
> Please let us know if you have any further queries on this.

Ah, O.K.

It would make sense to add to the commit message something like:

The Ethernet interface is connected to a switch, which Linux is not
managing.

Part of the purpose of the commit message is to answer questions
reviewers might have. This is one such question.

	  Andrew

