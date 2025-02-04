Return-Path: <netdev+bounces-162517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 521B3A272B3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7763A676A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022572139D2;
	Tue,  4 Feb 2025 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ntMn/dKc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B82139D8
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673976; cv=none; b=P46LLDv09czLB/Mh5aRwG2ss/aRCv5383Pfa4lNCjIPalAhEOlgNdZiwSvX+fCC41pi/wAClZf5fykc9DlOiT9cISGjfcVWtO90SnlGRt5aDc0/9S2b7GvzGgGDD6XvoTRufWWuW7UuWH3rVtPKdqut9TQSb6hqfmggC01KFxjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673976; c=relaxed/simple;
	bh=Rkqqh2LMlzhiY/HxJ83slok7TOy3J+gQafyTpBAwjcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoZQHiab8GJXy2mVzZat9Cbx9FCRa5QF7eYk/nk3vnUfhF8qlM2VccHCPCFxibpv5/crLBb2cfDpjAnvS6WbzkqzPGZZia0wXvuvSzgCM/PT2FNRbtr1SGb+2xGq5ivnv8zp/9om5JkeHOW/+m+/aXH/Ad0VEVkKddaDtpsIlsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ntMn/dKc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gRc6WATXM3qDS2HPAgTCMBHRT+tDHzZXh6zP2hgGO9E=; b=ntMn/dKc0fQD+1n+kPwR5bQ19h
	4B47sMhNygYiSOH3AO7/RQ2l99Vzk/asigpr1kTyKtnr12iO64aqATx72AzuM7enny0AbGBXdpIr5
	ROn2nKIUsCDGHid9JADKy6ppMbDM8JTyeyJhBbPMsjGXD5jt745S8W3nCvvoMT6bLlYc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tfIWM-00Aqx5-2y; Tue, 04 Feb 2025 13:59:18 +0100
Date: Tue, 4 Feb 2025 13:59:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] r8169: don't scan PHY addresses > 0
Message-ID: <f77ab00c-7858-413f-ba37-04c1f6f36381@lunn.ch>
References: <830637dd-4016-4a68-92b3-618fcac6589d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <830637dd-4016-4a68-92b3-618fcac6589d@gmail.com>

On Tue, Feb 04, 2025 at 07:58:17AM +0100, Heiner Kallweit wrote:
> The PHY address is a dummy, because r8169 PHY access registers
> don't support a PHY address. Therefore scan address 0 only.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

