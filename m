Return-Path: <netdev+bounces-192829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641FEAC1532
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330757A6CDB
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9E22222CE;
	Thu, 22 May 2025 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm5oTbgo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC1148827;
	Thu, 22 May 2025 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944200; cv=none; b=nC70aS4zdPWYaKQ4bSQ6oKK3qVaT6UnQbarhtoI3xzw6AG/oDl8QbCq+dBDFtn5fvxqDxCUrNqTPfMwwpHK//ViGsVoRb6OLnsxkeF35qbhXBpQvqL/gmdG+fZ1EZPpyxWfaqI6WXFq5Q1RnrfXQ0a0DnUOF+lqelpt7e1rXGsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944200; c=relaxed/simple;
	bh=YxlY/5vmchojqmYmI/UkPqyBxkv4Q9GjltHt9CgCY+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdarhotFGWyd6OjDFJpkptxjBFWP/DNLgapaafR1xg0xRVj22dyf3531KD83o4CmcqNtowRGJ6xYRTgZL4xe2s3RaDKXepu+pu8NIx5NtY/mCRRnLTjYznKS7RBXNo+kfrBWdbGUSCCzLrrfRGXgqW3voTOeCh+NRS352QV5DI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm5oTbgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D36C4CEE4;
	Thu, 22 May 2025 20:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747944199;
	bh=YxlY/5vmchojqmYmI/UkPqyBxkv4Q9GjltHt9CgCY+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cm5oTbgoX9G3PI0Dng+QNeGjWfGhY2GE+s/7Aw1AP+3JB55owRe7w0lBXbHpVr6X/
	 p9Jp3/UqdtFGAHDw7KZ/MCdaARlN2W3UaNj9Xxgkx55XN0DBn685S5H0vMLHH4cRrH
	 qcbCjvnKZBe3E6wanJlMY8AdAbunEK1iyIqPvcLvXh1zUA8ij9ANSb2fcMIRgylhg2
	 QRqvJRioRPjY3c13ljIeAUXQNkyUE2wMqUa5mUxByxMbTQE9ySPAgP90akpMDmdeqj
	 jwjaOH6g/5EP3y7tsf06HRqjXvFGMn26fgkiPkDI41QIxsKu6v8AUEZQn1Y7pL0Qxy
	 CXbBmfebqYBHw==
Date: Thu, 22 May 2025 21:03:14 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net Patchv2] octeontx2-pf: QOS: Refactor TC_HTB_LEAF_DEL_LAST
 callback
Message-ID: <20250522200314.GN365796@horms.kernel.org>
References: <20250522115842.1499666-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522115842.1499666-1-hkelam@marvell.com>

On Thu, May 22, 2025 at 05:28:42PM +0530, Hariprasad Kelam wrote:
> This patch addresses below issues,
> 
> 1. Active traffic on the leaf node must be stopped before its send queue
>    is reassigned to the parent. This patch resolves the issue by marking
>    the node as 'Inner'.
> 
> 2. During a system reboot, the interface receives TC_HTB_LEAF_DEL
>    and TC_HTB_LEAF_DEL_LAST callbacks to delete its HTB queues.
>    In the case of TC_HTB_LEAF_DEL_LAST, although the same send queue
>    is reassigned to the parent, the current logic still attempts to update
>    the real number of queues, leadning to below warnings
> 
>         New queues can't be registered after device unregistration.
>         WARNING: CPU: 0 PID: 6475 at net/core/net-sysfs.c:1714
>         netdev_queue_update_kobjects+0x1e4/0x200
> 
> Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
> v2* update the commit description about making qid as inner.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


