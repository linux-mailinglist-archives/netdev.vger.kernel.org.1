Return-Path: <netdev+bounces-99230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9768D429B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9451F1F210E7
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521ACD520;
	Thu, 30 May 2024 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2fiHZIq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBCB8814
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030643; cv=none; b=AzXEdMzp94XTWoCrZq/+dRG/0wo071bwQJGBO5FB5IWWc6WUpzXlm4bahszUSUzxXorDvcp/GnzL/cU1lTuDGd7ROv9OmmDXck5MSLPXqk5KU1IyVfbwi9Oc7ija7j65veW3lcyQkNc07A84pM0f2KOm37uP3HqKg6dPQTg6VOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030643; c=relaxed/simple;
	bh=U9/AMUbtFR2LURelgagaDnE4n0+k8EdWfnxvSe5JpD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xq2G8AIovzHTx9vD5gg/t9v6u8fgRWrlZQuY/b0aPp87ypOBPaHtZYmNXipI3HixlB1tKAROraIHodexYnvqCEkchCCLWih8YjqKya9+xr+5R4MiETfDp4jBwzCZxPUVRUjOQYl1e9mk+t0qPsh1U5UYIjKtWwOj8hXGF0URQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2fiHZIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F2CC113CC;
	Thu, 30 May 2024 00:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717030642;
	bh=U9/AMUbtFR2LURelgagaDnE4n0+k8EdWfnxvSe5JpD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i2fiHZIqxiwJBx8d9+20ydB6zyrb6cZyxD40YYDgPdhuwAShADxCItJjMO7/3GpIT
	 kK8oWzIOdfOGl52Q59WsPWRTfDP64+v5XwUjxDPtIQPxMzSH+Y1KWs2pyi9FSsu9dq
	 gehiQZVdpN8BlrKMcDCAa3ISEWXoomnDCB98O5otNRtWBL4GNdYLTrUTGsyAc4ZNyI
	 f/C1VN1nVp62RZvykoPMR1qvRctm4VfyAx2KVHy7zwSQeZbTz8pPJ0N+C6gFt91zY0
	 934ilvrHc5BrgS4wdHaKPPLPS+NBdwdpB8ZUc/LgzZjrd/6sn+0dSgU76yTnKWcdPE
	 ZlpQnuxpd/E4g==
Date: Wed, 29 May 2024 17:57:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthias Stocker <mstocker@barracuda.com>
Cc: doshir@vmware.com, pv-drivers@vmware.com, netdev@vger.kernel.org
Subject: Re: [PATCH] vmxnet3: disable rx data ring on dma allocation failure
Message-ID: <20240529175721.1e07b506@kernel.org>
In-Reply-To: <20240528100615.30818-1-mstocker@barracuda.com>
References: <20240528100615.30818-1-mstocker@barracuda.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 12:06:15 +0200 Matthias Stocker wrote:
> When vmxnet3_rq_create fails to allocate memory for the data ring,
> vmxnet3_rq_destroy_all_rxdataring is called, but rq->data_ring.desc_size
> is not zeroed, as is the case when adapter->rxdataring_enabled is set to
> false. This leads to the box crashing a short time later with a
> NULL pointer dereference in memcpy.

That's not much of an explanation, more of restating what the logs say.
I can't spot the bug in the existing code after looking at this for
10min. Please provide a proper explanation.

> [1101376.713751] vmxnet3 0000:13:00.0 dhcp: rx data ring will be disabled
> [1101376.719942] vmxnet3 0000:13:00.0 dhcp: intr type 3, mode 0, 3 vectors allocated
> [1101376.721085] vmxnet3 0000:13:00.0 dhcp: NIC Link is Up 10000 Mbps
> [1101377.020907] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [1101377.023396] #PF: supervisor read access in kernel mode
> [1101377.025172] #PF: error_code(0x0000) - not-present page
> [1101377.026966] PGD 115a58067 P4D 115a58067 PUD 115a55067 PMD 0
> [1101377.028930] Oops: 0000 [#1] SMP NOPTI
> [1101377.033776] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [1101377.037316] RIP: 0010:__memcpy+0x12/0x20

Grrr.. Looks like you hid the kernel version. Are you sure your kernel 
has commit 6f4833383e85 ("net: vmxnet3: Fix NULL pointer dereference in
vmxnet3_rq_rx_complete()") ?
-- 
pw-bot: cr

