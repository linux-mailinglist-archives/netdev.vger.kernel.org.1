Return-Path: <netdev+bounces-114307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D732E94217A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB1B28449A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB4D18C90A;
	Tue, 30 Jul 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gVC1yRa/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143961AA3DE;
	Tue, 30 Jul 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370641; cv=none; b=sMkp8sQtRX2PtAoFq7Ab9FbMYsYAX7aio1QHg8jeFK6zTLxWgzVlXSbmFbw3VRLjlPxYSjtRR4r3Dm8PLKbA8pY28C95mJReeNkVLeqrPVjRbhEhIjOhS45frSpA6qAVe/bxIVAIZ0PpOLceVhL/zmGlO3JlhlVGia2l+yPK4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370641; c=relaxed/simple;
	bh=gF3lfL6j+rF5HMLG0BmJKAJNwfOdOHt/PyxdqYrFHDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8wO7HiLvLOnYpLqfgRxcfNIa3BamqUyOJ4qSx+LoK6pBLDe+1pjLkIpcM9/+bFITMo3s5pXblncvveUXCb7FSkbVERUz8meRlIb9eGuSHWgxL/T3NdS5dVUIr0RR2qkOLwSO1ONdPP/9ER+5OL5qFa0Y74qLhlmrdYIpe9sl2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gVC1yRa/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=lm/VSDVZ3hXA+T+kOA2i3wv7H/4Q1WtwruXE/eLzuBo=; b=gV
	C1yRa/marQW7bc1iO5+jyKFvzTe4DF7ND9/o3vbDLpPCzalM2xmH9RbLVgPaaUZYZHJeA+xuoNc8/
	TerzIbeSHEbDUXGWyGiZLZw9B9HMXvWzVFIOFUh4Q5JqACkFJ2pLtaT0BWAwUECXj1MgQZTsC4fb5
	htKrBg9O21bO2c8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYtHS-003bua-EK; Tue, 30 Jul 2024 22:17:10 +0200
Date: Tue, 30 Jul 2024 22:17:10 +0200
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
Subject: Re: [PATCH v4 4/4] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Message-ID: <9a6a1605-5056-4a7a-9577-a26699738daf@lunn.ch>
References: <20240730091648.72322-1-swathi.ks@samsung.com>
 <CGME20240730092913epcas5p18c3be42421fffe1a229f83ceeca1ace0@epcas5p1.samsung.com>
 <20240730091648.72322-5-swathi.ks@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240730091648.72322-5-swathi.ks@samsung.com>

> +&ethernet_1 {
> +	status =3D "okay";
> +
> +	fixed-link {
> +		speed =3D <1000>;
> +		full-duplex;
> +	};

Another fixed link? That is a bit unusual.

=11	Andrew

