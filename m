Return-Path: <netdev+bounces-159815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A202A17021
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EEB1690E3
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B791E9B15;
	Mon, 20 Jan 2025 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTzi6RTH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9B1E9B11;
	Mon, 20 Jan 2025 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390371; cv=none; b=gVN7WllSpuriCKl5eB2lo6oGcJ+3rgYiq8FfKk8xd0h5ExHQx/0LaWkxXzcUp3qw5SVF50D4x3JpXqIJMRmwOANXX/MSZCG99KpEPzNz9uvBb4QMdfxe/e38rw9kahOUol6HNRIDJNJGU2OdOKO3T4guQa4/Qh2Ja6AOIscpBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390371; c=relaxed/simple;
	bh=HZUbkvOYtB8Y+G6le1YH+Vvvi88y7Jt1Us/+O6z8QRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9799RHe9wzEd1zXkkDc98b3Hvmg4FJUgfjY9yXHznZGRhqITrOzbCUOyCH6T8mJ2BeKMAdMH5zrpLZhkuzKXXSMDuYzfjMbS6ta8GFpVGtv/vSx4jUMOJUh2j2H8vFLFC97DfVkpZUiUVWwZs6ayvLdRTVbBVTPE3cWb5ACq+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTzi6RTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FD1C4CEDD;
	Mon, 20 Jan 2025 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737390369;
	bh=HZUbkvOYtB8Y+G6le1YH+Vvvi88y7Jt1Us/+O6z8QRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mTzi6RTHX4unnGc3jDJK8UDyyCkUdcv5800xCdp5SOHZS+JBweyV14kuZcsPu+8VB
	 Z8sSNGzP/o0cfioDt2DUgNz3OodSnZdsxiSp8UQaGGLrWIugp1mPWl0fxpsElyTKYp
	 HCD2OAWbTDMNw3dSkC6QEThHcxunvJ9ORBWPGrCyav0M6T31fFK832xNHJm3BzUv4B
	 BTHi4aYrv/vtiupnU5lV2wQyn4vQEcvplj75NojOFO/dstA9IiJR9YLSejnXGV3tk3
	 UpBIi3gjlv+fXQm7TmNxQgPRG1gFp7By/msb8zwuP+FYi26AwbA6gyd7jLVMFuYxqd
	 RhgCMCImBFrAQ==
Date: Mon, 20 Jan 2025 16:26:05 +0000
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v2] ipv4: ip_gre: Fix set but not used warning
 in ipgre_err() if IPv4-only
Message-ID: <20250120162605.GZ6206@kernel.org>
References: <67956320a8ee663f2582cc75f0e8047d69da5f6a.1737371364.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67956320a8ee663f2582cc75f0e8047d69da5f6a.1737371364.git.geert@linux-m68k.org>

On Mon, Jan 20, 2025 at 02:12:36PM +0100, Geert Uytterhoeven wrote:
> if CONFIG_NET_IPGRE is enabled, but CONFIG_IPV6 is disabled:
> 
>     net/ipv4/ip_gre.c: In function ‘ipgre_err’:
>     net/ipv4/ip_gre.c:144:22: error: variable ‘data_len’ set but not used [-Werror=unused-but-set-variable]
>       144 |         unsigned int data_len = 0;
> 	  |                      ^~~~~~~~
> 
> Fix this by moving all data_len processing inside the IPV6-only section
> that uses its result.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501121007.2GofXmh5-lkp@intel.com/
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Do not use the ternary operator,
>   - Target net-next.

Thanks Geert,

This has been bothering me too.

Reviewed-by: Simon Horman <horms@kernel.org>

