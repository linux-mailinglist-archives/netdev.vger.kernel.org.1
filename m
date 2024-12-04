Return-Path: <netdev+bounces-148766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF8C9E316C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405F3B27E04
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB01F20DF4;
	Wed,  4 Dec 2024 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XYmyFWF/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69124A1A;
	Wed,  4 Dec 2024 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279492; cv=none; b=fExnnAghcPC7Bfp5mQJS9Uu36lgjTJBtftTOfj3aIJ9Plh1KmHBforZtwHADJqflJtVmTeQX4cZQW2yxYAxpOeWSHsxCmrs0861xgS10PQV1ktuDU05xdJJqXehTU6N0TFrhGvrYRjtTohG+2q07ES3lD8Wu144mIzt4zdy0xJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279492; c=relaxed/simple;
	bh=puJM9U10pJ7ZZsZL46RbJm49Zgm255rDCPma8dTWHD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYx+KDnFpM0bfDJo+Qf8WekVgL7D2UiMAsj6cPjc4W57GQj4Sx/9sg/er2tXPMD0qqwozrbNZ74i9OtjIEfZz13ijP76hjzlhKE4eXwOgds33dxZIJUo6dIhaDKAeN/s9cRohJMIx7smDQdouozlZLTZ8UjHqPJPg5TIVFYOjTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XYmyFWF/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wc0zGDWbT/aWt7/2spsG4Ol8nYa9ime9o6DHO4l9Rgs=; b=XYmyFWF/coqCWpSpJO0fItL9DD
	n7ikGwD8cA4/aR8JfZg5ahGp1pZ5szOLgr1htHpQvKlqGvJIySx2XPq3xHIfJUG6MtSxgHpOc9qGU
	WGsJ2V3pSBkvBRKnJsaZbX1puCcpWEwwU6PRedVWdu1j+NelsNV5ayu6w1HYRyS0mSgQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIfAd-00F9mN-VB; Wed, 04 Dec 2024 03:31:19 +0100
Date: Wed, 4 Dec 2024 03:31:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: netdev@vger.kernel.org, Julian.FRIEDRICH@frequentis.com,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, upstream+netdev@sigma-star.at
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: propperly shutdown PPU re-enable
 timer on destroy
Message-ID: <8c882807-c8c1-4d44-ac13-19d12b2d976f@lunn.ch>
References: <20241203144448.30880-1-david.oberhollenzer@sigma-star.at>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203144448.30880-1-david.oberhollenzer@sigma-star.at>

On Tue, Dec 03, 2024 at 03:43:40PM +0100, David Oberhollenzer wrote:
> The mv88e6xxx has an internal PPU that polls PHY state. If we want to
> access the internal PHYs, we need to disable it. Because enable/disable
> of the PPU is a slow operation, a 10ms timer is used to re-enable it,
> canceled with every access, so bulk operations effectively only disable
> it once and re-enable it some 10ms after the last access.
> 
> If a PHY is accessed and then the mv88e6xxx module is removed before
> the 10ms are up, the PPU re-enable ends up accessing a dangling pointer.
> 
> This especially affects probing during bootup. The MDIO bus and PHY
> registration may succeed, but registration with the DSA framework
> may fail later on (e.g. because the CPU port depends on another,
> very slow device that isn't done probing yet, returning -EPROBE_DEFER).
> In this case, probe() fails, but the MDIO subsystem may already have
> accessed the MIDO bus or PHYs, arming timer.
> 
> This is fixed as follows:
>  - If probe fails after mv88e6xxx_phy_init(), make sure we also call
>    mv88e6xxx_phy_destroy() before returning
>  - In mv88e6xxx_phy_destroy(), grab the ppu_mutex to make sure the work
>    function either has already exited, or (should it run) cannot do
>    anything, fails to grab the mutex and returns.

On first reading this, i did not understand the code is using
mutex_trylock() which made me think it could deadlock. Maybe change
this to "mutex_trylock() fails to get the mutex and returns.

But i'm not actually sure this is needed. There are plenty of other
examples of destroying a work which does not take a mutex.

>  - In addition to destroying the timer, also destroy the work item, in
>    case the timer has already fired.
>  - Do all of this synchronously, to make sure timer & work item are
>    destroyed and none of the callbacks are running.

This is the important part, doing it synchronously. cancel_work_sync()
should be enough.

>  static void mv88e6xxx_phy_ppu_state_destroy(struct mv88e6xxx_chip *chip)
>  {
> +	mutex_lock(&chip->ppu_mutex);
>  	del_timer_sync(&chip->ppu_timer);
> +	cancel_work_sync(&chip->ppu_work);
> +	mutex_unlock(&chip->ppu_mutex);
>  }

/**
 * del_timer_sync - Delete a pending timer and wait for a running callback
 * @timer:	The timer to be deleted
 *
 * See timer_delete_sync() for detailed explanation.
 *
 * Do not use in new code. Use timer_delete_sync() instead.


    Andrew

---
pw-bot: cr

