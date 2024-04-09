Return-Path: <netdev+bounces-86240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7D489E2B7
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843BE28314C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759B156F28;
	Tue,  9 Apr 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiMWxE3t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF94145320;
	Tue,  9 Apr 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712688328; cv=none; b=KcEPo2nLlC2lZ+PVdAwwnnJ6gEOXffS4yf4/I07WkB0tvjiIfzKm6q/LgDbyatq2Br+dtY5lQSRnk20rFoDnWu76w1qTO+fbocKWdML+sI7h1ZXBKmvXwOfSQwYGeRzOeEV59lJ32w82mJ46eTI1X+jW0POn9oRPEN0A2R8aiwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712688328; c=relaxed/simple;
	bh=pk3eO9up0+mqJLsRHP+9AfXouVa3499Pd+5pwisS3xE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1FXCZHlOkpeRk0BxHKfOolizAzfY/yFUhfGCeytDX9K3zJO1p3OaE7GZrU1WFF0L1P8UNzu5w5QD+HJw0SF9hgbBSLvx/uztc8PMKmsVqP0F6dkKzCM+/zz/uQppKnv0AUzLA4Cv2oKMfMe4g2hbpbKFQQ0HtBfKlIzcRh2Xn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiMWxE3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108D8C433F1;
	Tue,  9 Apr 2024 18:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712688328;
	bh=pk3eO9up0+mqJLsRHP+9AfXouVa3499Pd+5pwisS3xE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UiMWxE3trVGoTA5Nbg8R5uy1rciJxbGN72kIvomi2nH9Q+3mgGT837SnaZIjIK3N2
	 mhU/TYS867CG6zsLV80UwEsVzu++KoDaMvHsNE0mrwZ/ZJmDrWBIRv67QC69l5c2P6
	 8gziVttxBMVS+PaLAw8F/j+youBt37IBgzpRYp9CL9SzeyoKYhkWitTV2gX7hq90CG
	 /ClsnUkce2Swk51gf93lL/7ZJdCGA8IDRgbvrdM0uvI5RknYIg+9JpiWmcKxeSlXdT
	 WRbnNIwZBGQ25gZqhXmvFSfAEYBDvFQFYckdmAawrL/DsE/RxXKRDwTHvs04TIW+UR
	 vQC1B/T5BzfRA==
Date: Tue, 9 Apr 2024 11:45:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next 8/8] Documentation: networking: document
 phy_link_topology
Message-ID: <20240409114525.63119c0c@kernel.org>
In-Reply-To: <20240409105847.465298-9-maxime.chevallier@bootlin.com>
References: <20240409105847.465298-1-maxime.chevallier@bootlin.com>
	<20240409105847.465298-9-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Apr 2024 12:58:46 +0200 Maxime Chevallier wrote:
> +For more information, refer to :ref:`Documentation/networking/phy-link-topology.rst`

make htmldocs seems upset by this:

WARNING: undefined label: 'documentation/networking/phy-link-topology.rst'

I always struggle with the cross-file links TBH :S
-- 
pw-bot: cr

