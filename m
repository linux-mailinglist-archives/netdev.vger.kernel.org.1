Return-Path: <netdev+bounces-89373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 686448AA256
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68DDB20CDB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAFE17AD67;
	Thu, 18 Apr 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ph5g3RK6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF8215FA92
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466561; cv=none; b=NOKZlC+ke38oDdjsJGNANnXOKzsp/2gfOLP2jex0K2td3MnNGT70QOSA1yXFGMqocXer/87aRwxnA2mvFeajM7s6nFHfV7TtnaPFgyD9jOy7UU2nt8KueMLpwTnIF881dXBHZq6qOQBRgcN/27f8/LNlI73Jj9msNfRQOp0Z6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466561; c=relaxed/simple;
	bh=LUH3DFoolMficHvAG1gmWGYiAGKGM+CYA9LrXA3TUAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSRPFdiDp0UvU8STVMYABtqsWYOiwSPs3hx3obg0z4j/karUSmACVdbnyDQ5vrfTqwRREFlINYDL17QJVMLmXvk3yDskI1nNXCwUVwDqdppOFA5o2Nxsc3J8xC3Jz2HNkBdsEVur281K/QNFB8D/vMU7pDUDVbgc/Gzr6y9zZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ph5g3RK6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/7sw4fKRwhUc7m1nekbHgHtt9yW14jXucm8YuU58S1w=; b=Ph
	5g3RK6IKsP+klb8gG1h+yNUp//sz7EjplsPXbSQCPgJQ4/Lu20KF/xDmqOryQRb91sKZ7jg4griJy
	dDknAniAVexIRCJOmm6ghFvynna3+BKYPRoOGAzMjyd0xg2qKNajWdfB8BSXmxbRmWg3aHMOg5F1Z
	Q9RWlOsX1mU3K3M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxWvN-00DNrn-4j; Thu, 18 Apr 2024 20:55:57 +0200
Date: Thu, 18 Apr 2024 20:55:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Peter =?iso-8859-1?Q?M=FCnster?= <pm@a16n.net>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net] net: b44: set pause params only when interface is up
Message-ID: <e5d3c578-6142-4a30-9dd8-d5fca49566e0@lunn.ch>
References: <871q72ahf1.fsf@a16n.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871q72ahf1.fsf@a16n.net>

On Thu, Apr 18, 2024 at 04:12:34PM +0200, Peter Münster wrote:
> Hi,
> 
> This patch fixes a kernel panic when using netifd.
> Could you please apply it to linux-5.15.y?

Hi Peter

Please take a read of:

https://docs.kernel.org/process/submitting-patches.html

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

This is a networking fix, so please base the patch on net:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git

Please include a Fixed: tag indicating when the problem was added.

Also, add a Cc: stable@vger.kernel.org, which will cause the patch to
be back ported to stable trees, including linux-5.15.

You can use the script scripts/get_maintainer.pl to get a list of
Maintainers you should Cc: the patch to.

The code change itself looks reasonable, although Florian should
review it.

   Thanks
	Andrew

