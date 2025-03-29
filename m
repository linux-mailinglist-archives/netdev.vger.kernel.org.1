Return-Path: <netdev+bounces-178186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CB1A756D6
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 15:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A83D1889805
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306B71C6F55;
	Sat, 29 Mar 2025 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juFNFcvz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A922DDBC
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743259997; cv=none; b=Oees8h6cl1gIzO3QmQgiURZPng3hVhyNJx1lZ86BxQMt/y38vd7zOR7u1wYRqWdIkAC9TZ3SRHpIR00XTvcBg+T9wug/N7SevDxBwSJQNwt8JHwaTKuASrqAFUKe1IX+v8nYoIC7l27Pycskq3YMBOUU8XCzBJQ42RlYM7k63WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743259997; c=relaxed/simple;
	bh=h3ljAei4Eao2o2Lp3s9/FR/9ObDG4yMMpYFbxZekNHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7ZB3mNlu6usFJ2oQxh1bA+isw9YovQjxDCzpWyXBvNze0nZLbU0k0iA1uR0hfVMcUDJ8936qpTVZJQFIunJJqOrhf0Ca133+MTOaEgx8jiaYdo0UZL+WeeuWEUGNxthnKuZ7eXSa8fhrLFej9VRTETA4xgsP7ZjbXGeMccYk7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juFNFcvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09936C4CEE2;
	Sat, 29 Mar 2025 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743259996;
	bh=h3ljAei4Eao2o2Lp3s9/FR/9ObDG4yMMpYFbxZekNHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=juFNFcvzx1LeRvbYlG/SATbHJh9LPKsjVLEczrP7itdPGDHfergiqLlgHFtnYzppH
	 reltoiwEHmTk8KkS1h03wdmwOR/80DO1lFtk8Rk3krM/dzHP/GpJxG1UpvhqiPRFWL
	 fYQHD9dRESBfJNd+4UWthCdCzEcAw1cgrU6ygOcwF/0vID1rqc/EU+XC0nsuBLoC8r
	 D8AwWfzX88Z+hurZvE11eJD0hK3jXwwICiWk5gPpNHRSXCjkSZrtCsTUyCsBHn8kpJ
	 O4sFQcmcTGM/m60hQDUpZDZjJlmqW+THyiTWwHdywSEc5tfAiU1ryyy4/Ji7YpELz8
	 OWct7arrE8yWA==
Date: Sat, 29 Mar 2025 07:53:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net 0/3] udp: Fix two integer overflows when
 sk->sk_rcvbuf is close to INT_MAX.
Message-ID: <20250329075315.0ec21bdd@kernel.org>
In-Reply-To: <20250327202722.63756-1-kuniyu@amazon.com>
References: <20250327202722.63756-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 13:26:52 -0700 Kuniyuki Iwashima wrote:
> I got a report that UDP mem usage in /proc/net/sockstat did not
> drop even after an application was terminated.
> 
> The issue could happen if sk->sk_rmem_alloc wraps around due
> to a large sk->sk_rcvbuf, which was INT_MAX in our case.
> 
> The patch 2 fixes the issue, and the patch 1 fixes yet another
> overflow I found while investigating the issue.

Test fails in the CI, unfortunately:

# 0.00 [+0.00] TAP version 13
# 0.00 [+0.00] 1..2
# 0.00 [+0.00] # Starting 2 tests from 2 test cases.
# 0.00 [+0.00] #  RUN           so_rcvbuf.udp_ipv4.rmem_max ...
# 0.00 [+0.00] # so_rcvbuf.c:150:rmem_max:Expected get_prot_pages(_metadata, variant) (49) == 0 (0)
# 0.01 [+0.00] # rmem_max: Test terminated by assertion
# 0.01 [+0.00] #          FAIL  so_rcvbuf.udp_ipv4.rmem_max
# 0.01 [+0.00] not ok 1 so_rcvbuf.udp_ipv4.rmem_max
# 0.01 [+0.00] #  RUN           so_rcvbuf.udp_ipv6.rmem_max ...
# 0.01 [+0.00] # so_rcvbuf.c:150:rmem_max:Expected get_prot_pages(_metadata, variant) (49) == 0 (0)
# 0.01 [+0.00] # rmem_max: Test terminated by assertion
# 0.01 [+0.00] #          FAIL  so_rcvbuf.udp_ipv6.rmem_max
# 0.01 [+0.00] not ok 2 so_rcvbuf.udp_ipv6.rmem_max
# 0.02 [+0.00] # FAILED: 0 / 2 tests passed.
# 0.02 [+0.00] # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: net: so_rcvbuf # exit=1
-- 
pw-bot: cr

