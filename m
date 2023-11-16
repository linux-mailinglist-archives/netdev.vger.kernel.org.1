Return-Path: <netdev+bounces-48281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB27EDEE8
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B9D280F56
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 10:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356312D04E;
	Thu, 16 Nov 2023 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbhSAl7h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3021AE;
	Thu, 16 Nov 2023 02:53:18 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c184b3bbc4so498512a12.1;
        Thu, 16 Nov 2023 02:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700131997; x=1700736797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6wLYSXzg5tmYqidzmV/DNDn2+dFtQpnSIBReQdUv9g=;
        b=PbhSAl7hch40DGTORDWg9KAdz/piYCL8XZRCIdxK0N+pRQRDjZBHB0ZW6z5V1D8/58
         CR1zJKqCN063BFQRXpHXCxFISK7i9k4H9ZK/eq/ZWWjRUqeVR9LLU2qnzKoVyH3n0Ru/
         jWRRzphJhtXtmzhOLCdvfGN/JsXucF8K5UH7bX83X1PDm7pnlNqUjyszfDA4QRSbI7dm
         +kKit5yVZpqFpD33K/ZMItnt2j/24DitPjfr458j2wc4Zxg3wrkPRE9HHLbXm+6qMqJR
         aC3m/NGqof/aHgfrvhPnYX1KAdvXGjxgSF4T75DwMo9LsRlSPXFHrwSfclapLAe5jp6k
         oO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131997; x=1700736797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6wLYSXzg5tmYqidzmV/DNDn2+dFtQpnSIBReQdUv9g=;
        b=ozaxevbCiLoCyyEFgsXZwcbZU86YRKJUv9HebqXb0eADRu4frYH+h8wPccWuLj/uIR
         6KqAoRQ2J6gMXDb23BGd8EWx2a4Q3Qn4Leyz8eOf/ny6+KyDfPhGXAfL6w/aWl8tY3YD
         Ps3NYZiU5R+K3ONYaeuSlWl79NLPEKC+356PAZ+uOB9mmnWpts4Iz9ki+9wyZyENMyFa
         YM6frpwQTex3cQs809h1pUBbkpf1ItqYTzZl+I7nvcPSxNJYYzy/yHZZiylw/+kbhFJb
         T4uqN3cT4UE0AsZeKddQrGoqVDcombvshPxGmuvNbaQERQcquehxCfpfceISVWnZXCSQ
         7QGA==
X-Gm-Message-State: AOJu0YwIGBICnsZlab+ltfXGw0RRVj5PVjd0WUV1oMcl4PuVvIGZk58w
	Xb+4e11HFm+EeJR5hfCcIrA=
X-Google-Smtp-Source: AGHT+IHviUA6wsN7WBJ0vdUlc5oRn54uPX/2SL1zM7nRFKveJPLaxBH16YaTE8jA32XcURweaSCFnA==
X-Received: by 2002:a17:90b:1810:b0:280:2652:d42 with SMTP id lw16-20020a17090b181000b0028026520d42mr17763037pjb.23.1700131997392;
        Thu, 16 Nov 2023 02:53:17 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090a560600b0026b3f76a063sm1300560pjf.44.2023.11.16.02.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:53:16 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 9876410206E62; Thu, 16 Nov 2023 17:53:11 +0700 (WIB)
Date: Thu, 16 Nov 2023 17:53:11 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Anil Choudhary <anilchabba@gmail.com>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Andy Gospodarek <andy@greyhouse.net>,
	Ivan Vecera <ivecera@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: sr-iov related bonding regression (two regressions in one report)
Message-ID: <ZVX0l0pTgbe0LKp7@archie.me>
References: <986716ed-f898-4a02-a8f6-94f85b355a05@gmail.com>
 <32716.1700009673@famine>
 <0f97acf9-012d-4bb2-a766-0c2737e32b2c@leemhuis.info>
 <CC024511-980A-4508-8ABF-659A04367C2B@gmail.com>
 <7AC9E8F6-B229-47AA-84CE-1149F45D7E0F@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e1HJro3cB6s4ipwc"
Content-Disposition: inline
In-Reply-To: <7AC9E8F6-B229-47AA-84CE-1149F45D7E0F@gmail.com>


--e1HJro3cB6s4ipwc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 12:48:51PM -0800, Anil Choudhary wrote:
> We are getting errorError subscribing to SWID 0x0000.
>  from following code
> root@us-ash-r1-c2-m1:~/linux# grep -rn -e "subscribing to " .
> grep: ./debian/linux-image/lib/modules/6.6.1-vdx/kernel/drivers/net/ether=
net/intel/ice/ice.ko: binary file matches
> ./samples/connector/ucon.c:149: ulog("subscribing to %u.%u\n", CN_TEST_ID=
X, CN_TEST_VAL);
> ./Documentation/driver-api/media/v4l2-event.rst:117:add      called when =
a new listener gets added (subscribing to the same
> ./Documentation/driver-api/media/v4l2-event.rst:130:Unsubscribing to an e=
vent is via:
> ./Documentation/maintainer/feature-and-driver-maintainers.rst:44:mailing =
list. Either by subscribing to the whole list or using more
> grep: ./drivers/net/ethernet/intel/ice/ice_lag.o: binary file matches
> grep: ./drivers/net/ethernet/intel/ice/ice.o: binary file matches
> grep: ./drivers/net/ethernet/intel/ice/ice.ko: binary file matches
> ./drivers/net/ethernet/intel/ice/ice_lag.c:1007:                dev_err(i=
ce_pf_to_dev(local_lag->pf), "Error subscribing to SWID 0x%04X\n",
> root@us-ash-r1-c2-m1:~/linux#
>=20

Again, please don't top-post; reply inline with appropriate context instead.
You may need to configure your email client to start reply below the quoted
context.

OK, now on your Bugzilla ticket, please attach the full log (either from
dmesg or from journalctl). And don't forget to perform bisection if
you'd like to get this regression fixed.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--e1HJro3cB6s4ipwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVX0kwAKCRD2uYlJVVFO
o7fjAQC0MeTuZpur/LspKJ2Mx7S+c45gX313sk1uD4kt7ANNVwEA/ivKY/8tlYLK
LIZuHFWvA3qMyHT4vgtG8fcqbuN8igc=
=O+Fn
-----END PGP SIGNATURE-----

--e1HJro3cB6s4ipwc--

