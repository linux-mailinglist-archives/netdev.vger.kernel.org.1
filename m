Return-Path: <netdev+bounces-104786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7523590E612
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E3A1F254D9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF857CF3E;
	Wed, 19 Jun 2024 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/HvbnpD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7B79952
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786391; cv=none; b=LuefzdL/4R22bOYP2eoGsKdbnqITEK5GvJStbQdNZhE2N5gNuvw0oqn51yZUveUnBxCsIVPBw5kuH53MG9W4TkeZ63TXBUlCO56ewRyyQKVBRxGvArRYLRPHB3EXzRMbaIuzkBP+5UpleJVz/1bhtcq5WQhB3Dbw+aYE31FLLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786391; c=relaxed/simple;
	bh=V1cIYjrBdLW8KIv3ONgB+ng/1ZHEgJK6ZjzzRqbTnFo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Z44e3QUcIDD259wDAtZnfe7BCIzHZLDxTj5K2vGVrVfOrtQkDPR3hjgH8M635XhlZqms5shiLsh8QO18b2UuPEbXRVMRqUjWZ4Z329JRz11tmLxGMkMkyUvBxIVIz5e+k5wYuS0GOzbZMIkE2oMTzIqWDwyTdAlFJByIGNzxhds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/HvbnpD; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43fdb797ee2so30755041cf.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 01:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718786388; x=1719391188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZQbTDo+z2Hw2qiH8fazN8oLyUDrBMHU2DUGTSkxqnI=;
        b=c/HvbnpDvT4eG6VmSBwqMpCJ4BQfxLDc53qTuvnENOYtJtHkthDmIYcB9msbeMLGDf
         4AUWbgimO6R8OeUzec0Vhm+Y4jExZcmPnbzDe3MIP3/HJjLIYZ/Wsuhoxaqplsazdx5E
         4TpgODdcsg9dO4CZV9hDyJPaJh1tx7DETFvCXo2VGJ+//UmlV6eNDvQ03fNqQt+vAnRG
         7nI8bmzgn33CUbwjZxs19G7kxA7yV4uPOABPk/VLyn/jZPlTKwAwAP9PwBVkn44vWCT3
         Toeo3P2rbDYHrmt35ADsOmrjas/koVrrOJEn8GiyJ+uwmdYya80eqC0xYji4Dhkz25lH
         0c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718786388; x=1719391188;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IZQbTDo+z2Hw2qiH8fazN8oLyUDrBMHU2DUGTSkxqnI=;
        b=VDpkXUJEj5+g8W8oaF991/Q476PLgYfJIXn1D6euTO+ImXpyUFYDyUTSZyseCfv7FQ
         TYioJIJZ8Er6f4yTpq2iSPzUeMlEMn/iLtwuiddyB8HmZtyxbiFzpjOCFSpHoQqIPO2O
         1PEGG9NJrCHdGR6eS3A6x7N7StwBGQ79lG5M7HFeyX67egjfuWSumb2khqFrkV79/wNQ
         VlvUGINAQtBTO9zEZL7qsBxhbCm7MGWXRKj2bd+KRKruDjVkdQkkRbtmnE88FMEHv7lS
         Sku/+x2JUlr3u1WrSNydUsIxAamjBgxHycK1KCc9nXq3IZNn6KqBDeR78hCFS+J1Y1kr
         APrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/cuV97gmp+KxLlAr6JIl/jo9SD8FKHuX2fpa7Fy/dWztkaK32u0IgsnlcTIFPeJ25wgNEX3J5fHkYybD8BHOJotEojndM
X-Gm-Message-State: AOJu0Yz2RI0MLTOVti/YPOlunayxtLhN9Rj1IMDjeIsp3/ATspH3mBWn
	qnZgNW00U5qF96OACa6fCDRvQTeEoqCls6Jw7rqlfK35w7XGLuEY
X-Google-Smtp-Source: AGHT+IGPFimCy5tjSNnagV/wBzxVJQKY35P1TdpQseb3vn7zgqAdawN7L42BjxLcNHlJq/eWkEib5w==
X-Received: by 2002:ac8:59c4:0:b0:43e:3d64:8c1 with SMTP id d75a77b69052e-444a7a717b7mr27401401cf.55.1718786388329;
        Wed, 19 Jun 2024 01:39:48 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fcc404sm63249531cf.66.2024.06.19.01.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:39:47 -0700 (PDT)
Date: Wed, 19 Jun 2024 04:39:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Singhai, Anjali" <anjali.singhai@intel.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 "gal@nvidia.com" <gal@nvidia.com>, 
 "cratiu@nvidia.com" <cratiu@nvidia.com>, 
 "rrameshbabu@nvidia.com" <rrameshbabu@nvidia.com>, 
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "tariqt@nvidia.com" <tariqt@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, 
 "Acharya, Arun Kumar" <arun.kumar.acharya@intel.com>
