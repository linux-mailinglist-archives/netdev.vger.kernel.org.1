Return-Path: <netdev+bounces-28570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577CE77FDEB
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 20:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CAB28215C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B915AE1;
	Thu, 17 Aug 2023 18:35:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA23239
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 18:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BDBC433C7;
	Thu, 17 Aug 2023 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692297302;
	bh=Am9UjkNW3MpdBFNCNvHcgdFElSJkruM1s/i+apzM684=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0MvQSnM9LxeHRm/VTcdByTU+Rto8o7/EkisezoueQthmJjwZrdXj+xLdplgmpNJp
	 t35JO91Mt7ImaoTuTfZn/vDgNU6cqd8jsIM60tkG4s6Wn25f08v1Gyj7HPVOuFd4M0
	 88kS0OT7+q5VeSOIdyUSPULwJJJJp/a56iJ/JWptfpsutzXR0CIn2d0fnSabiAPcxr
	 5/wAogsXkfa7CL7DB+/eVSh8fwBFRXKHiYNlTiuXfMUclJS1PNjFnAkx3NIiDulJ2j
	 J71VfTlvwqPUzIMSIW+2zHKoXZatNl5JxassFpyfIguWQoPoeCMgb0MFpzjWSJpY5z
	 ZHub0snRoJDMQ==
Date: Thu, 17 Aug 2023 20:34:58 +0200
From: Simon Horman <horms@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next] net: lan966x: Fix return value check for
 vcap_get_rule()
Message-ID: <ZN5oUpbbRWie9676@vergenet.net>
References: <20230817123726.1885512-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817123726.1885512-1-ruanjinjie@huawei.com>

On Thu, Aug 17, 2023 at 08:37:26PM +0800, Ruan Jinjie wrote:
> Since vcap_get_rule() return NULL or ERR_PTR(), just check NULL
> is not correct. So use IS_ERR_OR_NULL() to fix the issue.
> 
> Fixes: 72df3489fb10 ("net: lan966x: Add ptp trap rules")
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Hi Ruan Jinjie,

Could we consider updating vcap_get_rule() to always return an ERR_PTR()
and update the error detection conditions to use IS_ERR()?
It seems to me that would be somewhat cleaner in this case.

