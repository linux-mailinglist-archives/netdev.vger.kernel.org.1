Return-Path: <netdev+bounces-197838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA732AD9FCD
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 23:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B7D16A63A
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 21:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BEA1E5219;
	Sat, 14 Jun 2025 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irf295p7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDA542A8C;
	Sat, 14 Jun 2025 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749934898; cv=none; b=I4tgh7+UeY0GGhwj/IfinUXV7JnmLbQ4+ITSORmjq2bpYwETcWLxwrAj4WhciJfLwTqVpqU5gMPWS5kcbP5f3ymcHBsUoxIkdfCGvHftqZfiqkc0h+IWh0wYkCHXwxT+o5mxMLWEbZs/thOO+/+11JjR30uyGLv0SUau5Eb2i3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749934898; c=relaxed/simple;
	bh=Oy6CdK35L5UqrWcqJg7mXl77gwCRN1At28m/lVEVQkk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dTGBv9Yk4XM0ZMAaaXzlknvFAR/tHiue5EqwsXMiVFsvbWgm8iW4AUCgD7/VYCIBrSjK5NJ6+/fWlZVWkALYRh91uiM1nNJkxexqmq0vH9/kcFx+jc9b6b2eSAnUXlL1PewnB3UlK3hdIgbTaQELW0FS6gzek/Hntu6e1gm5GKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irf295p7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so38824945e9.1;
        Sat, 14 Jun 2025 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749934895; x=1750539695; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fxIEE+c6pUB0N6FNYktz5IvAb1U4IAe4R41rT8THtZE=;
        b=irf295p7B2Q0vmA+DeECJ9F0jtGwFwuV99nVa+zWZ4ukU4Ju7QGlt2LW4jL9DrU6u8
         aS384JqRRlL+CscXJffHhMD3MlIQvVQUb8+wmi8m9yHj/v4NoU/eYxAnmNTGUwww1mIZ
         0FRrkqRd5JiuGQwFMSFx7fKGcKDssQRlx+13ul7qBmKcX9gQ9ZByp0VGFbzlxauYU+WW
         tE/pkFOf9jOQ2dt2MILaHkTsZ5XgHu/T3KZBXluv8ACiDA8gEIk0e+AVZXYkl1mGZhw1
         xEDgzR/WNhXRgrHruPLMPuoroNNCDr70WiNq0gJmPNFooXgK9iIZ9CNFHy80r1xUPOn5
         6O6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749934895; x=1750539695;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxIEE+c6pUB0N6FNYktz5IvAb1U4IAe4R41rT8THtZE=;
        b=p28ASO1yZe+Xc3nLnFz6PWySsqnxQBf0KjJmez9Q58wZ3aJma6CMpTSQC5hyUsEgub
         6lO596RmzsK83r1FlAXgzhhHaG1M43CHNDkxaAUEp+E+QFMWSbURShuxYwVrW11LCwbT
         stO4gLp7/dhhCRLYKyHTiPD0h+2YNtYU8UlJaUTwT+g8PP7HHOpqhe4hzXMeN7NEbAJv
         dgx7gxguzDjXMUjon587HS9ZSGP0YsLCIKdSWj6CQUHcEbMbKHBmtuLMS5akjnYLl/Mw
         qYtpmXGiNsE2ZK+Tncw0KArSCWTgcq180RjGzG52I/hSu11fZazH4ke6++W8/F8/r6jR
         Oo2A==
X-Forwarded-Encrypted: i=1; AJvYcCXDKy0FAPZL+dA189Od0GeKRdh0vOM0aKbaP+qvWHviX+FetWN1R+bGrAIqs+a9z2e6S6VDFli0vy+9AcAe@vger.kernel.org, AJvYcCXiemjqSA24x3TP3wqFrQHaDSAlleWrNS/6ZzqMUGHU+9aPlKZuNfsBcAFYA7AIlgiwWB2wKax8/3cP@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVGuCU89PQdHKgoIdkUF4NCwpY8sOsFqEelycJ796wJ3wJZrS
	6XCdQcKWn7auOlUMxdMqhzNB5tcYwn4st0jJekC4IqGgD1db/smp1FpA
