Return-Path: <netdev+bounces-27047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9404977A04A
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 16:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4FB28104B
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 14:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC4E7496;
	Sat, 12 Aug 2023 14:09:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A66FCC
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 14:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB08C433C8;
	Sat, 12 Aug 2023 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691849362;
	bh=z+m4uxf5uQXSYdBR7XRst5uEUqfj5OU0THhKy2Pgzw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NRcuuSwRkCingBsl/vsEZbgeFFYLrf1y+jccW0/5Yc5HDj+1VoVAME8JmLoRwatmv
	 cq9vWxL4zAE9ZVUJLta84Dvv5Inw/EfKSi/yAs63VyBxmpmvFYbATcUsu77nljsk2A
	 aA3VJilGgMOpA/ket7dhpg569WOR9pO165Aa92NCsdjCCxPdIgZY5ieRy7nbUuFLnh
	 5IcBP4Gl/p7TKLadf1jSNE+GDBp+0bp0kFtLguMP/b1EWW/an8byu12FnBRohiFL9c
	 uRJrWRUhrLp3tNfyj4R8So0k0XxPic0tJx3E0PAmnu0wkeyaegTrtitZo78/ruaSpI
	 fW6TnxXPQeEnQ==
Date: Sat, 12 Aug 2023 16:09:12 +0200
From: Simon Horman <horms@kernel.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Oleksii_Moisieiev@epam.com, gregkh@linuxfoundation.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, alexandre.torgue@foss.st.com, vkoul@kernel.org,
	jic23@kernel.org, olivier.moysan@foss.st.com,
	arnaud.pouliquen@foss.st.com, mchehab@kernel.org,
	fabrice.gasnier@foss.st.com, andi.shyti@kernel.org,
	ulf.hansson@linaro.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, hugues.fruchet@foss.st.com, lee@kernel.org,
	will@kernel.org, catalin.marinas@arm.com, arnd@kernel.org,
	richardcochran@gmail.com, Frank Rowand <frowand.list@gmail.com>,
	peng.fan@oss.nxp.com, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 05/11] firewall: introduce stm32_firewall framework
Message-ID: <ZNeSiFQGdOXbR+2S@vergenet.net>
References: <20230811100731.108145-1-gatien.chevallier@foss.st.com>
 <20230811100731.108145-6-gatien.chevallier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811100731.108145-6-gatien.chevallier@foss.st.com>

On Fri, Aug 11, 2023 at 12:07:25PM +0200, Gatien Chevallier wrote:

...

