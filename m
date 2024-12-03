Return-Path: <netdev+bounces-148721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BAC9E300D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA64164AD6
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C346C1DF997;
	Tue,  3 Dec 2024 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0AbiEI/Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C580817;
	Tue,  3 Dec 2024 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733269652; cv=none; b=M91EyOtXfkyvsTCGV1g4aGIhtE6/GOp3u8GxaLI7vjeXudsz2W+usqy9SUbygddGKNZubjxS8pzlyJ3O1QNoDv20g+hG1+YrnfNoU3iIHnv0C4xmsOJrPzZV7M8502BYdbMr3VCCvLxU6IODnXoADzHDXlr6mMerO3xcVFmYEd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733269652; c=relaxed/simple;
	bh=hvYiJ8DILkDocF2JxnBT+Iylc4sHP3AK6c+tIx1sHKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FX2qwTc2vupSDJoZ83xGauLGQS4IqXC2N3buzQ2c9xbVLpcXpzOEunf7MkGnh+oLNFBhh6WVVBR+zOqUZhbcnyYJpgCyDrv6rN4KPZEhnbK4QWxz8RWUmtI4wND1p9DBQkQxvqBxCBYv6jb9E5mVvIbBXMcmD3jKVJhFEPMcpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0AbiEI/Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q7VC29OQznk9CyIabFBwdnET1FupuG6Cc4HOBI/prxc=; b=0AbiEI/YKvg8/d4/rd3Rb31fsI
	aC+gxVu3+U91p/jh3cIac+ke77abgkgUKIFPERRoI1jyzcIIcDSZowKYf88ZBQ2p+DzyHOIHyhwYt
	1pO4ETWZaPiP7TyR/Zn3HBJiVbVovqJL4DzcocUhQagE/syxuWX94WI/mJpFHuIQGeCo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIcbx-00F96u-2v; Wed, 04 Dec 2024 00:47:21 +0100
Date: Wed, 4 Dec 2024 00:47:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, ansuelsmth@gmail.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net-next 0/2] simplify with devm
Message-ID: <9bb90d44-1658-446a-99ff-b4ecbeef5b54@lunn.ch>
References: <20241203221644.136104-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203221644.136104-1-rosenp@gmail.com>

On Tue, Dec 03, 2024 at 02:16:42PM -0800, Rosen Penev wrote:
> Makes probe simpler and easier to reason about.

Hi Rosen

For all future patches, please say either:

Test on real hardware.

or

Compile tested only

We need to know this to help determine the risk of accepting the
patches. Clearly something you have tested is a lot lower risk than
something which is only compile tested.

	Andrew

