Return-Path: <netdev+bounces-82148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFEA88C751
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE00B1F67A70
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223AA13C9CC;
	Tue, 26 Mar 2024 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gUPvaE9B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532D013C9CB
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467203; cv=none; b=RnqUz7pnHSbV1e7P7E4NUq7NvV7djo/kzpIgsI/I1kazJw7dPHnSeJLTz130/U+XBUfFocdeNo8SbiQNvfQQ+ouSeebICnvoUdnu+LtZhvtCZafI+RRICvbIYXGSfnHP8VuxQUZ6QQo1MUKDtFVi0pCM1eqtlhNPz2DT8+PfDA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467203; c=relaxed/simple;
	bh=Oju9TbylMbIx6wT8Jiao/mgF0IEwvbcKl5uK1+UbMOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOE/T3MD2TJtn2kjpKr+3tcxDNlSPw/62RJFZKA9QcsFG9DVESM04qZsHCoNHimB0L2PkXGoBzfB3dg9Hr+DiRcE464YJOPaTNt/VtdFlB+dIe4TzIW2eOD+EkQTccX1WZGewJ2WevaB7xZ/vWTe0DIYiSPK8bt4LjrlCz585gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gUPvaE9B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m/kfIjrt9+SiG6HZYiljhox/rbSKNWCCjZoo8eLqcZw=; b=gUPvaE9BQgQfnnnQBEAMB7zfxU
	jmmh9aPRmj7Ld3Duz6FMLVD5jzTcu2RaWRMDaLjJXz2OrZH+X44gkaICK1OszJvua/SocwSFKSJn6
	z9UAS16AkutJBGhCr/xMGn599OAFmpTzV41/OuZAqY+1luRMn7b3qUmThxYvOr7xsTUI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rp8nd-00BIRw-68; Tue, 26 Mar 2024 16:33:17 +0100
Date: Tue, 26 Mar 2024 16:33:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] using guard/__free in networking
Message-ID: <afe22a46-1cc4-469a-9935-c76cfcea5842@lunn.ch>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
 <20240325190957.02d74258@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325190957.02d74258@kernel.org>

On Mon, Mar 25, 2024 at 07:09:57PM -0700, Jakub Kicinski wrote:
> On Mon, 25 Mar 2024 23:31:25 +0100 Johannes Berg wrote:
> > Hi,
> > 
> > So I started playing with this for wifi, and overall that
> > does look pretty nice, but it's a bit weird if we can do
> > 
> >   guard(wiphy)(&rdev->wiphy);
> > 
> > or so, but still have to manually handle the RTNL in the
> > same code.
> 
> Dunno, it locks code instead of data accesses.
> Forgive the comparison but it feels too much like Java to me :)
> scoped_guard is fine, the guard() not so much.

I tend to agree. guard() does not feel like C. scoped_guard does.

	Andrew

