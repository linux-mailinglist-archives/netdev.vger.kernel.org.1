Return-Path: <netdev+bounces-143885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604C9C4A47
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B271F22327
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 00:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE451CBE8F;
	Mon, 11 Nov 2024 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="187e04cM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFB1CBE83;
	Mon, 11 Nov 2024 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369395; cv=none; b=RuHrpCSbJTphEb2MObmY1Ih0PRXIipLJvmhHT3MNYuwADjvICyW1XkfAYeBk6vMk4e7Nm52pqgFFeDtOjwuwokRuoUXD8OEHkYvk292k4U1GfxFIODVTyw6Ma/NSDsKdF3uSyTuuswEJq+sU9TDmRdJ+K6RLbBG2qH4UAqC8dwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369395; c=relaxed/simple;
	bh=+uu2JYFO0LVK6AbWaDlISGBqWlzmGDBIEcaMLp9RxN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9kiiRoJs7q/zm7ej1NvjLLQTKJUkDuXTQ7JIKwVPpEtJt3qtM5mTzR/cEufsGbeYDbbWK7I6RTc825HSpGe4gghjjyvX2+GQm0GmTbu6RwI1Sm8b7Taj3P5cSUKxYKBtjwcbgUolhVcYROTHsyM7ZKpbnl9fKYGqAhEdqg2L4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=187e04cM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=MryA6VSFHDjqh8alDU5GvEoeFh8bEKlu6n8pBlDOixU=; b=18
	7e04cMD7Z6QrrTg8toFh4D4cJnnXj5/Duuel/TavF8d8UyiuBwfX9S/n/VPqDqHCVEQ1RUcYHOGH2
	HICcGyvhEjZkeWQmLorWtfibJl7rwymr9lg1nA6gvYXURvv6wM4sxm3c22IFsN1r+jF2U6zE2jMsO
	DX47zHvKjCsteA0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tAeGJ-00Cwe9-3K; Tue, 12 Nov 2024 00:56:03 +0100
Date: Tue, 12 Nov 2024 00:56:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>
Subject: Re: [PATCH net-next v2] stmmac: dwmac-intel-plat: remove redundant
 dwmac->data check in probe
Message-ID: <eea9bb16-305f-45bd-af5d-b14b715a9027@lunn.ch>
References: <20241111130047.3679099-1-mordan@ispras.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111130047.3679099-1-mordan@ispras.ru>

On Mon, Nov 11, 2024 at 04:00:47PM +0300, Vitalii Mordan wrote:
> The driver’s compatibility with devices is confirmed earlier in
> platform_match(). Since reaching probe means the device is valid,
> the extra check can be removed to simplify the code.
> 
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

