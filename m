Return-Path: <netdev+bounces-132269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CEC991256
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D2B283DDB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4722E13FD86;
	Fri,  4 Oct 2024 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHGmrNV2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBF2231C9F;
	Fri,  4 Oct 2024 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081078; cv=none; b=vFRwqEnbGcJfuAjz/QLsTOynvDaCPbtS0iIyfUEXG4Pr/v/SqD/ZzrjtpsBXhG6FwqZHwczABB6SEI29CKOxNRaM3TYNcNloTjvfnsDScICGhnqQhblPU9Rrv/ZlcFyqdJRJY1AK2Pz+JpJUlSJDg68wGTQ2e2gVnPqnxvUJeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081078; c=relaxed/simple;
	bh=UB/cQVsJIlvrYmc6cW2Jq3pbEGYqY1uD7VDav9QN0KE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnOYNQkQKrhbxP3vxIlcYthFgR92WzeSD9yvtFjrz6h2kTNO5bgX6LH1RTtVKxwQacT3iZTjK/3FDPSdWdGoq4+DxUGPM5pUp3xFl1c/Ub1jjjYesdLXmOV8CZ2qfmDg08jbacUZm0/VXFzDJ4PPEJjebkR0sSw5EqWVmvJhofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHGmrNV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364A8C4CECC;
	Fri,  4 Oct 2024 22:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728081077;
	bh=UB/cQVsJIlvrYmc6cW2Jq3pbEGYqY1uD7VDav9QN0KE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kHGmrNV2V4b9ze6jPV0fHCgdwcEA26c0OBBF7aIWeFl6oN1Mk16oc4SZ0Me4DeptJ
	 YVqu3rgw7M4BOqViL40jRYB9aLZXijnxXwYsvm7wvoQL+v8N1eT4DgNTtRn0nvrY2q
	 HcZUPg0F2TXN/Zdpd0ZNBC1zFRjIdpiLAFCdzaH/cgqHGvV2grsoz3qOxieaMFGZkC
	 SaoIZlvsXZzd7c1QZCWi18+gqz5CiASrxRuP5Vyh7DyheIK7LFqzQnHzVEPHjf27t4
	 3e10/aeJND/VruTT2TQubHFjK9IQbpA/szYjBG994fLE15B18mF0iMnVsWqE1XKVW+
	 Yi+CxAVyKbrxA==
Date: Fri, 4 Oct 2024 15:31:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Christian Marangi <ansuelsmth@gmail.com>, Tim
 Harvey <tharvey@gateworks.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: dsa: mv88e6xxx: Support LED control
Message-ID: <20241004153116.448c66ac@kernel.org>
In-Reply-To: <54922259-818f-425f-af47-cfa594a288e3@lunn.ch>
References: <20241001-mv88e6xxx-leds-v4-1-cc11c4f49b18@linaro.org>
	<20241004095403.1ce4e3b3@kernel.org>
	<54922259-818f-425f-af47-cfa594a288e3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 22:35:26 +0200 Andrew Lunn wrote:
> On Fri, Oct 04, 2024 at 09:54:03AM -0700, Jakub Kicinski wrote:
> > On Tue, 01 Oct 2024 11:27:21 +0200 Linus Walleij wrote:  
> > > This adds control over the hardware LEDs in the Marvell
> > > MV88E6xxx DSA switch and enables it for MV88E6352.  
> > 
> > Hi Andrew, looks good now?  
> 
> Sorry, drowning in patches.

I know the feeling.. Let's see if we can get the patchwork queue
below 150 patches today.. :(

While I have you, any further thoughts on
https://lore.kernel.org/all/20241001124150.1637835-1-danieller@nvidia.com/
?

> I just purged pretty much everything from Rosen Penev.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks!

