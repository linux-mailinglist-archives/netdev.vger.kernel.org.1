Return-Path: <netdev+bounces-83944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B809894F2E
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C731F25A62
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E604A59178;
	Tue,  2 Apr 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayY3eXMN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72855731E
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051627; cv=none; b=fVmvv5bu3ee1IKpZmBc3VSOV3CYBl2C9KtsuqmBPc5PTGdGHP9FXhhcN8wuIIwOUZOaD/+6GeqN6eUcsFGmVxQvlLOUtubP2UKtwQoQ6lfIGV1ViAMMWyl7VXJSmUplLlfBAfIqd+M9sxfxhdnqJh2ioddKSXCaulADJdhygdbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051627; c=relaxed/simple;
	bh=WOvp/AX9n2/z9zLpydWpGnxkQzLEiS0ayRrJveiCbWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2HGlKxWsgTD0aJhvPivJ0NnQaDJrPlzCImtcNaG7FMDgFoOCY97b3PdaA0hWunWR5JvRjXy6Ft6vlQoOEqFI3lPfJGFsTvLv+Ey34A3QBD2XSyhZOcuX2oCp1exkhKgDq/K1KGm9FWhhl4S+Y4pLszqfG2PTWHNqrKON1NJK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayY3eXMN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a466e53f8c0so646143166b.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712051624; x=1712656424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iuaI8Jq7pw5dNhbMXJPs/FAy+dcwuT0UO34G4gOHQLo=;
        b=ayY3eXMNf7lZn1n2klnZCjqdS9iSB4AHI+9woRPhk+6H6k7v/2zkPSQQqKbGiIZINV
         NsRv7D8KANse8Z9BvYeSIoIt1zLgpM7XwW/XjN3Pe8t26WpqkKpllw3pdcS2+xAum5Zg
         e1pUuCY52RMoWuL1MBR5+MWgyev5P5B1ckoevKCsEf9VlI5ZszCveAxZSCKzZlGfYifr
         j7Fo5Q6bpeqQx0hcGZ8YbOg7p65TXKMNgwRt1Znp2Xy58QWAUVmoQWpCwsjbsYv/U36s
         CJFRzoEPbhLvd2AzC8kbkW/lAoA9xDbCsQxUCr8ADvlXLbx/2D4ECXT8v9ktyWu7nIF9
         UzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051624; x=1712656424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuaI8Jq7pw5dNhbMXJPs/FAy+dcwuT0UO34G4gOHQLo=;
        b=v6fxUZ5zgTFXj6xHb1+8DhvSf6bSczemLki4LFA13pir9dXUs64FFFMIyBUWLbkiCq
         FB70f0oaLMdlO+ok+/VIq92bGdfLX0nV/MlIBPI5fCV2A0M9jncm/Vq6uar1gp6zCvmr
         WML18MRrB3WfHHXSSe7TATH4GfkI57m+pwE53vkK+4UdV660jYr9Q8r9TKsk+SXZ0UN+
         myMRrfkBZjsxefOddm/fYw/Yr2J6efLDsSSD6RMnvUnO9GtpWF0rbJdOuosW5hCe3U02
         Vbp8UKkh6jBRu8JhmHR2qOF/1Z7g0ctrCjTHcBxrh4UrGVEwSAGb3lp1v/mZbH0+HcOP
         NTMA==
X-Forwarded-Encrypted: i=1; AJvYcCWVMb7MoqK0LGfaR3mVp1R2L1i0xfy/h+wAxa3nzFxuuoSL4S9nykVD3mP/O/G05aJy1AQW7p1vaAadKlI5XJ8YeLZDB8Qk
X-Gm-Message-State: AOJu0YzrduCR3RwBC8f3kuOvuOJzU7l5zIqb6YtE00uA3uAewQaftyL7
	VBIuLBk6zQLXKe3LIPoUjr6BPVp9krWfe6icg10wrEtvrf+sDXZU
