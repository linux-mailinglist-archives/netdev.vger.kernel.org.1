Return-Path: <netdev+bounces-214374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0802B29340
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 15:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B412B7AC554
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 13:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24CF23535A;
	Sun, 17 Aug 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hhxb5e/u"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA6231837
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755436903; cv=none; b=cMfzm03K0DXV1rxqzuBPQUahlhlTkRTo1q01TvtB/HgvaS+dWg1euadIiFSPVvuKcBd2R+64zRMw/Q0cMypK+Ds4WBvuynhw/pSUuvCavIUFDhA5Mq5jv/46DbQUY3+PkHvz4LMAKly0/cgPIGxS9U05I1Hv8wbsY0VERo9nMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755436903; c=relaxed/simple;
	bh=3B+kmrd4jYRYn2N73Je4ldxiXSMnA0JfnGMXJqqAxe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGSctTSm0fhsRkeM0UaZiu6KTrJiHvDmd3BmpqltFvU/TjXLGlWd1JLQN9yUzBCdljX2BRky+Zz9wYpBDPprgxDkHTsVeaaZlgH3nROWTfBV6xo9dxqg/pPFH1Be3k83Qi/oVixdfR/x2NU9sYAopKy142OhmGqBuje/cYicC5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hhxb5e/u; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bd92c1b7-a358-4737-8f23-30b185cbb8ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755436897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoVTQA9/Q+2PJbsblSCEsOeGvXZ6h1tCSUZbUSnPe0w=;
	b=Hhxb5e/uEIsg1iigMFmesZSxQl7HExuKBVxASs7eDZPAB/vvOowAD3bCgCyVmKs8kMbOmJ
	w/VnY8GSWO+RS/fD2btEfhXPA7vze0hPyrJlSouPdOKz+m5ol7RRt974+0n7/oS4gxYzjm
	AMcBihkIZwudwYoYPBM23VoJiVeNSzA=
Date: Sun, 17 Aug 2025 14:21:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] bnxt_en: Fix lockdep warning during rmmod
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, sdf@fomichev.me
References: <20250816183850.4125033-1-michael.chan@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250816183850.4125033-1-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16.08.2025 19:38, Michael Chan wrote:
> The commit under the Fixes tag added a netdev_assert_locked() in
> bnxt_free_ntp_fltrs().  The lock should be held during normal run-time
> but the assert will be triggered (see below) during bnxt_remove_one()
> which should not need the lock.  The netdev is already unregistered by
> then.  Fix it by calling netdev_assert_locked_or_invisible() which will
> not assert if the netdev is unregistered.
> 
> WARNING: CPU: 5 PID: 2241 at ./include/net/netdev_lock.h:17 bnxt_free_ntp_fltrs+0xf8/0x100 [bnxt_en]
> Modules linked in: rpcrdma rdma_cm iw_cm ib_cm configfs ib_core bnxt_en(-) bridge stp llc x86_pkg_temp_thermal xfs tg3 [last unloaded: bnxt_re]
> CPU: 5 UID: 0 PID: 2241 Comm: rmmod Tainted: G S      W           6.16.0 #2 PREEMPT(voluntary)
> Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
> Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/17/2017
> RIP: 0010:bnxt_free_ntp_fltrs+0xf8/0x100 [bnxt_en]
> Code: 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 48 8b 47 60 be ff ff ff ff 48 8d b8 28 0c 00 00 e8 d0 cf 41 c3 85 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffa92082387da0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff9e5b593d8000 RCX: 0000000000000001
> RDX: 0000000000000001 RSI: ffffffff83dc9a70 RDI: ffffffff83e1a1cf
> RBP: ffff9e5b593d8c80 R08: 0000000000000000 R09: ffffffff8373a2b3
> R10: 000000008100009f R11: 0000000000000001 R12: 0000000000000001
> R13: ffffffffc01c4478 R14: dead000000000122 R15: dead000000000100
> FS:  00007f3a8a52c740(0000) GS:ffff9e631ad1c000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055bb289419c8 CR3: 000000011274e001 CR4: 00000000003706f0
> Call Trace:
>   <TASK>
>   bnxt_remove_one+0x57/0x180 [bnxt_en]
>   pci_device_remove+0x39/0xc0
>   device_release_driver_internal+0xa5/0x130
>   driver_detach+0x42/0x90
>   bus_remove_driver+0x61/0xc0
>   pci_unregister_driver+0x38/0x90
>   bnxt_exit+0xc/0x7d0 [bnxt_en]
> 
> Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> v2: Use netdev_assert_locked_or_invisible()
> 
> v1: https://lore.kernel.org/netdev/20250815170823.4062508-1-michael.chan@broadcom.com/
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 2800a90fba1f..207a8bb36ae5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -5332,7 +5332,7 @@ static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool all)
>   {
>   	int i;
>   
> -	netdev_assert_locked(bp->dev);
> +	netdev_assert_locked_or_invisible(bp->dev);
>   
>   	/* Under netdev instance lock and all our NAPIs have been disabled.
>   	 * It's safe to delete the hash table.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

