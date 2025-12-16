Return-Path: <netdev+bounces-245031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C578CC593A
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 01:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E9BD300EE75
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 00:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D431D6AA;
	Wed, 17 Dec 2025 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPkmJ4Io"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB11E495E5
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 00:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765930701; cv=none; b=DoR48MoeVOqKKY66lANTq0YdeRRnBq8TdKW3EiAGXEiA3j214Zn715AEBplRFDiSPkUSKhByZPNJjS7qYMERtrUpHxYQpt/6HF0b4x5pU01zyi069gWXXTsxaJ6nlp8kirE4zbqL9tD5JHh0FtOSiSoSYG2Zwf3b58P1pHjF4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765930701; c=relaxed/simple;
	bh=hFg+VKlJIq5XTbORAjn6Rq+qbYjZYC0Pv7CZj4zLRNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjEuwtkuT4cnJQaoBpMPv/F1wfAZoMAM5gEqY4gwB5Gb6KnT7j30MpSXY9smQ8MoKI9Prc1Hsc7UX0V63mv+pX63T9+oZ0ciuODkHQ0FcsdAMxNQBVcYIh8BWmJ6SF4y1ZZ2rwvaIWOFr7g2xC7cfr6uQlkUvzH39bMxuHIcyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPkmJ4Io; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5990ee705e6so169193e87.1
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 16:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765930697; x=1766535497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4nVnVpD+JcDCrZoHENWZDEA/8RfS4yZ+gqGfhy8uHE=;
        b=OPkmJ4Io2kANEAjJZ7DptOQcAMx0wW08xA88IrgQlb/X6Y88uq1rtI6mfCGZLggGfD
         k3J0tfjPjV/xWtFlXd+f4f6A3G1f8bQYF39XbhhH5OUB1Okl0EoPsazyWcYZkRcJkUic
         o5QXz6AHbdpbei6g6Himfa+sftH4ZWrMr91MhB/jOgXjlz9JssXlx2b1Ky8JM25eX+Xe
         rN8KBQQLttShuLS3mDDkQLC+UYWwXzN48T9uH45zFBAlbmrvqpouQAYBxEAd1nkM9QQS
         Ds2yizUtO/ZVSRfZu+DdEDgnPLiZQmH0BhTMW8R3wrYZuzbryD4Zal0FhEhQbgtc1nM6
         3Saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765930697; x=1766535497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4nVnVpD+JcDCrZoHENWZDEA/8RfS4yZ+gqGfhy8uHE=;
        b=N0AdsdTbB5LtFy3W/x1i7a7FQzTZmHVpMpoR7xOhnrYiXquAuxzrtBL+NGbB1T8MLU
         /k2N0TNmEC2yI/qZR4nA8nj0eFaDVNVuMj9P47DLxMRXhlp0MgcdthFeMrSLQl8QLqLO
         Qxcw2JfDm6whynzai4RYFkfLzx0yb9W9VMAERLkBkFhkj8ys4fQUtsvq/ARZHo+qHsrP
         I+EPEJObmAb9DRqh5hzgStNONg3Pldt+35wvj67NVmgeBvk2+skSoZwHbBn4loPeEn39
         Q0CpqJVwEB1cQYMa4YyDAoog8nmtOHwtz7xiPny3DucKCEGXcP1ZZp2WWFgg393+5DXv
         4ZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBYtE/GdWerz72G2gaV8oar0jUI9l/dJkW6yW7S3S6OjxQUz35TdwmWDU1qzuLCyileCu/LKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG2Yk1sNkk8l6slDYjKzk3ajj43jZnMwBBdn8hxfyaClqirtPV
	/CJlzEYSW5YwBFkqi7yNjpPBhjukeve2jJ9Vf22ldoMNEfAnSLzHIqmfQoPjjw==
X-Gm-Gg: AY/fxX4w8TBOr7rcklyYHr558aAsezVjVwjF3XdMwYNk40/HrmQ8HvB1md56LFNBzJC
	X9vSaG8B2b0rQSvRJXODm480JBG4k0wesEMV60fC7XnqWJeExwqgY6+f+gJyzyuFcW6DS9FR8Bx
	5DPlR5MEjo1C8w2lMpTBnWame1tvRHkmcBrFpty2Pq/TyehVag/K/+gzCQ/LWRqZfVxntbGkcN9
	sfAyfD/xIOmZj9exS1qBXrVODZnt1ItVIqnML37gGpCYzfvCVHxaZKH+iwIWES6TUeq0F+lH9Mv
	x3Q9A1x1a7VFqmGLDJTjjGu7vq38zMHmy7ykj8aKFwh0/Je096o2fFQm5fUNuuMrZCVs/lkRbp7
	fFMBtZt8tFQl0p/s5TX1WkTLJflxKo0DU4jgSQx3EmDXSK0f4/SmlecuZsqvOQhzlVfPaYRLVTr
	Fw
X-Google-Smtp-Source: AGHT+IEVPQxHfN39k9pspw4VfqB572a4Rx5TDeTI/7mTKTpE5Y9G5LWnugTOOj7EeObsFsuCLHZZEA==
X-Received: by 2002:a05:600c:3107:b0:471:3b6:e24 with SMTP id 5b1f17b1804b1-47bd42e2903mr31099575e9.8.1765925001264;
        Tue, 16 Dec 2025 14:43:21 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:c18:aa1:b847:17e5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bdc1e5e73sm10259205e9.10.2025.12.16.14.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 14:43:20 -0800 (PST)
