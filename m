Return-Path: <netdev+bounces-213825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92AB26FCC
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 21:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B541B67E9C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC9F2236E8;
	Thu, 14 Aug 2025 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6XyRnxT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A541991BF;
	Thu, 14 Aug 2025 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755200531; cv=none; b=ULHYsssD6FAREbnTATxLl0Rl2WphXJnXWpeTLGPMnudS457Viej4wHqVnU0lvADjF/GF0bZBt9isPm9yk5hCLZkzwXLMqs9MESX6pfUYw7e0hfd9eBuWrKxTti3Se1u55ba5BYVdKSdsCsFs1aZmOqe0TRbSuwmzl1TwZRVZq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755200531; c=relaxed/simple;
	bh=wgIkCCLOSZxBm+sjKHbdfI7Ycg8w5wvvej9QWz/EziE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQO8HqqsUrPrWlDYEjL7E3hGo/IdaUPuQcerbDnKvTxLEMs4V0Td34af3ozqV7PdMcHWeQmoL3vrLeX2y7lZkjfsC6M+xlklIsG51r+v/kqkpj4vTRSvtLR6Hmss5ORTo+En2OIw1O0E1Hm3dvsz27RTkIpa/6X6sVgMtXpkUTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6XyRnxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1404DC4CEED;
	Thu, 14 Aug 2025 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755200531;
	bh=wgIkCCLOSZxBm+sjKHbdfI7Ycg8w5wvvej9QWz/EziE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t6XyRnxT5tWOqmjl15vSbnIUgRMa6E3sMxJgADUvbXTdtyq1P7gK0xbIP5xLSDyz7
	 FPo6Jv1BCY71WWZ3EWhHHoEZQy5BmHC1unWPAhhi8VNTm8YikBxpCZ6fZpZFpVW799
	 VF8ZR01iFFh3ZVZX4ekHtzTPoiJAJoyxjxshdwzXt/NdI4x10okJhOvmYLqSJRk7su
	 F3Ux9a5yP0+w/dWqlcaXke7JW3HXCCLhEArAx+0qtPmXl96FK3ffLtjUBqS3+p5T3V
	 5kPfhcU3s+m3ZBPVDPmmGap58L6evmNLsA6kaVY292X3DyRfPRli2U1vs/AoW/Qu+8
	 e3M72xsu0MKTQ==
Date: Thu, 14 Aug 2025 12:42:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
Subject: Re: [PATCH net-next 5/5] selftests/net: test ipip packets in gro.sh
Message-ID: <20250814124209.699478a5@kernel.org>
In-Reply-To: <20250814114030.7683-6-richardbgobert@gmail.com>
References: <20250814114030.7683-1-richardbgobert@gmail.com>
	<20250814114030.7683-6-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 13:40:30 +0200 Richard Gobert wrote:
> Add IPIP test-cases to the GRO selftest.
> 
> This selftest already contains IP ID test-cases. They are now
> also tested for encapsulated packets.

The series seems to break the test when running in our CI:

https://netdev-3.bots.linux.dev/vmksft-net/results/253062/25-gro-sh/stdout
https://netdev-3.bots.linux.dev/vmksft-net/results/253062/25-gro-sh-retry/stdout

https://netdev-3.bots.linux.dev/vmksft-net/results/253241/18-gro-sh/stdout
https://netdev-3.bots.linux.dev/vmksft-net/results/253241/18-gro-sh-retry/stdout
-- 
pw-bot: cr

