Return-Path: <netdev+bounces-112312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3824693841E
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 11:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1022810FE
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 09:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE16BC2C6;
	Sun, 21 Jul 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFXVnH8r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF462256E;
	Sun, 21 Jul 2024 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721552486; cv=none; b=oTzNgQ7MQjEc5u5VdQ8klSsf5gj7kwrw+TDSx2geAFITPwG6FubgK+M+WL69hKh7m159T55I3rAsQIPMVeF68t2UxTJ6rFhoWodRu9i+diTfQ4abyJWrsyPBbOptFutgGVsXTwY/qBjpXvpmOhwD/G4BYQDwEvknHfDSpwDtUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721552486; c=relaxed/simple;
	bh=8MSVs0adN+I5h1SQG+ZJoSKe6+u9g0Uu8OZW3k/Z5Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG93GbNoBStNQXe5DH3+XHN9niOTTqP27Lm1/5d8xse/I+39xxPv/GnvouAgPiAZnTEZZdu1QdbaOTsai4qU7GeVGenewqlfFbBmKZkRbhX7h4wsy38hAIw7ovLhgf9mlNEbtn+91gXP2qL09mAXs3JdYefxrnRWWxzULBS9axo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFXVnH8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E65EC116B1;
	Sun, 21 Jul 2024 09:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721552485;
	bh=8MSVs0adN+I5h1SQG+ZJoSKe6+u9g0Uu8OZW3k/Z5Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFXVnH8r/mWQnMFn3ehCswGAfwj/71WMl4pIxAvXU+aH1e13ZPzrcrCAwvQCj49t8
	 q/v91n91oWOkNyYc2oW6IpNan8m6IUM2oi9yyjPs8rOcYr67HEL6xQI927SB9H3tEL
	 fbCsL++NrjClP1pWpHOw5QKzyacgSBNuse19SM4EOOFdaDQKsYkManyrdXOZLoTCHB
	 svGCCrdbF/eKdZNHUYVupMbvyje1KFU5c16kJgw38I+ceeSe4hmEDJ2Y5YugR13YgF
	 52nAVjXoDPaFWXkxpwIpyc/sccBh2HSXEZ72VhsflMO/vaIOVfJYByKKcgT+XIqNvt
	 Kw6zKOvUl3Kuw==
Date: Sun, 21 Jul 2024 10:01:19 +0100
From: Simon Horman <horms@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: net: ti,cc1352p7: Add boot-gpio
Message-ID: <20240721090119.GD715661@kernel.org>
References: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
 <20240719-beagleplay_fw_upgrade-v1-1-8664d4513252@beagleboard.org>
 <20240721090014.GC715661@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240721090014.GC715661@kernel.org>

On Sun, Jul 21, 2024 at 10:00:14AM +0100, Simon Horman wrote:
> On Fri, Jul 19, 2024 at 03:15:10PM +0530, Ayush Singh wrote:
> > boot-gpio (along with reset-gpio) is used to enable bootloader backdoor
> > for flashing new firmware.
> > 
> > The pin and pin level to enabel bootloader backdoor is configed using
> 
> nit: enable

Sorry, one more: configured

> 
>      Flagged by checkpatch.pl --codespell

...