X-Google-Smtp-Source: AGHT+IHOxR/MpTzSdErA2EMkU5b8T0KNjjXZeddv/xebafoZXzMr204y2OSPiO9R02cgJ+gnOIKTXQ==
X-Received: by 2002:a17:906:4f10:b0:a4e:70d8:4b29 with SMTP id t16-20020a1709064f1000b00a4e70d84b29mr3093173eju.3.1712051623628;
        Tue, 02 Apr 2024 02:53:43 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id wk8-20020a170907054800b00a4e2d7dd2d8sm5532576ejb.182.2024.04.02.02.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 02:53:42 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:53:40 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/7] net: Add helpers for netdev LEDs
Message-ID: <20240402095340.fnfjq3gtvjd4hakv@skbuf>
References: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
 <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-2-221b3fa55f78@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-2-221b3fa55f78@lunn.ch>

On Mon, Apr 01, 2024 at 08:35:47AM -0500, Andrew Lunn wrote:
> Add a set of helpers for parsing the standard device tree properties
> for LEDs as part of an ethernet device, and registering them with the
> LED subsystem. This code can be used by any sort of netdev driver,
> including plain MAC, DSA switches or pure switchdev switch driver.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  include/net/netdev_leds.h |  45 +++++++++++
>  net/Kconfig               |  11 +++
>  net/core/Makefile         |   1 +
>  net/core/netdev-leds.c    | 201 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 258 insertions(+)
> 
> diff --git a/include/net/netdev_leds.h b/include/net/netdev_leds.h
> new file mode 100644
> index 000000000000..239f492f29f5
> --- /dev/null
> +++ b/include/net/netdev_leds.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Helpers used for creating and managing LEDs on a netdev MAC
> + * driver.
> + */
> +
> +#ifndef _NET_NETDEV_LEDS_H
> +#define _NET_NETDEV_LEDS_H
> +

An object file which has "#include <net/netdev_leds.h>" as its only
line of source code does not compile. All headers should be
self-contained in terms of #include dependencies.