Date: Wed, 17 Dec 2025 00:43:17 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next v3 4/4] net: dsa: add basic initial driver
 for MxL862xx switches
Message-ID: <20251216224317.maxhcdsuqqxnywmu@skbuf>
References: <cover.1765757027.git.daniel@makrotopia.org>
 <cover.1765757027.git.daniel@makrotopia.org>
 <63aa4a502c73e08e184cc74c2e9c1c939ed93f33.1765757027.git.daniel@makrotopia.org>
 <63aa4a502c73e08e184cc74c2e9c1c939ed93f33.1765757027.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63aa4a502c73e08e184cc74c2e9c1c939ed93f33.1765757027.git.daniel@makrotopia.org>
 <63aa4a502c73e08e184cc74c2e9c1c939ed93f33.1765757027.git.daniel@makrotopia.org>

On Mon, Dec 15, 2025 at 12:12:20AM +0000, Daniel Golle wrote:
> Add very basic DSA driver for MaxLinear's MxL862xx switches.
> 
> In contrast to previous MaxLinear switches the MxL862xx has a built-in
> processor that runs a sophisticated firmware based on Zephyr RTOS.
> Interaction between the host and the switch hence is organized using a
> software API of that firmware rather than accessing hardware registers
> directly.
> 
> Add descriptions of the most basic firmware API calls to access the
> built-in MDIO bus hosting the 2.5GE PHYs, basic port control as well as
> setting up the CPU port.
> 
> Implement a very basic DSA driver using that API which is sufficient to
> get packets flowing between the user ports and the CPU port.
> 
> The firmware offers all features one would expect from a modern switch
> hardware, they will be added one by one in follow-up patch series.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> RFC v3:
>  * fix return value being uninitialized on error in mxl862xx_api_wrap()
>  * add missing descrition in kerneldoc comment of
>    struct mxl862xx_ss_sp_tag
> 
> RFC v2:
>  * make use of struct mdio_device
>  * add phylink_mac_ops stubs
>  * drop leftover nonsense from mxl862xx_phylink_get_caps()
>  * use __le32 instead of enum types in over-the-wire structs
>  * use existing MDIO_* macros whenever possible
>  * simplify API constants to be more readable
>  * use readx_poll_timeout instead of open-coding poll timeout loop
>  * add mxl862xx_reg_read() and mxl862xx_reg_write() helpers
>  * demystify error codes returned by the firmware
>  * add #defines for mxl862xx_ss_sp_tag member values
>  * move reset to dedicated function, clarify magic number being the
>    reset command ID
> 
>  MAINTAINERS                              |   1 +
>  drivers/net/dsa/Kconfig                  |   2 +
>  drivers/net/dsa/Makefile                 |   1 +
>  drivers/net/dsa/mxl862xx/Kconfig         |  12 +
>  drivers/net/dsa/mxl862xx/Makefile        |   3 +
>  drivers/net/dsa/mxl862xx/mxl862xx-api.h  | 118 ++++++++
>  drivers/net/dsa/mxl862xx/mxl862xx-cmd.h  |  28 ++
>  drivers/net/dsa/mxl862xx/mxl862xx-host.c | 230 +++++++++++++++
>  drivers/net/dsa/mxl862xx/mxl862xx-host.h |   4 +
>  drivers/net/dsa/mxl862xx/mxl862xx.c      | 361 +++++++++++++++++++++++
>  drivers/net/dsa/mxl862xx/mxl862xx.h      |  24 ++
>  11 files changed, 784 insertions(+)
>  create mode 100644 drivers/net/dsa/mxl862xx/Kconfig
>  create mode 100644 drivers/net/dsa/mxl862xx/Makefile
>  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-api.h
>  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
>  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.c
>  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.h
>  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.c
>  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a20498cc8320b..17ca0351cc5b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15609,6 +15609,7 @@ M:	Daniel Golle <daniel@makrotopia.org>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
> +F:	drivers/net/dsa/mxl862xx/
>  F:	net/dsa/tag_mxl862xx.c
>  
>  MCAN DEVICE DRIVER
> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 7eb301fd987d1..18f6e8b7f4cb2 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -74,6 +74,8 @@ source "drivers/net/dsa/microchip/Kconfig"
>  
>  source "drivers/net/dsa/mv88e6xxx/Kconfig"
>  
> +source "drivers/net/dsa/mxl862xx/Kconfig"
> +
>  source "drivers/net/dsa/ocelot/Kconfig"
>  
>  source "drivers/net/dsa/qca/Kconfig"
> diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
> index 16de4ba3fa388..f5a463b87ec25 100644
> --- a/drivers/net/dsa/Makefile
> +++ b/drivers/net/dsa/Makefile
> @@ -20,6 +20,7 @@ obj-y				+= hirschmann/
>  obj-y				+= lantiq/
>  obj-y				+= microchip/
>  obj-y				+= mv88e6xxx/
> +obj-y				+= mxl862xx/
>  obj-y				+= ocelot/
>  obj-y				+= qca/
>  obj-y				+= realtek/
> diff --git a/drivers/net/dsa/mxl862xx/Kconfig b/drivers/net/dsa/mxl862xx/Kconfig
> new file mode 100644
> index 0000000000000..5c538dfc2763e
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config NET_DSA_MXL862
> +	tristate "MaxLinear MxL862xx"
> +	depends on NET_DSA
> +	select MAXLINEAR_GPHY
> +	select NET_DSA_TAG_MXL862
> +	help
> +	  This enables support for the MaxLinear MxL862xx switch family.
> +	  These switches got two 10GE SerDes interfaces, one typically

