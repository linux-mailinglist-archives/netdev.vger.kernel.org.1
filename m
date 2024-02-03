Return-Path: <netdev+bounces-68754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CBC847E6F
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8761F2761C
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 02:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472FB4694;
	Sat,  3 Feb 2024 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdcB5lsa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B861FCC
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706927608; cv=none; b=LlYQwa8BccgIXcCb/Y8aQ2Ob9Ew55fvTDZUsLLrfP2TNPlbq79jnSm7GMG/LdTLvAXtgmckndJG667uijHpRKlyjh4yaSo5+HkEu8cTKI1oRg90KDID6XNWDTIC6nk7jP63/UHHv362x3N1NiYePw88CJLHt/82CQ52qYvKbmeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706927608; c=relaxed/simple;
	bh=amnrwesasT5pYnt9kqdqykfT9hbDmisRunSKyya+5WA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEZiTsiFNnCVHYFJozI8AUhU1nrv9LPWcZ0Dscpx0OJmmoEm3IvzYjavOT0n6e2HYfD93bpBJSKDmOJigZ8qyB6WFWGxV0bHjyf/3/caoTkDMDZIlXFW02D1ZMDQrT/p1D+hyW/m0o2Yq9EdfSOf7bHLdx/j+JCPvcjlUIxkhDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdcB5lsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C19AC433F1;
	Sat,  3 Feb 2024 02:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706927607;
	bh=amnrwesasT5pYnt9kqdqykfT9hbDmisRunSKyya+5WA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UdcB5lsaviFTUGVhoTeIej4uGFvZDpqgY/kCl1kGP32w1S3cQdOqOT8aqomtLvDzx
	 xW6IUyGOXbXkGvQeZn8bVOIsJxbba5+qtJnneI64dhOomq0MEnnym/PGJftiYSNd7k
	 52kZVCzZsc8KDJH4lzIIQI9182fnz5Gu2nwFwMNuiAU16iAP+FTxjAwrrcg/QUcnut
	 wjxIqEFP8xgENF0N+HyCCyYpDAYaNwvJj8MsoR7QnKE8oEoEz7m4MaeQU4fjyCNOE5
	 P7NlEYR216lSFAX1s5dU/w0e2ydiNfjvPUuer71BPMu9I5OZO3Sq4Xn+eqgUkrYwMh
	 sIopenWENRqUQ==
Date: Fri, 2 Feb 2024 18:33:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, mkubecek@suse.cz, alexander.duyck@gmail.com,
 willemdebruijn.kernel@gmail.com, gal@nvidia.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH ethtool v2] ethtool: add support for RSS input
 transformation
Message-ID: <20240202183326.160f0678@kernel.org>
In-Reply-To: <20240202202520.70162-1-ahmed.zaki@intel.com>
References: <20240202202520.70162-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Feb 2024 13:25:20 -0700 Ahmed Zaki wrote:
> Add support for RSS input transformation [1]. Currently, only symmetric-xor
> is supported. The user can set the RSS input transformation via:
> 
>     # ethtool -X <dev> xfrm symmetric-xor
> 
> and sets it off (default) by:
> 
>     # ethtool -X <dev> xfrm none
> 
> The status of the transformation is reported by a new section at the end
> of "ethtool -x":
> 
>     # ethtool -x <dev>
>       .
>       .
>       .
>       .
>       RSS hash function:
>           toeplitz: on
>           xor: off
>           crc32: off
>       RSS input transformation:
>           symmetric-xor: on
> 
> Link: https://lore.kernel.org/netdev/20231213003321.605376-1-ahmed.zaki@intel.com/
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

