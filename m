Return-Path: <netdev+bounces-216073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC1B31E49
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD2AB437D3
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F521A428;
	Fri, 22 Aug 2025 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D49MY0pF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38512213248;
	Fri, 22 Aug 2025 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875741; cv=none; b=hrH5EqN2Mn43jYdexn3pGcGZ9ULoCyEYemCPPINAEtLXPrPYl5M2J6c1EvEeB2zKjmS/6GOPnLBQjHRfQ6FV2rzcQk3+93eolUsotq1r5ryh2CtKzQPjAGqmsDmDUVDj15KdwobfG5uoyvLs0QCLij0Zr8Gn0/CAW8Oukux5mkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875741; c=relaxed/simple;
	bh=/gfsQyrsrbXGGdnGdaY7rGAPUWVlVKkYOqFhKUvL4PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaqK0AyYDt8BtjDOA8yLEPLyv7mxuzDvODHfKnT3h/ku2WtOeVgqyvkLn2jjaT4jG4pSEQXRpYBk/OsIZT3CRxy/Nv/q3n7lYJQRb2VV6tQYGtr8H9zFHmvskBS0g6q57Y1P5Qj1rBoR/2ztdUxaqmmYei1iwBKTUZvUunh8oK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D49MY0pF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gq5lclAtLzfhvhbo+m+j2mnvDqQkARAsz8mulcP4c7Q=; b=D49MY0pFDQh94UeCG6zcvZ2Zd7
	+ha5Jp27CbU9bG4IvUE/OHbqlT5ypoFM685mG6OqY5mABmlR5h95xM/oAFcN0dC55rD1SraYLLyNn
	zFTeIwO9rq8ZMQwnwSLkihBec3SxiCWgjEHjA1UmJC+3jVKrz53jmyfFZ8e5g4HUW2XE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upTUJ-005anR-Uq; Fri, 22 Aug 2025 17:15:31 +0200
Date: Fri, 22 Aug 2025 17:15:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dlink: fix multicast stats being counted
 incorrectly
Message-ID: <8f47407c-fb5b-4805-a95f-ca15d6eb7838@lunn.ch>
References: <20250822120246.243898-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822120246.243898-2-yyyynoom@gmail.com>

On Fri, Aug 22, 2025 at 09:02:46PM +0900, Yeounsu Moon wrote:
> `McstFramesRcvdOk` counts the number of received multicast packets, and
> it reports the value correctly.
> 
> However, reading `McstFramesRcvdOk` clears the register to zero. As a
> result, the driver was reporting only the packets since the last read,
> instead of the accumulated total.
> 
> Fix this by updating the multicast statistics accumulatively instaed of
> instantaneously.
> 
> Fixes: 3401299a1b9e747cbf7de2cc0c8f6376c3cbe565 ("de6*/dl2k/sundance: Move the D-Link drivers")

The hash for fixes tends to be shorter than that.

Fixes: 3401299a1b9e ("de6*/dl2k/sundance: Move the D-Link drivers")

If you add this to your .git/config

[pretty]
        fixes = Fixes: %h (\"%s\")

You can do

git log --pretty=fixes 3401299a1b9e747cbf7de2cc0c8f6376c3cbe565
Fixes: 3401299a1b9e ("de6*/dl2k/sundance: Move the D-Link drivers")

This problem actually goes back further:

git blame 3401299a1b9e~1 drivers/net/dl2k.c

shows it was broken in the first commit in git.

So the correct Fixes: tag is:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

    Andrew

---
pw-bot: cr

