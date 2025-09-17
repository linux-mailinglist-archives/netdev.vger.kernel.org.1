Return-Path: <netdev+bounces-224051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946D7B8007D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07852A4C24
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DDC2EF65F;
	Wed, 17 Sep 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHQdZlm6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6132EB5D1
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119508; cv=none; b=X1YVSVmnbuW0ekKw2/fiBoQKlUe2jI5i4+U7H3YtD7lED1z4Ep8hNvYWcaI1O80ZIED30JV+PVjB3KbcHaDAD/2gP7Ojb6RCyvuiGoh5vV8+sjCw3f+9iKI/V84Xn1nltY4we7IqW7NwQQtCCztaE/8R3TTc6gg8p6WLF5Q3Xg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119508; c=relaxed/simple;
	bh=pmZTa+8cnY7Efr6/mRZy0dWltDPz1nlF8NdW0P91Y9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AqdEuwSIGi8H41+QgVTIsmUcHsIBKREcmBQVgFMP2OVygxDXspcqD8xiOdqFkaKI8yTaOQf6DoCxXhja/Yc3uo41NFN6H06abL+H6kHKReD1cLXsVYEHcChXcXIJPTOUMaSsD6qM/yc5BuHIG3J3Fc/kJCOgak5dOyUTxEnikHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHQdZlm6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62f1987d4b2so8201290a12.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758119504; x=1758724304; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyY1RV/auovX2uJdCFMa3w6J8/ewCXkxPUNzbeKoZdo=;
        b=UHQdZlm6FfREwgu05wpI5BdkNT31V5dJKYkcA1EaCthiu75PTdoseiV+lM6YMpWRLh
         Z1vNYbS7Wo9ojMxun7qhGvFmX038VqYjBQBrkXoWwRdnw6N449GpQJm8mk0dsRWX9gkl
         czHnw2NKvUfN71vkjglJyuvjUuRs07zCypvFHaz8BR6vVUXNBJf/+i1iOZJPsD7xYfTE
         YbR5A2GZSs8uLoMbxS9ZRtZ3K+C1qIL/BztW/QtQZho73omSFrHWyEaovwmeN7Xo3vBW
         42naUpdLwlkaw7OulfcHc3F7ZoR+yFb8FFYXf+izAiQbV11B/upY3WWuXgxMDhM09vX/
         QGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758119504; x=1758724304;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IyY1RV/auovX2uJdCFMa3w6J8/ewCXkxPUNzbeKoZdo=;
        b=hzt75bloCwNK+Z17mh5Xzl5gG59CfndxC8+hJ2fi5BYVHbEf9prYbtmbp1oQZQNo7r
         J1jW2RbZxlltyZLzEiX+5RwQsT0YqPJjL5dI6QP6M4hZlXv6UjFWaE9C3soVmjqIIfoo
         0Xfxkr73Szqc3HqwBQ566/rITOnb5OPJfuRmzqsuZSw3rny/3NI+K7UDTjfT5Q60yK+I
         Tx8Ml5zKKdPtmZsWdjaITqPaOIQmppUzMTaCWztLwkrPWLLuDEhP/A688/LiUQw68iEp
         2+Yy54Gm84pRHNFUcUK7NzyXLa7gtZsHOYRRpCTar4ref1hkIRBVxB++a+E1w42xwjfm
         1wNw==
X-Forwarded-Encrypted: i=1; AJvYcCXHSFUGZaiqcCu1mcV70F5zWSUtJC0Eg4Cj0AoTOaODLUyfROzGmVZC6P74PJAk6qgilOxL1RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzRp3VP8ZN5ASxEkvU4m8P4UDSjiORkkIHI4I7Ili9BWn+CzGG
	EbZaxUls8z/YvUTRferex7D/IQU0iI3xW9fhJ4aI5pkQMzgdq2zw19bh
