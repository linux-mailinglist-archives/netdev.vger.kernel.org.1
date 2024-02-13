Return-Path: <netdev+bounces-71353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE1B8530F7
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8CC1C256C2
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32C741C75;
	Tue, 13 Feb 2024 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QZ5P2C4c"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A241C76
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828765; cv=none; b=G7YwFU+9qzvxwv7Urg4KYSCaIyeJcNoOSHnMpxb9lu30XX7vdJMld0gXnIbMPHjkzkfcO+V43a/PD5o+TlF2dGbOd1sBBzZgYsVr3QNRzg5lHQnxZDhFw249tc4nDVXlDlcWOj1dca1eeJUXv6mCmEGa2yoAbl6AStyVH0I8CPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828765; c=relaxed/simple;
	bh=789bRJX8DokWAv0peYnprYx4hSWKuz/n+fUAW4gKb3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDbk09JsvxEYmSuu0/csJp/ZFLPf77CEUvDRbJN0bUYzOa7Z7g7S+u9KbCjtYJtP66bMttmO+HaZvlIn/4Vs+xLw8C73dBBMZFcOumDbDwRpccMsboGl2dUgNtl6xgRiST2fhJgknrsDGeLuZIvo+8Vd8Lh903zUy4llLl/t+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QZ5P2C4c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hZijp1YyePpg6z5mqK/wkZFbKI8gevcXQ6MAxDSQK3U=; b=QZ5P2C4cgkJcJCowE5NN39r0ud
	CFWi3i/emfvxrM1kuafpJARp7Cw0P9avlEp0/EuYAWwUmqaSa3XU7IiPaGAYNx4mfDxm/xvLXw06Z
	ETZkkJx9TA4zKxjId7uLT7yhLoSAX5Ubma5w9zndIAGoa58xxNZZcUZ8xLoxqaN2Jaes=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZsHA-007fzJ-R8; Tue, 13 Feb 2024 13:52:40 +0100
Date: Tue, 13 Feb 2024 13:52:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: add LED support for RTL8125/RTL8126
Message-ID: <9da28504-d84f-493a-9d8d-71cc11d3a168@lunn.ch>
References: <f982602c-9de3-4ca6-85a3-2c1d118dcb15@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f982602c-9de3-4ca6-85a3-2c1d118dcb15@gmail.com>

On Mon, Feb 12, 2024 at 07:44:11PM +0100, Heiner Kallweit wrote:
> This adds LED support for RTL8125/RTL8126.
> 
> Note: Due to missing datasheets changing the 5Gbps link mode isn't
> supported for RTL8126.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

