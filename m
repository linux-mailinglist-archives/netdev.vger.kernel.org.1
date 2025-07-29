Return-Path: <netdev+bounces-210895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C1AB1555D
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 00:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F1F4E0205
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 22:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680932853F9;
	Tue, 29 Jul 2025 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qw4wudlE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAB41AA1D9;
	Tue, 29 Jul 2025 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829102; cv=none; b=JPcUNwgmPW2JQ3RDQP1fbrJ206pp8mQkRDtGg1mHXe3P62TBbtbsyKwwTPhq9HB8o+sMT9BNh5FShZxANMRAHZHgrXSMCYGjaHt6NKSGuZsdC77wzTpdzs2GVmnkvJ7ffWs8x384XomKEOFea+Md5uo6p/xG7JLEghygOOkd/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829102; c=relaxed/simple;
	bh=ObM698zo4DwV01L7bZzYsY6LWsBD229DFotACgPv4oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnaXXjIAoxFOfFT/afm8Bh8oNj5lHovkdZclpyq/LwnYMWZZq4ArLtPGZehflGq69NvOmqWr5SugfRqVJZyba7xFdTIhZ122kJxD38N8AcDc/sBtJsdmcwOJR1/9Q1iqJ16jg2ulqAbF8UCw9hMVi9SmmAKE1rKBtwBvPCc5TfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qw4wudlE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1WtoA09gcOii+21mVafZsCiy4A9k3Vy4kCvJTqQfyDI=; b=qw4wudlEHBvoKZoijh8Lpdu+/W
	L2ce7YLBzr5ewjMQRc4ROJIaQ+3gAIu5YQ8TQSomEFFFcM4QY7fLtn7puv9f2OKXJLUa3TPmR4ch/
	d8R9ZrP5gBQaH0wa9wBH6ahJ8waSwhJwugWXYEk0xXPxJHFAZ5Xq0qVOkPXWSeaOPL9Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugt3x-003Egn-5t; Wed, 30 Jul 2025 00:44:49 +0200
Date: Wed, 30 Jul 2025 00:44:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: mdio: mdio-bcm-unimac: Correct rate fallback
 logic
Message-ID: <775f7ae3-9705-4003-a7e8-aac3c418e48f@lunn.ch>
References: <20250729213148.3403882-1-florian.fainelli@broadcom.com>
 <11482de4-2a37-48b5-a98e-ba8a51a355cd@lunn.ch>
 <9c10c78b-3818-4b97-8d10-bc038ec97947@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c10c78b-3818-4b97-8d10-bc038ec97947@broadcom.com>

On Tue, Jul 29, 2025 at 03:22:57PM -0700, Florian Fainelli wrote:
> On 7/29/25 15:20, Andrew Lunn wrote:
> > On Tue, Jul 29, 2025 at 02:31:48PM -0700, Florian Fainelli wrote:
> > > In case the rate for the parent clock is zero,
> > 
> > Is there a legitimate reason the parent clock would be zero?
> 
> Yes there is, the parent clock might be a gated clock that aggregates
> multiple sub-clocks and therefore has multiple "parents" technically.
> Because it has multiple parents, we can't really return a particular rate
> (clock provider is SCMI/firmware).

O.K. Maybe add this to the commit message?

	Andrew

