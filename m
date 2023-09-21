Return-Path: <netdev+bounces-35406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9024F7A956B
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E695B20842
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 15:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A975720E7;
	Thu, 21 Sep 2023 15:04:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3E23B8;
	Thu, 21 Sep 2023 15:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3B8C4E75C;
	Thu, 21 Sep 2023 15:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695308682;
	bh=CRXh/3WmFeRF4emfkW9qLsHyIVF5cqNuXHQEj19Hprc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRFc4QkUGkD5iaifmciPjC/qPhzL5Fda2wpSBbplnNUw+9muYkK/UCS5rY3W09X3k
	 6Mhex3e99h178rgcD/c8lIHpx6f8UDvMOqwJ7s4qquxa0BkosppA196DBsKji6pW8U
	 ICHaf2YEiFfGDAQAPXuB/gUxu58lcIdUSbDfg8mlgOtXwewzEzysNjts856dkIWjuX
	 lKKzN4zav/7lETaDYOBLRM7x1RKlEWKeO4boz4lUe2uA8QhrR8wgTqwZa1JP8mqyul
	 B++L9eT+pTewygRfIxHuGqxwdYpE5WXGKlC4iWnAHVNA3lxMmoXy+K+hJmlVgo6Sw9
	 tRmj8qYiOKfBw==
Date: Thu, 21 Sep 2023 16:04:32 +0100
From: Simon Horman <horms@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
	Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>
Subject: Re: [PATCH net-next 00/19] net: mdio: Convert to platform remove
 callback returning void
Message-ID: <20230921150432.GP224399@kernel.org>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>

On Mon, Sep 18, 2023 at 09:50:43PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> this series convert all platform drivers below drivers/net/mdio to
> use remove_new. The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side.
> 
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
> 
> There are no interdependencies between the patches. As there are still
> quite a few drivers to convert, I'm happy about every patch that makes
> it in. So even if there is a merge conflict with one patch until you
> apply, please apply the remainder of this series anyhow.
> 
> Best regards
> Uwe

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


