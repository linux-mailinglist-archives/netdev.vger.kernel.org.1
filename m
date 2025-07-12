Return-Path: <netdev+bounces-206285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF61BB0279B
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 01:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD2E1CA7E72
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 23:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED58E22259D;
	Fri, 11 Jul 2025 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W58MlX5q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B887278F29;
	Fri, 11 Jul 2025 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752276305; cv=none; b=i6LBPq2TtUmQiVO2Gpayexo8UdYNVwxGT6yX+hxjCnVv2RoAMQhvFj4Qn7wqT+MbsP3SnhHHA3pAeQNMP3gPxS6lBPHwb1bo8fof/mH8/P1az1fa2Ru9wKvhAdX1ckmZUpir2RAbjD02ZWJwkGlLtosKLcGNQ9541N/x+1NP6QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752276305; c=relaxed/simple;
	bh=vMLtFCdICfTN1Condfc7E9QY9mFJNQlI7K/JFEES5j8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/bm/nLjyRCAnjq6S4dig7MrNwrEbH70vdQvMAnuThSdsaoJwYz0rM0gU5EE24YkIW44jnCyBWn7SDezAtkEQ4e8X6tT3bCw51XeqogsnZycXs2YU5LkT9//CGGAvOdT17QQegNmy2TgyywGzpJHynxeD0OzVg48FiZt20GM+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W58MlX5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE7FC4CEED;
	Fri, 11 Jul 2025 23:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752276305;
	bh=vMLtFCdICfTN1Condfc7E9QY9mFJNQlI7K/JFEES5j8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W58MlX5qy+ArhVhSCE6NBm7fHsoetPtCc+/n5OsuWUbu8uSmy+VjAPy4SLDi3FbZG
	 MD/Brbtg0UgbkxZexLCCBQ/fWgdAzVBGq+e3zGJd2Pyobr1ATTd4IMpMDi8SYFlEmk
	 1D4Ozx8kCZ7zLu/dJ/J/xRA8NhApguYmpjsrGkzeck0Q/hI0t+tVu2gx/DsTfuCJd4
	 uCZkNJOACKdJ728jVmh7idCx6Q90aDN1fCXiKmj847a7XECJ8RqmgBLzGg3TmsEGzG
	 D70khIFVozNoMRbrWyOvBWVb87QEilm56Hn0GPtzwgLcII+KkE7/zbMxTbkNL2c425
	 Anjogk0IzQuZA==
Date: Fri, 11 Jul 2025 16:25:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeed@kernel.org>, Gal Pressman
 <gal@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jonathan Corbet
 <corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 2/3] net/mlx5e: Add device PCIe congestion
 ethtool stats
Message-ID: <20250711162504.2c0b365d@kernel.org>
In-Reply-To: <1752130292-22249-3-git-send-email-tariqt@nvidia.com>
References: <1752130292-22249-1-git-send-email-tariqt@nvidia.com>
	<1752130292-22249-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 09:51:31 +0300 Tariq Toukan wrote:
> +   * - `pci_bw_inbound_high`
> +     - The number of times the device crossed the high inbound pcie bandwidth
> +       threshold. To be compared to pci_bw_inbound_low to check if the device
> +       is in a congested state.
> +       If pci_bw_inbound_high == pci_bw_inbound_low then the device is not congested.
> +       If pci_bw_inbound_high > pci_bw_inbound_low then the device is congested.
> +     - Tnformative

The metrics make sense, but utilization has to be averaged over some
period of time to be meaningful. Can you shad any light on what the
measurement period or algorithm is?

> +	changes = cong_event->state ^ new_cong_state;
> +	if (!changes)
> +		return;

no risk of the high / low events coming so quickly we'll miss both?
Should there be a counter for "mis-firing" of that sort?
You'd be surprised how long the scheduling latency for a kernel worker
can be on a busy server :(

> +	cong_event->state = new_cong_state;
> +
> +	if (changes & MLX5E_INBOUND_CONG) {
> +		if (new_cong_state & MLX5E_INBOUND_CONG)
> +			cong_event->stats.pci_bw_inbound_high++;
> +		else
> +			cong_event->stats.pci_bw_inbound_low++;
> +	}
> +
> +	if (changes & MLX5E_OUTBOUND_CONG) {
> +		if (new_cong_state & MLX5E_OUTBOUND_CONG)
> +			cong_event->stats.pci_bw_outbound_high++;
> +		else
> +			cong_event->stats.pci_bw_outbound_low++;
> +	}

