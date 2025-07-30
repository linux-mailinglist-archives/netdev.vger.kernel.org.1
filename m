Return-Path: <netdev+bounces-211063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5B1B1667E
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 20:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A871AA4148
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 18:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53732E0B48;
	Wed, 30 Jul 2025 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QhtqDkFM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F14BE6C
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901160; cv=none; b=hVj98iQzaE9cEluxVEg+byOWmI3zaoyEah7syK4RJiwj6be9NqZl29EZrQL5NEyl7rjirL2uH/Ac87fQUpOuNQdv7GJa3okPk1zyCAyAPC8sElF9c5xxE5fs5L+c+fX31T9+Smw4dy7wC+9A0r6E1lyYJ9pbUtDRZj9w/v0Aq9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901160; c=relaxed/simple;
	bh=1z1U0obMkiLsmQaExQuoJDPQREdMzdgQHbnAO/wm344=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJLJdNNij2/SrrutBS+718rcEt8lgOPapIZdgO8TfuOQwTQVISr57JOqxEMithTKpvuRbj5tFUcCmdcEciqTkfe0MSpYqHop8RSonU3fQGw3Js2WpziFIlN0oeyaRRvy5glS+UcVBIHwmmvhRKJ7UkXcQOg/+bcGeqtrFq/cnyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QhtqDkFM; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e62a1cbf83so24722585a.1
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753901158; x=1754505958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F+eATscs7aYEx7D5z9es6qkQ0c9vyiUmimHLhMPiQ9E=;
        b=QhtqDkFMgftLjZiv5ydmSlGlyPORGC77Wph2JJ5TmQ/nnYApmiGeBEYISOLB3pDB7g
         mSh9k+GAl5YDm1WEmFMFHREskhXV1554EqEgLeR7/xZZYu9M1cGDuXVAwBpFHh8JNuOT
         sRHUsvSLgvCBpENAPzN+0/Nc6Tz4R0BHtbUAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753901158; x=1754505958;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+eATscs7aYEx7D5z9es6qkQ0c9vyiUmimHLhMPiQ9E=;
        b=mY1DEKw8s5FNmQW6DIqEQHfnWWNTP7q+MbZPcMA9pHAuqymkAytw/LmyFZqFDNzczp
         J4mTvQX8p+7uwL+6kWX+44zIP2WXoj5/N09Bd6nkHBnsHw8uwrh38xoMYZdoOHbQkRfF
         hU1h8E9XeyH4DuTLg7zxhASTDeqFzi8TapjXTzfldvWG7Z71gS0nApZdVcjlf7mukFDI
         tq5gDFmD6R12bTBVrtMv5+0vBhxlUbnQ8UeNgDR8fOqALOpbsTyTVeqPTiDKW0qwO0zo
         yVgt3Pz3l9WkBExv7xTy9Pb65eCV40YQWhhJMPFaWuMaXULuUZvVbc0k9rrNDBBwJgE0
         tLrA==
X-Forwarded-Encrypted: i=1; AJvYcCU0ixHYIIpqzaccLrVAZyod/N5ZcCOp8A3at9PR28PIwBBH/gbglMMtyxXluazd0EZzoqds+8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiucLRPDbn3fsMYOZMTBhUo1W68iB+i7OoPv3nBTC0qDWi7zNV
	LWmlaWvg+srRYuoX7y3cYTRPiMnY3CRMywW+LgSJ6ma5AzAfuWbDJSDgqrIqXIc0mQ==
X-Gm-Gg: ASbGncudcLeTmEEkCix4WisIUJPVwpJFgTU9CYS+U5n2tdMniDgtb6z2J//X+3Sd/fZ
	2E6EkpZLbruSXVlPqjDD+Q4HXAU66eVUh+f/5akevnzNlM2ZPyTED1PUPJQSpkMmMZ/tYEK+jpO
	aeeOYfzYVxLm34ueVN0wT8zxAADgRfQQ2uPhFmEB0K8Ja2SQwvRQjIyASG1sjFHSPeEwl/siRDo
	tD/suw1bgVDwT35iSyoe+5pBQg3U9OkDSRjHzp6eXBLmbsnvu/6dx0/3hBBX7wa1WxeRC3PZlEJ
	tZOzHzyASMeXqj+ZkkCAlpVsV5JI5/Sr0enqwwMLvCQMErhyIhnJ0pBIdPzBFn+mazWXSN0B0RC
	4dcfmew7hFmweVcq+OGzRPiTKRk1PoX8VLi+wDAnDI5f6Eo1B3/tPEw6mwJjdaA==
