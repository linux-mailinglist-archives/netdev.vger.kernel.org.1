Return-Path: <netdev+bounces-220878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3480CB49551
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9DA3A74B0
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B46E22069A;
	Mon,  8 Sep 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W9Mo7MdW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D053A7;
	Mon,  8 Sep 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349102; cv=none; b=sAjxZNShPphER1RKCENy+EBbSx6oxWqmABds+pV9mXynuf9GCmzyMKkbxIvxr0YpZiPoS16578sSE79UHyx6bgdcwo1zNXZYb/upTRRho1qfbWrjIlXHgOEBTRpWeFYbKyWQUHC/nayRHISRHbTEGF4dIWZxuFoQ1cuz1PhEDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349102; c=relaxed/simple;
	bh=BNhOSYUA6dV025eeEzqqyBra5dstFqJVY8zkhmbYHQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ur5XhzEb6ZGvGjTgrVzFHQQZcEoAw0ottS7LyjBmb54tSly08JAUopRcbj08knmj+3bK4VeOlfyPfsj6oKZtXFnBpMiqHQNusNSDz5C2kYhzy9hVEXc+25tUZZroi202nqJCUC2P7WiheDJCVd4IqqsKIG7yIQcmz+w5BGXl4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W9Mo7MdW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LIElx5qF61apSsdG1Fx3DhG/2w7M7nxVDbU41a9FSDY=; b=W9Mo7MdWsP4e5bRYUNvEvzYlUn
	xImUsquQ2nZLKTBnAY/64ACPI0qwoUi3eMvFHmcmUa0LhS4UAboIMfE5tRfu83zkyk6nGuY0SFQEm
	zAxaBzN+3YSn8ROG2FLsbNvkyqHsqDtFMx/YTw2ph+xGD2q+MS1i60MCU1MJHUcHKgrY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uvem9-007glG-Vj; Mon, 08 Sep 2025 18:31:29 +0200
Date: Mon, 8 Sep 2025 18:31:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net-next 2/2] net: thunder_bgx: use OF loop instead of
 fwnode
Message-ID: <002d8e1a-ca2e-41e7-8751-429c2ee728c3@lunn.ch>
References: <20250904213228.8866-1-rosenp@gmail.com>
 <20250904213228.8866-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904213228.8866-3-rosenp@gmail.com>

On Thu, Sep 04, 2025 at 02:32:28PM -0700, Rosen Penev wrote:
> This is implemented under CONFIG_OF_MDIO, which already assumes an OF
> node.

I'm not sure that is correct.

bgx_probe() -> bgx_init_phy() -> bgx_init_of_phy()

static int bgx_init_phy(struct bgx *bgx)
{
	if (!acpi_disabled)
		return bgx_init_acpi_phy(bgx);

	return bgx_init_of_phy(bgx);
}

There is no check made to see if this is an ACPI node and so
bgx_init_acpi_phy() is called. So it might be an ACPI node is passed
to bgx_init_of_phy().

How have you tested this code? On an ACPI machine, or only a DT
machine?

	Andrew

