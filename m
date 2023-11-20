Return-Path: <netdev+bounces-49306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ED57F1992
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1821F2565F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD21DFE9;
	Mon, 20 Nov 2023 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahP+0DGA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396B1A5B9;
	Mon, 20 Nov 2023 17:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCC2C433C8;
	Mon, 20 Nov 2023 17:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700500597;
	bh=jw/RJ/xWZ1Od9+kY38sBvcmKbT0pOQI6jAiYg5L6Gwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahP+0DGA1nAJt7p+vgHJpU6UpjyVaqVjB5Zz9ZBLbjSLBcP9MvtS+7ZWslBAPhnkD
	 XpgP2dhKRtAmABl96o2ye3sDAIXgGnw2RVHqf2yOvfKIaTNrNwSifCSkUzexNhiHfs
	 Ejpz6TdbSSXYxS1s8L/nclrCAhmpeagz/n0jC/4sOVjpRQeWxFiUueRbyYFM1HsUvd
	 RxZMTIjp8QfhYfh87JGaAqrH307KnFw3xF+LwvTAB7M5AWO9D3Alm2sV+m7p4aR4To
	 hMYNxBq3+/hmYdimYscdMB84FF5GUPY7YB3NISeGwxldJQ63rf1Rb6vwFQk00crxuA
	 vSM6jygvmQbjA==
Date: Mon, 20 Nov 2023 17:16:31 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Michalik <michal.michalik@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com, jonathan.lemon@gmail.com,
	pabeni@redhat.com, poros@redhat.com, milena.olech@intel.com,
	mschmidt@redhat.com, linux-clk@vger.kernel.org, bvanassche@acm.org,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH RFC net-next v3 2/2] selftests/dpll: add DPLL system
 integration selftests
Message-ID: <20231120171631.GB245676@kernel.org>
References: <20231117190505.7819-1-michal.michalik@intel.com>
 <20231117190505.7819-3-michal.michalik@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117190505.7819-3-michal.michalik@intel.com>

On Fri, Nov 17, 2023 at 08:05:05PM +0100, Michal Michalik wrote:
> The tests are written in Python3 (3.7+) and pytest testing framework.
> Framework is basing on the ynl library available in the kernel tree
> at: tools/net/ynl
> 
> High level flow of DPLL subsystem integration selftests:
> (after running run_dpll_tests.sh or 'make -C tools/testing/selftests')
> 1) check if Python in correct version is installed,
> 2) create temporary Python virtual environment,
> 3) install all the required libraries,
> 4) run the tests,
> 5) do cleanup.
> 
> The DPLL system integration tests are meant to be part of selftests, so
> they can be build and run using command:
>   make -C tools/testing/selftests
> 
> Alternatively, they can be run using single command [1]:
>   make kselftest
> 
> If we want to run only DPLL tests, we should set the TARGETS variable:
>   make -C tools/testing/selftests TARGETS=drivers/net/netdevsim/dpll
> 
> They can also be run standalone using starter script:
>   ./run_dpll_tests.sh
> 
> There is a possibliy to set optional PYTEST_PARAMS environment variable
> to set the pytest options, like tests filtering ("-k <filter>") or
> verbose output ("-v").
> 
> [1] https://www.kernel.org/doc/html/v5.0/dev-tools/kselftest.html
> 
> Signed-off-by: Michal Michalik <michal.michalik@intel.com>

...

> diff --git a/tools/testing/selftests/drivers/net/netdevsim/dpll/run_dpll_tests.sh b/tools/testing/selftests/drivers/net/netdevsim/dpll/run_dpll_tests.sh
> new file mode 100755
> index 0000000..3bed221
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netdevsim/dpll/run_dpll_tests.sh
> @@ -0,0 +1,75 @@
> +#!/usr/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Wraper script for running the DPLL system integration tests.

nit: Wrapper

     Also elsewhere in this patch.

...

