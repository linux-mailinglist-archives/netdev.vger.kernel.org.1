Return-Path: <netdev+bounces-172734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB0CA55D42
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327AC7A8F24
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C496C155342;
	Fri,  7 Mar 2025 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONtynfBm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87804143748;
	Fri,  7 Mar 2025 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311827; cv=none; b=BIOMRCWubNNWt11VNhb1dX8pgKR7d29/LLZQhhmWcz5TyO/7sN4yun0WDsKuMFiEVj83WRIdiL+F3HZQA8VJL5gEZDCE6J7cEob9szjO+SUqU+465bM+lNJLvz0fDSSgjdQFGa6GeY6uY0sTFlP09/S7aiGSguWgjwLf9+Ulncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311827; c=relaxed/simple;
	bh=8qhGxDSBdP038W8WjQyV+vUDGzDlQzKTyxEbksg15U4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvWTFoCd6FI6AObBUGfNQy+QyT7o4c6K1WCs7urnFmPzy4NLd3vI8AbOqXdL8WfMz8BAX+oLhxuODKJuqwyrM9ZZLdPDjcf19I42hmukFEqozoESEwsJ9yv3KhYnuoRWQ9aEjaps8ROMmDjDosbaXKkxEZH21hp9qGMQechCzUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONtynfBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D00C4CEE0;
	Fri,  7 Mar 2025 01:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741311827;
	bh=8qhGxDSBdP038W8WjQyV+vUDGzDlQzKTyxEbksg15U4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ONtynfBmyRnNUIlFqkfW72NuT/t+7hfqelHFApZe9jct5JIWGdmCLP7dWYfa/gzup
	 9+GMnSWGyEYNNZyGO9cbLlurUNYyIB7MfiTk9lSZnSsAd3somq2lllZSXa9cgrXrSl
	 Aue7CW43Bibb/rMdzNkaHMThYFUOE7zB6NGsgc3Xp2uCRWy0/R4kPdSJ/AqH7ZiSha
	 m9AdznuJRNrkfJnYxsqYr5tlFRFf7LmbfR46PH1Kbp85r6LkLoAmzUtcDI1zrFEJxI
	 SGUHAW1+BcEBWOX8uDU/383a3JXMz2iwjJ3ZJsu2azq075ts3u3CMQEgpdZPZzNWo2
	 zgi71Mrh4/mBA==
Date: Thu, 6 Mar 2025 17:43:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 02/12] net: pse-pd: Add support for
 reporting events
Message-ID: <20250306174345.51a1d56d@kernel.org>
In-Reply-To: <20250304-feature_poe_port_prio-v6-2-3dc0c5ebaf32@bootlin.com>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
	<20250304-feature_poe_port_prio-v6-2-3dc0c5ebaf32@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 04 Mar 2025 11:18:51 +0100 Kory Maincent wrote:
> +      -
> +        name: events
> +        type: u32

type: uint
enum: your-enum-name

and you need to define the events like eg. c33-pse-ext-state
in the "definitions" section

BTW I was hoping you'd CC hwmon etc. Did you forget or some
of the CCed individuals are representing other subsystems?

