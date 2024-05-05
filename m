Return-Path: <netdev+bounces-93539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700858BC331
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 21:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7F71C20936
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F63E6D1AF;
	Sun,  5 May 2024 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf6QD6eV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0F6CDC0;
	Sun,  5 May 2024 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714936324; cv=none; b=KDmY0N0TYM8rWqCFpLMQzct1Ge8XjK6sWv1Uj37kwcRVZgRPoEHwCce+0R5a0v7PQmLVA7QgrhxSofvVmswmZEt7SlvBt26Q6r8WPZtV6jaAQIP/+Kq7F+QXb/VttLDlv4OPJBVdWR2nxGtTHx2YPI5lHnKcA+M9X2bJXMimr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714936324; c=relaxed/simple;
	bh=Y/fgiRvdyX1dKn8PkYZ5U4KnX7N47T7a0/DDwHEj9bo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HnRAS89wW+rNfSjmHZpnnTm28AyG7joim2FVCokckEPe6kr4RlN1nDyuiJb/IrQM1HOvUA+t8AwsEJd10kMDZd802oI1F1ZkWNl6MZrBGXf1xit0hcuwPD4w3CeRg4RM1tMJzBnCw9V/M6F8S+1YahT7bzo1rE2k2rdobbzMg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf6QD6eV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b38f2e95aeso2456082a91.0;
        Sun, 05 May 2024 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714936322; x=1715541122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TOYTiAT5mWSyqPS7L5ABSd2mSU5r1Jo96empFDcTVEI=;
        b=Pf6QD6eVXbbQzZkD92lh+3N3L2oA6rMWR9y8EbH6AP2BbDp2AOG4dFxqiSy7Bhfj2z
         AMu9y0wf8z2CFkBalR4SEEQuxbD8ckJvm2wDXXhIRL6qw6TrUbxw75XNP2OTIHh9YFv5
         0yKvl3fwEEJpT0xS8iVZpm7dTMKyG406Zr7a2GnOgUji3p/0Hp3rSjJs0wPKK/cW1CB5
         AcRL+xH/3XyCU3wgJu53tP6bRoNA1VmhH3TZEG9XtjTaiNbOLiw7VfQyDv+APv8BB2HF
         ILGVsOae6fPyM7KdrKhlC7oY5Otd9H6ex+mqLyKToL0k+BR4jivdyzxQ3UPMVjK9h3n8
         nwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714936322; x=1715541122;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TOYTiAT5mWSyqPS7L5ABSd2mSU5r1Jo96empFDcTVEI=;
        b=uPvv9Yv8w+qNSKrsVGGGxV/YXAKTpcG8wfftK8kidw/h4sIOIynGZXxGmRHcUELc/D
         w+hX4bMnXIepPId96f0ZZDvpnKEnscrdfhQOAbDFcGGw41SteGBrV1n0c0UTpWx6ma2F
         5JDOngcasO5eX2bb/6Uoz/ynSTTIMOVAR2/FVfm6HzpL5WPWLk2/4d1Si2ug441daXAc
         EYTOVEJ3axKc7A/2oQwRmDX7uN9xCywficvUmj+SWDLlwyZTAwZytr8Z2vaYGmXZ07gC
         KcjnfkVpMnvweFhyNdeSqB4yJbDI0TO7gwWFXPMBZiSCNdjRrimMeo0uaNTB+Q4Xtt08
         h3OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrEzZhCo/kTGMCGWE5nY2/9/I5u+k14ib7r11ttL/NvE/p4s4QkBLb6rERUOQ8R+L7Axkp3oBkeQQOD7Sxf1i8LezhfXXB78tNv39Q
X-Gm-Message-State: AOJu0YyXb4B0NxEzV2d2nXUrMulIAfdVCdXKu+qCPwiWR67deLVnSiPT
	uPc8c5iAMsF+DSdlCe6VHI195o39bABjleZ8bv9YLOh4QKrXfjZd
X-Google-Smtp-Source: AGHT+IE6/hKTRUkrkxdYCnyvp9TWvhP34G0NKcW9Aqwogha04ODN5mY9As9LJ/yC1Xdl78a+TTV+lQ==
X-Received: by 2002:a17:90b:124b:b0:2b0:763b:370e with SMTP id gx11-20020a17090b124b00b002b0763b370emr16779507pjb.18.1714936321886;
        Sun, 05 May 2024 12:12:01 -0700 (PDT)
Received: from ?IPv6:::1? ([2600:8802:b00:ba1:e51d:20fc:9973:dfc6])
        by smtp.gmail.com with ESMTPSA id nc15-20020a17090b37cf00b002b115be650bsm8550880pjb.10.2024.05.05.12.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 12:12:00 -0700 (PDT)
