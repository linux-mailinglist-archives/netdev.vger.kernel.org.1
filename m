Return-Path: <netdev+bounces-238898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D76CC60C06
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 23:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 279DD4E07AD
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 22:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8775722DFA5;
	Sat, 15 Nov 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr1/+SER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C218EAB
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763245547; cv=none; b=fs+xJX8/yETOlU5kTXH1+imUaWG4zksJiUJN/+foF+5mvY3C3rEp1Ss8r/aztEe+8AthVZNFobvHgVwG/M723kRR11YdHZrcLcbbaWOsj7r3AN7D+h0hNKwQmmuh0uywuJdF/ywspinr0FdgmwVGGve3sy5xYg03qx+PUOATkRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763245547; c=relaxed/simple;
	bh=XthBBokWT64Vpxv4JVzasRtIdUZGi1WK4aLpeYO5IXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imjmRUr77hJbWHxemt8lVqYmGB43mlT2DS0CDzpWBcfCFvjtXA88hKA27hHRDYwWVA7/roXwGiAbHzFNVMvOWx76SEdmrZ+AFKe5TuFL9ifZBv3LdsLlgUcMQfwhUGcrifGsh8B9bFmLoCvEOx1FV5KF7D3JkPzwtBwnsWoK1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xr1/+SER; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37b8aa5adf9so29245961fa.1
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 14:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763245544; x=1763850344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7T/6yc0Lchg3VdrpjG2zWIztee6XlqkBAYlj0+Pe7I=;
        b=Xr1/+SERY3t9DdAOfIGU6BJ96r24FFgcZiSZzrFWVo1XA7l/EeT1n7ko99Q14HwXZu
         MPDClRtJa6hiyUJs0vjU0gJlAd3mjeOnPrudeANlfI0ZC+xYiFNaw81y4deTHvewLcbK
         y2+yntET+BYSu+lCrBnLGIrGMU+eUgAdTGvIKVJskpKoyAgixzIkD9iLSqHqZdBT78D5
         xWPZBFhbBeDJIjLXJfGJAfaYQli8T//40bgttCTbg+uZv3eptZBFI8UR1ESb9107/NDK
         nn94svb107HS8DYoI8/52kRFm7PT/5a74pAAQLTxiNM2bstmfUTY1Giiv9gcpkzD76HY
         +4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763245544; x=1763850344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D7T/6yc0Lchg3VdrpjG2zWIztee6XlqkBAYlj0+Pe7I=;
        b=i+5ayajgQoEyoa0rYLGJnbdAQuQIGNjU/oxBBxRjKe/R0pQl8Q2zNEndf11GK60UaQ
         cNjGV9xl+yGjiXfei1rMBbSpF8IecsECtggAbp9Yvn7zM5QckWyCjFNxgrE5d/LlFa1/
         Rt+0WkNpA9R9PvGxHTK1VFpy9cdQTuXq6/C3TRisvEAGmbHnqh2rIm2oDV3AuOOGczx1
         FDTj8wTx09dO6qR9hnoTYEcf9rI7gm22bXKEOCPhU8DgADjaPaGh97V7k/Z+93KL/MxL
         kB6JiYwJ8GiQdHR+2N5fa4xDuJeLMWn2Rv4TsE7ox6Jnihnne0imINF4Ox3Jxaofflva
         pVow==
X-Forwarded-Encrypted: i=1; AJvYcCUD+zQwshHGQy0rF/aeRwJcG/q9IrTZ0ccnL/ITZ765NVrKjgxyup+Q3hZWTRhzJHTKhNUS27A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZSbI8sdHFWuddXwnDvDT14+4kAr6uDma2hVr22CzLGYVQ24f
	Os/bS4mwHgDF3x0cvUhhVi7iBpx4DgTHSHIhCJRerOPQRDQDQbeD3bofzQFRY2PJk2ePPLqRTKn
	yKQhq8h+sV41CU1VrM+oiNU/YZoAxZys=
