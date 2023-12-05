Return-Path: <netdev+bounces-53750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8D9804571
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 04:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1AD1F2134C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68206611E;
	Tue,  5 Dec 2023 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVuqFIzS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5EA59;
	Tue,  5 Dec 2023 03:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF645C433C7;
	Tue,  5 Dec 2023 03:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701745340;
	bh=rYAvLElhLrYlUkvues4bA4R1RictnO/yOcXpUYdYVks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fVuqFIzSjLzixcJ12Ryk9hSPWEFcz/y3xG0lSTzuYz7p4FSn8JRPW4YTFGdj8uS/4
	 BWs191SWvN43pThiFXIRwAGW25Kt7ofO8YwXS2vqX8uKiWws3G9qNQtOyIq76h2PM5
	 aJ/gvg1pBk6PwO3EN0qRyaTwuvsqXx3OXSUIshJ9sM/bxK7LXNmlgeINka8WQYTiuR
	 p9WL/1pgzHMcw49Y35C4UkE7+5hbqyH6v9tNIZQrW3GKk1ZDiuiiW0eaHrY02cyei3
	 /KoqcOSaLQ7bw9M6CmxcsWB5x7VUHlasTUP2AtTU4Vj93E4YUK3lf5u+uLhxQ/I15D
	 a1BnvFC4c7gxg==
Date: Mon, 4 Dec 2023 19:02:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Michalik, Michal" <michal.michalik@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "jonathan.lemon@gmail.com"
 <jonathan.lemon@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>, poros
 <poros@redhat.com>, "Olech, Milena" <milena.olech@intel.com>, mschmidt
 <mschmidt@redhat.com>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>
Subject: Re: [PATCH RFC net-next v4 2/2] selftests/dpll: add DPLL system
 integration selftests
Message-ID: <20231204190218.13d4e8cc@kernel.org>
In-Reply-To: <CH3PR11MB841424C185225EC7EB9DBE4DE386A@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20231123105243.7992-1-michal.michalik@intel.com>
	<20231123105243.7992-3-michal.michalik@intel.com>
	<20231129093951.3be1bd8b@kernel.org>
	<CH3PR11MB84143BBDDE886E6479146365E382A@CH3PR11MB8414.namprd11.prod.outlook.com>
	<20231130225127.1b56ffca@kernel.org>
	<CH3PR11MB84146024E32844E0931039ACE381A@CH3PR11MB8414.namprd11.prod.outlook.com>
	<20231201115259.37821ed5@kernel.org>
	<CH3PR11MB841424C185225EC7EB9DBE4DE386A@CH3PR11MB8414.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Dec 2023 12:44:44 +0000 Michalik, Michal wrote:
> > Hm, FWIW I manged to get virtme-ng to work (I was pointing it at a
> > vmlinux not bzImage which it expects). But vmtest is still unhappy.
> >=20
> > $ vmtest -k build/vmlinux "echo Running!" =20
> > =3D> vmlinux
> > =3D=3D=3D> Booting =20
> > Failed to connect QGA
> >=20
> > Caused by:
> >     Timed out waiting for QGA connection
> >  =20
>=20
> I have seen this before I got the proper qemu version, actually I
> compiled it from scratch:
>  $ qemu-system-x86_64 --version
>   QEMU emulator version 8.1.3
>=20
> Which version of qemu are you using?

7.2.6

Building Qemu from source won't work for me if the CI is supposed to
depend on it. I asked Daniel on GH, let's see what he says.

> Btw. I agree that logs for vmtest are not very helpful, the
> .vmtest.log file is basically empty for me every time.
>=20
> >=20
> > Are you on Ubuntu? I'm on Fedora. Maybe it has some distro deps :(
> >  =20
>=20
> I'm using Rocky, so kind of similar to Fedora.
>   $ cat /etc/rocky-release
>   Rocky Linux release 9.2 (Blue Onyx)
>=20
> Also, installed qemu-guest-agent and edk2-ovmf packages according to
> vmtest instructions. Have you installed those?

Yup, I have those.

> > Calling out to YNL, manipulating network namespaces, manipulating
> > netdevsim instances, etc - will be fairly common for a lot of networking
> > tests.
> >=20
> > There's already some code in tools/testing/selftests/bpf/test_offload.py
> > which is likely Python-incompetent cause I wrote it. But much like YNL
> > it'd be nice if it was available for new tests for reuse.
> >  =20
>=20
> I will familiarize myself with that - thanks for pointing that out.

To be clear - I'm not claiming that test_offload.py is beautiful=20
code :) Just that the problem of accessing shared code exists more
broadly.

> > Can we somehow "add to python's library search path" or some such? =20
>=20
> Yeah, we might consider using PYTHONPATH in this "new common lib place":
> https://docs.python.org/3/using/cmdline.html#envvar-PYTHONPATH

=F0=9F=91=8D=EF=B8=8F

