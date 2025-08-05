Return-Path: <netdev+bounces-211790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719DAB1BBA7
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4BF47A1107
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420BD221710;
	Tue,  5 Aug 2025 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lnyULp04"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4418632;
	Tue,  5 Aug 2025 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428365; cv=none; b=Up0e9zlmuA0mVHmHCtay6uqVo4QHfEGDp8vNr6K4sJj4v3DQxfSThUqsaEIemtWSs3HjjPA5vSKRhK8mW95mrOed1P9I4SgAKEOguW93skUdnXR+iC7PpCycDavStkJEgGskuaXJHPTXUynmXikI0+6fACnfzWkf6tY2rFJf798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428365; c=relaxed/simple;
	bh=nPom5Rh731jg09gBaYd36eYjFGaW5xY/XmgbtBtBWQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXle7Z5Ks4pZuAlKRxH029Z6a9rNG590xiTN4RE8vX45LIUSFSDRsQ2Ir4r8J64D3uJz//se6HCEqRQ22C42AGwGlHn5aZZFSND1pJaK0HnsFscdH93SNpvRXLcPEXAnIMFJgC1MLirvXbnDg+11hpcuxS2I4yYzrUEsUD81QYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lnyULp04; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lqkiB/8Zof/flippJeM//+dGGHfhVdDZDTGF2jIZ+ew=; b=lnyULp04t/hZCr2kjdegtJ/A0/
	ruVQbsWFlHwZEAl7uRf9yIYLfYGQCGuflWVvYMoo9brF1utgvyRpa0Era4n5cSMq3KtmBFx7j1/LR
	lArVxdHOa1lCrqQNe/BnSpozQj8Kt9mVDL1I0yDOCqhccrFH0arLkOd/nogKzitgLLns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujOxW-003pLx-OU; Tue, 05 Aug 2025 23:12:34 +0200
Date: Tue, 5 Aug 2025 23:12:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net-next v4 5/7] net: axienet: Use device variable in
 probe
Message-ID: <05a1234a-6da7-4c4b-9459-62db40e0267a@lunn.ch>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
 <20250805153456.1313661-6-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805153456.1313661-6-sean.anderson@linux.dev>

On Tue, Aug 05, 2025 at 11:34:54AM -0400, Sean Anderson wrote:
> There are a lot of references to pdev->dev that we can shorten by using
> a dev variable.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

