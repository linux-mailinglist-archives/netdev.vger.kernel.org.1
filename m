Return-Path: <netdev+bounces-177817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7D8A71E2A
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E2216FBD7
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240FD2517B6;
	Wed, 26 Mar 2025 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSz+5m5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654221F7561;
	Wed, 26 Mar 2025 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013099; cv=none; b=G1oM0da44Y4qFiT8jZyDf/V0cvF4gGWzK4gRCW4ONMWSNv2iHXku6Y+ZGxuElTH8HRDtLWAVIKHswkP8LK6XvHQlR0fT31Me+NcU/mhvnBWFGjNNoQQSZQTmF/haCEX/LOyawGSo1Xiiac8PPQovcd5fn/kgCQRSScM2Uh3pZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013099; c=relaxed/simple;
	bh=BCcusAiZcAMHVSpBfkVYYDvlZnORz0u1WzBhrdpt5Ek=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHmpADEYXLC0sH7yZHIWjXWXNQWZNMOBWN9C55cYMvuTGc9kCiI1vngnFn01UEK1P4G/P/JibZcgccm7EghJLDCRJ6TQKELLrNRcx+MbSi7Ohcq9dRb9a4ZtXarDsQjsYzc9wci+B1uylahTnJsCu2uv+u6ZQgwMJlnNxXtf9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSz+5m5Z; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso74460f8f.0;
        Wed, 26 Mar 2025 11:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743013096; x=1743617896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h+OYzJdahmjkb1uM2uwDmxOrko89EeT2kB7mZ5ExR2w=;
        b=cSz+5m5ZQiWief4kYJKcjABIqS9nQB1puBb7V10vYvm+IcqOgrh/XsUFUer1HeeCMk
         iBNobf4W1rpAkbsa8U7zyLXHd50045UaKGalziFgICYdzgTnWkt7hpnAflvry6jWd2c7
         GYkSb58nc4mDstZsW3xgGX+xHy5TJuJwGZ4aBC5/MJYkOca1eXhBcK0FmHSmGEreQXSv
         KAmhD8IL64V8kOVeozQyXlPWPRP/73wRAXh/Z43bzQR3Lun48WmHBZ+9TleWldVwukhu
         zt+TA23xPwWw5bQDGer2NOYsiWjvdX6oxMg1cTkpJaPCNlORFTQUc38CK6srepQQi+me
         P7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743013096; x=1743617896;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+OYzJdahmjkb1uM2uwDmxOrko89EeT2kB7mZ5ExR2w=;
        b=B9Ct4H1I6Irbzhtzmhz49r6YAeHwM7lVfpCXEB2q8HLAQzvO0nD6338ZlSKDK8pv3q
         KKSCQrr9VPPgBMbLy9s0rjManqJP5mfalvHPvCEUDZ99c3kA9b/NdgPjCStU6athKAgY
         /N/1RTjwBHdc9eEwCr6PxzDtTOxOm3STTSXhNdu5Ocu9lkyhEhpoBEw5MIMpdLv9jPJW
         bhA5BChzq3TctmW2adOKuvmdpg7C0/idl3jl/mPlLtDIEEDnWgVT/0LEoVOawlTyBbj2
         6Alke+HA5FV3zfDM2gY5rmNT3IqYNbkALypVHE9JGiy+5r8zvYoFcLrv0xlr/XCjyXL7
         ueOw==
X-Forwarded-Encrypted: i=1; AJvYcCU6x6Y/2dE8cs1E1gkYo1NzvN7n7r/UqopzM7sfJY+XUwQc6i/n3IMsjvC/G/62B9BA4w60EbkIkCrF@vger.kernel.org, AJvYcCVrOwB19vBEGRLA8Y4EeVbaNk/LFiTG88P2DbJoN2IgJKG5hDuQFM6fNyUvvVwkXqBeoZHhlw9Zu8d5sBEH@vger.kernel.org, AJvYcCXF8SRCLDWnA1LiGUwkZV/wYobazTVkDIyAXOiH7Qha4MwqB+aQy0Iuw0qMMIPXnL/jDJ6zF6K6@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIqr8Ke85cTTS6oWibGobVmw2ZcRPAsdNSh8Nve9cGvtWLF18
	5cQ20YDv+3uenTs/DBuC9NIa9DF1kRzTn0bZaLPruoOy0G9++t6o
