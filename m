Return-Path: <netdev+bounces-145041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E4B9C9307
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F74B1F22696
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B684D1AB52D;
	Thu, 14 Nov 2024 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WBLrvnNL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C043E1AA7A5;
	Thu, 14 Nov 2024 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615244; cv=none; b=UlvsIHEyAEW0ilimwTNFtEdP12wTyUu+1dWlhdOnEw3jwd88ul0ShBKYX8TT7lgfpDHIb9jP0x0Ufx4jZ6UOJky5sWBFjlRa7oZE7mrLq0b+O0udnNZYZZ6EAtvAgmCQtPuw6Q5oSl/Q4SgVqkJIhqecBrER1CS5b+SCN61LQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615244; c=relaxed/simple;
	bh=P+p6Pjb+uEt0r8Z6NLderctJtIyamvHJCKXmrP0Zb9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta34pnNsE3g0tK1v7Q658oUz6ZnZMrz60AF5PrQ3hU8dlYx278rpw9eMZYeyNixexLboZQxqHLMG3N9Pz0dy8KyrNLqy7VzPQxfAtYSZy5Po9ZKcOJbVMhu9ceau861bmF8rpHtNC8ymrzBOwIw7LI4zoMxBT8YkB+wJYiSBUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WBLrvnNL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0++6dXAVCPi0KZyO/XBAzaiP8kdzMGhTrgoNcuxSRqU=; b=WBLrvnNLWXHBVmnBfpPazf9cJ3
	02yOKopTgZbBpAwsPq6jy821kjynjCDShFw9ZGxk3deGCCXSov0yHzb4Cd79u1Y1WnYfDm+Smrqq0
	SyzMStcezzCnHh2QtrthTTtYDu3+tExYDFyB5pbb4Locva9By/kODSttLa4+9gI6X8WQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBgDv-00DLAF-1A; Thu, 14 Nov 2024 21:13:51 +0100
Date: Thu, 14 Nov 2024 21:13:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Russell King <linux@armlinux.org.uk>, jacob.e.keller@intel.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 8/8] dt-bindings: net: sparx5: document RGMII
 MAC delays
Message-ID: <29ddbe38-3aac-4518-b9f3-4d228de08360@lunn.ch>
References: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
 <20241113-sparx5-lan969x-switch-driver-4-v2-8-0db98ac096d1@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-sparx5-lan969x-switch-driver-4-v2-8-0db98ac096d1@microchip.com>

On Wed, Nov 13, 2024 at 10:11:16PM +0100, Daniel Machon wrote:
> The lan969x switch device supports two RGMII port interfaces that can be
> configured for MAC level rx and tx delays.
> 
> Document two new properties {rx,tx}-internal-delay-ps. Make them
> required properties, if the phy-mode is one of: rgmii, rgmii_id,
> rgmii-rxid or rgmii-txid. Also specify accepted values.

This is unusual if you look at other uses of {rt}x-internal-delay-ps.
It is generally an optional parameter, and states it defaults to 0 if
missing, and is ignored by the driver if phy-mode is not an rgmii
variant.

	Andrew

