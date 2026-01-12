Return-Path: <netdev+bounces-249154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D36D1523D
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC276301FFA1
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C28326D70;
	Mon, 12 Jan 2026 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3R2WIdn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4294C2E7BDC
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768247821; cv=none; b=dJPHfeRwBuf5xI73wrP3TOXk5kiKflpcLjbxiFZzHMZLqokJpifvZCzrRhWEC5/z2bfiTI0ti5AW7J5vPsdgzsb+VWBx+CK+VDMNfQbyD0USlMLoocOaGOc7qErQgNuZDmzWdX4XoU1VqHI86SbQtv5LkRFLs4gI9MeNTuGC1sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768247821; c=relaxed/simple;
	bh=0yCOuioX75RQ+Gxfx5r4CsOScqkvw4/an+GSg1fvfP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjyM6wQPCX5OWZfEEnadmS8lZnLE4j5JN2MpOS03YjRoi9LSSM1vvB0XiXj9GIhNxkWyrAs+JMZF57xzHEZEMx4/A9c0yjxcikKrWqHceX6yGTIUhXDoEhiXm7e8/N0Rcl/uNNDWB8haYuCUa0XojUOxy5OTtoQpQUPI6vIAS5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3R2WIdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E00C116D0;
	Mon, 12 Jan 2026 19:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768247821;
	bh=0yCOuioX75RQ+Gxfx5r4CsOScqkvw4/an+GSg1fvfP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K3R2WIdnh18bUeTxf8yl23WCygXDVdzR3pI3RWY9uW1QtuqfnsY7bCSalGsmvnuj6
	 LazIzJRDkvRS3od9rGDleC+FnMztMMLyDaWSwWSal03kyAKyDQFwkLhiueSlGBVl4M
	 Ct8sMNPauNgMw/fbjHmz2YaLpPCgW8YbvdtE4RHPT90NyjqimkbDP6cn8bP7hv4c5D
	 yvb3xpisrj0zKFrlnk9WVFwY/69p8E3hloulrmyO+QGEhlLU+m2vhHuu/Lm4k8HcNf
	 CKa9O0tMRQz2/ek57i6EqCgCuT+uo0Xll8kmFHeyG0SCWP09K9DsLb0zNipb3FgqLE
	 m3LBffcBdc5bg==
Date: Mon, 12 Jan 2026 19:56:56 +0000
From: Simon Horman <horms@kernel.org>
To: Kery Qi <qikeyu2017@gmail.com>
Cc: vburru@marvell.com, netdev@vger.kernel.org, srasheed@marvell.com,
	pabeni@redhat.com, sedara@marvell.com, andrew+netdev@lunn.ch,
	sburla@marvell.com, kuba@kernel.org, edumazet@google.com
Subject: Re: [PATCH] net: octeon_ep_vf: fix free_irq dev_id mismatch in IRQ
 rollback
Message-ID: <aWVSCMuX04gdLPL-@horms.kernel.org>
References: <20260108164256.1749-2-qikeyu2017@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108164256.1749-2-qikeyu2017@gmail.com>

+ Maintainers

On Fri, Jan 09, 2026 at 12:42:57AM +0800, Kery Qi wrote:
> octep_vf_request_irqs() requests MSI-X queue IRQs with dev_id set to
> ioq_vector. If request_irq() fails part-way, the rollback loop calls
> free_irq() with dev_id set to 'oct', which does not match the original
> dev_id and may leave the irqaction registered.
> 
> This can keep IRQ handlers alive while ioq_vector is later freed during
> unwind/teardown, leading to a use-after-free or crash when an interrupt
> fires.
> 
> Fix the error path to free IRQs with the same ioq_vector dev_id used
> during request_irq().
> 
> Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
> Signed-off-by: Kery Qi <qikeyu2017@gmail.com>

Thanks, I agree with your analysis; that the problem was introduced
by the cited commit; and the proposed fixes.

Reviewed-by: Simon Horman <horms@kernel.org>

Some notes on procedure For reference, if you post more networking fixes,
or need to spin this patch for some reason.

1. As a bug fix for code present in the net tree it should be
   targeted at that tree.

   Subject: [PATCH net] ...

2. Please include all maintainers and the patch author of the author commit.
   "./scripts/get_maintainer.pl this.patch" can with that.

3. For bug fixes, please consider the guidelines for stable submissions.
   I.e. CC; stable@vger.kernel.org

See also: https://docs.kernel.org/process/maintainer-netdev.html