X-Gm-Gg: ASbGncukMAeAAEkcEsAtxxVwdTBa6TzuRfV0tM0EVi4+XGdFgsUUp8i+30wTusciwu4
	mjtdaZVBS+XR83jSkrMBi1BaEdUZpOTLPwlJS4IwYzd5kI0ld1zyc6xbkogUgY+6+nYTcr9YPvx
	ffaVdIl36L/KDpPpxzBFlkAxHRmCEc+9WwYd9QJFqXOnQX4A/Y0/XtGaTAG7aAxk6B5slvwvca9
	6M6+mLHgxXxMiWdUP8idAWBSx4g875pEmjpzXuX3IX2Vo4Xa/mrqWzTFIgQ2pdxQorelcoQ8GRe
	0susBUH4F40JHjfIbA3QKrEPd6J5Ipm2nQS3aMNSTz1aIMdH0BJLOVHlVZ2IQHwdfq4Wt80Itux
	t
X-Google-Smtp-Source: AGHT+IHbLlrFdmSIcrPT6c3gVNy3Gg0+ecoorqwfqJv6yTpwt3N7gCX+tGY77Wakr5GU6+aKMH/Aig==
X-Received: by 2002:a05:6000:2912:b0:391:30b9:556c with SMTP id ffacd0b85a97d-39ad1743cd8mr466272f8f.21.1743013095347;
        Wed, 26 Mar 2025 11:18:15 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efc9bsm17258861f8f.87.2025.03.26.11.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 11:18:14 -0700 (PDT)
Message-ID: <67e444e6.050a0220.81044.004e@mx.google.com>
X-Google-Original-Message-ID: <Z-RE5O_FKEY3y3Vt@Ansuel-XPS.>
Date: Wed, 26 Mar 2025 19:18:12 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 2/3] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
 <20250326002404.25530-3-ansuelsmth@gmail.com>
 <dfa78876-d4a6-4226-b3d4-dbf112e001ee@lunn.ch>
 <Z-RCiWzRWbv7RlHJ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-RCiWzRWbv7RlHJ@shell.armlinux.org.uk>

On Wed, Mar 26, 2025 at 06:08:09PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 26, 2025 at 03:56:15PM +0100, Andrew Lunn wrote:
> > After the firmware download, the phylib core will still have the wrong
> > ID values. So you cannot use PHY_ID_MATCH_EXACT(PHY_ID_AS21011JB1).
> > But what you can do is have a .match_phy_device function. It will get
> > called, and it can read the real ID from the device, and perform a
> > match. If it does not match return -ENODEV, and the core will try the
> > next entry.
> 
> Before it returns -ENODEV, it could re-read the ID values and fill
> them into struct phy_device. This would allow phylib's matching to
> work.
>

Is it ok for PHY driver to change values in phy_device ""externally"" to
phy_device.c ? Maybe you still have to read the other response but a
bool with needs_rescan to handle this internally? 

> > You either need N match_phy_device functions, one per ID value, or you
> > can make use of the .driver_data in phy_driver, and place the matching
> > data there.
> 
> An alternative would be to change the match_phy_device() method to
> pass the phy_driver, which would allow a single match_phy_device
> function to match the new hardware ID values against the PHY IDs in
> the phy_driver without needing to modify the IDs in phy_device.
> 

I also considered extending the function with additional stuff but then
I considered that would mean rework each PHY driver and destroy PHY
driver downstream, not something we should care but still quite a big
task. If the -ENODEV path is not OK, I feel an additional OP is better
than tweaking match_phy_device.

-- 
	Ansuel

