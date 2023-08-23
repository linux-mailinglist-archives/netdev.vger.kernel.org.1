Return-Path: <netdev+bounces-29822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69379784D97
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDF3281184
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C792D646;
	Wed, 23 Aug 2023 00:03:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693FF7E
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E90C433C7;
	Wed, 23 Aug 2023 00:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692749017;
	bh=i5CvB6CZ/azi4lVxKcSZO2aXxxCTUXy6mjRt5ciWKww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R73DbQ9kLNFbIkVbtT+PYr1JYtKaMsCZxrpEiqH/Gi64EY31uXD5x80JJuGqRtfa6
	 G+JEsFMY57ztaWQxBsrbOLhaLzwd2Dm1Mp3Je+gXrr2DbvY2PmQ5UnMqi4yh/Xva9S
	 eDa223pBKvUJDwp8sIssl4VHNGjCDhZUAFBMZHuD2lEBqYHx8apiFcbMZOv1x7fajW
	 AFRAXeXWjZEEJ8ctqrn1X+2/iN7xBLHmw1l4zdPtg9PtjKFKFhEo8GMSHCX5pUmxp/
	 lxfHwb6RWgbnOloVzb8hQ5+3LzvXLa0I57Z3YEkMtkBN463V78Ms8OD5QwPwQgT/cc
	 OrjA1bdPCP4vA==
Date: Tue, 22 Aug 2023 17:03:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <rafal@milecki.pl>, <bcm-kernel-feedback-list@broadcom.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
 <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <netdev@vger.kernel.org>, <andrew@lunn.ch>
Subject: Re: [PATCH net-next v4 3/3] net: lan743x: Return PTR_ERR() for
 fixed_phy_register()
Message-ID: <20230822170335.671f3bef@kernel.org>
In-Reply-To: <20230821025020.1971520-4-ruanjinjie@huawei.com>
References: <20230821025020.1971520-1-ruanjinjie@huawei.com>
	<20230821025020.1971520-4-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 10:50:20 +0800 Jinjie Ruan wrote:
> fixed_phy_register() returns -EPROBE_DEFER, -EINVAL and -EBUSY,
> etc, in addition to -EIO. The Best practice is to return these
> error codes with PTR_ERR().

EPROBE_DEFER is not a unix error code. We can't return it to user
space, so propagating it from ndo_open is not correct.

> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index a36f6369f132..c81cdeb4d4e7 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -1515,7 +1515,7 @@ static int lan743x_phy_open(struct lan743x_adapter *adapter)
>  							    &fphy_status, NULL);
>  				if (IS_ERR(phydev)) {
>  					netdev_err(netdev, "No PHY/fixed_PHY found\n");
> -					return -EIO;
> +					return PTR_ERR(phydev);
>  				}
>  			} else {
>  				goto return_error;

