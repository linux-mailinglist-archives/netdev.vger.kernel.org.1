Return-Path: <netdev+bounces-241388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC467C8349E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 958D54E6A4C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE39914A60F;
	Tue, 25 Nov 2025 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="U5wUxwwP"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632231A8F84
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764043296; cv=pass; b=IaSyVn3jV8IxGKgi2g3bSRJ5hCbfA19s+V3WhnwtNHm1xaBkCDjinIIROHvDg2mK3OBMSIBu1g9Tt2mDGUZXfndY+ZTZtL9EqbJRxF9H6TeRMfm6P6FPteetPzn4wS4NYUWxl/SGJGjnYNZrIUW8mGsIKkrwONb6gLiAYb28P+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764043296; c=relaxed/simple;
	bh=8F3XelqSq45y9rIznL0gWRAHrEkAqvXw7ANWTZ3hTxs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WYoQ7aWHjMNNcJT2GVyQRbigA0Dkpwr18beZCbO5yfG2EDDH+FhmXHTg1cR39SmeGTmaddV9TEEB1tsRf3xvgaLSTROxaRBGgmGNAr40hXRR82g3Vfx9RxaAz+Nfa74B5w/XxI4WN6CtCTUpd5/VnGT99nKqTQ3eipbTFWt5MDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=U5wUxwwP; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1764043259; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Cxh7S+78DqUwgLI9TfBPRnsavjYrDXw71TqiQtV6nf0ixT9B2StxoYXOxTyIJAx8/QUVPp9j+3QKVi+9jkM8eWlBj1cW/ote9/5AoD3GIKq4M8rfKrgY1SvZd22Pwq7q6mNLXOtEUX1sMdlSJHz6qFkcPYqSHwZFqpqCpxl4Jv0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1764043259; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QugXX12w3LHqvxJnSQymcS9aIZXCYX5Hl1ahmESbSgs=; 
	b=G8Z+8Vv/zRlbwd+5P+4RvZWx69JX/w26yhoEKCWDz61ODLg8YMkKcGOALQrkAPkQ7XroFGWRz8Ge7l2B0z8lg5g5HUvSWC3Et7jfHCXOjyQWxuPkOy39ExXfybQUNJ4dyj6nrms2TJ6A+YrIcQGsmilye1zQiNn3qpEyBdAhWnU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764043259;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QugXX12w3LHqvxJnSQymcS9aIZXCYX5Hl1ahmESbSgs=;
	b=U5wUxwwPxR8/mZJM5eAUfnje9IxtqXEsVUl/VhbPTx8Td2q8T53t6z+bCVw1KDQT
	Z1tBGLJNewpMjD3zTqZnnclFVjxiINLK3xuitwY4ENCKUbCdtO5EubCxMrQl4K53PN4
	v2dswXlDPb11oihamVo2oazxwtwBQpr6XSc0BgpE=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1764043259072215.8427170083147; Tue, 25 Nov 2025 05:00:59 +0100 (CET)
Date: Tue, 25 Nov 2025 05:00:59 +0100
From: azey <me@azey.net>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "David Ahern" <dsahern@kernel.org>,
	"nicolasdichtel" <nicolas.dichtel@6wind.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19ab92bfcaa.fc063ed1450036.1152663278874953682@azey.net>
In-Reply-To: <20251124192550.09866129@kernel.org>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
	<20251124190044.22959874@kernel.org>
	<19ab902473c.cef7bda2449598.3788324713972830782@azey.net> <20251124192550.09866129@kernel.org>
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On 2025-11-25 04:25:50 +0100  Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 25 Nov 2025 04:15:25 +0100 azey wrote:
> > On 2025-11-25 04:00:44 +0100  Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Mon, 24 Nov 2025 14:52:45 +0100 azey wrote:  
> > > > Signed-off-by: azey <me@azey.net>  
> > > 
> > > We need real/legal names because licenses are a legal matter.
> > > -- 
> > > pw-bot: cr  
> > 
> > I was under the impression this was clarified in d4563201f33a
> > ("Documentation: simplify and clarify DCO contribution example
> > language") to not be the case, are there different rules for this
> > subsystem? I think it qualifies as a "known identity" since I use
> > the alias basically everywhere (github, website, GPG, email, etc).
> 
> My understanding is that if I know you, I can apply your patch even 
> if you use your nick name (rather than what you have in your passport
> letter for letter).
> 
> I don't know you.
> 
> If you're saying that I can do some research and find out who you are
> please be aware that we deal with 700 individual per release just
> in networking.

My main concern is that I keep my on/offline identities very separated,
so you couldn't find me by my real name anywhere online. And offline,
my legal name is common enough that you couldn't single me out by it
alone either.

My understanding is that the sign-off name should be what you can
identify and contact me by in case of any problems, which my legal
name is not. As per Linus' commit I linked:

> the sign-off needed to be something we could check back with.

> we've always accepted nicknames

> the wording [..] shouldn't be causing unnecessary angst and pain,
> or scare away people who go by preferred naming.

If the concern is that it isn't unique enough, I could change it to
azey7f as that's a username I use when just azey isn't available,
though my commits are always authored "azey <me@azey.net>".

