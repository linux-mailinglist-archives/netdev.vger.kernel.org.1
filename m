Return-Path: <netdev+bounces-225352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A4EB929B4
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 20:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF0B2A18AD
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B731961C;
	Mon, 22 Sep 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4Y+tvqJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB483318129
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758566094; cv=none; b=kvdCGjxPg1pAbsUT2Vo2CJ9hGITJX1QP6YODWAgZDvNnuEXN5tl6pEqxMfxg0gyCeHHFzykTix+WmNNNx03x3fQXsJaWO2W+vOPgxS/RNxVFmRpqTRrkxwjaEOsjl5R0OGumMZbzOZIL5nPf51eM1Gyx5dsrljSsHt9fuwgQBL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758566094; c=relaxed/simple;
	bh=wUjWb1bTnAG1Rl+PhQZMEkaefH7XQvuc94I94Ic6TMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0yH2DzM9mdybp8PHwARZaV2gouIr1jMddre/0v0GAmst5+PoJi1wYyUmfA4569BuCca+jeVqNG+YFM6CoY2siQXyyst5GFTuC29/XpK1igW28F998jxtpwqrkSgEzwiGsZ4n9/gyP/NxZx44gKe5sx1ZvTXah/NYvKhicvVfU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4Y+tvqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A779C4CEF5;
	Mon, 22 Sep 2025 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758566094;
	bh=wUjWb1bTnAG1Rl+PhQZMEkaefH7XQvuc94I94Ic6TMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J4Y+tvqJ0E+FIr7KSORn9/7u4p0eg61ODffrX+MosKdqvZeIDG70sAbtQb0XgiWUW
	 Dx/8g7mcH0Mv+t951KE+9bQHQFqe6EHqam7RKtwSDK6aTHBOdh3tVDH4GbfHWn+HEz
	 utXvWDR8aBpTig6qo+HoXXbVY1f0kamZVmze3rl442wCppCcDIATHpYsgRl0G67+55
	 dDHi213R7XB7Gbi2ye6r48GOyF/87fVaNpIzEpef/XmoE9Y+X/oFaFgB9VnR0D59mh
	 3VVCzIa3yEs/okdqfIoJULhZlpSOGLSDLRYk2kGLy+ViGSnn+Z+TBemfamHWS8w5ki
	 qdW74fpORD9Ng==
Date: Mon, 22 Sep 2025 11:34:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org, Hauke
 Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 0/2] lantiq_gswip fixes
Message-ID: <20250922113452.07844cd2@kernel.org>
In-Reply-To: <20250922110717.7n743dmxrcrokf4k@skbuf>
References: <20250918072142.894692-1-vladimir.oltean@nxp.com>
	<20250919165008.247549ab@kernel.org>
	<20250918072142.894692-1-vladimir.oltean@nxp.com>
	<20250919165008.247549ab@kernel.org>
	<aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
	<aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
	<20250922110717.7n743dmxrcrokf4k@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 14:07:17 +0300 Vladimir Oltean wrote:
> - I don't think your local_termination.sh exercises the bug fixed by
>   patch "[1/2] net: dsa: lantiq_gswip: move gswip_add_single_port_br()
>   call to port_setup()". The port has to be initially down before
>   joining a bridge, and be brought up afterwards. This can be tested
>   manually. In local_termination.sh, although bridge_create() runs
>   "ip link set $h2 up" after "ip link set $h2 master br0", $h2 was
>   already up due to "simple_if_init $h2".

Waiting for more testing..

> - If the vast majority of users make use of this driver through OpenWrt,
>   and if backporting to the required trees is done by OpenWrt and the
>   fixes' presence in linux-stable is not useful, I can offer to resend
>   this set plus the remaining patches all together through the net-next
>   tree, and avoid complications such as merge conflicts.

FWIW I don't even see a real conflict when merging this. git seems to
be figuring things out on its own.

