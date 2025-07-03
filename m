Return-Path: <netdev+bounces-203752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9030FAF6FBB
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B32B1BC0AE3
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D345B2E1747;
	Thu,  3 Jul 2025 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cSpZCwJ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640832E1744
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751537408; cv=none; b=QV18XMuPVIjyYd8S+6O7P7Pl6V/lxqqQ80F3O3SlE1LpdeVCdBH8QXD76/INIll1Y64/N3ZvKLDIHZTplb2SphK0umJruyYvb8oD9U7J5vzO2DGH+GNzPPhiIQhuJNpK5XGF+W3xaTm/SkryWgVhhMwASHqUk/6L5rSASFbS/fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751537408; c=relaxed/simple;
	bh=2URzPKeWwOWlfZr3VMU/R70qtUMAmLZrCaO6QOVU9A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy5BWxsxRtwAXHbiQPpfJsjadRI73kIsHYUcQzKctYhUS1Y9YX744BakBwSIn+QK91Lao5EZkzUcWKh3gYpsP8W9ht3N9zlp/YKs7PzxgPkGoywKJGtimJWpWlHYUvlSe2TSYV+R892M87tdKH/RcrE7pehagsWP77udK88kPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cSpZCwJ8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so5029331f8f.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1751537405; x=1752142205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hFA4oh4QUQdOxuaA9SVG8ATJhstNeNbsNX9+qVlE1g=;
        b=cSpZCwJ8EPQEGj92CQZ/ZWw+yF7rLqbrdcjuFEdf4Y652bVBXhqNYK+ICQdPhG6UdM
         owHTylNd4rfnKmPr8lKRATHqlljA2qmGlRlSgDEECbxMa6kyrnvRqyIozmxt1pKOSRXa
         BUvMAmUtUxdYdtsouIjrQfIjlFRccIOT6pRIxr7HZom5sKNWDw+4np1Okbp1Q5YiNAsD
         +w3lZnRhVkKiAHKcwh3CbGAZk1GRfEF0RZjtoIfnWnitXe+FU7FzoV1U9fwQF+zXL2R2
         RsFd/EiMOvIsTgZQP+V/+RVPD5/NEGIzmz47jGh6tMRn+ma9iJOgVukk9b3rV8fopbUb
         Vy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751537405; x=1752142205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hFA4oh4QUQdOxuaA9SVG8ATJhstNeNbsNX9+qVlE1g=;
        b=X7Yk5QNEIgjAzh/SzI4pBVpR8SEXX1E0XhWziEcYC7Nm1jZA1dxWaBwy17CMWRtqvj
         12GLFLWoFS7AblG0n2IiHL2H8zF62Rt1nMeHbG0maHpVGQg5nDGtuYf58/hJgADCCXfr
         u23el4hLMYk/92yqqKqKhXfUj/SpRQjoZ3BMLkqFbFTY9VuWFcK98cxT9tFzTXOj3N/s
         pRL3KLIzO7uI4rMqVnvFKczPVL63zfy5d6nJWVsU5Qv+K+qQuJe25VIxcpo5V69IHv0A
         bUUfQqyb0dzHiQioJyLjgHdWSHef/0vyWqtcszhdARMyLtXcObRsjRg4PVvQEXV9a6tf
         JnTg==
X-Gm-Message-State: AOJu0YyKbH18ltRu6h58EM4+TP8cttOFmyvvTXf/4+wQZiVdiQKe/lvK
	lnuHrOMvr0Ud33TbB9T078DTtdEt+lzQDJ0MPn17MqnpeU4rbSZHRkd6Hp/74wDff2U=
X-Gm-Gg: ASbGncvoDeWwH3ij29pwm3n3IlsxthqqYDkdFGE5m/noJVTfKNTJXSIJ9WQQ1oemOII
	2AGhwuMyMKaVn9F7X9NAD6SmBhioePXjzH+4hHxQxsgQrzwHZ2tmwy0Qh0a7tgWlMJIzvsUpMhK
	jHCyfhhrzkl5myZoyN1vOMd18Kn5Vyw3ydYtzHnOUubpk+jbbgI5tHNh8bSAfh0Od83yVPl6hKl
	dV/qJgTRyT+BiT1dtSafAbmZfpsFMld/3kN44KyQ8sK7u4jw7irzfPF9tgNY07+5Br6tLE5nbnY
	0IctnDpJgBHjX54yh/owsdTeW4vSPkLPcLvp3XiM4c0P8kD8XMDQEXNH69AkP4jvGs+X0A==
