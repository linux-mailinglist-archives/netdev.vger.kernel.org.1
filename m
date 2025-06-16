Return-Path: <netdev+bounces-198067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DCCADB256
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5483A7B62
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D16481B6;
	Mon, 16 Jun 2025 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hY6Qgzwe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A482BF00A
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081165; cv=none; b=PP9XIHcKpxUxJ73nnjD8+P7XHgvS24Venpy7F3CYBOf8qEwXrrYUdYsqBRe+ylzix4ktpryEcftNUek9sCdT1L21wE9GEWy4F+q3bVTsp5sc9pI+h09vh0hGZ2GEMignBh61tTOZj0lQ0eq7zeYjIJ2Euu4jYNJP3bVefqi0UZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081165; c=relaxed/simple;
	bh=7Rn9RGS4F27Q/MXmSeZffCnecIuiABWL+IKE3Qg9N1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoAloUf5YMfNo6WvlOp6QGsa+yFlqs9ZjZCHfk2h+L6oATVTV5MNDu8UDcli9qod8i3BkqR+gin6RcOZSrOeKc8825A7c3gTukh2aeSrGjeFEooG25FympWnnPZw6+0S90wnZkIb4rRQXtEKYtYxPR5NXvaKSUti7RVzPLM0xRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hY6Qgzwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC223C4CEEA;
	Mon, 16 Jun 2025 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750081165;
	bh=7Rn9RGS4F27Q/MXmSeZffCnecIuiABWL+IKE3Qg9N1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hY6QgzweUwP5p5Q0drWe8vNqEjX8dLlfcvA6LuQwWhP4P0ANjS7wwCWW9XuZWPEZp
	 xmbiE4K0/GbtpJJKwoD/LOYiYriSLPZfe23GFoSWZGrxR4c1zvijjHzVps3Uf94+83
	 A9nM7N+QmVkzZ2c2kDIgl5CoCPjOiAF+rRfFUjwY7qh2T7QpTMpb0nOlLgsB3gcC/i
	 rwoCO5CuOO9SXrT5N4rV0MwA/SLJQkBUStiNLN04mElZEFr/8FM6NsEcUlirtcE/Gz
	 EyJMd7Y+gRHrgl4/FxLfn2isFeYZlpGSTSg7D5I6rRGdfZZMlrcVQU+4lsl5ujNXAX
	 Q2ixZUi6oXhrQ==
Date: Mon, 16 Jun 2025 14:39:21 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net 1/3] bnxt_en: Fix double invocation of
 bnxt_ulp_stop()/bnxt_ulp_start()
Message-ID: <20250616133921.GB6187@horms.kernel.org>
References: <20250613231841.377988-1-michael.chan@broadcom.com>
 <20250613231841.377988-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613231841.377988-2-michael.chan@broadcom.com>

On Fri, Jun 13, 2025 at 04:18:39PM -0700, Michael Chan wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> Before the commit under the Fixes tag below, bnxt_ulp_stop() and
> bnxt_ulp_start() were always invoked in pairs.  After that commit,
> the new bnxt_ulp_restart() can be invoked after bnxt_ulp_stop()
> has been called.  This may result in the RoCE driver's aux driver
> .suspend() method being invoked twice.  The 2nd bnxt_re_suspend()
> call will crash when it dereferences a NULL pointer:
> 
> (NULL ib_device): Handle device suspend call
> BUG: kernel NULL pointer dereference, address: 0000000000000b78
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP PTI
> CPU: 20 UID: 0 PID: 181 Comm: kworker/u96:5 Tainted: G S                  6.15.0-rc1 #4 PREEMPT(voluntary)
> Tainted: [S]=CPU_OUT_OF_SPEC
> Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/17/2017
> Workqueue: bnxt_pf_wq bnxt_sp_task [bnxt_en]
> RIP: 0010:bnxt_re_suspend+0x45/0x1f0 [bnxt_re]
> Code: 8b 05 a7 3c 5b f5 48 89 44 24 18 31 c0 49 8b 5c 24 08 4d 8b 2c 24 e8 ea 06 0a f4 48 c7 c6 04 60 52 c0 48 89 df e8 1b ce f9 ff <48> 8b 83 78 0b 00 00 48 8b 80 38 03 00 00 a8 40 0f 85 b5 00 00 00
> RSP: 0018:ffffa2e84084fd88 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> RDX: 0000000000000000 RSI: ffffffffb4b6b934 RDI: 00000000ffffffff
> RBP: ffffa1760954c9c0 R08: 0000000000000000 R09: c0000000ffffdfff
> R10: 0000000000000001 R11: ffffa2e84084fb50 R12: ffffa176031ef070
> R13: ffffa17609775000 R14: ffffa17603adc180 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffa17daa397000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000b78 CR3: 00000004aaa30003 CR4: 00000000003706f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> bnxt_ulp_stop+0x69/0x90 [bnxt_en]
> bnxt_sp_task+0x678/0x920 [bnxt_en]
> ? __schedule+0x514/0xf50
> process_scheduled_works+0x9d/0x400
> worker_thread+0x11c/0x260
> ? __pfx_worker_thread+0x10/0x10
> kthread+0xfe/0x1e0
> ? __pfx_kthread+0x10/0x10
> ret_from_fork+0x2b/0x40
> ? __pfx_kthread+0x10/0x10
> ret_from_fork_asm+0x1a/0x30
> 
> Check the BNXT_EN_FLAG_ULP_STOPPED flag and do not proceed if the flag
> is already set.  This will preserve the original symmetrical
> bnxt_ulp_stop() and bnxt_ulp_start().
> 
> Also, inside bnxt_ulp_start(), clear the BNXT_EN_FLAG_ULP_STOPPED
> flag after taking the mutex to avoid any race condition.  And for
> symmetry, only proceed in bnxt_ulp_start() if the
> BNXT_EN_FLAG_ULP_STOPPED is set.
> 
> Fixes: 3c163f35bd50 ("bnxt_en: Optimize recovery path ULP locking in the driver")
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Co-developed-by: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


