Return-Path: <netdev+bounces-244363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE31BCB57A3
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 11:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07CD43021779
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FE92FD690;
	Thu, 11 Dec 2025 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsujrt+m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0892D77EA
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765448021; cv=none; b=HKb52qPIahuEXbTJpA9ro1lKR9GaFsYA53AOohAX1ZHxq9bVTkcRZ6xtF7kgZK3N5wduH59pbgFgk6SXI3/WreHaqPic2b9kgcwymYhU4X4QxfMenh3TyQ87Wu4ke8IEPCXQ5805w7mVRrJTKroJwPg0k0yNVcLUrVUUgIBM8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765448021; c=relaxed/simple;
	bh=L9Xxm1csAi9qlDdqlJJLNQjozlpOvefQRN2OmVvA0ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce3sFRRR2KBypLoLdkeGc9OoBcjv4wvulMQ88utOuj0eA7KIjPHLt8kN1GQhXppUb+xYx4hTCCsKGUmfnaFc1soMmq6upULoCLpMgRe9rAYmjeMjTPEuKCMLibBCLmis0irCVxR/Gv47bugQ5uHtP75beVtyeAO63x/vVmpl8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsujrt+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90387C4CEF7;
	Thu, 11 Dec 2025 10:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765448020;
	bh=L9Xxm1csAi9qlDdqlJJLNQjozlpOvefQRN2OmVvA0ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsujrt+mzuu9+/2qNX+Zafmc/iGGN/N4mih/nwfEVeJLyLG6bp77mLVfCGA9cu2IT
	 0Ho/hr58qzM4gEu5lhLEvRVwg1iPrdMF51svHl3K1eADR6U1tVKLGE8/yxFdS7vyZS
	 lXrNhxWM9VYz/D6ps4gEDG4DiO27dON8y+eZFYRAn4NL4D8IQIFWYXQCfIC2xQZCpb
	 2WiYS31e05yfX6zv+lihwRgMy1zNf22Q8pBxX/mzu9Feyx5gXjICa2vTvUHHGSgvgw
	 Eb3L/D+ZT7mow+zk1EMXVLRdjb+T4mJL1mgbuLT3PiI2Yn3+sEtDY9IRiMLhQHGGhc
	 +jLms5sqacryA==
Date: Thu, 11 Dec 2025 10:13:37 +0000
From: Simon Horman <horms@kernel.org>
To: "Alice C. Munduruca" <alice.munduruca@canonical.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] selftests: net: fix "buffer overflow detected" for
 tap.c
Message-ID: <aTqZUSZaZjDTlejt@horms.kernel.org>
References: <20251210223932.957446-1-alice.munduruca@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210223932.957446-1-alice.munduruca@canonical.com>

On Wed, Dec 10, 2025 at 05:39:32PM -0500, Alice C. Munduruca wrote:
> When 'tap.c' is compiled with '-D_FORTIFY_SOURCE=3', the strcpy() in
> rtattr_add_strsz() is replaced with a checked version which causes the
> test to consistently fail when compiled with toolchains for which this
> option is enabled by default.
> 
>  TAP version 13
>  1..3
>  # Starting 3 tests from 1 test cases.
>  #  RUN           tap.test_packet_valid_udp_gso ...
>  *** buffer overflow detected ***: terminated
>  # test_packet_valid_udp_gso: Test terminated by assertion
>  #          FAIL  tap.test_packet_valid_udp_gso
>  not ok 1 tap.test_packet_valid_udp_gso
>  #  RUN           tap.test_packet_valid_udp_csum ...
>  *** buffer overflow detected ***: terminated
>  # test_packet_valid_udp_csum: Test terminated by assertion
>  #          FAIL  tap.test_packet_valid_udp_csum
>  not ok 2 tap.test_packet_valid_udp_csum
>  #  RUN           tap.test_packet_crash_tap_invalid_eth_proto ...
>  *** buffer overflow detected ***: terminated
>  # test_packet_crash_tap_invalid_eth_proto: Test terminated by assertion
>  #          FAIL  tap.test_packet_crash_tap_invalid_eth_proto
>  not ok 3 tap.test_packet_crash_tap_invalid_eth_proto
>  # FAILED: 0 / 3 tests passed.
>  # Totals: pass:0 fail:3 xfail:0 xpass:0 skip:0 error:0
> 
> Using `memcpy`, an unchecked function, avoids this issue and allows
> the tests to go forwards as expected.
> 
> Fixes: 2e64fe4624d1 ("selftests: add few test cases for tap driver")
> Signed-off-by: Alice C. Munduruca <alice.munduruca@canonical.com>

Thanks Alice,

I agree that this approach makes sense.
But I wonder if the commit message should also mention:

1. That this is consistent with usage elsewhere in this file
2. Why there is actually no overflow.

...

