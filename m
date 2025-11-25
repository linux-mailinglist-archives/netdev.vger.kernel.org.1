Return-Path: <netdev+bounces-241399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E312C83646
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 06:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80EBC4E2F56
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260C01E3DE8;
	Tue, 25 Nov 2025 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="IovL47Po"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B268A59;
	Tue, 25 Nov 2025 05:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764048678; cv=pass; b=eFEef5YNtgab18gqXjGgzfSnCq10MEBTJvePq1MwcvEGrfFN//A+vxvBOTlGDSGAeq8kVC8H2rmy8OJbBUOGyJDetCW6y+XhM2/z+JBHWfOt4iwITqAvvR6aDNonvLk/FCC79PNQ+6G5dlta/Za+d9PDih/nAZf4pBVKhdRrE6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764048678; c=relaxed/simple;
	bh=zx6mAq63LErP8MqiUoqvefc+sS2z5o95Fvnt7MkDW/Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QpqnLn+C6kdnvE7jkhOE9llcc30MBPJXwYpcDg5SVdJBoEUSIqjO5E6coFF0k076LDt1Oi8Os7emv1C3sYDgWB81iMEBGv4A1/pvlchVtHTJkvlLV/fe0EqIMcYpEzWK1y08C1fP+OPJHrraCEqrP5GRHYJ23ZPY3dkJzP9jUJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=IovL47Po; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1764048651; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=lYR8rF/BJahBnT5SRCaa0UuE2WYj0UofJLIQ4xKGEEfVm43fFQssDRMFWA6OjWe++d1Blr6WmEXlcmDR7LBFt7OzdeoGRX4Jez2It24p20CoyNXFi7tW4ggivW2iv3mFa4QXSW/xWrrx0FgMvYjFGgMZ7KKsB7kE7aS7syP5NAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1764048651; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EMcxJ5Sk+tNtFH9o7kpnDbRZ0sfNqmVj4kISU+J0+MI=; 
	b=K3AkukmaoaRgF2iWo6g77rQ+gaVcPNqPUxztVyHRjNOSFrJeeAmXDl3hHHbgtjHjcEAbo7f1D9lIdNa0Vlrr99sOsiG8AYGD2RQVYyk4ZiShqM5pudRyr4Gq2uC272Wxz9F1mlpy+rsPWX9XQ8gKGfCYOPuMOSv/vS+CiUUDfHE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764048651;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EMcxJ5Sk+tNtFH9o7kpnDbRZ0sfNqmVj4kISU+J0+MI=;
	b=IovL47PowVhl45s6Wsp913CHbaPToEwJdUgV5V20dlWhz1k+HDxghiN01WY/jA0G
	o79rt7bJ9qeWzm/KiJy5XoQuCORTsh3uIT0XFZF6cD12dxpL75ZvnANSqzBIsQN0djG
	2YAUJsvA/fwhv8mV3j0+7G1Mk5O3zwgJ4UTn3SY8=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1764048649587289.01099734976253; Tue, 25 Nov 2025 06:30:49 +0100 (CET)
Date: Tue, 25 Nov 2025 06:30:49 +0100
From: azey <me@azey.net>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "David Ahern" <dsahern@kernel.org>,
	"nicolasdichtel" <nicolas.dichtel@6wind.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19ab97e3d43.d406735b451318.2141568304607547279@azey.net>
In-Reply-To: <20251124202037.2ffdc42a@kernel.org>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
	<20251124190044.22959874@kernel.org>
	<19ab902473c.cef7bda2449598.3788324713972830782@azey.net>
	<20251124192550.09866129@kernel.org>
	<19ab92bfcaa.fc063ed1450036.1152663278874953682@azey.net> <20251124202037.2ffdc42a@kernel.org>
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

On 2025-11-25 05:20:37 +0100  Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 25 Nov 2025 05:00:59 +0100 azey wrote:
> > My main concern is that I keep my on/offline identities very separated,
> > so you couldn't find me by my real name anywhere online. And offline,
> > my legal name is common enough that you couldn't single me out by it
> > alone either.
> > 
> > My understanding is that the sign-off name should be what you can
> > identify and contact me by in case of any problems, which my legal
> > name is not. As per Linus' commit I linked:
> > 
> > > the sign-off needed to be something we could check back with.  
> 
> Feel free to appeal to Linus or Greg KH if you think it's worth their
> time (I don't).
> 
> I hope I don't regret saying this. But my understanding is that the
> real reason the wording was changed was that there are surprisingly
> many countries in the world which have legal requirements on the name.
> For instance, in the past(!) Greece forced Macedonians to use a
> Greekified spelling of their name. IDK the details but IIUC Lithuania
> requires certain spelling of Polish names too (I could be wrong). etc.
> 
> The rule was loosened because someone may culturally want to spell
> their name one way, but their "legal" name is forced to be localized.

Just looking through the commit history, there are plenty of one-off
contributors using nicknames. E.g.:

git log --pretty=format:"%an <%ae>" | grep '^[A-Za-z0-9]* <' | sort | uniq -u

This shows ~700 authors with a single commit which identify themselves
with a first name or alias only, so I don't think this can be true.
Also, I feel like that'd be indicated in the commit message if it was.

> It does not mean we will entertain people who "want to be anonymous
> online".
> 
> This is my final comment on this.

Mine as well, until someone else chimes in.

