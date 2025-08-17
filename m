Return-Path: <netdev+bounces-214392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDDAB293DD
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 17:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125A016E855
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9C1A3160;
	Sun, 17 Aug 2025 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5Bz1QDu5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3212B73;
	Sun, 17 Aug 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755444669; cv=none; b=m3w6FFiV/oX1xYEUY4u4AP4yt/ryp7S/877wehsFv2RaGRs1jTAiUQJm4fJvGBytZ+08QAqAxbI7+aGQBWDTesLye8kKIeZoHJ72wOck/P/64SZHlRK6Tvye1IqMMFKN5Qn6EtNRbItorxBQJFC3mRrT566ZuYt64nInJtI+Yr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755444669; c=relaxed/simple;
	bh=PQ+CFIhp1yiLUGGpNqB/wxFxiJR6D2Rdik6+NX9WSPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctIsvZiQ9IiBN9HXAXKQn2y10ih2rFAhUifl1zpUIVrKwNea79+SBshDlstOZ0MStBqU8xrJn05jNDiCIFHizmEpyJ9XAhnOuva+flbpeF8/fukMeUIaNfXEb7nj4pJs3eFzJvFbkFN7HAtSnPuGmKMOi6askefT+pTkD9FA6ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5Bz1QDu5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TkFJZU4VtS+tHD4zwXLDlbea3GBzl9UC0DlBrPXczD8=; b=5Bz1QDu5nC/ErdwxZ7aKzlb8AT
	lYQSzRxGQ32xBSBzJceK9VMmp4nroK9VVFUuA7uP0YuAiaChaw8AMl6EsugsdLrawRxnoBvA/XKxQ
	eEw7DFdDRwGHkLaIvUmTb48K8Tg58QlHSblt4GssHzNEDoAt2FBc1ejvNzfBohHsy+jc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unfLO-004yOT-RU; Sun, 17 Aug 2025 17:30:50 +0200
Date: Sun, 17 Aug 2025 17:30:50 +0200
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
Subject: Re: [PATCH RFC net-next 08/23] net: dsa: lantiq_gswip: store switch
 API version in priv
Message-ID: <2e433a22-723c-4217-b682-35839015873f@lunn.ch>
References: <aKDhfn-92oPzDcYY@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKDhfn-92oPzDcYY@pidgin.makrotopia.org>

On Sat, Aug 16, 2025 at 08:52:30PM +0100, Daniel Golle wrote:
> Store the switch API version in struct gswip_priv to prepare supporting
> newer features such as 4096 VLANs and per-port configurable learning.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

