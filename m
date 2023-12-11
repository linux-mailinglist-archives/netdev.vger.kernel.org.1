Return-Path: <netdev+bounces-55787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680B480C548
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8829B20B8E
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD9D21A04;
	Mon, 11 Dec 2023 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLaiH5iW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F09E219FE
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A14C433C7;
	Mon, 11 Dec 2023 09:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702288414;
	bh=RPdfDOpfiLZcdJaTDPN9N5jZHZuWzkzNihgGSQCCDTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hLaiH5iWOGE6t/pXw4EzMsYUcIzwQzavt/ocJHBoeUFFW8HzLsvsLETOA6aaGcnQW
	 TDs58Iq5Xzgt6cldaHcabLkUibvk6X6jgrqB6BSaK8CyXeywGMCzENXVvT96qbqpw0
	 zknDRVV6W+PTW6/pe5U9nkV4+DlTqrWI4rMnHVmdWNyKxhqnRpcm0xTYVG61uU2bdX
	 5K8KT0cMINieOTVjm2Wru5F4Knm8908qHnY/wqyXHv4Na1gbGPhxcWvm9jNm6iB41H
	 944/BEwCbkO3F7TQTA7EsCxATp0uSDfR6Hsa/f+DnAwvdiOmOGm3qrfNmYPvbeYdPR
	 9DH3xm30H2LLg==
Date: Mon, 11 Dec 2023 10:53:29 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>, Paolo Abeni
 <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, David Miller
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] r8169: add support for LED's on
 RTL8168/RTL8101
Message-ID: <20231211105329.598473b9@dellmb>
In-Reply-To: <8861e5b7-b1f5-4ae7-9115-76d7256dec62@gmail.com>
References: <8861e5b7-b1f5-4ae7-9115-76d7256dec62@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Heiner,

On Fri, 8 Dec 2023 18:48:27 +0100
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> +static void rtl8168_setup_ldev(struct r8169_led_classdev *ldev,
> +			       struct net_device *ndev, int index)
> +{
> +	struct rtl8169_private *tp = netdev_priv(ndev);
> +	struct led_classdev *led_cdev = &ldev->led;
> +	char led_name[LED_MAX_NAME_SIZE];
> +
> +	ldev->ndev = ndev;
> +	ldev->index = index;
> +
> +	r8169_get_led_name(tp, index, led_name, LED_MAX_NAME_SIZE);
> +	led_cdev->name = led_name;
> +	led_cdev->default_trigger = "netdev";
> +	led_cdev->hw_control_trigger = "netdev";
> +	led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
> +	led_cdev->hw_control_is_supported = rtl8168_led_hw_control_is_supported;
> +	led_cdev->hw_control_set = rtl8168_led_hw_control_set;
> +	led_cdev->hw_control_get = rtl8168_led_hw_control_get;
> +	led_cdev->hw_control_get_device = r8169_led_hw_control_get_device;
> +
> +	/* ignore errors */
> +	devm_led_classdev_register(&ndev->dev, led_cdev);
> +}

...

> +void r8169_get_led_name(struct rtl8169_private *tp, int idx,
> +			char *buf, int buf_len)
> +{
> +	snprintf(buf, buf_len, "r8169-%x%x-led%d",
> +		 pci_domain_nr(tp->pci_dev->bus),
> +		 pci_dev_id(tp->pci_dev), idx);
> +}

Please look at Documentation/leds/leds-class.rst:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/leds/leds-class.rst?h=v6.7-rc5

LED devices should have name in the format
  "devicename:color:function"
Where color is one from the led_colors array from
drivers/leds/led-core.c (or omitted if you cannot know) and function is
one from the LED_FUNCTION_ macros from
include/dt-bindings/leds/common.h.

When skipping color, you should keep the colon sign, i.e.
  usbnet0::lan

Regarding the devicename part: originally it was thought to be
something like eth0 (like the LED for mmc0 has devicename mmc0),
but since network interfaces can be renamed and their names are not
guaranteeed to be persisnet across boots, maybe you can reuse the
Predictable Network Interface Names scheme for USB devices
  https://www.freedesktop.org/software/systemd/man/latest/systemd.net-naming-scheme.html

Please don't put the driver name (r8169) there.

Marek

