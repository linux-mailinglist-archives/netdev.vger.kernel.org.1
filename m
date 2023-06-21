Return-Path: <netdev+bounces-12688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4076738809
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C342815C2
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C045D18C2A;
	Wed, 21 Jun 2023 14:54:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A7AF9DE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC66CC433C8;
	Wed, 21 Jun 2023 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687359296;
	bh=bSDgKgIaIT7I/HAb2R0Ikz2XfAeToNBLTRIqFY41i2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDZ6bRNauyHwq6dzmJDZBnfL7lqHk5LlP9nPVhO2IUmRMZGfhnj1f+Q9liDfa/86s
	 8P4Y2TyCqe4y1hJmblPWEVbdSjYKtw9z1vkIE/oWCF/hnMxXimkcJTwG6DDAcX2763
	 9vyLMKbKAXgOlnitHHdntphT1vIz798ohvojXaI0astRKHidJzkuCqg4cCoMPACcXm
	 7tj0/D0ERra+CpIlP0FBrXL3xKBZJrVvJT0pqfKyolFredeGkNRqCp2rrJNR9n/4x9
	 izlHFSa30qohHUt/R4c35KTDGvAAon6+FmC87iRQALDOfA/ksWXrcLwIOh9fvHg/Tb
	 Bwu7IYbjlbwqQ==
Date: Wed, 21 Jun 2023 15:54:51 +0100
From: Lee Jones <lee@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v5 1/3] leds: trigger: netdev: add additional
 specific link speed mode
Message-ID: <20230621145451.GA10378@google.com>
References: <20230619204700.6665-1-ansuelsmth@gmail.com>
 <20230619204700.6665-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619204700.6665-2-ansuelsmth@gmail.com>

On Mon, 19 Jun 2023, Christian Marangi wrote:

> Add additional modes for specific link speed. Use ethtool APIs to get the
> current link speed and enable the LED accordingly. Under netdev event
> handler the rtnl lock is already held and is not needed to be set to
> access ethtool APIs.
> 
> This is especially useful for PHY and Switch that supports LEDs hw
> control for specific link speed. (example scenario a PHY that have 2 LED
> connected one green and one orange where the green is turned on with
> 1000mbps speed and orange is turned on with 10mpbs speed)
> 
> On mode set from sysfs we check if we have enabled split link speed mode
> and reject enabling generic link mode to prevent wrong and redundant
> configuration.
> 
> Rework logic on the set baseline state to support these new modes to
> select if we need to turn on or off the LED.
> 
> Add additional modes:
> - link_10: Turn on LED when link speed is 10mbps
> - link_100: Turn on LED when link speed is 100mbps
> - link_1000: Turn on LED when link speed is 1000mbps
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 80 +++++++++++++++++++++++----
>  include/linux/leds.h                  |  3 +
>  2 files changed, 73 insertions(+), 10 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