> diff --git a/drivers/bus/stm32_firewall.c b/drivers/bus/stm32_firewall.c
> new file mode 100644
> index 000000000000..900f3b052a66
> --- /dev/null
> +++ b/drivers/bus/stm32_firewall.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/bus/stm32_firewall_device.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +
> +#include "stm32_firewall.h"
> +
> +/* Corresponds to STM32_FIREWALL_MAX_EXTRA_ARGS + firewall ID */
> +#define STM32_FIREWALL_MAX_ARGS		(STM32_FIREWALL_MAX_EXTRA_ARGS + 1)
> +
> +static LIST_HEAD(firewall_controller_list);
> +static DEFINE_MUTEX(firewall_controller_list_lock);
> +
> +/* Firewall device API */
> +int stm32_firewall_get_firewall(struct device_node *np, struct stm32_firewall *firewall,
> +				unsigned int nb_firewall)
> +{
> +	struct stm32_firewall_controller *ctrl;
> +	struct of_phandle_iterator it;
> +	unsigned int i, j = 0;
> +	int err;
> +
> +	if (!firewall || !nb_firewall)
> +		return -EINVAL;
> +
> +	/* Parse property with phandle parsed out */
> +	of_for_each_phandle(&it, err, np, "feature-domains", "#feature-domain-cells", 0) {
> +		struct of_phandle_args provider_args;
> +		struct device_node *provider = it.node;
> +		const char *fw_entry;
> +		bool match = false;
> +
> +		if (err) {
> +			pr_err("Unable to get feature-domains property for node %s\n, err: %d",
> +			       np->full_name, err);
> +			of_node_put(provider);
> +			return err;
> +		}
> +
> +		if (j > nb_firewall) {
> +			pr_err("Too many firewall controllers");
> +			of_node_put(provider);
> +			return -EINVAL;
> +		}
> +
> +		provider_args.args_count = of_phandle_iterator_args(&it, provider_args.args,
> +								    STM32_FIREWALL_MAX_ARGS);
> +
> +		/* Check if the parsed phandle corresponds to a registered firewall controller */
> +		mutex_lock(&firewall_controller_list_lock);
> +		list_for_each_entry(ctrl, &firewall_controller_list, entry) {
> +			if (ctrl->dev->of_node->phandle == it.phandle) {
> +				match = true;
> +				firewall[j].firewall_ctrl = ctrl;
> +				break;
> +			}
> +		}
> +		mutex_unlock(&firewall_controller_list_lock);
> +
> +		if (!match) {
> +			firewall[j].firewall_ctrl = NULL;
> +			pr_err("No firewall controller registered for %s\n", np->full_name);
> +			of_node_put(provider);
> +			return -ENODEV;
> +		}
> +
> +		err = of_property_read_string_index(np, "feature-domain-names", j, &fw_entry);
> +		if (err == 0)
> +			firewall[j].entry = fw_entry;
> +
> +		/* Handle the case when there are no arguments given along with the phandle */
> +		if (provider_args.args_count < 0 ||
> +		    provider_args.args_count > STM32_FIREWALL_MAX_ARGS) {
> +			of_node_put(provider);
> +			return -EINVAL;
> +		} else if (provider_args.args_count == 0) {
> +			firewall[j].extra_args_size = 0;
> +			firewall[j].firewall_id = U32_MAX;
> +			j++;
> +			continue;
> +		}
> +
> +		/* The firewall ID is always the first argument */
> +		firewall[j].firewall_id = provider_args.args[0];
> +
> +		/* Extra args start at the third argument */
> +		for (i = 0; i < provider_args.args_count; i++)
> +			firewall[j].extra_args[i] = provider_args.args[i + 1];

Hi Gatien,

Above it is checked that the maximum value of provider_args.args_count is
STM32_FIREWALL_MAX_ARGS.
So here the maximum value of i is STM32_FIREWALL_MAX_ARGS - 1.

STM32_FIREWALL_MAX_ARGS is defined as STM32_FIREWALL_MAX_EXTRA_ARGS + 1
And STM32_FIREWALL_MAX_EXTRA_ARGS is defined as 5.
So the maximum value of i is (5 + 1 - 1) = 5.

firewall[j] is of type struct stm32_firewall.
And its args field has STM32_FIREWALL_MAX_EXTRA_ARGS (5) elements.
Thus the maximum valid index is (5 - 1) = 4.

But the line above may access index 5.

Flagged by Smatch.

> +
> +		/* Remove the firewall ID arg that is not an extra argument */
> +		firewall[j].extra_args_size = provider_args.args_count - 1;
> +
> +		j++;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(stm32_firewall_get_firewall);

...

> diff --git a/include/linux/bus/stm32_firewall_device.h b/include/linux/bus/stm32_firewall_device.h
> new file mode 100644
> index 000000000000..7b4450a8ec15
> --- /dev/null
> +++ b/include/linux/bus/stm32_firewall_device.h
> @@ -0,0 +1,141 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
> + */
> +
> +#ifndef STM32_FIREWALL_DEVICE_H
> +#define STM32_FIREWALL_DEVICE_H
> +
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +#define STM32_FIREWALL_MAX_EXTRA_ARGS		5
> +
> +/* Opaque reference to stm32_firewall_controller */
> +struct stm32_firewall_controller;
> +
> +/**
> + * struct stm32_firewall - Information on a device's firewall. Each device can have more than one
> + *			   firewall.
> + *
> + * @firewall_ctrl:		Pointer referencing a firewall controller of the device. It is
> + *				opaque so a device cannot manipulate the controller's ops or access
> + *				the controller's data
> + * @extra_args:			Extra arguments that are implementation dependent
> + * @entry:			Name of the firewall entry
> + * @extra_args_size:		Number of extra arguments
> + * @firewall_id:		Firewall ID associated the device for this firewall controller
> + */
> +struct stm32_firewall {
> +	struct stm32_firewall_controller *firewall_ctrl;
> +	u32 extra_args[STM32_FIREWALL_MAX_EXTRA_ARGS];
> +	const char *entry;
> +	size_t extra_args_size;
> +	u32 firewall_id;
> +};

...