X-Google-Smtp-Source: AGHT+IHfNjDl88KLIzBBak/j4QsOeoXaT11cx/c0F4gN8GQS6D2qXXuoCo04NSmd3GiJG1PcpnF/0A==
X-Received: by 2002:a05:6000:4011:b0:3b2:e07f:757 with SMTP id ffacd0b85a97d-3b32b145539mr2068694f8f.1.1751537404431;
        Thu, 03 Jul 2025 03:10:04 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a99878acsm22244925e9.17.2025.07.03.03.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 03:10:04 -0700 (PDT)
Date: Thu, 3 Jul 2025 12:09:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shannon Nelson <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, 
	Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v12 07/14] dpll: zl3073x: Add clock_id field
Message-ID: <pfkr62fp4jr2bts3ektfwn4or36lqdsdqfsntryubr5oawx7kv@adqwk2qoflhu>
References: <20250629191049.64398-1-ivecera@redhat.com>
 <20250629191049.64398-8-ivecera@redhat.com>
 <amsh2xeltgadepx22kvcq4cfyhb3psnxafqhr33ra6nznswsaq@hfq6yrb4zvo7>
 <e5e3409e-b6a8-4a63-97ac-33e6b1215979@redhat.com>
 <cpgoccukn5tuespqse5fep4gzzaeggth2dkzqh6l5jjchumfyc@5kjorwx57med>
 <4f2e040b-3761-441c-b8b1-3d6aa90c77fc@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f2e040b-3761-441c-b8b1-3d6aa90c77fc@redhat.com>

Wed, Jul 02, 2025 at 04:51:47PM +0200, ivecera@redhat.com wrote:
>On 02. 07. 25 2:01 odp., Jiri Pirko wrote:
>> Wed, Jul 02, 2025 at 01:43:38PM +0200, ivecera@redhat.com wrote:
>> > 
>> > On 02. 07. 25 12:31 odp., Jiri Pirko wrote:
>> > > Sun, Jun 29, 2025 at 09:10:42PM +0200, ivecera@redhat.com wrote:
>> > > > Add .clock_id to zl3073x_dev structure that will be used by later
>> > > > commits introducing DPLL feature. The clock ID is required for DPLL
>> > > > device registration.
>> > > > 
>> > > > To generate this ID, use chip ID read during device initialization.
>> > > > In case where multiple zl3073x based chips are present, the chip ID
>> > > > is shifted and lower bits are filled by an unique value - using
>> > > > the I2C device address for I2C connections and the chip-select value
>> > > > for SPI connections.
>> > > 
>> > > You say that multiple chips may have the same chip ID? How is that
>> > > possible? Isn't it supposed to be unique?
>> > > I understand clock ID to be invariant regardless where you plug your
>> > > device. When you construct it from i2c address, sounds wrong.
>> > 
>> > The chip id is not like serial number but it is like device id under
>> > PCI. So if you will have multiple chips with this chip id you have to
>> > distinguish somehow between them, this is the reason why I2C address
>> > is added into the final value.
>> > 
>> > Anyway this device does not have any attribute that corresponds to
>> > clock id (as per our previous discussion) and it will be better to NOT
>> > require clock id from DPLL core side.
>> 
>> Yes, better not to require it comparing to having it wrong.
>
>It looks that using clock_id==0 is safe from DPLL API point of view.
>The problem is if you will have multiple zl3073x based chips because
>the driver would call dpll_device_get(0 /* clock_id */, channel, module)
>
>For 1st chip (e.g. 2 channel) the driver will call:
>dpll_device_get(0, 0, module);
>dpll_device_get(0, 1, module);
>
>and for the second the same that is wrong. The clock_id would help to
>distinguish between them.
>
>Wouldn't it be better to use a random number for clock_id from the
>driver?

I take my suggestion to not require it back, does not make sense.

Clock id actually has a reason to exist from UAPI perspective. Checkout
dpll_device_find_from_nlattr(). The user passes CLOCK_ID attr (among
others) to obtain device by DPLL_CMD_DEVICE_ID_GET command. He expects
to get a result back from kernel regardless where the device is plugged
and across the reboots/rebinds.

Clock id should be properly filled with static and device specific
value. If your chip can't be queried for it, I'm sure the embedded world
has a solution for such cases. It's similar to MAC of a NIC device.