../include/net/netdev_leds.h:11:31: warning: declaration of 'struct net_device' will not be visible outside of this function [-Wvisibility]
        int (*brightness_set)(struct net_device *ndev, u8 led,
                                     ^
../include/net/netdev_leds.h:11:49: error: unknown type name 'u8'
        int (*brightness_set)(struct net_device *ndev, u8 led,
                                                       ^
../include/net/netdev_leds.h:12:15: warning: declaration of 'enum led_brightness' will not be visible outside of this function [-Wvisibility]
                              enum led_brightness brightness);
                                   ^
../include/net/netdev_leds.h:13:26: warning: declaration of 'struct net_device' will not be visible outside of this function [-Wvisibility]
        int (*blink_set)(struct net_device *ndev, u8 led,
                                ^
../include/net/netdev_leds.h:13:44: error: unknown type name 'u8'
        int (*blink_set)(struct net_device *ndev, u8 led,
                                                  ^
../include/net/netdev_leds.h:15:40: warning: declaration of 'struct net_device' will not be visible outside of this function [-Wvisibility]
        int (*hw_control_is_supported)(struct net_device *ndev, u8 led,
                                              ^
../include/net/netdev_leds.h:15:58: error: unknown type name 'u8'
        int (*hw_control_is_supported)(struct net_device *ndev, u8 led,
                                                                ^
../include/net/netdev_leds.h:17:31: warning: declaration of 'struct net_device' will not be visible outside of this function [-Wvisibility]
        int (*hw_control_set)(struct net_device *ndev, u8 led,
                                     ^
../include/net/netdev_leds.h:17:49: error: unknown type name 'u8'
        int (*hw_control_set)(struct net_device *ndev, u8 led,
                                                       ^
../include/net/netdev_leds.h:19:31: warning: declaration of 'struct net_device' will not be visible outside of this function [-Wvisibility]
        int (*hw_control_get)(struct net_device *ndev, u8 led,
                                     ^
../include/net/netdev_leds.h:19:49: error: unknown type name 'u8'
        int (*hw_control_get)(struct net_device *ndev, u8 led,
                                                       ^
../include/net/netdev_leds.h:24:30: warning: declaration of 'struct net_device' will not be visible outside of this function [-Wvisibility]
int netdev_leds_setup(struct net_device *ndev, struct device_node *np,
                             ^
../include/net/netdev_leds.h:24:55: warning: declaration of 'struct device_node' will not be visible outside of this function [-Wvisibility]
int netdev_leds_setup(struct net_device *ndev, struct device_node *np,
                                                      ^
../include/net/netdev_leds.h:25:16: warning: declaration of 'struct list_head' will not be visible outside of this function [-Wvisibility]
                      struct list_head *list, struct netdev_leds_ops *ops,
                             ^
../include/net/netdev_leds.h:28:34: warning: declaration of 'struct list_head' will not be visible outside of this function [-Wvisibility]
void netdev_leds_teardown(struct list_head *list, struct net_device *ndev);
                                 ^
../include/net/netdev_leds.h:28:58: warning: declaration of 'struct net_device' will not be visible outside of this function [-Wvisibility]
void netdev_leds_teardown(struct list_head *list, struct net_device *ndev);

> +struct netdev_leds_ops {
> +	int (*brightness_set)(struct net_device *ndev, u8 led,
> +			      enum led_brightness brightness);
> +	int (*blink_set)(struct net_device *ndev, u8 led,
> +			 unsigned long *delay_on,  unsigned long *delay_off);

One single space between arguments.

> +	int (*hw_control_is_supported)(struct net_device *ndev, u8 led,
> +				       unsigned long flags);
> +	int (*hw_control_set)(struct net_device *ndev, u8 led,
> +			      unsigned long flags);
> +	int (*hw_control_get)(struct net_device *ndev, u8 led,
> +			      unsigned long *flags);
> +};
> +
> +#ifdef CONFIG_NETDEV_LEDS
> +int netdev_leds_setup(struct net_device *ndev, struct device_node *np,
> +		      struct list_head *list, struct netdev_leds_ops *ops,
> +		      int max_leds);

Should we be even more opaque in the API, aka instead of requiring the
user to explicitly hold a struct list_head, just give it an opaque
struct netdev_led_group * which holds that (as a hidden implementation
detail)?

The API structure could be simply styled as
"struct netdev_led_group *netdev_led_group_create()" and
"void netdev_led_group_destroy(const struct netdev_led_group *group)",
and it would allow for future editing of the actual implementation.

Just an idea.

> +
> +void netdev_leds_teardown(struct list_head *list, struct net_device *ndev);
> +
> +#else
> +static inline int netdev_leds_setup(struct net_device *ndev,
> +				    struct device_node *np,
> +				    struct list_head *list,
> +				    struct netdev_leds_ops *ops)
> +{
> +	return 0;
> +}
> +
> +static inline void netdev_leds_teardown(struct list_head *list,
> +					struct net_device *ndev)
> +{
> +}
> +#endif /* CONFIG_NETDEV_LEDS */
> +
> +#endif /* _NET_PORT_LEDS_H */
> diff --git a/net/Kconfig b/net/Kconfig
> index 3e57ccf0da27..753dfd11f014 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -516,4 +516,15 @@ config NET_TEST
>  
>  	  If unsure, say N.
>  
> +config NETDEV_LEDS
> +	bool "NETDEV helper code for MAC LEDs"
> +	select LEDS_CLASS
> +	select LEDS_TRIGGERS
> +	select LEDS_TRIGGER_NETDEV
> +	help
> +	  NICs and Switches often contain LED controllers. When the LEDs

switches

> +	  are part of the MAC, the MAC driver, aka netdev driver, should
> +	  make the LEDs available. NETDEV_LEDS offers a small library
> +	  of code to help MAC drivers do this.
> +
>  endif   # if NET
> diff --git a/net/core/Makefile b/net/core/Makefile
> index 21d6fbc7e884..d04ce07541b5 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -42,3 +42,4 @@ obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
>  obj-$(CONFIG_OF)	+= of_net.o
>  obj-$(CONFIG_NET_TEST) += net_test.o
> +obj-$(CONFIG_NETDEV_LEDS) += netdev-leds.o
> diff --git a/net/core/netdev-leds.c b/net/core/netdev-leds.c
> new file mode 100644
> index 000000000000..802dd819a991
> --- /dev/null
> +++ b/net/core/netdev-leds.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/leds.h>
> +#include <linux/netdevice.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <net/netdev_leds.h>
> +
> +struct netdev_led {
> +	struct list_head led_list;
> +	struct led_classdev led_cdev;
> +	struct netdev_leds_ops *ops;
> +	struct net_device *ndev;
> +	u8 index;
> +};
> +
> +#define to_netdev_led(d) container_of(d, struct netdev_led, led_cdev)
> +
> +static int netdev_brightness_set(struct led_classdev *led_cdev,
> +				 enum led_brightness value)
> +{
> +	struct netdev_led *netdev_led = to_netdev_led(led_cdev);
> +
> +	return netdev_led->ops->brightness_set(netdev_led->ndev,
> +					       netdev_led->index,
> +					       value);
> +}
> +
> +static int netdev_blink_set(struct led_classdev *led_cdev,
> +			    unsigned long *delay_on, unsigned long *delay_off)
> +{
> +	struct netdev_led *netdev_led = to_netdev_led(led_cdev);
> +
> +	return netdev_led->ops->blink_set(netdev_led->ndev,
> +					  netdev_led->index,
> +					  delay_on, delay_off);
> +}
> +
> +static __maybe_unused int
> +netdev_hw_control_is_supported(struct led_classdev *led_cdev,
> +			       unsigned long flags)
> +{
> +	struct netdev_led *netdev_led = to_netdev_led(led_cdev);
> +
> +	return netdev_led->ops->hw_control_is_supported(netdev_led->ndev,
> +							netdev_led->index,
> +							flags);
> +}
> +
> +static __maybe_unused int netdev_hw_control_set(struct led_classdev *led_cdev,
> +						unsigned long flags)
> +{
> +	struct netdev_led *netdev_led = to_netdev_led(led_cdev);
> +
> +	return netdev_led->ops->hw_control_set(netdev_led->ndev,
> +					       netdev_led->index,
> +					       flags);
> +}
> +
> +static __maybe_unused int netdev_hw_control_get(struct led_classdev *led_cdev,
> +						unsigned long *flags)
> +{
> +	struct netdev_led *netdev_led = to_netdev_led(led_cdev);
> +
> +	return netdev_led->ops->hw_control_get(netdev_led->ndev,
> +					       netdev_led->index,
> +					       flags);
> +}
> +
> +static struct device *
> +netdev_hw_control_get_device(struct led_classdev *led_cdev)
> +{
> +	struct netdev_led *netdev_led = to_netdev_led(led_cdev);
> +
> +	return &netdev_led->ndev->dev;
> +}
> +
> +static int netdev_led_setup(struct net_device *ndev, struct device_node *led,
> +			    struct list_head *list, struct netdev_leds_ops *ops,
> +			    int max_leds)
> +{
> +	struct led_init_data init_data = {};
> +	struct device *dev = &ndev->dev;
> +	struct netdev_led *netdev_led;
> +	struct led_classdev *cdev;
> +	u32 index;
> +	int err;
> +
> +	netdev_led = devm_kzalloc(dev, sizeof(*netdev_led), GFP_KERNEL);
> +	if (!netdev_led)
> +		return -ENOMEM;
> +
> +	netdev_led->ndev = ndev;
> +	netdev_led->ops = ops;
> +	cdev = &netdev_led->led_cdev;
> +
> +	err = of_property_read_u32(led, "reg", &index);
> +	if (err)
> +		return err;
> +
> +	if (index >= max_leds)
> +		return -EINVAL;
> +
> +	netdev_led->index = index;
> +
> +	if (ops->brightness_set)
> +		cdev->brightness_set_blocking = netdev_brightness_set;
> +	if (ops->blink_set)
> +		cdev->blink_set = netdev_blink_set;
> +#ifdef CONFIG_LEDS_TRIGGERS
> +	if (ops->hw_control_is_supported)
> +		cdev->hw_control_is_supported = netdev_hw_control_is_supported;
> +	if (ops->hw_control_set)
> +		cdev->hw_control_set = netdev_hw_control_set;
> +	if (ops->hw_control_get)
> +		cdev->hw_control_get = netdev_hw_control_get;
> +	cdev->hw_control_trigger = "netdev";
> +#endif
> +	cdev->hw_control_get_device = netdev_hw_control_get_device;
> +	cdev->max_brightness = 1;
> +	init_data.fwnode = of_fwnode_handle(led);
> +	init_data.devname_mandatory = true;
> +
> +	init_data.devicename = dev_name(dev);
> +	err = devm_led_classdev_register_ext(dev, cdev, &init_data);
> +	if (err)
> +		return err;
> +
> +	INIT_LIST_HEAD(&netdev_led->led_list);
> +	list_add(&netdev_led->led_list, list);
> +
> +	return 0;
> +}
> +
> +/**
> + * netdev_leds_setup - Parse DT node and create LEDs for netdev
> + *
> + * @ndev: struct netdev for the MAC
> + * @np: ethernet-node in device tree
> + * @list: list to add LEDs to
> + * @ops: structure of ops to manipulate the LED.
> + * @max_leds: maximum number of LEDs support by netdev.
> + *
> + * Parse the device tree node, as described in
> + * ethernet-controller.yaml, and find any LEDs. For each LED found,
> + * ensure the reg value is less than max_leds, create an LED and
> + * register it with the LED subsystem. The LED will be added to the
> + * list, which can be shared by all netdevs of the device. The ops
> + * structure contains the callbacks needed to control the LEDs.
> + *
> + * Return 0 in success, otherwise an negative error code.
> + */
> +int netdev_leds_setup(struct net_device *ndev, struct device_node *np,
> +		      struct list_head *list, struct netdev_leds_ops *ops,
> +		      int max_leds)
> +{
> +	struct device_node *leds, *led;
> +	int err;
> +
> +	leds = of_get_child_by_name(np, "leds");
> +	if (!leds)
> +		return 0;
> +
> +	for_each_available_child_of_node(leds, led) {
> +		err = netdev_led_setup(ndev, led, list, ops, max_leds);
> +		if (err) {
> +			of_node_put(led);

What is the refcounting scheme for the "leds" node? Its refcount is left
incremented both on success, and on error here. It is not decremented
anywhere.

> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(netdev_leds_setup);
> +
> +/**
> + * netdev_leds_teardown - Remove LEDs for a netdev
> + *
> + * @list: list to add LEDs to teardown
> + * @ndev: The netdev for which LEDs should be removed
> + *
> + * Unregister all LEDs for a given netdev, freeing up any allocated
> + * memory.
> + */
> +void netdev_leds_teardown(struct list_head *list, struct net_device *ndev)
> +{
> +	struct netdev_led *netdev_led;
> +	struct led_classdev *cdev;
> +	struct device *dev;
> +
> +	list_for_each_entry(netdev_led, list, led_list) {
> +		if (netdev_led->ndev != ndev)
> +			continue;

I don't exactly see what's the advantage, in your proposal, of allowing
the API to bundle up the LED groups of multiple netdevs into a single
struct list_head. I see switches like mv88e6xxx have a single list for
the entire chip rather than one per port. It makes for a less
straightforward implementation here (we could have just wiped out the
entire list, if we knew there's a single group in it).

Also, what's the locking scheme expected by the API? The setup and
teardown methods are not reentrant.

> +		dev = &netdev_led->ndev->dev;
> +		cdev = &netdev_led->led_cdev;
> +		devm_led_classdev_unregister(dev, cdev);

I think devres-using API functions should be prefixed with devm_ in
their name for callers' awareness, rather than this aspect being silent.
And, if a netdev_leds_teardown() exists, I suspect devres usage isn't
even necessary, you could use list_for_each_entry_safe() and also
kfree() the netdev_led.

> +	}
> +}
> +EXPORT_SYMBOL_GPL(netdev_leds_teardown);
> 
> -- 
> 2.43.0
> 

