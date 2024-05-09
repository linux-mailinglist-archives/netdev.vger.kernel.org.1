Return-Path: <netdev+bounces-94748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5511D8C08DE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 03:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F32281A4C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 01:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797CC13A410;
	Thu,  9 May 2024 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7oBanTI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5516B13A3ED
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715216791; cv=none; b=Y3xEBQb/vA3MAjTGrbqpNntueF+n3MJ2m4OTJ3CpHJB/rQ9Cbst0oPoBrs3cUOYg1yllLRBfJC8oCIGOE7Qi5s/xCQnQT66lxRJUq8NQXdFRRl7QA7JptFAZoxD9UD025+rnaFm8pMe+1975TCP6WMlCAUsWXNB9WVbKXPZ5f5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715216791; c=relaxed/simple;
	bh=JmvL6g3sENoXXLzGri9qTQfv/nft2J3rKnZQotYJ2ho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsGFORTLFXdQbaDXm3NubN/XQGBHvn35Y84Enr8aZnE0azEfvEAGBsjBzd8E+SJNDrQE/eCVSrlBeT9PZd4weVtEqVu9s5iVc/DKqQ5doxR9g8Krk4IaTIPnWuEa61uu09l6VOCSostoBYX1syrxgOBZcg8Fe/sToP37Nav5UjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7oBanTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE604C113CC;
	Thu,  9 May 2024 01:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715216791;
	bh=JmvL6g3sENoXXLzGri9qTQfv/nft2J3rKnZQotYJ2ho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t7oBanTIfWqFd/qsKCvKIPVlhOBZKKGnKjKQrfHLVq4qF94rVAVBacCY3suOfdAJ7
	 M16jMjXBx/1cjT8ndKkZ0hoenZ5xbK+xSneBbpREzLvsyDzfEvW1tFe8Mn9qffdWwe
	 RIDYSCvhajP86EzZ++qYSIztalg+dz96/bqTytx8maNwx0ExXtVCgh1+8lNFBEoTna
	 vUYiY+Es41GXmTYM87zKqIVspYhdq0OIbFo1eoUY8OH6rl2wSidMC4tlXTRfxk7wX0
	 stZ4NTcKRGVnpGbBxnukncdTlQD2xx6cbpcJfhjoGVcGTR/hoGvXFZuq5A1C06DfGe
	 u3frCla7a3DqQ==
Date: Wed, 8 May 2024 18:06:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org, Sergey
 Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>, Esben
 Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 04/24] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <20240508180629.32501756@kernel.org>
In-Reply-To: <ZjuRqyZB0kMINqme@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
	<20240506011637.27272-5-antonio@openvpn.net>
	<ZjuRqyZB0kMINqme@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 16:52:27 +0200 Sabrina Dubroca wrote:
> > +static int ovpn_net_open(struct net_device *dev)
> > +{
> > +	struct in_device *dev_v4 = __in_dev_get_rtnl(dev);
> > +
> > +	if (dev_v4) {
> > +		/* disable redirects as Linux gets confused by ovpn handling
> > +		 * same-LAN routing
> > +		 */
> > +		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
> > +		IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;  
> 
> Jakub, are you ok with that? This feels a bit weird to have in the
> middle of a driver.

Herm, I only looked at the netlink bits so far.
Would be good to get more details on the problem and see if we can fix
it more directly.

