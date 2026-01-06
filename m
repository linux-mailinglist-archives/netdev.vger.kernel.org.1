Return-Path: <netdev+bounces-247426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EDDCF9EBD
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 19:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77C9C3044366
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 18:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B833F2FFDD6;
	Tue,  6 Jan 2026 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA1IAUJ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721162F9984
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722210; cv=none; b=sUbk0/YzNIvq7Fi1jrjAE4Ro77RiswGoMbzQ6QxIpxCudXGNX4COWE430d/P0FTVODPVJ618+RpmIYk6AmGzKeK78hDGPgVvKHRukn+Lf/gDUMzxih24VEP1lTebnZ7xRHJz8YbCggBqb4P1IVTj0YVm/V9ZJtvq6NNPaP7viQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722210; c=relaxed/simple;
	bh=fs/yg4XuRPTPaStP+CSYTKfQJTQA27E3x3kVXfla8LU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeTX3J2xExc3B1jPXmJmiaxhgOmkskD7WvbNy1+MP2on4u060vJroauDIoG28jpyiA+b+4cdgMLdDvYPXKKN9mf6LDEyfOIqMAMoBEvGnJicPPKyxb45TOPEQ+fCnsJj20nTv4v6aIJj4YvLRfKjIA10KimgBfqf77gBdW8sSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA1IAUJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5BCC116C6;
	Tue,  6 Jan 2026 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767722210;
	bh=fs/yg4XuRPTPaStP+CSYTKfQJTQA27E3x3kVXfla8LU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mA1IAUJ88z4e6iQixoHwzgreu2cWlcivEyat6dnNm5kCofOEj6WiGXOElW+MHJ24e
	 dDDzqT+VuBTbc+7zi6cpBC7V+HdYGZjEo/hKkdcnrMnWnXSIEQ3JWQo7Jhno4mvuAg
	 vBKjadpCd7YrSSRmVBbt5fpZVgNrBz5sm5A51ll3pmuLGk/9R9nMa4j3vacaFghHV6
	 NIyKpSGmLysdvVbnRGylLZwzMeVp7lPG7Kc+UtZmaQWayhayUzWPqA7N1Y/ugpX8Tu
	 FJDO49R9jOb7XlsrL5xOh+aXtEP1q1nfpjj78g47m+JwJHPFz8zX9KHldqICYHtt7d
	 e8aFiSlVr03WQ==
Date: Tue, 6 Jan 2026 09:56:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Florian Westphal
 <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, Mazin Al Haddad
 <mazin@getstate.dev>
Subject: Re: [PATCH v2 net] ip6_gre: use skb_vlan_inet_prepare() instead of
 pskb_inet_may_pull()
Message-ID: <20260106095648.07a870f1@kernel.org>
In-Reply-To: <20260106144529.1424886-1-edumazet@google.com>
References: <20260106144529.1424886-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 14:45:29 +0000 Eric Dumazet wrote:
> v2: invert the conditions (Jakub)

Thanks! Much better now, but still failing 
tools/testing/selftests/net/gre_gso.sh

TAP version 13
1..1
# timeout set to 3600
# selftests: net: gre_gso.sh
# 2.16 [+2.16]     TEST: GREv6/v4 - copy file w/ TSO                                   [ OK ]
# 3.16 [+1.01] 2026/01/06 10:32:57 socat[20546] W exiting on signal 15
# 3.17 [+0.01] 2026/01/06 10:32:57 socat[20546] W exiting on signal 15
# 3.17 [+0.00]     TEST: GREv6/v4 - copy file w/ GSO                                   [FAIL]
# 3.18 [+0.01] 2026/01/06 10:32:57 socat[20533] W exiting on signal 15
# 3.19 [+0.00]     TEST: GREv6/v6 - copy file w/ TSO                                   [ OK ]
# 4.19 [+1.00] 2026/01/06 10:32:59 socat[20559] W exiting on signal 15
# 4.19 [+0.01]     TEST: GREv6/v6 - copy file w/ GSO                                   [FAIL]
# 4.20 [+0.01] 2026/01/06 10:32:59 socat[20549] W exiting on signal 15
# 4.22 [+0.02] 2026/01/06 10:32:59 socat[20560] W exiting on signal 15
# 4.23 [+0.01] 
# 4.23 [+0.00] Tests passed:   2
# 4.23 [+0.00] Tests failed:   2
not ok 1 selftests: net: gre_gso.sh # exit=1

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/461862/65-gre-gso-sh/stdout

