Return-Path: <netdev+bounces-160929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34857A1C506
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 20:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3EE71888858
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA92155330;
	Sat, 25 Jan 2025 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2v+ju4Ss"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2739154C04;
	Sat, 25 Jan 2025 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737832127; cv=none; b=DHmTNuTJ9Z6pE+qsfzirQ3RvI2A2e+XwKVMeZB0BKzybGTaMVomc/vcCE/UC3olB0l6AJdIZoK2ZXbC8PO1JKdZV2GhQptZPkmmMDWGTRLO03onkCxRSsWbrUSYfxz7uLD0oFO/SMhyx/rR79VZ0mTfL59NqLQiFJCtl7xf1ttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737832127; c=relaxed/simple;
	bh=00ErsArdyhStOH/QzEm+HBktG0ApssIIB+eoGYtOKk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biGbgSoWoVvPcKGyKD1djfmt1GdW8ukNfGSL0UDciCys76gucbT836sYMMh6U8/2Jsvlptxl0f9y4C45S4MoTLqZBWC2x27/xShMAbcaos7piB8rwauIwMToom4DXwGSpT1+dP9j/ht3t2TOL7ODC0KAVeddKb/xmcLaR5HQpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2v+ju4Ss; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=obzrF8Fcswq9E43yJqIugq65f/Z50UkRlpZ6W6TRcfc=; b=2v+ju4SsDiTdVKKpK7HJYAX9kd
	wIrW6FKP9mt3eNl3DnsnGQtVpN2A/M+h4vKG5Iuok9zmf614ZaybqOw6H9RXWfQ/ZF5q0g9DdAtC4
	i68eI481stsLB1+vUbTxYf++BzjSSLG4L56+Xqw1gVPx7U8JjMLFIH4knLGhcJBwsZuM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tblVs-0081uW-OA; Sat, 25 Jan 2025 20:08:12 +0100
Date: Sat, 25 Jan 2025 20:08:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, Brad Griffis <bgriffis@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
Message-ID: <09442385-573c-4756-8c30-296631bc6272@lunn.ch>
References: <cover.1736910454.git.0x1207@gmail.com>
 <bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
 <d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
 <20250124003501.5fff00bc@orangepi5-plus>
 <e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
 <ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
 <20250124104256.00007d23@gmail.com>
 <Z5S69kb7Qz_QZqOh@shredder>
 <20250125230347.0000187b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250125230347.0000187b@gmail.com>

> It is recommended to disable the "SPH feature" by default unless some
> certain cases depend on it. Like Ido said, two large buffers being
> allocated from the same page pool for each packet, this is a huge waste
> of memory, and brings performance drops for most of general cases.

I don't know this driver, but it looks like SPH is required for
NETIF_F_GRO? Can you add this flag to hw_features, but not
wanted_features and leave SPH disabled until ethtool is used to enable
GRO?

Are there other use cases where SPH is needed?

	Andrew

