Return-Path: <netdev+bounces-53085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402558013DB
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 21:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE90F281CB4
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 20:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B91F54BC9;
	Fri,  1 Dec 2023 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaEDBX/i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07734D59E;
	Fri,  1 Dec 2023 20:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135B3C433CA;
	Fri,  1 Dec 2023 20:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701460994;
	bh=VKO7H1hgguo6aqL6Jv73CFvzI/2EG9Mdqq5XH2jJIWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VaEDBX/imma0K1AEc9/J9eI2t3L2lNfyd8vhFLTsez3ffc9J34q6KTBSsiMotemGb
	 uk87MtXcfpKm/jICySH5CgI5jFGeqExQnJlNk9AyctA3SjtVYlQ/TgsI4jmdQwVoJf
	 PIkCndN7v/zDx1xK4BueV6577bXYtny3ed0jj+md0OkGTvsS4xI3pwKlWPvrLt2H1n
	 kz3GSo0bC1Y6+g/91ety9Us4JZ7t7NC07wNtGubOuZnVC39l5YSIRmmv7t7vdMN+pt
	 kq8/Mq0QOE7RVRXtQQvAFcLnLA07PstATYpqn4BN8uL6IYvHPaMPq+zqaFBH19Lz9N
	 g71RN+ZceRRHg==
Date: Fri, 1 Dec 2023 12:03:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Michalik <michal.michalik@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jonathan.lemon@gmail.com,
 pabeni@redhat.com, poros@redhat.com, milena.olech@intel.com,
 mschmidt@redhat.com, linux-clk@vger.kernel.org, bvanassche@acm.org,
 davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH RFC net-next v4 2/2] selftests/dpll: add DPLL system
 integration selftests
Message-ID: <20231201120313.36c2e722@kernel.org>
In-Reply-To: <20231123105243.7992-3-michal.michalik@intel.com>
References: <20231123105243.7992-1-michal.michalik@intel.com>
	<20231123105243.7992-3-michal.michalik@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 05:52:43 -0500 Michal Michalik wrote:
> +++ b/tools/testing/selftests/drivers/net/netdevsim/dpll/ynlfamilyhandler.py
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Wrapper for the YNL library used to interact with the netlink interface.
> +#
> +# Copyright (c) 2023, Intel Corporation.
> +# Author: Michal Michalik <michal.michalik@intel.com>
> +
> +import sys
> +from pathlib import Path
> +from dataclasses import dataclass
> +
> +from .consts import KSRC, YNLSPEC, YNLPATH
> +
> +
> +try:
> +    ynl_full_path = Path(KSRC) / YNLPATH
> +    sys.path.append(ynl_full_path.as_posix())
> +    from lib import YnlFamily
> +except ModuleNotFoundError:
> +    print("Failed importing `ynl` library from kernel sources, please set KSRC")
> +    sys.exit(1)

Do you have any suggestions on how we could build up a common Python
library for selftests? Can we create a directory for "library" code
somewhere under tools/testing/ ? Adding a wrapper like this for every
test is going to hurt.

Calling out to YNL, manipulating network namespaces, manipulating
netdevsim instances, etc - will be fairly common for a lot of networking
tests.

There's already some code in tools/testing/selftests/bpf/test_offload.py
which is likely Python-incompetent cause I wrote it. But much like YNL
it'd be nice if it was available for new tests for reuse.

Can we somehow "add to python's library search path" or some such?

