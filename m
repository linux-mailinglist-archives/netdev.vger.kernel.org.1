Return-Path: <netdev+bounces-117531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1003594E2F9
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 22:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254CF1C204AB
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 20:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174FC15B116;
	Sun, 11 Aug 2024 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QGkpgXWG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723879F4;
	Sun, 11 Aug 2024 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407982; cv=none; b=N0NTYASH1m6yjTsoVqZWOENr3Qkhv2duDx+4GUEdfbuhGTvTrUV4mAswv1EQbYXXVQ22gfYuOwSr+s8zp7uKzDAQFe1x8OrCCq61KE/hrwz0syPebd9gsgMlzQ7fr/0VciSfpW6VnKKdTkoJ8D0tMOBKCRNTgQldRvn2Ku73bU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407982; c=relaxed/simple;
	bh=bbauAM7vn9K9N05ATrHTToA9/0wq/Yx3f/kV2pSzrgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggSpd3XsQF8maIVFHAG4M7bcp+/lkVudaXMIgMqFzRcuydAoc9j5B9+esL+I28O537cdggQFTEOkAPz2JY2aPbWflybY/8ZO6X5wnFJJ/aj/HQ7WtxlsKBEaIKtU4F/zki35jSiQ2qYqQ5JzN7pKjS5EBNHeDxF8t2GhDrVx4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QGkpgXWG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bCJY3RdK0QZTGR9Mg87gFxeeImcuLylNpRu+TrGP/gg=; b=QGkpgXWGEkw/1SB+n01GQfnjyY
	hRIa4o5SGhOqY4CBf9Vu8BVZOVj/F8p7JxQ2MpNUGw9KUOQUv8O4jt7f/QAT5ZGYFW7dvxUseQhkb
	IBZ2cgwkIayPe3y9ewXuqj7bV+iQI0Tuzr5Xr7Ts59+QTVQErEpHILv9SkaDFjhwvd50=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdF8i-004WJp-7D; Sun, 11 Aug 2024 22:26:08 +0200
Date: Sun, 11 Aug 2024 22:26:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC v2] net: dsa: mv88e6xxx: Support LED control
Message-ID: <07b19b43-e8db-45c8-9b7f-1372753e6865@lunn.ch>
References: <20240810-mv88e6xxx-leds-v2-1-7417d5336686@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810-mv88e6xxx-leds-v2-1-7417d5336686@linaro.org>

On Sat, Aug 10, 2024 at 12:19:12AM +0200, Linus Walleij wrote:
> This adds control over the hardware LEDs in the Marvell
> MV88E6xxx DSA switch and enables it for MV88E6352.
> 
> This fixes an imminent problem on the Inteno XG6846 which
> has a WAN LED that simply do not work with hardware
> defaults: driver amendment is necessary.
> 
> The patch is modeled after Christian Marangis LED support
> code for the QCA8k DSA switch, I got help with the register
> definitions from Tim Harvey.
> 
> After this patch it is possible to activate hardware link
> indication like this (or with a similar script):
> 
>   cd /sys/class/leds/Marvell\ 88E6352:05:00:green:wan/
>   echo netdev > trigger
>   echo 1 > link
> 
> This makes the green link indicator come up on any link
> speed. It is also possible to be more elaborate, like this:
> 
>   cd /sys/class/leds/Marvell\ 88E6352:05:00:green:wan/
>   echo netdev > trigger
>   echo 1 > link_1000
>   cd /sys/class/leds/Marvell\ 88E6352:05:01:amber:wan/
>   echo netdev > trigger
>   echo 1 > link_100
> 
> Making the green LED come on for a gigabit link and the
> amber LED come on for a 100 mbit link.
> 
> After the previous series rewriting the MV88E6xxx DT
> bindings to use YAML a "leds" subnode is already valid
> for each port, in my scratch device tree it looks like
> this:
> 
>    leds {
>      #address-cells = <1>;
>      #size-cells = <0>;
> 
>      led@0 {
>        reg = <0>;
>        color = <LED_COLOR_ID_GREEN>;
>        function = LED_FUNCTION_LAN;
>        default-state = "off";
>        linux,default-trigger = "netdev";
>      };
>      led@1 {
>        reg = <1>;
>        color = <LED_COLOR_ID_AMBER>;
>        function = LED_FUNCTION_LAN;
>        default-state = "off";
>      };
>    };
> 
> This DT config is not yet configuring everything: the netdev
> default trigger is assigned by the hw acceleration callbacks are
> not called, and there is no way to set the netdev sub-trigger
> type from the device tree, such as if you want a gigabit link
> indicator. This has to be done from userspace at this point.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> The attempt to make LED support more generic didn't work out
> as expected, so proposing to merge the very particular for now.

