Return-Path: <netdev+bounces-239634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E17EC6AAF2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3CFDB2C058
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43A026F2B6;
	Tue, 18 Nov 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2Eeb2cJy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081C1D63EF
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484023; cv=none; b=Ht68b00anj4bs9vTw1vQYQRbhTEFdP13uih3HwaowOxpthyY+U7sC8L+KiJ6dCVj2z9GTC6t+Xs1tNQVKQbcyKTjaH8S7HLT1Li+X9RO8d5vSqXTQ8u9voQM5dD66sFMEaXWo4zh8i17/ojYVyLE/tKz9aDIFocbMTR3vJiiiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484023; c=relaxed/simple;
	bh=TxK41wWPYCmyIIobQi7otEbIKKUdXKELAPlLBaM2HjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQlZCzfjOLN9pz0hqJpSfkK4GDwX6GM+tK8rM2j85AAzcxCt3ZCxnZSTzOf+O7qrNjN5ya1vUiXG20p2kimQ7BQK4QWtx43b+VSRECXIvIZN+WZ5TOzqg7k0s6a33idPVlkIE7P9nH4RN3wiCdVQ99lWs/D73hGdoAzO7Ioq3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2Eeb2cJy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oZ3/8tV3+I0CFki1qG4ilo5z4AmC2klo1ULGZnE/XsA=; b=2Eeb2cJyf5DmS3infjDtjH3JNW
	THrFHhkPbEE9RPT9WWJVtjWrFaaPN46ARnq8ZivCxEjqWuHeYsnhN/G5ILlAWl238Tst6s1slFr87
	FlIUSrqIsm1N7F0Au0OKLKBbRSBYy+EEHXYuENfMRCtEA366M4TxpkuXlXwScG/3RLEY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLOkd-00ENFi-7X; Tue, 18 Nov 2025 17:40:19 +0100
Date: Tue, 18 Nov 2025 17:40:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Netdev <netdev@vger.kernel.org>,
	"inus.walleij@linaro.org" <inus.walleij@linaro.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: Do not subtract
 ifOutDiscards from rx_packets
Message-ID: <a31ffe45-5457-42a2-aac5-2f2da9368408@lunn.ch>
References: <878777925.105015.1763423928520.ref@mail.yahoo.com>
 <878777925.105015.1763423928520@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878777925.105015.1763423928520@mail.yahoo.com>

On Mon, Nov 17, 2025 at 11:58:48PM +0000, Mieczyslaw Nalewaj wrote:
> rx_packets should report the number of frames successfully received:
> unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX
> counter) is incorrect and can undercount RX packets. RX drops are
> already reported via rx_dropped (e.g. etherStatsDropEvents), so
> there is no need to adjust rx_packets.
> 
> This patch removes the subtraction of ifOutDiscards from rx_packets
> in rtl8365mb_stats_update().

It does look like a cut/paste error of some sort.

Please could you figure out a Fixes: tag, and submit this to net.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

