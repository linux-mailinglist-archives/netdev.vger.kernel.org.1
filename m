Return-Path: <netdev+bounces-281745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IqKEBWH8GnuUQEAu9opvQ
	(envelope-from <netdev+bounces-281745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:08:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EDA4823FB
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1D4732FBDB6
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA6C388E41;
	Tue, 28 Apr 2026 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QundDFMv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820E3806B0
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368379; cv=none; b=TJiUlwZO84BMkhYoKRJEpV6CaWcEe6OQREW5S6vcxh+v6d2YAjh+4eqpc1L0WiHREkabeJSoEkIQTJfd0WGqKNf/ZM+AMwDW7eXdzhyNWHEXdUni+InPpgVKVEclFQ2oqrroz/57HMCPXcUftPTFeESGphL0AOTtLIQCt+IkYd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368379; c=relaxed/simple;
	bh=9Cmk2zEMnqYDCmmzuz7M/Q/Kf4X+1td9feLwCVsavls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3GTWwY0gnxpSVR5Kd54bG40A+dfo7+iu3gBvnkC+FF2pALxul3dDzjLxO8t3IzZdfumHlXDeTV9pQ3GIBWYKR97CSICwhBgR73uhM2mARB2a7fdRJLnSuQkfsMLelS6CDRM4OyB8OlcJ3AVFXv+KVjKb7YegtxxOsOIKdLIQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QundDFMv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488d2079582so131999615e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368371; x=1777973171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/bKX8nWZ5h+TCYbqj5tfLIob37kb6iKL7nSpxWlYBs=;
        b=QundDFMv/byC/UjeX6qUyYUarW3gWzJGjkEa7oIu+C/0B+J61SZzner+sEaiNbwiBC
         SZvQ2wBUfosAJYpKsH7XKqhZ0LDxKhQz+llcRxDOm3qXvNaYzhMSV7YrYSxttDBOIrlO
         VmcJuqFvyW/No5ORyNI+57rg8krZcMtUWg4AJqj1azgfRbEB+vrAsNdsrwJAu1uzyWOd
         1a3J+1MsZcsYtyrWLLHnrtlwmdMqG1wOiwrqvDBd6pZ+B8py41Vx9Fnu7SK1CXoIudi+
         pjtzx1FQsHkpzIv0+rfCCIUDJ/lKMkoXKyX5BqyXU0SgweplA5f95j7Pl/8MPVGZfwEJ
         EfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368371; x=1777973171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/bKX8nWZ5h+TCYbqj5tfLIob37kb6iKL7nSpxWlYBs=;
        b=A2YVDrDWJSxS51XDRgTMowVGrHcjYzdKlPox5BiQ0cdMXhy6BRScaToXe7c4Rh6wZI
         mDoTKsMCMCS8A17j5Ar//sPsS/jfVokUcuuord7YFbQ1mMLqkYfwgaj8FhbH1Ixj73KB
         vuqd9JY4av+n6o77R0OZDyhoLZ00maHGGNdzI4DNazYpc4GryB9iQeB5lMnIn7i5/Dsv
         rm25aGHAy7tP5Ttz3yZghYLqDuJ4M9iPeRtTXPfO/FXqA5dUaa6KAZC0pHQJCW1/sprP
         IhGne7gRoF7RkEoIhFE1f2HDevGEH5zyW3JoIVQynCylNJ8oxeu9Bzxqb9fsuh3wkWJp
         DiQw==
X-Forwarded-Encrypted: i=1; AFNElJ9MU0ASy8JHwFUEhuwvHn3jbeNe1ersWX0ITFuu0/1KDx3KxxKhR2rLzcPPE/Mb/1I1zH/Zu4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEodFmisE++UMq8zXp+PVCQRJCee5iaUGvWwQW0mZhVMqCzD1H
	O9m/rIgWuAaXEaw7iHX9tujVx/jq6eRPIcoNCQE84Hrv7KSQFdpkhhiO
X-Gm-Gg: AeBDievM6CoOWLHqGa0VhF3+/2Ix2wHWr8IguYOFXedNJ+4PSqWJOiLAOPINhodjICR
	qiR7KXcgy2m4EB08SkN8lIr61Wvsog5IveDwv1dAZpUjq+MIaz1YlLBdhmv82oC4GePcQuR/2MH
	MLZHNTgo0zevd7vYKUGhN1STM1MHlbXCbShKGWMcxgowKaGl8J/CfPXH8x9qTh6Qw1e8pMoMbV0
	9vmmCyekO3o6ZT02KBYpzj5NcI111azprwRkJqX/npLAw5K4W1zAH+LE7b1bSrJINew7rR90JnC
	Q1Rx21yei0AlmvvAN5r9FVVuzryMSHLw1hQJgq1JSsbsZhvyVK4D9a/dtTaYY0xoUwPTzDjMv2Z
	HHFHXGGROZrgvjFHIpBcvXbhu6yk7fWg7giO1emdAZj1/W/llYszrGuAGEBeP0cN/R0YQLWBSA8
	RCS+t0A1SyYRZzB8EzWsW7BF6bnM3jYA5Z2I292wFOB2Na+WO3o+fbTlTlb1+k1T7Bbgg3a5QgA
	w==
X-Received: by 2002:a05:600c:c048:b0:489:1e8a:90b4 with SMTP id 5b1f17b1804b1-48a77b2203emr26399355e9.21.1777368371175;
        Tue, 28 Apr 2026 02:26:11 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773f1fa0sm44594055e9.14.2026.04.28.02.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:26:10 -0700 (PDT)
Message-ID: <232d7c53-f413-4c8d-bc70-f03a12d601f5@gmail.com>
Date: Tue, 28 Apr 2026 11:26:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 06/10] net: dsa: realtek: rtl8365mb: add VLAN
 support
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <alsi@bang-olufsen.dk>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com>
 <CAD++jLmRT+3EJ-f_FNuZwOGU4fBB6pGHhq2OuxBS7O-cEnWt=g@mail.gmail.com>
 <CAJq09z6Y3MfkyiyaMhPTQH3W7p-ZmsNeS-iBKOeQNWWpDi0UoQ@mail.gmail.com>
 <CAD++jLkqcqUThJe+kJhR2hwyg1y_RWJc7yrM-kqMeiA4T-Jqig@mail.gmail.com>
 <CAJq09z6O81Sev07pQiQzCXzbKC2JxBCjep6=tX2Noqd=pPW1KQ@mail.gmail.com>
 <CAJq09z6PjXeDYhfo3=UmLyUhXyx5rPHCK4kBaMaJWNZNssjo2Q@mail.gmail.com>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <CAJq09z6PjXeDYhfo3=UmLyUhXyx5rPHCK4kBaMaJWNZNssjo2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 95EDA4823FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281745-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j4g8y7@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,semitron.co.kr:url]

