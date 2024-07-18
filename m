Return-Path: <netdev+bounces-111980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997449345DA
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 03:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8ED2814D7
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 01:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0366B139F;
	Thu, 18 Jul 2024 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qg+4a0Dr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3D382;
	Thu, 18 Jul 2024 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266555; cv=none; b=h2zQdt3t2TFW4TqyIp7N70wnY0Y5K80pUFExr7nxghN69MFayVEqDGbToFNf5VAf90Gg1hKXQkjy9tuS1ie1kwqzN+BKrd6Ja1u8def7KNMR7IvvvcolsOPt5hdvmi3cd3wlQZ/Qzzy8e0hJ/4dVuJKLP1lkGE1zE4ez1PoeYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266555; c=relaxed/simple;
	bh=Na4L6/2toi2mazrcZwJ6NDf6ZOw1qpCQQrZtAM8bAOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I61icOI5Cn0ejiSWiklpHEvuDftyMt7ci1knKlSeBNRhCLS/Cq0LsfIFBe2XKD2TYel6MsvU6UPUmjiIrAHwhvWnLgV/5nz99xFvKkWDANgbH97R5F7KDSR+y92kdSsEyaocjGzXZUrmAWY/pHuX9TR6XoR0gTO1eowGFP8RaRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qg+4a0Dr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RLpti1NwU+b0zEc0uHrSUhFZqx8j/aSv23e/pp00Cfk=; b=Qg+4a0DrImLKD46yhubjM6gOGL
	0aip5KQreHe2GIC+ayU2N0DJXtQP2M623e0JGq/tLnARkYtTpf/jvTzj22uWJ18SYzd8e7bPGQ4C1
	mD6DBkbilAilTc7DUO9X57leUk7BZUyJmMWxRwHb8q5qRP1iZkh0cMajIhvQu0QP2YrY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUG3a-002kUY-FD; Thu, 18 Jul 2024 03:35:42 +0200
Date: Thu, 18 Jul 2024 03:35:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: dsa: vsc73xx: make RGMII delays
 configurable
Message-ID: <66ae24b7-37c2-41c9-a0c1-aaa2925ba40f@lunn.ch>
References: <20240717212732.1775267-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717212732.1775267-1-paweldembicki@gmail.com>

On Wed, Jul 17, 2024 at 11:27:31PM +0200, Pawel Dembicki wrote:
> This patch switches hardcoded RGMII transmit/receive delay to
> a configurable value. Delay values are taken from the properties of
> the CPU port: 'tx-internal-delay-ps' and 'rx-internal-delay-ps'.
> 
> The default value is configured to 2.0 ns to maintain backward
> compatibility with existing code.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