Date: Sun, 05 May 2024 12:11:57 -0700
From: Florian Fainelli <f.fainelli@gmail.com>
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mor Nagli <mor.nagli@solid-run.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v3=5D_net=3A_dsa=3A_mv88e6xxx=3A_?=
 =?US-ASCII?Q?control_mdio_bus-id_truncation_for_long_paths?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240505-mv88e6xxx-truncate-busid-v3-1-e70d6ec2f3db@solid-run.com>
References: <20240505-mv88e6xxx-truncate-busid-v3-1-e70d6ec2f3db@solid-run.com>
Message-ID: <A40C71BD-A733-43D2-A563-FEB1322ECB5C@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 5 mai 2024 02:52:45 GMT-07:00, Josua Mayer <josua@solid-run=2Ecom> a =C3=
=A9crit=C2=A0:
>mv88e6xxx supports multiple mdio buses as children, e=2Eg=2E to model bot=
h
>internal and external phys=2E If the child buses mdio ids are truncated,
>they might collide with each other leading to an obscure error from
>kobject_add=2E
>
>The maximum length of bus id is currently defined as 61
>(MII_BUS_ID_SIZE)=2E Truncation can occur on platforms with long node
>names and multiple levels before the parent bus on which the dsa switch
>itself sits, e=2Eg=2E CN9130 [1]=2E
>
>Compare the return value of snprintf against maximum bus-id length to
>detect truncation=2E In that case write an incrementing marker to the end
>to avoid name collisions=2E
>This changes the problematic bus-ids mdio and mdio-external from [1]
>to [2]=2E
>
>Truncation at the beginning was considered as a workaround, however that
>is still subject to name collisions in sysfs where only the first
>characters differ=2E
>
>[1]
>[    8=2E324631] mv88e6085 f212a200=2Emdio-mii:04: switch 0x1760 detected=
: Marvell 88E6176, revision 1
>[    8=2E389516] mv88e6085 f212a200=2Emdio-mii:04: Truncated bus-id may c=
ollide=2E
>[    8=2E592367] mv88e6085 f212a200=2Emdio-mii:04: Truncated bus-id may c=
ollide=2E
>[    8=2E623593] sysfs: cannot create duplicate filename '/devices/platfo=
rm/cp0/cp0:config-space@f2000000/f212a200=2Emdio/mdio_bus/f212a200=2Emdio-m=
ii/f212a200=2Emdio-mii:04/mdio_bus/!cp0!config-space@f2000000!mdio@12a200!e=
thernet-switch@4!mdi'
>[    8=2E785480] kobject: kobject_add_internal failed for !cp0!config-spa=
ce@f2000000!mdio@12a200!ethernet-switch@4!mdi with -EEXIST, don't try to re=
gister things with the same name in the same directory=2E
>[    8=2E936514] libphy: mii_bus /cp0/config-space@f2000000/mdio@12a200/e=
thernet-switch@4/mdi failed to register
>[    8=2E946300] mdio_bus !cp0!config-space@f2000000!mdio@12a200!ethernet=
-switch@4!mdi: __mdiobus_register: -22
>[    8=2E956003] mv88e6085 f212a200=2Emdio-mii:04: Cannot register MDIO b=
us (-22)
>[    8=2E965329] mv88e6085: probe of f212a200=2Emdio-mii:04 failed with e=
rror -22
>
>[2]
>/devices/platform/cp0/cp0:config-space@f2000000/f212a200=2Emdio/mdio_bus/=
f212a200=2Emdio-mii/f212a200=2Emdio-mii:04/mdio_bus/!cp0!config-space@f2000=
000!mdio@12a200!ethernet-switch=2E=2E=2E!-0
>/devices/platform/cp0/cp0:config-space@f2000000/f212a200=2Emdio/mdio_bus/=
f212a200=2Emdio-mii/f212a200=2Emdio-mii:04/mdio_bus/!cp0!config-space@f2000=
000!mdio@12a200!ethernet-switch=2E=2E=2E!-1
>
>Signed-off-by: Josua Mayer <josua@solid-run=2Ecom>
>---

The idea and implementation is reasonable but this could affect other driv=
ers than mv88e6xxx, why not move that logic to mdiobus_register() and track=
ing the truncation index globally within the MDIO bus layer?

If we prefer a driver based solution, the mii_bus object could carry a tru=
ncation format, at the risk of creating more variation between drivers in c=
ase of truncation=2E We could also wait until we have another driver requir=
ing a similar solution before promoting this to a wider range=2E


Florian

