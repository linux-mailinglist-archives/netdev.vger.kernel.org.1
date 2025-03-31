Return-Path: <netdev+bounces-178300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA51AA7671F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FF41889843
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 13:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC941212FAB;
	Mon, 31 Mar 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp6BdQ72"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A8F20296C
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429070; cv=none; b=BdId8HExGE7lC3O5WxqbUNDpJpZFKJv0E58sd8HeKYVWAeXrJfOUGapTv3U8s0EGFAlGuyBTliHyDn+XQjgocUHd+Xe9Ss8gazwXaGMT2Y0DGiDVvq9YTrvnme0Z7auyn1Iqo37hSXW59OA88XWTt6+eTHh2wLrGVG6DXbZWP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429070; c=relaxed/simple;
	bh=Hn5ZgpWUfjORcCaaECTI4BDLLOY17ziXbas+GSCOQak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guF2FWygKI2M1v67Mx1mOr/iSAdjzfSIZTbS/kgdVEh30ANpYOMAl9TMTh57bHKjPCz6dq/Fp8sErLogsBBFQwK0MbEvtXC7QRO0B0l4yeNDtdztahd0cj078Y9G1/RZdOrTDpbGLVB7hILaejxLJcd8wW5AM6ziozoIDv9+1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp6BdQ72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B582FC4CEE4;
	Mon, 31 Mar 2025 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743429070;
	bh=Hn5ZgpWUfjORcCaaECTI4BDLLOY17ziXbas+GSCOQak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bp6BdQ72ETAZ8FegulUP/r9lsYuObL/jrj+RxrQ8JtZ4R6cBST3AY4jBXAfvl09i8
	 +PBdGZ2L3w8Rlw9fqmlY9JqKDiBD7fIgHScR6Habp9OAvQsMdquqpful5wu9L62X+S
	 4pBPjdg445+aa9fjnUAco2IydqcngEN0AE1s6WJ8EFDI1KE606PTjHyZY/iJMDneln
	 SX8jWDc+BP5amhc18JytP+b/I9Ypu+QViQZp8PfDJ5ilROZtcXLjquZutK8FT3AOmc
	 5kUoFWkGeTQBl3a9axpyifFz7XAepDbdFGQTsxrnF995O9OSuz3MFnXdPuR+5U9Dd2
	 3455DHX22MM3g==
Date: Mon, 31 Mar 2025 06:51:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 net 0/3] udp: Fix two integer overflows when
 sk->sk_rcvbuf is close to INT_MAX.
Message-ID: <20250331065109.45dddd0d@kernel.org>
In-Reply-To: <20250329180541.34968-1-kuniyu@amazon.com>
References: <20250329180541.34968-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Mar 2025 11:05:10 -0700 Kuniyuki Iwashima wrote:
> v4:
>   * Patch 4
>     * Wait RCU for at most 30 sec

The new test still doesn't pass

TAP version 13
1..1
# timeout set to 3600
# selftests: net: so_rcvbuf
# 0.00 [+0.00] TAP version 13
# 0.00 [+0.00] 1..2
# 0.00 [+0.00] # Starting 2 tests from 2 test cases.
# 0.00 [+0.00] #  RUN           so_rcvbuf.udp_ipv4.rmem_max ...
# 0.00 [+0.00] # so_rcvbuf.c:151:rmem_max:Expected pages (35) == 0 (0)
# 0.00 [+0.00] # rmem_max: Test terminated by assertion
# 0.00 [+0.00] #          FAIL  so_rcvbuf.udp_ipv4.rmem_max
# 0.00 [+0.00] not ok 1 so_rcvbuf.udp_ipv4.rmem_max
# 0.01 [+0.00] #  RUN           so_rcvbuf.udp_ipv6.rmem_max ...
# 0.01 [+0.00] # so_rcvbuf.c:151:rmem_max:Expected pages (35) == 0 (0)
# 0.01 [+0.00] # rmem_max: Test terminated by assertion
# 0.01 [+0.00] #          FAIL  so_rcvbuf.udp_ipv6.rmem_max
# 0.01 [+0.00] not ok 2 so_rcvbuf.udp_ipv6.rmem_max
# 0.01 [+0.00] # FAILED: 0 / 2 tests passed.
# 0.01 [+0.00] # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: net: so_rcvbuf # exit=1


Plus we also see failures in udpgso.sh

