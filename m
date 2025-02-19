Return-Path: <netdev+bounces-167591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B623A3AF9F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7360C3A9BBC
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C24E176ADE;
	Wed, 19 Feb 2025 02:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnCeVXX7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7413DDB9;
	Wed, 19 Feb 2025 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932390; cv=none; b=CK7QIXXNuOVcA05AnSYCmkcupBtVe+OjmiR5FMOx4urSPYOMNlO8kfSngC6wA6XiHGVsIsIduDXcnF9/D+/yMzCYRYT8qKDSDkuWK2NjPLtWoPmKvQeqy2E3pt1BBY/n7Rk5bMEVvTsJKeA+zMffs1/pTidolKBi6Ax573FqTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932390; c=relaxed/simple;
	bh=m7BpxpXPF4VfoKYq7YsALuhmkx7N5GnIh1RNknLtAxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nd5GIGYY4iwhSvoQEoj9opt3ICW8oEtnov9lFMXvWXuamINGoGy7Lu5NpYHLEw+NzxT6v4SUDfbfCnsMkmDmwIR5H/9LZnlbiZJ7TINp/XQN1NGI0AmpegcqbtNthsrtWN75yYMy1EZ/MzosSf68UU3l8/oCX7RxLZhoGzzFlAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnCeVXX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A6BC4CEE2;
	Wed, 19 Feb 2025 02:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739932389;
	bh=m7BpxpXPF4VfoKYq7YsALuhmkx7N5GnIh1RNknLtAxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TnCeVXX7r9UonU7Le1CNQK6QDvhXxSHrstWZvgZWbq2H+f1+2MbjObMQKuw/Ksj5g
	 P0VQZUGzvNxxANWutFMx6A8Q9XPWmCk4xWx///byPVsgh4eTHTz3V3g4M4uEgyqFNr
	 lZG27pHHTyRNJ9R73LsYe047A5zf5YJh/wUhVc6s7Gt845r1+tZ7vQ9EUCP6S8d/Fb
	 kevqFIQLQeZw/QXJjPdS+HNnNFqegskZ8SdQ86c/z3I41AaGnGmu4JoCc9PUTGp0Ei
	 ZV+9g3DC0Yb834a+5aTEolG6t8J5mLWhh2YVnWoNR9TkVb05M5+InaVgonA3Oiy2FB
	 QBqHHXxky6Slg==
Date: Tue, 18 Feb 2025 18:33:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: pd692x0: Fix power limit retrieval
Message-ID: <20250218183308.5101d50c@kernel.org>
In-Reply-To: <20250217171500.0fd4a519@kmaincent-XPS-13-7390>
References: <20250217134812.1925345-1-kory.maincent@bootlin.com>
	<bb058f5f-31f2-4c20-848e-54c178ecaf6c@lunn.ch>
	<20250217171500.0fd4a519@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 17:15:00 +0100 Kory Maincent wrote:
> > > -	return pd692x0_pi_get_pw_from_table(buf.data[2], buf.data[3]);
> > > +	return pd692x0_pi_get_pw_from_table(buf.data[0], buf.data[1]);    
> > 
> > Would the issue of been more obvious if some #defines were used,
> > rather than magic numbers?  
> 
> We would need lots of defines as the offset of the useful data can
> change between each command. Don't know if it would have been better. 
> 
> On my current patch priority series.
> git grep "buf\." drivers/net/pse-pd/pd692x0.c | wc -l
> 29

I guess it'd take a bigger rewrite, so I'll apply.
But I fully agree with Andrew that the current coding is very error
prone :( If you ever need to add more message you should start from
refactoring this code..

