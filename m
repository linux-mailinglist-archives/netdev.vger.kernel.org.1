Return-Path: <netdev+bounces-155403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE18A02354
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389963A49D3
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4961DC1A2;
	Mon,  6 Jan 2025 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abI/2IcL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E071DC198
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736160289; cv=none; b=EBkK5LFtf5Aw1+3/Yj+3LamGozsQUhyuHarJIk2Ow9I56XWgnxrMpRH0TA55G+0kpClL6S2D9WeAoZ7u8K9rpYFdsFjmLKKBQegwfcwQpu8SadKHuPwDPfvLgKFpr43tUNM3dLiSkJpNhqRK2ABcHPMGQs7R1GMwrR2PM+PxLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736160289; c=relaxed/simple;
	bh=AWEemNc0raKKH2Kwou+f+1lTew6hT8lUQDDjqNXpkYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYj9fqjM/DDlHBymxfAjBq7u3GTmjcAMd+qpU0z4qHHCXsXin2Iar+cIlihZcB+CU0lcJHrWl0x4DjWNo/KWYdqgR3xroFok/0zItl6OIUludIxvotTJkzsjh1wFBKXQkRFdYNVIT1r9G3HIp3CnBWCv9nuaDK5EtdALm1I+4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abI/2IcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB27BC4CEE0;
	Mon,  6 Jan 2025 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736160289;
	bh=AWEemNc0raKKH2Kwou+f+1lTew6hT8lUQDDjqNXpkYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abI/2IcLyUSdp0uLJFdfrPKPqudyuCYfQ8X6peVfNIrIif9rlaUa7do2SrtSpDuQw
	 VdVFMNfsb+0bfqSyfziDL6Pdk6qRuL6gIV9yCPoMV6QvyC/tb5Sko15cYe2Lhu1P0i
	 yJutXWyXaFRwQhLQ5zNbWakgbV75wgZLdQi/gw06prOr79RGH8CYs/wrOlFdZmX55x
	 MczEgi3g0+lo/5OYsxTXKiR+rkEoNYVG4o3X3ns0wgjI0K0WA58rs0MnIPDX5hJiPU
	 K/OHEFINy7iSYm6CqkchLdoIN25A04DG3TyfW8MfQonoZ/jnLI/ZOmauhc5Fz7MZe9
	 rY+yG9R9iz1mg==
Date: Mon, 6 Jan 2025 10:44:44 +0000
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	larysa.zaremba@intel.com, decot@google.com, willemb@google.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	aleksander.lobakin@intel.com
Subject: Re: [PATCH iwl-net v2] idpf: fix transaction timeouts on reset
Message-ID: <20250106104444.GB4068@kernel.org>
References: <20241220020932.32545-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220020932.32545-1-emil.s.tantilov@intel.com>

On Thu, Dec 19, 2024 at 06:09:32PM -0800, Emil Tantilov wrote:
> Restore the call to idpf_vc_xn_shutdown() at the beginning of
> idpf_vc_core_deinit() provided the function is not called on remove.
> In the reset path the mailbox is destroyed, leading to all transactions
> timing out.
> 
> Fixes: 09d0fb5cb30e ("idpf: deinit virtchnl transaction manager after vport and vectors")
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
> Changelog:
> v2:
> - Assigned the current state of REMOVE_IN_PROG flag to a boolean
>   variable, to be checked instead of reading the flag twice.
> - Updated the description to clarify the reason for the timeouts on
>   reset is due to the mailbox being destroyed.
> 
> v1:
> https://lore.kernel.org/intel-wired-lan/20241218014417.3786-1-emil.s.tantilov@intel.com/
> 
> Testing hints:
> echo 1 > /sys/class/net/<netif>/device/reset

Thanks for the update,

Reviewed-by: Simon Horman <horms@kernel.org>


