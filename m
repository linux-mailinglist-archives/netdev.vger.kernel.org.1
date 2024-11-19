Return-Path: <netdev+bounces-146081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F619D1E95
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F31CB22FF8
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDFE839F4;
	Tue, 19 Nov 2024 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDrlDIW5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734CDC2C9;
	Tue, 19 Nov 2024 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985341; cv=none; b=W1/kqLgrrPf5Be+w5RjrYZByQz5qxVZSAvwyzZvcwb72L1I9Hbpx9C+NHM5TRGaNMnaYfq37OwFdg4o23fW5aAVJGnlCyPF0n1O978K3Eh+sKIKEJ7tZ5+Qh3q8i/OQXwVDfVN+DH+YKtC/iY7Yl/IaMl5BxjOYMx81mZF7sgfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985341; c=relaxed/simple;
	bh=skSyyD0B90oPoREXDpJMM0gHuSbXub3nJAV1EYWY41c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwnQKCE1uK453Hs4H3lg7Cdbng6vkI/4ItgeqJoMoseElOHCRvi+fTtqI3hCKNMhXQ8pvdcftlNule6p2HQLoOHVIclLpbPqCaxhnfc1k0x41tueh8arJpGsvtsTEcf8lJaTLRGvsJ3Hw4r9kcyKMjKV0cdOlmlrCxwNABcmncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDrlDIW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEB4C4CECC;
	Tue, 19 Nov 2024 03:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985340;
	bh=skSyyD0B90oPoREXDpJMM0gHuSbXub3nJAV1EYWY41c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MDrlDIW570K20wb9dlLVc1fbjhYjcLJOw7Vxe04PUeqU7u2c5qFeL2F2r1woAbGTr
	 eQ2SAVzMo/d0NXdUH2O7PLQ505SQARO6I8tAADt1FVpyR7NIetd6AyZpy08DpejB/w
	 LPyGXoExE5QjRSBE8t4tgCfmJSqGEuQ9YAX1j/5DDWa+iwn+/zcewm0bnawewJ8Qpp
	 4iqmZbjCXRW6UsndJE56euUhANbVK1YUkcv3r46Zn7yHWiVQYnjklG/tQghv7W8AEB
	 EX45ZYslvjmDutw1vCGGF3GkCRBCtL/z+hQgW8pXLUmXR0Q8hwciyPZFG2elehcFEE
	 SQMk1V4rabh2g==
Date: Mon, 18 Nov 2024 19:02:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Michal Kubiak <michal.kubiak@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, Stephen Hemminger
 <stephen@networkplumber.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: Re: [PATCH net 2/2] netpoll: Use rcu_access_pointer() in
 netpoll_poll_lock
Message-ID: <20241118190219.5b4c601b@kernel.org>
In-Reply-To: <20241118-bipedal-beryl-peccary-ed32da@leitao>
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
	<20241118-netpoll_rcu-v1-2-a1888dcb4a02@debian.org>
	<ZzsxDhFqALWCojNb@localhost.localdomain>
	<20241118-bipedal-beryl-peccary-ed32da@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 07:37:43 -0800 Breno Leitao wrote:
> I am not planning to resend it now, since I think maintainer's tooling will
> reorder that.

FWIW ours doesn't, but I fixed up manually.

