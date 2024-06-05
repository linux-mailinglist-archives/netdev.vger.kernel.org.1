Return-Path: <netdev+bounces-101143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA68FD789
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47597281372
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180BB14EC52;
	Wed,  5 Jun 2024 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F5zRhWvT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E4153BC7
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619481; cv=none; b=f+NHiLj8/IaS8lS0hNw49EdzyoNcwve/P07lrKIs7qie5hOJEXzvWCaIJwO9gbIbocHI1KRz+VxQeWsw0NK+HNtt/DHuRFnwPBbLiFNyR2mQjVdw+YC/3vByXihNFUonQYrdIPyGRWR7q4KadbUIG+TW46DlXFmv3OO+1Y/ncGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619481; c=relaxed/simple;
	bh=AG/hx8fOYwqKDhLkhKTgrZeqHCPj4BA1sltX/s4RzA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5VnbPV5xQNz89gSFOWWKShH1yaIl0g+XmBC6m1SnnXcN03/hcm3hAGJaIMxL5StQfDn97k8l7BR20tw4EM8GTosh77O3Rr0prghDf39DybZ06oiqGpSZKYQuyqeMj/vzelsxvUs+IWtFJnkxI/bmVhgw2LJ7I0N3rKMaUgSw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F5zRhWvT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yvnQRgkMrgaqcNhVBP1cbiqbFoOP1ZghiV1NOof1sRw=; b=F5zRhWvTnfoYDuh91hH+wCLZFv
	NTaMmdxGeYZiJM+3cUdsDra6wfo6Ex19paMZqrpoNqm6HhAxw1D1j3/oE08ODm/ljCSZrcdq9wspX
	UDn8WYCGOCB1c8NzGh/cToK99pc3anB1ISTUzIK0Z0crN3vigWK4Uf1q5VZ7hi8ExnJQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sExHq-00Gwhr-Pj; Wed, 05 Jun 2024 22:31:10 +0200
Date: Wed, 5 Jun 2024 22:31:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>,
	David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Menachem Fogel <menachem.fogel@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH 9/9] igc: add support for ethtool.set_phys_id
Message-ID: <202e55e2-be5f-4c7a-955e-fd726963c19c@lunn.ch>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
 <20240603-next-2024-06-03-intel-next-batch-v1-9-e0523b28f325@intel.com>
 <f8f8d5fb-68c1-4fd1-9e0b-04c661c98f25@amd.com>
 <dc0cc2ca-d3f4-4387-88bd-b54ea6896e0f@intel.com>
 <d27f050a-26db-4f08-aa19-848ae2c6ed2d@lunn.ch>
 <65068820-f8be-4093-800d-cec673d55b9f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65068820-f8be-4093-800d-cec673d55b9f@intel.com>

> Maybe I'm misunderstanding here. Are you asking us to expose the LEDs
> via some other interface and extend ethtool to use that interface to
> blink LEDs?

The LEDs are already exposed:

commit ea578703b03d5d651b091c39f717dc829155b520
Author: Kurt Kanzenbach <kurt@linutronix.de>
Date:   Tue Feb 13 10:41:37 2024 -0800

    igc: Add support for LEDs on i225/i226
    
    Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
    from user space using the netdev trigger. The LEDs are named as
    igc-<bus><device>-<led> to be easily identified.
    
    Offloading link speed and activity are supported. Other modes are simulated
    in software by using on/off. Tested on Intel i225.
    
    Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    Tested-by: Naama Meir <naamax.meir@linux.intel.com>
    Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
    Link: https://lore.kernel.org/r/20240213184138.1483968-1-anthony.l.nguyen@intel.com
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>

The Linux LED subsystem knows about them.

The Linux LED subsystem also knows about the qca8k LEDs, rtl8366rb
LEDs, mediatek-ge-soc LEDs, air_en8811h LEDs, broadcom PHY LEDs,
Marvell PHY LEDs, dp83867 LEDs, etc. There is nothing special here
about igc. All these should be capable of blinking.

So what i'm asking for is you add an ethtool helper, which implements
this using the Linux LED subsystem to blink the LEDs. The same helper
can then be used by other MAC drivers to blink their LEDs when they
use the Linux LED subsystem.

I'm sure there are a few different ways to implement this. One could
be to extend the existing ledtrig-netdev.c. Add a call

int netdev_trig_ethtool_phys_id(struct net_device *net_dev,
          		       enum ethtool_phys_id_state state)

Which if passed ETHTOOL_ID_ON, ETHTOOL_ID_OFF, ETHTOOL_ID_ACTIVE,
saves the current state and then sets the LEDs associated to the
netdev to the requested state. If passed ETHTOOL_ID_INACTIVE it
restores the previous state.

	 Andrew

