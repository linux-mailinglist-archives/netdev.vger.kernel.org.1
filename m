Return-Path: <netdev+bounces-234250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68890C1E1F9
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BEC24E1B10
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11438314B8F;
	Thu, 30 Oct 2025 02:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ahUImTTw"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA5F30FC3B
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791169; cv=none; b=DPwbQ4LsbO9Q0c5u3Gvrq4rzKTnFZFHGoMq2ZjEZEB6z6rPzhxnWV51Z9DQyaInxCC0tr0735u5CR9pGDoVo7hEvGmd0JD0Ppejgjn/wIpNoqjCMlmE+SvpnkcA3WPilGxVglaE4zWRmfSVBf038mkJ+K5zSRqh/rN7vaArosHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791169; c=relaxed/simple;
	bh=mjZ8XJdmk5sQHdRk5sRlHEZhEozLAXXht0Z80O26Vk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqaldwWSSMWMHCzbS2nRZwfvYfnZajfWkaMcAUnJHSVxUVFJNxM+jFWqPUKrgSCGeCGGP6exX3MOF479gYJl3jHJjLq964thK+g0PIzQBJfZbIc8HfFhunV5otM5GmzeMFMAHOpa608JwjFP8PY/60OTwVRHqe3MW8w1UYkJbmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ahUImTTw; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761791164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTgJMpeQpekaZJ7fIprXIqEHKjKn0fjVFCPWjig1jMI=;
	b=ahUImTTwAC9Rx7ymvaQ9VzRV7oz6Ywbi4b+UhrqVsge1KPinMWfB7SkPecrTs1QZEWuGg1
	pH3WavZ9a4aRJfeB7tESf+evF3zK98aowcQ41F/Pai1HJcIOB+ETgDeYSuWKr2RSSz3AdU
	ahNcDHtXF0yyLcnFm3vRZzSUsAj1LeQ=
From: Yi Cong <cong.yi@linux.dev>
To: andrew@lunn.ch
Cc: Frank.Sae@motor-comm.com,
	cong.yi@linux.dev,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH net-next 1/2] net: phy: motorcomm: correct the default rx delay config for the rgmii
Date: Thu, 30 Oct 2025 10:25:09 +0800
Message-Id: <20251030022509.267938-1-cong.yi@linux.dev>
In-Reply-To: <94ef8610-dc90-4d4a-a607-17ed2ced06c6@lunn.ch>
References: <94ef8610-dc90-4d4a-a607-17ed2ced06c6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 29 Oct 2025 13:07:35 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Oct 29, 2025 at 11:00:42AM +0800, Yi Cong wrote:
> > From: Yi Cong <yicong@kylinos.cn>
> >
> > According to the dataSheet, rx delay default value is set to 0.
>
> You need to be careful here, or you will break working boards. Please
> add to the commit message why this is safe.
>
> Also, motorcomm,yt8xxx.yaml says:
>
>   rx-internal-delay-ps:
>     description: |
>       RGMII RX Clock Delay used only when PHY operates in RGMII mode with
>       internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.
>     enum: [ 0, 150, 300, 450, 600, 750, 900, 1050, 1200, 1350, 1500, 1650,
>             1800, 1900, 1950, 2050, 2100, 2200, 2250, 2350, 2500, 2650, 2800,
>             2950, 3100, 3250, 3400, 3550, 3700, 3850, 4000, 4150 ]
>     default: 1950

Hi, Andrew, thanks for your reply!

Let me add the following information:

The chip documentation I have for the YT8521 and YT8531S:
"YT8521SH/YT8521SC Application Note, Version v1.7, Release Date: January 3, 2024"
"YT8531SH/YT8531SC Application Note, Version v1.2, Release Date: November 21, 2023"

Both documents specify the RGMII delay configuration as follows:
The RX delay value can be set via Ext Reg 0xA003[13:10], where each
increment of 1 adds 150ps. After power-on, the default value of
bits [13:10] is 0.
The TX delay value can be set via Ext Reg 0xA003[3:0], with the
default value of bits [3:0] being 1 after power-on.

I reviewed the commit history of this driver code. When YT8521 support
was initially added, the code configuration matched the chip manual:
70479a40954c ("net: phy: Add driver for Motorcomm yt8521 gigabit ethernet phy")

However, later when DTS support was added:
a6e68f0f8769 ("net: phy: Add dts support for Motorcomm yt8521 gigabit ethernet phy")
the default values were changed to 1.950ns.

Indeed, the RGMII standard specifies that the clock signal should be
delayed by 1-2ns relative to the data signals to ensure proper setup/hold
timing, which is likely the origin of the 1.950ns value in the YAML and
current code.

More importantly, the current Motorcomm driver's delay configuration logic
is incomplete. In the projects I've worked on, some configurations are
obtained from DTS, some from ACPI, but many manufacturers prefer to directly
set the delay values in BIOS based on their hardware design.

In fact, Motorcomm's Linux 5.4 driver versions guided PC motherboard
manufacturers to configure the delay values through BIOS, and the driver
code did not touch the delay registers (Ext Reg 0xA003). This means that
upgrading to a newer kernel version, where the driver writes 1.950ns
by default, could cause communication failures.

To summarize, the current issues with the Motorcomm driver are:
1. It only supports configuration via DTS, not via ACPI
    —— I may implement this myself or coordinate with Motorcomm
       in the future.
2. When no DTS configuration is available, the default values
   do not match the chip manual
    —— this is the issue I'm currently fixing.
3. Regardless of whether the configuration comes from DTS, ACPI, or defaults,
   the driver overwrites any BIOS settings.
    —— In similar past cases, I would first check if the register holds its
     default value; if not, it indicates a deliberate configuration, and
     the driver should leave it unchanged.

Issues 1 and 3 will be addressed as my project progresses,
including development, testing, and validation.
Currently, issue 2 has been verified as effective with the present patch,
and has also been confirmed by Motorcomm.

Thank you again! Please feel free to raise any further questions,
I will continue to communicate promptly with Motorcomm.


Regards,
    Yi Cong