s/got/have/

> +	  used as CPU port.
> +	   MxL86282 Eight 2.5 Gigabit PHYs
> +	   MxL86252 Five 2.5 Gigabit PHYs

These sentences are missing the verb "has"?

> \ No newline at end of file
> diff --git a/drivers/net/dsa/mxl862xx/Makefile b/drivers/net/dsa/mxl862xx/Makefile
> new file mode 100644
> index 0000000000000..d23dd3cd511d4
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_NET_DSA_MXL862) += mxl862xx_dsa.o
> +mxl862xx_dsa-y := mxl862xx.o mxl862xx-host.o
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-api.h b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
> new file mode 100644
> index 0000000000000..e2b0a04366aa6
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
> @@ -0,0 +1,118 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/**
> + * struct mdio_relay_data - relayed access to the switch internal MDIO bus
> + * @data: data to be read or written
> + * @phy: PHY index
> + * @mmd: MMD device
> + * @reg: register rndex

s/rndex/index/

> + */
> +struct mdio_relay_data {
> +	__le16 data;
> +	u8 phy;
> +	u8 mmd;
> +	__le16 reg;
> +} __packed;
> +
> +/* Register access parameter to directly modify internal registers */
> +struct mxl862xx_register_mod {
> +	__le16 addr;
> +	__le16 data;
> +	__le16 mask;
> +} __packed;
> +
> +#define MXL862XX_SS_SP_TAG_MASK_RX			BIT(0)
> +#define MXL862XX_SS_SP_TAG_MASK_TX			BIT(1)
> +#define MXL862XX_SS_SP_TAG_MASK_RX_PEN			BIT(2)
> +#define MXL862XX_SS_SP_TAG_MASK_TX_PEN			BIT(3)
> +
> +#define MXL862XX_SS_SP_TAG_RX_NO_TAG_NO_INSERT		0
> +#define MXL862XX_SS_SP_TAG_RX_NO_TAG_INSERT		1
> +#define MXL862XX_SS_SP_TAG_RX_TAG_NO_INSERT		2
> +
> +#define MXL862XX_SS_SP_TAG_TX_NO_TAG_NO_REMOVE		0
> +#define MXL862XX_SS_SP_TAG_TX_TAG_REPLACE		1
> +#define MXL862XX_SS_SP_TAG_TX_TAG_NO_REMOVE		2
> +#define MXL862XX_SS_SP_TAG_TX_TAG_REMOVE		3
> +
> +/**
> + * struct mxl862xx_ss_sp_tag - Special tag port settings
> + * @pid: port ID (1~16)
> + * @mask: bit value 1 to indicate valid field
> + *	0 - rx
> + *	1 - tx
> + *	2 - rx_pen
> + *	3 - tx_pen
> + * @rx: RX special tag mode
> + *	0 - packet does NOT have special tag and special tag is NOT inserted
> + *	1 - packet does NOT have special tag and special tag is inserted
> + *	2 - packet has special tag and special tag is NOT inserted
> + * @tx: TX special tag mode
> + *	0 - packet does NOT have special tag and special tag is NOT removed
> + *	1 - packet has special tag and special tag is replaced
> + *	2 - packet has special tag and special tag is NOT removed
> + *	3 - packet has special tag and special tag is removed
> + * @rx_pen: RX special tag info over preamble
> + *	0 - special tag info inserted from byte 2 to 7 are all 0
> + *	1 - special tag byte 5 is 16, other bytes from 2 to 7 are 0
> + *	2 - special tag byte 5 is from preamble field, others are 0
> + *	3 - special tag byte 2 to 7 are from preabmle field
> + * @tx_pen: TX special tag info over preamble
> + *	0 - disabled
> + *	1 - enabled
> + */
> +struct mxl862xx_ss_sp_tag {
> +	u8 pid;
> +	u8 mask;
> +	u8 rx;
> +	u8 tx;
> +	u8 rx_pen;
> +	u8 tx_pen;
> +} __packed;
> +
> +/**
> + * enum mxl862xx_logical_port_mode - Logical port mode
> + * @MXL862XX_LOGICAL_PORT_8BIT_WLAN: WLAN with 8-bit station ID
> + * @MXL862XX_LOGICAL_PORT_9BIT_WLAN: WLAN with 9-bit station ID
> + * @MXL862XX_LOGICAL_PORT_GPON: GPON OMCI context
> + * @MXL862XX_LOGICAL_PORT_EPON: EPON context
> + * @MXL862XX_LOGICAL_PORT_GINT: G.INT context
> + * @MXL862XX_LOGICAL_PORT_OTHER: Others
> + */
> +enum mxl862xx_logical_port_mode {
> +	MXL862XX_LOGICAL_PORT_8BIT_WLAN = 0,
> +	MXL862XX_LOGICAL_PORT_9BIT_WLAN,
> +	MXL862XX_LOGICAL_PORT_GPON,
> +	MXL862XX_LOGICAL_PORT_EPON,
> +	MXL862XX_LOGICAL_PORT_GINT,
> +	MXL862XX_LOGICAL_PORT_OTHER = 0xFF,
> +};
> +
> +/**
> + * struct mxl862xx_ctp_port_assignment - CTP Port Assignment/association with logical port

What is a CTP port? Logical port? Why is the "GPON" logical port mode
for the DSA CPU port preferable to its alternatives?

> + * @logical_port_id: Logical Port Id. The valid range is hardware dependent
> + * @first_ctp_port_id: First CTP Port ID mapped to above logical port ID
> + * @number_of_ctp_port: Total number of CTP Ports mapped above logical port ID
> + * @mode: See &enum mxl862xx_logical_port_mode
> + * @bridge_port_id: Bridge ID (FID)
> + */
> +struct mxl862xx_ctp_port_assignment {
> +	u8 logical_port_id;
> +	__le16 first_ctp_port_id;
> +	__le16 number_of_ctp_port;
> +	__le32 mode; /* enum mxl862xx_logical_port_mode */
> +	__le16 bridge_port_id;
> +} __packed;

