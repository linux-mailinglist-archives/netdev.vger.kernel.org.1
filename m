Return-Path: <netdev+bounces-142469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5889BF483
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CDC1F2294F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321F1207A0F;
	Wed,  6 Nov 2024 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bckz7RTN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887872076DD;
	Wed,  6 Nov 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915124; cv=none; b=PtsG/7zT9w4/cfytOqzp3vejIr9As7iKOF9Qf8Rqyzc2IjeH82OQ3ULqAV2+2D7JzPl7ASz1N84ItNdYZoT0hOEFEWqhXZgW9gj/H5xj1PuxL5QtQheT9uTew/M28+gPoBaIcvZT5dJ2PA/iacY86HmSoJWydSSKNYsKykoEFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915124; c=relaxed/simple;
	bh=UlRfXX19qsv4mCDBgj85GQYkTz0EJiViPpEmRjDcL2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji4uCSwjZ9Xb1ZEQfrIUV27tJzrA6L1HH1m1vZD3U1xYV50kDAIMiVecdG+/B2Sz01VeBK3F37Pnpgsne50tzDYl4FLJCre/aLrSFWS6f9dyyzzBrFI+kP8Xyp+UP4L6rrS/i9TTr4d/iTu+2A4RmR1MmZYjnYLfRhEatZFX2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bckz7RTN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UxOA/rfjI1KE6q3W8gj1BUxMxZg7BxDAt4RAStM8cQA=; b=bckz7RTNCff3o2N0qC4BrW5JJU
	t/NSlxrsd+A4IZiqBPho+pn1msHV/R9j4murPChVT9pvz2n/KWHwQPw9bbpmOHohQVi4yWa4W48Nx
	Z+sC2x4pxCgPMEbO9uSl0nDw3qEeV+BB5OSFFMDDDOnoLm5P0txnjkLVwplDdMhfGPY4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8k5m-00CMZo-Fe; Wed, 06 Nov 2024 18:45:18 +0100
Date: Wed, 6 Nov 2024 18:45:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 1/2] ptp: add control over HW timestamp latch
 point
Message-ID: <d20d8265-4263-4408-8448-4338a268d537@lunn.ch>
References: <20241106010756.1588973-1-arkadiusz.kubalewski@intel.com>
 <20241106010756.1588973-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106010756.1588973-2-arkadiusz.kubalewski@intel.com>

On Wed, Nov 06, 2024 at 02:07:55AM +0100, Arkadiusz Kubalewski wrote:
> Currently HW support of ptp/timesync solutions in network PHY chips can be
> implemented with two different approaches, the timestamp maybe latched
> either at the beginning or after the Start of Frame Delimiter (SFD) [1].
> 
> Allow ptp device drivers to provide user with control over the HW
> timestamp latch point with ptp sysfs ABI. Provide a new file under sysfs
> ptp device (/sys/class/ptp/ptp<N>/ts_point). The file is available for the
> user, if the device driver implements at least one of newly provided
> callbacks. If the file is not provided the user shall find a PHY timestamp
> latch point within the HW vendor specification.
> 
> The file is designed for root user/group access only, as the read for
> regular user could impact performance of the ptp device.
> 
> Usage, examples:
> 
> ** Obtain current state:
> $ cat /sys/class/ptp/ptp<N>/ts_point
> Command returns enum/integer:
> * 1 - timestamp latched by PHY at the beginning of SFD,
> * 2 - timestamp latched by PHY after the SFD,
> * None - callback returns error to the user.

-EOPNOTSUPP would be more conventional, not None.

> 
> ** Configure timestamp latch point at the beginning of SFD:
> $ echo 1 > /sys/class/ptp/ptp<N>/ts_point
> 
> ** Configure timestamp latch point after the SFD:
> $ echo 2 > /sys/class/ptp/ptp<N>/ts_point

and i assume these also return -EOPNOTSUPP if it is not supported.

And a dumb question, why should i care where the latch point is? Why
would i want to change it? Richard always says that you cannot trust
the kernel to have the same latency from kernel to kernel version
because driver developers like to tweak the latency, invalidating all
measurements the user has done when setting up their ptp4l
daemon. This just seems like yet another way to break my ptp4l
configuration.

	Andrew

