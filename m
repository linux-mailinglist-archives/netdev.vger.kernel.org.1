Return-Path: <netdev+bounces-177630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE91A70C12
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C1247A7C1A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF28269801;
	Tue, 25 Mar 2025 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tK0clAUZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41497266B55;
	Tue, 25 Mar 2025 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938283; cv=none; b=U4CSMd1cmZcZ5lMVawBL2eRBmY243joEc8E1P6Q+wPI/ITA+ApInI2quZht9wpSlJkdZEEb8k4XLl7SJcmzry3pal2mNFq42F0y93K9pj2t1gLhT2X6pBaSPVC7nfOkjzAGx/RNGFN9GgH0aE411pVju1TqjmZSzqBx2i3h0SxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938283; c=relaxed/simple;
	bh=nAFi6dgMBV3lJUJPu6iKA4YLItIVFO/go3V3AiJ3/Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbyBDRkpYrlIsmEBaPVRFSqWSmIk94PGNwhQeadSjwN4TkHoXtj/m216q+uCcx5AqHCyuNU8M8/kAcufKHmW0WCXX40mdWN5Vqu4yY13WvCZubC6UBgTsWb8jUih399tXVQutvj0JPtcMUhI1OK7Qz35ZEQdZmShdfMxmvrA7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tK0clAUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1518EC4CEE9;
	Tue, 25 Mar 2025 21:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742938282;
	bh=nAFi6dgMBV3lJUJPu6iKA4YLItIVFO/go3V3AiJ3/Wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tK0clAUZ2CpSENOT5//Ju4pTjOxtSmuMXIWYTtcKrpU+qkkubsZBWpAtUrHkoTgHf
	 bVfe/E5zaN1lgojpbK15qdxKGM2hDp5Zls7hypsqCcW/gHgq19NN1E+JpNNLDKmdOk
	 Ms2xm+CZWov5TwvUmfNovf4gjJIGUyFUjc873HFj64HBYrUeZCbOmEkL2D2JfkYy6d
	 I1J2gdek9bPfcFK3D2lsZFNThGY78RddH0bsjBX7S3HDyV8292orDEGlDA3WQBtZXs
	 hljEx4YmSq48bzfc8rngxLYX0GAmBhgjhkyy5AZ42mQ2rE/NCKgXmepn1Ehpchecru
	 FSRU1K/O5tISw==
Date: Tue, 25 Mar 2025 14:31:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v4 0/8] net: ethtool: Introduce ethnl dump
 helpers
Message-ID: <20250325143111.4a9e26c2@kernel.org>
In-Reply-To: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 11:40:02 +0100 Maxime Chevallier wrote:
> The patches 1 and 2 introduce the support for filtered DUMPs, where an
> ifindex/ifname can be passed in the request header for the DUMP
> operation. This is for when we want to dump everything a netdev
> supports, but without doing so for every single netdev. ethtool's
> "--show-phys ethX" option for example performs a filtered dump.
> 
> Patch 3 introduces 3 new ethnl ops : 
>  ->dump_start() to initialize a dump context
>  ->dump_one_dev(), that can be implemented per-command to dump  
>  everything on a given netdev
>  ->dump_done() to release the context  

Did you consider ignoring the RSS and focusing purely on PHYs?
The 3 callbacks are a bit generic, but we end up primarily
using them for PHY stuff. And the implementations still need 
to call ethnl_req_get_phydev() AFAICT

