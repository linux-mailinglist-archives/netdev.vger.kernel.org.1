Return-Path: <netdev+bounces-164287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6E6A2D3B8
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 05:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B82B188D172
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 04:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A7A18756A;
	Sat,  8 Feb 2025 04:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4M784u8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDC9167DAC
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 04:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738988340; cv=none; b=srEPGx/+loD5T1DVfLbNmcPB7YO0+Ly90WaWyrmpMyq4iUYUxeNQumIfOT8b1AFy3AWAk+9AVcQSyVvAs0hZ1i8Yg9ErDTJw9bjMYQUwl9sOIw6Ih2ewqDx+PsitSsVCt5aCO20U65XFe1GY7yj7IjzIZsAMyDga2PJRyFhM4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738988340; c=relaxed/simple;
	bh=KdB7unTaRB+08sCb4aq5s8sHrp/mi1wRkkb0qmR8Ve0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/2SY/x4EDk00IKjupDsdOIaW0QewOfBifidJqmH3cj+fD9XIk1liao31QGGEjfWveTZ+T4W6RW2cDFugeicBwgpQhsXqmpgFtARPKE0GZnnlZN5vVWMaRh6kRbLXjf65u6RAKiHzxv3NITkVCUN00uye41TMWMC0hZaSbKK6vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N4M784u8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab771575040so509340266b.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 20:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738988337; x=1739593137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJnBLg+2EMCubVxOzepIpdcBMB6agbuUnEZ2sZAa12A=;
        b=N4M784u8Raod907ElfgcT1zGd/dtOkC3WJh2PzVgiqRO+0d8JurpuFkx8DRkPdem/D
         jB3qAtfhSAHtHRIXPWBg8wXjJQ2fuXPuBTangUDvYr4agMgwmebwWaPx6eJU2Z41Ywth
         D6uibBT8ZuEHQcyaneW/z9DppQp5pBiE8LKWwMsmkYquRbfO2Ciu6WjKwtUGniezC24m
         cAQ3vNf39FDQAMddyjIYU6z7KBLY+D0+YvFRK2W0zfq0GELfPgbhRtgJLX5cMRxriumG
         6lojtcIiRrMUOJnNKy7EYdAh7PXarEsljs3IaAARcrduP0qh+rUNAwRu9EGk+h99lzO5
         CS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738988337; x=1739593137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJnBLg+2EMCubVxOzepIpdcBMB6agbuUnEZ2sZAa12A=;
        b=EIqObHasYYqlF2LlcJfk5v8QB+LEfB5HQc8D+7d+1VEgtYykZALZVsbaSRCCbeDLIs
         yYFDCqlBWx0DVRNFie+9vtSlIJYYY8akWFRIke+0NFoEsDOTD2sAhGxCAo0qsuWFEtO2
         Prg8bxiprAc5zvPWLME0x6uI25VNwcCYf1gD8qRnS1NGNvED63uTf3LaaCTo9S785+95
         KY2YI4DgA6G3kuUM2rzPaiy1kzwLvQvQ3ldYBpjP6/6fpuSBefvPRQIuAK/5RPJd3PGt
         jDN4wvyPVmzTXubqciA28wcE5dhmysYv/dDuWZUQHK4c11y5zUnXwE6gDhscNshAX9cg
         VWGA==
X-Forwarded-Encrypted: i=1; AJvYcCVDpyH5HE5ZK8zYQtfWE9hUNKlikWPiG58/9SXkz84eZvKNNMmdZVLu+dsRxXtuLxWgyL0DrX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvE4nbZwOMZGa9Zoqqv6gCoIzP/bB02XfaicFI+FEPfg3BAjo
	/O43mzsFhQdDPWbnwJixegdEmWWGziEORsgtNcXh7FtgFyWIxADmlm+KOpexEKg=
