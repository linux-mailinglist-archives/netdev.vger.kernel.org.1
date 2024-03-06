Return-Path: <netdev+bounces-77915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A83F387372E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 14:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A9E1F263D1
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CA51272B9;
	Wed,  6 Mar 2024 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="I4If0inQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545303E48E
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730022; cv=none; b=R9sq+jNm8tml/IziiQnz/WmqZAjMSass74DfhfE8HNWmw8yV2fBeMGengQ4AxYYjN0/qW9cpMal7j85xL8gztGR4bnfwQHiRKa+l8wKm6Uq/2nrcnoo4o1lEHyadx4OiUaFyDiuP3115sQvo07JBbGa9ybGarpknBGGEjFoh/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730022; c=relaxed/simple;
	bh=F6I1lpH/HVc1tXtjeMEoOyxv4M9lZjsiJNJ2Kapy8VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nivgw+6UZ39VoD1EpBqkOslFrZ2JXUim07oD4DFreQ165L/4nxuNKXaj/iRjfTiDK6JxWMVtC86qt7jAiflCDR5yd1FHrhqM7qum3U86nrKshivJ7o5WNz2/jadjAB2vyMU/XjmFFeBBcpFpc5z3Yvb2R7ZCuTT6IMvB209n6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=I4If0inQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DdiIyhPKHP73x4pmNhJoiNC3dZPLUtJWrZ15qaXWfYg=; b=I4If0inQQNOxMPDst7s2SzZoFK
	6q0wnIk90C7rptEVpp/82Pe09hTqxuoB1l/jz1i+nDYxO6bIzDJKwDl6YvGKYTFbIUokAS4gsI8/i
	f5Ubl19wiNHjMuhHExfITl3dCI9sFPu9e9Ht8lnxSnW9QBEE22D5NaEP0Y1n/fPDWclE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhqsu-009V6V-64; Wed, 06 Mar 2024 14:00:36 +0100
Date: Wed, 6 Mar 2024 14:00:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2] net: hsr: Use full string description when opening
 HSR network device
Message-ID: <bf1dc55e-2a8f-4d24-8a58-9ae8afe70248@lunn.ch>
References: <20240306094026.220195-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306094026.220195-1-lukma@denx.de>

On Wed, Mar 06, 2024 at 10:40:26AM +0100, Lukasz Majewski wrote:
> Up till now only single character ('A' or 'B') was used to provide
> information of HSR slave network device status.
> 
> As it is also possible and valid, that Interlink network device may
> be supported as well, the description must be more verbose. As a result
> the full string description is now used.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---
> Changes for v2:
> - Use const char * instead of char * - to assure that pointed string is
>   immutable (.rodata allocated).
> ---
>  net/hsr/hsr_device.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 9d71b66183da..904cd8f8f830 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -142,30 +142,29 @@ static int hsr_dev_open(struct net_device *dev)
>  {
>  	struct hsr_priv *hsr;
>  	struct hsr_port *port;
> -	char designation;
> +	const char *designation = NULL;

Reverse Christmas Tree. This is now longer than any other variable, so
definitely should be first when sorted longest to shortest.

However, don't change the other variables. Such a cleanup should be in
a patch of its own.

	Andrew

