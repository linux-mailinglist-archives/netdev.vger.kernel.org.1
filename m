Return-Path: <netdev+bounces-227502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D72BB15AA
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 19:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCE016EC77
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0FC2D3739;
	Wed,  1 Oct 2025 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3eBw3tm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8929BDBF
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759339345; cv=none; b=H1GTocVePHhWEe91X2MHckEyqXjiCGvcYULWHuMmjgEpUK1x41x0Fx1oy59pJsib+O4I9qhCzoGjMBbM+SLbI4uNF0eBqI0ti8aL9ko9gaeIxCAs8xSDlpGyFcJF5hM2kq2o2HloBPuS97lru6YV5AdmrK7yMjcP/0RqRG83TVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759339345; c=relaxed/simple;
	bh=er5fdosOTkZo6aWK98DMQCF7XfdpT0QQLYFvimi3dB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bv5ubzc88YQcY1E8a6OnJccZAU1tv3pKgxl6R4lEO7Q49kRmL1YajJySjeIgvAgBQXlRkPOKuO6PJEickTR9v8lgW/svdoYBPqhmU0WrPiQCAsr033xZwFRTqplLgrqqnqsREXO1qYXZgH/WJgvl7b0xh/JinEkTvG552EfuwG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3eBw3tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB704C4CEF7;
	Wed,  1 Oct 2025 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759339344;
	bh=er5fdosOTkZo6aWK98DMQCF7XfdpT0QQLYFvimi3dB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b3eBw3tmH2aas4v7vZXH1nSWh1OOW3QOjAtHa2G+lVdxQhTCx/uZIiJxum5JhUOPc
	 eD5yQbA87+LGwHCz4/WjlDLDmj6jR94H4++fvqWhH9rThfB2M1SPpG7ksRHoBD9h3g
	 SAs1IRUz6RKWL8mQfyC8NksL/3wh7fBv5kSSI/tCRE7yBbN8D3ApKHs9OnEujVJMI0
	 d5dNcrSj2Pb8/zNr0nOU8B/QaFsel2ZWTh56HW9pTrcNFyAQCoV6akZbAL96bj6B8z
	 1mOftIZXFxRCB10233PHA2LlOzL8YWhD51Ld9JW7SmZMA1It0kM3BYxRN0TX0ixIHN
	 Hs8MiwkzSM+nw==
Date: Wed, 1 Oct 2025 10:22:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org
Subject: Re: deadlocks on pernet_ops_rwsem
Message-ID: <20251001102223.1b8e9702@kernel.org>
In-Reply-To: <3a8ba87f-a6ab-4523-b0ce-8e9dbd5a923b@redhat.com>
References: <20251001082036.0fc51440@kernel.org>
	<3a8ba87f-a6ab-4523-b0ce-8e9dbd5a923b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Oct 2025 18:46:16 +0200 Paolo Abeni wrote:
> Not many here. The above are debug builds, so we should get a lockdep
> splat on deadlock, the logs lack it. I guess the request_module() breaks
> the lockdep checks?

To be clear -- AFAICT lockdep misses this.

The splat is from the "stuck task" checker. 

2 min wait to load a module during test init would definitely be a sign
of something going sideways.. but I think it's worse than that, these
time out completely and we kill the VM. I think the modprobe is truly
stuck here.

In one of the splats lockdep was able to say:

[ 4302.448228][   T44] INFO: task modprobe:31634 <writer> blocked on an rw-semaphore likely owned by task kworker/u16:0:12 <reader>

but most are more useless:

[ 4671.090728][   T44] INFO: task modprobe:2342 is blocked on an rw-semaphore, but the owner is not found.

(?!?)

