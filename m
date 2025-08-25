Return-Path: <netdev+bounces-216531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E5EB34513
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3535E58AB
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB02E0921;
	Mon, 25 Aug 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="YMUV2YRj"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C9111BF;
	Mon, 25 Aug 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134090; cv=none; b=PT2IIOIQll87j9FXnpVqmV8Icwy1lZzBq+8MbC4U8YG/C9bWI7Wie9vDZEtN8CpXY/ZX3rv0O1KXOomX7/wWSTM3FTWUxJtwsTxOh6jl5QbPjNGmSaFst3JsW7eIXdG0TlW/lWZZEKfklv2Z9/Q3O3XLOINK2vzgJ3e5JG6aDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134090; c=relaxed/simple;
	bh=RMimBFG4FlqEvtp6v1dBdftJCWrHc+FKNd3AtGUu5vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nC5ZBHvQAlFT0sXa4kS9juake5cRPY6vawpU4ifhSNYnaY68Xd2hqJSddhU5MdDpYMBAO3WeOK6Uwu54M4KCQFw2kWwGNnahHXA86YEk97plySeDORRTcKGLLFTTw2M6QWWVa2cc0ZS08oGwOU8z7deU3FGCu/rF2OIWAxAjLJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=YMUV2YRj; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 80AD9A0B9C;
	Mon, 25 Aug 2025 17:01:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=+Atn993zu+xTI4sKFEPw
	tu3dFIccwWGD6f2ILNMtxTc=; b=YMUV2YRjO1mx1K9PTBAd44Q6fB4QUlIljb03
	E29U6JT5siWeza5ouQQ5b5YiI4aCy1U62YZImtkwTnxu/5x/s2UEnOTfLC1EN8Dc
	47A4S5Y/4ZxwwDp7MnP0VA+WSlJEh6n2ktGEHtUGQo05UTPRimvc9kcDwfKXLzDu
	BAAb9l0AhEFZzD7i+XeVtR8Txb1HfM4d45SsuqZzSOT30N486VUu7nJfZf/nHOxh
	D6otYAGfwoP9RSEE4ZqQPpTdjhUbd3pxgcpA17DKZ6q/z9nEUieQDNj6lK4VNMZR
	slzIihLC/x7ejB7ghCE6uHNAtGXLFInu7Sm0wCHuk6haZioTY0o1iBoZsyKXjmuY
	NsSUBkcgKFaIxVfUF2enYWSw3TMoLshzxN/x5BEUtZLl2AJXfbVVXAIt2Z5P6RqX
	0rIDyWn7MsXuCazrT4UflsvNkwN8CvJzbzXkFpQGGPrj5IzIS5EIAheJBdHeQrPy
	svnB20WzIFmazIyTZxN0OViA+Hhhbds0M/aX8Sf8MLV89cYTKrrOx3kqCEd5a/pm
	fKAMbpJ/I9JCWzcH+kp0pmELb54ZtIwSaaYO0h4Ca3BatSLKEQWpqRfiBqX8EQdt
	+CIwq4PR0jBI9MCZsoqBX5/cafP/WtU9p7KQfJu0CapQiDS1Ib+V0PixSWYXEuqc
	ghEHjRM=
Message-ID: <4876fc17-6118-418c-9a7c-dd3feeb4fa88@prolan.hu>
Date: Mon, 25 Aug 2025 17:01:19 +0200
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
 <724f69f0-7eab-40aa-84f0-07055f051175@prolan.hu>
 <aKx5DX09QZcbrXA6@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <aKx5DX09QZcbrXA6@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: sinope.intranet.prolan.hu (10.254.0.237) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E607067

Hi,

On 2025. 08. 25. 16:54, Russell King (Oracle) wrote:
> Now, I could nitpick your "because the PHY was never reset" - that's
> untrue. The common problem is the PHY is _held_ in reset mode making
> the PHY unresponsive on the MDIO bus.

In our case, the problem is that refclk is turned off during init, and 
then before PHY probe, it is turned back on, but reset is not being 
asserted.

> If your goal is to fix this, then rather than submitting piecemeal
> patches with no explanation, I suggest you work on the problem and
> come up with a solution as a series of patches (with commit
> descriptions that explain _what_ and _why_ changes are being made)
> and submit it with a cover message explaining the overall issue
> that is being addressed.
> 
> That means we can review the patch series as a whole rather than
> being drip-fed individual patches, which is going to take a very
> long time to make forward progress.

We are still working on the comprehensive solution. I thought that in 
the meantime, these small and lower-risk pieces could be reviewed and 
picked up.

Bence


