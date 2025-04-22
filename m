Return-Path: <netdev+bounces-184650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A3EA96C57
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA0E189EEF9
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B0B281357;
	Tue, 22 Apr 2025 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVVJCXRy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623B427F4D6;
	Tue, 22 Apr 2025 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328027; cv=none; b=fmqVTf1BJbmr0J3B5q1RMV7YKEr+crlLQZRJaxHJatgO/ntLfSNDDtFHunshEUycPrLYu1fmf5km7vl5znAW1UhbfcoGbpFJMcP3ja6mACfeaz9kMMMR+GF4D2X+e6gToCNxmLKPh/0Bg+adXa7w1SqI0ryBlALpS9Gg3VXI5z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328027; c=relaxed/simple;
	bh=wZdmrDgX4yePsaIadpP1W3K+3M/OYFjuXxvjnHeQd1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpt8nr+8WcM0BnwJk14oTEcbQfUjkl2HKjEkyI7SlSUNWA9aoa4ji14vJ1NmeHIbU325bXdR9sXGjjinp2wt2ZQODtXjNMOCLxJcGupif4HtgoqbbENqYxKs0ssXaaQvQyez4gGvgVPwkHDEfh3HTy111rvDU8OjLeSM3nXfNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVVJCXRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1197C4CEE9;
	Tue, 22 Apr 2025 13:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745328027;
	bh=wZdmrDgX4yePsaIadpP1W3K+3M/OYFjuXxvjnHeQd1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVVJCXRyR/9Z8AR1n5u6aqdVgwNHkrD+ADPH29kFztrX2lbP+X2gyyogsAb5dF4fT
	 GrMEkE2OJbeAx57FJd58nfL9L0sPrw1TFMYPgcWXv8WG2zgZjMH4ZCKTOe7PBAQhAK
	 5GE0vPfA5uvyLU6ocQgsKBvfERoGPuXp3/C0JOCafnLRKLVlYOhf0qU8unCDnvbjqi
	 H/yjcfq/whk9JK5RxQ8918iwt2YlqbgX+GkXrGN5S/UjHJRVc87gb7AXNqP5/dL0L9
	 2aFfPeW389eIDFgSUO2ubYdqUKhioXSO4evOmImpP9bQPOvciRa0jbijgzLs2kzfFO
	 nXVzPrPD2/pLw==
Date: Tue, 22 Apr 2025 14:20:23 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net v3 1/3] rtase: Modify the condition used to detect
 overflow in rtase_calc_time_mitigation
Message-ID: <20250422132023.GG2843373@horms.kernel.org>
References: <20250417085659.5740-1-justinlai0215@realtek.com>
 <20250417085659.5740-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417085659.5740-2-justinlai0215@realtek.com>

On Thu, Apr 17, 2025 at 04:56:57PM +0800, Justin Lai wrote:
> Fix the following compile error reported by the kernel test
> robot by modifying the condition used to detect overflow in
> rtase_calc_time_mitigation.
> 
> In file included from include/linux/mdio.h:10:0,
>                   from drivers/net/ethernet/realtek/rtase/rtase_main.c:58:
>  In function 'u16_encode_bits',
>      inlined from 'rtase_calc_time_mitigation.constprop' at drivers/net/
>      ethernet/realtek/rtase/rtase_main.c:1915:13,
>      inlined from 'rtase_init_software_variable.isra.41' at drivers/net/
>      ethernet/realtek/rtase/rtase_main.c:1961:13,
>      inlined from 'rtase_init_one' at drivers/net/ethernet/realtek/
>      rtase/rtase_main.c:2111:2:
> >> include/linux/bitfield.h:178:3: error: call to '__field_overflow'
>       declared with attribute error: value doesn't fit into mask
>     __field_overflow();     \
>     ^~~~~~~~~~~~~~~~~~
>  include/linux/bitfield.h:198:2: note: in expansion of macro
>  '____MAKE_OP'
>    ____MAKE_OP(u##size,u##size,,)
>    ^~~~~~~~~~~
>  include/linux/bitfield.h:200:1: note: in expansion of macro
>  '__MAKE_OP'
>   __MAKE_OP(16)
>   ^~~~~~~~~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503182158.nkAlbJWX-lkp@intel.com/
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Hi Justin,

FWIIW, I note that this problem is reported by GCC 7.5.0 on sparc64 but not
by GCC 14.2.0. And I think that is because in the end the values passed to
u16_encode_bits (line 1915 in the trace above) are the same with and
without this patch. That is to say, this the compiler error above is a
false positive of sorts.

But I believe GCC 7.5.0 is a supported compiler version for sparc64.
And this does result in an error, without W=1 or any other extra KCFLAGS
set. So I agree this is appropriate to treat as a fix for net.

And in any case, fix or no fix, it seems nice to limit the scope of
the initialisation of msb.

Reviewed-by: Simon Horman <horms@kernel.org>


