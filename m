Return-Path: <netdev+bounces-174233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D2DA5DEB1
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBD4175BDC
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5325524C669;
	Wed, 12 Mar 2025 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0KECc+VK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000D1F4CB7;
	Wed, 12 Mar 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788854; cv=none; b=MnPMJi+OXNjR8kMK1vKiP7GblulbqQluktknIC5GYIHFDpGpbX/CL5/4dK9XxSpuflaHHVkRzrFVYqpEr0Q7lp/q/hV8AGvS0U60B/j9yHuWOqUK4t5QipUOva9mh6ALHQeodHkQJRlVLfPgtQE3pjNF8AUBs4yJpX0+doJ3aDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788854; c=relaxed/simple;
	bh=XZ3bROGubEEVeOSkjFbfbi8m42i4Upcz+kP33L81gRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=si7i/+DclkHTgMtmvzlvTaYQxnotIt2n4ihmq6ydBsBMx3ZQbUUGknTryrZ5Ad+M8BuvpNG4dmZlnrcM/7eUOfagff2Q0dDEO9t1m15oIe3u4sX/xSzBMRvoyqe/i2OlQKELUcMUwlZ5rXxXw0zZPZjT1p0B4coaDOVi3sUN/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0KECc+VK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ImBTaS60ReQfPO3xJ1M0jsrctwI6Qkx+rm26vovRU+c=; b=0KECc+VKF/xF+po574Br51EcqU
	rKsuJR05I2Rib4V8sTHdibditYvhflqHuKJw4tEouph7q7HAJKy9fILY9hxuGU7PA+D0rivkI/XP+
	NdokiTNjJmycXeI4eL0RRDT7SwwJnI0COOEWFlkNDVGrNY0jQfFemzimP6jHo6+3F3KrgVzBwGoum
	z+nAzj/tKzLsfB/hSIdpgVtL0F9UcV3J8qBJoowxHqMAPJw7VyM0C91qrmcdU9Win9uHRagazBECG
	Gc/e+AizK9xGM2cmFZMbdUJ5KpSYjYtUJNhgdQ9WYN1PExnUwuBixARrKAQff+sW3IpHfY0vS6Dhc
	Ho0hgDRg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32982)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tsMqL-0005i4-2X;
	Wed, 12 Mar 2025 14:13:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tsMqJ-0004bc-09;
	Wed, 12 Mar 2025 14:13:55 +0000
Date: Wed, 12 Mar 2025 14:13:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Suraj Gupta <suraj.gupta2@amd.com>, radhey.shyam.pandey@amd.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	git@amd.com, harini.katakam@amd.com
Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Message-ID: <Z9GWokRDzEYwJmBz@shell.armlinux.org.uk>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
 <20250312095411.1392379-3-suraj.gupta2@amd.com>
 <ad1e81b5-1596-4d94-a0fa-1828d667b7a2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad1e81b5-1596-4d94-a0fa-1828d667b7a2@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 12, 2025 at 02:25:27PM +0100, Andrew Lunn wrote:
> > +	/* AXI 1G/2.5G ethernet IP has following synthesis options:
> > +	 * 1) SGMII/1000base-X only.
> > +	 * 2) 2500base-X only.
> > +	 * 3) Dynamically switching between (1) and (2), and is not
> > +	 * implemented in driver.
> > +	 */
> > +
> > +	if (axienet_ior(lp, XAE_ABILITY_OFFSET) & XAE_ABILITY_2_5G)
> 
> How can we tell if the synthesis allows 3)?
> 
> Don't we have a backwards compatibility issue here? Maybe there are
> systems which have been synthesised with 3), but are currently limited
> to 1) due to the driver. If you don't differentiate between 2 and 3,
> such systems are going to swap to 2) and regress.

We've discussed this before... but because the author doesn't post
regularly enough, it's not suprising that context keeps getting lost.

Here's the discussion from 20th February 2025 on a patch series that I
commented on on 19th November 2024.

https://lore.kernel.org/r/BL3PR12MB6571FE73FA8D5AAB9FB4BB3CC9C42@BL3PR12MB6571.namprd12.prod.outlook.com

Suraj Gupta - you _must_ be more responsive so that reviewers can keep
the context of previous discussions in their heads to avoid going over
the same points time and time again. If you can't do that (and it's a
good idea anyway) then you need to supplement the commit descriptions
with the salient points from the previous patch series discussion to
remind reviewers of the appropriate context.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

