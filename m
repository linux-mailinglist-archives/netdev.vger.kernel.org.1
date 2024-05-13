Return-Path: <netdev+bounces-95921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FB08C3D74
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B859FB209DF
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C19147C91;
	Mon, 13 May 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Syxg9neN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9FB147C7F;
	Mon, 13 May 2024 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589775; cv=none; b=iMRatYZY/Q6mmz0mRaRbHHJvsMrgnPlAz3/Aa55298uDuTAD6z9vMozjz00uiBcXgHRrt7mZEctLgyOTn29M1B4i16Bk5lbKaTLk2Qp1O8Mh3Ob/aR6tOJBgWU4E4Lj6GYblakla9t60Gxv2lxYI6LAzfbInIsmDcOZobKteH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589775; c=relaxed/simple;
	bh=y7lPqf6Kbd8pfKb7R0gWDlNSm18f/VWp7Do2LxaEh3w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h5e3AKyGl3a0ECVAMz3sv3vk7mohDnmRiPg7FI5I+bC7lZIMdvurdkJSPkMf7NMPL3pVPv47IZcL4f31KoM12Y2gLfq2JsRHFBsW+KcLRiE9H3cs9+RabjQSci5l8GoPVEWUwOrQjrfxWxxOLQOJ3a88vGK09H5e3yFpVcHIQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Syxg9neN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso30530475ad.0;
        Mon, 13 May 2024 01:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715589774; x=1716194574; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7lPqf6Kbd8pfKb7R0gWDlNSm18f/VWp7Do2LxaEh3w=;
        b=Syxg9neNdLuft7fTZdu9MhWAWgirpHfemMYhZaber6dr6kfUuoZUd7W2FWBZyO1xxX
         f1TAiHc3cNSRDtqFneqYdsIfisWW2vnT2nv4hLWPOW0m3Uwa+eDMYchBtTcr4NB9fzW9
         HQJHjBD0nzJAEcd6Ca6+Kfn3UX3Kqgj7XUExfsQG1o8jcCiovp5C2/x8flkjCdRNnlyj
         Osw1o3gukIBcYI1SYdf1dIsVTxJ3bAoCKbZ7j4Z/RLZNhpaTSkZxR9D22+GodM8VLJDS
         JYG7PMI6oKH+rscTycPXXC8NV42sofTrHjX1aeP2A1+P0lXrbe6j88r+1IPwJ9+JDvj3
         HDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715589774; x=1716194574;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7lPqf6Kbd8pfKb7R0gWDlNSm18f/VWp7Do2LxaEh3w=;
        b=pnE/ti4yMYa8bAE2oSzaqwpo/EkDWEGzI60Hyn74MJvDxCpe0okXYxsjlxsdsW2M3f
         26bJqQJgq+jTiUCovb42XOklWFWun59rddpn7B5jdGcYcDrs9cU1AI984d7SZJryCvOB
         b8+gfBVaVVRqio4D2YbO2GwkgyLHjFc5BMfBZyV45YwlB4lzzPoMBvfEMq3zseDUMMEF
         E5JGdgciteH4NBeoP2m6ZPeuy0clleJe5WF9aEHqvrVrn2SxR6MbcD35aqXjw+w+25zb
         HxYb8yQ1wd9BIoQSyE/kVIsLSXvkdtkjHn2VhEeFS3W2e37u1hghjO4SthtzXb7SAsUP
         Vcsg==
X-Forwarded-Encrypted: i=1; AJvYcCU+9M9aD8/8yWTAioR0BJsaQtYYMxVcW3B2zfq9anTREunaL+p42o6Ep4/1FRieciOL5KhMXQeQw0tMCwp0eWCeKNXzvYqo
X-Gm-Message-State: AOJu0YyZzrF9fRJeN8Ql/FGJ3m8Zob6+jbRLdK847cuAEq+ijyT15JaO
	NFgGs61uj8oisqaBCjmmAgyPDBbN8lhGCuaTJZf9pXY5pAd39ugg
X-Google-Smtp-Source: AGHT+IG75rkNOpcpo5GhLpsIDduIrQUEWF6yC924gDigs5v7pfDFIFCXraNZ7Di0/yOikq6t4XIz3Q==
X-Received: by 2002:a17:903:1251:b0:1eb:5344:6a01 with SMTP id d9443c01a7336-1ef4404a25bmr103311395ad.44.1715589773717;
        Mon, 13 May 2024 01:42:53 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a32sm75607045ad.123.2024.05.13.01.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 01:42:53 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id EB5A2181C8FA4; Mon, 13 May 2024 15:42:50 +0700 (WIB)
Date: Mon, 13 May 2024 15:42:50 +0700
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
Subject: Regression of e1000e (I219-LM) from 6.1.90 to 6.6.30
Message-ID: <ZkHSipExKpQC8bWJ@archie.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ae47ss+eiIbn41c"
Content-Disposition: inline


--2ae47ss+eiIbn41c
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

--2ae47ss+eiIbn41c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkHSigAKCRD2uYlJVVFO
o0Z/AQCIkJz7plid8wPPU7db5xKtA7Ftq60HC/uJ7718jfmBkgEAtvtduKsDn2CB
sliUh8IN6Cx7oNQTIYq+Il73paLXMAk=
=lNxt
-----END PGP SIGNATURE-----

--2ae47ss+eiIbn41c--