X-Gm-Gg: ASbGncsVm7bcV00x6pgdu/e8eSl2pmib1ns1/v7FtnT15IbSK7MdSU6P9FEPj/g4fs9
	RaSDaSh+BMT3hqzfAyKSzQnvq8YQfGFr4ZqZ5wCemzgC1IkwvYw9sOAmS53ASeCQ/Ct1PGfnXXZ
	bKvLAQljZHILgYFKvPa9pDkkamdhDgZRi/Ha/cmpiV8fbNUyut7S9WCL+G6KW10+wf3zKY3Fk93
	wCe0/aAcoMCMn997g1Vm72mTM7F9aE7f3+kgwORPRg3INPlcXWmM8lkuJ57wKoVamQk/8SmH7NC
	RbLvHMD9ZOvlbE80ko+z
X-Google-Smtp-Source: AGHT+IHn89AYm8QeUz9PnuTAmBi0sjoUrl44qsoKpOAlveTucLfggPm9SdbIhHVoYrkXGlxj1n8EoQ==
X-Received: by 2002:a17:907:2ce3:b0:ab6:f4eb:91aa with SMTP id a640c23a62f3a-ab76e896c0cmr1077297866b.10.1738988336641;
        Fri, 07 Feb 2025 20:18:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7732e7120sm391127366b.91.2025.02.07.20.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 20:18:55 -0800 (PST)
Date: Sat, 8 Feb 2025 07:18:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "zhangzekun (A)" <zhangzekun11@huawei.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, robh@kernel.org,
	saravanak@google.com, justin.chen@broadcom.com,
	florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
	kuba@kernel.org, kory.maincent@bootlin.com,
	jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, taras.chornyi@plvision.eu,
	edumazet@google.com, pabeni@redhat.com, sudeep.holla@arm.com,
	cristian.marussi@arm.com, arm-scmi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	chenjun102@huawei.com, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: Re: [PATCH 1/9] of: Add warpper function
 of_find_node_by_name_balanced()
Message-ID: <be93486b-91bb-4fdd-9f6c-ec295c448476@stanley.mountain>
References: <20250207013117.104205-1-zhangzekun11@huawei.com>
 <20250207013117.104205-2-zhangzekun11@huawei.com>
 <Z6XDKi_V0BZSdCeL@pengutronix.de>
 <80b1c21c-096b-4a11-b9d7-069c972b146a@huawei.com>
 <20250207153722.GA24886@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZyGJHelXDmJEw393"
Content-Disposition: inline
In-Reply-To: <20250207153722.GA24886@pendragon.ideasonboard.com>


--ZyGJHelXDmJEw393
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2025 at 05:37:22PM +0200, Laurent Pinchart wrote:
> I'm tempted to then rename of_find_node_by_name() to
> __of_find_node_by_name() to indicate it's an internal function not meant
> to be called except in special cases. It could all be renamed to
> __of_find_next_node_by_name() to make its behaviour clearer.
> 

Adding "next" to the name would help a lot.

Joe Hattori was finding some of these bugs using his static checker.
We could easily write something really specific to find this sort of
bug using Smatch.  If you have ideas like this feel free to ask on
smatch@vger.kernel.org.  It doesn't find anything that your grep
didn't find but any new bugs will be detected when they're introduced.

regards,
dan carpenter

--ZyGJHelXDmJEw393
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=err-list

drivers/net/ethernet/broadcom/asp2/bcmasp.c:1370 bcmasp_probe() warn: 'dev->of_node' was not incremented
drivers/net/pse-pd/tps23881.c:505 tps23881_get_of_channels() warn: 'priv->np' was not incremented
drivers/media/platform/qcom/venus/core.c:301 venus_add_video_core() warn: 'dev->of_node' was not incremented
drivers/regulator/tps6594-regulator.c:618 tps6594_regulator_probe() warn: 'tps->dev->of_node' was not incremented

--ZyGJHelXDmJEw393
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_of_find_node_by_name.c"

/*
 * Copyright 2025 Linaro Ltd.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"

static int my_id;

static void of_find_node_by_name(struct expression *expr, const char *name, struct symbol *sym, void *data)
{
	if (!refcount_was_inced_name_sym(name, sym, "->kobj.kref.refcount.refs.counter"))
		sm_warning("'%s' was not incremented", name);
}

void check_of_find_node_by_name(int id)
{
	my_id = id;

	if (option_project != PROJ_KERNEL)
		return;

	add_function_param_key_hook_early("of_find_node_by_name", &of_find_node_by_name, 0, "$", NULL);
}

--ZyGJHelXDmJEw393--

