Return-Path: <netdev+bounces-52255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91B37FE060
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 20:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCE11C209CA
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590B45E0D6;
	Wed, 29 Nov 2023 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFp/3jSf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB4121A0C
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 19:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F011C433C7;
	Wed, 29 Nov 2023 19:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701286832;
	bh=fHNXRpVtKkP1y0TLrxmOB/9dRBKjdU1C043qG73EXDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFp/3jSfQxnsKMxe0fGJ36dpganCCY48KrI7kw/i+wsWQkCGj4jhaNo+KeVGKUwDY
	 hW05v1QXT1xccfiUl06kbfNttQ4UVhYCMtSm29oBPSPfBGB4D1/w1BOGYRy7gHSPv/
	 4P34Z/qxT/p+gIyUcyHqlK/hyqOji2nUmjAHTKSJarTbHWBwXaGCFeju9tNn0dI9ZC
	 3Kezg7/pvYMl6qWWwKV8uMuxOqVyYrNnmURExe2CaLf+NU3A0hUhBGMgypUE+iaXAo
	 L4IMrdzudjM5rz+D6/PN6M9LTgv6ezzKkmgri63jmtu5Xi/jIMGeVywLt2uIPeQOkk
	 T59uYytvoKwiw==
Date: Wed, 29 Nov 2023 19:40:28 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC net-next 4/8] dsa: Create port LEDs based on DT
 binding
Message-ID: <20231129194028.GH43811@kernel.org>
References: <20231128232135.358638-1-andrew@lunn.ch>
 <20231128232135.358638-5-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128232135.358638-5-andrew@lunn.ch>

On Wed, Nov 29, 2023 at 12:21:31AM +0100, Andrew Lunn wrote:

...

> +static int dsa_port_leds_setup(struct dsa_port *dp)
> +{
> +	struct device_node *leds, *led;
> +	int err;
> +
> +	if (!dp->dn)
> +		return 0;
> +
> +	leds = of_get_child_by_name(dp->dn, "leds");
> +	if (!leds)
> +		return 0;
> +
> +	for_each_available_child_of_node(leds, led) {
> +		err = dsa_port_led_setup(dp, led);
> +		if (err)
> +			return err;

Hi Andrew,

I realise this is an RFC, but Coccinelle tells me that a call to
of_node_put() is needed here.

> +	}
> +
> +	return 0;
> +}

...

