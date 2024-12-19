Return-Path: <netdev+bounces-153371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D1B9F7C8B
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FEF16341E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E0C17836B;
	Thu, 19 Dec 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t39ZyES/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F1C200A3
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734615689; cv=none; b=fnhVKonmg5FQwS1o6AjHiaACgWoEi9uOIg/hm3AAMHONQxm0M6ctn69Q9euaRS14JKoouk6pZMmuvKvUV1pQKm8Dyh1Kc+Zj19TKGMWWGu7m3eXSee7yn0p3N3ihsmG3ImzPdB9v17AvqEmKqKHNTqtbRs2kXmEdsT8qtA3SGMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734615689; c=relaxed/simple;
	bh=Sup5wsTggBM8HBSYWH9692pWCCFi0cl80/U4NF6HaiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYkLmqy+Fc8vNw1+FBuhLa3xHTCgo0q76z5vw9fHwEovB/eOopxXhGdYdPxnTBbq0shbW6orT0G5WdtnTNN4Ey2UhtdAUv129i8ftnFRyUW3+lwPO1JBZ+8ES9OQac7U361rdS9ZBPgiAkKH0raU15FdToC8wXAllYssrljw6VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t39ZyES/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=om3kjQmiTFr5kr0E3bcFTYski2sb4v2GXk9WOn2dMtE=; b=t39ZyES/mhVr7qq6WqTgibvjOF
	jGexjwTOY/VBBbZJXotHpRiolC55eBTOR+xaPDNGQF1/vmFuRm5+7uT2sAgSWpBh2EGJJgW0ufD3v
	YOKf2LBHl/SNKRKAnScQRWOg4025mHBQ9h29lgULH6JM2Kco7x37WMPvUFgzk1f5jHcQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOGmJ-001dDL-5P; Thu, 19 Dec 2024 14:41:23 +0100
Date: Thu, 19 Dec 2024 14:41:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
	olteanv@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com
Subject: Re: [PATCH v2 net 2/4] net: dsa: mv88e6xxx: Give chips more time to
 activate their PPUs
Message-ID: <deaa5a8f-613f-4612-8e5d-5482a39ecbee@lunn.ch>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219123106.730032-3-tobias@waldekranz.com>

On Thu, Dec 19, 2024 at 01:30:41PM +0100, Tobias Waldekranz wrote:
> In a daisy-chain of three 6393X devices, delays of up to 750ms are
> sometimes observed before completion of PPU initialization (Global 1,
> register 0, bit 15) is signaled. Therefore, allow chips more time
> before giving up.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

