Return-Path: <netdev+bounces-157815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23917A0BDF6
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19FF1884F09
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81C20AF83;
	Mon, 13 Jan 2025 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aCiEXW2+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C7320AF7E;
	Mon, 13 Jan 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786921; cv=none; b=i7tZvNJLYWs8K552e3/rqjQ9fcTyxrT7kLBlAEQJK3ZBwzbits4XFAhxPNxEIRwZLQxO8UKMWATQQbvO/Da+eJcgYM13J/zdcuM6zxxV/qgJyeWzqVuFU1xH50nSBAiBI6CoUggh8ul+lPIhAc0R0zr9Y97G3D8nLWtG/7un3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786921; c=relaxed/simple;
	bh=EMtxf49NgMLSCpe9A6Xm6SFnlFMC2cbxKPic8lxHWPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTRGjl87A4Wu0AvgzBcyaandwR46r+woIFhVghvgpsvMkuquGbAwXRX2qUD6VrBOV5WxZBRG7CzdWJX9qyWwaxpzv9O1cYXhnarQ/MAG8i7hyV6QY5noLCN7ZDMJZxQd+ONt1bvhD4AE/EqgF6FrLz/NMr5vWtTAmozQbTN6Q9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aCiEXW2+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NJOghlU8ppSEsLnsa+7G654aZpvcnksHwQ+VO9d8IOI=; b=aCiEXW2+MU0SobXi9dTn0RJT42
	D7mHtH5qln/3dYjZVfQMZRksLtTRuL3tfH1O3LdtTyOuQ+kIpCMZZjz5oGbolHVP0eesfubaPlUx3
	0DzvvWGuxXKaPTYEwSAOTX4WENu0EFZ8iiS/aIRQ7mqCxvnPKJbC/c5eI+47inFZZpeA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXNby-0049kS-3R; Mon, 13 Jan 2025 17:48:22 +0100
Date: Mon, 13 Jan 2025 17:48:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yanteng Si <si.yanteng@linux.dev>, Furong Xu <0x1207@gmail.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1 1/3] net: stmmac: Switch to zero-copy in
 non-XDP RX path
Message-ID: <e9cacef2-1049-4296-92f4-85041f4b6eaf@lunn.ch>
References: <cover.1736500685.git.0x1207@gmail.com>
 <600c76e88b6510f6a4635401ec1e224b3bbb76ec.1736500685.git.0x1207@gmail.com>
 <f1062d1c-f39d-4c9e-9b50-f6ae0bcf27d5@linux.dev>
 <054ae4bf-37a8-4e4e-8631-dedded8f30f1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <054ae4bf-37a8-4e4e-8631-dedded8f30f1@intel.com>

> 1. It's author's responsibility to read netdev CI output on Patchwork,
>    reviewers shouldn't copy its logs.

I somewhat disagree with that. We want the author to of already run
all the static analysers before they post code. We don't want the
mailing list abused as a CI system.

So rather than pointing out a specific problem, it can be better to
say that static analysers XZY is not happy with this patch, please run
it and fix the issues it reports.

	Andrew

