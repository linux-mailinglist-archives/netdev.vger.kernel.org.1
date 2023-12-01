Return-Path: <netdev+bounces-53084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAEB8013BC
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 20:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF1E1C209F8
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0E442075;
	Fri,  1 Dec 2023 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARU2lAdf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D23D5103D;
	Fri,  1 Dec 2023 19:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A77FC433C8;
	Fri,  1 Dec 2023 19:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701460380;
	bh=1r7+t0m4Avt8XEaHtW05l7pP2NHmDtRMRV7Gko184Sw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ARU2lAdfLBWGwgQ+JSxDVBFGeK7bX8VGIf1IYMUbMdZBNw5p9N2B1jNnEB5RQJvVN
	 6UAruqFfZ0BNKqRkl6p3E4yaE7rMbqYbmi/0MrXSMB+Lm1ROH4YExlHn1tEkDVh+l1
	 8lEJAGLKllZTTCtLLzh6XCbsud6Xwl9WOnNQSoq/SrFAELDyom9VMT0D/HAWesEalz
	 yo9wxH8upZTahjnoXc9svONjiQH9fsgYR/DJ5p7ajJt9VgvUy5rhqpxraFkWpS3qP6
	 rxLV3zz1dXHkdKwMS38dximSAGwZhLlm+EhcjErvzdHs6nm0smbQgPLbIxlOy3qEfw
	 /Su4u5dOlq/zQ==
Date: Fri, 1 Dec 2023 11:52:59 -0800
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
Message-ID: <20231201115259.37821ed5@kernel.org>
In-Reply-To: <CH3PR11MB84146024E32844E0931039ACE381A@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20231123105243.7992-1-michal.michalik@intel.com>
	<20231123105243.7992-3-michal.michalik@intel.com>
	<20231129093951.3be1bd8b@kernel.org>
	<CH3PR11MB84143BBDDE886E6479146365E382A@CH3PR11MB8414.namprd11.prod.outlook.com>
	<20231130225127.1b56ffca@kernel.org>
	<CH3PR11MB84146024E32844E0931039ACE381A@CH3PR11MB8414.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Dec 2023 18:33:11 +0000 Michalik, Michal wrote:
> That looks really promising - great idea. I tried only vmtest today, and my tests
> work kind of flawless with my own built kernel (nested VMs):
>   $ vmtest -k /home/net-next/vmlinux "modprobe netdevsim && KSRC=/home/net-next/ pytest"
>   => vmlinux
>   ===> Booting
>   ===> Setting up VM
>   ===> Running command  
>   ============================= test session starts ==============================
>   platform linux -- Python 3.9.16, pytest-7.4.3, pluggy-1.3.0
>   rootdir: /home/net-next/tools/testing/selftests/drivers/net/netdevsim/dpll
>   collected 91 items  
> 
>   test_dpll.py ........................................................... [ 64%]
>   ................................                                         [100%]
> 
>   ============================= 91 passed in 10.54s ==============================
> 
> I will try to take a look at virtme-ng next week, but to be frank I already like
> the vmtest.

Hm, FWIW I manged to get virtme-ng to work (I was pointing it at a
vmlinux not bzImage which it expects). But vmtest is still unhappy.

$ vmtest -k build/vmlinux "echo Running!"
=> vmlinux
===> Booting
Failed to connect QGA

Caused by:
    Timed out waiting for QGA connection


Are you on Ubuntu? I'm on Fedora. Maybe it has some distro deps :(

> >> To be honest I did not see that. I agree that this is a simpler solution, but I am
> >> not sure if that is not "too simple". What I mean, I'm not sure who wrote the sdsi
> >> tests, but maybe they were not aware about the Python best practices? Python used
> >> to be my first language, and I would vote for using the venvs if you asked me.
> >> I understand that it haven't been done before, but we are here to try to improve
> >> the things, yes?   
> > 
> > I think I already asked how long the setup takes but my only concern 
> > is that the setup will be slower, and less useful during development.
> 
> I wanted for "run_dpll_test.sh" to be userfriendly even for people who does not
> have a clue how python/pytest works. If somebody is developing tests, I assume
> he/she knows what she is doing and is using own environment either way, like
> venvs with additional Python debug tools and direct pytest in tests directory:
>   KSRC=<KERNEL SRC> pytest

Fair point.

> I don't feel like it is slowing anybody down. But since vmtest looks promising,
> maybe I can prepare a reverse logic. What I mean is I will prepare script which
> helps prepare the environment, but the default will be to use "locally installed
> stuff" when people just run "make -C tools/testing/selftests".

Let's keep it as is. 10sec for automated run is fine.

