Return-Path: <netdev+bounces-227096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA87BA837A
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 09:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D3BC7A64B1
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 07:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC3A2BE620;
	Mon, 29 Sep 2025 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHt33nzE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2F4503B
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759129924; cv=none; b=l+WbhepmyNfrnTiT93wWHv9+UO3eDZGvk9VSCGa3vnzYhDOeHDTEwzxk5MEStlOmFi0Vih1MQoALvq+1HBpuZaR11si84RwKY3CaJvrkmdbWTMsnmntVvX53KfF5Ywgzd755zEYt9lOycb2RbEi7vXFE2XrlhDl2JB6WIndMFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759129924; c=relaxed/simple;
	bh=q8NB4wFao6bhMFBAijyglBJMXgtUD5Pnm4AwYAn/4k0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRrzdvepBw8pFv87Ju4vUa45dghMyzOkj1AskHAoJLkPgiPapdPcDtoMW1cpovq4UQ8G+2q73ptJqVzpaCLT2iuxi06Grst0hdwCB5YhrN1sBit0+DdpYSbeX9w+4y6mGjDZYFT06/Mw3NCg+XA/DNVCQtHsV1EoFLsVmINTDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHt33nzE; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso2156429e87.3
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759129921; x=1759734721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wARMIVQSUJ/9n1GZEwptuSuz2LEs2xneOUnHQcOfbWc=;
        b=DHt33nzEwpQp/+Pz+Z03MkaDiiVARhH2hqNcW8H0kB0cER4ylwNeQY3rWcLKRnqTrK
         b5fry3r3HXj5YP1wTdakiqDVYBkHxVXrWWiOequaej92SmfVQI1OCDfvQgkQTsrayopE
         rVzus07p2FrtIH7Qp05M87bhJ++BfqxbYF8NnSdR1ekj3oX4M8yz92PvPl1NfEDk/DHl
         0HPVhdkIsstQE2PKtI6HuczLPvou3l1Eqns0/AUYlp3FU0+oDZNNUoYLA7mcMTYGj9rM
         QF01bqOJPrv6Ue5fNPj2BloQvagHagJrL4Kn/aCfWssUTZLvg+ncnlGFVndBqovUurRU
         vcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759129921; x=1759734721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wARMIVQSUJ/9n1GZEwptuSuz2LEs2xneOUnHQcOfbWc=;
        b=sEKpqUOie/Y2++HPzirRx/IJQ72tXIAyEWkgSWOVLqRNDzg5OCfBjT+0+Ih4nd3ohv
         nRHDLo0PUXWitS3PNtn6lW9xR7S2qw8zFh93rsTRg+B8KPkmzxXA3H0t6NhKmIFxHk8E
         sWVBHHZHuCD3tGkd7cwJXGCVtlMMqMPojm+VqCoCxO306lL7RbJ4hp4b71pzkxJPkgf7
         740fMZY3sMiSpbw9tZ8pC08vwG1lRDNTHYyow/1TNy+nAolr08kdbrclfqxqcC2uVlPe
         ly6enicUvkDekHxMywlVYrUAGuV6gagHfnrT1s/180oa4EsZOyv6+BHBYhI6bZyVU0Ou
         n8+g==
X-Forwarded-Encrypted: i=1; AJvYcCX2hXGcIiX0Q/2k0Vy5dGULOgwgD4PZ9O8jAZiRS0HUlDWz+FMT/kgKC4yV91ceeW/7QlICAqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEwRB3Smn+CMOmYXntfvyTz9h48vjCF0dgSv+M+hYAA9EnxOqE
	VwEQ9gN2XI6At2WCCnaPCG5JyxyHlzegl4xct29LvD8iGR11ZoKRi0wm
X-Gm-Gg: ASbGncv/DvjYlKrSlYRxsNCznWKDS569vkarhK0N34A40t0ev+r9Sk3dDl1xPj7jwun
	J6S/Khlc6L8g4XHSLDfs4HWC3K4x//0/rouFThhy9eDCqxvdwexi0RZs04CMHDK/vsasEopUEu2
	/HsOX1uWJMBRABHSPz+WBigoSdrsNhQmzAuyLtRvMFqpSnRHDYHGu/XmNwMdDTXtxcTOgF8FdlW
	ibTRJNhqADDztaNGrMokq/Lp1V0itTRMxRLCVniqS3VREQRPFAPPrmtFhBDsIhhxfxHxreCXm8B
	YGKL54+lDu9lywLX4+c8FaEx9aGobBdf2omH0etGGhAq6vFFXASr3axdhzwsdWkWgOLi5J6r2NF
	LqFBUTC/ih5JEguX+yWq5Xk8Oi2wYz4ZrxYIThA4=