Hi Luiz, Linus,

Sorry for the late reply.

> 
>>> I haven't yet wrapped my head around if the RTL8367 (no extra letters)
>>> is more RTL8366RB-ish or more RTL8365MB-ish... take a look at the
>>> old code if you can figure it out from register maps etc:
>>> https://github.com/openwrt/openwrt/tree/main/target/linux/generic/files/drivers/net/phy
>>> (maybe Gabor knows, put him on cc)
> 
> Regarding the RTL8367 (no extra letters), the RTL8367R is indeed a
> member of that original family, rather than the "B" family as I
> previously suggested. It uses Port 9 for the CPU, which is absent in
> RTL8367B. Architecturally, it is definitely more RTL8365MB-ish.

I wrote the rtl8367 driver for the RTL8367R and RTL8367M switches. I have
no datasheet for those chips, but there are some basic information about
their features [1].

The driver was based on various code found in GPL sources of the TP-Link
TL-WR2543ND and ASUS RT-N56U devices. Those sources were using the RTL8370
specific API for these chips.

It was not clear that the two models really belongs to the RTL8370 family
or simply the vendors were using the RTL8370 specific code as a base, so
I have used RTL8367 prefix in the swconfig driver. Probably, it would have
been better to keep the RTL8370 prefix to avoid confusion.

> 
> The main challenge with the base RTL8367 is the lack of a public API.
> Most vendors support it via binary managers (ASUS) or proprietary
> kernel modules (TP-Link). The only available references I’ve found are
> the OpenWrt swconfig driver you mentioned and some U-Boot
> initialization code. I do have the rtl8367{b,c,d} APIs. While the
> rtl8367b seems close to the original RTL8367, it has fewer ports. Does
> anyone happen to have access to the original RTL8367 API
> documentation?

I have no documentation, but the RTL8370 API source can be found at various
places [2], [3].

To be honest, I don't remember all the details, but I hope that this helps.

Regards,
Gabor

[1] http://semitron.co.kr/product/product.php?lcate=001&mcate=005&scate=004&uid=47&PHPSESSID=ec195486d91ed175f698567462571180
[2] https://github.com/cgoder/openwrt_rtk/tree/master/rtk_openwrt_sdk/target/linux/rtkmipsel/files/drivers/net/rtl819x/RTL8370_RTL8367_API
[3] https://github.com/andy-padavan/rt-n56u/tree/master/uboot/mips/uboot-5.x.x.x/drivers/rtl8367/api_8370