Can you confirm this alignment is correct? __le32 mode begins with byte
offset 5 of the structure. I haven't decompiled the code, but I suppose
the compiler will have to perform byte by byte accesses.

> +
> +/**
> + * struct mxl862xx_sys_fw_image_version - Firmware version information
> + * @iv_major: firmware major version
> + * @iv_minor: firmware minor version
> + * @iv_revision: firmware revision
> + * @iv_build_num: firmware build number
> + */
> +struct mxl862xx_sys_fw_image_version {
> +	u8 iv_major;
> +	u8 iv_minor;
> +	__le16 iv_revision;
> +	__le32 iv_build_num;
> +} __packed;
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
> new file mode 100644
> index 0000000000000..db6a4c3f54f22
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#define MXL862XX_MMD_DEV 30
> +#define MXL862XX_MMD_REG_CTRL 0
> +#define MXL862XX_MMD_REG_LEN_RET 1
> +#define MXL862XX_MMD_REG_DATA_FIRST 2
> +#define MXL862XX_MMD_REG_DATA_LAST 95
> +#define MXL862XX_MMD_REG_DATA_MAX_SIZE \
> +	(MXL862XX_MMD_REG_DATA_LAST - MXL862XX_MMD_REG_DATA_FIRST + 1)
> +
> +#define MXL862XX_COMMON_MAGIC 0x100
> +#define MXL862XX_CTP_MAGIC 0x500
> +#define MXL862XX_SS_MAGIC 0x1600
> +#define GPY_GPY2XX_MAGIC 0x1800
> +#define SYS_MISC_MAGIC 0x1900
> +
> +#define MXL862XX_COMMON_REGISTERMOD (MXL862XX_COMMON_MAGIC + 0x11)
> +
> +#define MXL862XX_CTP_PORTASSIGNMENTSET (MXL862XX_CTP_MAGIC + 0x3)
> +
> +#define MXL862XX_SS_SPTAG_SET (MXL862XX_SS_MAGIC + 0x02)
> +
> +#define INT_GPHY_READ (GPY_GPY2XX_MAGIC + 0x01)
> +#define INT_GPHY_WRITE (GPY_GPY2XX_MAGIC + 0x02)
> +
> +#define SYS_MISC_FW_VERSION (SYS_MISC_MAGIC + 0x02)
> +
> +#define MMD_API_MAXIMUM_ID 0x7FFF
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> new file mode 100644
> index 0000000000000..ca13c43bd9efa
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Based upon the Maxlinear SDK driver
> + *
> + * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
> + * Copyright (C) 2025 John Crispin <john@phrozen.org>
> + * Copyright (C) 2024 MaxLinear Inc.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/iopoll.h>
> +#include <net/dsa.h>
> +#include "mxl862xx.h"
> +#include "mxl862xx-host.h"
> +
> +#define CTRL_BUSY_MASK			BIT(15)
> +
> +#define MXL862XX_MMD_REG_CTRL		0
> +#define MXL862XX_MMD_REG_LEN_RET	1
> +#define MXL862XX_MMD_REG_DATA_FIRST	2
> +#define MXL862XX_MMD_REG_DATA_LAST	95
> +#define MXL862XX_MMD_REG_DATA_MAX_SIZE \
> +		(MXL862XX_MMD_REG_DATA_LAST - MXL862XX_MMD_REG_DATA_FIRST + 1)
> +
> +#define MMD_API_SET_DATA_0		2
> +#define MMD_API_GET_DATA_0		5
> +#define MMD_API_RST_DATA		8
> +
> +#define MXL862XX_SWITCH_RESET 0x9907
> +
> +static int mxl862xx_reg_read(struct mxl862xx_priv *priv, u32 addr)
> +{
> +	return __mdiodev_c45_read(priv->mdiodev, MDIO_MMD_VEND1, addr);
> +}
> +
> +static int mxl862xx_reg_write(struct mxl862xx_priv *priv, u32 addr, u16 data)
> +{
> +	return __mdiodev_c45_write(priv->mdiodev, MDIO_MMD_VEND1, addr, data);
> +}
> +
> +static int mxl862xx_ctrl_read(struct mxl862xx_priv *priv)
> +{
> +	return mxl862xx_reg_read(priv, MXL862XX_MMD_REG_CTRL);
> +}
> +
> +static int mxl862xx_busy_wait(struct mxl862xx_priv *priv)
> +{
> +	int val;
> +
> +	return readx_poll_timeout(mxl862xx_ctrl_read, priv, val,
> +				  !(val & CTRL_BUSY_MASK), 15, 10000);
> +}
> +
> +static int mxl862xx_set_data(struct mxl862xx_priv *priv, u16 words)
> +{
> +	int ret;
> +	u16 cmd;
> +
> +	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_LEN_RET,
> +				 MXL862XX_MMD_REG_DATA_MAX_SIZE * sizeof(u16));
> +	if (ret < 0)
> +		return ret;
> +
> +	cmd = words / MXL862XX_MMD_REG_DATA_MAX_SIZE - 1;
> +	if (!(cmd < 2))
> +		return -EINVAL;
> +
> +	cmd += MMD_API_SET_DATA_0;
> +	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_CTRL,
> +				 cmd | CTRL_BUSY_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	return mxl862xx_busy_wait(priv);
> +}
> +
> +static int mxl862xx_get_data(struct mxl862xx_priv *priv, u16 words)
> +{
> +	int ret;
> +	u16 cmd;
> +
> +	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_LEN_RET,
> +				 MXL862XX_MMD_REG_DATA_MAX_SIZE * sizeof(u16));
> +	if (ret < 0)
> +		return ret;
> +
> +	cmd = words / MXL862XX_MMD_REG_DATA_MAX_SIZE;
> +	if (!(cmd > 0 && cmd < 3))
> +		return -EINVAL;
> +
> +	cmd += MMD_API_GET_DATA_0;
> +	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_CTRL,
> +				 cmd | CTRL_BUSY_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	return mxl862xx_busy_wait(priv);
> +}
> +
> +static int mxl862xx_send_cmd(struct mxl862xx_priv *priv, u16 cmd, u16 size)