X-Gm-Gg: ASbGncvxkN4RmSyZgFfA7kTTnjnIRIYwAxP5GNq8KiSHhPzONjfJNYd/I/r06b2RzI0
	DIznQ/67Zp9kXJJ1XLSOj4azt+SS9grooat5D2ayoCmJQ97pannDPQv1aMrzSEsOIp/fawTvBCp
	ujn3n3+Zq2WPbywPfVIdg5fiVTG5p1+jVtjh6tKrEj6LtFrag4JhgzpgTxWx05IaTrCg2VFpLuk
	5ftiCa4l70WTB49z1IQ0VifxDT3erhAI52Yso316Hwz/8g8XhVEYRVl9sRTsf/CT3tsPcoSidDD
	tAM8DWwN7kOGQe6yxDAhJXuen/lE1lNEWrSqWTSrJ9LIO2P5+6hfkMWu3EbudyC4IKY/YiCgJ9r
	mdaNVKNIQ57B+uy0B6Q6pG93YNUYI1t4zZdnVQAlPLgzMk3+gpP0iOxTVy7BVK+8XSNU=
X-Google-Smtp-Source: AGHT+IGSu0kLCnKgEdILIwXArUGLgXbeJB2AOyLfpHxUrOACUzPlxCRqec4ro27CMYP0cvBESnTAKA==
X-Received: by 2002:a05:6402:3252:b0:615:6a10:f048 with SMTP id 4fb4d7f45d1cf-62f8443a507mr2008537a12.33.1758119504155;
        Wed, 17 Sep 2025 07:31:44 -0700 (PDT)
Received: from localhost (public-gprs292944.centertel.pl. [31.62.31.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f70984065sm2433229a12.33.2025.09.17.07.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Sep 2025 16:31:40 +0200
Message-Id: <DCV5CKKQTTMV.GA825CXM0H9F@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, <stable@vger.kernel.org>,
 <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, "Lukas Wunner" <lukas@wunner.de>, "Russell King"
 <linux@armlinux.org.uk>, "Xu Yang" <xu.yang_2@nxp.com>,
 <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
From: =?utf-8?q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: "Alan Stern" <stern@rowland.harvard.edu>, "Oleksij Rempel"
 <o.rempel@pengutronix.de>
X-Mailer: aerc 0.20.0
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
 <c94af0e9-dc67-432e-a853-e41bfa59e863@rowland.harvard.edu>
In-Reply-To: <c94af0e9-dc67-432e-a853-e41bfa59e863@rowland.harvard.edu>

On Wed Sep 17, 2025 at 3:54 PM CEST, Alan Stern wrote:
> On Wed, Sep 17, 2025 at 11:54:57AM +0200, Oleksij Rempel wrote:
>> Forbid USB runtime PM (autosuspend) for AX88772* in bind.
>>=20
>> usbnet enables runtime PM by default in probe, so disabling it via the
>> usb_driver flag is ineffective. For AX88772B, autosuspend shows no
>> measurable power saving in my tests (no link partner, admin up/down).
>> The ~0.453 W -> ~0.248 W reduction on 6.1 comes from phylib powering
>> the PHY off on admin-down, not from USB autosuspend.
>>=20
>> With autosuspend active, resume paths may require calling phylink/phylib
>> (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM
>> resume can deadlock (RTNL may already be held), and MDIO can attempt a
>> runtime-wake while the USB PM lock is held. Given the lack of benefit
>> and poor test coverage (autosuspend is usually disabled by default in
>> distros), forbid runtime PM here to avoid these hazards.
>>=20
>> This affects only AX88772* devices (per-interface in bind). System
>> sleep/resume is unchanged.
>
>> @@ -919,6 +935,16 @@ static int ax88772_bind(struct usbnet *dev, struct =
usb_interface *intf)
>>  	if (ret)
>>  		goto initphy_err;
>> =20
>> +	/* Disable USB runtime PM (autosuspend) for this interface.
>> +	 * Rationale:
>> +	 * - No measurable power saving from autosuspend for this device.
>> +	 * - phylink/phylib calls require caller-held RTNL and do MDIO I/O,
>> +	 *   which is unsafe from USB PM resume paths (possible RTNL already
>> +	 *   held, USB PM lock held).
>> +	 * System suspend/resume is unaffected.
>> +	 */
>> +	pm_runtime_forbid(&intf->dev);
>
> Are you aware that the action of pm_runtime_forbid() can be reversed by=
=20
> the user (by writing "auto" to the .../power/control sysfs file)?

I have tested this. With this patch, it seems that writing "auto" to
power/control has no effect -- power/runtime_status remains "active" and
the device does not get suspended. But maybe there is a way to force the
suspension anyway?

> To prevent the user from re-enabling runtime PM, you should call=20
> pm_runtime_get_noresume() (and then of course pm_runtime_put() or=20
> equivalent while unbinding).
>
> Alan Stern


