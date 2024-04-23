Return-Path: <netdev+bounces-90529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC14D8AE662
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AFE28545B
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04FD1353E3;
	Tue, 23 Apr 2024 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6jaeHtW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BAB1353E1;
	Tue, 23 Apr 2024 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875828; cv=none; b=hWKcAD8ONoDM113YIUvqu4t0wjmrtoPPcnwkYVLG8pA3bv6ZJuZcj6V08gLC1auxNOCx7hKR/hwbaetHHEfCtEmsui7NbM4Si41kGpFt21VZid+gU81ESPggwYCzkd9NN3h3cVl7Q8t1wLAOrHTp9z7cbZqCPWV4iSh/T4MZtIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875828; c=relaxed/simple;
	bh=GKf7GB42N/M22FE24I9G9cXx4qfHe6pDszUBNx2HFPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anWtXENdIZXSlwzOP7NFVioALbaIKCw7pilq46rUORTRxdOnf/gQFYYVfepEiphgjBlo+8PHgPDQfurMxJEG7cYuSGZAwuAdYWv/Wtr81ZI1pi+79dhcV9rLJQFlccfXn0MpxsWO8CH1IxfdPSg+YmATh2Vwb6DH7hJVuNxAdEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6jaeHtW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so4476204a12.1;
        Tue, 23 Apr 2024 05:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713875826; x=1714480626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DKsDgka1mGmOjEP5saIwH7c9QjBuan+UM9jRHCb6sA=;
        b=U6jaeHtW/Oj+gtpjAIKpiz62DKwUkNfkzMKrUjANnMtbes2osYOlCWJU/7CRDbvZd9
         dPCyOS1X6/tFYl+OTTNMnHQybN8N0ds8lfwSrRkXyeF3LerzmU7eifCkU4gIq72Cr4lK
         tq0RG3H8KF0CaR4cimY4JaHbCO+RJKUVgaXCbOx5d3yj0o8U3VVEGHNTCcCeCtVazHGS
         4iw4pLFJ/zKFyr2nC0m/pGudm9rY1+HX7nsPoRb46hhPhdF2+wfAu7JBlwy1j57UPYi0
         up7rl0abBIATHXDMirZXlggNVmg9WiSHXxh7rgoBnLRNh42oBnD+hUYRulEePq40Oo7W
         FzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713875826; x=1714480626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DKsDgka1mGmOjEP5saIwH7c9QjBuan+UM9jRHCb6sA=;
        b=MRA5fbeDapf9l1KowOKAhSHZLe3Dp5HV8RNLDv+CfnTR5O3twrsRF0nE/yLrGFM/9P
         1LHDZWlM1y5mDM25vIl5gGuLpGvbqULo/G0re23FNQ0KZRBYAr4gNZJKEI4UoL1uzgSn
         0R5qBnzSh9xKu3Im9n/aO5xhgzVsD1YmCVovoaT3P5idUv3o2sRDOtLu5RJiGKbyOkMU
         JTFskvbLJsCSktz7wvqzaPi+6M+F0G7VnGuk505E9Wwrb5rnUniHujrzKMbcdPxp4zTw
         t5AACMGzD5fuY1OxDBfNIk0qG983xwATtDc1M8Men412pyhaz6VI4c2fBwvx58J/CSIW
         GZLw==
X-Forwarded-Encrypted: i=1; AJvYcCWWyWQI/cnT8LJy+i4YrGwNz1Lq9kvF6wkguQ5dtjWRvv12wZg4BjTRjdoPr8vA2bDOULRHJZD71d7ITZaIUKYFfMSsgSDROFBqYVytkyjUEPPiluCjlGk0b1j9FNHndIyc
X-Gm-Message-State: AOJu0YzaKakqCpONj7UWtTkYOBIIhbQASZ/Xjl2bpKiulXGrNxS80vlV
	gapTBirhu3XqXUMhDOzkKTy5bZGpZzPuIc197M4ypDl7RB6F516e
