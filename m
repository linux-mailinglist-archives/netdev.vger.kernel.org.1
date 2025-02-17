Return-Path: <netdev+bounces-167047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A1AA388E6
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85166188265A
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8608E3E499;
	Mon, 17 Feb 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/yCHTC2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B83DDBE
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808605; cv=none; b=X50v0W/e83qWZoCFfkMnUWEgRvEJ6ZWePcmQwr815jN2kPhQX3laQ8RffASo5RzWoDqVOHIP7B22M7RyH4NAV+k8MNZVgsFXWIRxHtQmWDGTEbfKSFOKNy1IvdHvfbAVCmJSRkQbndDlJ4ikuHq3Bg2VmGLMgcyoPVZOWgjMgCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808605; c=relaxed/simple;
	bh=fxMtjqq2y522EKxJTwIX5041g1t62k1/SxcaP2TOTo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stjbUNPIQjzmWqaSkuAPZ+EX55EDO+ziiTTvBSHez7J2r2IERl2YoJ28d9YA+Nwucq5z7fiBVPT5Y65EO6A01+FG9SZxvqDmzogFx8CTZ6djPPenxy5HpeyupV/0aVto7tgKHsq9r4StBGo8eJnOwGab9RLINiF9WeqPWenFOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/yCHTC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FC2C4CED1;
	Mon, 17 Feb 2025 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739808604;
	bh=fxMtjqq2y522EKxJTwIX5041g1t62k1/SxcaP2TOTo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/yCHTC22CTimrFYu6HKGe++xewZP9jU0BcSEB5vauEsEUM+irae37d+65En64U3P
	 peccNTSg34qm5w3v7k+eQScE4sjp5XO5jbFOMFZiBp2TAWV9Xp/1GmFTI7DNkKjNZT
	 Ux7Ud1LGKakbho4PC/xk1RqIinV1h6h0kddyvDsG9IFUtnGV669QCK02aABXffxloI
	 8sgKqxrcOINwv/xZbqLrxWi+jegoXNOoeFErgkSiRV7U2HUZJyR3h3iZXFeyIjUDbk
	 VZq7QJg6yJ4pGHVxTb+rnthhYMDRdPqI30bfpXqvDstXiPnm3rXy0nJLg4RZqesTMh
	 JWayDnNVRDH5Q==
Date: Mon, 17 Feb 2025 16:10:01 +0000
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
	nick.child@ibm.com
Subject: Re: [PATCH net] ibmvnic: Don't reference skb after sending to VIOS
Message-ID: <20250217161001.GN1615191@kernel.org>
References: <20250214155233.235559-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214155233.235559-1-nnac123@linux.ibm.com>

On Fri, Feb 14, 2025 at 09:52:33AM -0600, Nick Child wrote:
> Previously, after successfully flushing the xmit buffer to VIOS,
> the tx_bytes stat was incremented by the length of the skb.
> 
> It is invalid to access the skb memory after sending the buffer to
> the VIOS because, at any point after sending, the VIOS can trigger
> an interrupt to free this memory. A race between reading skb->len
> and freeing the skb is possible (especially during LPM) and will
> result in use-after-free:
>  ==================================================================
>  BUG: KASAN: slab-use-after-free in ibmvnic_xmit+0x75c/0x1808 [ibmvnic]
>  Read of size 4 at addr c00000024eb48a70 by task hxecom/14495
>  <...>
>  Call Trace:
>  [c000000118f66cf0] [c0000000018cba6c] dump_stack_lvl+0x84/0xe8 (unreliable)
>  [c000000118f66d20] [c0000000006f0080] print_report+0x1a8/0x7f0
>  [c000000118f66df0] [c0000000006f08f0] kasan_report+0x128/0x1f8
>  [c000000118f66f00] [c0000000006f2868] __asan_load4+0xac/0xe0
>  [c000000118f66f20] [c0080000046eac84] ibmvnic_xmit+0x75c/0x1808 [ibmvnic]
>  [c000000118f67340] [c0000000014be168] dev_hard_start_xmit+0x150/0x358
>  <...>
>  Freed by task 0:
>  kasan_save_stack+0x34/0x68
>  kasan_save_track+0x2c/0x50
>  kasan_save_free_info+0x64/0x108
>  __kasan_mempool_poison_object+0x148/0x2d4
>  napi_skb_cache_put+0x5c/0x194
>  net_tx_action+0x154/0x5b8
>  handle_softirqs+0x20c/0x60c
>  do_softirq_own_stack+0x6c/0x88
>  <...>
>  The buggy address belongs to the object at c00000024eb48a00 which
>   belongs to the cache skbuff_head_cache of size 224
> ==================================================================
> 
> Fixes: 032c5e82847a ("Driver for IBM System i/p VNIC protocol")
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

