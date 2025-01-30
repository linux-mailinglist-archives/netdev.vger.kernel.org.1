Return-Path: <netdev+bounces-161611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ED7A22B33
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 11:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3B61889232
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 10:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644821BAEDC;
	Thu, 30 Jan 2025 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WusdYqMp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9669F19F13F;
	Thu, 30 Jan 2025 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231354; cv=none; b=q5ec8xpFvJQna6WBNE7j3I0X8HE9ifMTevgjSzkVAv9SXcod2jlsJ30jLacSCIvJoxIxWW400G0AEyMAUQQ6DOBm+so3P3vXNU/05CHzWtw/6uLRWr5VHMbuRWg8dnHeQjAqJkWD2NOmzFBm82XM+f+/yozfBgFFF5pyrlOAMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231354; c=relaxed/simple;
	bh=g6NT99kCYlu2bAm2C7e45OSPi49TwQfekfaWpV+BLWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEi1vG1aJUpsGz6XOn1QSz/tVCf7GYZUVTiovbmgDU9lPvAwgqbIohjnJVWM+dKQpxyYLkDsq3dlrSwTTkVz38YzAeeAA1S06TW0173+PjwQU7qyMeRQR81t6pib5Ns2ehu6GcvIfRRvG3jtwysjtayn2FY0kClgBMWgDOj1/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WusdYqMp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e44a1a2dso89550f8f.3;
        Thu, 30 Jan 2025 02:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738231351; x=1738836151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VAj/+6ugpW0lcARLGUzj2/Kg/DjBYxwbsq4/1Hp+yh8=;
        b=WusdYqMpxx9EBwMCfi0AM0m0eaR/KmQLXULy17jS8r2a1tu5M1LQkWIOL9Nwq6qNMr
         Vo4/vWeYAusN+315uE2a5qLD67hBQlCI+okvfbKJrh3Guq6N2tkhPknWDK0GZ+EpKiFX
         wbOdpcO2ycm9sLDccK9RHX2rn0BvQq/FyBcgIiN1F4OqORApj7+knKOLwyD5gXPqXCbd
         XBzRq7t70xvvQRVpB5QhmdmO4wMf9thoruVy3x8KjXb2KhkpaPjcI+5XOvmG82ipDTtJ
         cY+h6pRiJhiai27Pt3FwKRWLL9ci8R+Yh23SPIR9ePhpJ/H+b9LxnB/mzFU9mQEV4HzL
         s/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738231351; x=1738836151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAj/+6ugpW0lcARLGUzj2/Kg/DjBYxwbsq4/1Hp+yh8=;
        b=rEpzbh7y21myovm/ze8fN2Or337YMkhecvUP97EoMj/xlAuIabU5BZnCKsnjrAERPS
         OvEFM0C3lROyTQOnDrPvkrkTbKgdi6kWTPW/RKv6UOG2nFr9lbeqNu/6mRt6nLnDBIET
         LBwKYSsSQSs4uMNjEBY6AQSiBcFWloKNlVzKOv8V/vkn/o8YRy2RegI5GyPY5hKTdz70
         /jidk2JkOE1axDLsnX2KavBykhIQUIk88CjL8LEryek4gK4jrCHPBl9TJtRx7hSi2Jux
         u1rQ55hFKYtGG3/YLdHzbfPDgqy7Xv7LPGJqQv5q5WwlfCk9XvBxDYdHiH4LnhrOChwC
         Cqvg==
X-Forwarded-Encrypted: i=1; AJvYcCUxHKBzj1dP94BAJLF0TKvnC1BeYrCyNDNJwZokSUjvAr82Tn9jPqt4+uIlhafFL4bDkLTmM59s@vger.kernel.org, AJvYcCWFCEbo4SsVheRWpe8QjSqRkSuGDhHXPn88PqDkWfz2z8xGH02VVHuwAMll6siYZgNz8otvCaD57YCT3ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvP07rp53tFTIAXVFscl9NwPhWjZzpSAwvA7Ev9npldqUCchZM
	W7JjgVAGu7al8rEK1MtECbRJ1qhBQant7W2I+HsGCGkK8begsgXa
X-Gm-Gg: ASbGnctFV7eFSvHip/5f3tJEij+peVsDulY1vPgS/faTgM6ygPHbqD2dH6rB0skbMSY
	SN7CNK5pKO4CpR4a3yk1oeBMcMXzVK1aGnBLa67+yn5VrUfAZKwUkhOY40nG+oYp2T6OFHCG/tu
	IoIMQFhDUZyPTU4kUELn8XoPPSyjYkTGhib8wwdVWjkEFIgF5nnoSittfAx4R2N0NtM6oyrrv6u
	ES8myKOZeTla3j+NWj3e/WjP73UHo2OCXGsrGLzUFApSVnVa4RAETR0VXXWHWtHpi3bSWDC0ZSH
	xgs=
X-Google-Smtp-Source: AGHT+IEFNuFJMrQJoYiBhgBqjUhkHpcE/Et30pFazQ0ZffCvLRewq6UyYNLYpoAzADLPNm/9TqsJdA==
X-Received: by 2002:a5d:5f4b:0:b0:385:f909:eb33 with SMTP id ffacd0b85a97d-38c52092755mr2147799f8f.10.1738231350670;
        Thu, 30 Jan 2025 02:02:30 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1cf7cfsm1439532f8f.86.2025.01.30.02.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 02:02:29 -0800 (PST)
Date: Thu, 30 Jan 2025 12:02:27 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com
Cc: linux@armlinux.org.uk, Woojung.Huh@microchip.com, andrew@lunn.ch,
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Message-ID: <20250130100227.isffoveezoqk5jpw@skbuf>
References: <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
 <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>

On Thu, Jan 30, 2025 at 04:50:18AM +0000, Tristram.Ha@microchip.com wrote:
> I explained in the other email that this SGMII_LINK_STS |
> TX_CONFIG_PHY_SIDE_SGMII setting is only required for 1000BASEX where
> C37_1000BASEX is used instead of C37_SGMII and auto-negotiation is
> enabled.
> 
> This behavior only occurs in KSZ9477 with old IP and so may not reflect
> in current specs.  If neg_mode can be set in certain way that disables
> auto-negotiation in 1000BASEX mode but enables auto-negotiation in SGMII
> mode then this setting is not required.

I see that the KSZ9477 documentation specifies that these bits "must be
set to 1 when operating in SerDes mode", but gives no explanation whatsoever,
and gives the description of the bits that matches what I see in the
XPCS data book (which suggests they would not be needed for 1000Base-X,
just for SGMII PHY role).

There must exist a block guide of the Designware PCS that was integrated
in KSZ9477 in the entire Microchip company. Or at least, the hardware
architects must know what is going on. Can you help reconcile the XPCS
specification with the KSZ9477 implementation? "The bits must be set" is
not satisfactory when we are considering a common PCS driver. Were these
bits overloaded by Microchip for 1000Base-X mode for KSZ9477?

At the very least, it sounds like it is improper to name these fields by
their documented role for SGMII PHY mode, when clearly it is a different
and undocumented role here.