Yes, i never found the time/energy to get my patches over the line. So
lets go with this. However, i expect we have quite a bit of
duplication with the qca8k, especially the parsing of DT and
registering the LEDs. So it might be the third DSA driver wanting LEDs
gets the job of refactoring.

Please could you add something to the commit message about the SFP
needs special handling. That will help reviewers understand the code.

>  static int mv88e6xxx_setup_port(struct mv88e6xxx_chip *chip, int port)
>  {
>  	struct device_node *phy_handle = NULL;
> +	struct fwnode_handle *ports_fwnode;
> +	struct fwnode_handle *port_fwnode;
>  	struct dsa_switch *ds = chip->ds;
> +	struct mv88e6xxx_port *p;
>  	struct dsa_port *dp;
>  	int tx_amp;
>  	int err;
>  	u16 reg;
> +	u32 val;
> +
> +	p = &chip->ports[port];
> +	p->chip = chip;
> +	p->port = port;
> +
> +	/* Look up corresponding fwnode if any */
> +	ports_fwnode = device_get_named_child_node(chip->dev, "ethernet-ports");
> +	if (!ports_fwnode)
> +		ports_fwnode = device_get_named_child_node(chip->dev, "ports");
> +	if (ports_fwnode) {
> +		fwnode_for_each_child_node(ports_fwnode, port_fwnode) {
> +			if (fwnode_property_read_u32(port_fwnode, "reg", &val))
> +				continue;
> +			if (val == port) {
> +				p->fwnode = port_fwnode;
> +				p->fiber = fwnode_property_present(port_fwnode, "sfp");
> +				break;

> +			}
> +		}

This can be simplified i think. struct dsa_port *dp has a member dn,
which is the device tree node for the port. So p->fwnode is not
needed, and you can directly do of_property_present(dp->dn, "sfp").

If you keep with the current code structure, do you need a
fwnode_put() here? It seems like a common bug with
*_for_each_child_node(), if you don't iterate to the end of the
list, you need to do some manual cleanup.


> +	} else {
> +		dev_info(chip->dev,
> +			 "no ethernet ports node defined for the device\n");
> +	}

And i'm pretty sure this cannot happen, dsa_switch_parse_ports_of()
will return -EINVAL. What can happen is there is no DT at all, because
platform data is used. In that case, you need to silently skip LEDs.

> @@ -289,6 +292,12 @@ struct mv88e6xxx_port {
>  	struct devlink_region *region;
>  	void *pcs_private;
>  
> +	/* LED related information */
> +	bool fiber;
> +	struct led_classdev led0;
> +	struct led_classdev led1;
> +	u16 ledreg;
> +
>  	/* MacAuth Bypass control flag */
>  	bool mab;
>  };
> +static int mv88e6xxx_led_brightness_set(struct mv88e6xxx_port *p, int led,
> +					int brightness)
> +{
> +	u16 reg;
> +
> +	reg = p->ledreg;
> +
> +	if (led == 1)
> +		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED1_SEL_MASK;
> +	else
> +		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED0_SEL_MASK;
> +
> +	if (brightness) {
> +		/* Selector 0x0f == Force LED ON */
> +		if (led == 1)
> +			reg |= MV88E6XXX_PORT_LED_CONTROL_LED1_SELF;
> +		else
> +			reg |= MV88E6XXX_PORT_LED_CONTROL_LED0_SELF;
> +	} else {
> +		/* Selector 0x0e == Force LED OFF */
> +		if (led == 1)
> +			reg |= MV88E6XXX_PORT_LED_CONTROL_LED1_SELE;
> +		else
> +			reg |= MV88E6XXX_PORT_LED_CONTROL_LED0_SELE;
> +	}
> +
> +	p->ledreg = reg;
> +
> +	reg |= MV88E6XXX_PORT_LED_CONTROL_UPDATE;
> +	reg |= MV88E6XXX_PORT_LED_CONTROL_POINTER_LED01_CTRL;
> +
> +	return mv88e6xxx_port_write(p->chip, p->port, MV88E6XXX_PORT_LED_CONTROL, reg);

It seems like a little helper would be useful here, something like

mv88e6xxx_port_led_write(chip, port, reg)
{
	reg |= MV88E6XXX_PORT_LED_CONTROL_UPDATE;

	return mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_LED_CONTROL, reg);
}

You could also add a 
mv88e6xxx_port_led_read(chip, port, *val)
{
	int err;

	err = mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_LED_CONTROL, reg);
	*reg &= 0x3ff;

	return err;
}


