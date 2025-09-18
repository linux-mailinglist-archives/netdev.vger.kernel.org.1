Return-Path: <netdev+bounces-224616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF77B86F33
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A300B165A0C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156F4264A72;
	Thu, 18 Sep 2025 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L4FfR9Id"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9AF2206BB
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228497; cv=none; b=Qu9IThvvEotT//jOol77H1WPfpqVHq5i26KRL6828hfcauqn22kNKwWrr5kaygCaXhHgy4Va2ih29NBNVxGCEh0ENPfhQq5qLzLSBtkfMb921JqVKFDW1tj6qepq4niXqapU3ebc0j6WsBMEPJWPq6H04J/s11jgMcmX8At+tGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228497; c=relaxed/simple;
	bh=Wnc7ZwKcrHkX4q1hif6DpyqoySsSjtFT3AOTpqVsUbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lK66bPz5okQfIHg/tOE9UBLyhT2fvbGznPX3YDvjeoFSgfNIJJc1GC67bfvPRYjQEdTZNvgUJHhG3I3b14bxYvwD6MkE9a6FvxWSoDIedlFo0yhNDECwUvskiJZnguK8/50/xWlzIe4FpJArxyrhBv2qfpD59VMH5KkgipEUakY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L4FfR9Id; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FUW+vtI390QZ4w1Qs1L71ekWxoP+vEokNlfm9PsWJio=; b=L4FfR9IdbSGUmrQHvWyB13uIOn
	TUq94a1pSVEQYLE6DruzF5IgBeXk0wd6qJ1huuEwwFO4lq26P+iiXTdgYQoVD9it6yXEwzLA1K+At
	k2ctIMqj03F3Mu9EeQKXzkJ1euSfgAhPKzErjCPd2rXNSXaZfbVsWmuhNRF46b4vTtKQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzLY5-008sKQ-6W; Thu, 18 Sep 2025 22:48:13 +0200
Date: Thu, 18 Sep 2025 22:48:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 06/20] net: dsa: mv88e6xxx: convert PTP
 ptp_verify() method to take chip
Message-ID: <bdba91cd-498f-4ba8-af5c-4d99c6e888eb@lunn.ch>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIbK-00000006mzc-27NF@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uzIbK-00000006mzc-27NF@rmk-PC.armlinux.org.uk>

On Thu, Sep 18, 2025 at 06:39:22PM +0100, Russell King (Oracle) wrote:
> Wrap the ptp_ops->ptp_verify() method and convert it to take
> struct mv88e6xxx_chip. This eases the transition to generic Marvell
> PTP.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