Can you document what this function is supposed to return on success?
Seems something non-zero, otherwise you wouldn't bother saving it in cmd_ret,
I guess.

> +{
> +	int ret;
> +
> +	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_LEN_RET, size);
> +	if (ret)
> +		return ret;
> +
> +	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_CTRL,
> +				 cmd | CTRL_BUSY_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret = mxl862xx_busy_wait(priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = mxl862xx_reg_read(priv, MXL862XX_MMD_REG_LEN_RET);
> +	/* handle errors returned by the firmware as -EIO
> +	 * The firmware is based on Zephyr OS and uses the errors as
> +	 * defined in errno.h of Zephyr OS. See
> +	 * https://github.com/zephyrproject-rtos/zephyr/blob/v3.7.0/lib/libc/minimal/include/errno.h
> +	 */
> +	if ((s16)ret < 0) {
> +		dev_err(&priv->mdiodev->dev, "CMD %04x returned error %d\n",
> +			cmd, (s16)ret);
> +		return -EIO;
> +	}
> +
> +	return ret;
> +}
> +
> +int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
> +		      u16 size, bool read)
> +{
> +	__le16 *data = _data;
> +	u16 max, i;
> +	int ret, cmd_ret;
> +
> +	dev_dbg(&priv->mdiodev->dev, "CMD %04x DATA %*ph\n", cmd, size, data);
> +
> +	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
> +
> +	max = (size + 1) / 2;
> +
> +	ret = mxl862xx_busy_wait(priv);
> +	if (ret < 0)
> +		goto out;
> +
> +	for (i = 0; i < max; i++) {
> +		u16 off = i % MXL862XX_MMD_REG_DATA_MAX_SIZE;
> +
> +		if (i && off == 0) {
> +			/* Send command to set data when every
> +			 * MXL862XX_MMD_REG_DATA_MAX_SIZE of WORDs are written.
> +			 */
> +			ret = mxl862xx_set_data(priv, i);
> +			if (ret < 0)
> +				goto out;
> +		}
> +
> +		ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_DATA_FIRST + off,
> +					 le16_to_cpu(data[i]));
> +		if (ret < 0)
> +			goto out;

I have only superficially looked at this, but doesn't writing need
special handling if the buffer size is odd, like reading does?

> +	}
> +
> +	ret = mxl862xx_send_cmd(priv, cmd, size);
> +	if (ret < 0 || !read)
> +		goto out;
> +
> +	/* store result of mxl862xx_send_cmd() */
> +	cmd_ret = ret;
> +
> +	for (i = 0; i < max; i++) {
> +		u16 off = i % MXL862XX_MMD_REG_DATA_MAX_SIZE;
> +
> +		if (i && off == 0) {
> +			/* Send command to fetch next batch of data when every
> +			 * MXL862XX_MMD_REG_DATA_MAX_SIZE of WORDs are read.
> +			 */
> +			ret = mxl862xx_get_data(priv, i);
> +			if (ret < 0)
> +				goto out;
> +		}
> +
> +		ret = mxl862xx_reg_read(priv, MXL862XX_MMD_REG_DATA_FIRST + off);
> +		if (ret < 0)
> +			goto out;
> +
> +		if ((i * 2 + 1) == size) {
> +			/* Special handling for last BYTE if it's not WORD
> +			 * aligned.
> +			 */
> +			*(uint8_t *)&data[i] = ret & 0xFF;
> +		} else {
> +			data[i] = cpu_to_le16((u16)ret);
> +		}
> +	}
> +
> +	/* on success return the result of the mxl862xx_send_cmd() */
> +	ret = cmd_ret;
> +
> +	dev_dbg(&priv->mdiodev->dev, "RET %d DATA %*ph\n", ret, size, data);
> +
> +out:
> +	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
> +
> +	return ret;
> +}
> +
> +int mxl862xx_reset(struct mxl862xx_priv *priv)
> +{
> +	int ret;
> +
> +	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
> +
> +	/* Software reset */
> +	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_LEN_RET, 0);
> +	if (ret)
> +		goto out;
> +
> +	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_CTRL, MXL862XX_SWITCH_RESET);
> +out:
> +	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
> +
> +	if (!ret)
> +		usleep_range(4000000, 6000000);

