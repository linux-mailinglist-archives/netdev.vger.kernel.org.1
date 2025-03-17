Return-Path: <netdev+bounces-175302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7301A6501D
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6FC3B456B
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2360829D19;
	Mon, 17 Mar 2025 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="seW/ADE4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1CF7485;
	Mon, 17 Mar 2025 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216541; cv=none; b=aRIY+Tuiy+wOMMc5A4CXgBQiqMqa+55xX7cTlakIkQnPEtraVG8l7PKfxY10HS8O16QPqCkd/JGdxOMnXn7avg0pZi5eO1uNEAj4YdblP9AgrXhEATMMGcrZ/B/Hrwz6xa4PUBUyavWQ8eJv9gJtuk+l4ibjfmV6q0M3Un77+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216541; c=relaxed/simple;
	bh=Flnd+885JO4syD/z3UtFgokBx1Oa9WBjkE2Bez7q3Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8y4UOTRgZzlyKhzIk1IPKilJk4X96Icp2t2Yc07dLgCK88g9i7TYhCG0kPAmRDJK7spbPX9u+QYtPMa+hlg54n+TxhV07veNFN3uwrELd+i3hxHDI3dJtgVvuMB6/hPfR09EDhz0Kg61AylQ3VxLvk+V5ABevxWPjonmtBK7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=seW/ADE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67275C4CEE3;
	Mon, 17 Mar 2025 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742216540;
	bh=Flnd+885JO4syD/z3UtFgokBx1Oa9WBjkE2Bez7q3Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=seW/ADE46smYoY5WT/fFRDwHocj9UNL53O2UEFoVZnKrwVusGueXnx1VNCCFh55Ir
	 cUtX5zYPDqMz6/Bie6n6YQAiH3sqY7uX5UPNPP0Z4kLMgTPxELqbjsjzfVlXBsKyIL
	 XMhucKQslFia8cnx20zKZbUlIGuPCIjz1pc2Nchw=
Date: Mon, 17 Mar 2025 14:00:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 7/9] net: phy: fixed_phy: transition to the faux device
 interface
Message-ID: <2025031706-diffusion-posting-a617@gregkh>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-7-5fe67c085ad5@arm.com>
 <ea159cab-e09f-4afc-b0da-807d22d272c8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea159cab-e09f-4afc-b0da-807d22d272c8@lunn.ch>

On Mon, Mar 17, 2025 at 01:29:31PM +0100, Andrew Lunn wrote:
> On Mon, Mar 17, 2025 at 10:13:19AM +0000, Sudeep Holla wrote:
> > The net fixed phy driver does not require the creation of a platform
> > device. Originally, this approach was chosen for simplicity when the
> > driver was first implemented.
> > 
> > With the introduction of the lightweight faux device interface, we now
> > have a more appropriate alternative. Migrate the driver to utilize the
> > faux bus, given that the platform device it previously created was not
> > a real one anyway. This will simplify the code, reducing its footprint
> > while maintaining functionality.
> > 
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/net/phy/fixed_phy.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> 8 insertions, 8 deletions. How does this reduce its footprint?
> 
> Seems like pointless churn to me. Unless there is a real advantage to
> faux bus you are not enumerating in your commit message.

It stops the abuse of using a platform device for something that is NOT
a platform device.  This file should have never used a platform device
for this in the first place, and this change is fixing that design bug.

thanks,

greg k-h

