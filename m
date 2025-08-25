Return-Path: <netdev+bounces-216527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0994B3446C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637F15E4B51
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDFB279918;
	Mon, 25 Aug 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hP0FzDKv"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292B6AD21;
	Mon, 25 Aug 2025 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132759; cv=none; b=u0LJST1rsmdlhafTGv/979KdUdre+kDT0Un3t27LGMGMUI/WQQeI3XQLRKmdMVPtYKLwBCN0LgZxHr7nDyu9+UcRtF19ZQHwghl80T3qY4Uai1od8K9SQUzxeTYUJ69f4yJ8TMjMv0GOkGepsMz03EG9V1Z+g//q9ndZj+O23vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132759; c=relaxed/simple;
	bh=gjMNa053jm9d1ZxNLYNws1hv3/WjlgBNebfTgWG/+fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hXGD0xbsweLqgmW15zssxDlsSYnn9kB+7xZYdIJ0x+4M88xMEunEcXINSbizDTsV72Qq56xXSfVfN837lrBSaGfPYklxRdval6Zlzp1FDmj90sSSh1cB+e2GFzhI6VMC6GkF4U3fm5pMCof4NlwCCuMWqPJ8UEXTqBh/MfLEuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hP0FzDKv; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7B486A01D2;
	Mon, 25 Aug 2025 16:39:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=7LBCMNAUL/7vcH2b4nh4
	CGZU3Z9xao18skU/LyQqwYA=; b=hP0FzDKvH3mi6Qmaw5vWS55+ZOVq7SwtKWwW
	UsAzTcl57wg6xAzdT+nzcqNQN5L0bZ6yTmMNxENRL11hgvPxGsYPnuEAQBZ5ocWp
	dkpulxb74zWEpTBx9aARKxhtH9Jws0I3kzVO9KSyVopAp6/3TvkeFKx0kMylQ8i5
	5ZVNpGW2E8O7XWODZJq63hrsqpAfQT8GJZUD2nllpJBOjj78xaI+37IZLU2KYTGp
	UqS6KDj3HFSx1id0v618ty+2raO3Aokxaeaj5QILoLUQi+6u+p2O+B3uvcSaRIM5
	/mh1UJ+jPHRb3HGsSpPqxVHkW7V8AZ5nRiZZ55pCcOhPmJ7iDZE3io9IO4faGZi5
	VazhlQzgRVuewWi2jrWZuACOMPh9ZLaj4LwvduVwuKHAe2K8T7dyb52jpZ1q7iIu
	J8q+HR9EBsQZ7PXqwCIfYe9U4fbloy0HpD1Q/pWV5XctlRtjMCbQtMS9GhgIo0xM
	0ieUi4u35fOpfla6VYChakQrfPSJtBpjL5IHOV12+gTuIcdZVjvBHhTMwQo64XB/
	bUVGgGkQ/ZAFZ9bhDQVx20jIkWZRu0jaXgw4HWSEt82/+rmE4IOB2YEQlQiHkOKP
	8b6A7Cuo5i9jWAQLVLz0OWLtGsezfbnTJzcd41dUcBlNnuAbHEtHGDANCN+SPl1a
	aU8IKsU=
Message-ID: <724f69f0-7eab-40aa-84f0-07055f051175@prolan.hu>
Date: Mon, 25 Aug 2025 16:39:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mdiobus: Move all reset registration to
 `mdiobus_register_reset()`
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Philipp
 Zabel" <p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250825-b4-phy-rst-mv-prep-v1-1-6298349df7ca@prolan.hu>
 <aKxwVNffu9w8Mepl@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <aKxwVNffu9w8Mepl@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: sinope.intranet.prolan.hu (10.254.0.237) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E607067

Hi,

On 2025. 08. 25. 16:16, Russell King (Oracle) wrote:
> On Mon, Aug 25, 2025 at 04:09:34PM +0200, Bence Csókás wrote:
>> Make `mdiobus_register_reset()` function handle both gpiod and
>> reset-controller-based reset registration.
> 
> The commit description should include not only _what_ is being done but
> also _why_.

Well, my question was, when I saw this part of code: why have it 
separate? Users shouldn't care whether a device uses gpiod or 
reset-controller when they call `mdio_device_reset()`, so why should 
they have to care here and call two separate register functions, one 
after another? In fact, the whole thing should be moved to mdio_device.c 
honestly. Along with the setting of mdiodev->reset_{,de}assert_delay.

The end goal is fixing this "Can't read PHY ID because the PHY was never 
reset" bug that's been plaguing users for years.

Bence


