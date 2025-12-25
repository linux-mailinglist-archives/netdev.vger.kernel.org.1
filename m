Return-Path: <netdev+bounces-246050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16913CDDA70
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 11:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4935F302D908
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 10:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589DD31A7F5;
	Thu, 25 Dec 2025 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q6oQIgN/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F254431960B;
	Thu, 25 Dec 2025 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766658258; cv=none; b=UvSqARepivbaUijSBiVjBu1V4/fjZqQuyVaMFFFiuR8X3AmxVQ6dM7HtDhUwc/xGOcg0FS4PN0qf8+O4iVkgyMBopLViwAUnOCQ5UygMwLBPe/7bE/H+wtvuOOZqzTujeAB9AndqfJ6dZCMzSzF5YijLkenffOUn29KaqN8S/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766658258; c=relaxed/simple;
	bh=rkKsCN8GZKPcWF0t5jLapxBcgdye6KwO+rLjihBRFWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6WM5qKitYIBV35AxqJoEbTl1lRPfpnsJ0tGuB/ZsTv1l6lJkNt99LA5V3xL7aUHwHlIpsWHVw00GZRMmN0Sj2XYSZM7nhRzuJ5KlsnETBKuZF7PwxwR0J0O6/7DbGScFd+Z8SOli/SYZ0OjLC8ZnY4fhaZkf//ofsh+lfUz23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q6oQIgN/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RLZ5dp7ZF0ShvKw+eCUkjiwp3M5NbJucFJVtzDcWMmU=; b=Q6oQIgN/eZS8wpunWL02wfB5uv
	Th/cu82a2kEIYbe4q3x+QGs3mS+kbCEwy8nzxT2h4LurjO7ji3EDh/omMoWxsuFhW57gG2GvPzrUv
	ZE8H2fRdR5rPnG3JE9Ag+ftrzxqqyMOT/yV7O9SFgG1fJlmk075NGQbuTiNQIDe0gOkw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vYiVI-000W0A-RB; Thu, 25 Dec 2025 11:23:32 +0100
Date: Thu, 25 Dec 2025 11:23:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yao Zi <me@ziyao.cc>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [RFC PATCH net-next v5 1/3] net: phy: motorcomm: Support YT8531S
 PHY in YT6801 Ethernet controller
Message-ID: <6b0b5ce1-43f5-4652-b7ba-c03ac277fe1f@lunn.ch>
References: <20251225071914.1903-1-me@ziyao.cc>
 <20251225071914.1903-2-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225071914.1903-2-me@ziyao.cc>

On Thu, Dec 25, 2025 at 07:19:12AM +0000, Yao Zi wrote:
> YT6801's internal PHY is confirmed as a GMII-capable variant of YT8531S
> by a previous series[1] and reading PHY ID. Add support for
> PHY_INTERFACE_MODE_GMII for YT8531S to allow the Ethernet driver to
> reuse the PHY code for its internal PHY.
> 
> Link: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/ # [1]
> Co-developed-by: Frank Sae <Frank.Sae@motor-comm.com>
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

