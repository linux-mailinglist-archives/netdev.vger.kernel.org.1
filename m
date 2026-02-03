Return-Path: <netdev+bounces-256357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCXCNSsjgmnPPgMAu9opvQ
	(envelope-from <netdev+bounces-256357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:32:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79221DC017
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCD67306ABA1
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D3C3D1CA3;
	Tue,  3 Feb 2026 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPEJSSRm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54D3D1CC4
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136131; cv=none; b=Hy/TUDnLU5h95fRJ4JNbIqLkOOrHga+HxaqDFRgONIzHlHzFh053GXWHYqRE83uzxfTDvAWikiQJjkZ0QeKtjRp2YzgGCscpfi79LzOBu4JfdxSDc+Ka+s75WrTN29V3VhJaYXQxSAQtJfZm8BJWOf7OMyWRw4n//UAWkgnY81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136131; c=relaxed/simple;
	bh=C4LCwiHMJLH4EJHuKA0kgNtAtBVk64Afz7AB3Gax50U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0HKmlE693xbgP0cuL6lyiNNcnsBksx3fdrHh9LrkUfWYDmJQTC8f10iZxZ/C9dpfRM0skyV5Pq+toJS51o9wj/grOlXgmA1Bf0OOnpVgKyKhYt82PAPtPHJE+V7awIDjtv2gnyqamMvmEr0Xxy8ATmUmdLQ/GRjZX+6rhV/u44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPEJSSRm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43601e96f72so1837250f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770136128; x=1770740928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K10+Z/PfLLLC2tLsBMJ7x0EDY9z49CyvtmsqUUYjuGg=;
        b=nPEJSSRmDbot00E3LsJOpSng1lLPUwmkIjKQ6wJISoowUNwcZnW3MnAkP2CINZfRLn
         vxol8Ur9DiQ0o00R/x3cgNqrEAPyJyANzq0ZNOOXeJB4dHILvRUEvw0+LoBcqhkmYxt3
         qyVc+XsnPOCL9XjrrF01hSBwSBf7k0bbwHmE15dx6l7UdIPQdAJ890+RpxFsRVQZCE9A
         +pWQVL6ShIsmjhovQ6tn8u/O9+PiEnErqLpcyGv1y5Fp3jaTskxBszteG26RISzEDPwE
         q+kOdGN+4KEIhEDANuRAQ9+/dp3SwoFoqafNiGzpMxBFVEBk76fUPwGNZI/fYSE6c74s
         /sOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770136128; x=1770740928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K10+Z/PfLLLC2tLsBMJ7x0EDY9z49CyvtmsqUUYjuGg=;
        b=Nd07xzEGgBwEaHHELbsVMeP19deu5pQayzZJfptpYQYe0VPoiC9ehctsSJ2QiGv3UQ
         P4Lgac9VuAwjdh8VVkfkLPTGF0SWJUpeqNyWBpnsBhcIem3otQdm6fZlH5fykLL+ViOr
         W4zbYpvLSaiedjvP2rUl8p+Bjql1sX6hZ2qyMGJVDFc3i80NFZGQ1tOCXeGIY//wk8i4
         NZJ1JC9cFBXcLVpwVYbTuge0EDZm8HTDEyL9mtHDwvh99SPrY6fuot79Ro09XGZ00Jya
         Z4L86WOC7mYJuzmekMdd0wVqgmt7ENRbaShJos7NQ5K2ihhXk6gaFlLvS5NjgOPZnAtW
         Z+uw==
X-Forwarded-Encrypted: i=1; AJvYcCW4foh8lO6He6OBYeM3Fl5nyE3+zMHszX8KOUymS9hUPhbDAjwUkaaYaPEaxPmgb1yHTIQvdEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3uA79L5EWl8q+gDHuRtepjnYwg5qEqYIp1lGlTxHOSPq93WZT
	Kv07JPKQXTnxgVhaQoL3enqHOi2WsKyoMbGr8+X6+832Z1bnXEFsn3cu
X-Gm-Gg: AZuq6aIdG/M5IWQ+2A5CjYXsE8VxU3cgeoE61+YBMMtIJrVirUAP4RRiu2FRssFsK/z
	g4W7I+p4Ys3HXA9l1m+i44iwpY1G9vb3WxBcital2cQeEG4KFLzmqH50615DDO4CJhpZhq1rQWx
	mMSizYsYnc0R8xVGUNzAJTM+aOBAc8T/ONGVz7t+FxCaowi7hvcE98kG4058JPTaZZWw3mcqgy4
	CIOqvNe8pRY40ZXr8A2R3jRz138MNdO2z6YA4heJDEwqMtVRMXABZEXHy+Hw2mCEJIYVWyZ9ehZ
	haKEXo2+HvEbjLJNnN1BvovnbZPo8WP1H5YNcEWFySP1mQF88cCFTWF7n5NxeyKlg66/Zb255PA
	gSmUVG47+GvRCxrim1qYsucL6hYmtoR1xJCIJ/Ds/yKvbBHiJYP4oZnmzdvxT1G+BagsbE87xuG
	6gIzFNpyzH6C+G/zSeoguMd65J
X-Received: by 2002:a5d:5e01:0:b0:435:b068:d3be with SMTP id ffacd0b85a97d-435f3aa90cemr24034054f8f.41.1770136128003;
        Tue, 03 Feb 2026 08:28:48 -0800 (PST)
Received: from [192.168.0.7] ([86.124.200.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cfd4sm50668256f8f.25.2026.02.03.08.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 08:28:47 -0800 (PST)
Message-ID: <434bff80-0b89-4fe5-beb2-4b70a4b600d8@gmail.com>
Date: Tue, 3 Feb 2026 18:28:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: stmmac: provide flag to disable EEE
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Clark Wang <xiaoning.wang@nxp.com>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 "David S. Miller" <davem@davemloft.net>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, imx@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Stefan Klug <stefan.klug@ideasonboard.com>,
 Wei Fang <wei.fang@nxp.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk>
 <f95f73b9-d024-4697-bca1-02fb8bc044af@gmail.com>
 <aYEj8VM5AfvcDHrl@shell.armlinux.org.uk>
 <ea2434e6-d1db-4ea2-90f4-0a77961b7918@gmail.com>
 <aYIXmsIG_ZJO-cg4@shell.armlinux.org.uk>
Content-Language: en-US
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
In-Reply-To: <aYIXmsIG_ZJO-cg4@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256357-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,nxp.com,ideasonboard.com,davemloft.net,gmail.com,google.com,lists.linux.dev,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,pengutronix.de,redhat.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ovidiupanaitoss@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 79221DC017
X-Rspamd-Action: no action



On 2/3/26 5:43 PM, Russell King (Oracle) wrote:
> On Tue, Feb 03, 2026 at 05:42:07PM +0200, Ovidiu Panait wrote:
>>
>> Hi Russell,
>>
>> On 2/3/26 12:23 AM, Russell King (Oracle) wrote:
>>> On Mon, Feb 02, 2026 at 08:54:52PM +0200, Ovidiu Panait wrote:
>>>>
>>>> Hi Russell,
>>>>
>>>> On 11/24/25 1:27 PM, Russell King (Oracle) wrote:
>>>>> Some platforms have problems when EEE is enabled, and thus need a way
>>>>> to disable stmmac EEE support. Add a flag before the other LPI related
>>>>> flags which tells stmmac to avoid populating the phylink LPI
>>>>> capabilities, which causes phylink to call phy_disable_eee() for any
>>>>> PHY that is attached to the affected phylink instance.
>>>>>
>>>>> iMX8MP is an example - the lpi_intr_o signal is wired to an OR gate
>>>>> along with the main dwmac interrupts. Since lpi_intr_o is synchronous
>>>>> to the receive clock domain, and takes four clock cycles to clear, this
>>>>> leads to interrupt storms as the interrupt remains asserted for some
>>>>> time after the LPI control and status register is read.
>>>>>
>>>>> This problem becomes worse when the receive clock from the PHY stops
>>>>> when the receive path enters LPI state - which means that lpi_intr_o
>>>>> can not deassert until the clock restarts. Since the LPI state of the
>>>>> receive path depends on the link partner, this is out of our control.
>>>>> We could disable RX clock stop at the PHY, but that doesn't get around
>>>>> the slow-to-deassert lpi_intr_o mentioned in the above paragraph.
>>>>>
>>>>> Previously, iMX8MP worked around this by disabling gigabit EEE, but
>>>>> this is insufficient - the problem is also visible at 100M speeds,
>>>>> where the receive clock is slower.
>>>>>
>>>>> There is extensive discussion and investigation in the thread linked
>>>>> below, the result of which is summarised in this commit message.
>>>>>
>>>>
>>>> We are seeing the same lpi_intr_o interrupt storm on the Renesas RZ/V2H
>>>> EVK (dwmac-renesas-gbeth.c). On this platform, lpi_intr_o is routed as a
>>>> separate, dedicated interrupt line to the CPU rather than being OR'd
>>>> with the main DWMAC interrupt as on iMX8MP. This corresponds to the
>>>> "eth_lpi" interrupt in the stmmac bindings:
>>>> """
>>>> - description: The interrupt that occurs when Rx exits the LPI state
>>>> const: eth_lpi
>>>> """
>>>>
>>>> Looking through the other glue drivers/device-trees, it looks to me that
>>>> every platform that defines a separate "eth_lpi" irq might have the
>>>> interrupt storm problem.
>>>
>>> That is highly likely.
>>>
>>>> To fix this issue on these platforms, rather than disabling EEE
>>>> altogether, would it be possible to just not request the eth_lpi
>>>> interrupt and let EEE continue to work? Perhaps a new flag could let
>>>> each platform decide.
>>>
>>> Yes, because lpi_intr_o serves no purpose from a software point of
>>> view - see the commit message below for the details. I do like
>>> removing code from stmmac :)
>>>
>>>> If not, maybe this patch could be merged to add the flag that disables
>>>> EEE and I will just send a patch to disable EEE on our platforms as well.
>>>
>>> We still need the flag to disable EEE for platforms where lpi_intr_o is
>>> logically OR'd with the other interrupts, so there's no way to ignore
>>> its persistent assertion.
>>>
>>> 8<===
>>> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
>>> Subject: [PATCH net-next] net: stmmac: remove support for lpi_intr_o
>>>
>>> The dwmac databook for v3.74a states that lpi_intr_o is a sideband
>>> signal which should be used to ungate the application clock, and this
>>> signal is synchronous to the receive clock. The receive clock can run
>>> at 2.5, 25 or 125MHz depending on the media speed, and can stop under
>>> the control of the link partner. This means that the time it takes to
>>> clear is dependent on the negotiated media speed, and thus can be 8,
>>> 40, or 400ns after reading the LPI control and status register.
>>>
>>> It has been observed with some aggressive link partners, this clock
>>> can stop while lpi_intr_o is still asserted, meaning that the signal
>>> remains asserted for an indefinite period that the local system has
>>> no direct control over.
>>>
>>> The LPI interrupts will still be signalled through the main interrupt
>>> path in any case, and this path is not dependent on the receive clock.
>>>
>>> This, since we do not gate the application clock, and the chances of
>>> adding clock gating in the future are slim due to the clocks being
>>> ill-defined, lpi_intr_o serves no useful purpose. Remove the code which
>>> requests the interrupt, and all associated code.
>>>
>>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>>
>> Thanks for fixing this. I did some testing on the Renesas RZ/V2H board
>> with this patch and didn't see any issues:
>>
>> Tested-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> 
> Would you say this is a regression or a new problem?

I don't think it is a regression per se. AFAICT this behavior was always
present as long as EEE is enabled, but I only noticed it after I changed
the network switch the board was connected to.

Thanks,
Ovidiu


