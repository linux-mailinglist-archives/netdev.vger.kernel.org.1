Return-Path: <netdev+bounces-169502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 166DCA443C8
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA8F18853A1
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9E02561B7;
	Tue, 25 Feb 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vo8mUfK7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91725269CF0;
	Tue, 25 Feb 2025 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495522; cv=none; b=ADrtQ+uKVX++KVkKj/8Kzq9Nhz1Pcf0p6hpjaHZcv1av6/JGbcEOvG1f6sv4xxqCJOw5O/T5sHeV/uQiut99L9XXskh5IMumJNl4lrffk3ZJSS+aQ8i3lWGocL8XfYbn2vrAPOovpmj5aExZSlWKLjXa/weHM05sJ/XB/DgxzwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495522; c=relaxed/simple;
	bh=OOOQ2iAV9RcPK+sRsOM15Eslihb9DrXX+GRWkHK3Fa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDhyXoMgzEYGSEdBqyOxniqbJt4OWt3EN7MhyjqGcWmHOqjimgF3wOkod9Lla/IpW9+LP4Ij6AoAHFnXQ9HaFcS6VVV0r/d9cwdxh9MPY6P3qbT7NMJORJlgy5qWc6BRF072Vj7ITAF/J9f3E9tHBH1YVqEEFOz8SuMU8XbKPhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vo8mUfK7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5k1IwHxZahOlLQH5uLv2uOHgVzjElueHHZLb0aGMJJE=; b=vo8mUfK7nomK6vqCYsV+6lfUOV
	so90WcZBZhs48naQkAFpfJLqj+w6uSbN2oRVY4o2reMHjYoFEkajY37SJVX8X56adoOzb8sF7tmFD
	SScQV/JwzB7DtujduYp3qqxhefU/4exb0+O5N+zbuBXNdC08haloUzBUHYaLuTNzNbJg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmwOF-00HXlC-B9; Tue, 25 Feb 2025 15:58:31 +0100
Date: Tue, 25 Feb 2025 15:58:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v2 1/2] net: phy: sfp: Add support for SMBus
 module access
Message-ID: <caa65ad9-9489-4d22-9e87-dd30e4e16cca@lunn.ch>
References: <20250225112043.419189-1-maxime.chevallier@bootlin.com>
 <20250225112043.419189-2-maxime.chevallier@bootlin.com>
 <6ff4a225-07c0-40f6-9509-c4fa79966266@lunn.ch>
 <20250225145617.1ed1833d@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225145617.1ed1833d@fedora.home>

> You might be correct. As I have been running that code out-of-tree for
> a while, I was thinking that surely I'd have noticed if this was
> wrong, however there are only a few cases where we actually write to
> SFP :
> 
>  - sfp_modify_u8(...) => one-byte write
>  - in sfp_cotsworks_fixup_check(...) there are 2 writes : one 1-byte
> write and a 3-bytes write.
> 
> As I don't have any cotsworks SFP, then it looks like having the writes
> mis-ordered would have stayed un-noticed on my side as I only
> stressed the 1 byte write path...
> 
> So, good catch :) Let me triple-check and see if I can find any
> conceivable way of testing that...

Read might be more important than write. This is particularly
important for the second page containing the diagnostics, and dumped
by ethtool -m. It could be the sensor values latch when you read the
higher byte, so you can read the lower byte without worrying about it
changing. This is why we don't want HWMON, if you can only do byte
access. You might be able to test this with the temperature
sensor. The value is in 1/256 degrees. So if you can get is going from
21 255/256C to 22 0/256C and see if you ever read 21 0/256 or 22
255/256C.

	Andrew