X-Google-Smtp-Source: AGHT+IEXxdN5DFL0vR+NPrWnJmasenXQi+V7Y1DwI7M1l24vGCsmjhbTQYobD9iWUvZCbUFkkoo/jQ==
X-Received: by 2002:a17:90a:1657:b0:2a2:7494:15df with SMTP id x23-20020a17090a165700b002a2749415dfmr3491088pje.9.1713875826323;
        Tue, 23 Apr 2024 05:37:06 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a3d0800b002a2a3aebb38sm10193529pjc.48.2024.04.23.05.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:37:05 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 662571807D56B; Tue, 23 Apr 2024 19:37:02 +0700 (WIB)
Date: Tue, 23 Apr 2024 19:37:01 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Wilczynski <michal.wilczynski@intel.com>, corbet@lwn.net,
	linux-doc@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH net-next 6/6] ice: Document tx_scheduling_layers parameter
Message-ID: <ZierbWCemdgRNIuc@archie.me>
References: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
 <20240422203913.225151-7-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ero6mLgMf00ayC8g"
Content-Disposition: inline
In-Reply-To: <20240422203913.225151-7-anthony.l.nguyen@intel.com>


--Ero6mLgMf00ayC8g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 01:39:11PM -0700, Tony Nguyen wrote:
> +       The default 9-layer tree topology was deemed best for most worklo=
ads,
> +       as it gives an optimal ratio of performance to configurability. H=
owever,
> +       for some specific cases, this 9-layer topology might not be desir=
ed.
> +       One example would be sending traffic to queues that are not a mul=
tiple
> +       of 8. Because the maximum radix is limited to 8 in 9-layer topolo=
gy,
> +       the 9th queue has a different parent than the rest, and it's given
> +       more bandwidth credits. This causes a problem when the system is
> +       sending traffic to 9 queues:
> +
> +       | tx_queue_0_packets: 24163396
> +       | tx_queue_1_packets: 24164623
> +       | tx_queue_2_packets: 24163188
> +       | tx_queue_3_packets: 24163701
> +       | tx_queue_4_packets: 24163683
> +       | tx_queue_5_packets: 24164668
> +       | tx_queue_6_packets: 23327200
> +       | tx_queue_7_packets: 24163853
> +       | tx_queue_8_packets: 91101417 < Too much traffic is sent from 9th
> +
> <snipped>...
> +       To verify that value has been set:
> +       $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_laye=
rs
> =20

For consistency with other code blocks, format above as such:

---- >8 ----
diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/netwo=
rking/devlink/ice.rst
index 830c04354222f8..0039ca45782400 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -41,15 +41,17 @@ Parameters
        more bandwidth credits. This causes a problem when the system is
        sending traffic to 9 queues:
=20
-       | tx_queue_0_packets: 24163396
-       | tx_queue_1_packets: 24164623
-       | tx_queue_2_packets: 24163188
-       | tx_queue_3_packets: 24163701
-       | tx_queue_4_packets: 24163683
-       | tx_queue_5_packets: 24164668
-       | tx_queue_6_packets: 23327200
-       | tx_queue_7_packets: 24163853
-       | tx_queue_8_packets: 91101417 < Too much traffic is sent from 9th
+       .. code-block:: shell
+
+         tx_queue_0_packets: 24163396
+         tx_queue_1_packets: 24164623
+         tx_queue_2_packets: 24163188
+         tx_queue_3_packets: 24163701
+         tx_queue_4_packets: 24163683
+         tx_queue_5_packets: 24164668
+         tx_queue_6_packets: 23327200
+         tx_queue_7_packets: 24163853
+         tx_queue_8_packets: 91101417 < Too much traffic is sent from 9th
=20
        To address this need, you can switch to a 5-layer topology, which
        changes the maximum topology radix to 512. With this enhancement,
@@ -67,7 +69,10 @@ Parameters
        You must do PCI slot powercycle for the selected topology to take e=
ffect.
=20
        To verify that value has been set:
-       $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
+
+       .. code-block:: shell
+
+         $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_laye=
rs
=20
 Info versions
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Ero6mLgMf00ayC8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZierYwAKCRD2uYlJVVFO
o/3RAP4u04zxEqBpmQTnTbihVhFmK+Vhhj6UUlO1mULVDKCbMAEAy/RvPbBi4w6U
hXdwezW130UcTT54E3AlXG9Eh3EtaQo=
=8hMl
-----END PGP SIGNATURE-----

--Ero6mLgMf00ayC8g--

