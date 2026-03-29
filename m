Return-Path: <netdev+bounces-272862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nYS5CyG0yGlMpQUAu9opvQ
	(envelope-from <netdev+bounces-272862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 07:09:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBBD350CC2
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 07:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F6FA3016246
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 05:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FAE256C84;
	Sun, 29 Mar 2026 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjw2F9zp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6D1D5160
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 05:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774760988; cv=none; b=d1Fa9ouYCmEIod5E9eX31+oPOc2mdMU79kmJ9pJ+KlVztpf2kYTR69tt620LEaEiUwOjhD4x+t3kwD8TKEosdejSHs5WyzIKghZBdgxQOkD2esbesushtQFCk+pgdBcJu77ar8505FZS2NvzdE0m/99J481I8b7vJdNY/JDqzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774760988; c=relaxed/simple;
	bh=XcQG0KbCJc+fgQxt6iRAWzty/YENJD2WYcxNHX1Vfjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqP/jzIKYy4NNfSICHX4mno4+SopFiOXbhDUWuuEnnhMrtbCde9tbXvNw/plHp0ct3NcsF8KT0QXqxUEGKgXHjuuiPAGwyWlSo4MsaDF5bj1w9z5K/fvPaKcfSNas5b/PiUKT3csbkxT1A6gFJdv97paIfPK7U23Nx/QybFrY+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jjw2F9zp; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so416046a91.2
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 22:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774760986; x=1775365786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifVKr93jGVH2yIRiQnF/GXY0v1LX7aDY3yGFgOalIIk=;
        b=Jjw2F9zpwOrRykjwQcU27DyN2/c0LGoj54W82iH+YwQbqGclhGNdiihVkQM0+uUuTh
         581CjJlTAb6qLEre9pgXKjXxfbC+83nUetL4KE+xhoSEfhdd9UOM4wRBWv8wQFo7ekpw
         4xh69kqq6ZM5RHHN4sX3O4BrIyPJA1WE45b8YqwdB1Dc+vDn8WUHiRzzEbROLhvkCG33
         wYys8IV1tDLTzg5P8qNfpwLpPBWaaBkaJiDRZeNAyOT9By6/aRccHjMvX8u3gAPoJUV0
         i57gaIm/KzqBurqChHCtcGBRSsuaqix0Ka3nIpmtQovTrFSnJq66trA+jGIyAEcmTTcR
         QNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774760986; x=1775365786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifVKr93jGVH2yIRiQnF/GXY0v1LX7aDY3yGFgOalIIk=;
        b=gUngWSes+DXE6msRU9gns0OViQj7+BLcMvwXCp45fDpuYHlRzsjY3LKuv7TX2GT/8i
         ew4UhPdQXr/PGKczVYAt8dSFSV+T3WL41ymTglxmiKHLtdmNAGz2jzoRkME5yNbtZzmQ
         9YtLfYKAXUoQ2eILd47USgy8UTa3Xk6NtKCsRJ62TdAsZAokP8SOJfp18wCkdeOQNDBw
         At7LXnp345VEBQkXYUUdMM17LHDr/wVgJqz/zdVCnI55AiSQlX42q5Nv/PZ8W+9O/res
         LFQbdJU6RhfgPgmUBW+JKku7M3cdug7RfwUun8NEw628x8qzTgnrgsAxWrl4UoZa62Qe
         a/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1p0WvGEsEDMXhPIkoJdMxrINuNSmB3P/hsxv7SU1aQ/5OmqfoqN1bQ2skDwU7ziByvPJ/g+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPC4jpRo3NXw/1V/bypw39mIbah13XeKpzTo7SpX/X4pxhNsl+
	sGKI3dgOYov+trl13Vy5yCCIWLwSr/LQqHL3lejcnoU7nNBtFHT7amTO
X-Gm-Gg: ATEYQzxD3J8oUlT3SARybk1rHCu34Fm8daqI4I3DDPOK17wMBZI4SZrfEUJOOj1TP98
	f7XhO6rP0ac15lnb8UTVGsRQm+dcqL4Kz2MbJ0UcawWrXwBvFWceONJnZV5D4K1HNg7/NrSrRij
	waZHsEURpFAVAfiQGKL+KqXnRes2O4JX6kEd0aA6WYKVAHsfcjHCiokLahsTzIxBNOl8CwYtQER
	VKrfR+V99S8Oi4UU/CfhwjcngQGHaRMDH+BEzeTC+GbfLy33c15S09JySj+ddHxMyYegPTgyBQo
	rcAxRUrpiJYbj2oEFeJdAl6ehURbZG6y3L0vPxpDvKY6zXfiiHwLejLRReRMDFEYMuDfXFy1BUr
	sMDW274NOXfFxH6uW25zuqvdbfHutEx/ouPnZUquhOzd9DztysgDxse518DXzz9C5eXaG6l609h
	Z/nhtC2EV2ZxB3HmNa61nSPNO0r6YM/76HjWGdSfhXgCNAXYwsItnxQPL/I0dOU6/hnmEjo09N/
	h4S8juBFNI=
X-Received: by 2002:a17:902:db08:b0:2b0:9c2b:641d with SMTP id d9443c01a7336-2b0cdc1fd28mr81702895ad.2.1774760986153;
        Sat, 28 Mar 2026 22:09:46 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c176fsm39183165ad.77.2026.03.28.22.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 22:09:45 -0700 (PDT)
Message-ID: <41ad999d-786f-4aa5-b6bd-9faff016f7ff@gmail.com>
Date: Sun, 29 Mar 2026 13:09:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
To: Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Eric Woudstra <ericwouds@gmail.com>, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn@mork.no, frank-w@public-files.de, daniel@makrotopia.org,
 lucien.jheng@airoha.com
References: <20260326153518.8387-1-lucienzx159@gmail.com>
 <edeee8e5-0de3-48ea-aeb5-cc705fdcd469@gmail.com>
 <6f42d92b-a26d-49a4-bef7-2227c252eea7@gmail.com>
 <acesgklpv8GlNeVf@shell.armlinux.org.uk>
 <e1a3ca7c-99f0-4452-bd5e-ca3662fd8d9a@lunn.ch>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <e1a3ca7c-99f0-4452-bd5e-ca3662fd8d9a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no,public-files.de,makrotopia.org,airoha.com];
	TAGGED_FROM(0.00)[bounces-272862-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienzx159@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FBBD350CC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Andrew Lunn 於 2026/3/28 下午 10:15 寫道:
> On Sat, Mar 28, 2026 at 10:25:06AM +0000, Russell King (Oracle) wrote:
>> On Sat, Mar 28, 2026 at 11:21:59AM +0100, Eric Woudstra wrote:
>>> static int air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
>>> 			      u32 pbus_data)
>>> {
>>> 	int ret;
>>>
>>> 	mutex_lock(&mdio->bus->mdio_lock);
>> I wonder why we have phy_lock_mdio_bus() but not mdio_bus_lock()...
>> Should a helper be provided at mdio bus level to complement the PHY
>> level helper if we're going to have MDIO drivers directly manipulating
>> the lock?
> DSA is pretty much the only class of mdio driver. And they mostly need
> to use:
>
> mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
>
> Not the plain mutex_lock().
>
> Hence it has not been added up until now.
>
> But yes, such a helper would make sense for a PHY driver having to do
> odd things.
>
> 	Andrew

Thank you for your feedback

I will implement the helper you suggested for this in the next iteration.