This unconditionally sleeps 4 to 6 seconds after a reset?
Does the reset command reboot Zephyr?
Are we unable to know when we have communication with the firmware again?
Like read SYS_MISC_FW_VERSION until it's equal to what was originally
read during probing? Does this save any time?

> +
> +	return ret;
> +}
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.h b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
> new file mode 100644
> index 0000000000000..eb5acb81feea6
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
> @@ -0,0 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *data, u16 size, bool read);
> +int mxl862xx_reset(struct mxl862xx_priv *priv);
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> new file mode 100644
> index 0000000000000..8e0dcfeb3b5c2
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
> @@ -0,0 +1,361 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for MaxLinear MxL862xx switch family
> + *
> + * Copyright (C) 2024 MaxLinear Inc.
> + * Copyright (C) 2025 John Crispin <john@phrozen.org>
> + * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/of_device.h>
> +#include <linux/of_mdio.h>
> +#include <linux/phy.h>
> +#include <linux/phylink.h>
> +#include <net/dsa.h>
> +
> +#include "mxl862xx.h"
> +#include "mxl862xx-api.h"
> +#include "mxl862xx-cmd.h"
> +#include "mxl862xx-host.h"
> +
> +#define MXL862XX_API_WRITE(dev, cmd, data) \
> +	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false)
> +#define MXL862XX_API_READ(dev, cmd, data) \
> +	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true)
> +
> +#define DSA_MXL_PORT(port) ((port) + 1)
> +
> +#define MXL862XX_SDMA_PCTRLP(p) (0xBC0 + ((p) * 0x6))
> +#define MXL862XX_SDMA_PCTRL_EN BIT(0)
> +
> +#define MXL862XX_FDMA_PCTRLP(p) (0xA80 + ((p) * 0x6))
> +#define MXL862XX_FDMA_PCTRL_EN BIT(0)
> +
> +/* PHY access via firmware relay */
> +static int mxl862xx_phy_read_mmd(struct mxl862xx_priv *priv, int port,
> +				 int devadd, int reg)
> +{
> +	struct mdio_relay_data param = {
> +		.phy = port,
> +		.mmd = devadd,
> +		.reg = cpu_to_le16(reg),
> +	};
> +	int ret;
> +
> +	ret = MXL862XX_API_READ(priv, INT_GPHY_READ, param);
> +	if (ret)
> +		return ret;
> +
> +	return le16_to_cpu(param.data);
> +}
> +
> +static int mxl862xx_phy_write_mmd(struct mxl862xx_priv *priv, int port,
> +				  int devadd, int reg, u16 data)
> +{
> +	struct mdio_relay_data param = {
> +		.phy = port,
> +		.mmd = devadd,
> +		.reg = cpu_to_le16(reg),
> +		.data = cpu_to_le16(data),
> +	};
> +
> +	return MXL862XX_API_WRITE(priv, INT_GPHY_WRITE, param);
> +}
> +
> +static int mxl862xx_phy_read(struct dsa_switch *ds, int port, int reg)
> +{
> +	return mxl862xx_phy_read_mmd(ds->priv, port, 0, reg);
> +}
> +
> +static int mxl862xx_phy_write(struct dsa_switch *ds, int port, int reg, u16 data)
> +{
> +	return mxl862xx_phy_write_mmd(ds->priv, port, 0, reg, data);
> +}
> +
> +static int mxl862xx_configure_tag_proto(struct dsa_port *dp, bool enable)

Why pass "bool enable" if you always set it to true?

