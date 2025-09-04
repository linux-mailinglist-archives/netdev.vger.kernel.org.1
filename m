Return-Path: <netdev+bounces-219839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5FEB43624
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15C0A4E5593
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC832BEC57;
	Thu,  4 Sep 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4aRV7Sz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A005924B28;
	Thu,  4 Sep 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975358; cv=none; b=SiP93bJo6uZk970oVA151iDXghHOVT3tG6zSOtCzS6yJsaGOUwWYwzOq3vtjVT6wS5tKbmvwOzA2Geqgi7wt2EvYJfz/WUUuKt0j+W/iggYHHAeeko9VwWDdrCITeHz7LbjMGyyiG8EkHmdT6jnJW6aItlMdMMcFyqur0RPoVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975358; c=relaxed/simple;
	bh=Pvw0c4uTRFsGNzS3JPjG+PT3lfxOgu6Bwub+YpiYusI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAw1B1bSWAzkQd/Y67Vxl4reO8iILykl2iX5iS7PNkDpip4EM26AEv3UCA8KcntuemcfO50OL+ZZZAax/v2OMEsKQR9ym0ItIWaD8GCPWdW33paNGixm96SOg24hkw+nqxxzzW4b1OjsfB5gLYzHB73dxBbGJHqVZ35c8mtLb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4aRV7Sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242B6C4CEF0;
	Thu,  4 Sep 2025 08:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756975358;
	bh=Pvw0c4uTRFsGNzS3JPjG+PT3lfxOgu6Bwub+YpiYusI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4aRV7SzpZmbkpwIuQfOIElBvWzR+0RVN41aG1R3Dr3Y77V9vmjxrtBrfFLBip5l0
	 YVXDuU7jazQhdbJy8UHIJXW24k3xEPLYYgZgzQi2PKrc+vIQpuNW+OrQFt+7jjg0Vu
	 qld2Lkz13ZrLPYGoitfFnjFtcl3M91pTUevN7sza4bD7dIvVXDAsncZo8+qEKsEIGb
	 vDCuEW/kx8etgaFgnfGPLdwZN/jKen8lMnY4Wewuef0Njb09kojtlpDGglKN2gBkCU
	 4h/FbhZygVMyUYvS0KzpffnHZ7QYnzJ4PZXWJetnCUnl6geHDQwTy5z2a4nk8W9bpk
	 3R+Wki5UAh8uA==
Date: Thu, 4 Sep 2025 09:42:33 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] net: phylink: add lock for serializing
 concurrent pl->phydev writes with resolver
Message-ID: <20250904084233.GA372207@horms.kernel.org>
References: <20250903152348.2998651-1-vladimir.oltean@nxp.com>
 <20250903184858.GF361157@horms.kernel.org>
 <20250903190145.n7su27upz2avqcm5@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903190145.n7su27upz2avqcm5@skbuf>

On Wed, Sep 03, 2025 at 10:01:45PM +0300, Vladimir Oltean wrote:
> On Wed, Sep 03, 2025 at 07:48:58PM +0100, Simon Horman wrote:
> > On Wed, Sep 03, 2025 at 06:23:47PM +0300, Vladimir Oltean wrote:
> > > @@ -1582,8 +1584,11 @@ static void phylink_resolve(struct work_struct *w)
> > >  	struct phylink_link_state link_state;
> > >  	bool mac_config = false;
> > >  	bool retrigger = false;
> > > +	struct phy_device *phy;
> > >  	bool cur_link_state;
> > >  
> > > +	mutex_lock(&pl->phy_lock);
> > > +	phy = pl->phydev;
> > 
> > Hi Vladimir,
> > 
> > I guess this is an artifact of the development of this patchset.
> > Whatever the case, phy is set but otherwise unused in this function.
> > 
> > This makes CI lightup like a Christmas tree.
> > And it's a bit too early in the year for that.
> 
> Thanks for letting me know. It's an artifact of moving patch 1 in front
> of 2, and I'll address this for the next revision.
> 
> I downgraded to a slower computer for kernel compilation, and even
> though I did compile patch by patch this submission, I had to stop
> building with W=1 C=1 for some unrelated bisect and I forgot to turn
> them back on.
> 
> I don't have a great solution to this, except I'll try next time to set
> up a separate 'git worktree' for noisy stuff like bisection, and try to
> keep the net-next environment separate and always with build warnings
> and debug options enabled.

Understood. It's a tricky problem.

FWIIW, while it's not perfect - e.g. it doesn't exercise linking - building
individual objects does catch problems like this one with low CPU time
requirements.

