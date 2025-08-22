Return-Path: <netdev+bounces-215849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B31B30A42
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 02:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0D41CE77C2
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 00:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE7E4A3E;
	Fri, 22 Aug 2025 00:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b4rlDsE+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8F393DE0;
	Fri, 22 Aug 2025 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755822212; cv=none; b=dKin0jJJv9R557p9m+SID9NxuclOE9XIfZt0ei3Q3G/kFzwBs9VFiUwn9D5zgZQ6PBM+ixiiE9Yh2fnJG7MOLk8ogr8/dN2e0+jSxWZNcKTG3A0ToKU8rVX6setRge52/PiHZ3XVBpaZVVC2OY2WRHYivi+zRvQdtAbPDrfGyPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755822212; c=relaxed/simple;
	bh=d8uSlCdsb6IxON+UB2gioFYxQjDtQKGH8lLrzfJm/6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/0hN4fyLMzRNUryZNkHPGlU3FvoXSfpb8AXQ44e/k8g0qGQCDQ74edHtlvLG6E3KH5zbME9yl0llUnJ0AB3xMl8QKDilw9+qt93SdynuHjJxzMUbz2OeXCzVBZJCC+EXdTZVCUF6N4PfuuwxhTb/xcN3jt2MF5PdoPR3zkmGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b4rlDsE+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pdwFPjIY1pZ9q97xgTvS+donn5rx+Zx9UyAGAblGIoo=; b=b4rlDsE+x09keSlPfhZmsxsNcf
	WLJHrpSr7MLO27TernWqiGoCe1RkjcVgcxcM+xKsVb1bkB3Pkf6ZXdAYJpV/KMundEGdEksxs83Ff
	mbBBnJLPcUxVQmUVltH+HCOPvo/jGx9yjP5JpUsuYvyCMgWFvfPaToGHM3TctiCgCGZc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upFYx-005W7H-AA; Fri, 22 Aug 2025 02:23:23 +0200
Date: Fri, 22 Aug 2025 02:23:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dlink: fix multicast stats being counted
 incorrectly
Message-ID: <f06befad-ebbc-441f-95e5-c206bcd512ce@lunn.ch>
References: <20250821114254.3384-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821114254.3384-1-yyyynoom@gmail.com>

On Thu, Aug 21, 2025 at 08:42:53PM +0900, Yeounsu Moon wrote:
> `McstFramesRcvdOk` counts the number of received multicast packets, and
> it reports the value correctly.
> 
> However, reading `McstFramesRcvdOk` clears the register to zero. As a
> result, the driver was reporting only the packets since the last read,
> instead of the accumulated total.
> 
> Fix this by updating the multicast statistics accumulatively instaed of
> instantaneously.

This looks like a fix. Please could you add a Fixes: tag and submit to
net.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


    Andrew

---
pw-bot: cr