X-Gm-Gg: ASbGncsV5mQuENN2qvs8MMGsRFSe1yFCw5y4X5loDui21uU7wIaBQH6zRBtFHkPCrwg
	JK/lat68yBu2+z4KhEpRFNrUr6ez4R5eqHmPin7fHrLneDweLTy/27dfBOPpLIzuttQLdgJag5S
	E+DyH7g9M/Rg9M5TPalcpz3Tu/mP4JMTDb8d9b16BvOdVEUFAhEBWLSqyBTQez3IF2qwj2dBGWr
	f0wB98ewcbUo6ImjlZ9uF38MtiSKx2YMAuWBuv5ZZyfW0DTrZ4C/QU8K6soBK2f7LjtW+3fmih1
	VelILRcdiv/XUd9N0Hd6HZrTZWXxJzm4Tp7W2A==
X-Google-Smtp-Source: AGHT+IHe8sWMYy8oqdsHh2FXUS60E6vwnEQKX428KIMfEGeRiQ++/ipfJV2pu6CSrXrbUCavIzsT/gEcQPq7aYGIogY=
X-Received: by 2002:a05:6512:3ca3:b0:594:25a6:9996 with SMTP id
 2adb3069b0e04-595841ee9e2mr2486360e87.10.1763245543521; Sat, 15 Nov 2025
 14:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
 <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch> <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
 <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com> <CAOMZO5CbNEspuYTUVfMysNkzzMXgTZaRxCTKSXfT0=WmoK=i5Q@mail.gmail.com>
 <7082e2d0-a5a9-4b00-950f-dc513975af1c@gmail.com> <CAOMZO5CLvDMgxi+VUVgiTy=TsK75QMYrTYZDEOzY4Y7eN=CRMw@mail.gmail.com>
 <aRj4L-BKoFeaJpWH@shell.armlinux.org.uk>
In-Reply-To: <aRj4L-BKoFeaJpWH@shell.armlinux.org.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 15 Nov 2025 19:25:32 -0300
X-Gm-Features: AWmQ_bljWn4YXjv7qVLAMH4BAwHNMpCwoXG8evSMmU9UFTaXTQomhl6RJUOrkRQ
Message-ID: <CAOMZO5C49MudQzPzWuChyzBoemgZFCVBp9A1XPpCOcWNfDb0jg@mail.gmail.com>
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on i.MX6Q
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, edumazet <edumazet@google.com>, 
	netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 7:01=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> This is no proof. The two are not independent. See 3.7.2 of the LAN8720
> datasheet. A change to the MODE[2:0] field requires a soft reset to
> take effect.
>
> Avoiding the soft reset just means effectively you've disabled the
> effect of the write to MII_LAN83C185_SPECIAL_MODES. I don't see
> anywhere else that the driver would set the RESET bit in BMCR, so
> this write will never take effect.

On this board, MODE[2:0] is 111 , which comes from the strap MODE pins.

This means that the "If the SMSC PHY is in power down mode" path is
never executed on this board.

In the section you pointed out:

"Power Down mode. In this mode the transceiver will
wake-up in Power-Down mode. The transceiver
cannot be used when the MODE[2:0] bits are set to
this mode. To exit this mode, the MODE bits in Reg-
ister 18.7:5(see Section 4.2.9, "Special Modes Reg-
ister," on page 50) must be configured to some
other value and a soft reset must be issued."

I am wondering if the genphy_soft_reset() should happen only when if
the write to MII_LAN83C185_SPECIAL_MODES is done:

--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -147,10 +147,10 @@ static int smsc_phy_reset(struct phy_device *phydev)
                /* set "all capable" mode */
                rc |=3D MII_LAN83C185_MODE_ALL;
                phy_write(phydev, MII_LAN83C185_SPECIAL_MODES, rc);
+               return genphy_soft_reset(phydev);
        }

-       /* reset the phy */
-       return genphy_soft_reset(phydev);
+       return 0;
 }

