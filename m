Return-Path: <netdev+bounces-95901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E28C3D25
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082211F220CA
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9945D1474D8;
	Mon, 13 May 2024 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXJz6/UC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E71474B4;
	Mon, 13 May 2024 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588939; cv=none; b=AJ2SulBQeJCjyDl3FvjdDUVG80jvtyYrQoYnS3EF6VqDEXFymxH3Nd0DOBRyUhwJ0mggK8o4uBjb4vUBZ6N2EC7nPc7UGvrgElLQVI7L329bwi/b4oFwCIrpg28NMU+EOZlmsSgRWQC50HAngZGWYlb96/zhMiNgDiTOemmG20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588939; c=relaxed/simple;
	bh=1l1gBuhAghDzGTpmKFRmMZDa6k+2TjMJBTuOI8PxFZE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dtUGb6iGhk+tX5oJZzwotMy6FGi+A5L8VMPEfULLNT6r5iXwmT2KSojNPUlLfpyXQ8Bsd+8frrpUSBp7oxLMtdkLAP30RqnXsU1AgAXXDc2tCiroB9l0x37MNZHnPSXIG3yIO9/Vl9AVLpyWTW0bqtzkHCZuhpzNuhf9dlG2TyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXJz6/UC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1eeabda8590so28650975ad.0;
        Mon, 13 May 2024 01:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715588937; x=1716193737; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1l1gBuhAghDzGTpmKFRmMZDa6k+2TjMJBTuOI8PxFZE=;
        b=NXJz6/UCsHfN69FkJrnXVRpR2hjmYOuQw1c86t8EYPFel9wSfFloPc9DenfrKL2o/B
         JPDVxwR1hjHhFIjYtPCFb4NAg1Gza7roAAdykQiQpJxLuSFog2ahRjFnGSsx9fYl/ylX
         tvyPv8S8hBW2D1FK/vxeGXwDHW98aJt+W2PqfhiOLv9EcrpwGsOHQODDjcd2RH5sMHr/
         1Hujs00I6QpGpKx0r6YAvibSlVmaRth/07l32zE/gPbJXwTGG50JG1ezpWf/aK/zCYMV
         8C2fIBRv2Zpqox2n9i16poAyhYayivhG+hi+1S2zmu2t0c1UREZxF5bLoEAVes8AKY22
         ll5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715588937; x=1716193737;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1l1gBuhAghDzGTpmKFRmMZDa6k+2TjMJBTuOI8PxFZE=;
        b=VhY6afu/lfmORJPQ/24qNchvAIxuwh8fLjKhOrumR9zT3z6eMpah1ezMWumTIlXp6t
         K8JyGorqNW1uaj5oM/IAwNsxl0DEzuat5qSBiz9KZsO+o4QXiR3tX6bKbcWeGMJ0K6qE
         oRS+mUo7gtyD/lcCD+p/x4e4vtm/6tXlV3FuGM7NkE6x/NOujsjuspqudvHfdgm98Py6
         5CQHDG6K5zSjwfwedcd2Lp+PGj3LN/XgwC/jPwQfNpPo6EJ82u6X67aQyIlX6M6njaJD
         zN8e1JV0X45l8iYcOoIYTGqIPjqAeTY9StYa2cImfSEKYYe2HPPQpv6dVQbO/EnAndzA
         B2Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUs++Q5J8Uzh5R1ma4NCyp3X0Ws5fbpg6hQBXCb4l1fcd1QOVIGw51intTRsuJQtsOfIutDoG67gDq/3jnBOcFMRwZcKFL2
X-Gm-Message-State: AOJu0YxCfzT5SDN+zysiz1SGulVZ2j7g3Rv9tv/7Jh1gF3zM5BDslMuK
	ohm8I/9/HITb30YLDOR88CNUxrJEJNOxWDR8mP/H7Vq8/3LPvuZT
X-Google-Smtp-Source: AGHT+IEyFi9OkHesvUDKD8WJBIa2kU2vFMcbgW2nT+sM0xKfUBCZ7S9sE6dvQzu9KaR545YjlGNXYw==
X-Received: by 2002:a17:902:da8c:b0:1eb:4a72:f468 with SMTP id d9443c01a7336-1ef4416113fmr111274895ad.52.1715588937322;
        Mon, 13 May 2024 01:28:57 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1807sm73594535ad.59.2024.05.13.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 01:28:56 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 26731184762DF; Mon, 13 May 2024 15:28:52 +0700 (WIB)
Date: Mon, 13 May 2024 15:28:52 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Networking <netdev@vger.kernel.org>,
	intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	lukas.probsthain@googlemail.com
Subject: pi
Message-ID: <ZkHPRBLlHJpRytIB@archie.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MqJ187FVOnOf64oY"
Content-Disposition: inline


--MqJ187FVOnOf64oY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

<lukas.probsthain@googlemail.com> reported on Bugzilla
(https://bugzilla.kernel.org/show_bug.cgi?id=3D218826) regression on his Th=
inkpad
T480 with Intel I219-LM:

> After updating from kernel version 6.1.90 to 6.6.30, the e1000e driver ex=
hibits a regression on a Lenovo Thinkpad T480 with an Intel I219-LM Etherne=
t controller. The system experiences a freeze when an Ethernet cable is plu=
gged in. The issue is not present in the previous kernel version 6.1.90.
>=20
> System Information:
> - Model: Lenovo Thinkpad T480
> - BIOS Version: N24ET76W (1.51) dated 02/27/2024
> - Ethernet Controller: Intel Corporation Ethernet Connection (4) I219-LM =
(rev 21)
> - Kernel Module in Use: e1000e
> - Operating System: Manjaro Linux, kernel version 6.6.30-1
>=20
> Steps to Reproduce:
> 1. Boot system with kernel version 6.6.30.
> 2. Connect the Ethernet cable to the laptop.
> 3. Observe that the system freezes.
>=20
> Expected Behavior:
> The system should remain stable and maintain network connectivity without=
 freezing when the Ethernet cable is connected.
>=20
> Actual Behavior:
> The system freezes immediately upon plugging in the Ethernet cable.
>=20
> Additional Information:
> The regression seems to be introduced in one of the updates between kerne=
l versions 6.1.90 and 6.6.30. The issue does not occur with the older kerne=
l version 6.1.90.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--MqJ187FVOnOf64oY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkHPOgAKCRD2uYlJVVFO
o5k0AQCvBu6nHDzpTwo8OJz3jjdqc5D6AsxCg7E3p+QX6zJ72AEA1/QI1liupwSO
V+b6OxS6Ih+R0okARxUMwGuT3svVQw8=
=hyi0
-----END PGP SIGNATURE-----

--MqJ187FVOnOf64oY--