X-Gm-Gg: ASbGncudz+yL+tfQzTg7VF5xv5c0TUDcZiQwkWjRoD8IZ4aVrD4+YzWLMDgZRBC20Lo
	gszGeAg1i/lgfohsPqSh9AgVn95DYeOisVvPg4t+TdGUEy8bSC+0NTyFzRl4l1XEuKn2zaTAJ2V
	UUsiiKYaq8EzC6oOdSZECjHEFW+qBnT02xtxT8w2tRxgYLB4tUg9YPX4K5aMnGiQDC8Mdd/xjlC
	qcwvcvSW9tNRmS/FThy1+p5XtXGqFJbBfpX3BiAd833CkMbO4zmtMglJqcdS1KqdHGkauaMjB2g
	VxgKf/UMTYKoL24tlloMhSrg2xDyxjPuBb5l1UBFw8/pt6kePgH+KAuYtScfK0Xx7RjbdYhp6Ta
	ieCTuzA==
X-Google-Smtp-Source: AGHT+IFczogrn/L57qlQe9UCB84Ov9Y9pOTc5rwLMmgD+dlRC+Fn7LKHG3fxgIt+gTTBlBv82V4M7w==
X-Received: by 2002:a05:600c:8b48:b0:442:e9eb:cba2 with SMTP id 5b1f17b1804b1-4533c9c107dmr43924655e9.0.1749934894673;
        Sat, 14 Jun 2025 14:01:34 -0700 (PDT)
Received: from giga-mm-7.home ([2a02:1210:8608:9200:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm92863175e9.4.2025.06.14.14.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 14:01:34 -0700 (PDT)
Message-ID: <7a4ceb2e0b75848c9400dc5a56007e6c46306cdc.camel@gmail.com>
Subject: Re: [PATCH net-next RFC 0/3] riscv: dts: sophgo: Add ethernet
 support for cv18xx
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen
 Wang	 <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,  Richard Cochran
 <richardcochran@gmail.com>, Yixun Lan <dlan@gentoo.org>, Thomas Bonnefille	
 <thomas.bonnefille@bootlin.com>, Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, 	linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Longbin Li	 <looong.bin@gmail.com>
Date: Sat, 14 Jun 2025 23:01:43 +0200
In-Reply-To: <20250611080709.1182183-1-inochiama@gmail.com>
References: <20250611080709.1182183-1-inochiama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks for the series Inochi!

On Wed, 2025-06-11 at 16:07 +0800, Inochi Amaoto wrote:
> Add device binding and dts for CV18XX series SoC, this dts change series
> require both the mdio patch [1] and the reset patch [2].
>=20
> [1] https://lore.kernel.org/all/20250611080228.1166090-1-inochiama@gmail.=
com
> [2] https://lore.kernel.org/all/20250611075321.1160973-1-inochiama@gmail.=
com
>=20
> Inochi Amaoto (3):
> =C2=A0 dt-bindings: net: Add support for Sophgo CV1800 dwmac
> =C2=A0 riscv: dts: sophgo: Add ethernet device for cv18xx
> =C2=A0 riscv: dts: sophgo: Add mdio multiplexer device for cv18xx

Taking into account, whatever MII variation is implemented in the SoC
is always internal (and only MDIO part is multiplexed), can we add
	phy-mode =3D "internal";
and
	phy-handle =3D <&internal_ephy>;
right into cv180x.dtsi?

Boards can then enable the corresponding nodes if they wire RJ45 connector,
but I see no way how they could vary the MII connection.

>=20
> =C2=A0.../bindings/net/sophgo,cv1800b-dwmac.yaml=C2=A0=C2=A0=C2=A0 | 113 =
++++++++++++++++++
> =C2=A0arch/riscv/boot/dts/sophgo/cv180x.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 70 +++++++++++
> =C2=A02 files changed, 183 insertions(+)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1=
800b-dwmac.yaml
>=20
>=20
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> prerequisite-patch-id: d5162144180458b11587ebd4ad24e5e3f62b0caf
> prerequisite-patch-id: 9e1992d2ec3c81fbcc463ff7397168fc2acbbf1b
> prerequisite-patch-id: ab3ca8c9cda888f429945fb0283145122975b734
> prerequisite-patch-id: bd94f8bd3d4ce4f3b153cbb36a3896c5dc143c17
> prerequisite-patch-id: 1b73196566058718471def62bc215d2f319513c3
> prerequisite-patch-id: 54157303203826ccf91e985458c4ae7bcdd9b2ba
> --
> 2.49.0

--=20
Alexander Sverdlin.

