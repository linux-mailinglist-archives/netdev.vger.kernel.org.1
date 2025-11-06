Return-Path: <netdev+bounces-236255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BDDC3A4E6
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C1424E3CC7
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663312C0F6E;
	Thu,  6 Nov 2025 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="La2lMt1p"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E6A8F7D
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425339; cv=none; b=ZpJoFQtudpEO5St38hUAbxiVyr9OVJjywHXFLRopdwMGcM+2KZQisdpMSYo+i3W+up9wRQwlij3bdDJfdzXJqBQbznJJcOR1Rjj7pj0MU6CwXXvYYGj0jPUnlhA+/v9RbGqUwGw0taWq7TUi5mRwioqqLI/sW7hy8Ri5ytvOvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425339; c=relaxed/simple;
	bh=V0sVq7jTEaKW/w9hGkQC4lWNAskLw6EbFTuwyaZK6Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hs/8bfKmgUYGLNosa+3Kj3WCyMS0RjEU2LHDM9ymKjF2ypkzg8CmaYQJmTosvx7Uia0hwy+JwyepnV2/dHLYrCw8BcFs01Y9H3GToMZ/UaRkVvZCupfRgey72pQ1G2unyPtXPCLYe61/+MXIPAFvyccFqspv+njgZ4ZQ8CpZ340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=La2lMt1p; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 03E8F4E4156F;
	Thu,  6 Nov 2025 10:35:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CDD4F6068C;
	Thu,  6 Nov 2025 10:35:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 988AA11850A7B;
	Thu,  6 Nov 2025 11:35:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762425334; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QiGYWWa5Rp57nAs3YvpKkmsJ3R0ZczKe27XnYzkP11E=;
	b=La2lMt1p6x8Hb9C4Zb4UsCRLtRjgSDQHG9SACtaJZuGR23DTZhxooUqS9qjaVzHyC7jOaX
	suv+nt5QbHKOuV/VUnyBeSYA5k0qUp4NPOc2C1KCKAsUGA6qs6HUCQUaCIb4UqABCOKywe
	0kQeR+bC75XuNIhEjn5YEIL9eJx2+6Ee+sik2osTtpfd/ieJfXpySlTRNNd3bvT+hQQ+cn
	QV1WqssONxwiGELNS4B73AVTErYGREFXWE3JHli3VQSE3N/tChz06EzHuvYD7up65CExoM
	V6icAliw9KsXZIi65dH80n45Ol2jByhS8t9HOJRIsIbmJS0s7UdEhtG0KuK4Ig==
Message-ID: <88e8b9c9-16b5-4f8e-a2ea-3ce14555c731@bootlin.com>
Date: Thu, 6 Nov 2025 11:35:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/11] net: stmmac: ingenic: convert to
 set_phy_intf_sel()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
 <6ad7667a-f2be-4674-99a2-2895a82b762a@bootlin.com>
 <aQx3Brj6t48O6wPg@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aQx3Brj6t48O6wPg@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

>>> Convert ingenic to use the new ->set_phy_intf_sel() method that was
>>> recently introduced in net-next.
>>>
>>> This is the largest of the conversions, as there is scope for cleanups
>>> along with the conversion.
>>>
>>> v2: fix build warnings in patch 9 by rearranging the code
>>>
>>>  .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    | 165 ++++++---------------
>>>  1 file changed, 45 insertions(+), 120 deletions(-)
>>>
>>
>> Damned, missed that V2 and started reviewing V1... I'll resend the tags
>> for V2.
> 
> Yes, Jakub reported build warnings on patch 9 last night, followed by
> the kernel build bot reporting the same thing. The dangers of not
> building with W=1, but then W=1 is noisy which makes spotting new
> warnings difficult.
> 

I had the same issue, I have recently started using the nipa infra locally for
that, which comes with a way to compare the number of warnings before/after for
each patch to help sift through these :

https://github.com/linux-netdev/nipa

The setup was actually way easier than I would've thought, and testing
a series boils down to running :

cd $nipa
./ingest_mdir.py --mdir /tmp/my-series/ --tree $linux

it still takes a while to run on my workstation though, but at least it
doubles as a nice way to heat-up my living room with all the compiling
going on :)

Maxime

