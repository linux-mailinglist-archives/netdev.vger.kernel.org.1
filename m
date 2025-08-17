Return-Path: <netdev+bounces-214391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EB3B293DA
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57C4485E5B
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3442E5426;
	Sun, 17 Aug 2025 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jCyaZu4O"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6D723958C;
	Sun, 17 Aug 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755444610; cv=none; b=C6G1SHHmFT4sTkgpRZEgkbebEDpvARXXauMFjVGPxJ7qFrlF+y+UE+SqPcWgepjEGI6jdX5DxDIw7eRtAm/7MlbjRizzCIG/Jbit+Zaf9aw2jnDA4bNYqdj2c1rSXvGQLItTGXkT0yysnJxDucopxfO5YO5swHclVvTOOyDoikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755444610; c=relaxed/simple;
	bh=njg8NZ+SZpZIubGmIKFBweVvUoA5SeZ8ighSyBsFwko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDhYNuzEkXNJMuTw08dmnEQr2S5ZuC+XyhI8Y0aNAKtFU2WZfJEorcO2uF4pPtu3o3sv88kOyZmvtXO1buCZq4rhOzFOTnukLgPVsICfv+gTPi/j57BH0pXuAMc8utGPABb4uZtKxJuCzD2Dfue7wtGo3kdk/LQU/y3sQKzts4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jCyaZu4O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E4HpHy6x0s+5GvenUTQoNEp148w7CG4sh6jILxklFcQ=; b=jCyaZu4Os/CibYTrEt5cHvuOFp
	4POatdtazWa3nnmgzQ64+7qPLcJGHg9QymjCJNN7tdzZAOIN+5ar44tMU1sR/tQllxIjzHmQ/K6pB
	yMV8wkeh8OZeJABdKElwSE+VeX7MK9Th4g4epGMkz6orzn2CWJlyFgrMq/rwzLaQ53jg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unfKR-004yNV-1a; Sun, 17 Aug 2025 17:29:51 +0200
Date: Sun, 17 Aug 2025 17:29:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 07/23] net: dsa: lantiq_gswip: make DSA tag
 protocol model-specific
Message-ID: <284529f3-5e49-4495-9c96-00ebfa92088f@lunn.ch>
References: <aKDhcyFMKB_Cp0wF@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKDhcyFMKB_Cp0wF@pidgin.makrotopia.org>

On Sat, Aug 16, 2025 at 08:52:19PM +0100, Daniel Golle wrote:
> While the older Lantiq / Intel which are currently supported all use
> the DSA_TAG_GSWIP tagging protocol, newer MaxLinear GSW1xx modules use
> another 8-byte tagging protocol. Move the tag protocol information to
> struct gswip_hw_info to make it possible for new models to specify
> a different tagging protocol.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

