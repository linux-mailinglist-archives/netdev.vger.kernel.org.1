Return-Path: <netdev+bounces-94537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B8F8BFCBE
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B621F234B2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA50582D64;
	Wed,  8 May 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZU+PreJh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5782C6B;
	Wed,  8 May 2024 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169444; cv=none; b=T93QnjhErfIRx5EkVlszBqwUdgXp6Tzdz2LjMmV5o0fxq1/aMCRNww/94FYzhaS82VHZxi4jrU4c4UnN5n+XFdXwPIT6fgt6SQwvted84uHqDwSG2qgc7vAgs6R/7F1H2AXGtDyuZbfDmJd2Jixk4Sl9bwFbfGSGGdBStQ1eaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169444; c=relaxed/simple;
	bh=wju6TxifXsmZBEaNzAa18t9xsnqPTcke0EvxvyMxRaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYGts/PmODkhCRXRsTD0vV+fcJ0rV54GFIvB1Eai5ECzFqgAe0frHQ05trLptgdQ6dKgThkuhSEXLCUEKtRcrf6jxcUyBwzl1sCWNIXo+yAocJ+7kx+v1YUl3eZF2K5EjVSg4V00aaiwvJ7sxMSnuat3Xa21rA8vRpJxXVnjhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZU+PreJh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p1A5eM6N5zPKftIsP9j+hrNy6HacLDaOY385DjZnn30=; b=ZU+PreJh/Ev3vXlm69jYeUEIlO
	laDXs5H0nhmdLvZ8pDPG7pyjp3shNWg/o5FtGBeyx7ztUy5oPOE+bW8y6vU/3PHtQWtix+SF5P3li
	1P4FCoi7iSpYeUpTfaG8oCRn3Opc1qkG1Iyh6BLmUKxAiMypK7z9gOFplfnk5JTHxK3Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4fv6-00Ewfk-VE; Wed, 08 May 2024 13:57:12 +0200
Date: Wed, 8 May 2024 13:57:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rengarajan.S@microchip.com
Cc: Bryan.Whitehead@microchip.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, edumazet@google.com,
	UNGLinuxDriver@microchip.com, kuba@kernel.org
Subject: Re: [PATCH net-next v1] net: microchip: lan743x: Reduce PTP timeout
 on HW failure
Message-ID: <9cc733b9-005d-4587-bc08-971f39334663@lunn.ch>
References: <20240502050300.38689-1-rengarajan.s@microchip.com>
 <01145749-30a7-47a3-a5e6-03f4d0ee1264@lunn.ch>
 <5ee0e9beb684dcf0b19b5c0698deea033cfff588.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee0e9beb684dcf0b19b5c0698deea033cfff588.camel@microchip.com>

> Hi Andrew, based on the customer experience they felt that there might
> be cases where the 20-sec delay can cause the issue(reporting the HW to
> be dead). For boards with defects/failure on few occasions it was found
> that resetting the chip can lead to successful resolution; however,
> since we need to wait for 20 sec for chip reset, we found that reducing
> the timeout to 1 sec would be optimal.

O.K. This should of been part of the commit message, since with this
comment the change becomes meaningful. Please try to ensure the commit
message explains "Why?"

	Andrew

