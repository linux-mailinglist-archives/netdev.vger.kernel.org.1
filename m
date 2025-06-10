Return-Path: <netdev+bounces-196358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBC2AD4604
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8F217B23B
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DC8278754;
	Tue, 10 Jun 2025 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEY4l/pC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6394269B01;
	Tue, 10 Jun 2025 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594872; cv=none; b=jGLTznC8xY9iN+fClj5bOqyjqjSocs+YZmgcF6lCJnJzCPA1wi8Wpw5kidH/LMHblQ9Xnwr0NeJyfBV86g1PzS1dJW6fhMeigW2ZfEbhUJQujJ6FtsyzNljCtJjn4JL1VuNEIPdWrMDCHk2iTPnsjMGriaRL4IsjZ6FzuLDM/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594872; c=relaxed/simple;
	bh=tXbDG69pqssgcGg4iB0p/RaU/dHtIZh4hPHnxu2hRoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8cVhP8u133t+XeEVryErnw3/6rV+/ttvtWXKaJ2KKvuAIxK3UhQXmRjvFoVtkYOuuWNFN/84dsefMbmtiI2I8704quYuy4zaxfy5hWO9hQ1+DEkjx/l5eYkcDgGBwNh0no4geDXS7NexxgjuAbfRF+ArY1S++mMFNGfLnHXxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEY4l/pC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CC1C4CEED;
	Tue, 10 Jun 2025 22:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749594871;
	bh=tXbDG69pqssgcGg4iB0p/RaU/dHtIZh4hPHnxu2hRoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oEY4l/pCZ/oxiNa4jR/eK0R4GqrZifkAS3m83DiLTkUxjwZ/nFzvEHz9V/Vpawfbg
	 hBA6wg03dfXVhFS8KzglagkrxCc3m5VNBdFgNoW/ZoRm4+0AVB07gYw0ybgA+m0DMl
	 Um8hl+BAR3u18vKkgPxkG7/x+PNZGiFfdL729awIH6pSARSutkvQejq3yb+25ch9JB
	 SXjK4OkHekibY4OF7p5Sv2xzDe39u+P8zC+FAHOZu7rVfIwKEWMGRD0w5/JIb8Ozja
	 tXuEeu9eWnR2tSbfbH+sHjjJEb1pLWvKeeevYyarnwbL420CMJr0LCtHIzW/aVwuKe
	 4dczQf8pYUNVw==
Date: Tue, 10 Jun 2025 15:34:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, David Ahern <dsahern@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH RESEND net-next] net: tcp: tsq: Convert from tasklet to
 BH workqueue
Message-ID: <20250610153429.0f098b07@kernel.org>
In-Reply-To: <aEdIXQkxiORwc5v4@slm.duckdns.org>
References: <aEdIXQkxiORwc5v4@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 10:47:25 -1000 Tejun Heo wrote:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.

Could you rebase on latest net-next? Doesn't seem to apply:

Applying: net: tcp: tsq: Convert from tasklet to BH workqueue
error: patch failed: net/ipv4/tcp_output.c:1164
error: net/ipv4/tcp_output.c: patch does not apply
Patch failed at 0001 net: tcp: tsq: Convert from tasklet to BH workqueue
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
-- 
pw-bot: cr