X-Google-Smtp-Source: AGHT+IFOwz0qUu8e6vv/suvXI/Y4ObqQePUsZmD2wb8JPAJegrxE9SglsiFWDWrbhSW1iAvnvddVWA==
X-Received: by 2002:a05:620a:aa03:b0:7e3:49b5:d53f with SMTP id af79cd13be357-7e66f397d1amr395742785a.34.1753901157460;
        Wed, 30 Jul 2025 11:45:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e64388e9fesm612736385a.72.2025.07.30.11.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 11:45:56 -0700 (PDT)
Message-ID: <c02f1bdb-0134-4edf-b3a7-8bb5152c11d0@broadcom.com>
Date: Wed, 30 Jul 2025 11:45:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC ???net???] net: phy: realtek: fix wake-on-lan support
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Daniel Braunwarth <daniel.braunwarth@kuka.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
 Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Thierry Reding <treding@nvidia.com>
References: <E1uh2Hm-006lvG-PK@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <E1uh2Hm-006lvG-PK@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 01:35, Russell King (Oracle) wrote:
> Implement Wake-on-Lan correctly. The existing implementation has
> multiple issues:
> 
> 1. It assumes that Wake-on-Lan can always be used, whether or not the
>     interrupt is wired, and whether or not the interrupt is capable of
>     waking the system. This breaks the ability for MAC drivers to detect
>     whether the PHY WoL is functional.
> 2. switching the interrupt pin in the .set_wol() method to PMEB mode
>     immediately silences link-state interrupts, which breaks phylib
>     when interrupts are being used rather than polling mode.
> 3. the code claiming to "reset WOL status" was doing nothing of the
>     sort. Bit 15 in page 0xd8a register 17 controls WoL reset, and
>     needs to be pulsed low to reset the WoL state. This bit was always
>     written as '1', resulting in no reset.
> 4. not resetting WoL state results in the PMEB pin remaining asserted,
>     which in turn leads to an interrupt storm. Only resetting the WoL
>     state in .set_wol() is not sufficient.
> 5. PMEB mode does not allow software detection of the wake-up event as
>     there is no status bit to indicate we received the WoL packet.
> 6. across reboots of at least the Jetson Xavier NX system, the WoL
>     configuration is preserved.
> 
> Fix all of these issues by essentially rewriting the support. We:
> 1. clear the WoL event enable register at probe time.
> 2. detect whether we can support wake-up by having a valid interrupt,
>     and the "wakeup-source" property in DT. If we can, then we mark
>     the MDIO device as wakeup capable, and associate the interrupt
>     with the wakeup source.
> 3. arrange for the get_wol() and set_wol() implementations to handle
>     the case where the MDIO device has not been marked as wakeup
>     capable (thereby returning no WoL support, and refusing to enable
>     WoL support.)
> 4. avoid switching to PMEB mode, instead using INTB mode with the
>     interrupt enable, reconfiguring the interrupt enables at suspend
>     time, and restoring their original state at resume time (we track
>     the state of the interrupt enable register in .config_intr()
>     register.)
> 5. move WoL reset from .set_wol() to the suspend function to ensure
>     that WoL state is cleared prior to suspend. This is necessary
>     after the PME interrupt has been enabled as a second WoL packet
>     will not re-raise a previously cleared PME interrupt.
> 6. when a PME interrupt (for wakeup) is asserted, pass this to the
>     PM wakeup so it knows which device woke the system.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

This looks much better and straightforward to me, thanks!

> ---
> I've sort-of tested this on the Jetson Xavier NX platform, but it's
> been difficult because it appears that the whole interrupt/wakeup
> stuff for the SoC is foobar in mainline. One gets the choice of
> specifying the GPIO interrupt in DT and have working normal interrupt
> or the power management controller interrupt for the same line and
> having wakeup functional. You can't have both together.
> 
> I'm not sure whether this change should target the net or net-next
> tree; what we have currently in 6.16 is totally and utterly broken,
> so arguably this is a fix - but it's not a regression because 6.16
> is the first kernel that WoL "support" for RTL8211F is in. This is
> also a large change.
> 
> However, I can't see that it was tested, given all the problems
> identified above. As a result, I've taken the decision in this patch
> to not worry about breaking anyone's existing setup.
> 
> So, I have no problem with requiring "wakeup-source" to be added to DT
> for rtl8211f PHYs that are to support wake-up, meaning that they are
> properly wired to support WoL. We can't tell just from having an
> interrupt - not all interrupts on all devices may be wake-up capable.

That seems entirely reasonable to me to expect.
-- 
Florian