X-Google-Smtp-Source: AGHT+IEmNoQYBqKvwN8TVtMwx5cZBA+Xia+RHNIkLRstLr/fYqrVO5WjO6K2jaX2MbAeLkgCdEYxRw==
X-Received: by 2002:a05:6512:2205:b0:576:e6ef:1817 with SMTP id 2adb3069b0e04-582d39b4fabmr4919813e87.41.1759129920583;
        Mon, 29 Sep 2025 00:12:00 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316a32113sm3972060e87.102.2025.09.29.00.11.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Sep 2025 00:12:00 -0700 (PDT)
Date: Mon, 29 Sep 2025 09:11:53 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: yicongsrfy@163.com
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, marcan@marcan.st, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, yicong@kylinos.cn
Subject: Re: [PATCH v2 2/3] net: usb: support quirks in usbnet
Message-ID: <20250929091153.4c769e44.michal.pecio@gmail.com>
In-Reply-To: <20250929053145.3113394-3-yicongsrfy@163.com>
References: <20250928212351.3b5828c2@kernel.org>
	<20250929053145.3113394-1-yicongsrfy@163.com>
	<20250929053145.3113394-3-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Sep 2025 13:31:44 +0800, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
>=20
> Some vendors' USB network interface controllers (NICs) may be compatible
> with multiple drivers.
>=20
> I consulted with relevant vendors. Taking the AX88179 chip as an example,
> NICs based on this chip may be used across various OS=E2=80=94for instanc=
e,
> cdc_ncm is used on macOS, while ax88179_178a.ko is the intended driver
> on Linux (despite a previous patch having disabled it).
> Therefore, the firmware must support multiple protocols.
>=20
> Currently, both cdc_ncm and ax88179_178a coexist in the Linux kernel.
> Supporting both drivers simultaneously leads to the following issues:
>=20
> 1. Inconsistent driver loading order during reboot stress testing:
>    The order in which drivers are loaded can vary across reboots,
>    potentially resulting in the unintended driver being loaded. For
>    example:
> [    4.239893] cdc_ncm 2-1:2.0: MAC-Address: c8:a3:62:ef:99:8e
> [    4.239897] cdc_ncm 2-1:2.0: setting rx_max =3D 16384
> [    4.240149] cdc_ncm 2-1:2.0: setting tx_max =3D 16384
> [    4.240583] cdc_ncm 2-1:2.0 usb0: register 'cdc_ncm' at usb-
> xxxxx:00-1, CDC NCM, c8:a3:62:ef:99:8e
> [    4.240627] usbcore: registered new interface driver cdc_ncm
> [    4.240908] usbcore: registered new interface driver ax88179_178a
>=20
> In this case, network connectivity functions, but the cdc_ncm driver is
> loaded instead of the expected ax88179_178a.
>=20
> 2. Similar issues during cable plug/unplug testing:
>    The same race condition can occur when reconnecting the USB device:
> [   79.879922] usb 4-1: new SuperSpeed USB device number 3 using xhci_hcd
> [   79.905168] usb 4-1: New USB device found, idVendor=3D0b95, idProduct=
=3D
> 1790, bcdDevice=3D 2.00
> [   79.905185] usb 4-1: New USB device strings: Mfr=3D1, Product=3D2,
> SerialNumber=3D3
> [   79.905191] usb 4-1: Product: AX88179B
> [   79.905198] usb 4-1: Manufacturer: ASIX
> [   79.905201] usb 4-1: SerialNumber: 00EF998E
> [   79.915215] ax88179_probe, bConfigurationValue:2
> [   79.952638] cdc_ncm 4-1:2.0: MAC-Address: c8:a3:62:ef:99:8e
> [   79.952654] cdc_ncm 4-1:2.0: setting rx_max =3D 16384
> [   79.952919] cdc_ncm 4-1:2.0: setting tx_max =3D 16384
> [   79.953598] cdc_ncm 4-1:2.0 eth0: register 'cdc_ncm' at usb-0000:04:
> 00.2-1, CDC NCM (NO ZLP), c8:a3:62:ef:99:8e
> [   79.954029] cdc_ncm 4-1:2.0 eth0: unregister 'cdc_ncm' usb-0000:04:
> 00.2-1, CDC NCM (NO ZLP)
>=20
> At this point, the network becomes unusable.
>=20
> To resolve these issues, introduce a *quirks* mechanism into the usbnet
> module. By adding chip-specific identification within the generic usbnet
> framework, we can skip the usbnet probe process for devices that require a
> dedicated driver.

And if the vendor driver is not available then the device won't work at
all, for a completely artificial reason. We have had such problems.

At the very least, this should check if CONFIG_AX88179 is enabled.

Regards,
Michal

