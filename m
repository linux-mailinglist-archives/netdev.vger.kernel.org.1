Return-Path: <netdev+bounces-82228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1205E88CC30
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 19:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C141F81C34
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 18:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFCF129A6B;
	Tue, 26 Mar 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S/y1RtGw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C945127B5D;
	Tue, 26 Mar 2024 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478699; cv=none; b=ib9E//2E/ZmZJO7+Fpc191MSpqcwCkLyVtpKY7OVxtSX5dDFbZF2CTtotVwgLroJKFxGk5PiQ/bbpHoa9cHwGY/FXtWaUT3CzX00jXQE+oKcY+pmmvU/zeBqKfihwTHwWaeuS0Mc31wNXJT+U7UYnjSH9xsr4ANsxNLGjqYhxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478699; c=relaxed/simple;
	bh=W3C2kFjGVfAT4/bijkgkE41Mz601YGF6iG9K9t2q/cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKMVKgkPd/ZZENyfwLxNp889QjIZIova/piQa29qdPCzWHLXIDWMwq/56aKhmr/GZS4GbKmE7kc3qKoDCgQ9Gx02WVLdFeEHsvBM8NgUlrMDMlcWT1e071i0HEEVFd/8ybu1yAMy88w0mT97a+F+TKK1pbVasATQWep2xWGXs6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=S/y1RtGw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/SgKl960Wcx3odOWxbVS88Iu4QakXKkcVHwhd6njhE0=; b=S/y1RtGwwszjjUFseeQQf3hh/7
	OtmMZhN/qjSPF4NS6LNk8hxa2xU+LsDLqkGF4m60fNoMwcBntUwEGRKxhDTQUexJt8vx/iNIbo46v
	ff4dBA93tXiD2VKIXhcO/Okba8tPXjJ8TRoncoolUIQGg4nVEytlTEKPzqZzQR+9Ir3k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rpBmr-00BJmD-Bg; Tue, 26 Mar 2024 19:44:41 +0100
Date: Tue, 26 Mar 2024 19:44:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <8906b980-1330-42b7-87ba-daff70bad8f2@lunn.ch>
References: <20240326162305.303598-1-ericwouds@gmail.com>
 <20240326162305.303598-3-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326162305.303598-3-ericwouds@gmail.com>

On Tue, Mar 26, 2024 at 05:23:05PM +0100, Eric Woudstra wrote:
> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The phy supports
> 100/1000/2500 Mbps with auto negotiation only.
> 
> The driver uses two firmware files, for which updated versions are added to
> linux-firmware already.
> 
> Note: At phy-address + 8 there is another device on the mdio bus, that
> belongs to the EN881H. While the original driver writes to it, Airoha
> has confirmed this is not needed. Therefore, communication with this
> device is not included in this driver.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