> +}
> +
> +static int mv88e6xxx_led0_brightness_set_blocking(struct led_classdev *ldev,
> +						  enum led_brightness brightness)
> +{
> +	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led0);
> +	int err;
> +
> +	mv88e6xxx_reg_lock(p->chip);
> +	err = mv88e6xxx_led_brightness_set(p, 0, brightness);
> +	mv88e6xxx_reg_unlock(p->chip);
> +

Rather than have mv88e6xxx_led0_brightness_set_blocking() and
mv88e6xxx_led1_brightness_set_blocking(), could you not do

	led = (port->led1 == ldev? 1 : 0);

	mv88e6xxx_reg_lock(p->chip);
	err = mv88e6xxx_led_brightness_set(p, led, brightness);
	mv88e6xxx_reg_unlock(p->chip);

> +/* The following is a lookup table to check what rules we can support on a
> + * certain LED given restrictions such as that some rules only work with fiber
> + * (SFP) connections and some blink on activity by default.
> + */
> +#define MV88E6XXX_PORTS_0_3 (BIT(0)|BIT(1)|BIT(2)|BIT(3))
> +#define MV88E6XXX_PORTS_4_5 (BIT(4)|BIT(5))
> +#define MV88E6XXX_PORT_4 BIT(4)
> +#define MV88E6XXX_PORT_5 BIT(5)
> +
> +/* Entries are listed in selector order */
> +static const struct mv88e6xxx_led_hwconfig mv88e6xxx_led_hwconfigs[] = {

We should consider naming here. These are specific to the 6352, with
its SERDES which can be connected to port 4 or port 5. Other families
are going to have different tables. So this probably should be
mv88e6352_led_hwconfigs, and any functions here which are specific to
the 6352 should use that prefix, leaving space for other
implementations for different families.

> +/* Sets up the hardware blinking period */
> +static int mv88e6xxx_led_set_blinking_period(struct mv88e6xxx_port *p, int led,
> +					     unsigned long *delay_on, unsigned long *delay_off)
> +{
> +	unsigned long period;
> +	u16 reg;
> +
> +	period = *delay_on + *delay_off;
> +
> +	reg = 0;
> +
> +	switch (period) {
> +	case 21:
> +		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_21MS;
> +		break;
> +	case 42:
> +		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_42MS;
> +		break;
> +	case 84:
> +		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_84MS;
> +		break;
> +	case 168:
> +		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_168MS;
> +		break;
> +	case 336:
> +		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_336MS;
> +		break;
> +	case 672:
> +		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_672MS;
> +		break;
> +	default:
> +		/* Fall back to software blinking */
> +		return -EINVAL;

I _think_ if period is 0, i.e. not specified, the driver gets to pick
values it can support. I might be remembering this wrong, so please
check. This is why delay_on, an delay_off are pointers, not values....

> +static int mv88e6xxx_led_blink_set(struct mv88e6xxx_port *p, int led,
> +				   unsigned long *delay_on, unsigned long *delay_off)
> +{
> +	u16 reg;
> +	int err;
> +
> +	/* Choose a sensible default 336 ms (~3 Hz) */
> +	if ((*delay_on == 0) && (*delay_off == 0)) {
> +		*delay_on = 168;
> +		*delay_off = 168;
> +	}

Ah, here it is :-)

> +
> +	/* No off delay is just on */
> +	if (*delay_off == 0)
> +		return mv88e6xxx_led_brightness_set(p, led, 1);
> +
> +	err = mv88e6xxx_led_set_blinking_period(p, led, delay_on, delay_off);

Rather than pass pointers, you could pass the value, since the helper
is not going to change it, and that avoids the trap i fell into while
reviewing the code.

> +mv88e6xxx_led_hw_control_get(struct mv88e6xxx_port *p, int led, unsigned long *rules)
> +{
> +	/* The hardware register cannot be read: no initial state determined */
> +	return -EINVAL;
> +}

That is not what i expected. For the Marvell PHY driver, i walked the
table to find a match, and returned -EOPNOTSUPP if there was no
match. Can this be done here?

> +int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
> +{
> +	struct fwnode_handle *led = NULL, *leds = NULL;
> +	struct led_init_data init_data = { };
> +	unsigned long delay_off = 168;
> +	unsigned long delay_on = 168;
> +	enum led_default_state state;
> +	struct mv88e6xxx_port *p;
> +	struct led_classdev *l;
> +	struct device *dev;
> +	u32 led_num;
> +	int ret;
> +
> +	/* LEDs are on ports 1,2,3,4, 5 and 6 (index 0..5), no more */
> +	if (port > 5)
> +		return -EOPNOTSUPP;
> +
> +	p = &chip->ports[port];
> +	if (!p->fwnode)
> +		return 0;
> +	p->ledreg = 0;
> +
> +	dev = chip->dev;
> +
> +	leds = fwnode_get_named_child_node(p->fwnode, "leds");
> +	if (!leds) {
> +		dev_info(dev, "No Leds node specified in device tree for port %d!\n",
> +			 port);
> +		return 0;
> +	}

dev_dbg()? LEDs are optional, so we should not spam the log if they
are not found.

> +
> +	fwnode_for_each_child_node(leds, led) {
> +		/* Reg represent the led number of the port, max 2
> +		 * LEDs can be connected to each port, in some designs
> +		 * only one LED is connected.
> +		 */
> +		if (fwnode_property_read_u32(led, "reg", &led_num))
> +			continue;
> +		if (led_num > 1) {
> +			dev_err(dev, "invalid LED specified port %d\n", port);

That is a real error, the DT is broken. So i would return -EINVAL.

> +			continue;
> +		}
> +
> +		if (led_num == 0)
> +			l = &p->led0;
> +		else
> +			l = &p->led1;
> +
> +		state = led_init_default_state_get(led);
> +		switch (state) {
> +		case LEDS_DEFSTATE_ON:
> +			l->brightness = 1;
> +			mv88e6xxx_led_brightness_set(p, led_num, 1);
> +			break;
> +		case LEDS_DEFSTATE_KEEP:
> +			break;
> +		default:
> +			l->brightness = 0;
> +			mv88e6xxx_led_brightness_set(p, led_num, 0);
> +		}
> +
> +		/* Default blinking period for LEDs */
> +		mv88e6xxx_led_set_blinking_period(p, led_num, &delay_on, &delay_off);
> +
> +		l->max_brightness = 1;
> +		if (led_num == 0) {
> +			l->brightness_set_blocking = mv88e6xxx_led0_brightness_set_blocking;
> +			l->blink_set = mv88e6xxx_led0_blink_set;
> +			l->hw_control_is_supported = mv88e6xxx_led0_hw_control_is_supported;
> +			l->hw_control_set = mv88e6xxx_led0_hw_control_set;
> +			l->hw_control_get = mv88e6xxx_led0_hw_control_get;
> +			l->hw_control_get_device = mv88e6xxx_led0_hw_control_get_device;
> +		} else {
> +			l->brightness_set_blocking = mv88e6xxx_led1_brightness_set_blocking;
> +			l->blink_set = mv88e6xxx_led1_blink_set;
> +			l->hw_control_is_supported = mv88e6xxx_led1_hw_control_is_supported;
> +			l->hw_control_set = mv88e6xxx_led1_hw_control_set;
> +			l->hw_control_get = mv88e6xxx_led1_hw_control_get;
> +			l->hw_control_get_device = mv88e6xxx_led1_hw_control_get_device;
> +		}
> +		l->hw_control_trigger = "netdev";
> +
> +		init_data.default_label = ":port";
> +		init_data.fwnode = led;
> +		init_data.devname_mandatory = true;
> +		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d:0%d", chip->info->name,
> +						 port, led_num);
> +		if (!init_data.devicename)
> +			return -ENOMEM;
> +
> +		ret = devm_led_classdev_register_ext(dev, l, &init_data);
> +		if (ret)
> +			dev_err(dev, "Failed to init LED %d for port %d", led_num, port);

I would also return this error. If we got this far, we don't expect an
error.

> +
> +		kfree(init_data.devicename);
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
> index 5394a8cf7bf1..d72bba1969f7 100644
> --- a/drivers/net/dsa/mv88e6xxx/port.c
> +++ b/drivers/net/dsa/mv88e6xxx/port.c
> @@ -12,6 +12,7 @@
>  #include <linux/if_bridge.h>
>  #include <linux/phy.h>
>  #include <linux/phylink.h>
> +#include <linux/property.h>
>  
>  #include "chip.h"
>  #include "global2.h"

Since this is the complete change to this file, is the new include
really needed?


    Andrew

---
pw-bot: cr