> +{
> +	struct mxl862xx_ctp_port_assignment assign = {
> +		.number_of_ctp_port = cpu_to_le16(enable ? (32 - DSA_MXL_PORT(dp->index)) : 1),
> +		.logical_port_id = DSA_MXL_PORT(dp->index),
> +		.first_ctp_port_id = cpu_to_le16(DSA_MXL_PORT(dp->index)),
> +		.mode = cpu_to_le32(MXL862XX_LOGICAL_PORT_GPON),
> +	};
> +	struct mxl862xx_ss_sp_tag tag = {
> +		.pid = DSA_MXL_PORT(dp->index),
> +		.mask = MXL862XX_SS_SP_TAG_MASK_RX | MXL862XX_SS_SP_TAG_MASK_TX,
> +		.rx = enable ? MXL862XX_SS_SP_TAG_RX_TAG_NO_INSERT :
> +			       MXL862XX_SS_SP_TAG_RX_NO_TAG_INSERT,
> +		.tx = enable ? MXL862XX_SS_SP_TAG_TX_TAG_NO_REMOVE :
> +			       MXL862XX_SS_SP_TAG_TX_TAG_REMOVE,
> +	};
> +	int ret;
> +
> +	ret = MXL862XX_API_WRITE(dp->ds->priv, MXL862XX_SS_SPTAG_SET, tag);
> +	if (ret)
> +		return ret;
> +
> +	return MXL862XX_API_WRITE(dp->ds->priv, MXL862XX_CTP_PORTASSIGNMENTSET, assign);
> +}
> +
> +static int mxl862xx_port_state(struct dsa_switch *ds, int port, bool enable)
> +{
> +	struct mxl862xx_register_mod sdma = {
> +		.addr = cpu_to_le16(MXL862XX_SDMA_PCTRLP(DSA_MXL_PORT(port))),
> +		.data = cpu_to_le16(enable ? MXL862XX_SDMA_PCTRL_EN : 0),
> +		.mask = cpu_to_le16(MXL862XX_SDMA_PCTRL_EN),
> +	};
> +	struct mxl862xx_register_mod fdma = {
> +		.addr = cpu_to_le16(MXL862XX_FDMA_PCTRLP(DSA_MXL_PORT(port))),
> +		.data = cpu_to_le16(enable ? MXL862XX_FDMA_PCTRL_EN : 0),
> +		.mask = cpu_to_le16(MXL862XX_FDMA_PCTRL_EN),
> +	};
> +	int ret;
> +
> +	if (!dsa_is_user_port(ds, port))
> +		return 0;

I am a bit surprised that the CPU ports don't need the Fetch DMA and the
Store DMA enabled? Perhaps I don't understand what these blocks do.

> +
> +	ret = MXL862XX_API_WRITE(ds->priv, MXL862XX_COMMON_REGISTERMOD, sdma);
> +	if (ret)
> +		return ret;
> +
> +	return MXL862XX_API_WRITE(ds->priv, MXL862XX_COMMON_REGISTERMOD, fdma);
> +}
> +
> +static int mxl862xx_port_enable(struct dsa_switch *ds, int port,
> +				struct phy_device *phydev)
> +{
> +	return mxl862xx_port_state(ds, port, true);
> +}
> +
> +static void mxl862xx_port_disable(struct dsa_switch *ds, int port)
> +{
> +	mxl862xx_port_state(ds, port, false);
> +}
> +
> +static int mxl862xx_phy_read_mii_bus(struct mii_bus *bus, int port, int regnum)
> +{
> +	return mxl862xx_phy_read_mmd(bus->priv, port, 0, regnum);
> +}
> +
> +static int mxl862xx_phy_write_mii_bus(struct mii_bus *bus, int port,
> +				      int regnum, u16 val)
> +{
> +	return mxl862xx_phy_write_mmd(bus->priv, port, 0, regnum, val);
> +}
> +
> +static int mxl862xx_phy_read_c45_mii_bus(struct mii_bus *bus, int port,
> +					 int devadd, int regnum)
> +{
> +	return mxl862xx_phy_read_mmd(bus->priv, port, devadd, regnum);
> +}
> +
> +static int mxl862xx_phy_write_c45_mii_bus(struct mii_bus *bus, int port,
> +					  int devadd, int regnum, u16 val)
> +{
> +	return mxl862xx_phy_write_mmd(bus->priv, port, devadd, regnum, val);
> +}
> +
> +static int mxl862xx_setup_mdio(struct dsa_switch *ds)
> +{
> +	struct mxl862xx_priv *priv = ds->priv;
> +	struct device *dev = ds->dev;
> +	struct device_node *mdio_np;
> +	struct mii_bus *bus;
> +	static int idx;
> +	int ret;
> +
> +	bus = devm_mdiobus_alloc(dev);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->priv = priv;
> +	ds->user_mii_bus = bus;
> +	bus->name = KBUILD_MODNAME "-mii";
> +	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
> +	bus->read_c45 = mxl862xx_phy_read_c45_mii_bus;
> +	bus->write_c45 = mxl862xx_phy_write_c45_mii_bus;
> +	bus->read = mxl862xx_phy_read_mii_bus;
> +	bus->write = mxl862xx_phy_write_mii_bus;
> +	bus->parent = dev;
> +	bus->phy_mask = ~ds->phys_mii_mask;
> +
> +	mdio_np = of_get_child_by_name(dev->of_node, "mdio");
> +	if (!mdio_np)
> +		return -ENODEV;
> +
> +	ret = devm_of_mdiobus_register(dev, bus, mdio_np);
> +	of_node_put(mdio_np);
> +
> +	return ret;
> +}
> +
> +static void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
> +				      struct phylink_config *config)
> +{
> +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
> +				   MAC_100 | MAC_1000 | MAC_2500FD;
> +
> +	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +		  config->supported_interfaces);
> +}
> +
> +static enum dsa_tag_protocol mxl862xx_get_tag_protocol(struct dsa_switch *ds,
> +						       int port,
> +						       enum dsa_tag_protocol m)
> +{
> +	return DSA_TAG_PROTO_MXL862;
> +}
> +
> +static int mxl862xx_setup(struct dsa_switch *ds)
> +{
> +	struct mxl862xx_priv *priv = ds->priv;
> +	struct dsa_port *cpu_dp;
> +	int ret;
> +
> +	ret = mxl862xx_reset(priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = mxl862xx_setup_mdio(ds);
> +	if (ret)
> +		return ret;
> +
> +	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
> +		ret = mxl862xx_configure_tag_proto(cpu_dp, true);
> +		if (ret)
> +			return ret;
> +	}

Do the ports know not to forward packets between each other by default,
just to the CPU port? Which setting does that? Is address learning
turned off on user ports, since they are operating as standalone?

> +
> +	return 0;
> +}
> +
> +static const struct dsa_switch_ops mxl862xx_switch_ops = {
> +	.get_tag_protocol = mxl862xx_get_tag_protocol,
> +	.phylink_get_caps = mxl862xx_phylink_get_caps,
> +	.phy_read = mxl862xx_phy_read,
> +	.phy_write = mxl862xx_phy_write,
> +	.port_disable = mxl862xx_port_disable,
> +	.port_enable = mxl862xx_port_enable,
> +	.setup = mxl862xx_setup,
> +};
> +
> +static void mxl862xx_phylink_mac_config(struct phylink_config *config,
> +					unsigned int mode,
> +					const struct phylink_link_state *state)
> +{
> +}
> +
> +static void mxl862xx_phylink_mac_link_down(struct phylink_config *config,
> +					   unsigned int mode,
> +					   phy_interface_t interface)
> +{
> +}
> +
> +static void mxl862xx_phylink_mac_link_up(struct phylink_config *config,
> +					 struct phy_device *phydev,
> +					 unsigned int mode,
> +					 phy_interface_t interface,
> +					 int speed, int duplex,
> +					 bool tx_pause, bool rx_pause)
> +{
> +}
> +
> +static struct phylink_pcs *
> +mxl862xx_phylink_mac_select_pcs(struct phylink_config *config,
> +				phy_interface_t interface)
> +{
> +	return NULL;
> +}
> +
> +static const struct phylink_mac_ops mxl862xx_phylink_mac_ops = {
> +	.mac_config = mxl862xx_phylink_mac_config,
> +	.mac_link_down = mxl862xx_phylink_mac_link_down,
> +	.mac_link_up = mxl862xx_phylink_mac_link_up,
> +	.mac_select_pcs = mxl862xx_phylink_mac_select_pcs,
> +};
> +
> +static int mxl862xx_probe(struct mdio_device *mdiodev)
> +{
> +	struct device *dev = &mdiodev->dev;
> +	struct mxl862xx_priv *priv;
> +	struct dsa_switch *ds;
> +	struct mxl862xx_sys_fw_image_version fw;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->mdiodev = mdiodev;
> +	priv->hw_info = of_device_get_match_data(dev);
> +	if (!priv->hw_info)
> +		return -EINVAL;
> +
> +	ds = devm_kzalloc(dev, sizeof(*ds), GFP_KERNEL);
> +	if (!ds)
> +		return -ENOMEM;
> +
> +	priv->ds = ds;
> +	ds->dev = dev;
> +	ds->priv = priv;
> +	ds->ops = &mxl862xx_switch_ops;
> +	ds->phylink_mac_ops = &mxl862xx_phylink_mac_ops;
> +	ds->num_ports = priv->hw_info->max_ports;
> +
> +	dev_set_drvdata(dev, ds);
> +
> +	ret = dsa_register_switch(ds);
> +	if (ret)
> +		return ret;
> +
> +	ret = MXL862XX_API_READ(priv, SYS_MISC_FW_VERSION, fw);
> +	if (!ret)
> +		dev_info(dev, "Firmware version %d.%d.%d.%d\n",
> +			 fw.iv_major, fw.iv_minor,
> +			 fw.iv_revision, fw.iv_build_num);
> +
> +	return 0;
> +}
> +
> +static void mxl862xx_remove(struct mdio_device *mdiodev)
> +{
> +	struct dsa_switch *ds = dev_get_drvdata(&mdiodev->dev);
> +
> +	dsa_unregister_switch(ds);
> +}
> +
> +static const struct mxl862xx_hw_info mxl86282_data = {
> +	.max_ports = MXL862XX_MAX_PORT_NUM,
> +	.phy_ports = MXL86282_PHY_PORT_NUM,
> +	.ext_ports = MXL86282_EXT_PORT_NUM,
> +};
> +
> +static const struct mxl862xx_hw_info mxl86252_data = {
> +	.max_ports = MXL862XX_MAX_PORT_NUM,
> +	.phy_ports = MXL86252_PHY_PORT_NUM,
> +	.ext_ports = MXL86252_EXT_PORT_NUM,
> +};
> +
> +static const struct of_device_id mxl862xx_of_match[] = {
> +	{ .compatible = "maxlinear,mxl86282", .data = &mxl86282_data },
> +	{ .compatible = "maxlinear,mxl86252", .data = &mxl86252_data },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mxl862xx_of_match);
> +
> +static struct mdio_driver mxl862xx_driver = {
> +	.probe  = mxl862xx_probe,
> +	.remove = mxl862xx_remove,

This is missing the non-optional shutdown hook again.

> +	.mdiodrv.driver = {
> +		.name = "mxl862xx",
> +		.of_match_table = mxl862xx_of_match,
> +	},
> +};
> +
> +mdio_module_driver(mxl862xx_driver);
> +
> +MODULE_DESCRIPTION("Minimal driver for MaxLinear MxL862xx switch family");

I suspect this description may not age well, and may remain "minimal"
even when the driver gains more substantial features.

> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:mxl862xx");

What is the role of this MODULE_ALIAS?

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
> new file mode 100644
> index 0000000000000..66d194db8d6dd
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#define MXL862XX_MAX_PHY_PORT_NUM	8
> +#define MXL862XX_MAX_EXT_PORT_NUM	7
> +#define MXL862XX_MAX_PORT_NUM		(MXL862XX_MAX_PHY_PORT_NUM + \
> +					 MXL862XX_MAX_EXT_PORT_NUM)
> +
> +#define MXL86252_PHY_PORT_NUM		5
> +#define MXL86282_PHY_PORT_NUM		8
> +
> +#define MXL86252_EXT_PORT_NUM		2
> +#define MXL86282_EXT_PORT_NUM		2
> +
> +struct mxl862xx_hw_info {
> +	u8 max_ports;
> +	u8 phy_ports;
> +	u8 ext_ports;
> +};
> +
> +struct mxl862xx_priv {
> +	struct dsa_switch *ds;
> +	struct mdio_device *mdiodev;
> +	const struct mxl862xx_hw_info *hw_info;
> +};
> -- 
> 2.52.0


