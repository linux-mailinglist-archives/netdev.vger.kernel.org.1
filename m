Return-Path: <netdev+bounces-246349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB6CE9831
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 12:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7403E301B2F7
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4D6293C44;
	Tue, 30 Dec 2025 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BPSqJZYs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE97324729A;
	Tue, 30 Dec 2025 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767093107; cv=none; b=sV2qrOkZtjhsvTX2Ou1UCDDv1P7MBCr5kUqWxVRpbdk5KX8bFMQTrxNjNZKXmpSQiWNizE6r5ly8aEDQN+rlHttQ8PSGwqG2VzCgpkahRnc/6j9+xzAixDyL0k142YNCTnH7UUrj8ZNTyY/rLqX3poAW9LjkExLa3gl9KBWMb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767093107; c=relaxed/simple;
	bh=9nNpEvlyk4wBnCZes+CfZOPBzdToHDZkf8fgqdWsK8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMpkxbW3ZvfIv3LOK1tYp2rPdfdjmp8U5AYmGI6kR3or0Ob9qqTPX6ddJC8i/IdfEHbfO7R5uaL2l0Jd7WQ5BvAxGwBYJIkd9K12iAfVMDoivRV9AegGy+pRcgR3pP0JSyzOHuOXaoMVtJcSV5zOUQKKeTx/skIsY1RSeGav13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BPSqJZYs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q8mJjZZ+g0Ane4YM5RznnhE0rIh8fOKol1HCX6F0D/o=; b=BPSqJZYsaDZ7VTxZxtC4xtF6us
	nnjomjcgInese737gA0SIxpFBCz7H0JDBXU54soQ8qOVSs5CkVNUP9O+4a+uuggu5w1dTXvExFTl3
	PRjqdtUvdlsZscGftFRaZDTwJ+quhkt62MOip2ShMGaaaVfA1cM/CWjeCEkgxtQBiAic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vaXdU-000rjY-5P; Tue, 30 Dec 2025 12:11:32 +0100
Date: Tue, 30 Dec 2025 12:11:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mamta Shukla <mamta.shukla@leica-geosystems.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	bsp-development.geo@leica-geosystems.com,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "arm: dts: socfpga: use reset-name
 "stmmaceth-ocp" instead of "ahb""
Message-ID: <8997facb-068b-4088-b996-1c0898dea19a@lunn.ch>
References: <20251229-remove_ocp-v1-0-594294e04bd4@kernel.org>
 <20251229-remove_ocp-v1-2-594294e04bd4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229-remove_ocp-v1-2-594294e04bd4@kernel.org>

On Mon, Dec 29, 2025 at 01:17:19PM -0600, Dinh Nguyen wrote:
> This reverts commit 62a40a0d5634834790f7166ab592be247390d857.
> 
> With the patch "add call to assert/deassert ahb reset line" in place, we can
> safely remove the "stmmaceth-ocp" reset name and just use the standard
> "ahb" reset name.

altr,socfpga-stmmac.yamle says:

  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
  # does not validate against net/snps,dwmac.yaml.

Please add a patch to the series adding stmmaceth-ocp, but mark it as
deprecated, and comment that ahb should be used instead.

    Andrew

---
pw-bot: cr

