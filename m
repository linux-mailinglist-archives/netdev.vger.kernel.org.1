Return-Path: <netdev+bounces-211686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D3CB1B2CD
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 13:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B25B3B371A
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 11:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8ED23BD04;
	Tue,  5 Aug 2025 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JeYcP4IP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3A1D7E5B
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754394780; cv=none; b=EkGeEvBrAIakZBQYqG8vmkgBcRnd3yxyFOjTLK+T646PCpLj7/v2QbKxNZftdpBvN3z53wxDpXkjgg9NoIi6vEnGs7TXDM0BFj/uyjcj7YUGF3U7QcYT52tMzkBm23GLbatgXHWBgIVsb4JmrI+AtoxTJYqUB1aaeZ2LCxxc1eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754394780; c=relaxed/simple;
	bh=snY9YU6jUmqW1iFzVyfIX13IajAVN5ROvSqYfrNKE8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyPSww6oEOktSTiKs7DUVcxtXtxBYSDJ5dub8fwhoHKZHYa4L3/MEj2Q7W/MMFcOiJ1veXHDOnt29rubvZB45ys/jZ+Ze7ig3xpSFkY/Wm85Pv1yhNVlis1udzm6SdqHe0D1PHDJdYscfM5UmfaLa66kzdbugtMSYZZpfxlh1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JeYcP4IP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=G60OpUeSCFQwT+Ftz64XID9t72JvPaKedHIGpha/zhQ=; b=Je
	YcP4IPBEn+d7gb4beu0bDLM6jN/ZFVZ52Vbq9kQ3wTUBqkCEa4G/vLoh0rbFl/9eAhtkEM69kr49a
	aXalYx+Jw+fd9x6dsGdZI/isZjegH6e+k8mwElMhuBO76bRErB8IrQOI+4eHPZS+h6KoZJjyej3KJ
	32oebedxBuxiyzw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujGDr-003moh-6R; Tue, 05 Aug 2025 13:52:51 +0200
Date: Tue, 5 Aug 2025 13:52:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ryan Wilkins <Ryan.Wilkins@telosalliance.com>,
	Luke Howard <lukeh@padl.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: validate source trunk against lags_len
Message-ID: <42a1926a-6e1a-4b0e-92e1-2647d7c75993@lunn.ch>
References: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>
 <20250731090753.tr3d37mg4wsumdli@skbuf>
 <42BC8652-49EC-4BB6-8077-DC77BCA2A884@padl.com>
 <20250731113751.7s7u4zjt6isjnlng@skbuf>
 <C867697B-7F5B-4500-8098-9C44630D7930@padl.com>
 <CAD3ieB36VnKAQPXUGbnRdWYFThf-VfLkhZTRfb9=ddndZEW3=A@mail.gmail.com>
 <20250805074226.agdnmeaip5wxzgkz@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250805074226.agdnmeaip5wxzgkz@skbuf>

On Tue, Aug 05, 2025 at 10:42:26AM +0300, Vladimir Oltean wrote:
> Hello Ryan,
> 
> On Tue, Aug 05, 2025 at 12:06:32AM -0400, Ryan Wilkins wrote:
> > I cannot confirm if the problem reproduces without the in-band management
> > patches applied as I’m testing with a Raspberry Pi that has no current
> > ability to connect to the switch chip via MDIO.
> 
> Last I checked, the RMU patches did not offer the possibility to control
> the switch exclusively over Ethernet; an MDIO connection was still
> necessary, mainly as a fallback to mv88e6xxx_rmu_available(). Has any of
> that changed? Who enables RMU management in the first place?

Luke has extended my patches to add pure RMU support. It does require
the EEPROM has the needed contents to get the switch into RMU mode,
but with that, no MDIO is required.

	Andrew

