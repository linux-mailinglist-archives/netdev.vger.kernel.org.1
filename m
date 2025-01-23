Return-Path: <netdev+bounces-160598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EB1A1A784
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0C916A0ED
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B77A3DBB6;
	Thu, 23 Jan 2025 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaxL9e2I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0677D1EF01
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648286; cv=none; b=MMkXvttJGtZA75xnbBItuI+nzL89/8wTPFdVRU6yIt9vUzz+X21jeVd6AqI06eor5c/lUSgq0FQF93hNtNoklUUObXd0tA5P04hyjT4n3LeVyawKrEO+eL4dpCUw81jlS/7uHpbrsoaZ4aov3HXBZHRhc2W8i809GdtmDRz9FNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648286; c=relaxed/simple;
	bh=WtkDiYZN/3wqjuHg4hXRWO+GXgNk82MhxvRPrtDR3TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mM++krYIKokFeKQPMKP7krQH2KtHV1I9OdTWKP/e4xoT0cUCd62Q/UJqmB6/c59+r5X7pHHL+U1NHu4mxSLFAjMrSxE3riScWrpw8E1LCldQ7SL+YlBS2PPinZIBFS6uzQ2bxERzS6MZ42hD2gWWl0u1ExS3H/WcW8YeqohlSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaxL9e2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38755C4CED3;
	Thu, 23 Jan 2025 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737648285;
	bh=WtkDiYZN/3wqjuHg4hXRWO+GXgNk82MhxvRPrtDR3TQ=;
	h=Date:From:To:Cc:Subject:From;
	b=IaxL9e2IY745JJG0q6i3UH8yyrXwxRBC5ceDMo4PXVM8NZD42bqe4sEWXo7DhKzJ6
	 y4TLGBAqWAiPwWLLOH9d+7sW6YJfx7iokrf9XCmzBfR6mTsMPuNJuPvE/07x0kk0Ob
	 qfqUTDgdyP+dt1PX4r2FaKb5lyy3JoBLNYA0DZ+MABK63fR6e2yYBMipG3kFX63rmA
	 LhYMstuv7Qi055IO9YFoukT5MyaZgnj5bKhBtygdIgSJvjY947kZLWvq9vyuEghfxA
	 0rnwl2fMI4yzANACqDsiKBq/PyHPUH9KeSqoOuWd3LN6DP7GsL39FIFfaCcyBDhmLL
	 qhjd7p1un/WmA==
Date: Thu, 23 Jan 2025 08:04:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, fw@strlen.de
Subject: [TEST] nft-flowtable-sh flaking after pulling first chunk of the
 merge window
Message-ID: <20250123080444.4d92030c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Could be very bad luck but after we fast forwarded net-next yesterday
we have 3 failures in less than 24h in nft_flowtabl.sh:

https://netdev.bots.linux.dev/contest.html?test=nft-flowtable-sh

# FAIL: flow offload for ns1/ns2 with masquerade and pmtu discovery : original counter  2113852 exceeds expected value 2097152, reply counter  60
https://netdev-3.bots.linux.dev/vmksft-nf/results/960740/11-nft-flowtable-sh/stdout

# FAIL: flow offload for ns1/ns2 with masquerade and pmtu discovery : original counter  3530493 exceeds expected value 3478585, reply counter  60
https://netdev-3.bots.linux.dev/vmksft-nf/results/960022/10-nft-flowtable-sh/stdout

# FAIL: dscp counters do not match, expected dscp3 and dscp0 > 0 but got  1431 , 0 
https://netdev-3.bots.linux.dev/vmksft-nf/results/960740/11-nft-flowtable-sh-retry/stdout