Message-ID: <66729953651ba_2751bc294fa@willemb.c.googlers.com.notmuch>
In-Reply-To: <CO1PR11MB49939CBC31BC13472404094793CE2@CO1PR11MB4993.namprd11.prod.outlook.com>
References: <CO1PR11MB49939CBC31BC13472404094793CE2@CO1PR11MB4993.namprd11.prod.outlook.com>
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP connections
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Singhai, Anjali wrote:
> =

> In reference to this patch series
> https://lore.kernel.org/netdev/20240510030435.120935-1-kuba@kernel.org/=
#t
> =

> Thanks a lot  for the PSP crypto enabling patches in the kernel.
> Some points that we noticed that could use some enhancements/fixes
> =

> 1. Why do we need =C2=A0ndo_op set_config() at device level which is se=
tting only one version, instead the description above the psp_dev struct =
which had a mask for enabled versions at a=C2=A0 device level is better a=
nd device lets the stack know at psp_dev create time what all versions it=
 is capable of.  Later on, version is negotiated with the peer and set pe=
r session.
> Even the Mellanox driver does not implement this set_config ndo_op. =

> =C2=A0
> 2. Where is the association_index/handle returned to the stack to be us=
ed with the packet on TX by the driver and device? ( if an SADB is in use=
 on Tx side in the device), what we understand from Mellanox driver is, i=
ts not doing an SADB in TX in HW, but passing the key directly into the T=
x descriptor? Is that right, but other devices may not support this and w=
ill have an SADB on TX and this allowed as per PSP protocol. Of course on=
 RX there is no SADB for any device.
> In our device we have 2 options, =

>              1. Using SADB on TX and just passing SA_Index in the descr=
iptor (trade off between performance and memory. =

>               As  passing key in descriptor makes for a much larger TX =
descriptor which will have perf penalty.)
>              2. Passing key in the descriptor.
> =C2=A0             For us we need both these options, so please allow f=
or enhancements.
> =

> 3. About the PSP and UDP header addition, why is the driver doing it? I=
 guess it's because the SW equivalent for PSP support in the kernel does =
not exist and just an offload for the device. Again in this case the assu=
mption is either the driver does it or the device will do it.
> Hope that is irrelevant for the stack. In our case most likely it will =
be the device doing it.
> =

> 4. Why is the driver adding the PSP trailer? Hoping this is between the=
 driver and the device, in our case it's the device that will add the tra=
iler.

This does not adhere to the spec:

"An option must be provided that enables upper-level software to send pac=
kets that are
pre-formatted to include the headers required for PSP encapsulation. In t=
his case, the
NIC will modify the contents of the headers appropriately, apply
encryption/authentication, and add the PSP trailer to the packet."

https://raw.githubusercontent.com/google/psp/main/doc/PSP_Arch_Spec.pdf

 =C2=A0
> 5. Five way handshake, can this be optimized to 3 way?
> Here is what we think is happening right now at the IKE level interacti=
on for the two ends of the session, as PSP protocol does not define it bu=
t based on the implementation this is what we gathered.
>   Looks like its 5 way handshake that is happening with the session par=
tner.
>    For example two sides are called Tx session partner and RX session p=
artner, just because TX initiates the session creation, of course it's a =
full duplex session.
>              1. TX session partner sends over sideband tls channel to t=
he Rx session partner what all versions the TX can do based on caps learn=
t from the device driver.
>              2. The Rx session partner replies with what common version=
s it can do back to TX session partner based on dev caps it learnt from t=
he device.

In practice in reasonably homogeneous hyperscale environments, this
step can be skipped. To be in spec devices must support both 128b
and 256b AES-GCM (and nothing else). It is an organizational choice
which to deploy.

>              3. Tx session partner tells the driver to generate a spi a=
n session key for the rx side by specifying the version it wants to use f=
or this session. And then sends to Rx session partner the spi and session=
 key and version selected etc.
>              4. The Rx session partner at its end then talks to its dri=
ver to generate a spi an session key for the rx side by specifying the ve=
rsion sent from TX session partner. And then sends to Tx session partner =
the spi and session key and version selected etc. The RX session partner =
also programs the session key and spi it received from TX session partner=
 in HW in its Tx SADB (psp_assoc_add)
>             5. Tx session partner programs the received SPI and session=
 key in its HW in its Tx SADB (psp_assoc_add). When done it sends an ACK =
back to Rx session partner that the session is ready.
>  =

> Should this be optimized to a  3 way handshake to allow for faster sess=
ion setup? 1 and 3 and 2 and 4 could be combined in an intelligent way. A=
gain may be there is already an optimized way to do 3 way handshake here =
and the kernel-driver flow still looks the same.
> =

> Thanks
> Anjali
> =




