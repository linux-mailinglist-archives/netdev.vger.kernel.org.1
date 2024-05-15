Return-Path: <netdev+bounces-96500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4FF8C63C3
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 11:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB192814E6
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E77F58AA5;
	Wed, 15 May 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="TSRU48GK"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99E5A0E0
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765723; cv=none; b=gs6crxdLcF7ncBpwqy9mRAcpdPpV1fS8rS9cALuKL2BVih9MuqGNL4befnZgjQv+ahCUrQZs5cNVmeqAa2mjmcL0ktVkvIyhPaBti+FeDzOEXMFT27v8MsMDUwRgUcugqa7sIQBNtWpHhFbzwmsoZVH8TpOzNN+ZBFYezUMlpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765723; c=relaxed/simple;
	bh=irgGQsPBq16ModwGXSDA8nu4SGX8iYA0vyU6UciN8kg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qGm7qeK+r8nCFTQehg41Ixsg+F4GNk1wUcdq/KouHdBQoffiRUIu2tb1X1gCN3DQc8R48CF/bN9ao2R2tH6Ww7Ai9+GTGimCfALefwtdT34H719a5t/d5i189sxQynI/5YdeHpyu6793lZigT2y9Dj0jJ/hHAVpFCNbIaVTtqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=TSRU48GK; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s7B2V-00Gzmr-1w; Wed, 15 May 2024 11:35:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=1t1Hd7cKkwE2rC4FroJaaCHc+KsQeuYesdrL5E7I+VA=; b=TSRU48GKNAFNBfzozMnUBLFrgh
	twAjFN952eO+JATTSnqVvKohNUQTKYU+W7FDIaelMbpfxGuls0iB/3W/PGJ5zsA0k/TPZDEei4H6w
	YWUhDOU8Kp0fvl+5MxbnoteQt7F3Ja3yyodR2zye8KPUqo9lPYp+0IK0It14+ToPO8Y5rabRQGeHZ
	sx4/MkTBKOg3UwxZ5pN3eQ7JfUTgcjNtl+ailDj2H2pDEQI93Zljjm5fc+ZmFWpemxaLgwgGH8lEa
	NVRQG5ZLzeYiKq3nmL+Gw1DCAMeOGiPwCLDnPBCUKZVeGPKtWeENScMd9kd4bfMbx4gTiQ5wPzBc0
	Q2DJJmTQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s7B2U-0003Pq-9v; Wed, 15 May 2024 11:35:10 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s7B2D-00E0ji-NS; Wed, 15 May 2024 11:34:53 +0200
Message-ID: <c6eb5987-4ffa-47cf-a0c7-dcc7b969d2ca@rbox.co>
Date: Wed, 15 May 2024 11:34:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH v5 net 1/2] af_unix: Fix garbage collection of embryos
 carrying OOB/SCM_RIGHTS.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20240515003204.43153-1-kuniyu@amazon.com>
 <20240515003204.43153-2-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20240515003204.43153-2-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/24 02:32, Kuniyuki Iwashima wrote:
> ...
> The python script below [0] sends a listener's fd to its embryo as OOB
> data.  Then, GC does not iterates the embryo from the listener to drop
> the OOB skb's refcount, and the skb in embryo's receive queue keeps the
> listener's refcount.  As a result, the listener is leaked and the warning
> [1] is hit.
> ...

Sorry, this does not convey what I wrote. And I think your edit is
incorrect.

GC starts from the in-flight listener and *does* iterate the embryo; see
scan_children() where scan_inflight() is called for all the embryos.
The skb in embryo's RQ *does not* keep the listener's refcount; skb from RQ
ends up in the hit list and is purged.
It is embryo's oob_skb that holds the refcount; see how __unix_gc() goes
over gc_candidates attempting to kfree_skb(u->oob_skb), notice that `u`
here is a listener, not an embryo.

I understand you're "in rush for the merge window", but would it be okay if
I ask you not to edit my commit messages so heavily?

Thanks,
Michal

