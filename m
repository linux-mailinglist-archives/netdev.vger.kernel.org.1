Return-Path: <netdev+bounces-191103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A2ABA191
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 19:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C727216594A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7525324168A;
	Fri, 16 May 2025 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZvlNgoC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500B126B0AD
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415143; cv=none; b=NKDdtsbFTgYo82f2THHWDdJpxB2PNZXEmcLUD5R6DiVZ81HdrTdYjiyIH/KwPe5cigt/hJURFeXZHjJVloQxcLAULDmDbP+2UN3OxzWrilkNOxBKJOBOLIdszNjsWa0A2Owi3VYIrx9350A2W5v05ptxraQdpfMdWob3fdjss1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415143; c=relaxed/simple;
	bh=3yZIo7O0CqhoDDXn9wGmnfNYRGBryVN2ivhz3+gAty8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=finkvGNX5YEFsaae8AIeDL1l4N2ImtdwunL7N4Y9FXYllknrAgvcVxwo4chz3rvEDbJAe8A5WYAtG6EKIYzG6E3JGcezdlyzs/tXrU6s0QykUbl2rIDUfo3mNU9JNXBx9x9URtsTv0Y4KETcp0jWfoPPhnpAWzRmiv4j0c0nQ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZvlNgoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB456C4CEE4;
	Fri, 16 May 2025 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747415142;
	bh=3yZIo7O0CqhoDDXn9wGmnfNYRGBryVN2ivhz3+gAty8=;
	h=Date:From:To:Subject:From;
	b=VZvlNgoCG7gIR15dPiujrlhqwbeVb6Ip62n7BUrmc2CNr/0zW24AksNt+zf9uxAkW
	 NBVroOshQKlf9hG74lMjXjGj7pE09tHUur16Ys4V8kUFrvM9myXAuE2ZkjHPE6OCT9
	 b+sszE+AVXXnqFhTJ4rRGI6YFQxE4bbctOdQTxvZuVt+H5JiBSHgmoJaSeJfb9zxst
	 tAbPjaj6a1roz3uwjVhr2m206fIZiWcZ/6Hm5gOf/kbPS4U6yVrbk4jDAw+r3H4n9G
	 pUhckiiwwDUux5yvpV+96LFp3Im9nJOGggQvXJxB948ksYC8t3DCKb/gK4/QpQWtnD
	 YBiWygDIrkPig==
Date: Fri, 16 May 2025 10:05:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org
Subject: [TEST]  net/bind_wildcard flakiness
Message-ID: <20250516100542.67c276ec@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bind_wildcard used to be rock solid, no flakes in last 1000 runs,
but then around the time Eric posted his Rx optimizations we hit one
flake, and now we hit another:

List:
https://netdev.bots.linux.dev/contest.html?test=bind-wildcard&executor=vmksft-net&pass=0

Outputs:
https://netdev-3.bots.linux.dev/vmksft-net/results/122022/14-bind-wildcard/stdout
https://netdev-3.bots.linux.dev/vmksft-net/results/123463/14-bind-wildcard/stdout

One does:

# 0.21 [+0.00] # bind_wildcard.c:768:reuseaddr:Expected ret (-1) == 0 (0)
# 0.21 [+0.00] # reuseaddr: Test terminated by assertion
# 0.21 [+0.00] #          FAIL  bind_wildcard.v6_any_only_v6_v4mapped_any.reuseaddr

The other:

# 0.25 [+0.00] # bind_wildcard.c:775:plain:Expected ret (-1) == 0 (0)
# 0.25 [+0.00] # plain: Test terminated by assertion
# 0.25 [+0.00] #          FAIL  bind_wildcard.v6_local_v6_v4mapped_any.plain


The only change on the infra side is that I increased disk IO cap,
so the builds are now faster.

